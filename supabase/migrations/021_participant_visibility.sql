-- ==========================================
-- 1. Enable participant-to-participant visibility (users table only)
-- 2. Fix critical applications RLS vulnerability
-- 3. Fix comments table overly broad SELECT
-- 4. Fix daily_reflections overly broad SELECT
-- 5. Fix invite_tokens missing public. prefix on is_admin()
-- 6. Fix case-sensitive email matching in auto_link_application_on_signup trigger
-- ==========================================

-- ==========================================
-- USERS TABLE
-- ==========================================
-- Participants can see other participants in the directory.
-- (Restores the policy dropped in migration 009)
CREATE POLICY "participants_view_other_participants" ON public.users
  FOR SELECT
  TO authenticated
  USING (
    public.auth_role() IN ('participant', 'admin')
    AND id IN (
      SELECT au.id FROM auth.users au
      WHERE au.raw_app_meta_data->>'role' = 'participant'
    )
  );

-- ==========================================
-- APPLICATIONS TABLE
-- ==========================================
-- Migration 004 created "Users can view own applications by email or user_id"
-- with the condition: email IS NOT NULL
-- This is ALWAYS true, meaning ANY authenticated user can read ALL applications.
-- Fix: restrict to own application or admin only.

DROP POLICY IF EXISTS "Users can view own applications by email or user_id" ON public.applications;

CREATE POLICY "Users can view own applications" ON public.applications
  FOR SELECT
  TO authenticated
  USING (
    public.is_admin() OR
    (user_id IS NOT NULL AND user_id = (SELECT auth.uid()))
  );

-- ==========================================
-- COMMENTS TABLE
-- ==========================================
-- Migration 002 created "Authenticated can view comments" with USING (true),
-- allowing any authenticated user (including applicants) to read all comments.
-- Fix: restrict to participants and admins only.

DROP POLICY IF EXISTS "Authenticated can view comments" ON public.comments;

CREATE POLICY "Participants and admins can view comments" ON public.comments
  FOR SELECT
  TO authenticated
  USING (
    public.auth_role() IN ('participant', 'admin')
  );

-- Also restrict comment creation to participants and admins
DROP POLICY IF EXISTS "Authenticated can create comments" ON public.comments;

CREATE POLICY "Participants and admins can create comments" ON public.comments
  FOR INSERT
  TO authenticated
  WITH CHECK (
    user_id = (SELECT auth.uid()) AND
    public.auth_role() IN ('participant', 'admin')
  );

-- ==========================================
-- DAILY REFLECTIONS TABLE
-- ==========================================
-- Unused table — no application code references it. Drop it entirely.

DROP TABLE IF EXISTS public.daily_reflections;
DROP TYPE IF EXISTS public.reflection_type;

-- ==========================================
-- INVITE TOKENS TABLE
-- ==========================================
-- Migration 011 used is_admin() without the public. schema prefix.
-- Depending on search_path, this may silently fail and block all access.
-- Fix: drop and recreate with public.is_admin().

DROP POLICY IF EXISTS "Admins can view all invite tokens" ON public.invite_tokens;
DROP POLICY IF EXISTS "Admins can create invite tokens" ON public.invite_tokens;
DROP POLICY IF EXISTS "Admins can update invite tokens" ON public.invite_tokens;

CREATE POLICY "Admins can view all invite tokens" ON public.invite_tokens
  FOR SELECT
  TO authenticated
  USING (public.is_admin());

CREATE POLICY "Admins can create invite tokens" ON public.invite_tokens
  FOR INSERT
  TO authenticated
  WITH CHECK (public.is_admin());

CREATE POLICY "Admins can update invite tokens" ON public.invite_tokens
  FOR UPDATE
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- ==========================================
-- AUTO-LINK TRIGGER
-- ==========================================
-- Migration 004 created auto_link_application_on_signup() with case-sensitive
-- email matching (WHERE email = NEW.email). This silently fails when casing
-- differs (e.g. "Ellie@scios.tech" vs "ellie@scios.tech").
-- Fix: use LOWER() for case-insensitive matching.

CREATE OR REPLACE FUNCTION public.auto_link_application_on_signup()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  IF NEW.email IS NOT NULL THEN
    UPDATE public.applications
    SET user_id = NEW.id,
        updated_at = NOW()
    WHERE LOWER(email) = LOWER(NEW.email)
      AND user_id IS NULL;
  END IF;

  RETURN NEW;
END;
$$;
