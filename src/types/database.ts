/**
 * Extended database types for voting and commenting system
 */

export type VoteType = 'approve' | 'reject' | 'abstain'

export type ApplicationStatus = 'pending' | 'accepted' | 'rejected' | 'waitlisted'

export interface ApplicationVote {
  id: string
  application_id: string
  admin_id: string
  vote: VoteType
  comment?: string | null
  created_at: string | null
  updated_at: string | null
  // Joined fields
  admin?: {
    id: string
    name: string
    email: string
  }
}

export interface ApplicationComment {
  id: string
  application_id: string
  author_id: string
  content: string
  parent_id?: string | null
  is_internal: boolean | null
  created_at: string | null
  edited_at?: string | null
  deleted_at?: string | null
  // Joined fields
  author?: {
    id: string
    name: string
    email: string
    profile_image_url?: string | null
  }
  replies?: ApplicationComment[]
  depth?: number
}

export interface VotingConfig {
  id: string
  min_votes_required: number | null
  approval_threshold: number | null
  auto_approve_enabled: boolean | null
  auto_reject_enabled: boolean | null
  rejection_threshold: number | null
  created_at: string | null
  updated_at: string | null
}

export interface ApplicationWithVoting {
  id: string
  user_id?: string | null
  email: string
  name: string
  organization?: string
  role: string
  status: ApplicationStatus
  reason_for_applying: string
  requirements_for_protocol?: string | null
  relevant_experience?: string | null
  admin_notes?: string[] | null
  submitted_at: string
  reviewed_at?: string | null
  reviewed_by?: string | null
  // Voting fields
  total_votes: number
  approve_votes: number
  reject_votes: number
  abstain_votes: number
  voting_completed: boolean
  voting_completed_at?: string | null
  // Relations
  votes?: ApplicationVote[]
  comments?: ApplicationComment[]
}

export interface VotingSummary {
  id: string
  name: string
  email: string
  status: ApplicationStatus
  total_votes: number
  approve_votes: number
  reject_votes: number
  abstain_votes: number
  voting_completed: boolean
  approval_percentage: number
  rejection_percentage: number
  votes: {
    admin_id: string
    admin_name: string
    vote: VoteType
    voted_at: string
  }[]
}

// Helper functions for vote calculations
export const calculateVotePercentage = (votes: number, total: number): number => {
  if (total === 0) return 0
  return Math.round((votes / total) * 100 * 10) / 10
}

export const getVoteColor = (vote: VoteType): string => {
  switch (vote) {
    case 'approve':
      return 'text-green-600'
    case 'reject':
      return 'text-red-600'
    case 'abstain':
      return 'text-gray-500'
    default:
      return 'text-gray-500'
  }
}

export const getVoteBadgeClass = (vote: VoteType): string => {
  switch (vote) {
    case 'approve':
      return 'bg-green-100 text-green-800 border-green-300'
    case 'reject':
      return 'bg-red-100 text-red-800 border-red-300'
    case 'abstain':
      return 'bg-gray-100 text-gray-800 border-gray-300'
    default:
      return 'bg-gray-100 text-gray-800 border-gray-300'
  }
}

export const canEditComment = (comment: ApplicationComment): boolean => {
  if (comment.deleted_at) return false
  if (!comment.created_at) return false
  const createdAt = new Date(comment.created_at)
  const fifteenMinutesAgo = new Date(Date.now() - 15 * 60 * 1000)
  return createdAt > fifteenMinutesAgo
}