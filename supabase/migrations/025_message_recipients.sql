-- ==========================================
-- Message Recipients (per-recipient visibility)
-- ==========================================
-- Junction table tracking which users a message was sent to.
-- Admins always see everything; participants will only see
-- messages addressed to them once the page is unlocked.
-- ==========================================

-- ==========================================
-- 1. Junction table
-- ==========================================
CREATE TABLE public.message_recipients (
  message_id UUID NOT NULL REFERENCES public.messages(id) ON DELETE CASCADE,
  user_id    UUID NOT NULL REFERENCES public.users(id)    ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (message_id, user_id)
);

CREATE INDEX idx_message_recipients_user_id    ON public.message_recipients(user_id);
CREATE INDEX idx_message_recipients_message_id ON public.message_recipients(message_id);

ALTER TABLE public.message_recipients ENABLE ROW LEVEL SECURITY;

-- Admins see all recipient rows
CREATE POLICY "Admins can view all message recipients" ON public.message_recipients
  FOR SELECT TO authenticated
  USING (public.is_admin());

-- Users can see their own recipient rows
CREATE POLICY "Users can view own message recipients" ON public.message_recipients
  FOR SELECT TO authenticated
  USING (user_id = (SELECT auth.uid()));

-- Admins can insert recipient rows
CREATE POLICY "Admins can insert message recipients" ON public.message_recipients
  FOR INSERT TO authenticated
  WITH CHECK (public.is_admin());

-- ==========================================
-- 2. Helper: can_see_message(UUID)
-- ==========================================
-- SECURITY DEFINER so it bypasses RLS on message_recipients
-- (avoids nested-RLS issues, same pattern as migration 023).
CREATE OR REPLACE FUNCTION public.can_see_message(p_message_id UUID)
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT
    public.is_admin()
    OR EXISTS (
      SELECT 1
      FROM public.message_recipients mr
      WHERE mr.message_id = p_message_id
        AND mr.user_id = (SELECT auth.uid())
    );
$$;

-- ==========================================
-- 3. Rewrite messages RLS
-- ==========================================
DROP POLICY IF EXISTS "Admins can view all messages"   ON public.messages;
DROP POLICY IF EXISTS "Admins can create messages"     ON public.messages;
DROP POLICY IF EXISTS "Admins can update own messages"  ON public.messages;
DROP POLICY IF EXISTS "Admins can delete messages"      ON public.messages;

-- SELECT: admins see all; participants see only messages addressed to them
CREATE POLICY "Users can view their messages" ON public.messages
  FOR SELECT TO authenticated
  USING (
    public.is_admin()
    OR EXISTS (
      SELECT 1 FROM public.message_recipients mr
      WHERE mr.message_id = id
        AND mr.user_id = (SELECT auth.uid())
    )
  );

-- INSERT: admin-only (must be author)
CREATE POLICY "Admins can create messages" ON public.messages
  FOR INSERT TO authenticated
  WITH CHECK (
    public.is_admin()
    AND author_id = (SELECT auth.uid())
  );

-- UPDATE: admin-only (own messages)
CREATE POLICY "Admins can update own messages" ON public.messages
  FOR UPDATE TO authenticated
  USING (
    public.is_admin()
    AND author_id = (SELECT auth.uid())
  )
  WITH CHECK (
    public.is_admin()
    AND author_id = (SELECT auth.uid())
  );

-- DELETE: admin-only
CREATE POLICY "Admins can delete messages" ON public.messages
  FOR DELETE TO authenticated
  USING (public.is_admin());

-- ==========================================
-- 4. Rewrite message_reactions RLS
-- ==========================================
DROP POLICY IF EXISTS "Admins can view all reactions" ON public.message_reactions;
DROP POLICY IF EXISTS "Admins can add own reactions"  ON public.message_reactions;
DROP POLICY IF EXISTS "Admins can remove own reactions" ON public.message_reactions;

-- SELECT: anyone who can see the message can see its reactions
CREATE POLICY "Users can view reactions on visible messages" ON public.message_reactions
  FOR SELECT TO authenticated
  USING (public.can_see_message(message_id));

-- INSERT: own reaction, must be able to see the message
CREATE POLICY "Users can add own reactions" ON public.message_reactions
  FOR INSERT TO authenticated
  WITH CHECK (
    user_id = (SELECT auth.uid())
    AND public.can_see_message(message_id)
  );

-- DELETE: own reaction, must be able to see the message
CREATE POLICY "Users can remove own reactions" ON public.message_reactions
  FOR DELETE TO authenticated
  USING (
    user_id = (SELECT auth.uid())
    AND public.can_see_message(message_id)
  );

-- ==========================================
-- 5. Rewrite message_comments RLS
-- ==========================================
DROP POLICY IF EXISTS "Admins can view message comments"              ON public.message_comments;
DROP POLICY IF EXISTS "Admins can create message comments"            ON public.message_comments;
DROP POLICY IF EXISTS "Authors can update own recent message comments" ON public.message_comments;
DROP POLICY IF EXISTS "Authors can delete own message comments"       ON public.message_comments;

-- SELECT: anyone who can see the message
CREATE POLICY "Users can view comments on visible messages" ON public.message_comments
  FOR SELECT TO authenticated
  USING (public.can_see_message(message_id));

-- INSERT: own comment, must be able to see the message
CREATE POLICY "Users can create comments on visible messages" ON public.message_comments
  FOR INSERT TO authenticated
  WITH CHECK (
    author_id = (SELECT auth.uid())
    AND public.can_see_message(message_id)
  );

-- UPDATE: own comment, within 15 min, must be able to see the message
CREATE POLICY "Authors can update own recent comments" ON public.message_comments
  FOR UPDATE TO authenticated
  USING (
    author_id = (SELECT auth.uid())
    AND created_at > NOW() - INTERVAL '15 minutes'
    AND public.can_see_message(message_id)
  )
  WITH CHECK (
    author_id = (SELECT auth.uid())
    AND public.can_see_message(message_id)
  );

-- DELETE: own comment, must be able to see the message
CREATE POLICY "Authors can delete own comments" ON public.message_comments
  FOR DELETE TO authenticated
  USING (
    author_id = (SELECT auth.uid())
    AND public.can_see_message(message_id)
  );

-- ==========================================
-- 6. Recreate messages_with_details view
-- ==========================================
CREATE OR REPLACE VIEW public.messages_with_details AS
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

GRANT SELECT ON public.messages_with_details TO authenticated;
