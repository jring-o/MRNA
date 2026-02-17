'use client'

import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import type { MessageReactionType } from '@/types/database'

const REACTIONS: { type: MessageReactionType; emoji: string }[] = [
  { type: 'thumbs_up', emoji: '\uD83D\uDC4D' },
  { type: 'heart', emoji: '\u2764\uFE0F' },
  { type: 'party', emoji: '\uD83C\uDF89' },
  { type: 'rocket', emoji: '\uD83D\uDE80' },
  { type: 'eyes', emoji: '\uD83D\uDC40' },
  { type: 'thumbs_down', emoji: '\uD83D\uDC4E' },
]

interface ReactionCount {
  reaction: MessageReactionType
  count: number
  userReacted: boolean
}

interface ReactionBarProps {
  messageId: string
  currentUserId: string
  initialReactions: ReactionCount[]
}

export function ReactionBar({ messageId, currentUserId, initialReactions }: ReactionBarProps) {
  const [reactions, setReactions] = useState<ReactionCount[]>(initialReactions)
  const [loading, setLoading] = useState<string | null>(null)

  const toggleReaction = async (reactionType: MessageReactionType) => {
    setLoading(reactionType)
    const supabase = createClient()
    const existing = reactions.find(r => r.reaction === reactionType)
    const userReacted = existing?.userReacted || false

    // Optimistic update
    setReactions(prev =>
      prev.map(r =>
        r.reaction === reactionType
          ? { ...r, count: userReacted ? r.count - 1 : r.count + 1, userReacted: !userReacted }
          : r
      )
    )

    try {
      if (userReacted) {
        await supabase
          .from('message_reactions')
          .delete()
          .eq('message_id', messageId)
          .eq('user_id', currentUserId)
          .eq('reaction', reactionType)
      } else {
        await supabase
          .from('message_reactions')
          .insert({
            message_id: messageId,
            user_id: currentUserId,
            reaction: reactionType,
          })
      }
    } catch {
      // Revert on error
      setReactions(prev =>
        prev.map(r =>
          r.reaction === reactionType
            ? { ...r, count: userReacted ? r.count + 1 : r.count - 1, userReacted: userReacted }
            : r
        )
      )
    } finally {
      setLoading(null)
    }
  }

  return (
    <div className="flex flex-wrap gap-1">
      {REACTIONS.map(({ type, emoji }) => {
        const reactionData = reactions.find(r => r.reaction === type)
        const count = reactionData?.count || 0
        const userReacted = reactionData?.userReacted || false

        return (
          <Button
            key={type}
            variant={userReacted ? 'default' : 'outline'}
            size="sm"
            className={`h-8 px-2 text-sm ${
              userReacted ? 'bg-blue-100 text-blue-800 hover:bg-blue-200 border-blue-300' : ''
            }`}
            onClick={() => toggleReaction(type)}
            disabled={loading === type}
          >
            {emoji} {count > 0 && <span className="ml-1">{count}</span>}
          </Button>
        )
      })}
    </div>
  )
}
