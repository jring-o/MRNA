import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { ParticipantSection } from './participant-section'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'

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

  // Dashboard is only for participants (including admins who are also participants)
  // Applicants should be redirected to apply
  if (role !== 'participant' && role !== 'admin') {
    redirect('/apply')
  }

  // Get user profile
  const { data: profile } = await supabase
    .from('users')
    .select('*')
    .eq('id', user.id)
    .single()

  const initials = profile?.name
    ? profile.name.split(' ').map(n => n[0]).join('').toUpperCase()
    : user.email?.[0].toUpperCase() || 'U'

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-white to-blue-50">
      {/* Header */}
      <div className="bg-white border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            <div className="flex items-center">
              <h1 className="text-xl font-bold bg-gradient-to-r from-blue-600 to-cyan-600 bg-clip-text text-transparent">
                Modular Research Workshop
              </h1>
            </div>
            <div className="flex items-center space-x-4">
              {isAdmin && (
                <Link href="/admin">
                  <Button variant="outline" size="sm">
                    Admin Dash
                  </Button>
                </Link>
              )}
              <Badge variant="secondary">
                Participant {isAdmin && '(Admin)'}
              </Badge>
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
        {/* Participant Dashboard - shown to all participants including admins */}
        <ParticipantSection userId={user.id} userName={profile?.name || 'Participant'} />
      </div>
    </div>
  )
}