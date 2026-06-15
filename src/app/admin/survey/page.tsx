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

type AnswerMap = Record<string, unknown>

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
        )}
      </div>
    </div>
  )
}
