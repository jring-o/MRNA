-- ==========================================
-- Participant Profiles — rich, workshop-specific profile fields
-- ==========================================

CREATE TABLE public.participant_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES public.users(id) ON DELETE CASCADE,
  description TEXT,
  location TEXT,
  inspiring_moment TEXT,
  reading_list JSONB DEFAULT '[]',       -- [{title, author}]
  who_inspires_you JSONB DEFAULT '[]',   -- [{name, reason}]
  best_sidequests TEXT,
  favorite_animal TEXT,
  undersung_roles JSONB DEFAULT '[]',    -- ["string", ...]
  cool_projects JSONB DEFAULT '[]',      -- [{url, description}]
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for fast lookup by user_id
CREATE INDEX idx_participant_profiles_user_id ON public.participant_profiles(user_id);

-- Reuse existing trigger for updated_at
CREATE TRIGGER update_participant_profiles_updated_at
  BEFORE UPDATE ON public.participant_profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ==========================================
-- RLS
-- ==========================================
ALTER TABLE public.participant_profiles ENABLE ROW LEVEL SECURITY;

-- Participants and admins can view all profiles
CREATE POLICY "participants_and_admins_select_profiles" ON public.participant_profiles
  FOR SELECT
  TO authenticated
  USING (
    public.auth_role() IN ('participant', 'admin')
  );

-- Users can insert their own profile
CREATE POLICY "users_insert_own_profile" ON public.participant_profiles
  FOR INSERT
  TO authenticated
  WITH CHECK (
    user_id = (SELECT auth.uid())
  );

-- Users can update their own profile
CREATE POLICY "users_update_own_profile" ON public.participant_profiles
  FOR UPDATE
  TO authenticated
  USING (user_id = (SELECT auth.uid()))
  WITH CHECK (user_id = (SELECT auth.uid()));
