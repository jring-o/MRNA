-- Rename inspiring_moment to schema_motivation
ALTER TABLE public.participant_profiles
  RENAME COLUMN inspiring_moment TO schema_motivation;
