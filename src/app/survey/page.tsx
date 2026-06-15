import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { getOpenSurvey, hasCompleted } from '@/lib/survey/store'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { CheckCircle2 } from 'lucide-react'
import { SurveyForm } from './survey-form'

export const metadata = {
  title: 'Post-Event Survey · MIRA',
}

export default async function SurveyPage() {
  const supabase = await createClient()

  const { data: { user } } = await supabase.auth.getUser()
  if (!user) {
    redirect('/login')
  }

  const role = user.app_metadata?.role || 'applicant'
  if (role !== 'participant' && role !== 'admin') {
    redirect('/apply')
  }

  const survey = await getOpenSurvey()

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-white to-blue-50">
      <div className="bg-white border-b">
        <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            <h1 className="text-xl font-bold bg-gradient-to-r from-blue-600 to-cyan-600 bg-clip-text text-transparent">
              MIRA
            </h1>
            <Link href="/dashboard">
              <Button variant="outline" size="sm">Back to dashboard</Button>
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-3xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        {!survey ? (
          <Card>
            <CardContent className="py-12 text-center text-gray-600">
              There&apos;s no survey open right now. Thanks for checking in!
            </CardContent>
          </Card>
        ) : (await hasCompleted(survey.id, user.id)) ? (
          <Card>
            <CardContent className="py-12 text-center space-y-3">
              <CheckCircle2 className="h-12 w-12 text-green-600 mx-auto" />
              <h2 className="text-lg font-semibold text-gray-900">Thank you — your response is in.</h2>
              <p className="text-sm text-gray-600">
                Your feedback was submitted anonymously. We can&apos;t edit a submitted response,
                so if something needs fixing, reach out to{' '}
                <a href="mailto:contact@scios.tech" className="text-blue-600 hover:underline">
                  contact@scios.tech
                </a>.
              </p>
            </CardContent>
          </Card>
        ) : (
          <SurveyForm
            surveyId={survey.id}
            eventLabel={survey.event_label || 'MIRA workshop'}
          />
        )}
      </div>
    </div>
  )
}
