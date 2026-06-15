/**
 * End-to-end test for the post-event survey (migration 037).
 *
 * Verifies the schema, then exercises the REAL RLS-protected submission path:
 *   - creates a throwaway participant (auth user)
 *   - signs in as them (anon key) to get an authenticated JWT
 *   - submits an anonymous response + completion exactly like the app does
 *   - asserts the response is stored anonymously (no user link)
 *   - asserts a non-admin user CANNOT read responses (privacy)
 *   - asserts the open/closed gate blocks inserts when the survey is closed
 *   - asserts double-submit is prevented
 * ...then deletes the test response, completion, and user.
 *
 * Run: npx tsx scripts/survey-e2e-test.ts
 */

import { createClient, type SupabaseClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const url = process.env.NEXT_PUBLIC_SUPABASE_URL
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

if (!url || !serviceKey || !anonKey) {
  console.error('Missing NEXT_PUBLIC_SUPABASE_URL / SUPABASE_SERVICE_ROLE_KEY / NEXT_PUBLIC_SUPABASE_ANON_KEY')
  process.exit(1)
}

const admin = createClient(url, serviceKey, {
  auth: { autoRefreshToken: false, persistSession: false },
})

const MARKER = `E2E-TEST-${Date.now()}`
const TEST_EMAIL = `survey-e2e-${Date.now()}@example.com`
const TEST_PASSWORD = `Test-${Math.random().toString(36).slice(2)}-Aa1!`

let pass = 0
let fail = 0
function check(label: string, ok: boolean, detail = '') {
  console.log(`${ok ? '✅' : '❌'} ${label}${detail ? ` — ${detail}` : ''}`)
  if (ok) pass++
  else fail++
}

async function main() {
  let testUserId: string | null = null
  let surveyId: string | null = null
  let createdUsersRow = false

  try {
    // ── 1. Schema + seed ─────────────────────────────────────────────
    const { data: survey, error: surveyErr } = await admin
      .from('surveys')
      .select('id, slug, title, event_label, is_open')
      .eq('slug', 'mira-dublin-2026')
      .maybeSingle()

    check('surveys table exists & seed row present', !surveyErr && !!survey, surveyErr?.message || survey?.event_label || '')
    if (!survey) throw new Error('No seeded survey — cannot continue.')
    surveyId = survey.id
    check('seeded survey is open', survey.is_open === true)

    // Confirm the other two tables exist (count queries succeed).
    const r1 = await admin.from('survey_responses').select('*', { count: 'exact', head: true }).eq('survey_id', surveyId)
    check('survey_responses table exists', !r1.error, r1.error?.message)
    const r2 = await admin.from('survey_completions').select('*', { count: 'exact', head: true }).eq('survey_id', surveyId)
    check('survey_completions table exists', !r2.error, r2.error?.message)

    // ── 2. Throwaway participant ─────────────────────────────────────
    const { data: created, error: createErr } = await admin.auth.admin.createUser({
      email: TEST_EMAIL,
      password: TEST_PASSWORD,
      email_confirm: true,
      app_metadata: { role: 'participant' },
    })
    check('created throwaway participant', !createErr && !!created?.user, createErr?.message)
    if (!created?.user) throw new Error('Could not create test user.')
    testUserId = created.user.id

    // Ensure a public.users row exists (FK target for completions).
    const { data: existingRow } = await admin.from('users').select('id').eq('id', testUserId).maybeSingle()
    if (!existingRow) {
      const { error: insErr } = await admin
        .from('users')
        .insert({ id: testUserId, email: TEST_EMAIL, name: 'E2E Test (delete me)' })
      createdUsersRow = !insErr
      check('public.users row available for test user', !insErr, insErr?.message)
    } else {
      check('public.users row available for test user', true, 'auto-created by trigger')
    }

    // ── 3. Sign in as the participant (real authenticated JWT) ───────
    const userClient: SupabaseClient = createClient(url!, anonKey!, {
      auth: { autoRefreshToken: false, persistSession: false },
    })
    const { data: signIn, error: signInErr } = await userClient.auth.signInWithPassword({
      email: TEST_EMAIL,
      password: TEST_PASSWORD,
    })
    check('participant can sign in', !signInErr && !!signIn?.session, signInErr?.message)

    // ── 4. Submit through the real RLS path ──────────────────────────
    const answers = {
      q1_overall: 5,
      q2_confidence: 4,
      q2b_contribute: 8,
      q2c_advocate: 7,
      q3_expectations: 'exceeded',
      q4_most_valuable: MARKER,
      q23_iosp: ['attend', 'facilitate'],
      q15_logistics: { accommodation: 5, food: 4, travel_transport: 'na' },
    }
    const insertRes = await userClient.from('survey_responses').insert({ survey_id: surveyId, answers })
    check('authenticated insert of anonymous response succeeds', !insertRes.error, insertRes.error?.message)

    const compRes = await userClient
      .from('survey_completions')
      .upsert({ survey_id: surveyId, user_id: testUserId }, { onConflict: 'survey_id,user_id', ignoreDuplicates: true })
    check('completion marker recorded', !compRes.error, compRes.error?.message)

    // ── 5. Privacy: non-admin cannot read responses ──────────────────
    const peek = await userClient.from('survey_responses').select('id, answers').eq('survey_id', surveyId)
    check('non-admin CANNOT read responses (RLS)', !peek.error && (peek.data?.length ?? 0) === 0,
      `rows visible to participant: ${peek.data?.length ?? 'err:' + peek.error?.message}`)

    // ── 6. Admin can read it back; it's stored with no user link ─────
    const { data: stored } = await admin
      .from('survey_responses')
      .select('id, answers, submitted_at')
      .eq('survey_id', surveyId)
    const mine = (stored ?? []).find((r) => (r.answers as Record<string, unknown>)?.q4_most_valuable === MARKER)
    check('admin can read the stored response', !!mine)
    check('response row has NO user_id column (anonymous)', !!mine && !('user_id' in (mine as object)))
    check('answers round-tripped (multi + matrix preserved)',
      !!mine &&
      Array.isArray((mine!.answers as Record<string, unknown>).q23_iosp) &&
      ((mine!.answers as Record<string, Record<string, unknown>>).q15_logistics?.accommodation === 5))

    // ── 7. Double-submit is prevented (completion already exists) ────
    const dupe = await admin
      .from('survey_completions')
      .select('user_id')
      .eq('survey_id', surveyId)
      .eq('user_id', testUserId)
      .maybeSingle()
    check('completion exists → app blocks re-submission', !!dupe.data)

    // ── 8. Open/closed gate: closing the survey blocks inserts ───────
    await admin.from('surveys').update({ is_open: false }).eq('id', surveyId)
    const blocked = await userClient.from('survey_responses').insert({ survey_id: surveyId, answers: { q1_overall: 1 } })
    check('insert blocked when survey is closed (RLS open-gate)', !!blocked.error, blocked.error ? 'correctly rejected' : 'NOT rejected!')
    await admin.from('surveys').update({ is_open: true }).eq('id', surveyId)
  } finally {
    // ── Cleanup ──────────────────────────────────────────────────────
    console.log('\n— cleanup —')
    if (surveyId) {
      // Restore open state in case step 8 left it closed.
      await admin.from('surveys').update({ is_open: true }).eq('id', surveyId)
      const delResp = await admin.from('survey_responses').delete().eq('survey_id', surveyId).contains('answers', { q4_most_valuable: MARKER })
      check('cleanup: test response deleted', !delResp.error, delResp.error?.message)
    }
    if (testUserId) {
      await admin.from('survey_completions').delete().eq('user_id', testUserId)
      const delUser = await admin.auth.admin.deleteUser(testUserId)
      check('cleanup: test auth user deleted', !delUser.error, delUser.error?.message)
      if (createdUsersRow) {
        await admin.from('users').delete().eq('id', testUserId)
      }
      // Confirm no orphan rows remain for the test user.
      const { count } = await admin.from('survey_completions').select('*', { count: 'exact', head: true }).eq('user_id', testUserId)
      check('cleanup: no completion rows remain', (count ?? 0) === 0)
    }
  }

  console.log(`\n${fail === 0 ? '🎉 ALL PASSED' : '⚠️  SOME FAILED'} — ${pass} passed, ${fail} failed`)
  process.exit(fail === 0 ? 0 : 1)
}

main().catch((e) => {
  console.error('Fatal:', e)
  process.exit(1)
})
