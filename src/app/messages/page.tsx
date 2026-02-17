import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { createClient as createServiceClient } from '@supabase/supabase-js'
import { MessagesPageClient } from '@/components/messages/messages-page-client'
import { Button } from '@/components/ui/button'
import { ArrowLeft } from 'lucide-react'

export default async function MessagesPage() {
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

  // Fetch all users with role info for recipient selection
  const { data: usersData } = await supabase
    .from('users')
    .select('id, name, email')
    .order('name')

  // Get role info from auth.users via service role client
  let roleMap: Record<string, string> = {}
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (serviceKey) {
    const adminClient = createServiceClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      serviceKey
    )
    const { data: { users: authUsers } } = await adminClient.auth.admin.listUsers({ perPage: 1000 })
    roleMap = Object.fromEntries(
      authUsers.map(u => [u.id, u.app_metadata?.role || 'applicant'])
    )
  }

  const users = (usersData || [])
    .filter(u => {
      const r = roleMap[u.id]
      return r === 'participant' || r === 'admin'
    })
    .map(u => ({
      ...u,
      role: (roleMap[u.id] || 'participant') as 'participant' | 'admin',
    }))

  // Fetch messages with details
  const { data: messagesData } = await supabase
    .from('messages_with_details')
    .select('*')
    .order('created_at', { ascending: false })

  // Filter and transform to ensure required fields
  const messages = messagesData?.filter(m =>
    m.id && m.subject && m.content && m.author_id && m.created_at
  ).map(m => ({
    id: m.id!,
    subject: m.subject!,
    content: m.content!,
    content_plain: m.content_plain,
    author_id: m.author_id!,
    email_sent: m.email_sent,
    email_sent_at: m.email_sent_at,
    email_recipient_count: m.email_recipient_count,
    created_at: m.created_at,
    updated_at: m.updated_at,
    author_name: m.author_name,
    author_email: m.author_email,
    comment_count: m.comment_count,
    reaction_count: m.reaction_count,
  })) || []

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Navigation */}
        <div className="flex items-center justify-between mb-6">
          <Link href="/admin">
            <Button variant="ghost" size="sm">
              <ArrowLeft className="mr-2 h-4 w-4" />
              Back to Dashboard
            </Button>
          </Link>
        </div>

        <MessagesPageClient
          initialMessages={messages}
          currentUserId={user.id}
          users={users}
        />
      </div>
    </div>
  )
}
