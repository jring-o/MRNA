-- ==========================================
-- Messages System
-- ==========================================
-- Admins can broadcast rich-text messages to all participants via email.
-- Messages can be read, reacted to, and commented on.
-- RLS policies currently restrict to admins only; comments indicate
-- how to expand to participants later.
-- ==========================================

-- Create reaction type enum
CREATE TYPE message_reaction_type AS ENUM (
  'thumbs_up', 'heart', 'party', 'rocket', 'eyes', 'thumbs_down'
);

-- ==========================================
-- Messages table
-- ==========================================
CREATE TABLE public.messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  subject TEXT NOT NULL,
  content TEXT NOT NULL,          -- Tiptap HTML
  content_plain TEXT,             -- Plain text fallback
  author_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  email_sent BOOLEAN DEFAULT FALSE,
  email_sent_at TIMESTAMPTZ,
  email_recipient_count INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for performance
CREATE INDEX idx_messages_author_id ON public.messages(author_id);
CREATE INDEX idx_messages_created_at ON public.messages(created_at DESC);

-- ==========================================
-- Message reactions table
-- ==========================================
CREATE TABLE public.message_reactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  message_id UUID NOT NULL REFERENCES public.messages(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  reaction message_reaction_type NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(message_id, user_id, reaction)
);

-- Create indexes for performance
CREATE INDEX idx_message_reactions_message_id ON public.message_reactions(message_id);
CREATE INDEX idx_message_reactions_user_id ON public.message_reactions(user_id);

-- ==========================================
-- Message comments table (flat, no threading)
-- ==========================================
CREATE TABLE public.message_comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  message_id UUID NOT NULL REFERENCES public.messages(id) ON DELETE CASCADE,
  author_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  edited_at TIMESTAMPTZ
);

-- Create indexes for performance
CREATE INDEX idx_message_comments_message_id ON public.message_comments(message_id);
CREATE INDEX idx_message_comments_author_id ON public.message_comments(author_id);
CREATE INDEX idx_message_comments_created_at ON public.message_comments(created_at DESC);

-- ==========================================
-- Update trigger for messages
-- ==========================================
CREATE TRIGGER update_messages_updated_at
  BEFORE UPDATE ON public.messages
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ==========================================
-- RLS Policies for Messages
-- ==========================================
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

-- Admins can view all messages
-- To expand: USING (public.auth_role() IN ('participant', 'admin'))
CREATE POLICY "Admins can view all messages" ON public.messages
  FOR SELECT
  TO authenticated
  USING (public.is_admin());

-- Admins can create messages (must be author)
-- To expand: keep admin-only for INSERT
CREATE POLICY "Admins can create messages" ON public.messages
  FOR INSERT
  TO authenticated
  WITH CHECK (
    public.is_admin() AND
    author_id = (SELECT auth.uid())
  );

-- Admins can update their own messages
-- To expand: keep admin-only for UPDATE
CREATE POLICY "Admins can update own messages" ON public.messages
  FOR UPDATE
  TO authenticated
  USING (
    public.is_admin() AND
    author_id = (SELECT auth.uid())
  )
  WITH CHECK (
    public.is_admin() AND
    author_id = (SELECT auth.uid())
  );

-- Admins can delete messages
-- To expand: keep admin-only for DELETE
CREATE POLICY "Admins can delete messages" ON public.messages
  FOR DELETE
  TO authenticated
  USING (public.is_admin());

-- ==========================================
-- RLS Policies for Message Reactions
-- ==========================================
ALTER TABLE public.message_reactions ENABLE ROW LEVEL SECURITY;

-- Admins can view all reactions
-- To expand: USING (public.auth_role() IN ('participant', 'admin'))
CREATE POLICY "Admins can view all reactions" ON public.message_reactions
  FOR SELECT
  TO authenticated
  USING (public.is_admin());

-- Admins can add their own reactions
-- To expand: WITH CHECK (public.auth_role() IN ('participant', 'admin') AND user_id = (SELECT auth.uid()))
CREATE POLICY "Admins can add own reactions" ON public.message_reactions
  FOR INSERT
  TO authenticated
  WITH CHECK (
    public.is_admin() AND
    user_id = (SELECT auth.uid())
  );

-- Admins can remove their own reactions
-- To expand: USING (public.auth_role() IN ('participant', 'admin') AND user_id = (SELECT auth.uid()))
CREATE POLICY "Admins can remove own reactions" ON public.message_reactions
  FOR DELETE
  TO authenticated
  USING (
    public.is_admin() AND
    user_id = (SELECT auth.uid())
  );

-- ==========================================
-- RLS Policies for Message Comments
-- ==========================================
ALTER TABLE public.message_comments ENABLE ROW LEVEL SECURITY;

-- Admins can view all comments
-- To expand: USING (public.auth_role() IN ('participant', 'admin'))
CREATE POLICY "Admins can view message comments" ON public.message_comments
  FOR SELECT
  TO authenticated
  USING (public.is_admin());

-- Admins can create comments
-- To expand: WITH CHECK (public.auth_role() IN ('participant', 'admin') AND author_id = (SELECT auth.uid()))
CREATE POLICY "Admins can create message comments" ON public.message_comments
  FOR INSERT
  TO authenticated
  WITH CHECK (
    public.is_admin() AND
    author_id = (SELECT auth.uid())
  );

-- Authors can update their own comments within 15 minutes
-- To expand: change is_admin() to auth_role() IN ('participant', 'admin')
CREATE POLICY "Authors can update own recent message comments" ON public.message_comments
  FOR UPDATE
  TO authenticated
  USING (
    public.is_admin() AND
    author_id = (SELECT auth.uid()) AND
    created_at > NOW() - INTERVAL '15 minutes'
  )
  WITH CHECK (
    public.is_admin() AND
    author_id = (SELECT auth.uid())
  );

-- Authors can delete their own comments
-- To expand: change is_admin() to auth_role() IN ('participant', 'admin')
CREATE POLICY "Authors can delete own message comments" ON public.message_comments
  FOR DELETE
  TO authenticated
  USING (
    public.is_admin() AND
    author_id = (SELECT auth.uid())
  );

-- ==========================================
-- View for messages with author info and counts
-- ==========================================
CREATE OR REPLACE VIEW public.messages_with_details AS
SELECT
  m.*,
  author.name as author_name,
  author.email as author_email,
  (
    SELECT COUNT(*)
    FROM public.message_comments
    WHERE message_id = m.id
  ) as comment_count,
  (
    SELECT COUNT(*)
    FROM public.message_reactions
    WHERE message_id = m.id
  ) as reaction_count
FROM public.messages m
LEFT JOIN public.users author ON m.author_id = author.id;

-- Grant access to the view
GRANT SELECT ON public.messages_with_details TO authenticated;

-- ==========================================
-- RPC function to get participant emails
-- ==========================================
CREATE OR REPLACE FUNCTION public.get_participant_emails()
RETURNS TABLE (
  user_id UUID,
  email TEXT,
  name TEXT
)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT u.id as user_id, u.email, u.name
  FROM public.users u
  INNER JOIN auth.users au ON u.id = au.id
  WHERE au.raw_app_meta_data->>'role' IN ('participant', 'admin');
$$;
