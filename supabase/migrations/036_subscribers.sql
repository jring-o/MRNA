-- 036_subscribers.sql
-- Newsletter / "Keep me posted" signups captured from the MIRA landing page
-- (mira.science). Anonymous visitors may INSERT a signup; only admins may read
-- the list.

CREATE TABLE IF NOT EXISTS public.subscribers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT NOT NULL,
  source TEXT,                               -- e.g. 'hero', 'get-involved'
  status TEXT NOT NULL DEFAULT 'subscribed', -- 'subscribed' | 'unsubscribed'
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Case-insensitive de-duplication. The app also lowercases before inserting,
-- but this enforces uniqueness regardless of casing.
CREATE UNIQUE INDEX IF NOT EXISTS subscribers_email_lower_idx
  ON public.subscribers (lower(email));

ALTER TABLE public.subscribers ENABLE ROW LEVEL SECURITY;

-- Anyone (anonymous or logged-in) may add themselves to the list, nothing else.
GRANT INSERT ON public.subscribers TO anon, authenticated;

CREATE POLICY "Anyone can subscribe"
  ON public.subscribers
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- Only admins can read / manage the subscriber list.
GRANT SELECT ON public.subscribers TO authenticated;

CREATE POLICY "Admins can view subscribers"
  ON public.subscribers
  FOR SELECT
  TO authenticated
  USING (public.is_admin());
