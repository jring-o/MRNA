-- ==========================================
-- Fix: participants_view_other_participants policy on users table
--
-- The policy from migration 021 subqueries auth.users directly,
-- which the authenticated role cannot access (restricted schema).
-- This causes the entire SELECT to error.
--
-- Fix: simplify the policy. Participants and admins can see all
-- rows in public.users. No need to filter by role at the DB level —
-- the users table already only contains signed-up users, and
-- the app code controls what's displayed.
-- ==========================================

DROP POLICY IF EXISTS "participants_view_other_participants" ON public.users;

CREATE POLICY "participants_view_other_participants" ON public.users
  FOR SELECT
  TO authenticated
  USING (
    public.auth_role() IN ('participant', 'admin')
  );
