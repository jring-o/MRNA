-- ==========================================
-- Admin Todo System
-- ==========================================
-- A comprehensive todo system for admins to track tasks,
-- assign work, set priorities, and collaborate through comments.
-- Only admins can view or interact with these todos.
-- ==========================================

-- Create priority enum
CREATE TYPE todo_priority AS ENUM ('low', 'medium', 'high', 'urgent');

-- Create status enum
CREATE TYPE todo_status AS ENUM ('pending', 'in_progress', 'completed', 'cancelled');

-- ==========================================
-- Admin todos table
-- ==========================================
CREATE TABLE public.admin_todos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  status todo_status DEFAULT 'pending',
  priority todo_priority DEFAULT 'medium',
  assigned_to UUID REFERENCES public.users(id) ON DELETE SET NULL,
  created_by UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  due_date DATE,
  completed_at TIMESTAMPTZ,
  completed_by UUID REFERENCES public.users(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for performance
CREATE INDEX idx_admin_todos_status ON public.admin_todos(status);
CREATE INDEX idx_admin_todos_priority ON public.admin_todos(priority);
CREATE INDEX idx_admin_todos_assigned_to ON public.admin_todos(assigned_to);
CREATE INDEX idx_admin_todos_created_by ON public.admin_todos(created_by);
CREATE INDEX idx_admin_todos_due_date ON public.admin_todos(due_date);

-- ==========================================
-- Admin todo comments table
-- ==========================================
CREATE TABLE public.admin_todo_comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  todo_id UUID NOT NULL REFERENCES public.admin_todos(id) ON DELETE CASCADE,
  author_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  edited_at TIMESTAMPTZ
);

-- Create indexes for performance
CREATE INDEX idx_admin_todo_comments_todo_id ON public.admin_todo_comments(todo_id);
CREATE INDEX idx_admin_todo_comments_author_id ON public.admin_todo_comments(author_id);
CREATE INDEX idx_admin_todo_comments_created_at ON public.admin_todo_comments(created_at DESC);

-- ==========================================
-- Update triggers
-- ==========================================

-- Trigger for updated_at on todos
CREATE TRIGGER update_admin_todos_updated_at
  BEFORE UPDATE ON public.admin_todos
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ==========================================
-- RLS Policies for Admin Todos
-- ==========================================

-- Enable RLS
ALTER TABLE public.admin_todos ENABLE ROW LEVEL SECURITY;

-- Only admins can view todos
CREATE POLICY "Admins can view all todos" ON public.admin_todos
  FOR SELECT
  TO authenticated
  USING (public.is_admin());

-- Only admins can create todos
CREATE POLICY "Admins can create todos" ON public.admin_todos
  FOR INSERT
  TO authenticated
  WITH CHECK (
    public.is_admin() AND
    created_by = (SELECT auth.uid())
  );

-- Admins can update todos
CREATE POLICY "Admins can update todos" ON public.admin_todos
  FOR UPDATE
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- Admins can delete todos (soft delete by setting status to cancelled)
CREATE POLICY "Admins can delete todos" ON public.admin_todos
  FOR DELETE
  TO authenticated
  USING (public.is_admin());

-- ==========================================
-- RLS Policies for Admin Todo Comments
-- ==========================================

-- Enable RLS
ALTER TABLE public.admin_todo_comments ENABLE ROW LEVEL SECURITY;

-- Only admins can view comments
CREATE POLICY "Admins can view todo comments" ON public.admin_todo_comments
  FOR SELECT
  TO authenticated
  USING (public.is_admin());

-- Only admins can create comments
CREATE POLICY "Admins can create todo comments" ON public.admin_todo_comments
  FOR INSERT
  TO authenticated
  WITH CHECK (
    public.is_admin() AND
    author_id = (SELECT auth.uid())
  );

-- Authors can update their own comments within 15 minutes
CREATE POLICY "Authors can update own recent todo comments" ON public.admin_todo_comments
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
CREATE POLICY "Authors can delete own todo comments" ON public.admin_todo_comments
  FOR DELETE
  TO authenticated
  USING (
    public.is_admin() AND
    author_id = (SELECT auth.uid())
  );

-- ==========================================
-- Helper function to auto-set completed_at and completed_by
-- ==========================================

CREATE OR REPLACE FUNCTION public.handle_todo_completion()
RETURNS TRIGGER AS $$
BEGIN
  -- If status is changing to completed
  IF NEW.status = 'completed' AND OLD.status != 'completed' THEN
    NEW.completed_at = NOW();
    NEW.completed_by = auth.uid();
  -- If status is changing from completed to something else
  ELSIF OLD.status = 'completed' AND NEW.status != 'completed' THEN
    NEW.completed_at = NULL;
    NEW.completed_by = NULL;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for auto-completion handling
CREATE TRIGGER handle_todo_completion
  BEFORE UPDATE ON public.admin_todos
  FOR EACH ROW
  WHEN (OLD.status IS DISTINCT FROM NEW.status)
  EXECUTE FUNCTION public.handle_todo_completion();

-- ==========================================
-- View for todos with assignee and creator info
-- ==========================================

CREATE OR REPLACE VIEW public.admin_todos_with_users AS
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

-- Grant access to the view
GRANT SELECT ON public.admin_todos_with_users TO authenticated;