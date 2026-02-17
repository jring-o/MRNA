-- ==========================================
-- Code of Conduct acceptance tracking
--
-- Participants must accept the CoC before
-- accessing the dashboard or other gated pages.
-- ==========================================

ALTER TABLE public.users
  ADD COLUMN IF NOT EXISTS coc_accepted_at TIMESTAMPTZ;
