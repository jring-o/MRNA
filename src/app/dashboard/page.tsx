import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'

export default async function DashboardPage() {
  const supabase = await createClient()

  // Get the current user
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Get user role from app_metadata
  const role = user.app_metadata?.role || 'applicant'

  // Get user profile
  const { data: profile } = await supabase
    .from('users')
    .select('*')
    .eq('id', user.id)
    .single()

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
        <div className="bg-white overflow-hidden shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <h1 className="text-2xl font-bold text-gray-900 mb-4">
              Welcome, {profile?.name || user.email}!
            </h1>

            <div className="bg-blue-50 border-l-4 border-blue-400 p-4 mb-6">
              <p className="text-sm text-blue-700">
                Your role: <span className="font-semibold">{role}</span>
              </p>
            </div>

            {role === 'admin' && (
              <div className="space-y-4">
                <h2 className="text-lg font-semibold">Admin Dashboard</h2>
                <p className="text-gray-600">Welcome to the admin dashboard. You can manage applications and workshop content.</p>
                <div className="flex gap-4">
                  <a href="/admin/applications" className="text-workshop-primary hover:text-workshop-accent">
                    Review Applications →
                  </a>
                  <a href="/admin/tasks" className="text-workshop-primary hover:text-workshop-accent">
                    Manage Tasks →
                  </a>
                </div>
              </div>
            )}

            {role === 'participant' && (
              <div className="space-y-4">
                <h2 className="text-lg font-semibold">Participant Dashboard</h2>
                <p className="text-gray-600">Welcome! You've been accepted to the workshop. Resources and collaboration tools will be available here.</p>
                <div className="flex gap-4">
                  <a href="/workshop" className="text-workshop-primary hover:text-workshop-accent">
                    Workshop Hub →
                  </a>
                  <a href="/workshop/rooms" className="text-workshop-primary hover:text-workshop-accent">
                    Breakout Rooms →
                  </a>
                </div>
              </div>
            )}

            {role === 'applicant' && (
              <div className="space-y-4">
                <h2 className="text-lg font-semibold">Applicant Dashboard</h2>
                <p className="text-gray-600">Thank you for your interest in the workshop!</p>

                {/* Check if they have an application */}
                <div className="bg-yellow-50 border-l-4 border-yellow-400 p-4">
                  <p className="text-sm text-yellow-700">
                    Ready to apply? Complete your application to be considered for the workshop.
                  </p>
                  <a href="/apply" className="inline-block mt-2 text-workshop-primary hover:text-workshop-accent font-medium">
                    Start Application →
                  </a>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}