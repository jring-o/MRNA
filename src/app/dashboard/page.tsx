import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { getOpenSurvey, hasCompleted } from '@/lib/survey/store'
import { ParticipantSection } from './participant-section'
import { Button } from '@/components/ui/button'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import { ClipboardList } from 'lucide-react'

export default async function DashboardPage() {
  const supabase = await createClient()

  // Get the current user
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Get user role from app_metadata only (secure, server-controlled)
  const role = user.app_metadata?.role || 'applicant'
  const isAdmin = role === 'admin'

  // Only participants and admins can access the dashboard
  if (role !== 'participant' && role !== 'admin') {
    redirect('/apply')
  }

  // Get user profile
  const { data: profile } = await supabase
    .from('users')
    .select('*')
    .eq('id', user.id)
    .single()

  // Participants must accept the Code of Conduct before accessing the dashboard
  if (!profile?.coc_accepted_at) {
    redirect('/code-of-conduct')
  }

  const initials = profile?.name
    ? profile.name.split(' ').map(n => n[0]).join('').toUpperCase()
    : user.email?.[0].toUpperCase() || 'U'

  // Surface the post-event survey if one is open and the user hasn't responded.
  const openSurvey = await getOpenSurvey()
  const surveyPending = openSurvey ? !(await hasCompleted(openSurvey.id, user.id)) : false

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-white to-blue-50">
      {/* Header */}
      <div className="bg-white border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            <div className="flex items-center">
              <h1 className="text-xl font-bold bg-gradient-to-r from-blue-600 to-cyan-600 bg-clip-text text-transparent">
                MIRA
              </h1>
            </div>
            <div className="flex items-center space-x-4">
              {isAdmin && (
                <>
                  <Link href="/messages">
                    <Button variant="outline" size="sm">
                      Messages
                    </Button>
                  </Link>
                  <Link href="/admin">
                    <Button variant="outline" size="sm">
                      Admin Dash
                    </Button>
                  </Link>
                </>
              )}
              <Avatar>
                <AvatarFallback className="bg-gradient-to-r from-blue-600 to-cyan-600 text-white">
                  {initials}
                </AvatarFallback>
              </Avatar>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        {/* Post-event survey banner */}
        {surveyPending && (
          <div className="mb-6 flex flex-col gap-3 rounded-lg border border-blue-300 bg-blue-50 p-4 sm:flex-row sm:items-center sm:justify-between">
            <div className="flex items-start gap-3">
              <ClipboardList className="mt-0.5 h-5 w-5 text-blue-600" />
              <div>
                <p className="font-medium text-blue-900">The post-event survey is open</p>
                <p className="text-sm text-blue-800">
                  Help shape the next MIRA — it&apos;s anonymous and takes about 5–8 minutes.
                </p>
              </div>
            </div>
            <Link href="/survey">
              <Button>Take the survey</Button>
            </Link>
          </div>
        )}

        {/* Participant Dashboard - shown to all participants including admins */}
        <ParticipantSection userId={user.id} userName={profile?.name || 'Participant'} isAdmin={isAdmin} />
      </div>
    </div>
  )
}