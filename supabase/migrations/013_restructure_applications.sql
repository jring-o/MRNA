-- ==========================================
-- Restructure applications table for classification-based questionnaire
-- ==========================================

-- Drop old application question columns
ALTER TABLE public.applications
DROP COLUMN IF EXISTS reason_for_applying,
DROP COLUMN IF EXISTS requirements_for_protocol,
DROP COLUMN IF EXISTS relevant_experience;

-- Add classification fields
ALTER TABLE public.applications
ADD COLUMN classifications TEXT[] NOT NULL DEFAULT '{}',
ADD COLUMN classification_other TEXT CHECK (char_length(classification_other) <= 15);

-- Add universal question fields (required for all applicants)
ALTER TABLE public.applications
ADD COLUMN importance_of_schema TEXT NOT NULL DEFAULT '',
ADD COLUMN excited_projects TEXT NOT NULL DEFAULT '',
ADD COLUMN work_links JSONB NOT NULL DEFAULT '[]'::jsonb,
ADD COLUMN workshop_contribution TEXT NOT NULL DEFAULT '',
ADD COLUMN research_elements TEXT NOT NULL DEFAULT '';

-- Add role-specific question fields (nullable - only required if that role is selected)
ALTER TABLE public.applications
ADD COLUMN researcher_use_case TEXT,
ADD COLUMN researcher_future_impact TEXT,
ADD COLUMN designer_ux_considerations TEXT,
ADD COLUMN engineer_working_on TEXT,
ADD COLUMN engineer_schema_considerations TEXT,
ADD COLUMN conceptionalist_unlock TEXT,
ADD COLUMN conceptionalist_enable TEXT;

-- Create index on classifications array for faster filtering
CREATE INDEX IF NOT EXISTS idx_applications_classifications ON public.applications USING GIN (classifications);

-- Add check constraint to ensure at least one classification
ALTER TABLE public.applications
ADD CONSTRAINT check_at_least_one_classification CHECK (array_length(classifications, 1) >= 1);

-- Add check constraint for classification_other (required if 'other' in classifications)
ALTER TABLE public.applications
ADD CONSTRAINT check_classification_other_when_other CHECK (
  (NOT 'other' = ANY(classifications)) OR
  (classification_other IS NOT NULL AND char_length(classification_other) > 0)
);

-- Add check constraint for work_links structure (must be array of objects with url and role)
ALTER TABLE public.applications
ADD CONSTRAINT check_work_links_structure CHECK (
  jsonb_typeof(work_links) = 'array' AND
  jsonb_array_length(work_links) >= 1 AND
  jsonb_array_length(work_links) <= 5
);

-- Add check constraints for role-specific questions based on classifications
-- Researcher questions required if 'researcher' in classifications
ALTER TABLE public.applications
ADD CONSTRAINT check_researcher_questions CHECK (
  (NOT 'researcher' = ANY(classifications)) OR
  (researcher_use_case IS NOT NULL AND researcher_future_impact IS NOT NULL)
);

-- Designer questions required if 'designer' in classifications
ALTER TABLE public.applications
ADD CONSTRAINT check_designer_questions CHECK (
  (NOT 'designer' = ANY(classifications)) OR
  (designer_ux_considerations IS NOT NULL)
);

-- Engineer questions required if 'engineer' in classifications
ALTER TABLE public.applications
ADD CONSTRAINT check_engineer_questions CHECK (
  (NOT 'engineer' = ANY(classifications)) OR
  (engineer_working_on IS NOT NULL AND engineer_schema_considerations IS NOT NULL)
);

-- Conceptionalist questions required if 'conceptionalist' in classifications
ALTER TABLE public.applications
ADD CONSTRAINT check_conceptionalist_questions CHECK (
  (NOT 'conceptionalist' = ANY(classifications)) OR
  (conceptionalist_unlock IS NOT NULL AND conceptionalist_enable IS NOT NULL)
);

-- Remove default constraints after adding them (they were just for migration)
ALTER TABLE public.applications
ALTER COLUMN importance_of_schema DROP DEFAULT,
ALTER COLUMN excited_projects DROP DEFAULT,
ALTER COLUMN work_links DROP DEFAULT,
ALTER COLUMN workshop_contribution DROP DEFAULT,
ALTER COLUMN research_elements DROP DEFAULT;

-- Clear any existing applications (as discussed with user)
TRUNCATE TABLE public.application_votes CASCADE;
TRUNCATE TABLE public.application_comments CASCADE;
TRUNCATE TABLE public.invite_tokens CASCADE;
TRUNCATE TABLE public.applications CASCADE;

-- ==========================================
-- Helper function to validate work_links structure
-- ==========================================

CREATE OR REPLACE FUNCTION public.validate_work_links(links JSONB)
RETURNS BOOLEAN AS $$
DECLARE
  link JSONB;
BEGIN
  -- Check if it's an array
  IF jsonb_typeof(links) != 'array' THEN
    RETURN FALSE;
  END IF;

  -- Check array length
  IF jsonb_array_length(links) < 1 OR jsonb_array_length(links) > 5 THEN
    RETURN FALSE;
  END IF;

  -- Check each element has url and role
  FOR link IN SELECT * FROM jsonb_array_elements(links)
  LOOP
    IF NOT (link ? 'url' AND link ? 'role') THEN
      RETURN FALSE;
    END IF;

    IF jsonb_typeof(link->'url') != 'string' OR jsonb_typeof(link->'role') != 'string' THEN
      RETURN FALSE;
    END IF;
  END LOOP;

  RETURN TRUE;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Grant execute permission
GRANT EXECUTE ON FUNCTION public.validate_work_links TO authenticated;
GRANT EXECUTE ON FUNCTION public.validate_work_links TO anon;

-- ==========================================
-- Comment on new columns for documentation
-- ==========================================

COMMENT ON COLUMN public.applications.classifications IS 'Array of selected classifications: researcher, engineer, designer, conceptionalist, other';
COMMENT ON COLUMN public.applications.classification_other IS 'Custom classification text if "other" is selected (max 15 chars)';
COMMENT ON COLUMN public.applications.importance_of_schema IS 'Why is an interoperable Research attribution Schema important to you? (200 words)';
COMMENT ON COLUMN public.applications.excited_projects IS 'What other science/infrastructure/open science projects are you excited about? (200 words)';
COMMENT ON COLUMN public.applications.work_links IS 'Array of {url, role} objects for links to applicant work (1-5 links)';
COMMENT ON COLUMN public.applications.workshop_contribution IS 'What would you add to this workshop if you came? (200 words)';
COMMENT ON COLUMN public.applications.research_elements IS 'What elements or outputs of the research process would you define? (200 words)';
COMMENT ON COLUMN public.applications.researcher_use_case IS 'Researcher: Immediate use-case for modular research sharing/attribution (200 words)';
COMMENT ON COLUMN public.applications.researcher_future_impact IS 'Researcher: Future impact of granular research sharing (200 words)';
COMMENT ON COLUMN public.applications.designer_ux_considerations IS 'Designer: Important considerations for UX/design across platforms (200 words)';
COMMENT ON COLUMN public.applications.engineer_working_on IS 'Engineer: What are you working on that would use the schema - How? (200 words)';
COMMENT ON COLUMN public.applications.engineer_schema_considerations IS 'Engineer: Important considerations for designing shared schema (200 words)';
COMMENT ON COLUMN public.applications.conceptionalist_unlock IS 'Conceptionalist: What would schema unlock for existing projects? (200 words)';
COMMENT ON COLUMN public.applications.conceptionalist_enable IS 'Conceptionalist: What new projects might schema enable? (200 words)';
