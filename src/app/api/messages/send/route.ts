import { NextResponse } from 'next/server'
import { Resend } from 'resend'
import { createClient } from '@/lib/supabase/server'
import { AdminMessageEmail } from '@/emails/admin-message'

export async function POST(request: Request) {
  const resend = new Resend(process.env.RESEND_API_KEY)
  try {
    // Check if user is admin
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const isAdmin = user.app_metadata?.role === 'admin'
    if (!isAdmin) {
      return NextResponse.json({ error: 'Forbidden - Admin only' }, { status: 403 })
    }

    const body = await request.json()
    const { subject, content, contentPlain, recipientIds } = body

    if (!subject || !content) {
      return NextResponse.json(
        { error: 'Missing required fields' },
        { status: 400 }
      )
    }

    // Insert message into messages table
    const { data: message, error: insertError } = await supabase
      .from('messages')
      .insert({
        subject,
        content,
        content_plain: contentPlain || null,
        author_id: user.id,
      })
      .select()
      .single()

    if (insertError || !message) {
      console.error('Error inserting message:', insertError)
      return NextResponse.json(
        { error: 'Failed to create message' },
        { status: 500 }
      )
    }

    // Get participant emails via RPC (returns users with role 'participant' or 'admin')
    const { data: allRecipients, error: rpcError } = await supabase
      .rpc('get_participant_emails')

    if (rpcError) {
      console.error('Error getting participant emails:', rpcError)
      return NextResponse.json(
        { error: 'Failed to get recipient list' },
        { status: 500 }
      )
    }

    // Filter recipients by provided IDs, or send to all (backward compat)
    let recipients = allRecipients || []

    if (Array.isArray(recipientIds) && recipientIds.length > 0) {
      const allowedIds = new Set(recipientIds as string[])
      recipients = recipients.filter((r: { user_id: string }) => allowedIds.has(r.user_id))
    }

    // Populate message_recipients junction table (non-fatal)
    if (recipients.length > 0) {
      const recipientRows = recipients.map((r: { user_id: string }) => ({
        message_id: message.id,
        user_id: r.user_id,
      }))
      const { error: recipientError } = await supabase
        .from('message_recipients')
        .insert(recipientRows)
      if (recipientError) {
        console.error('Error inserting message_recipients:', recipientError)
      }
    }

    const baseUrl = process.env.NODE_ENV === 'production'
      ? 'https://mrna-nine.vercel.app'
      : 'http://localhost:3000'
    const messagesUrl = `${baseUrl}/messages`

    const authorName = user.user_metadata?.name || user.email || 'Admin'
    const sentAt = new Date().toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
    })

    // Send email to each recipient with delay
    let emailsSent = 0
    let emailsFailed = 0

    for (let i = 0; i < (recipients?.length || 0); i++) {
      const recipient = recipients![i]

      // Add 1500ms delay between emails (rate limiting)
      if (i > 0) {
        await new Promise(resolve => setTimeout(resolve, 1500))
      }

      try {
        await resend.emails.send({
          from: 'MIRA <contact@scios.tech>',
          to: [recipient.email],
          subject: `${subject} - MIRA`,
          react: AdminMessageEmail({
            recipientName: recipient.name || 'Participant',
            subject,
            messageHtml: content,
            authorName,
            sentAt,
            messagesUrl,
          }),
        })
        emailsSent++
      } catch (error) {
        console.error(`Failed to send email to ${recipient.email}:`, error)
        emailsFailed++
      }
    }

    // Update message with email stats
    await supabase
      .from('messages')
      .update({
        email_sent: true,
        email_sent_at: new Date().toISOString(),
        email_recipient_count: emailsSent,
      })
      .eq('id', message.id)

    return NextResponse.json({
      success: true,
      messageId: message.id,
      emailsSent,
      emailsFailed,
    })
  } catch (error) {
    console.error('Unexpected error:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}
