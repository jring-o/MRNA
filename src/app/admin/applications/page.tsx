import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { ApplicationsTable } from './applications-table'
import { Button } from '@/components/ui/button'
import { ArrowLeft, CheckSquare } from 'lucide-react'

export default async function AdminApplicationsPage() {
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

  // Fetch all applications (with optional user data if account exists)
  const { data: applications, error } = await supabase
    .from('applications')
    .select('*')
    .order('submitted_at', { ascending: false })

  if (error) {
    console.error('Error fetching applications:', error)
  }

  // Get application statistics
  const stats = {
    total: applications?.length || 0,
    pending: applications?.filter(app => app.status === 'pending').length || 0,
    accepted: applications?.filter(app => app.status === 'accepted').length || 0,
    rejected: applications?.filter(app => app.status === 'rejected').length || 0,
    waitlisted: applications?.filter(app => app.status === 'waitlisted').length || 0,
  }

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
            <Link href="/admin/todos">
              <Button variant="outline" size="sm">
                <CheckSquare className="mr-2 h-4 w-4" />
                Admin Todos
              </Button>
            </Link>
          </div>
          <h1 className="text-3xl font-bold text-gray-900">Application Management</h1>
          <p className="mt-2 text-gray-600">
            Review and manage workshop applications
          </p>
        </div>

        {/* Statistics Cards */}
        <div className="grid grid-cols-1 md:grid-cols-5 gap-4 mb-8">
          <div className="bg-white rounded-lg shadow p-6">
            <div className="text-sm font-medium text-gray-500">Total</div>
            <div className="mt-1 text-3xl font-bold text-gray-900">{stats.total}</div>
          </div>
          <div className="bg-white rounded-lg shadow p-6">
            <div className="text-sm font-medium text-yellow-600">Pending</div>
            <div className="mt-1 text-3xl font-bold text-yellow-600">{stats.pending}</div>
          </div>
          <div className="bg-white rounded-lg shadow p-6">
            <div className="text-sm font-medium text-green-600">Accepted</div>
            <div className="mt-1 text-3xl font-bold text-green-600">{stats.accepted}</div>
          </div>
          <div className="bg-white rounded-lg shadow p-6">
            <div className="text-sm font-medium text-red-600">Rejected</div>
            <div className="mt-1 text-3xl font-bold text-red-600">{stats.rejected}</div>
          </div>
          <div className="bg-white rounded-lg shadow p-6">
            <div className="text-sm font-medium text-blue-600">Waitlisted</div>
            <div className="mt-1 text-3xl font-bold text-blue-600">{stats.waitlisted}</div>
          </div>
        </div>

        {/* Applications Table */}
        <ApplicationsTable initialApplications={applications || []} />
      </div>
    </div>
  )
}