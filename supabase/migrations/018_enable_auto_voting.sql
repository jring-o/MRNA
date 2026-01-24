-- Enable automatic status change when voting threshold is met
UPDATE public.voting_config
SET
  auto_approve_enabled = true,
  auto_reject_enabled = true,
  updated_at = NOW();
