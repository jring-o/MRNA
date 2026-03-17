-- ==========================================
-- Travel Info — per-participant travel budgets & flight details
-- ==========================================

CREATE TABLE public.travel_info (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES public.users(id) ON DELETE CASCADE,
  travel_budget INTEGER,                          -- max reimbursable amount in USD
  arrival_mode TEXT DEFAULT 'flight',              -- flight, train, already_in_ireland, other
  arrival_date DATE,
  arrival_flight_number TEXT,                      -- flight number or train info
  arrival_time TEXT,                               -- estimated arrival time at Dublin
  departure_mode TEXT DEFAULT 'flight',            -- flight, train, other
  departure_date DATE,
  departure_flight_number TEXT,
  departure_time TEXT,                             -- departure time from Dublin
  notes TEXT,                                      -- special requests, already in Ireland, etc.
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_travel_info_user_id ON public.travel_info(user_id);

-- Reuse existing trigger for updated_at
CREATE TRIGGER update_travel_info_updated_at
  BEFORE UPDATE ON public.travel_info
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ==========================================
-- RLS — participants see only own, admins see all
-- ==========================================
ALTER TABLE public.travel_info ENABLE ROW LEVEL SECURITY;

-- Participants can view their own travel info (budget + flight details)
CREATE POLICY "users_select_own_travel_info" ON public.travel_info
  FOR SELECT
  TO authenticated
  USING (
    user_id = (SELECT auth.uid())
    OR public.is_admin()
  );

-- Users can insert their own travel info
CREATE POLICY "users_insert_own_travel_info" ON public.travel_info
  FOR INSERT
  TO authenticated
  WITH CHECK (
    user_id = (SELECT auth.uid())
    OR public.is_admin()
  );

-- Users can update their own travel info
-- NOTE: travel_budget is protected at the DB level via the trigger below
CREATE POLICY "users_update_own_travel_info" ON public.travel_info
  FOR UPDATE
  TO authenticated
  USING (
    user_id = (SELECT auth.uid())
    OR public.is_admin()
  )
  WITH CHECK (
    user_id = (SELECT auth.uid())
    OR public.is_admin()
  );

-- ==========================================
-- Protect travel_budget from non-admin updates
-- ==========================================
CREATE OR REPLACE FUNCTION protect_travel_budget()
RETURNS TRIGGER AS $$
BEGIN
  -- If the user is not an admin and tries to change travel_budget, revert it
  IF NOT public.is_admin() THEN
    NEW.travel_budget := OLD.travel_budget;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER protect_travel_budget_trigger
  BEFORE UPDATE ON public.travel_info
  FOR EACH ROW EXECUTE FUNCTION protect_travel_budget();

-- ==========================================
-- Seed travel budgets from CSV data
-- ==========================================
INSERT INTO public.travel_info (user_id, travel_budget)
SELECT u.id, budgets.budget
FROM (VALUES
  ('monica@creativecommons.org', 600),
  ('akamatsm@uw.edu', 1250),
  ('ronen@cosmik.network', 1100),
  ('wesley@cosmik.network', 750),
  ('ellie@scios.tech', 800),
  ('jon@scios.tech', 850),
  ('morgan@quantumbiology.org', 1250),
  ('a.campbell@digital-science.com', 100),
  ('sekhar.ramakrishnan@astera.org', 230),
  ('frida.arreytakubetang@gmail.com', 150),
  ('m@jmartink.org', 150),
  ('rodrigo.miguelesramirez@mail.mcgill.ca', 600),
  ('shaobsh@gmail.com', 800),
  ('antonmolina@bnext.bio', 1250),
  ('ellie.rennie@rmit.edu.au', 1500),
  ('luke@block.science', 800),
  ('nokome@stencila.io', 2000),
  ('joelchan@umd.edu', 1000),
  ('maparent@conversence.com', 600),
  ('hyunokate.lee@utoronto.ca', 600),
  ('sean.moore3@mail.mcgill.ca', 600),
  ('p.shannon@elifesciences.org', 100)
) AS budgets(email, budget)
JOIN public.users u ON u.email = budgets.email
ON CONFLICT (user_id) DO UPDATE SET travel_budget = EXCLUDED.travel_budget;
