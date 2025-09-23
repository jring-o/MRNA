'use client'

import { useState, useEffect, useCallback } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Progress } from '@/components/ui/progress'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import { Textarea } from '@/components/ui/textarea'
import { Alert, AlertDescription } from '@/components/ui/alert'
import { Separator } from '@/components/ui/separator'
import { toast } from 'sonner'
import {
  ThumbsUp,
  ThumbsDown,
  MinusCircle,
  Users,
  CheckCircle,
  XCircle,
  Clock,
  User,
  TrendingUp,
  TrendingDown,
} from 'lucide-react'
import type { VoteType, ApplicationVote, VotingConfig, ApplicationWithVoting } from '@/types/database'
import { getVoteBadgeClass, calculateVotePercentage } from '@/types/database'

interface VotingPanelProps {
  application: ApplicationWithVoting
  currentUserId: string
  onVoteChange?: () => void
}

export function VotingPanel({ application, currentUserId, onVoteChange }: VotingPanelProps) {
  const [votes, setVotes] = useState<ApplicationVote[]>([])
  const [currentUserVote, setCurrentUserVote] = useState<ApplicationVote | null>(null)
  const [voteComment, setVoteComment] = useState('')
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [votingConfig, setVotingConfig] = useState<VotingConfig | null>(null)
  const [adminUsers, setAdminUsers] = useState<Array<{ id: string; name: string; email: string }>>([])

  const supabase = createClient()

  const loadVotes = useCallback(async () => {
    const { data, error } = await supabase
      .from('application_votes')
      .select(`
        *,
        admin:users!admin_id(id, name, email)
      `)
      .eq('application_id', application.id)
      .order('created_at', { ascending: false })

    if (error) {
      console.error('Error loading votes:', error)
      return
    }

    setVotes(data || [])
    const userVote = data?.find(v => v.admin_id === currentUserId)
    if (userVote) {
      setCurrentUserVote(userVote)
      setVoteComment(userVote.comment || '')
    }
  }, [application.id, currentUserId, supabase])

  const loadVotingConfig = useCallback(async () => {
    const { data, error } = await supabase
      .from('voting_config')
      .select('*')
      .single()

    if (error) {
      console.error('Error loading voting config:', error)
      return
    }

    setVotingConfig(data)
  }, [supabase])

  const loadAdminUsers = useCallback(async () => {
    // Get all admin users from auth metadata
    const { data, error } = await supabase.rpc('get_admin_users')

    if (error) {
      console.error('Error loading admin users:', error)
      // Fallback: try to get from existing votes
      const uniqueAdmins = new Map()
      votes.forEach(v => {
        if (v.admin && !uniqueAdmins.has(v.admin.id)) {
          uniqueAdmins.set(v.admin.id, v.admin)
        }
      })
      setAdminUsers(Array.from(uniqueAdmins.values()))
    } else {
      setAdminUsers(data || [])
    }
  }, [supabase, votes])

  useEffect(() => {
    loadVotes()
    loadVotingConfig()
    loadAdminUsers()
  }, [loadVotes, loadVotingConfig, loadAdminUsers])

  const submitVote = async (voteType: VoteType) => {
    setIsSubmitting(true)

    try {
      const voteData = {
        application_id: application.id,
        admin_id: currentUserId,
        vote: voteType,
        comment: voteComment.trim() || null,
      }

      let result
      if (currentUserVote) {
        // Update existing vote
        result = await supabase
          .from('application_votes')
          .update({
            vote: voteType,
            comment: voteData.comment,
            updated_at: new Date().toISOString(),
          })
          .eq('id', currentUserVote.id)
          .select()
          .single()
      } else {
        // Create new vote
        result = await supabase
          .from('application_votes')
          .insert(voteData)
          .select()
          .single()
      }

      if (result.error) throw result.error

      toast.success(`Vote ${currentUserVote ? 'updated' : 'submitted'}: ${voteType}`)

      // Reload votes
      await loadVotes()

      if (onVoteChange) {
        onVoteChange()
      }
    } catch (error) {
      console.error('Error submitting vote:', error)
      toast.error('Failed to submit vote')
    } finally {
      setIsSubmitting(false)
    }
  }

  const removeVote = async () => {
    if (!currentUserVote) return

    setIsSubmitting(true)

    try {
      const { error } = await supabase
        .from('application_votes')
        .delete()
        .eq('id', currentUserVote.id)

      if (error) throw error

      toast.success('Vote removed')
      setCurrentUserVote(null)
      setVoteComment('')

      await loadVotes()

      if (onVoteChange) {
        onVoteChange()
      }
    } catch (error) {
      console.error('Error removing vote:', error)
      toast.error('Failed to remove vote')
    } finally {
      setIsSubmitting(false)
    }
  }

  const getVoteIcon = (vote: VoteType) => {
    switch (vote) {
      case 'approve':
        return <ThumbsUp className="w-4 h-4" />
      case 'reject':
        return <ThumbsDown className="w-4 h-4" />
      case 'abstain':
        return <MinusCircle className="w-4 h-4" />
    }
  }

  const approvalPercentage = calculateVotePercentage(application.approve_votes, application.total_votes)
  const rejectionPercentage = calculateVotePercentage(application.reject_votes, application.total_votes)
  const abstainPercentage = calculateVotePercentage(application.abstain_votes, application.total_votes)

  const hasMetThreshold = votingConfig && votingConfig.min_votes_required !== null && application.total_votes !== null && application.total_votes >= votingConfig.min_votes_required
  const hasApprovalConsensus = votingConfig && votingConfig.approval_threshold !== null && approvalPercentage >= (votingConfig.approval_threshold * 100)
  const hasRejectionConsensus = votingConfig && votingConfig.rejection_threshold !== null && rejectionPercentage >= (votingConfig.rejection_threshold * 100)

  return (
    <div className="space-y-4">
      {/* Voting Summary Card */}
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <CardTitle className="flex items-center">
              <Users className="mr-2 h-5 w-5" />
              Voting Summary
            </CardTitle>
            {application.voting_completed && (
              <Badge className="bg-purple-100 text-purple-800 border-purple-300">
                <CheckCircle className="mr-1 h-3 w-3" />
                Voting Completed
              </Badge>
            )}
          </div>
          <CardDescription>
            {application.total_votes} of {adminUsers.length || '?'} admins have voted
            {votingConfig && votingConfig.min_votes_required !== null && ` (minimum ${votingConfig.min_votes_required} required)`}
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          {/* Vote Progress Bars */}
          <div className="space-y-3">
            <div>
              <div className="flex items-center justify-between mb-1">
                <div className="flex items-center text-sm">
                  <ThumbsUp className="mr-2 h-4 w-4 text-green-600" />
                  <span className="font-medium">Approve</span>
                </div>
                <span className="text-sm text-gray-600">
                  {application.approve_votes} ({approvalPercentage}%)
                </span>
              </div>
              <Progress value={approvalPercentage} className="h-2 bg-green-100" />
            </div>

            <div>
              <div className="flex items-center justify-between mb-1">
                <div className="flex items-center text-sm">
                  <ThumbsDown className="mr-2 h-4 w-4 text-red-600" />
                  <span className="font-medium">Reject</span>
                </div>
                <span className="text-sm text-gray-600">
                  {application.reject_votes} ({rejectionPercentage}%)
                </span>
              </div>
              <Progress value={rejectionPercentage} className="h-2 bg-red-100" />
            </div>

            <div>
              <div className="flex items-center justify-between mb-1">
                <div className="flex items-center text-sm">
                  <MinusCircle className="mr-2 h-4 w-4 text-gray-600" />
                  <span className="font-medium">Abstain</span>
                </div>
                <span className="text-sm text-gray-600">
                  {application.abstain_votes} ({abstainPercentage}%)
                </span>
              </div>
              <Progress value={abstainPercentage} className="h-2 bg-gray-200" />
            </div>
          </div>

          <Separator />

          {/* Status Indicators */}
          {votingConfig && (
            <div className="space-y-2">
              {hasMetThreshold ? (
                <Alert className="border-green-300 bg-green-50">
                  <CheckCircle className="h-4 w-4 text-green-600" />
                  <AlertDescription className="text-green-800">
                    Minimum vote threshold met ({application.total_votes}/{votingConfig?.min_votes_required ?? 0})
                  </AlertDescription>
                </Alert>
              ) : (
                <Alert className="border-yellow-300 bg-yellow-50">
                  <Clock className="h-4 w-4 text-yellow-600" />
                  <AlertDescription className="text-yellow-800">
                    Waiting for more votes ({application.total_votes}/{votingConfig?.min_votes_required ?? 0})
                  </AlertDescription>
                </Alert>
              )}

              {hasApprovalConsensus && votingConfig?.auto_approve_enabled && (
                <Alert className="border-green-300 bg-green-50">
                  <TrendingUp className="h-4 w-4 text-green-600" />
                  <AlertDescription className="text-green-800">
                    Approval threshold reached ({approvalPercentage}% ≥ {(votingConfig?.approval_threshold ?? 0) * 100}%)
                    {!application.voting_completed && ' - Auto-approval pending'}
                  </AlertDescription>
                </Alert>
              )}

              {hasRejectionConsensus && votingConfig?.auto_reject_enabled && (
                <Alert className="border-red-300 bg-red-50">
                  <TrendingDown className="h-4 w-4 text-red-600" />
                  <AlertDescription className="text-red-800">
                    Rejection threshold reached ({rejectionPercentage}% ≥ {(votingConfig?.rejection_threshold ?? 0) * 100}%)
                    {!application.voting_completed && ' - Auto-rejection pending'}
                  </AlertDescription>
                </Alert>
              )}
            </div>
          )}
        </CardContent>
      </Card>

      {/* Your Vote Card */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center">
            <User className="mr-2 h-5 w-5" />
            Your Vote
          </CardTitle>
          <CardDescription>
            {currentUserVote
              ? `You voted: ${currentUserVote.vote}${currentUserVote.created_at ? ` on ${new Date(currentUserVote.created_at).toLocaleDateString()}` : ''}`
              : 'You have not voted yet'
            }
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="flex gap-2">
            <Button
              onClick={() => submitVote('approve')}
              disabled={isSubmitting}
              className={`flex-1 ${currentUserVote?.vote === 'approve' ? 'bg-green-600 hover:bg-green-700' : ''}`}
              variant={currentUserVote?.vote === 'approve' ? 'default' : 'outline'}
            >
              <ThumbsUp className="mr-2 h-4 w-4" />
              Approve
            </Button>
            <Button
              onClick={() => submitVote('reject')}
              disabled={isSubmitting}
              className={`flex-1 ${currentUserVote?.vote === 'reject' ? 'bg-red-600 hover:bg-red-700' : ''}`}
              variant={currentUserVote?.vote === 'reject' ? 'destructive' : 'outline'}
            >
              <ThumbsDown className="mr-2 h-4 w-4" />
              Reject
            </Button>
            <Button
              onClick={() => submitVote('abstain')}
              disabled={isSubmitting}
              className={`flex-1 ${currentUserVote?.vote === 'abstain' ? 'bg-gray-600 hover:bg-gray-700' : ''}`}
              variant={currentUserVote?.vote === 'abstain' ? 'secondary' : 'outline'}
            >
              <MinusCircle className="mr-2 h-4 w-4" />
              Abstain
            </Button>
          </div>

          <div>
            <label className="text-sm font-medium text-gray-700">Vote Comment (Optional)</label>
            <Textarea
              value={voteComment}
              onChange={(e) => setVoteComment(e.target.value)}
              placeholder="Add a comment about your decision..."
              className="mt-1"
              rows={3}
            />
          </div>

          {currentUserVote && (
            <Button
              onClick={removeVote}
              disabled={isSubmitting}
              variant="ghost"
              size="sm"
              className="text-red-600 hover:text-red-700"
            >
              <XCircle className="mr-2 h-4 w-4" />
              Remove Vote
            </Button>
          )}
        </CardContent>
      </Card>

      {/* All Votes List */}
      <Card>
        <CardHeader>
          <CardTitle>All Votes</CardTitle>
          <CardDescription>
            Individual votes from admin team members
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            {votes.map((vote) => (
              <div key={vote.id} className="flex items-start space-x-3 p-3 bg-gray-50 rounded-lg">
                <Avatar className="h-8 w-8">
                  <AvatarFallback>
                    {vote.admin?.name?.substring(0, 2).toUpperCase() || 'AD'}
                  </AvatarFallback>
                </Avatar>
                <div className="flex-1">
                  <div className="flex items-center justify-between">
                    <div className="flex items-center space-x-2">
                      <span className="text-sm font-medium">
                        {vote.admin?.name || 'Admin'}
                      </span>
                      <Badge className={getVoteBadgeClass(vote.vote)}>
                        {getVoteIcon(vote.vote)}
                        <span className="ml-1">{vote.vote}</span>
                      </Badge>
                    </div>
                    <span className="text-xs text-gray-500">
                      {vote.created_at ? new Date(vote.created_at).toLocaleDateString() : 'Unknown date'}
                    </span>
                  </div>
                  {vote.comment && (
                    <p className="mt-1 text-sm text-gray-600">{vote.comment}</p>
                  )}
                </div>
              </div>
            ))}

            {votes.length === 0 && (
              <p className="text-center text-sm text-gray-500 py-4">
                No votes yet. Be the first to vote!
              </p>
            )}

            {/* Show pending admins */}
            {adminUsers.length > votes.length && (
              <div className="mt-4 pt-4 border-t">
                <p className="text-sm text-gray-600 mb-2">Awaiting votes from:</p>
                <div className="flex flex-wrap gap-2">
                  {adminUsers
                    .filter(admin => !votes.find(v => v.admin_id === admin.id))
                    .map(admin => (
                      <Badge key={admin.id} variant="outline" className="text-xs">
                        {admin.name}
                      </Badge>
                    ))}
                </div>
              </div>
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  )
}