-- ==========================================
-- Security hardening
--
-- 1. Revoke overly broad function grants from anon
-- 2. Add role guard to get_participant_emails()
-- 3. Restrict link_application_to_user() to the user's own account
-- 4. Restrict validate_invite_token() to authenticated only
-- ==========================================

-- 1. Revoke EXECUTE on all public functions from anon.
--    Individual functions that genuinely need anon access
--    (like check_invite_token for signup) are re-granted below.
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA public FROM anon;

-- Re-grant anon access only to functions needed during signup
GRANT EXECUTE ON FUNCTION public.check_invite_token(VARCHAR, VARCHAR) TO anon;

-- 2. Recreate get_participant_emails() with an admin/participant guard
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
      AND u.is_test_user IS NOT TRUE;
END;
$$;

-- 3. Recreate link_application_to_user() with ownership check
--    Only allows linking an application to the caller's own user ID
DROP FUNCTION IF EXISTS public.link_application_to_user(TEXT, UUID);

CREATE OR REPLACE FUNCTION public.link_application_to_user(
  p_email TEXT,
  p_user_id UUID
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  -- Only allow linking to your own account
  IF p_user_id != (SELECT auth.uid()) THEN
    RAISE EXCEPTION 'You can only link applications to your own account';
  END IF;

  UPDATE public.applications
  SET user_id = p_user_id
  WHERE email = p_email
    AND user_id IS NULL;
END;
$$;

-- 4. Revoke anon from validate_invite_token (legacy function)
--    The signup flow now uses check_invite_token + mark_invite_token_used
REVOKE EXECUTE ON FUNCTION public.validate_invite_token(VARCHAR, VARCHAR) FROM anon;
