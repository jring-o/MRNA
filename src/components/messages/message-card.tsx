'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Card, CardContent, CardHeader } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import { MessageSquare, Mail } from 'lucide-react'
import { ReactionBar } from './reaction-bar'
import { MessageComments } from './message-comments'
import type { MessageReactionType } from '@/types/database'

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

interface Comment {
  id: string
  message_id: string
  author_id: string
  content: string
  created_at: string | null
  edited_at: string | null
  author_name?: string
  author_email?: string
}

interface ReactionCount {
  reaction: MessageReactionType
  count: number
  userReacted: boolean
}

interface MessageCardProps {
  message: MessageWithDetails
  currentUserId: string
}

const ALL_REACTIONS: MessageReactionType[] = [
  'thumbs_up', 'heart', 'party', 'rocket', 'eyes', 'thumbs_down'
]

export function MessageCard({ message, currentUserId }: MessageCardProps) {
  const [comments, setComments] = useState<Comment[]>([])
  const [reactions, setReactions] = useState<ReactionCount[]>(
    ALL_REACTIONS.map(r => ({ reaction: r, count: 0, userReacted: false }))
  )
  const [showComments, setShowComments] = useState(false)
  const [loaded, setLoaded] = useState(false)

  useEffect(() => {
    const loadData = async () => {
      const supabase = createClient()

      // Load reactions
      const { data: reactionsData } = await supabase
        .from('message_reactions')
        .select('*')
        .eq('message_id', message.id)

      if (reactionsData) {
        const reactionCounts: ReactionCount[] = ALL_REACTIONS.map(type => ({
          reaction: type,
          count: reactionsData.filter(r => r.reaction === type).length,
          userReacted: reactionsData.some(r => r.reaction === type && r.user_id === currentUserId),
        }))
        setReactions(reactionCounts)
      }

      // Load comments with author info
      const { data: commentsData } = await supabase
        .from('message_comments')
        .select('*')
        .eq('message_id', message.id)
        .order('created_at', { ascending: true })

      if (commentsData) {
        // Get unique author IDs
        const authorIds = [...new Set(commentsData.map(c => c.author_id))]
        const { data: authors } = await supabase
          .from('users')
          .select('id, name, email')
          .in('id', authorIds)

        const authorsMap = new Map(authors?.map(a => [a.id, a]) || [])
        const enriched = commentsData.map(c => ({
          ...c,
          author_name: authorsMap.get(c.author_id)?.name,
          author_email: authorsMap.get(c.author_id)?.email,
        }))
        setComments(enriched)
      }

      setLoaded(true)
    }

    loadData()
  }, [message.id, currentUserId])

  const initials = message.author_name
    ? message.author_name.split(' ').map(n => n[0]).join('').toUpperCase()
    : '?'

  return (
    <Card>
      <CardHeader className="pb-3">
        <div className="flex items-start gap-3">
          <Avatar className="h-10 w-10">
            <AvatarFallback className="bg-gradient-to-r from-blue-600 to-cyan-600 text-white text-sm">
              {initials}
            </AvatarFallback>
          </Avatar>
          <div className="flex-1 min-w-0">
            <div className="flex items-center gap-2 flex-wrap">
              <span className="font-medium text-gray-900">{message.author_name || 'Unknown'}</span>
              <span className="text-xs text-gray-500">
                {message.created_at && new Date(message.created_at).toLocaleDateString('en-US', {
                  month: 'short',
                  day: 'numeric',
                  year: 'numeric',
                  hour: '2-digit',
                  minute: '2-digit',
                })}
              </span>
              {message.email_sent && (
                <Badge variant="outline" className="text-xs bg-green-50 text-green-700 border-green-200">
                  <Mail className="h-3 w-3 mr-1" />
                  Emailed to {message.email_recipient_count}
                </Badge>
              )}
            </div>
            <h3 className="text-lg font-semibold text-gray-900 mt-1">{message.subject}</h3>
          </div>
        </div>
      </CardHeader>
      <CardContent className="space-y-4">
        <div
          className="prose prose-sm max-w-none"
          dangerouslySetInnerHTML={{ __html: message.content }}
        />

        {loaded && (
          <>
            <ReactionBar
              messageId={message.id}
              currentUserId={currentUserId}
              initialReactions={reactions}
            />

            <div>
              <button
                className="flex items-center gap-1 text-sm text-gray-500 hover:text-gray-700"
                onClick={() => setShowComments(!showComments)}
              >
                <MessageSquare className="h-4 w-4" />
                {comments.length > 0 ? `${comments.length} comment${comments.length !== 1 ? 's' : ''}` : 'Comment'}
              </button>

              {showComments && (
                <div className="mt-3 pt-3 border-t">
                  <MessageComments
                    messageId={message.id}
                    currentUserId={currentUserId}
                    initialComments={comments}
                  />
                </div>
              )}
            </div>
          </>
        )}
      </CardContent>
    </Card>
  )
}
