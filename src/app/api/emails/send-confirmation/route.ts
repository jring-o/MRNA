import { NextResponse } from 'next/server'
import { Resend } from 'resend'
import { createClient } from '@/lib/supabase/server'
import { ApplicationReceivedEmail } from '@/emails/application-received'
import { AdminNewApplicationEmail } from '@/emails/admin-new-application'

// Admin emails to notify when new applications are submitted
const ADMIN_EMAILS = [
  'jon@scios.tech',
  'ellie@scios.tech',
  'akamatsm@uw.edu',
  // Add more admin emails as needed
]

export async function POST(request: Request) {
  const resend = new Resend(process.env.RESEND_API_KEY)

  try {
    // Verify the caller is an admin
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    if (user.app_metadata?.role !== 'admin') {
      return NextResponse.json({ error: 'Forbidden - Admin only' }, { status: 403 })
    }

    const body = await request.json()
    const {
      applicationId,
      applicantEmail,
      applicantName,
      organization,
      submittedAt
    } = body

    if (!applicationId || !applicantEmail || !applicantName) {
      return NextResponse.json(
        { error: 'Missing required fields' },
        { status: 400 }
      )
    }

    const formattedDate = new Date(submittedAt).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    })

    // Send confirmation email to applicant
    const { data: applicantData, error: applicantError } = await resend.emails.send({
      from: 'MIRA <contact@scios.tech>',
      to: [applicantEmail],
      subject: 'Application Received - MIRA',
      react: ApplicationReceivedEmail({
        applicantName,
        applicationId,
        submittedAt: formattedDate,
      }),
    })

    if (applicantError) {
      console.error('Error sending applicant confirmation:', applicantError)
    }

    // Wait 1500ms before sending admin emails to avoid rate limiting
    await new Promise(resolve => setTimeout(resolve, 1500))

    // Send notification emails to all admins (with delay to avoid rate limiting)
    const adminResults = []
    for (let i = 0; i < ADMIN_EMAILS.length; i++) {
      const adminEmail = ADMIN_EMAILS[i]

      // Add 1500ms delay between each admin email (2 req/sec limit)
      if (i > 0) {
        await new Promise(resolve => setTimeout(resolve, 1500))
      }

      try {
        const result = await resend.emails.send({
          from: 'MIRA Workshop <contact@scios.tech>',
          to: [adminEmail],
          subject: `New Application: ${applicantName} (${organization || 'Unknown'})`,
          react: AdminNewApplicationEmail({
            applicantName,
            applicantEmail,
            organization: organization || 'Not specified',
            submittedAt: formattedDate,
            applicationId,
            reviewLink: `https://mrna-nine.vercel.app/admin/applications/${applicationId}`,
          }),
        })
        adminResults.push({ status: 'fulfilled', value: result })
      } catch (error) {
        adminResults.push({ status: 'rejected', reason: error })
      }
    }

    // Log any admin email failures
    adminResults.forEach((result, index) => {
      if (result.status === 'rejected') {
        console.error(`Failed to send admin notification to ${ADMIN_EMAILS[index]}:`, result.reason)
      }
    })

    return NextResponse.json({
      success: true,
      applicantEmailId: applicantData?.id,
      adminsNotified: adminResults.filter(r => r.status === 'fulfilled').length,
      message: 'Confirmation emails sent successfully',
    })
  } catch (error) {
    console.error('Unexpected error:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}