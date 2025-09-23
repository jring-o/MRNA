-- ==========================================
-- Force fix RLS policies for users table
-- ==========================================
--
-- The is_admin() function is working (returns true), but the RLS policies
-- on the users table are still blocking access. Let's completely rebuild them.
-- ==========================================

-- First, drop ALL existing policies on users table to start fresh
DO $$
DECLARE
    pol record;
BEGIN
    FOR pol IN SELECT policyname FROM pg_policies WHERE tablename = 'users' AND schemaname = 'public'
    LOOP
        EXECUTE format('DROP POLICY IF EXISTS %I ON public.users', pol.policyname);
    END LOOP;
END $$;

-- Ensure RLS is enabled
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

-- Create a single, simple policy: Admins can do everything with users table
CREATE POLICY "admins_all_access" ON public.users
  FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- Users can view their own profile
CREATE POLICY "users_view_own" ON public.users
  FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

-- Users can update their own profile
CREATE POLICY "users_update_own" ON public.users
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Also ensure application_comments policies are correct
DROP POLICY IF EXISTS "Admins can view all comments" ON public.application_comments;
DROP POLICY IF EXISTS "Admins can view comments" ON public.application_comments;

-- Simplified policy: if you're admin, you can see all comments
CREATE POLICY "admin_view_comments" ON public.application_comments
  FOR SELECT
  TO authenticated
  USING (public.is_admin());

-- Keep other comment policies as they were
-- (create, update, etc.)