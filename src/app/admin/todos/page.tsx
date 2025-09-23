import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { AdminTodoList } from '@/components/admin/todo-list'
import { Button } from '@/components/ui/button'
import { ArrowLeft, ClipboardList } from 'lucide-react'

export default async function AdminTodosPage() {
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

  // Fetch initial todos with user info
  const { data: todosData } = await supabase
    .from('admin_todos_with_users')
    .select('*')
    .order('created_at', { ascending: false })

  // Filter and transform todos to ensure required fields are not null
  const todos = todosData?.filter(todo =>
    todo.id &&
    todo.title &&
    todo.status &&
    todo.priority &&
    todo.created_by &&
    todo.created_at &&
    todo.updated_at &&
    todo.creator_name &&
    todo.creator_email
  ).map(todo => ({
    ...todo,
    id: todo.id!,
    title: todo.title!,
    status: todo.status!,
    priority: todo.priority!,
    created_by: todo.created_by!,
    created_at: todo.created_at!,
    updated_at: todo.updated_at!,
    creator_name: todo.creator_name!,
    creator_email: todo.creator_email!,
    comment_count: todo.comment_count || 0
  }))

  // Fetch all admins for assignment dropdown
  // Since role is stored in auth.users, we need to use RPC or just get all users
  // For now, let's get all users since only admins can access this page anyway
  const { data: admins } = await supabase
    .from('users')
    .select('id, name, email')
    .order('name')

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Navigation */}
        <div className="flex items-center justify-between mb-6">
          <Link href="/admin">
            <Button variant="ghost" size="sm">
              <ArrowLeft className="mr-2 h-4 w-4" />
              Back to Dashboard
            </Button>
          </Link>
          <Link href="/admin/applications">
            <Button variant="outline" size="sm">
              <ClipboardList className="mr-2 h-4 w-4" />
              Applications
            </Button>
          </Link>
        </div>

        <AdminTodoList
          initialTodos={todos || []}
          admins={admins || []}
          currentUserId={user.id}
        />
      </div>
    </div>
  )
}