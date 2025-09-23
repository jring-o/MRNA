-- ==========================================
-- Fix auth_role() function to properly check JWT structure
-- ==========================================
--
-- Problem: The auth_role() function is not correctly extracting the role
-- from the JWT token's app_metadata structure.
--
-- Solution: Update the function to properly check the JWT structure
-- that Supabase provides, which stores custom claims in app_metadata.
-- ==========================================

-- Drop and recreate the auth_role function with better JWT parsing
CREATE OR REPLACE FUNCTION public.auth_role()
RETURNS TEXT AS $$
DECLARE
  jwt_claims jsonb;
  role_value text;
BEGIN
  -- Get the full JWT claims
  jwt_claims := auth.jwt();

  -- Return null if no JWT (not authenticated)
  IF jwt_claims IS NULL THEN
    RETURN 'applicant';
  END IF;

  -- Try multiple paths where the role might be stored
  -- Supabase stores custom claims in app_metadata
  role_value := COALESCE(
    jwt_claims->'app_metadata'->>'role',     -- Standard location in Supabase
    jwt_claims->'user_metadata'->>'role',    -- Sometimes in user_metadata
    jwt_claims->>'role',                      -- Direct claim (less common)
    'applicant'                               -- Default fallback
  );

  RETURN role_value;
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

-- Also create a debug function to help diagnose JWT issues
CREATE OR REPLACE FUNCTION public.debug_jwt()
RETURNS jsonb AS $$
BEGIN
  RETURN jsonb_build_object(
    'jwt', auth.jwt(),
    'uid', auth.uid(),
    'email', auth.jwt()->>'email',
    'role_from_auth_role', public.auth_role(),
    'is_admin', public.is_admin(),
    'app_metadata', auth.jwt()->'app_metadata',
    'user_metadata', auth.jwt()->'user_metadata'
  );
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

-- Grant execute permissions
GRANT EXECUTE ON FUNCTION public.auth_role() TO authenticated;
GRANT EXECUTE ON FUNCTION public.debug_jwt() TO authenticated;