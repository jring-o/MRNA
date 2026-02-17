import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

export async function POST(request: Request) {
  try {
    const { applicationId, email } = await request.json()

    if (!applicationId || !email) {
      return NextResponse.json(
        { error: 'Application ID and email are required' },
        { status: 400 }
      )
    }

    const supabase = await createClient()

    // Verify the caller is authenticated
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Only allow users to delete their own application (email must match their account)
    if (user.email !== email) {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }

    // First, verify the email matches the application (security check)
    const { data: application, error: fetchError } = await supabase
      .from('applications')
      .select('id, email, status')
      .eq('id', applicationId)
      .single()

    if (fetchError || !application) {
      return NextResponse.json(
        { error: 'Application not found' },
        { status: 404 }
      )
    }

    // Verify email matches
    if (application.email !== email) {
      return NextResponse.json(
        { error: 'Email does not match application' },
        { status: 403 }
      )
    }

    // Prevent deletion of accepted applications (optional - you can remove this if you want to allow it)
    if (application.status === 'accepted') {
      return NextResponse.json(
        { error: 'Cannot delete accepted applications. Please contact us at contact@scios.tech for assistance.' },
        { status: 400 }
      )
    }

    // Delete the application (CASCADE will delete related votes, comments, invite tokens)
    const { error: deleteError } = await supabase
      .from('applications')
      .delete()
      .eq('id', applicationId)
      .eq('email', email) // Double-check for security

    if (deleteError) {
      console.error('Delete error:', deleteError)
      return NextResponse.json(
        { error: 'Failed to delete application' },
        { status: 500 }
      )
    }

    return NextResponse.json({ success: true, message: 'Application deleted successfully' })
  } catch (error) {
    console.error('API error:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}
