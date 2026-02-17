-- Update get_participant_emails to also return user role
-- Must drop first because return type changed (Postgres requirement)
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
  SELECT u.id as user_id, u.email, u.name,
         au.raw_app_meta_data->>'role' as role
  FROM public.users u
  INNER JOIN auth.users au ON u.id = au.id
  WHERE au.raw_app_meta_data->>'role' IN ('participant', 'admin');
$$;
