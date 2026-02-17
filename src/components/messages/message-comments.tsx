'use client'

import { useState, useCallback } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { toast } from 'sonner'
import { Send, Pencil, Trash2, Check, X } from 'lucide-react'

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

interface MessageCommentsProps {
  messageId: string
  currentUserId: string
  initialComments: Comment[]
}

function canEditComment(comment: Comment, currentUserId: string): boolean {
  if (comment.author_id !== currentUserId) return false
  if (!comment.created_at) return false
  const createdAt = new Date(comment.created_at)
  const now = new Date()
  const fifteenMinutesInMs = 15 * 60 * 1000
  return (now.getTime() - createdAt.getTime()) < fifteenMinutesInMs
}

export function MessageComments({ messageId, currentUserId, initialComments }: MessageCommentsProps) {
  const [comments, setComments] = useState<Comment[]>(initialComments)
  const [newComment, setNewComment] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [editingId, setEditingId] = useState<string | null>(null)
  const [editContent, setEditContent] = useState('')

  const addComment = useCallback(async () => {
    if (!newComment.trim()) return
    setSubmitting(true)

    const supabase = createClient()
    const { data, error } = await supabase
      .from('message_comments')
      .insert({
        message_id: messageId,
        author_id: currentUserId,
        content: newComment.trim(),
      })
      .select()
      .single()

    if (error) {
      toast.error('Failed to add comment')
      setSubmitting(false)
      return
    }

    // Get author info
    const { data: author } = await supabase
      .from('users')
      .select('name, email')
      .eq('id', currentUserId)
      .single()

    setComments(prev => [...prev, {
      ...data,
      author_name: author?.name,
      author_email: author?.email,
    }])
    setNewComment('')
    setSubmitting(false)
  }, [newComment, messageId, currentUserId])

  const startEdit = (comment: Comment) => {
    setEditingId(comment.id)
    setEditContent(comment.content)
  }

  const saveEdit = async (commentId: string) => {
    if (!editContent.trim()) return

    const supabase = createClient()
    const { error } = await supabase
      .from('message_comments')
      .update({ content: editContent.trim(), edited_at: new Date().toISOString() })
      .eq('id', commentId)

    if (error) {
      toast.error('Failed to update comment')
      return
    }

    setComments(prev =>
      prev.map(c =>
        c.id === commentId
          ? { ...c, content: editContent.trim(), edited_at: new Date().toISOString() }
          : c
      )
    )
    setEditingId(null)
    setEditContent('')
  }

  const deleteComment = async (commentId: string) => {
    const supabase = createClient()
    const { error } = await supabase
      .from('message_comments')
      .delete()
      .eq('id', commentId)

    if (error) {
      toast.error('Failed to delete comment')
      return
    }

    setComments(prev => prev.filter(c => c.id !== commentId))
    toast.success('Comment deleted')
  }

  return (
    <div className="space-y-3">
      {comments.length > 0 && (
        <div className="space-y-2">
          {comments.map(comment => (
            <div key={comment.id} className="flex items-start gap-2 text-sm">
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2">
                  <span className="font-medium text-gray-900">
                    {comment.author_name || 'Unknown'}
                  </span>
                  <span className="text-xs text-gray-500">
                    {comment.created_at && new Date(comment.created_at).toLocaleDateString('en-US', {
                      month: 'short',
                      day: 'numeric',
                      hour: '2-digit',
                      minute: '2-digit',
                    })}
                  </span>
                  {comment.edited_at && (
                    <span className="text-xs text-gray-400">(edited)</span>
                  )}
                </div>

                {editingId === comment.id ? (
                  <div className="flex items-center gap-1 mt-1">
                    <Input
                      value={editContent}
                      onChange={e => setEditContent(e.target.value)}
                      className="h-7 text-sm"
                      onKeyDown={e => {
                        if (e.key === 'Enter') saveEdit(comment.id)
                        if (e.key === 'Escape') setEditingId(null)
                      }}
                    />
                    <Button
                      variant="ghost"
                      size="icon"
                      className="h-7 w-7"
                      onClick={() => saveEdit(comment.id)}
                    >
                      <Check className="h-3 w-3" />
                    </Button>
                    <Button
                      variant="ghost"
                      size="icon"
                      className="h-7 w-7"
                      onClick={() => setEditingId(null)}
                    >
                      <X className="h-3 w-3" />
                    </Button>
                  </div>
                ) : (
                  <p className="text-gray-700">{comment.content}</p>
                )}
              </div>

              {comment.author_id === currentUserId && editingId !== comment.id && (
                <div className="flex items-center gap-1">
                  {canEditComment(comment, currentUserId) && (
                    <Button
                      variant="ghost"
                      size="icon"
                      className="h-6 w-6"
                      onClick={() => startEdit(comment)}
                    >
                      <Pencil className="h-3 w-3" />
                    </Button>
                  )}
                  <Button
                    variant="ghost"
                    size="icon"
                    className="h-6 w-6 text-red-500 hover:text-red-700"
                    onClick={() => deleteComment(comment.id)}
                  >
                    <Trash2 className="h-3 w-3" />
                  </Button>
                </div>
              )}
            </div>
          ))}
        </div>
      )}

      <div className="flex items-center gap-2">
        <Input
          value={newComment}
          onChange={e => setNewComment(e.target.value)}
          placeholder="Add a comment..."
          className="h-8 text-sm"
          onKeyDown={e => {
            if (e.key === 'Enter' && !e.shiftKey) {
              e.preventDefault()
              addComment()
            }
          }}
        />
        <Button
          variant="ghost"
          size="icon"
          className="h-8 w-8"
          onClick={addComment}
          disabled={submitting || !newComment.trim()}
        >
          <Send className="h-4 w-4" />
        </Button>
      </div>
    </div>
  )
}
