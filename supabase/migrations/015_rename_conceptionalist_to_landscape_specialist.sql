-- ==========================================
-- Rename "Conceptionalist" classification to "Landscape/Ecosystem Specialist"
-- ==========================================

-- Clear existing applications to avoid migration issues
TRUNCATE TABLE public.application_votes CASCADE;
TRUNCATE TABLE public.application_comments CASCADE;
TRUNCATE TABLE public.invite_tokens CASCADE;
TRUNCATE TABLE public.applications CASCADE;

-- Drop old check constraint for conceptionalist
ALTER TABLE public.applications
DROP CONSTRAINT IF EXISTS check_conceptionalist_questions;

-- Rename columns from conceptionalist_* to landscape_specialist_*
ALTER TABLE public.applications
RENAME COLUMN conceptionalist_unlock TO landscape_specialist_current_work;

ALTER TABLE public.applications
RENAME COLUMN conceptionalist_enable TO landscape_specialist_see_emerging;

-- Add new check constraint for landscape_specialist questions
ALTER TABLE public.applications
ADD CONSTRAINT check_landscape_specialist_questions CHECK (
  (NOT 'landscape_specialist' = ANY(classifications)) OR
  (landscape_specialist_current_work IS NOT NULL AND landscape_specialist_see_emerging IS NOT NULL)
);

-- Update column comments
COMMENT ON COLUMN public.applications.landscape_specialist_current_work IS 'Landscape/Ecosystem Specialist: What research landscape(s) or ecosystem(s) are you currently working in or observing? (200 words)';
COMMENT ON COLUMN public.applications.landscape_specialist_see_emerging IS 'Landscape/Ecosystem Specialist: What do you see emerging in research ecosystems that an interoperable attribution schema might support? (200 words)';

-- ==========================================
-- Migration Note:
-- This migration renames the "Conceptionalist" classification to "Landscape/Ecosystem Specialist"
-- Field mappings:
-- - conceptionalist_unlock -> landscape_specialist_current_work
-- - conceptionalist_enable -> landscape_specialist_see_emerging
-- ==========================================
