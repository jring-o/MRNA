'use client'

import { useState, useCallback } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { PenSquare, MessageSquare } from 'lucide-react'
import { MessageCard } from './message-card'
import { ComposeMessageDialog } from './compose-message-dialog'

interface MessageWithDetails {
  id: string
  subject: string
  content: string
  content_plain: string | null
  author_id: string
  email_sent: boolean | null
  email_sent_at: string | null
  email_recipient_count: number | null
  created_at: string | null
  updated_at: string | null
  author_name: string | null
  author_email: string | null
  comment_count: number | null
  reaction_count: number | null
}

interface UserInfo {
  id: string
  name: string
  email: string
  role: 'participant' | 'admin'
}

interface MessagesPageClientProps {
  initialMessages: MessageWithDetails[]
  currentUserId: string
  users: UserInfo[]
}

export function MessagesPageClient({ initialMessages, currentUserId, users }: MessagesPageClientProps) {
  const [messages, setMessages] = useState<MessageWithDetails[]>(initialMessages)
  const [composeOpen, setComposeOpen] = useState(false)

  const refreshMessages = useCallback(async () => {
    const supabase = createClient()
    const { data } = await supabase
      .from('messages_with_details')
      .select('*')
      .order('created_at', { ascending: false })

    if (data) {
      const filtered = data.filter(m =>
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
      }))
      setMessages(filtered)
    }
  }, [])

  return (
    <div>
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Messages</h1>
          <p className="mt-1 text-gray-600">
            Broadcast messages to all participants
          </p>
        </div>
        <Button onClick={() => setComposeOpen(true)}>
          <PenSquare className="mr-2 h-4 w-4" />
          Compose Message
        </Button>
      </div>

      {/* Messages list */}
      {messages.length === 0 ? (
        <div className="text-center py-12">
          <MessageSquare className="mx-auto h-12 w-12 text-gray-400" />
          <h3 className="mt-4 text-lg font-medium text-gray-900">No messages yet</h3>
          <p className="mt-2 text-gray-500">
            Compose your first message to get started.
          </p>
          <Button className="mt-4" onClick={() => setComposeOpen(true)}>
            <PenSquare className="mr-2 h-4 w-4" />
            Compose Message
          </Button>
        </div>
      ) : (
        <div className="space-y-4">
          {messages.map(message => (
            <MessageCard
              key={message.id}
              message={message}
              currentUserId={currentUserId}
            />
          ))}
        </div>
      )}

      <ComposeMessageDialog
        open={composeOpen}
        onOpenChange={setComposeOpen}
        onMessageSent={refreshMessages}
        users={users}
      />
    </div>
  )
}
