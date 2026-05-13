-- ==========================================
-- Lightning talk interest — boolean opt-in on participant profiles
-- ==========================================

ALTER TABLE public.participant_profiles
  ADD COLUMN lightning_talk_interest BOOLEAN;
-- NULL = no answer, TRUE = yes, FALSE = no
