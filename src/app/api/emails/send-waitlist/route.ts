import { NextResponse } from 'next/server'
import { Resend } from 'resend'
import { ApplicationWaitlistedEmail } from '@/emails/application-waitlisted'
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

    // Send waitlist email using React Email template
    const { data, error } = await resend.emails.send({
      from: 'MIRA <contact@scios.tech>',
      to: [applicantEmail],
      subject: 'Update on Your MIRA Application - Waitlist Status',
      react: ApplicationWaitlistedEmail({
        applicantName,
      }),
    })

    if (error) {
      console.error('Error sending email:', error)
      return NextResponse.json(
        { error: 'Failed to send email' },
        { status: 500 }
      )
    }

    // Note: We do NOT update the status here - the application is already waitlisted
    // This endpoint just sends the notification email

    return NextResponse.json({
      success: true,
      emailId: data?.id,
      message: 'Waitlist email sent successfully',
    })
  } catch (error) {
    console.error('Unexpected error:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}
