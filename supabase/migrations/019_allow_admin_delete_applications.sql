-- Allow admins to delete applications
-- This enables super admins to remove applications from the database

CREATE POLICY "Admins can delete applications" ON public.applications
  FOR DELETE TO authenticated
  USING (public.is_admin());
