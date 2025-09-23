-- ==========================================
-- Multi-Admin Voting System
-- ==========================================

-- Create vote types enum
CREATE TYPE vote_type AS ENUM ('approve', 'reject', 'abstain');

-- Create application_votes table
CREATE TABLE public.application_votes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  application_id UUID NOT NULL REFERENCES public.applications(id) ON DELETE CASCADE,
  admin_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  vote vote_type NOT NULL,
  comment TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(application_id, admin_id)
);

-- Create indexes for performance
CREATE INDEX idx_application_votes_application_id ON public.application_votes(application_id);
CREATE INDEX idx_application_votes_admin_id ON public.application_votes(admin_id);
CREATE INDEX idx_application_votes_vote ON public.application_votes(vote);

-- ==========================================
-- Enhanced Comment System
-- ==========================================

-- Create application_comments table
CREATE TABLE public.application_comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  application_id UUID NOT NULL REFERENCES public.applications(id) ON DELETE CASCADE,
  author_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  parent_id UUID REFERENCES public.application_comments(id) ON DELETE CASCADE,
  is_internal BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  edited_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ, -- Soft delete for audit trail
  CONSTRAINT valid_parent CHECK (parent_id != id)
);

-- Create indexes for performance
CREATE INDEX idx_application_comments_application_id ON public.application_comments(application_id);
CREATE INDEX idx_application_comments_author_id ON public.application_comments(author_id);
CREATE INDEX idx_application_comments_parent_id ON public.application_comments(parent_id);
CREATE INDEX idx_application_comments_created_at ON public.application_comments(created_at DESC);

-- ==========================================
-- Voting Configuration Table
-- ==========================================

CREATE TABLE public.voting_config (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  min_votes_required INTEGER DEFAULT 3,
  approval_threshold DECIMAL(3,2) DEFAULT 0.66, -- 66% approval needed
  auto_approve_enabled BOOLEAN DEFAULT false,
  auto_reject_enabled BOOLEAN DEFAULT false,
  rejection_threshold DECIMAL(3,2) DEFAULT 0.66, -- 66% rejection needed
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Insert default configuration
INSERT INTO public.voting_config (
  min_votes_required,
  approval_threshold,
  auto_approve_enabled,
  auto_reject_enabled,
  rejection_threshold
) VALUES (3, 0.66, false, false, 0.66);

-- ==========================================
-- Add voting summary fields to applications
-- ==========================================

ALTER TABLE public.applications
ADD COLUMN IF NOT EXISTS total_votes INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS approve_votes INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS reject_votes INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS abstain_votes INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS voting_completed BOOLEAN DEFAULT false,
ADD COLUMN IF NOT EXISTS voting_completed_at TIMESTAMPTZ;

-- ==========================================
-- Update triggers
-- ==========================================

-- Trigger for updated_at on votes
CREATE TRIGGER update_application_votes_updated_at
  BEFORE UPDATE ON public.application_votes
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Trigger for updated_at on comments
CREATE TRIGGER update_application_comments_updated_at
  BEFORE UPDATE ON public.application_comments
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Trigger for updated_at on voting_config
CREATE TRIGGER update_voting_config_updated_at
  BEFORE UPDATE ON public.voting_config
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ==========================================
-- Function to update vote counts
-- ==========================================

CREATE OR REPLACE FUNCTION public.update_application_vote_counts()
RETURNS TRIGGER AS $$
BEGIN
  -- Update vote counts on the applications table
  UPDATE public.applications
  SET
    total_votes = (
      SELECT COUNT(*)
      FROM public.application_votes
      WHERE application_id = COALESCE(NEW.application_id, OLD.application_id)
    ),
    approve_votes = (
      SELECT COUNT(*)
      FROM public.application_votes
      WHERE application_id = COALESCE(NEW.application_id, OLD.application_id)
        AND vote = 'approve'
    ),
    reject_votes = (
      SELECT COUNT(*)
      FROM public.application_votes
      WHERE application_id = COALESCE(NEW.application_id, OLD.application_id)
        AND vote = 'reject'
    ),
    abstain_votes = (
      SELECT COUNT(*)
      FROM public.application_votes
      WHERE application_id = COALESCE(NEW.application_id, OLD.application_id)
        AND vote = 'abstain'
    )
  WHERE id = COALESCE(NEW.application_id, OLD.application_id);

  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Create triggers for vote count updates
CREATE TRIGGER update_vote_counts_on_insert
  AFTER INSERT ON public.application_votes
  FOR EACH ROW EXECUTE FUNCTION public.update_application_vote_counts();

CREATE TRIGGER update_vote_counts_on_update
  AFTER UPDATE ON public.application_votes
  FOR EACH ROW EXECUTE FUNCTION public.update_application_vote_counts();

CREATE TRIGGER update_vote_counts_on_delete
  AFTER DELETE ON public.application_votes
  FOR EACH ROW EXECUTE FUNCTION public.update_application_vote_counts();

-- ==========================================
-- Function to check and auto-process applications
-- ==========================================

CREATE OR REPLACE FUNCTION public.check_auto_application_status()
RETURNS TRIGGER AS $$
DECLARE
  config RECORD;
  approval_ratio DECIMAL(3,2);
  rejection_ratio DECIMAL(3,2);
BEGIN
  -- Get voting configuration
  SELECT * INTO config FROM public.voting_config LIMIT 1;

  -- Check if we have enough votes
  IF NEW.total_votes >= config.min_votes_required THEN
    -- Calculate ratios
    approval_ratio := CASE
      WHEN NEW.total_votes > 0 THEN NEW.approve_votes::DECIMAL / NEW.total_votes
      ELSE 0
    END;

    rejection_ratio := CASE
      WHEN NEW.total_votes > 0 THEN NEW.reject_votes::DECIMAL / NEW.total_votes
      ELSE 0
    END;

    -- Check for auto-approval
    IF config.auto_approve_enabled AND approval_ratio >= config.approval_threshold THEN
      NEW.status := 'accepted';
      NEW.voting_completed := true;
      NEW.voting_completed_at := NOW();
    -- Check for auto-rejection
    ELSIF config.auto_reject_enabled AND rejection_ratio >= config.rejection_threshold THEN
      NEW.status := 'rejected';
      NEW.voting_completed := true;
      NEW.voting_completed_at := NOW();
    END IF;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for auto status updates
CREATE TRIGGER check_auto_status
  BEFORE UPDATE OF total_votes, approve_votes, reject_votes ON public.applications
  FOR EACH ROW EXECUTE FUNCTION public.check_auto_application_status();

-- ==========================================
-- RLS Policies for Votes
-- ==========================================

-- Enable RLS
ALTER TABLE public.application_votes ENABLE ROW LEVEL SECURITY;

-- Admins can view all votes
CREATE POLICY "Admins can view all votes" ON public.application_votes
  FOR SELECT
  USING (public.is_admin());

-- Admins can create votes
CREATE POLICY "Admins can create votes" ON public.application_votes
  FOR INSERT
  WITH CHECK (
    public.is_admin() AND
    admin_id = (SELECT auth.uid())
  );

-- Admins can update their own votes
CREATE POLICY "Admins can update own votes" ON public.application_votes
  FOR UPDATE
  USING (
    public.is_admin() AND
    admin_id = (SELECT auth.uid())
  )
  WITH CHECK (
    public.is_admin() AND
    admin_id = (SELECT auth.uid())
  );

-- Admins can delete their own votes
CREATE POLICY "Admins can delete own votes" ON public.application_votes
  FOR DELETE
  USING (
    public.is_admin() AND
    admin_id = (SELECT auth.uid())
  );

-- ==========================================
-- RLS Policies for Comments
-- ==========================================

-- Enable RLS
ALTER TABLE public.application_comments ENABLE ROW LEVEL SECURITY;

-- Admins can view all internal comments
CREATE POLICY "Admins can view comments" ON public.application_comments
  FOR SELECT
  USING (
    public.is_admin() OR
    (NOT is_internal AND EXISTS (
      SELECT 1 FROM public.applications
      WHERE id = application_id
      AND (user_id = (SELECT auth.uid()) OR email = (SELECT auth.jwt()->>'email'))
    ))
  );

-- Admins can create comments
CREATE POLICY "Admins can create comments" ON public.application_comments
  FOR INSERT
  WITH CHECK (
    public.is_admin() AND
    author_id = (SELECT auth.uid())
  );

-- Authors can update their own comments within 15 minutes
CREATE POLICY "Authors can update own recent comments" ON public.application_comments
  FOR UPDATE
  USING (
    author_id = (SELECT auth.uid()) AND
    created_at > NOW() - INTERVAL '15 minutes' AND
    deleted_at IS NULL
  )
  WITH CHECK (
    author_id = (SELECT auth.uid()) AND
    created_at > NOW() - INTERVAL '15 minutes' AND
    deleted_at IS NULL
  );

-- Authors can soft-delete their own comments
CREATE POLICY "Authors can soft-delete own comments" ON public.application_comments
  FOR UPDATE
  USING (
    author_id = (SELECT auth.uid()) AND
    deleted_at IS NULL
  )
  WITH CHECK (
    author_id = (SELECT auth.uid())
  );

-- ==========================================
-- RLS Policies for Voting Config (admin only)
-- ==========================================

ALTER TABLE public.voting_config ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Admins can view voting config" ON public.voting_config
  FOR SELECT
  USING (public.is_admin());

CREATE POLICY "Admins can update voting config" ON public.voting_config
  FOR UPDATE
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- ==========================================
-- Helper Views
-- ==========================================

-- View for application voting summary
CREATE OR REPLACE VIEW public.application_voting_summary AS
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

-- Grant access to the view
GRANT SELECT ON public.application_voting_summary TO authenticated;

-- ==========================================
-- Function to get comment threads
-- ==========================================

CREATE OR REPLACE FUNCTION public.get_application_comments(p_application_id UUID)
RETURNS TABLE (
  id UUID,
  application_id UUID,
  author_id UUID,
  author_name TEXT,
  content TEXT,
  parent_id UUID,
  is_internal BOOLEAN,
  created_at TIMESTAMPTZ,
  edited_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ,
  depth INTEGER
) AS $$
WITH RECURSIVE comment_tree AS (
  -- Base case: top-level comments
  SELECT
    c.id,
    c.application_id,
    c.author_id,
    u.name as author_name,
    c.content,
    c.parent_id,
    c.is_internal,
    c.created_at,
    c.edited_at,
    c.deleted_at,
    0 as depth
  FROM public.application_comments c
  JOIN public.users u ON c.author_id = u.id
  WHERE c.application_id = p_application_id
    AND c.parent_id IS NULL

  UNION ALL

  -- Recursive case: replies
  SELECT
    c.id,
    c.application_id,
    c.author_id,
    u.name as author_name,
    c.content,
    c.parent_id,
    c.is_internal,
    c.created_at,
    c.edited_at,
    c.deleted_at,
    ct.depth + 1
  FROM public.application_comments c
  JOIN public.users u ON c.author_id = u.id
  JOIN comment_tree ct ON c.parent_id = ct.id
  WHERE c.application_id = p_application_id
)
SELECT * FROM comment_tree
ORDER BY created_at, depth;
$$ LANGUAGE sql STABLE;

-- Grant execute permission
GRANT EXECUTE ON FUNCTION public.get_application_comments TO authenticated;