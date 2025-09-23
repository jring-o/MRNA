import { NextResponse } from 'next/server'
import { Resend } from 'resend'
import { ApplicationReceivedEmail } from '@/emails/application-received'
import { AdminNewApplicationEmail } from '@/emails/admin-new-application'

const resend = new Resend(process.env.RESEND_API_KEY)

// Admin emails to notify when new applications are submitted
const ADMIN_EMAILS = [
  'jon@scios.tech',
  'ellie@scios.tech',
  // Add more admin emails as needed
]

export async function POST(request: Request) {
  try {
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
      from: 'Modular Research Workshop <workshop@modularresearch.org>',
      to: [applicantEmail],
      subject: 'Application Received - Modular Research Workshop',
      react: ApplicationReceivedEmail({
        applicantName,
        applicationId,
        submittedAt: formattedDate,
      }),
    })

    if (applicantError) {
      console.error('Error sending applicant confirmation:', applicantError)
    }

    // Send notification emails to all admins
    const adminEmails = ADMIN_EMAILS.map(adminEmail =>
      resend.emails.send({
        from: 'Workshop Admin <admin@modularresearch.org>',
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
    )

    // Send all admin emails in parallel
    const adminResults = await Promise.allSettled(adminEmails)

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