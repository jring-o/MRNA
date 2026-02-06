'use client'

import { useState } from 'react'
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Alert, AlertDescription } from '@/components/ui/alert'
import { Badge } from '@/components/ui/badge'
import { Send, AlertTriangle, Users } from 'lucide-react'
import { toast } from 'sonner'

interface Applicant {
  id: string
  name: string | null
  email: string | null
  status: string
}

type EmailType = 'acceptance' | 'waitlist'

interface SendEmailDialogProps {
  open: boolean
  onOpenChange: (open: boolean) => void
  applicants: Applicant[]
  onSend: () => Promise<void>
  isResend?: boolean
  emailType?: EmailType
}

const emailTypeConfig = {
  acceptance: {
    requiredStatus: 'accepted',
    statusLabel: 'Accepted',
    badgeClass: 'bg-green-100 text-green-800 border-green-300',
    emailContents: [
      'Personalized acceptance message',
      'Unique signup link with invite token',
      'Workshop dates and location',
      'Next steps and important information',
    ],
  },
  waitlist: {
    requiredStatus: 'waitlisted',
    statusLabel: 'Waitlisted',
    badgeClass: 'bg-amber-100 text-amber-800 border-amber-300',
    emailContents: [
      'Personalized waitlist notification',
      'Explanation of waitlist process',
      'Timeline for potential acceptance',
      'Encouragement to stay connected',
    ],
  },
}

export function SendEmailDialog({
  open,
  onOpenChange,
  applicants,
  onSend,
  isResend = false,
  emailType = 'acceptance'
}: SendEmailDialogProps) {
  const [isSending, setIsSending] = useState(false)

  const config = emailTypeConfig[emailType]
  const emailLabel = emailType === 'acceptance' ? 'Acceptance' : 'Waitlist'

  const handleSend = async () => {
    setIsSending(true)
    try {
      await onSend()
      toast.success(`${emailLabel} email${applicants.length > 1 ? 's' : ''} sent successfully!`)
      onOpenChange(false)
    } catch (error) {
      console.error('Error sending emails:', error)
      toast.error('Failed to send emails. Please try again.')
    } finally {
      setIsSending(false)
    }
  }

  const eligibleApplicants = applicants.filter(a => a.status === config.requiredStatus)
  const ineligibleApplicants = applicants.filter(a => a.status !== config.requiredStatus)

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[525px]">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            {applicants.length > 1 ? (
              <>
                <Users className="h-5 w-5" />
                {isResend ? 'Resend' : 'Send'} {emailLabel} Emails
              </>
            ) : (
              <>
                <Send className="h-5 w-5" />
                {isResend ? 'Resend' : 'Send'} {emailLabel} Email
              </>
            )}
          </DialogTitle>
          <DialogDescription>
            {applicants.length > 1
              ? `You are about to send ${emailLabel.toLowerCase()} emails to ${eligibleApplicants.length} applicant${eligibleApplicants.length > 1 ? 's' : ''}.`
              : `Confirm the recipient details before sending the ${emailLabel.toLowerCase()} email.`}
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4">
          {/* Show eligible applicants */}
          {eligibleApplicants.length > 0 && (
            <div className="space-y-2">
              <div className="text-sm font-medium text-gray-700">
                Recipients ({eligibleApplicants.length}):
              </div>
              <div className="max-h-[200px] overflow-y-auto space-y-2 border rounded-lg p-3">
                {eligibleApplicants.map(applicant => (
                  <div key={applicant.id} className="flex items-center justify-between">
                    <div>
                      <div className="font-medium">{applicant.name || 'Unknown'}</div>
                      <div className="text-sm text-gray-500">{applicant.email || 'No email'}</div>
                    </div>
                    <Badge className={config.badgeClass}>
                      {config.statusLabel}
                    </Badge>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* Show warning for ineligible applicants */}
          {ineligibleApplicants.length > 0 && (
            <Alert>
              <AlertTriangle className="h-4 w-4" />
              <AlertDescription>
                <strong>{ineligibleApplicants.length} applicant{ineligibleApplicants.length > 1 ? 's' : ''} will be skipped</strong> because they are not in &quot;{config.requiredStatus}&quot; status.
                <div className="mt-2 text-xs">
                  {ineligibleApplicants.map(a => a.name || a.email).join(', ')}
                </div>
              </AlertDescription>
            </Alert>
          )}

          {/* No eligible applicants */}
          {eligibleApplicants.length === 0 && (
            <Alert>
              <AlertTriangle className="h-4 w-4" />
              <AlertDescription>
                No applicants are eligible to receive {emailLabel.toLowerCase()} emails. Only applicants with &quot;{config.requiredStatus}&quot; status can receive {emailLabel.toLowerCase()} emails.
              </AlertDescription>
            </Alert>
          )}

          <div className="text-sm text-gray-600">
            The email will include:
            <ul className="mt-1 list-disc list-inside">
              {config.emailContents.map((item, index) => (
                <li key={index}>{item}</li>
              ))}
            </ul>
          </div>
        </div>

        <DialogFooter>
          <Button
            variant="outline"
            onClick={() => onOpenChange(false)}
            disabled={isSending}
          >
            Cancel
          </Button>
          <Button
            onClick={handleSend}
            disabled={isSending || eligibleApplicants.length === 0}
            className={emailType === 'waitlist' ? 'bg-amber-600 hover:bg-amber-700' : 'bg-blue-600 hover:bg-blue-700'}
          >
            {isSending ? (
              <>Sending...</>
            ) : (
              <>
                <Send className="mr-2 h-4 w-4" />
                Send Email{eligibleApplicants.length > 1 ? 's' : ''}
              </>
            )}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  )
}
