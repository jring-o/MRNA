'use client'

import { useState } from 'react'
import Link from 'next/link'
import { cn } from '@/lib/utils'
import {
  SURVEY_SECTIONS,
  REQUIRED_QUESTION_IDS,
  type Question,
  type ScaleQuestion,
  type SingleQuestion,
  type MultiQuestion,
  type TextQuestion,
  type MatrixQuestion,
} from '@/lib/survey/questions'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Textarea } from '@/components/ui/textarea'
import { Input } from '@/components/ui/input'
import { Checkbox } from '@/components/ui/checkbox'
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group'
import { toast } from 'sonner'
import { Loader2, CheckCircle2 } from 'lucide-react'

type MatrixValue = Record<string, number | 'na'>
type AnswerValue = number | string | string[] | MatrixValue
type Answers = Record<string, AnswerValue>

function range(min: number, max: number): number[] {
  const out: number[] = []
  for (let i = min; i <= max; i++) out.push(i)
  return out
}

function ScaleInput({
  q,
  value,
  onChange,
}: {
  q: ScaleQuestion | MatrixQuestion
  value: number | undefined
  onChange: (v: number | undefined) => void
}) {
  return (
    <div className="w-fit space-y-1">
      <div className="flex flex-wrap gap-2">
        {range(q.min, q.max).map((n) => (
          <button
            type="button"
            key={n}
            // Click the selected value again to clear it.
            onClick={() => onChange(value === n ? undefined : n)}
            aria-pressed={value === n}
            className={cn(
              'h-9 w-9 rounded-md border text-sm font-medium transition-colors',
              value === n
                ? 'border-blue-600 bg-blue-600 text-white'
                : 'border-gray-300 bg-white text-gray-700 hover:bg-gray-50'
            )}
          >
            {n}
          </button>
        ))}
      </div>
      {(q.minLabel || q.maxLabel) && (
        <div className="flex justify-between text-xs text-gray-500">
          <span>{q.minLabel}</span>
          <span>{q.maxLabel}</span>
        </div>
      )}
    </div>
  )
}

function SingleInput({
  q,
  value,
  onChange,
}: {
  q: SingleQuestion
  value: string | undefined
  onChange: (v: string | undefined) => void
}) {
  return (
    <RadioGroup value={value ?? ''} onValueChange={onChange}>
      {q.options.map((o) => {
        const id = `${q.id}-${o.value}`
        const selected = value === o.value
        return (
          <label
            key={o.value}
            htmlFor={id}
            className={cn(
              'flex items-center gap-3 rounded-md border p-3 cursor-pointer transition-colors',
              selected ? 'border-blue-500 bg-blue-50' : 'border-gray-200 hover:bg-gray-50'
            )}
          >
            <RadioGroupItem
              value={o.value}
              id={id}
              // Click the selected option again to clear it (radios don't deselect by default).
              onClick={() => {
                if (selected) onChange(undefined)
              }}
            />
            <span className="text-sm">{o.label}</span>
          </label>
        )
      })}
    </RadioGroup>
  )
}

function MultiInput({
  q,
  value,
  onChange,
}: {
  q: MultiQuestion
  value: string[] | undefined
  onChange: (v: string[]) => void
}) {
  const selected = value ?? []
  return (
    <div className="space-y-2">
      {q.options.map((o) => {
        const checked = selected.includes(o.value)
        return (
          <label
            key={o.value}
            className={cn(
              'flex items-center gap-3 rounded-md border p-3 cursor-pointer transition-colors',
              checked ? 'border-blue-500 bg-blue-50' : 'border-gray-200 hover:bg-gray-50'
            )}
          >
            <Checkbox
              checked={checked}
              onCheckedChange={(c) => {
                if (c) onChange([...selected, o.value])
                else onChange(selected.filter((v) => v !== o.value))
              }}
            />
            <span className="text-sm">{o.label}</span>
          </label>
        )
      })}
    </div>
  )
}

function TextInput({
  q,
  value,
  onChange,
}: {
  q: TextQuestion
  value: string | undefined
  onChange: (v: string) => void
}) {
  if (q.long) {
    return (
      <Textarea
        value={value ?? ''}
        onChange={(e) => onChange(e.target.value)}
        placeholder={q.placeholder}
        rows={3}
      />
    )
  }
  return (
    <Input
      value={value ?? ''}
      onChange={(e) => onChange(e.target.value)}
      placeholder={q.placeholder}
    />
  )
}

function MatrixInput({
  q,
  value,
  onChange,
}: {
  q: MatrixQuestion
  value: MatrixValue | undefined
  onChange: (v: MatrixValue | undefined) => void
}) {
  const current = value ?? {}
  const setRow = (rowId: string, v: number | 'na') => {
    const next = { ...current }
    // Click the same rating again to clear that row.
    if (next[rowId] === v) delete next[rowId]
    else next[rowId] = v
    onChange(Object.keys(next).length > 0 ? next : undefined)
  }
  const scale = range(q.min, q.max)
  // The anchor row and every option row share these grid columns, so the scale
  // labels and the buttons line up by construction — no margin math.
  const gridCols = `minmax(7rem,1fr) repeat(${scale.length}, 2.5rem)${q.allowNA ? ' 3rem' : ''}`
  const hasAnchors = !!(q.minLabel || q.maxLabel)

  return (
    <div className="overflow-x-auto">
      <div className="min-w-[20rem] rounded-md border">
        {/* Verbal anchors spanning exactly the scale columns */}
        {hasAnchors && (
          <div
            className="grid gap-x-2 border-b bg-gray-50/60 px-3 py-2 text-xs text-gray-500"
            style={{ gridTemplateColumns: gridCols }}
          >
            <span />
            <div
              className="flex justify-between"
              style={{ gridColumn: `span ${scale.length}` }}
            >
              <span>{q.minLabel}</span>
              <span>{q.maxLabel}</span>
            </div>
            {q.allowNA && <span />}
          </div>
        )}

        <div className="divide-y">
          {q.rows.map((row) => {
            const rowVal = current[row.value]
            return (
              <div
                key={row.value}
                className="grid items-center gap-x-2 px-3 py-3"
                style={{ gridTemplateColumns: gridCols }}
              >
                <span className="pr-2 text-sm">{row.label}</span>
                {scale.map((n) => (
                  <div key={n} className="flex justify-center">
                    <button
                      type="button"
                      onClick={() => setRow(row.value, n)}
                      aria-label={`${row.label}: ${n}`}
                      aria-pressed={rowVal === n}
                      className={cn(
                        'h-8 w-8 rounded-md border text-sm font-medium transition-colors',
                        rowVal === n
                          ? 'border-blue-600 bg-blue-600 text-white'
                          : 'border-gray-300 bg-white text-gray-700 hover:bg-gray-50'
                      )}
                    >
                      {n}
                    </button>
                  </div>
                ))}
                {q.allowNA && (
                  <div className="flex justify-center">
                    <button
                      type="button"
                      onClick={() => setRow(row.value, 'na')}
                      aria-label={`${row.label}: N/A`}
                      aria-pressed={rowVal === 'na'}
                      className={cn(
                        'h-8 w-12 rounded-md border text-xs font-medium transition-colors',
                        rowVal === 'na'
                          ? 'border-gray-600 bg-gray-600 text-white'
                          : 'border-gray-300 bg-white text-gray-500 hover:bg-gray-50'
                      )}
                    >
                      N/A
                    </button>
                  </div>
                )}
              </div>
            )
          })}
        </div>
      </div>
    </div>
  )
}

function QuestionField({
  q,
  value,
  onChange,
  error,
}: {
  q: Question
  value: AnswerValue | undefined
  onChange: (v: AnswerValue | undefined) => void
  error: boolean
}) {
  return (
    <div className={cn('rounded-lg p-4 -mx-1', error && 'ring-1 ring-red-400 bg-red-50/40')}>
      <div className="mb-3">
        <p className="text-sm font-medium text-gray-900">
          {q.number && <span className="text-gray-400 mr-1.5">{q.number}.</span>}
          {q.title}
          {!q.optional && <span className="text-red-500 ml-1">*</span>}
        </p>
        {q.help && <p className="mt-1 text-xs text-gray-500">{q.help}</p>}
        {q.helpLink && (
          <a
            href={q.helpLink.href}
            target="_blank"
            rel="noopener noreferrer"
            className="mt-1 inline-block text-xs text-blue-600 hover:underline"
          >
            {q.helpLink.text}
          </a>
        )}
      </div>

      {q.kind === 'scale' && (
        <ScaleInput q={q} value={value as number | undefined} onChange={(v) => onChange(v)} />
      )}
      {q.kind === 'single' && (
        <SingleInput q={q} value={value as string | undefined} onChange={(v) => onChange(v)} />
      )}
      {q.kind === 'multi' && (
        <MultiInput q={q} value={value as string[] | undefined} onChange={(v) => onChange(v)} />
      )}
      {q.kind === 'text' && (
        <TextInput q={q} value={value as string | undefined} onChange={(v) => onChange(v)} />
      )}
      {q.kind === 'matrix' && (
        <MatrixInput q={q} value={value as MatrixValue | undefined} onChange={(v) => onChange(v)} />
      )}

      {error && <p className="mt-2 text-xs text-red-600">This question is required.</p>}
    </div>
  )
}

export function SurveyForm({
  surveyId,
  eventLabel,
}: {
  surveyId: string
  eventLabel: string
}) {
  const [answers, setAnswers] = useState<Answers>({})
  const [errors, setErrors] = useState<Set<string>>(new Set())
  const [submitting, setSubmitting] = useState(false)
  const [submitted, setSubmitted] = useState(false)

  const setAnswer = (id: string, value: AnswerValue | undefined) => {
    setAnswers((prev) => {
      if (value === undefined) {
        const next = { ...prev }
        delete next[id]
        return next
      }
      return { ...prev, [id]: value }
    })
    // Clear any "required" error once a value is actually set (not on clear).
    if (value !== undefined && errors.has(id)) {
      setErrors((prev) => {
        const next = new Set(prev)
        next.delete(id)
        return next
      })
    }
  }

  const isEmpty = (v: AnswerValue | undefined): boolean => {
    if (v === undefined || v === null || v === '') return true
    if (Array.isArray(v) && v.length === 0) return true
    return false
  }

  const handleSubmit = async () => {
    const missing = REQUIRED_QUESTION_IDS.filter((id) => isEmpty(answers[id]))
    if (missing.length > 0) {
      setErrors(new Set(missing))
      toast.error('Please answer all required questions.')
      const el = document.getElementById(`q-${missing[0]}`)
      el?.scrollIntoView({ behavior: 'smooth', block: 'center' })
      return
    }

    setSubmitting(true)
    try {
      const res = await fetch('/api/survey/submit', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ surveyId, answers }),
      })
      if (!res.ok) {
        const data = await res.json().catch(() => ({}))
        throw new Error(data.error || 'Failed to submit')
      }
      setSubmitted(true)
      window.scrollTo({ top: 0, behavior: 'smooth' })
    } catch (err) {
      console.error('Survey submit failed:', err)
      toast.error(err instanceof Error ? err.message : 'Failed to submit survey')
    } finally {
      setSubmitting(false)
    }
  }

  if (submitted) {
    return (
      <Card>
        <CardContent className="py-12 text-center space-y-3">
          <CheckCircle2 className="h-12 w-12 text-green-600 mx-auto" />
          <h2 className="text-lg font-semibold text-gray-900">Thank you!</h2>
          <p className="text-sm text-gray-600">
            Your response was submitted anonymously. We really appreciate it.
          </p>
          <Link href="/dashboard">
            <Button variant="outline" className="mt-2">Back to dashboard</Button>
          </Link>
        </CardContent>
      </Card>
    )
  }

  return (
    <div className="space-y-6">
      <div className="rounded-lg border border-blue-200 bg-gradient-to-r from-blue-50 to-indigo-50 p-6">
        <h2 className="text-2xl font-semibold text-gray-900">{eventLabel} — Post-Event Survey</h2>
        <p className="mt-2 text-sm text-gray-600">
          Your responses are <strong>anonymous</strong>. This takes about 5–8 minutes. Questions
          marked <span className="text-red-500">*</span> are required; everything else is optional.
        </p>
      </div>

      {SURVEY_SECTIONS.map((section) => (
        <Card key={section.title}>
          <CardHeader>
            <CardTitle className="text-lg">{section.title}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-2">
            {section.questions.map((q) => (
              <div key={q.id} id={`q-${q.id}`}>
                <QuestionField
                  q={q}
                  value={answers[q.id]}
                  onChange={(v) => setAnswer(q.id, v)}
                  error={errors.has(q.id)}
                />
              </div>
            ))}
          </CardContent>
        </Card>
      ))}

      <div className="flex items-center justify-between gap-4 pb-12">
        <p className="text-xs text-gray-500">
          You can only submit once, and responses can&apos;t be edited afterward.
        </p>
        <Button onClick={handleSubmit} disabled={submitting} size="lg">
          {submitting ? (
            <>
              <Loader2 className="mr-2 h-4 w-4 animate-spin" />
              Submitting…
            </>
          ) : (
            'Submit survey'
          )}
        </Button>
      </div>
    </div>
  )
}
