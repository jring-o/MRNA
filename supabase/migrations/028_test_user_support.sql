-- ==========================================
-- Test user support
--
-- Adds an is_test_user flag to public.users so test accounts
-- can have full participant permissions while being invisible
-- to other participants.  Admins still see everything.
-- ==========================================

-- 1. Add the column
ALTER TABLE public.users
  ADD COLUMN IF NOT EXISTS is_test_user BOOLEAN NOT NULL DEFAULT FALSE;

-- 2. Update participants_view_other_participants on public.users
--    Other participants cannot see test-user rows (except their own).
--    Admins are unaffected — they match admins_all_access instead.
DROP POLICY IF EXISTS "participants_view_other_participants" ON public.users;

CREATE POLICY "participants_view_other_participants" ON public.users
  FOR SELECT
  TO authenticated
  USING (
    public.auth_role() IN ('participant', 'admin')
    AND (
      is_test_user IS NOT TRUE          -- normal rows are always visible
      OR id = (SELECT auth.uid())       -- test user can see their own row
    )
  );

-- 3. Update participant_profiles RLS (defense in depth)
--    Hide test-user profiles from other participants.
DROP POLICY IF EXISTS "participants_and_admins_select_profiles" ON public.participant_profiles;

CREATE POLICY "participants_and_admins_select_profiles" ON public.participant_profiles
  FOR SELECT
  TO authenticated
  USING (
    public.auth_role() IN ('participant', 'admin')
    AND (
      NOT EXISTS (
        SELECT 1 FROM public.users u
        WHERE u.id = participant_profiles.user_id
          AND u.is_test_user IS TRUE
      )
      OR user_id = (SELECT auth.uid())   -- test user can see own profile
    )
  );

-- 4. Update get_participant_emails() to exclude test users
--    This RPC is SECURITY DEFINER (bypasses RLS), so we filter explicitly.
DROP FUNCTION IF EXISTS public.get_participant_emails();

CREATE OR REPLACE FUNCTION public.get_participant_emails()
RETURNS TABLE (
  user_id UUID,
  email TEXT,
  name TEXT,
  role TEXT
)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT u.id AS user_id, u.email, u.name,
         au.raw_app_meta_data->>'role' AS role
  FROM public.users u
  INNER JOIN auth.users au ON u.id = au.id
  WHERE au.raw_app_meta_data->>'role' IN ('participant', 'admin')
    AND u.is_test_user IS NOT TRUE;
$$;
