-- ==========================================
-- Relax validation constraints for work_items
-- Change minimum length from 10 to 1 for description, and 2 to 1 for role
-- ==========================================

-- Drop constraint first (depends on the function)
ALTER TABLE public.applications
DROP CONSTRAINT IF EXISTS check_work_links_structure;

-- Drop old validation function
DROP FUNCTION IF EXISTS public.validate_work_links(JSONB);

-- Create updated validation function with relaxed constraints
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

    -- Description must be at least 1 character (not empty)
    IF length(link->>'description') < 1 THEN
      RETURN FALSE;
    END IF;

    -- Role must be at least 1 character (not empty)
    IF length(link->>'role') < 1 THEN
      RETURN FALSE;
    END IF;
  END LOOP;

  RETURN TRUE;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Re-add the constraint with the new validation function
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
-- This relaxes the validation to match the front-end form validation
-- Description: min 1 character (was 10)
-- Role: min 1 character (was 2)
-- ==========================================
