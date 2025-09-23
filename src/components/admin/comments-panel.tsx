'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import { Textarea } from '@/components/ui/textarea'
import { Checkbox } from '@/components/ui/checkbox'
import { Alert, AlertDescription } from '@/components/ui/alert'
import { Separator } from '@/components/ui/separator'
import { toast } from 'sonner'
import {
  MessageSquare,
  Reply,
  Edit,
  Trash2,
  Save,
  X,
  Eye,
  EyeOff,
  ChevronDown,
  ChevronUp,
  MoreVertical,
} from 'lucide-react'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu'
import type { ApplicationComment } from '@/types/database'
import { canEditComment } from '@/types/database'

interface CommentsPanelProps {
  applicationId: string
  currentUserId: string
  isApplicantView?: boolean // For showing comments to applicants (non-internal only)
  onCommentAdded?: () => void
}

interface CommentWithReplies extends ApplicationComment {
  replies: CommentWithReplies[]
}

export function CommentsPanel({
  applicationId,
  currentUserId,
  isApplicantView = false,
  onCommentAdded,
}: CommentsPanelProps) {
  const [comments, setComments] = useState<CommentWithReplies[]>([])
  const [newComment, setNewComment] = useState('')
  const [isInternal, setIsInternal] = useState(true)
  const [replyingTo, setReplyingTo] = useState<string | null>(null)
  const [editingComment, setEditingComment] = useState<string | null>(null)
  const [editContent, setEditContent] = useState('')
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [expandedThreads, setExpandedThreads] = useState<Set<string>>(new Set())

  const supabase = createClient()

  useEffect(() => {
    loadComments()

    // Subscribe to realtime updates
    const channel = supabase
      .channel(`comments:${applicationId}`)
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'application_comments',
          filter: `application_id=eq.${applicationId}`,
        },
        () => {
          loadComments()
        }
      )
      .subscribe()

    return () => {
      supabase.removeChannel(channel)
    }
  }, [applicationId])

  const loadComments = async () => {
    // Get all comments for this application
    const { data, error } = await supabase
      .from('application_comments')
      .select(`
        *,
        author:users!author_id(id, name, email, profile_image_url)
      `)
      .eq('application_id', applicationId)
      .order('created_at', { ascending: false })

    if (error) {
      console.error('Error loading comments:', error)
      return
    }

    // Filter comments based on view type
    let filteredComments = data || []
    if (isApplicantView) {
      filteredComments = filteredComments.filter(c => !c.is_internal && !c.deleted_at)
    }

    // Build comment tree structure
    const commentMap = new Map<string, CommentWithReplies>()
    const rootComments: CommentWithReplies[] = []

    // First pass: create all comments
    filteredComments.forEach(comment => {
      commentMap.set(comment.id, {
        ...comment,
        is_internal: comment.is_internal ?? false,
        created_at: comment.created_at ?? new Date().toISOString(),
        replies: []
      })
    })

    // Second pass: build tree
    filteredComments.forEach(comment => {
      const commentWithReplies = commentMap.get(comment.id)!
      if (comment.parent_id) {
        const parent = commentMap.get(comment.parent_id)
        if (parent) {
          parent.replies.push(commentWithReplies)
        }
      } else {
        rootComments.push(commentWithReplies)
      }
    })

    // Sort replies by creation date (oldest first for chronological order)
    const sortReplies = (comments: CommentWithReplies[]) => {
      comments.forEach(comment => {
        comment.replies.sort((a, b) => {
          const dateA = a.created_at ? new Date(a.created_at).getTime() : 0
          const dateB = b.created_at ? new Date(b.created_at).getTime() : 0
          return dateA - dateB
        })
        sortReplies(comment.replies)
      })
    }
    sortReplies(rootComments)

    setComments(rootComments)
  }

  const submitComment = async (parentId: string | null = null) => {
    const content = parentId ? newComment : newComment
    if (!content.trim()) return

    setIsSubmitting(true)

    try {
      const { error } = await supabase
        .from('application_comments')
        .insert({
          application_id: applicationId,
          author_id: currentUserId,
          content: content.trim(),
          parent_id: parentId,
          is_internal: isApplicantView ? false : isInternal,
        })

      if (error) throw error

      toast.success('Comment added')
      setNewComment('')
      setReplyingTo(null)

      // Immediately refresh comments list
      await loadComments()

      if (onCommentAdded) {
        onCommentAdded()
      }
    } catch (error) {
      console.error('Error adding comment:', error)
      toast.error('Failed to add comment')
    } finally {
      setIsSubmitting(false)
    }
  }

  const updateComment = async (commentId: string) => {
    if (!editContent.trim()) return

    setIsSubmitting(true)

    try {
      const { error } = await supabase
        .from('application_comments')
        .update({
          content: editContent.trim(),
          edited_at: new Date().toISOString(),
        })
        .eq('id', commentId)

      if (error) throw error

      toast.success('Comment updated')
      setEditingComment(null)
      setEditContent('')

      // Immediately refresh comments list
      await loadComments()
    } catch (error) {
      console.error('Error updating comment:', error)
      toast.error('Failed to update comment')
    } finally {
      setIsSubmitting(false)
    }
  }

  const deleteComment = async (commentId: string) => {
    if (!confirm('Are you sure you want to delete this comment?')) return

    setIsSubmitting(true)

    try {
      const { error } = await supabase
        .from('application_comments')
        .update({
          deleted_at: new Date().toISOString(),
        })
        .eq('id', commentId)

      if (error) throw error

      toast.success('Comment deleted')

      // Immediately refresh comments list
      await loadComments()
    } catch (error) {
      console.error('Error deleting comment:', error)
      toast.error('Failed to delete comment')
    } finally {
      setIsSubmitting(false)
    }
  }

  const toggleThread = (commentId: string) => {
    const newExpanded = new Set(expandedThreads)
    if (newExpanded.has(commentId)) {
      newExpanded.delete(commentId)
    } else {
      newExpanded.add(commentId)
    }
    setExpandedThreads(newExpanded)
  }

  const renderComment = (comment: CommentWithReplies, depth: number = 0) => {
    if (comment.deleted_at) {
      return (
        <div
          key={comment.id}
          className={`${depth > 0 ? 'ml-12' : ''} p-3 bg-gray-50 rounded-lg text-sm text-gray-500 italic`}
        >
          [Comment deleted]
        </div>
      )
    }

    const isAuthor = comment.author_id === currentUserId
    const canEdit = isAuthor && canEditComment(comment) && !isApplicantView
    const canDelete = isAuthor && !isApplicantView
    const hasReplies = comment.replies.length > 0
    const isExpanded = expandedThreads.has(comment.id)
    const isEditing = editingComment === comment.id

    return (
      <div key={comment.id} className={`${depth > 0 ? 'ml-12' : ''}`}>
        <div className="flex items-start space-x-3 p-3 bg-white border rounded-lg hover:shadow-sm transition-shadow">
          <Avatar className="h-8 w-8">
            <AvatarFallback>
              {comment.author?.name?.substring(0, 2).toUpperCase() || 'UN'}
            </AvatarFallback>
          </Avatar>

          <div className="flex-1 min-w-0">
            {/* Comment Header */}
            <div className="flex items-start justify-between">
              <div>
                <div className="flex items-center space-x-2">
                  <span className="text-sm font-medium">{comment.author?.name || 'Unknown'}</span>
                  {comment.is_internal && !isApplicantView && (
                    <Badge variant="outline" className="text-xs">
                      <EyeOff className="mr-1 h-3 w-3" />
                      Internal
                    </Badge>
                  )}
                  <span className="text-xs text-gray-500">
                    {comment.created_at ? new Date(comment.created_at).toLocaleString() : 'Unknown date'}
                  </span>
                  {comment.edited_at && (
                    <span className="text-xs text-gray-400">(edited)</span>
                  )}
                </div>
              </div>

              {/* Actions Menu */}
              {!isApplicantView && (
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" size="sm" className="h-6 w-6 p-0">
                      <MoreVertical className="h-4 w-4" />
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent align="end">
                    <DropdownMenuItem onClick={() => {
                      setReplyingTo(comment.id)
                      setNewComment('')
                    }}>
                      <Reply className="mr-2 h-4 w-4" />
                      Reply
                    </DropdownMenuItem>
                    {canEdit && (
                      <DropdownMenuItem onClick={() => {
                        setEditingComment(comment.id)
                        setEditContent(comment.content)
                      }}>
                        <Edit className="mr-2 h-4 w-4" />
                        Edit
                      </DropdownMenuItem>
                    )}
                    {canDelete && (
                      <DropdownMenuItem
                        onClick={() => deleteComment(comment.id)}
                        className="text-red-600"
                      >
                        <Trash2 className="mr-2 h-4 w-4" />
                        Delete
                      </DropdownMenuItem>
                    )}
                  </DropdownMenuContent>
                </DropdownMenu>
              )}
            </div>

            {/* Comment Content */}
            {isEditing ? (
              <div className="mt-2 space-y-2">
                <Textarea
                  value={editContent}
                  onChange={(e) => setEditContent(e.target.value)}
                  className="min-h-[60px]"
                  autoFocus
                />
                <div className="flex gap-2">
                  <Button
                    size="sm"
                    onClick={() => updateComment(comment.id)}
                    disabled={isSubmitting || !editContent.trim()}
                  >
                    <Save className="mr-2 h-3 w-3" />
                    Save
                  </Button>
                  <Button
                    size="sm"
                    variant="outline"
                    onClick={() => {
                      setEditingComment(null)
                      setEditContent('')
                    }}
                  >
                    <X className="mr-2 h-3 w-3" />
                    Cancel
                  </Button>
                </div>
              </div>
            ) : (
              <p className="mt-1 text-sm text-gray-700 whitespace-pre-wrap">{comment.content}</p>
            )}

            {/* Thread Toggle */}
            {hasReplies && (
              <button
                onClick={() => toggleThread(comment.id)}
                className="mt-2 flex items-center text-xs text-blue-600 hover:text-blue-700"
              >
                {isExpanded ? (
                  <>
                    <ChevronUp className="mr-1 h-3 w-3" />
                    Hide {comment.replies.length} {comment.replies.length === 1 ? 'reply' : 'replies'}
                  </>
                ) : (
                  <>
                    <ChevronDown className="mr-1 h-3 w-3" />
                    Show {comment.replies.length} {comment.replies.length === 1 ? 'reply' : 'replies'}
                  </>
                )}
              </button>
            )}
          </div>
        </div>

        {/* Reply Form */}
        {replyingTo === comment.id && !isApplicantView && (
          <div className="ml-12 mt-2 p-3 bg-blue-50 border border-blue-200 rounded-lg">
            <div className="space-y-2">
              <Textarea
                value={newComment}
                onChange={(e) => setNewComment(e.target.value)}
                placeholder="Type your reply..."
                className="min-h-[60px]"
                autoFocus
              />
              <div className="flex gap-2">
                <Button
                  size="sm"
                  onClick={() => submitComment(comment.id)}
                  disabled={isSubmitting || !newComment.trim()}
                >
                  <Reply className="mr-2 h-3 w-3" />
                  Reply
                </Button>
                <Button
                  size="sm"
                  variant="outline"
                  onClick={() => {
                    setReplyingTo(null)
                    setNewComment('')
                  }}
                >
                  Cancel
                </Button>
              </div>
            </div>
          </div>
        )}

        {/* Render Replies */}
        {hasReplies && isExpanded && (
          <div className="mt-2 space-y-2">
            {comment.replies.map(reply => renderComment(reply, depth + 1))}
          </div>
        )}
      </div>
    )
  }

  return (
    <Card>
      <CardHeader>
        <div className="flex items-center justify-between">
          <CardTitle className="flex items-center">
            <MessageSquare className="mr-2 h-5 w-5" />
            {isApplicantView ? 'Comments' : 'Discussion & Comments'}
          </CardTitle>
          <Badge variant="outline">
            {comments.length} {comments.length === 1 ? 'thread' : 'threads'}
          </Badge>
        </div>
        <CardDescription>
          {isApplicantView
            ? 'View comments from the review team'
            : 'Collaborate with other admins on this application'
          }
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        {/* New Comment Form */}
        {!isApplicantView && (
          <div className="space-y-3 p-4 bg-gray-50 rounded-lg">
            <Textarea
              value={newComment}
              onChange={(e) => setNewComment(e.target.value)}
              placeholder="Add a comment..."
              className="min-h-[80px] bg-white"
            />

            <div className="flex items-center justify-between">
              <div className="flex items-center space-x-2">
                <Checkbox
                  id="internal"
                  checked={isInternal}
                  onCheckedChange={(checked) => setIsInternal(checked as boolean)}
                />
                <label
                  htmlFor="internal"
                  className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                >
                  Internal comment (admin only)
                </label>
              </div>

              <Button
                onClick={() => submitComment(null)}
                disabled={isSubmitting || !newComment.trim()}
              >
                <MessageSquare className="mr-2 h-4 w-4" />
                Post Comment
              </Button>
            </div>

            {!isInternal && (
              <Alert>
                <Eye className="h-4 w-4" />
                <AlertDescription>
                  This comment will be visible to the applicant if they check their application status.
                </AlertDescription>
              </Alert>
            )}
          </div>
        )}

        <Separator />

        {/* Comments List */}
        <div className="space-y-3">
          {comments.length > 0 ? (
            comments.map(comment => renderComment(comment))
          ) : (
            <div className="text-center py-8 text-gray-500">
              <MessageSquare className="mx-auto h-12 w-12 text-gray-300 mb-3" />
              <p className="text-sm">No comments yet</p>
              {!isApplicantView && (
                <p className="text-xs mt-1">Be the first to add a comment</p>
              )}
            </div>
          )}
        </div>
      </CardContent>
    </Card>
  )
}