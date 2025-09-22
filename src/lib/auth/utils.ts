import { createClient } from '@/lib/supabase/client'
import type { UserRole } from '@/types/supabase'

/**
 * Get the current user with their role from app_metadata
 */
export async function getCurrentUser() {
  const supabase = createClient()
  const { data: { user }, error } = await supabase.auth.getUser()

  if (error || !user) return null

  // Role is stored in app_metadata
  const role = (user.app_metadata?.role as UserRole) || 'applicant'

  return {
    ...user,
    role
  }
}

/**
 * Check if the current user is an admin
 */
export async function isAdmin(): Promise<boolean> {
  const user = await getCurrentUser()
  return user?.role === 'admin'
}

/**
 * Check if the current user is a participant
 */
export async function isParticipant(): Promise<boolean> {
  const user = await getCurrentUser()
  return user?.role === 'participant'
}

/**
 * Get user's role from app_metadata
 */
export function getUserRole(user: any): UserRole {
  return (user?.app_metadata?.role as UserRole) || 'applicant'
}