-- ==========================================
-- Fix: messages_with_details view bypasses RLS
--
-- The view was created without SECURITY INVOKER,
-- so it runs with the view owner's privileges and
-- ignores RLS on public.messages.  This means any
-- authenticated user can see all messages, not just
-- the ones addressed to them.
--
-- Recreate with security_invoker = true so that
-- the "Users can view their messages" RLS policy
-- on public.messages is enforced per-caller.
-- ==========================================

CREATE OR REPLACE VIEW public.messages_with_details
WITH (security_invoker = true)
AS
SELECT
  m.*,
  author.name  AS author_name,
  author.email AS author_email,
  (
    SELECT COUNT(*)
    FROM public.message_comments
    WHERE message_id = m.id
  ) AS comment_count,
  (
    SELECT COUNT(*)
    FROM public.message_reactions
    WHERE message_id = m.id
  ) AS reaction_count
FROM public.messages m
LEFT JOIN public.users author ON m.author_id = author.id;
