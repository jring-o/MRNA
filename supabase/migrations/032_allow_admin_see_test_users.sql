-- ==========================================
-- Allow admins to see test users in get_participant_emails()
--
-- Previously test users were excluded for all callers.
-- Now admins can see (and message) test users, while
-- participants still cannot.
-- ==========================================

DROP FUNCTION IF EXISTS public.get_participant_emails();

CREATE OR REPLACE FUNCTION public.get_participant_emails()
RETURNS TABLE (
  user_id UUID,
  email TEXT,
  name TEXT,
  role TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF public.auth_role() NOT IN ('admin', 'participant') THEN
    RAISE EXCEPTION 'Access denied';
  END IF;

  RETURN QUERY
    SELECT u.id AS user_id, u.email, u.name,
           au.raw_app_meta_data->>'role' AS role
    FROM public.users u
    INNER JOIN auth.users au ON u.id = au.id
    WHERE au.raw_app_meta_data->>'role' IN ('participant', 'admin')
      AND (public.is_admin() OR u.is_test_user IS NOT TRUE);
END;
$$;
