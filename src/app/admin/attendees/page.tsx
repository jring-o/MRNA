import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { AttendeesTable } from './attendees-table'
import { Button } from '@/components/ui/button'
import { ArrowLeft, Users } from 'lucide-react'

export default async function AdminAttendeesPage() {
  const supabase = await createClient()

  // Check if user is authenticated
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Check if user is admin
  const role = user.app_metadata?.role
  if (role !== 'admin') {
    redirect('/dashboard')
  }

  // Fetch only accepted applications
  const { data: attendees, error } = await supabase
    .from('applications')
    .select('*')
    .eq('status', 'accepted')
    .order('name', { ascending: true })

  if (error) {
    console.error('Error fetching attendees:', error)
  }

  // Get invite tokens to check who has been sent emails
  const attendeeIds = attendees?.map(a => a.id) || []
  const { data: tokens } = await supabase
    .from('invite_tokens')
    .select('application_id, used')
    .in('application_id', attendeeIds.length > 0 ? attendeeIds : [''])

  // Create a map of application_id -> token info
  const tokenMap = new Map<string, { sent: boolean; used: boolean }>()
  tokens?.forEach(token => {
    if (token.application_id) {
      tokenMap.set(token.application_id, { sent: true, used: token.used || false })
    }
  })

  // Calculate stats
  const stats = {
    total: attendees?.length || 0,
    emailsSent: tokenMap.size,
    accountsCreated: attendees?.filter(a => a.user_id !== null).length || 0,
  }

  // Enrich attendees with token info
  const enrichedAttendees = attendees?.map(attendee => ({
    ...attendee,
    emailSent: tokenMap.has(attendee.id),
    accountCreated: attendee.user_id !== null,
  })) || []

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Header with Navigation */}
        <div className="mb-8">
          <div className="flex items-center justify-between mb-4">
            <Link href="/admin">
              <Button variant="ghost" size="sm">
                <ArrowLeft className="mr-2 h-4 w-4" />
                Back to Dashboard
              </Button>
            </Link>
            <Link href="/admin/applications">
              <Button variant="outline" size="sm">
                View All Applications
              </Button>
            </Link>
          </div>
          <div className="flex items-center gap-3">
            <Users className="h-8 w-8 text-green-600" />
            <div>
              <h1 className="text-3xl font-bold text-gray-900">Attendees</h1>
              <p className="mt-1 text-gray-600">
                Manage accepted workshop participants
              </p>
            </div>
          </div>
        </div>

        {/* Statistics Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
          <div className="bg-white rounded-lg shadow p-6 border-l-4 border-green-500">
            <div className="text-sm font-medium text-gray-500">Total Accepted</div>
            <div className="mt-1 text-3xl font-bold text-green-600">{stats.total}</div>
          </div>
          <div className="bg-white rounded-lg shadow p-6 border-l-4 border-blue-500">
            <div className="text-sm font-medium text-gray-500">Emails Sent</div>
            <div className="mt-1 text-3xl font-bold text-blue-600">{stats.emailsSent}</div>
            <div className="text-xs text-gray-400 mt-1">
              {stats.total - stats.emailsSent} pending
            </div>
          </div>
          <div className="bg-white rounded-lg shadow p-6 border-l-4 border-purple-500">
            <div className="text-sm font-medium text-gray-500">Accounts Created</div>
            <div className="mt-1 text-3xl font-bold text-purple-600">{stats.accountsCreated}</div>
            <div className="text-xs text-gray-400 mt-1">
              {stats.total - stats.accountsCreated} not yet registered
            </div>
          </div>
        </div>

        {/* Attendees Table */}
        <AttendeesTable attendees={enrichedAttendees} />
      </div>
    </div>
  )
}
