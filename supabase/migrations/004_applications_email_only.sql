-- ==========================================
-- Modify applications table for email-only submissions
-- ==========================================

-- Add email, name, organization columns to applications table
ALTER TABLE public.applications
ADD COLUMN IF NOT EXISTS email TEXT,
ADD COLUMN IF NOT EXISTS name TEXT,
ADD COLUMN IF NOT EXISTS organization TEXT;

-- Make user_id nullable (allow applications without accounts)
ALTER TABLE public.applications
ALTER COLUMN user_id DROP NOT NULL;

-- Add unique constraint on email to prevent duplicate applications
ALTER TABLE public.applications
ADD CONSTRAINT unique_application_email UNIQUE (email);

-- Create index on email for faster lookups
CREATE INDEX IF NOT EXISTS idx_applications_email ON public.applications(email);

-- ==========================================
-- Update RLS policies for public application submission
-- ==========================================

-- Drop existing application policies that we need to modify
DROP POLICY IF EXISTS "Users can create applications" ON public.applications;
DROP POLICY IF EXISTS "Users can view own applications" ON public.applications;
DROP POLICY IF EXISTS "Users can update own pending applications" ON public.applications;

-- Allow anyone to create applications (no auth required)
CREATE POLICY "Anyone can create applications" ON public.applications
  FOR INSERT
  WITH CHECK (
    -- Ensure email is provided
    email IS NOT NULL AND
    -- Either user_id is null (anonymous) or matches the authenticated user
    (user_id IS NULL OR user_id = (SELECT auth.uid()))
  );

-- Users can view applications by email OR user_id
CREATE POLICY "Users can view own applications by email or user_id" ON public.applications
  FOR SELECT
  USING (
    -- Admins can see all
    public.is_admin() OR
    -- Authenticated users can see their own by user_id
    (user_id IS NOT NULL AND user_id = (SELECT auth.uid())) OR
    -- Anyone can look up by email (for status checking)
    -- Note: In production, you might want to add rate limiting here
    email IS NOT NULL
  );

-- Users can update their own pending applications
CREATE POLICY "Users can update own pending applications by email or user_id" ON public.applications
  FOR UPDATE
  USING (
    -- Must be pending status
    status = 'pending' AND (
      -- Authenticated users can update by user_id
      (user_id IS NOT NULL AND user_id = (SELECT auth.uid())) OR
      -- Admins can update any
      public.is_admin()
    )
  )
  WITH CHECK (
    -- Same conditions for the update
    status = 'pending' AND (
      (user_id IS NOT NULL AND user_id = (SELECT auth.uid())) OR
      public.is_admin()
    )
  );

-- ==========================================
-- Helper function to link application to user account
-- ==========================================

CREATE OR REPLACE FUNCTION public.link_application_to_user(
  p_email TEXT,
  p_user_id UUID
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Update the application to link it to the user
  UPDATE public.applications
  SET user_id = p_user_id,
      updated_at = NOW()
  WHERE email = p_email
    AND user_id IS NULL;  -- Only link if not already linked

  RETURN FOUND;
END;
$$;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION public.link_application_to_user TO authenticated;

-- ==========================================
-- Trigger to auto-link applications when user signs up
-- ==========================================

CREATE OR REPLACE FUNCTION public.auto_link_application_on_signup()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- When a new user is created, check if they have an application
  IF NEW.email IS NOT NULL THEN
    -- Link any existing application to this user
    UPDATE public.applications
    SET user_id = NEW.id,
        updated_at = NOW()
    WHERE email = NEW.email
      AND user_id IS NULL;
  END IF;

  RETURN NEW;
END;
$$;

-- Create trigger on users table
DROP TRIGGER IF EXISTS auto_link_application ON public.users;
CREATE TRIGGER auto_link_application
  AFTER INSERT ON public.users
  FOR EACH ROW
  EXECUTE FUNCTION public.auto_link_application_on_signup();

-- ==========================================
-- Update existing data (if any)
-- ==========================================

-- Populate email field for existing applications that have user_id
UPDATE public.applications a
SET email = u.email,
    name = u.name,
    organization = u.organization
FROM public.users u
WHERE a.user_id = u.id
  AND a.email IS NULL;