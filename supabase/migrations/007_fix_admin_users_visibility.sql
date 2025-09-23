-- ==========================================
-- Fix admin visibility of users for comments system
-- ==========================================
--
-- Problem: When admins view application comments, the query joins with the users table
-- to get author information (name, email, profile_image_url). The current RLS policies
-- are too restrictive and don't allow admins to view other users' information.
--
-- Solution: Since only admins can view/create comments anyway, we need to ensure
-- admins can view ALL users in the system (including other admins).
-- ==========================================

-- The existing policy "Admins can view all users" should already handle this,
-- but let's make sure it exists and is correct
DROP POLICY IF EXISTS "Admins can view all users" ON public.users;

-- Admins should be able to view ALL users (including other admins)
-- This is needed for the comments system where we join application_comments with users
CREATE POLICY "Admins can view all users" ON public.users
  FOR SELECT
  TO authenticated
  USING (public.is_admin());

-- Also ensure the application_comments policies are correctly set for admin-only access
-- (These should already exist from migration 005, but let's ensure they're correct)

-- Verify that only admins can view comments
DROP POLICY IF EXISTS "Admins can view comments" ON public.application_comments;
CREATE POLICY "Admins can view all comments" ON public.application_comments
  FOR SELECT
  TO authenticated
  USING (public.is_admin());

-- Verify that only admins can create comments
DROP POLICY IF EXISTS "Admins can create comments" ON public.application_comments;
CREATE POLICY "Admins can create comments" ON public.application_comments
  FOR INSERT
  TO authenticated
  WITH CHECK (
    public.is_admin() AND
    author_id = (SELECT auth.uid())
  );

-- Keep the existing update/delete policies as they are
-- (Authors can update their own recent comments, soft-delete their own comments)