-- ==========================================
-- Security Hardening for Admin Views
-- ==========================================
-- This migration explicitly sets SECURITY INVOKER on views and
-- ensures proper ownership to prevent RLS bypass issues.
-- ==========================================

-- Recreate the admin_todos_with_users view with explicit SECURITY INVOKER
-- This ensures RLS policies on underlying tables are always enforced
DROP VIEW IF EXISTS public.admin_todos_with_users;

CREATE VIEW public.admin_todos_with_users
WITH (security_invoker = true)
AS
SELECT
  t.*,
  creator.name as creator_name,
  creator.email as creator_email,
  assignee.name as assignee_name,
  assignee.email as assignee_email,
  completer.name as completer_name,
  (
    SELECT COUNT(*)
    FROM public.admin_todo_comments
    WHERE todo_id = t.id
  ) as comment_count
FROM public.admin_todos t
LEFT JOIN public.users creator ON t.created_by = creator.id
LEFT JOIN public.users assignee ON t.assigned_to = assignee.id
LEFT JOIN public.users completer ON t.completed_by = completer.id;

-- Secure the grants: only authenticated users can query
-- (RLS on admin_todos will filter to admins only)
REVOKE ALL ON public.admin_todos_with_users FROM PUBLIC;
GRANT SELECT ON public.admin_todos_with_users TO authenticated;

-- Add a comment documenting the security model
COMMENT ON VIEW public.admin_todos_with_users IS
'View for admin todos with user details. Security: Uses SECURITY INVOKER so RLS on admin_todos (admin-only) is enforced. Non-admins will receive zero rows.';

-- ==========================================
-- Also secure application_voting_summary view
-- ==========================================
DROP VIEW IF EXISTS public.application_voting_summary;

CREATE VIEW public.application_voting_summary
WITH (security_invoker = true)
AS
SELECT
  a.id,
  a.name,
  a.email,
  a.status,
  a.total_votes,
  a.approve_votes,
  a.reject_votes,
  a.abstain_votes,
  a.voting_completed,
  CASE
    WHEN a.total_votes > 0 THEN ROUND((a.approve_votes::DECIMAL / a.total_votes) * 100, 1)
    ELSE 0
  END as approval_percentage,
  CASE
    WHEN a.total_votes > 0 THEN ROUND((a.reject_votes::DECIMAL / a.total_votes) * 100, 1)
    ELSE 0
  END as rejection_percentage,
  COALESCE(
    array_agg(
      jsonb_build_object(
        'admin_id', v.admin_id,
        'admin_name', u.name,
        'vote', v.vote,
        'voted_at', v.created_at
      ) ORDER BY v.created_at
    ) FILTER (WHERE v.id IS NOT NULL),
    ARRAY[]::jsonb[]
  ) as votes
FROM public.applications a
LEFT JOIN public.application_votes v ON a.id = v.application_id
LEFT JOIN public.users u ON v.admin_id = u.id
GROUP BY
  a.id, a.name, a.email, a.status, a.total_votes,
  a.approve_votes, a.reject_votes, a.abstain_votes, a.voting_completed;

REVOKE ALL ON public.application_voting_summary FROM PUBLIC;
GRANT SELECT ON public.application_voting_summary TO authenticated;

COMMENT ON VIEW public.application_voting_summary IS
'Voting summary for applications. Security: Uses SECURITY INVOKER so RLS on applications/votes tables is enforced.';
