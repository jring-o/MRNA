-- ==========================================
-- Post-Event Survey — anonymous responses + decoupled completion tracking
-- ==========================================
-- Responses carry NO user_id (truly anonymous). A separate completions table
-- records only THAT a user submitted, so we can show an "already responded"
-- state and nudge non-responders without being able to link a person to their
-- answers. Question definitions live in code: src/lib/survey/questions.ts
-- (answers JSONB is keyed by the question ids defined there).

-- Surveys: one row per gathering; reusable for every future workshop.
CREATE TABLE public.surveys (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT NOT NULL UNIQUE,
  title TEXT NOT NULL,
  event_label TEXT,                        -- e.g. 'MIRA Dublin 2026'
  is_open BOOLEAN NOT NULL DEFAULT true,   -- accepting responses?
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TRIGGER update_surveys_updated_at
  BEFORE UPDATE ON public.surveys
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Responses: anonymous (no user link). answers keyed by question id.
CREATE TABLE public.survey_responses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  survey_id UUID NOT NULL REFERENCES public.surveys(id) ON DELETE CASCADE,
  answers JSONB NOT NULL DEFAULT '{}'::jsonb,
  submitted_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_survey_responses_survey_id ON public.survey_responses(survey_id);

-- Completions: records who submitted, decoupled from their answers.
-- PK enforces one completion per user per survey.
CREATE TABLE public.survey_completions (
  survey_id UUID NOT NULL REFERENCES public.surveys(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  completed_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (survey_id, user_id)
);

-- ==========================================
-- RLS
-- ==========================================
ALTER TABLE public.surveys ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.survey_responses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.survey_completions ENABLE ROW LEVEL SECURITY;

-- surveys: any authenticated user can read survey metadata; only admins manage.
CREATE POLICY "surveys_select_authenticated" ON public.surveys
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "surveys_admin_all" ON public.surveys
  FOR ALL
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- responses: authenticated users may INSERT, but only while the survey is open.
-- No user link is stored on insert, so responses stay anonymous.
-- Only admins may SELECT (aggregate/read). No UPDATE/DELETE — responses are immutable.
CREATE POLICY "survey_responses_insert_when_open" ON public.survey_responses
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.surveys s
      WHERE s.id = survey_id AND s.is_open
    )
  );

CREATE POLICY "survey_responses_admin_select" ON public.survey_responses
  FOR SELECT
  TO authenticated
  USING (public.is_admin());

-- completions: a user can record only their own completion; admins read all.
CREATE POLICY "survey_completions_insert_own" ON public.survey_completions
  FOR INSERT
  TO authenticated
  WITH CHECK (user_id = (SELECT auth.uid()));

CREATE POLICY "survey_completions_select_own_or_admin" ON public.survey_completions
  FOR SELECT
  TO authenticated
  USING (
    user_id = (SELECT auth.uid())
    OR public.is_admin()
  );

-- ==========================================
-- Seed the MIRA Dublin 2026 post-event survey
-- ==========================================
INSERT INTO public.surveys (slug, title, event_label, is_open)
VALUES ('mira-dublin-2026', 'MIRA Workshop Post-Event Survey', 'MIRA Dublin 2026', true)
ON CONFLICT (slug) DO NOTHING;
