import { createClient } from '@/lib/supabase/server'
import type { SupabaseClient } from '@supabase/supabase-js'

// The generated Database type (src/types/supabase.ts) doesn't yet include the
// survey tables added in migration 037. Until it's regenerated
// (`supabase gen types typescript`), access those tables through a
// loosely-typed client. Auth/session handling is unchanged — this is the same
// underlying server client, just without table typings.
async function looseClient(): Promise<SupabaseClient> {
  const supabase = await createClient()
  return supabase as unknown as SupabaseClient
}

export type Survey = {
  id: string
  slug: string
  title: string
  event_label: string | null
  is_open: boolean
}

export type SurveyResponse = {
  answers: Record<string, unknown>
  submitted_at: string
}

/** The currently-open survey (most recently created), or null. */
export async function getOpenSurvey(): Promise<Survey | null> {
  const db = await looseClient()
  const { data } = await db
    .from('surveys')
    .select('id, slug, title, event_label, is_open')
    .eq('is_open', true)
    .order('created_at', { ascending: false })
    .limit(1)
    .maybeSingle()
  return (data as Survey | null) ?? null
}

/** Whether this user has already submitted the given survey. */
export async function hasCompleted(surveyId: string, userId: string): Promise<boolean> {
  const db = await looseClient()
  const { data } = await db
    .from('survey_completions')
    .select('user_id')
    .eq('survey_id', surveyId)
    .eq('user_id', userId)
    .maybeSingle()
  return !!data
}

/** All responses for a survey (admin-only via RLS). */
export async function getResponses(surveyId: string): Promise<SurveyResponse[]> {
  const db = await looseClient()
  const { data } = await db
    .from('survey_responses')
    .select('answers, submitted_at')
    .eq('survey_id', surveyId)
  return (data as SurveyResponse[] | null) ?? []
}

/** Count of participants who have submitted (admin-only via RLS). */
export async function getCompletionCount(surveyId: string): Promise<number> {
  const db = await looseClient()
  const { count } = await db
    .from('survey_completions')
    .select('*', { count: 'exact', head: true })
    .eq('survey_id', surveyId)
  return count ?? 0
}

/**
 * Store an anonymous response and mark the user as having completed the survey.
 * The two writes are intentionally decoupled: the response row carries no
 * user_id, so it can't be linked back to the person; the completion row records
 * only THAT this user submitted.
 */
export async function submitResponse(
  surveyId: string,
  userId: string,
  answers: Record<string, unknown>
): Promise<{ ok: true } | { ok: false; status: number; error: string }> {
  const db = await looseClient()

  // Block double-submission.
  if (await hasCompleted(surveyId, userId)) {
    return { ok: false, status: 409, error: 'You have already submitted this survey.' }
  }

  // 1) Anonymous response (no user link).
  const { error: responseError } = await db
    .from('survey_responses')
    .insert({ survey_id: surveyId, answers })
  if (responseError) {
    return { ok: false, status: 500, error: 'Failed to save response.' }
  }

  // 2) Completion marker (decoupled). On conflict, the user already completed —
  // the response above is a harmless duplicate; treat as success either way.
  await db
    .from('survey_completions')
    .upsert(
      { survey_id: surveyId, user_id: userId },
      { onConflict: 'survey_id,user_id', ignoreDuplicates: true }
    )

  return { ok: true }
}
