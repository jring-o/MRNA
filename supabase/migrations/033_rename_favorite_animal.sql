-- ==========================================
-- Rename favorite_animal → revolutionary_animal
--
-- The profile question changes from "What's your favorite animal?"
-- to "Which animal is most likely to revolutionize science?"
-- ==========================================

ALTER TABLE public.participant_profiles
  RENAME COLUMN favorite_animal TO revolutionary_animal;
