import type { ReactNode } from 'react'
import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { getOpenSurvey, getResponses, getCompletionCount } from '@/lib/survey/store'
import {
  SURVEY_SECTIONS,
  type Question,
  type Choice,
} from '@/lib/survey/questions'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { ArrowLeft } from 'lucide-react'
import { ResultsTabs } from './results-tabs'

type AnswerMap = Record<string, unknown>

// The question whose answer (if any) is the respondent's self-provided name.
const NAME_QUESTION_ID = 'q26_name'

function num(v: unknown): number | null {
  return typeof v === 'number' && Number.isFinite(v) ? v : null
}

function scaleStats(answers: AnswerMap[], id: string) {
  const vals = answers.map((a) => num(a[id])).filter((v): v is number => v !== null)
  if (vals.length === 0) return null
  const avg = vals.reduce((s, v) => s + v, 0) / vals.length
  const dist = new Map<number, number>()
  for (const v of vals) dist.set(v, (dist.get(v) ?? 0) + 1)
  return { avg, count: vals.length, dist }
}

function DistBars({
  dist,
  count,
  values,
}: {
  dist: Map<number, number>
  count: number
  values: number[]
}) {
  const maxCount = Math.max(1, ...values.map((v) => dist.get(v) ?? 0))
  return (
    <div className="space-y-1">
      {values.map((v) => {
        const c = dist.get(v) ?? 0
        return (
          <div key={v} className="flex items-center gap-2 text-xs">
            <span className="w-6 text-right text-gray-500">{v}</span>
            <div className="flex-1 h-4 rounded bg-gray-100 overflow-hidden">
              <div
                className="h-full bg-blue-500"
                style={{ width: `${(c / maxCount) * 100}%` }}
              />
            </div>
            <span className="w-16 text-gray-500">
              {c} ({count > 0 ? Math.round((c / count) * 100) : 0}%)
            </span>
          </div>
        )
      })}
    </div>
  )
}

function CountRows({
  options,
  counts,
  total,
}: {
  options: Choice[]
  counts: Record<string, number>
  total: number
}) {
  const maxCount = Math.max(1, ...options.map((o) => counts[o.value] ?? 0))
  return (
    <div className="space-y-1">
      {options.map((o) => {
        const c = counts[o.value] ?? 0
        return (
          <div key={o.value} className="flex items-center gap-2 text-xs">
            <span className="w-48 truncate text-gray-600" title={o.label}>{o.label}</span>
            <div className="flex-1 h-4 rounded bg-gray-100 overflow-hidden">
              <div className="h-full bg-blue-500" style={{ width: `${(c / maxCount) * 100}%` }} />
            </div>
            <span className="w-16 text-gray-500">
              {c} ({total > 0 ? Math.round((c / total) * 100) : 0}%)
            </span>
          </div>
        )
      })}
    </div>
  )
}

function TextList({ answers, id }: { answers: AnswerMap[]; id: string }) {
  const texts = answers
    .map((a) => a[id])
    .filter((v): v is string => typeof v === 'string' && v.trim().length > 0)
  if (texts.length === 0) {
    return <p className="text-xs text-gray-400 italic">No responses.</p>
  }
  return (
    <ul className="space-y-2">
      {texts.map((t, i) => (
        <li key={i} className="rounded-md border bg-gray-50 px-3 py-2 text-sm text-gray-700">
          {t}
        </li>
      ))}
    </ul>
  )
}

function QuestionResult({ q, answers }: { q: Question; answers: AnswerMap[] }) {
  return (
    <div className="border-b pb-4 last:border-0 last:pb-0">
      <p className="mb-2 text-sm font-medium text-gray-900">
        {q.number && <span className="text-gray-400 mr-1.5">{q.number}.</span>}
        {q.title}
      </p>

      {q.kind === 'scale' && (() => {
        const stats = scaleStats(answers, q.id)
        if (!stats) return <p className="text-xs text-gray-400 italic">No responses.</p>
        const values: number[] = []
        for (let i = q.min; i <= q.max; i++) values.push(i)
        return (
          <div className="space-y-2">
            <p className="text-sm text-gray-600">
              Average <span className="font-semibold text-gray-900">{stats.avg.toFixed(1)}</span>
              <span className="text-gray-400"> / {q.max}</span>
              <span className="text-gray-400"> · {stats.count} responses</span>
            </p>
            <DistBars dist={stats.dist} count={stats.count} values={values} />
          </div>
        )
      })()}

      {(q.kind === 'single' || q.kind === 'multi') && (() => {
        const counts: Record<string, number> = {}
        for (const o of q.options) counts[o.value] = 0
        let total = 0
        for (const a of answers) {
          const v = a[q.id]
          if (q.kind === 'single') {
            if (typeof v === 'string' && v in counts) { counts[v]++; total++ }
          } else {
            if (Array.isArray(v)) {
              let any = false
              for (const item of v) {
                if (typeof item === 'string' && item in counts) { counts[item]++; any = true }
              }
              if (any) total++
            }
          }
        }
        return (
          <div className="space-y-2">
            <p className="text-xs text-gray-400">
              {total} {q.kind === 'multi' ? 'respondents' : 'responses'}
            </p>
            <CountRows options={q.options} counts={counts} total={total} />
          </div>
        )
      })()}

      {q.kind === 'matrix' && (
        <div className="space-y-3">
          {q.rows.map((row) => {
            const key = `${q.id}.${row.value}`
            // Build a per-row answer list from the nested matrix object.
            const rowAnswers: AnswerMap[] = answers.map((a) => {
              const obj = a[q.id]
              const val = obj && typeof obj === 'object' ? (obj as Record<string, unknown>)[row.value] : undefined
              return { [key]: typeof val === 'number' ? val : undefined }
            })
            const stats = scaleStats(rowAnswers, key)
            const naCount = answers.filter((a) => {
              const obj = a[q.id]
              return obj && typeof obj === 'object' && (obj as Record<string, unknown>)[row.value] === 'na'
            }).length
            return (
              <div key={row.value} className="text-sm">
                <div className="flex items-center justify-between">
                  <span className="text-gray-700">{row.label}</span>
                  <span className="text-gray-500">
                    {stats ? (
                      <>avg <span className="font-semibold text-gray-900">{stats.avg.toFixed(1)}</span> ({stats.count})</>
                    ) : (
                      <span className="text-gray-400 italic">no ratings</span>
                    )}
                    {naCount > 0 && <span className="text-gray-400"> · {naCount} N/A</span>}
                  </span>
                </div>
              </div>
            )
          })}
        </div>
      )}

      {q.kind === 'text' && <TextList answers={answers} id={q.id} />}
    </div>
  )
}

// ── Individual responses ──────────────────────────────────────────────

function hasAnswer(value: unknown): boolean {
  if (value === undefined || value === null || value === '') return false
  if (Array.isArray(value)) return value.length > 0
  if (typeof value === 'object') return Object.keys(value as object).length > 0
  return true
}

function Pill({ tone = 'gray', children }: { tone?: 'gray' | 'blue'; children: ReactNode }) {
  return (
    <span
      className={
        'inline-block rounded-md px-2 py-0.5 text-sm font-medium ' +
        (tone === 'blue' ? 'bg-blue-50 text-blue-700' : 'bg-gray-100 text-gray-800')
      }
    >
      {children}
    </span>
  )
}

function Dash() {
  return <span className="text-sm text-gray-300">—</span>
}

/** One respondent's answer to a single question, formatted for scanning. */
function AnswerDisplay({ q, value }: { q: Question; value: unknown }) {
  switch (q.kind) {
    case 'scale': {
      const v = num(value)
      return v === null ? <Dash /> : <Pill tone="blue">{v} / {q.max}</Pill>
    }
    case 'single': {
      if (typeof value !== 'string') return <Dash />
      return <Pill>{q.options.find((o) => o.value === value)?.label ?? value}</Pill>
    }
    case 'multi': {
      if (!Array.isArray(value) || value.length === 0) return <Dash />
      return (
        <div className="flex flex-wrap gap-1.5">
          {value.map((vv) => (
            <Pill key={String(vv)}>{q.options.find((o) => o.value === vv)?.label ?? String(vv)}</Pill>
          ))}
        </div>
      )
    }
    case 'matrix': {
      if (!value || typeof value !== 'object') return <Dash />
      const obj = value as Record<string, unknown>
      const rows = q.rows.filter((row) => obj[row.value] !== undefined)
      if (rows.length === 0) return <Dash />
      return (
        <div className="flex flex-col gap-1.5">
          {rows.map((row) => (
            <div key={row.value} className="flex items-center justify-between gap-3">
              <span className="text-sm text-gray-500">{row.label}</span>
              <Pill tone="blue">{obj[row.value] === 'na' ? 'N/A' : `${obj[row.value]} / ${q.max}`}</Pill>
            </div>
          ))}
        </div>
      )
    }
    case 'text': {
      if (typeof value !== 'string' || !value.trim()) return <Dash />
      return <p className="whitespace-pre-wrap text-sm leading-relaxed text-gray-800">{value}</p>
    }
  }
}

function IndividualResponses({
  responses,
}: {
  responses: { answers: AnswerMap; submitted_at: string }[]
}) {
  // Oldest first, so "Response #1" is stable as new ones arrive.
  const ordered = [...responses].sort((a, b) =>
    a.submitted_at < b.submitted_at ? -1 : 1
  )
  return (
    <div className="space-y-3">
      {ordered.map((r, i) => {
        const rawName = r.answers[NAME_QUESTION_ID]
        const name = typeof rawName === 'string' ? rawName.trim() : ''
        const date = new Date(r.submitted_at).toLocaleDateString('en-US', {
          month: 'short',
          day: 'numeric',
          year: 'numeric',
        })
        return (
          <details key={i} className="overflow-hidden rounded-md border bg-white">
            <summary className="flex cursor-pointer list-none items-center gap-3 px-4 py-3 hover:bg-gray-50">
              <span className="text-sm font-medium text-gray-900">Response #{i + 1}</span>
              {name ? (
                <span className="rounded-full bg-blue-100 px-2 py-0.5 text-xs font-medium text-blue-800">
                  {name}
                </span>
              ) : (
                <span className="text-xs italic text-gray-400">Anonymous</span>
              )}
              <span className="ml-auto text-xs text-gray-400">{date}</span>
            </summary>
            <div className="divide-y divide-gray-100 border-t">
              {SURVEY_SECTIONS.map((section) => {
                const answered = section.questions.filter((q) => hasAnswer(r.answers[q.id]))
                if (answered.length === 0) return null
                return (
                  <div key={section.title} className="px-4 py-4">
                    <p className="mb-3 text-xs font-semibold uppercase tracking-wide text-gray-400">
                      {section.title}
                    </p>
                    <dl className="divide-y divide-gray-100">
                      {answered.map((q) => (
                        <div
                          key={q.id}
                          className="grid grid-cols-1 gap-1 py-2.5 first:pt-0 last:pb-0 sm:grid-cols-2 sm:gap-6"
                        >
                          <dt className="text-sm text-gray-500">
                            {q.number && <span className="text-gray-400">{q.number}. </span>}
                            {q.title}
                          </dt>
                          <dd className="text-gray-900">
                            <AnswerDisplay q={q} value={r.answers[q.id]} />
                          </dd>
                        </div>
                      ))}
                    </dl>
                  </div>
                )
              })}
            </div>
          </details>
        )
      })}
    </div>
  )
}

export default async function AdminSurveyPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) redirect('/login')
  if (user.app_metadata?.role !== 'admin') redirect('/dashboard')

  const survey = await getOpenSurvey()

  if (!survey) {
    return (
      <div className="min-h-screen bg-gray-50">
        <div className="max-w-4xl mx-auto px-4 py-8">
          <Link href="/admin">
            <Button variant="outline" size="sm" className="mb-6">
              <ArrowLeft className="mr-2 h-4 w-4" /> Admin
            </Button>
          </Link>
          <Card>
            <CardContent className="py-12 text-center text-gray-500">
              No survey found. Apply migration 037 to create the survey.
            </CardContent>
          </Card>
        </div>
      </div>
    )
  }

  const [responses, completions] = await Promise.all([
    getResponses(survey.id),
    getCompletionCount(survey.id),
  ])
  const answers: AnswerMap[] = responses.map((r) => r.answers)
  const n = responses.length

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <Link href="/admin">
          <Button variant="outline" size="sm" className="mb-6">
            <ArrowLeft className="mr-2 h-4 w-4" /> Admin
          </Button>
        </Link>

        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900">{survey.event_label || survey.title}</h1>
          <p className="mt-2 text-gray-600">Post-event survey results</p>
        </div>

        <div className="grid grid-cols-2 md:grid-cols-3 gap-4 mb-8">
          <Card>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">Responses</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{n}</div>
            </CardContent>
          </Card>
          <Card>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">Completed by</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{completions}</div>
              <p className="text-xs text-muted-foreground">of ~23 participants</p>
            </CardContent>
          </Card>
          <Card>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">Status</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{survey.is_open ? 'Open' : 'Closed'}</div>
            </CardContent>
          </Card>
        </div>

        {n === 0 ? (
          <Card>
            <CardContent className="py-12 text-center text-gray-500">
              No responses yet.
            </CardContent>
          </Card>
        ) : (
          <ResultsTabs
            responseCount={n}
            summary={
              <div className="space-y-6">
                {SURVEY_SECTIONS.map((section) => (
                  <Card key={section.title}>
                    <CardHeader>
                      <CardTitle className="text-lg">{section.title}</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-4">
                      {section.questions.map((q) => (
                        <QuestionResult key={q.id} q={q} answers={answers} />
                      ))}
                    </CardContent>
                  </Card>
                ))}
              </div>
            }
            individual={<IndividualResponses responses={responses} />}
          />
        )}
      </div>
    </div>
  )
}
