import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
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

  // Check if user is participant or admin
  const role = user.app_metadata?.role
  if (role !== 'admin' && role !== 'participant') {
    redirect('/dashboard')
  }

  // Check CoC acceptance
  const { data: profile } = await supabase
    .from('users')
    .select('coc_accepted_at')
    .eq('id', user.id)
    .single()

  if (!profile?.coc_accepted_at) {
    redirect('/code-of-conduct')
  }

  // Only fetch the full user list for admins (compose dialog needs it)
  let users: { id: string; name: string; email: string; role: 'participant' | 'admin' }[] = []
  if (role === 'admin') {
    const { data: recipientData } = await supabase.rpc('get_participant_emails')
    users = (recipientData || []).map((r: { user_id: string; name: string; email: string; role: string }) => ({
      id: r.user_id,
      name: r.name,
      email: r.email,
      role: (r.role === 'admin' ? 'admin' : 'participant') as 'participant' | 'admin',
    })).sort((a: { name: string }, b: { name: string }) => a.name.localeCompare(b.name))
  }

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
          <Link href={role === 'admin' ? '/admin' : '/dashboard'}>
            <Button variant="ghost" size="sm">
              <ArrowLeft className="mr-2 h-4 w-4" />
              Back to Dashboard
            </Button>
          </Link>
        </div>

        <MessagesPageClient
          initialMessages={messages}
          currentUserId={user.id}
          currentUserRole={role === 'admin' ? 'admin' : 'participant'}
          users={users}
        />
      </div>
    </div>
  )
}
