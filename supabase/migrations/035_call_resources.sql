-- ==========================================
-- Call Resources — recordings, notes, and files from calls
-- Only participants and admins can view; only admins can manage
-- ==========================================

CREATE TABLE public.call_resources (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  call_date DATE,
  file_url TEXT,                -- Supabase Storage path or external URL
  file_name TEXT,               -- Original file name for display
  file_size BIGINT,             -- File size in bytes
  file_type TEXT,               -- MIME type (audio/mp3, application/pdf, etc.)
  resource_type TEXT NOT NULL DEFAULT 'recording'
    CHECK (resource_type IN ('recording', 'notes', 'agenda', 'slides', 'other')),
  uploaded_by UUID REFERENCES public.users(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_call_resources_call_date ON public.call_resources(call_date DESC);

CREATE TRIGGER update_call_resources_updated_at
  BEFORE UPDATE ON public.call_resources
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ==========================================
-- RLS — participants + admins can read, only admins can write
-- ==========================================
ALTER TABLE public.call_resources ENABLE ROW LEVEL SECURITY;

-- Participants and admins can view all call resources
CREATE POLICY "participants_and_admins_select_call_resources" ON public.call_resources
  FOR SELECT
  TO authenticated
  USING (
    public.auth_role() IN ('participant', 'admin')
  );

-- Only admins can insert
CREATE POLICY "admins_insert_call_resources" ON public.call_resources
  FOR INSERT
  TO authenticated
  WITH CHECK (public.is_admin());

-- Only admins can update
CREATE POLICY "admins_update_call_resources" ON public.call_resources
  FOR UPDATE
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- Only admins can delete
CREATE POLICY "admins_delete_call_resources" ON public.call_resources
  FOR DELETE
  TO authenticated
  USING (public.is_admin());

-- ==========================================
-- Storage bucket for call resource files
-- ==========================================
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'call-resources',
  'call-resources',
  false,
  524288000,  -- 500MB limit for recordings
  ARRAY[
    'audio/mpeg', 'audio/mp3', 'audio/wav', 'audio/ogg', 'audio/webm', 'audio/mp4', 'audio/x-m4a',
    'video/mp4', 'video/webm', 'video/quicktime',
    'application/pdf',
    'text/plain', 'text/markdown',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    'image/png', 'image/jpeg', 'image/gif'
  ]
)
ON CONFLICT (id) DO NOTHING;

-- Storage policies: participants + admins can download, only admins can upload/delete
CREATE POLICY "participants_and_admins_read_call_resources"
  ON storage.objects FOR SELECT
  TO authenticated
  USING (
    bucket_id = 'call-resources'
    AND public.auth_role() IN ('participant', 'admin')
  );

CREATE POLICY "admins_upload_call_resources"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (
    bucket_id = 'call-resources'
    AND public.is_admin()
  );

CREATE POLICY "admins_delete_call_resources"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (
    bucket_id = 'call-resources'
    AND public.is_admin()
  );
