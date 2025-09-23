'use client'

import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Alert, AlertDescription } from '@/components/ui/alert'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { toast } from 'sonner'
import {
  Copy,
  Mail,
  CheckCircle2,
  Link,
  RefreshCw,
  AlertCircle,
} from 'lucide-react'

interface InviteTokenGeneratorProps {
  applicationId: string
  applicationEmail: string
  applicationStatus: string
  applicantName: string
}

export function InviteTokenGenerator({
  applicationId,
  applicationEmail,
  applicationStatus,
  applicantName,
}: InviteTokenGeneratorProps) {
  const [, setInviteToken] = useState<string | null>(null)
  const [inviteUrl, setInviteUrl] = useState<string | null>(null)
  const [loading, setLoading] = useState(false)
  const [copied, setCopied] = useState(false)

  const supabase = createClient()

  const generateInviteToken = async () => {
    setLoading(true)
    try {
      const { data, error } = await supabase.rpc('generate_invite_token', {
        p_application_id: applicationId,
      })

      if (error) throw error

      const token = data as string
      const url = `${window.location.origin}/signup?token=${token}&email=${encodeURIComponent(applicationEmail)}`

      setInviteToken(token)
      setInviteUrl(url)
      toast.success('Invite token generated successfully!')
    } catch (error) {
      console.error('Error generating invite token:', error)
      toast.error('Failed to generate invite token')
    } finally {
      setLoading(false)
    }
  }

  const copyToClipboard = async () => {
    if (inviteUrl) {
      await navigator.clipboard.writeText(inviteUrl)
      setCopied(true)
      setTimeout(() => setCopied(false), 2000)
      toast.success('Invite link copied to clipboard!')
    }
  }

  const sendInviteEmail = async () => {
    if (!inviteUrl) return

    // This would normally integrate with your email service
    // For now, we'll just copy the template to clipboard
    const emailTemplate = `Subject: Welcome to the Modular Research Attribution Workshop!

Dear ${applicantName},

Congratulations! Your application to the Modular Research Attribution Workshop has been accepted.

We're thrilled to welcome you as a participant in the Spring 2026 workshop. To get started, please create your account using your personal invitation link:

${inviteUrl}

This link is unique to you and will expire in 30 days. Once you've created your account, you'll have access to:

• Participant directory and profiles
• Workshop schedule and logistics information
• Pre-workshop collaboration tools
• Shared resources and documents

Important Details:
• Workshop Dates: Spring 2026 (4 days)
• Format: In-person intensive collaboration
• Location: [To be announced]

If you have any questions or encounter any issues with registration, please don't hesitate to contact us.

We look forward to working with you!

Best regards,
The Workshop Organizing Team`

    await navigator.clipboard.writeText(emailTemplate)
    toast.success('Email template copied to clipboard!')
  }

  const checkExistingToken = async () => {
    try {
      const { data, error } = await supabase
        .from('invite_tokens')
        .select('token, used, created_at, expires_at')
        .eq('application_id', applicationId)
        .eq('used', false)
        .gte('expires_at', new Date().toISOString())
        .single()

      if (data && !error) {
        const url = `${window.location.origin}/signup?token=${data.token}&email=${encodeURIComponent(applicationEmail)}`
        setInviteToken(data.token)
        setInviteUrl(url)
      }
    } catch {
      // No existing token found
    }
  }

  // Check for existing token on mount
  useState(() => {
    if (applicationStatus === 'accepted') {
      checkExistingToken()
    }
  })

  if (applicationStatus !== 'accepted') {
    return (
      <Alert>
        <AlertCircle className="h-4 w-4" />
        <AlertDescription>
          Invite tokens can only be generated for accepted applications.
          Change the application status to &quot;accepted&quot; first.
        </AlertDescription>
      </Alert>
    )
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center justify-between">
          <span>Participant Invitation</span>
          <Badge className="bg-green-100 text-green-800">Accepted</Badge>
        </CardTitle>
        <CardDescription>
          Generate or manage the invitation link for this participant
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        {!inviteUrl ? (
          <div className="text-center py-4">
            <p className="text-sm text-gray-600 mb-4">
              No active invitation token exists for this application.
            </p>
            <Button onClick={generateInviteToken} disabled={loading}>
              {loading ? (
                <>
                  <RefreshCw className="mr-2 h-4 w-4 animate-spin" />
                  Generating...
                </>
              ) : (
                <>
                  <Link className="mr-2 h-4 w-4" />
                  Generate Invitation Link
                </>
              )}
            </Button>
          </div>
        ) : (
          <>
            <Alert>
              <CheckCircle2 className="h-4 w-4" />
              <AlertDescription>
                Invitation link is ready! Send this to {applicantName} at {applicationEmail}
              </AlertDescription>
            </Alert>

            <div className="space-y-2">
              <label className="text-sm font-medium">Invitation Link</label>
              <div className="flex space-x-2">
                <Input
                  value={inviteUrl}
                  readOnly
                  className="font-mono text-xs"
                />
                <Button
                  variant="outline"
                  size="icon"
                  onClick={copyToClipboard}
                >
                  {copied ? (
                    <CheckCircle2 className="h-4 w-4" />
                  ) : (
                    <Copy className="h-4 w-4" />
                  )}
                </Button>
              </div>
              <p className="text-xs text-gray-500">
                This link will expire in 30 days and can only be used once.
              </p>
            </div>

            <div className="flex space-x-2">
              <Button
                variant="outline"
                className="flex-1"
                onClick={sendInviteEmail}
              >
                <Mail className="mr-2 h-4 w-4" />
                Copy Email Template
              </Button>
              <Button
                variant="outline"
                onClick={generateInviteToken}
                disabled={loading}
              >
                <RefreshCw className="mr-2 h-4 w-4" />
                Regenerate
              </Button>
            </div>

            <Alert>
              <AlertCircle className="h-4 w-4" />
              <AlertDescription className="text-xs">
                <strong>Next Steps:</strong>
                <ol className="mt-2 space-y-1 list-decimal list-inside">
                  <li>Copy the invitation link or email template</li>
                  <li>Send the invitation to {applicationEmail}</li>
                  <li>The participant will use this link to create their account</li>
                  <li>Once registered, they&apos;ll have access to the participant dashboard</li>
                </ol>
              </AlertDescription>
            </Alert>
          </>
        )}
      </CardContent>
    </Card>
  )
}