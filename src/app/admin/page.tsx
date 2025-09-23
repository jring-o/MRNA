import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import {
  Users,
  ClipboardList,
  CheckSquare,
  MessageSquare,
  Settings,
  ArrowRight,
  Activity,
} from 'lucide-react'

export default async function AdminDashboardPage() {
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

  // Get quick stats
  const { data: applications } = await supabase
    .from('applications')
    .select('status')

  const { data: todos } = await supabase
    .from('admin_todos')
    .select('status')

  const pendingApplications = applications?.filter(a => a.status === 'pending').length || 0
  const totalApplications = applications?.length || 0
  const pendingTodos = todos?.filter(t => t.status === 'pending' || t.status === 'in_progress').length || 0
  const totalTodos = todos?.length || 0

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Header */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900">Admin Dashboard</h1>
          <p className="mt-2 text-gray-600">
            Welcome back, {user.user_metadata?.name || user.email}
          </p>
        </div>

        {/* Quick Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">
                Pending Applications
              </CardTitle>
              <Users className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{pendingApplications}</div>
              <p className="text-xs text-muted-foreground">
                out of {totalApplications} total
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">
                Active Todos
              </CardTitle>
              <CheckSquare className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{pendingTodos}</div>
              <p className="text-xs text-muted-foreground">
                out of {totalTodos} total
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">
                System Status
              </CardTitle>
              <Activity className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">Active</div>
              <p className="text-xs text-muted-foreground">
                All systems operational
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">
                Admin Team
              </CardTitle>
              <Settings className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">Online</div>
              <p className="text-xs text-muted-foreground">
                Admin access active
              </p>
            </CardContent>
          </Card>
        </div>

        {/* Navigation Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <Card className="hover:shadow-lg transition-shadow">
            <CardHeader>
              <div className="flex items-center justify-between">
                <ClipboardList className="h-8 w-8 text-blue-600" />
                <ArrowRight className="h-5 w-5 text-gray-400" />
              </div>
              <CardTitle className="mt-4">Applications</CardTitle>
              <CardDescription>
                Review and manage workshop applications
              </CardDescription>
            </CardHeader>
            <CardContent>
              <Link href="/admin/applications">
                <Button className="w-full" variant="default">
                  View Applications
                </Button>
              </Link>
            </CardContent>
          </Card>

          <Card className="hover:shadow-lg transition-shadow">
            <CardHeader>
              <div className="flex items-center justify-between">
                <CheckSquare className="h-8 w-8 text-green-600" />
                <ArrowRight className="h-5 w-5 text-gray-400" />
              </div>
              <CardTitle className="mt-4">Todo List</CardTitle>
              <CardDescription>
                Internal task management for the admin team
              </CardDescription>
            </CardHeader>
            <CardContent>
              <Link href="/admin/todos">
                <Button className="w-full" variant="default">
                  View Todos
                </Button>
              </Link>
            </CardContent>
          </Card>

          <Card className="hover:shadow-lg transition-shadow">
            <CardHeader>
              <div className="flex items-center justify-between">
                <MessageSquare className="h-8 w-8 text-purple-600" />
                <ArrowRight className="h-5 w-5 text-gray-400" />
              </div>
              <CardTitle className="mt-4">Comments</CardTitle>
              <CardDescription>
                View recent discussions on applications
              </CardDescription>
            </CardHeader>
            <CardContent>
              <Link href="/admin/applications">
                <Button className="w-full" variant="outline">
                  View Discussions
                </Button>
              </Link>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  )
}