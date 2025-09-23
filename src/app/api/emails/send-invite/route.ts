import { NextResponse } from 'next/server'
import { Resend } from 'resend'
import { ApplicationAcceptedEmail } from '@/emails/application-accepted'
import { createClient } from '@/lib/supabase/server'

const resend = new Resend(process.env.RESEND_API_KEY)

export async function POST(request: Request) {
  try {
    // Check if user is admin
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Check if user is admin
    const isAdmin = user.app_metadata?.role === 'admin'
    if (!isAdmin) {
      return NextResponse.json({ error: 'Forbidden - Admin only' }, { status: 403 })
    }

    const body = await request.json()
    const { applicationId, applicantEmail, applicantName } = body

    if (!applicationId || !applicantEmail || !applicantName) {
      return NextResponse.json(
        { error: 'Missing required fields' },
        { status: 400 }
      )
    }

    // Generate invite token
    const token = crypto.randomUUID()
    const expiresAt = new Date()
    expiresAt.setDate(expiresAt.getDate() + 7) // 7 days expiration

    // Save invite token to database
    const { error: tokenError } = await supabase
      .from('invite_tokens')
      .insert({
        email: applicantEmail,
        token,
        application_id: applicationId,
        expires_at: expiresAt.toISOString(),
        used: false,
      })

    if (tokenError) {
      console.error('Error creating invite token:', tokenError)
      return NextResponse.json(
        { error: 'Failed to create invite token' },
        { status: 500 }
      )
    }

    // Create invite link
    const baseUrl = process.env.NODE_ENV === 'production'
      ? 'https://mrna-nine.vercel.app'
      : 'http://localhost:3000'
    const inviteLink = `${baseUrl}/signup?token=${token}&email=${encodeURIComponent(applicantEmail)}`

    // Send email using React Email template
    const { data, error } = await resend.emails.send({
      from: 'Modular Research Workshop <workshop@modularresearch.org>',
      to: [applicantEmail],
      subject: '🎉 You\'ve Been Accepted to the Modular Research Workshop!',
      react: ApplicationAcceptedEmail({
        applicantName,
        inviteLink,
        workshopDates: 'May 12-15, 2026',
        workshopLocation: 'Columbia University, New York City',
      }),
    })

    if (error) {
      console.error('Error sending email:', error)
      return NextResponse.json(
        { error: 'Failed to send email' },
        { status: 500 }
      )
    }

    // Update application status to accepted
    const { error: updateError } = await supabase
      .from('applications')
      .update({ status: 'accepted' })
      .eq('id', applicationId)

    if (updateError) {
      console.error('Error updating application status:', updateError)
    }

    return NextResponse.json({
      success: true,
      emailId: data?.id,
      inviteLink,
      message: 'Acceptance email sent successfully',
    })
  } catch (error) {
    console.error('Unexpected error:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}