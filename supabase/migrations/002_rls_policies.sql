-- Enable RLS on all tables
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.blog_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.breakout_rooms ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.room_participants ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_reflections ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.photo_gallery ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.schema_iterations ENABLE ROW LEVEL SECURITY;

-- ==========================================
-- USERS TABLE POLICIES
-- ==========================================

-- Users can view their own profile
CREATE POLICY "Users can view own profile" ON public.users
  FOR SELECT USING ((SELECT auth.uid()) = id);

-- Users can view all participants (for directory)
CREATE POLICY "Users can view participants" ON public.users
  FOR SELECT TO authenticated
  USING (
    id IN (
      SELECT au.id FROM auth.users au
      WHERE au.raw_app_meta_data->>'role' = 'participant'
    )
  );

-- Admins can view all users
CREATE POLICY "Admins can view all users" ON public.users
  FOR SELECT TO authenticated
  USING (public.is_admin());

-- Users can update their own profile
CREATE POLICY "Users can update own profile" ON public.users
  FOR UPDATE USING ((SELECT auth.uid()) = id)
  WITH CHECK ((SELECT auth.uid()) = id);

-- ==========================================
-- APPLICATIONS TABLE POLICIES
-- ==========================================

-- Users can view their own applications
CREATE POLICY "Users can view own applications" ON public.applications
  FOR SELECT TO authenticated
  USING (user_id = (SELECT auth.uid()));

-- Admins can view all applications
CREATE POLICY "Admins can view all applications" ON public.applications
  FOR SELECT TO authenticated
  USING (public.is_admin());

-- Users can insert their own applications
CREATE POLICY "Users can create applications" ON public.applications
  FOR INSERT TO authenticated
  WITH CHECK (user_id = (SELECT auth.uid()));

-- Users can update their own pending applications
CREATE POLICY "Users can update own pending applications" ON public.applications
  FOR UPDATE TO authenticated
  USING (user_id = (SELECT auth.uid()) AND status = 'pending')
  WITH CHECK (user_id = (SELECT auth.uid()));

-- Admins can update any application
CREATE POLICY "Admins can update applications" ON public.applications
  FOR UPDATE TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- ==========================================
-- BLOG POSTS TABLE POLICIES
-- ==========================================

-- Anyone can view published blog posts
CREATE POLICY "Anyone can view published posts" ON public.blog_posts
  FOR SELECT
  USING (published = true);

-- Authors can view their own unpublished posts
CREATE POLICY "Authors can view own posts" ON public.blog_posts
  FOR SELECT TO authenticated
  USING (author_id = (SELECT auth.uid()));

-- Admins can view all posts
CREATE POLICY "Admins can view all posts" ON public.blog_posts
  FOR SELECT TO authenticated
  USING (public.is_admin());

-- Admins can create posts
CREATE POLICY "Admins can create posts" ON public.blog_posts
  FOR INSERT TO authenticated
  WITH CHECK (public.is_admin());

-- Authors and admins can update posts
CREATE POLICY "Authors and admins can update posts" ON public.blog_posts
  FOR UPDATE TO authenticated
  USING (author_id = (SELECT auth.uid()) OR public.is_admin())
  WITH CHECK (author_id = (SELECT auth.uid()) OR public.is_admin());

-- ==========================================
-- TASKS TABLE POLICIES
-- ==========================================

-- Users can view tasks assigned to them
CREATE POLICY "Users can view assigned tasks" ON public.tasks
  FOR SELECT TO authenticated
  USING (assignee_id = (SELECT auth.uid()) OR created_by = (SELECT auth.uid()));

-- Admins can view all tasks
CREATE POLICY "Admins can view all tasks" ON public.tasks
  FOR SELECT TO authenticated
  USING (public.is_admin());

-- Admins can create tasks
CREATE POLICY "Admins can create tasks" ON public.tasks
  FOR INSERT TO authenticated
  WITH CHECK (public.is_admin());

-- Admins and assignees can update tasks
CREATE POLICY "Admins and assignees can update tasks" ON public.tasks
  FOR UPDATE TO authenticated
  USING (assignee_id = (SELECT auth.uid()) OR public.is_admin())
  WITH CHECK (assignee_id = (SELECT auth.uid()) OR public.is_admin());

-- ==========================================
-- BREAKOUT ROOMS TABLE POLICIES
-- ==========================================

-- Participants can view active breakout rooms they're assigned to
CREATE POLICY "Participants can view assigned rooms" ON public.breakout_rooms
  FOR SELECT TO authenticated
  USING (
    active = true AND (
      id IN (
        SELECT room_id FROM public.room_participants
        WHERE user_id = (SELECT auth.uid())
      ) OR
      public.is_admin()
    )
  );

-- Admins can manage all rooms
CREATE POLICY "Admins can manage rooms" ON public.breakout_rooms
  FOR ALL TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- ==========================================
-- ROOM PARTICIPANTS TABLE POLICIES
-- ==========================================

-- Users can view participants in their rooms
CREATE POLICY "Users can view room participants" ON public.room_participants
  FOR SELECT TO authenticated
  USING (
    room_id IN (
      SELECT room_id FROM public.room_participants
      WHERE user_id = (SELECT auth.uid())
    ) OR
    public.is_admin()
  );

-- Admins can manage room participants
CREATE POLICY "Admins can manage room participants" ON public.room_participants
  FOR ALL TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- ==========================================
-- DAILY REFLECTIONS TABLE POLICIES
-- ==========================================

-- Users can view their own reflections
CREATE POLICY "Users can view own reflections" ON public.daily_reflections
  FOR SELECT TO authenticated
  USING (user_id = (SELECT auth.uid()));

-- Participants can view shared reflections
CREATE POLICY "Participants can view shared reflections" ON public.daily_reflections
  FOR SELECT TO authenticated
  USING (
    public.auth_role() IN ('participant', 'admin')
  );

-- Users can create their own reflections (if participant or admin)
CREATE POLICY "Users can create own reflections" ON public.daily_reflections
  FOR INSERT TO authenticated
  WITH CHECK (
    user_id = (SELECT auth.uid()) AND
    public.auth_role() IN ('participant', 'admin')
  );

-- Users can update their own reflections
CREATE POLICY "Users can update own reflections" ON public.daily_reflections
  FOR UPDATE TO authenticated
  USING (user_id = (SELECT auth.uid()))
  WITH CHECK (user_id = (SELECT auth.uid()));

-- ==========================================
-- PHOTO GALLERY TABLE POLICIES
-- ==========================================

-- Participants can view all photos
CREATE POLICY "Participants can view photos" ON public.photo_gallery
  FOR SELECT TO authenticated
  USING (
    public.auth_role() IN ('participant', 'admin')
  );

-- Users can upload their own photos (if participant or admin)
CREATE POLICY "Users can upload photos" ON public.photo_gallery
  FOR INSERT TO authenticated
  WITH CHECK (
    user_id = (SELECT auth.uid()) AND
    public.auth_role() IN ('participant', 'admin')
  );

-- Users can update their own photos
CREATE POLICY "Users can update own photos" ON public.photo_gallery
  FOR UPDATE TO authenticated
  USING (user_id = (SELECT auth.uid()))
  WITH CHECK (user_id = (SELECT auth.uid()));

-- Users can delete their own photos (or admins can delete any)
CREATE POLICY "Users can delete own photos" ON public.photo_gallery
  FOR DELETE TO authenticated
  USING (user_id = (SELECT auth.uid()) OR public.is_admin());

-- ==========================================
-- COMMENTS TABLE POLICIES
-- ==========================================

-- Authenticated users can view comments
CREATE POLICY "Authenticated can view comments" ON public.comments
  FOR SELECT TO authenticated
  USING (true);

-- Authenticated users can create comments
CREATE POLICY "Authenticated can create comments" ON public.comments
  FOR INSERT TO authenticated
  WITH CHECK (user_id = (SELECT auth.uid()));

-- Users can update their own comments
CREATE POLICY "Users can update own comments" ON public.comments
  FOR UPDATE TO authenticated
  USING (user_id = (SELECT auth.uid()))
  WITH CHECK (user_id = (SELECT auth.uid()));

-- Users can delete their own comments (admins can delete any)
CREATE POLICY "Users can delete own comments" ON public.comments
  FOR DELETE TO authenticated
  USING (user_id = (SELECT auth.uid()) OR public.is_admin());

-- ==========================================
-- SCHEMA ITERATIONS TABLE POLICIES
-- ==========================================

-- Participants can view schema iterations
CREATE POLICY "Participants can view schemas" ON public.schema_iterations
  FOR SELECT TO authenticated
  USING (
    public.auth_role() IN ('participant', 'admin')
  );

-- Participants can create schema iterations
CREATE POLICY "Participants can create schemas" ON public.schema_iterations
  FOR INSERT TO authenticated
  WITH CHECK (
    created_by = (SELECT auth.uid()) AND
    public.auth_role() IN ('participant', 'admin')
  );

-- Creators and admins can update schemas
CREATE POLICY "Creators and admins can update schemas" ON public.schema_iterations
  FOR UPDATE TO authenticated
  USING (created_by = (SELECT auth.uid()) OR public.is_admin())
  WITH CHECK (created_by = (SELECT auth.uid()) OR public.is_admin());

-- Grant necessary permissions
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO anon, authenticated;