import { redirect, notFound } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import { ApplicationReview } from './application-review-enhanced'
import type { ApplicationWithVoting } from '@/types/database'

export default async function ApplicationDetailPage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const supabase = await createClient()

  // Check if user is authenticated
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Check if user is admin
  const role = user.app_metadata?.role
  if (role !== 'admin') {
    redirect('/dashboard')
  }

  // First, fetch the basic application data
  const { data: application, error: appError } = await supabase
    .from('applications')
    .select('*')
    .eq('id', id)
    .single()

  if (appError || !application) {
    console.error('Error fetching application:', appError)
    notFound()
  }

  // Try to fetch related user data if user_id exists
  let userData = null
  if (application.user_id) {
    const { data } = await supabase
      .from('users')
      .select('id, name, email, organization, created_at')
      .eq('id', application.user_id)
      .single()
    userData = data
  }

  // Try to fetch reviewer data if reviewed_by exists
  let reviewerData = null
  if (application.reviewed_by) {
    const { data } = await supabase
      .from('users')
      .select('id, name, email')
      .eq('id', application.reviewed_by)
      .single()
    reviewerData = data
  }

  // Combine the data, ensuring email is not null
  const enrichedApplication = {
    ...application,
    email: application.email || '', // Ensure email is never null
    users: userData,
    reviewer: reviewerData,
    // Ensure voting fields exist with defaults if not in DB yet
    total_votes: application.total_votes ?? 0,
    approve_votes: application.approve_votes ?? 0,
    reject_votes: application.reject_votes ?? 0,
    abstain_votes: application.abstain_votes ?? 0,
    voting_completed: application.voting_completed ?? false,
    voting_completed_at: application.voting_completed_at ?? null,
  }

  // Type the enriched application
  type EnrichedApplication = ApplicationWithVoting & {
    users?: {
      id: string
      name: string
      email: string
      organization: string | null
      created_at: string | null
    } | null
    reviewer?: {
      id: string
      name: string
      email: string
    } | null
  }

  return <ApplicationReview application={enrichedApplication as EnrichedApplication} currentUserId={user.id} userEmail={user.email || ''} />
}
