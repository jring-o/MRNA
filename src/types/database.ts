import type { Database, UserRole } from './supabase'

// Re-export types from supabase
export type Tables<T extends keyof Database['public']['Tables']> = Database['public']['Tables'][T]['Row']
export type Inserts<T extends keyof Database['public']['Tables']> = Database['public']['Tables'][T]['Insert']
export type Updates<T extends keyof Database['public']['Tables']> = Database['public']['Tables'][T]['Update']
export type Enums<T extends keyof Database['public']['Enums']> = Database['public']['Enums'][T]

// Re-export UserRole
export type { UserRole }

// Application types
export type Application = Tables<'applications'>
export type ApplicationStatus = Database['public']['Enums']['application_status']

// Voting types
export type VoteType = Database['public']['Enums']['vote_type']
export type ApplicationVote = Tables<'application_votes'> & {
  admin?: {
    id: string
    name: string
    email: string
  }
}

export type VotingConfig = Tables<'voting_config'>

export type ApplicationWithVoting = Application & {
  total_votes: number | null
  approve_votes: number | null
  reject_votes: number | null
  abstain_votes: number | null
  voting_completed: boolean | null
  voting_summary: string | null
  average_score: number | null
}

// Comment types
export type ApplicationComment = {
  id: string
  application_id: string
  author_id: string
  author_name?: string
  content: string
  parent_id: string | null
  is_internal: boolean
  created_at: string
  edited_at: string | null
  deleted_at: string | null
  depth?: number
}

// Blog types
export type BlogPost = Tables<'blog_posts'> & {
  author?: {
    id: string
    name: string
    email: string
  }
  tags?: Array<{ name: string }>
  categories?: Array<{ name: string }>
}

// User types
export type User = Tables<'users'>

// Helper functions for voting
export function calculateVotePercentage(voteCount: number | null, totalVotes: number | null): number {
  if (!totalVotes || totalVotes === 0 || !voteCount) return 0
  return Math.round((voteCount / totalVotes) * 100)
}

export function getVoteBadgeClass(vote: VoteType): string {
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

// Helper function for comments
export function canEditComment(comment: ApplicationComment, currentUserId: string): boolean {
  // Users can edit their own comments within 5 minutes of creation
  if (comment.author_id !== currentUserId) return false
  if (comment.deleted_at) return false

  const createdAt = new Date(comment.created_at)
  const now = new Date()
  const fiveMinutesInMs = 5 * 60 * 1000

  return (now.getTime() - createdAt.getTime()) < fiveMinutesInMs
}

// Todo types
export type AdminTodo = Tables<'admin_todos'> & {
  created_by_user?: {
    id: string
    name: string
    email: string
  }
  assigned_to_user?: {
    id: string
    name: string
    email: string
  }
  completed_by_user?: {
    id: string
    name: string
    email: string
  }
}

export type TodoPriority = Database['public']['Enums']['todo_priority']
export type TodoStatus = Database['public']['Enums']['todo_status']

// Reflection types (commented out - table not in generated types yet)
// export type ReflectionType = Database['public']['Enums']['reflection_type']
// export type Reflection = Tables<'reflections'> & {
//   user?: {
//     id: string
//     name: string
//     email: string
//   }
// }

// Invite token types
export type InviteToken = Tables<'invite_tokens'>