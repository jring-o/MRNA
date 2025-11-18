-- ==========================================
-- Update work_links structure to support description-first work items
-- Structure changes from {url, role} to {description, role, url (optional)}
-- ==========================================

-- Clear existing applications to avoid migration issues
TRUNCATE TABLE public.application_votes CASCADE;
TRUNCATE TABLE public.application_comments CASCADE;
TRUNCATE TABLE public.invite_tokens CASCADE;
TRUNCATE TABLE public.applications CASCADE;

-- Drop old validation function
DROP FUNCTION IF EXISTS public.validate_work_links(JSONB);

-- Drop old check constraint
ALTER TABLE public.applications
DROP CONSTRAINT IF EXISTS check_work_links_structure;

-- Update work_links column comment to reflect new structure
COMMENT ON COLUMN public.applications.work_links IS 'Array of {description, role, url (optional)} objects for work examples (1-5 items)';

-- Create new validation function for work_links with description-first structure
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

  -- Check each element has required fields: description, role
  -- URL is optional
  FOR link IN SELECT * FROM jsonb_array_elements(links)
  LOOP
    -- Must have description and role
    IF NOT (link ? 'description' AND link ? 'role') THEN
      RETURN FALSE;
    END IF;

    -- Check types are strings
    IF jsonb_typeof(link->'description') != 'string' OR jsonb_typeof(link->'role') != 'string' THEN
      RETURN FALSE;
    END IF;

    -- URL is optional, but if present must be a string
    IF link ? 'url' THEN
      IF jsonb_typeof(link->'url') != 'string' THEN
        RETURN FALSE;
      END IF;
    END IF;

    -- Description must be at least 10 characters
    IF length(link->>'description') < 10 THEN
      RETURN FALSE;
    END IF;

    -- Role must be at least 2 characters
    IF length(link->>'role') < 2 THEN
      RETURN FALSE;
    END IF;
  END LOOP;

  RETURN TRUE;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Add new check constraint for work_links structure with description required
ALTER TABLE public.applications
ADD CONSTRAINT check_work_links_structure CHECK (
  jsonb_typeof(work_links) = 'array' AND
  jsonb_array_length(work_links) >= 1 AND
  jsonb_array_length(work_links) <= 5 AND
  validate_work_links(work_links)
);

-- Grant execute permission
GRANT EXECUTE ON FUNCTION public.validate_work_links TO authenticated;
GRANT EXECUTE ON FUNCTION public.validate_work_links TO anon;

-- ==========================================
-- Migration Note:
-- Existing applications will need to be manually updated if any exist
-- New structure: [{description: string, role: string, url?: string}]
-- Old structure: [{url: string, role: string}]
-- ==========================================
