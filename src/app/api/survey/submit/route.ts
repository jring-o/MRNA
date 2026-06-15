import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { getOpenSurvey, submitResponse } from '@/lib/survey/store'
import { ALL_QUESTIONS, REQUIRED_QUESTION_IDS } from '@/lib/survey/questions'

const VALID_IDS = new Set(ALL_QUESTIONS.map((q) => q.id))

// POST: store an anonymous survey response + mark this user as completed.
export async function POST(request: Request) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Only participants and admins can submit.
    const role = user.app_metadata?.role
    if (role !== 'participant' && role !== 'admin') {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }

    const survey = await getOpenSurvey()
    if (!survey) {
      return NextResponse.json({ error: 'No open survey.' }, { status: 404 })
    }

    const body = await request.json().catch(() => null)
    const rawAnswers = body?.answers
    if (!rawAnswers || typeof rawAnswers !== 'object' || Array.isArray(rawAnswers)) {
      return NextResponse.json({ error: 'Invalid answers.' }, { status: 400 })
    }

    // Keep only known question ids; drop empty values.
    const answers: Record<string, unknown> = {}
    for (const [key, value] of Object.entries(rawAnswers as Record<string, unknown>)) {
      if (!VALID_IDS.has(key)) continue
      if (value === null || value === undefined || value === '') continue
      if (Array.isArray(value) && value.length === 0) continue
      answers[key] = value
    }

    // Enforce required questions server-side.
    const missing = REQUIRED_QUESTION_IDS.filter((id) => !(id in answers))
    if (missing.length > 0) {
      return NextResponse.json(
        { error: 'Please answer all required questions.', missing },
        { status: 400 }
      )
    }

    const result = await submitResponse(survey.id, user.id, answers)
    if (!result.ok) {
      return NextResponse.json({ error: result.error }, { status: result.status })
    }

    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('Survey submit error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
