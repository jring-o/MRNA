-- ==========================================
-- RPC function to get all admin users
-- ==========================================

CREATE OR REPLACE FUNCTION public.get_admin_users()
RETURNS TABLE (
  id UUID,
  name TEXT,
  email TEXT,
  profile_image_url TEXT,
  created_at TIMESTAMPTZ
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Only allow admins to call this function
  IF NOT public.is_admin() THEN
    RAISE EXCEPTION 'Access denied. Admin role required.';
  END IF;

  RETURN QUERY
  SELECT
    u.id,
    u.name,
    u.email,
    u.profile_image_url,
    u.created_at
  FROM public.users u
  JOIN auth.users au ON u.id = au.id
  WHERE au.raw_app_meta_data->>'role' = 'admin'
  ORDER BY u.name;
END;
$$;

-- Grant execute permission to authenticated users (RLS will handle access control)
GRANT EXECUTE ON FUNCTION public.get_admin_users TO authenticated;

-- ==========================================
-- Function to get voting statistics
-- ==========================================

CREATE OR REPLACE FUNCTION public.get_voting_statistics()
RETURNS TABLE (
  total_applications INTEGER,
  pending_votes INTEGER,
  completed_votes INTEGER,
  auto_approved INTEGER,
  auto_rejected INTEGER,
  average_votes_per_application NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Only allow admins to call this function
  IF NOT public.is_admin() THEN
    RAISE EXCEPTION 'Access denied. Admin role required.';
  END IF;

  RETURN QUERY
  SELECT
    COUNT(*)::INTEGER as total_applications,
    COUNT(*) FILTER (WHERE voting_completed = false)::INTEGER as pending_votes,
    COUNT(*) FILTER (WHERE voting_completed = true)::INTEGER as completed_votes,
    COUNT(*) FILTER (WHERE voting_completed = true AND status = 'accepted')::INTEGER as auto_approved,
    COUNT(*) FILTER (WHERE voting_completed = true AND status = 'rejected')::INTEGER as auto_rejected,
    ROUND(AVG(total_votes), 2) as average_votes_per_application
  FROM public.applications;
END;
$$;

-- Grant execute permission
GRANT EXECUTE ON FUNCTION public.get_voting_statistics TO authenticated;