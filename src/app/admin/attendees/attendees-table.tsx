'use client'

import { useState, useMemo } from 'react'
import Link from 'next/link'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Badge } from '@/components/ui/badge'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu'
import { SendEmailDialog } from '@/components/admin/send-email-dialog'
import { toast } from 'sonner'
import { getClassificationDisplayName, getClassificationBadgeClass } from '@/types/database'
import {
  Search,
  Download,
  MoreVertical,
  Eye,
  Send,
  RefreshCw,
  CheckCircle,
  XCircle,
  Mail,
  UserCheck,
  Trash2,
} from 'lucide-react'
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from '@/components/ui/alert-dialog'

type Attendee = {
  id: string
  user_id: string | null
  email: string | null
  name: string | null
  organization: string | null
  role: string
  status: string
  classifications: string[]
  classification_other: string | null
  submitted_at: string | null
  emailSent: boolean
  accountCreated: boolean
}

export function AttendeesTable({ attendees: initialAttendees }: { attendees: Attendee[] }) {
  const router = useRouter()
  const [attendees, setAttendees] = useState<Attendee[]>(initialAttendees)
  const [searchTerm, setSearchTerm] = useState('')
  const [emailDialogOpen, setEmailDialogOpen] = useState(false)
  const [emailApplicant, setEmailApplicant] = useState<Attendee | null>(null)
  const [removeDialogOpen, setRemoveDialogOpen] = useState(false)
  const [attendeeToRemove, setAttendeeToRemove] = useState<Attendee | null>(null)
  const [removing, setRemoving] = useState(false)

  // Filter attendees
  const filteredAttendees = useMemo(() => {
    if (!searchTerm) return attendees

    return attendees.filter(attendee =>
      attendee.name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
      attendee.email?.toLowerCase().includes(searchTerm.toLowerCase()) ||
      attendee.organization?.toLowerCase().includes(searchTerm.toLowerCase())
    )
  }, [attendees, searchTerm])

  // Send acceptance email
  const sendAcceptanceEmail = async (attendee: Attendee) => {
    try {
      const response = await fetch('/api/emails/send-invite', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          applicationId: attendee.id,
          applicantEmail: attendee.email,
          applicantName: attendee.name,
        }),
      })

      if (!response.ok) {
        throw new Error('Failed to send email')
      }

      toast.success('Acceptance email sent')
      router.refresh()
    } catch (error) {
      console.error('Error sending email:', error)
      toast.error('Failed to send email')
    }
  }

  // Open email dialog
  const openEmailDialog = (attendee: Attendee) => {
    setEmailApplicant(attendee)
    setEmailDialogOpen(true)
  }

  // Open remove confirmation dialog
  const openRemoveDialog = (attendee: Attendee) => {
    setAttendeeToRemove(attendee)
    setRemoveDialogOpen(true)
  }

  // Remove attendee from accepted list
  const removeAttendee = async () => {
    if (!attendeeToRemove) return

    setRemoving(true)
    try {
      const response = await fetch('/api/admin/remove-attendee', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ applicationId: attendeeToRemove.id }),
      })

      if (!response.ok) {
        const data = await response.json()
        throw new Error(data.error || 'Failed to remove attendee')
      }

      toast.success(`${attendeeToRemove.name} removed from accepted list`)
      setAttendees(prev => prev.filter(a => a.id !== attendeeToRemove.id))
      setRemoveDialogOpen(false)
      setAttendeeToRemove(null)
      router.refresh()
    } catch (error) {
      console.error('Error removing attendee:', error)
      toast.error(error instanceof Error ? error.message : 'Failed to remove attendee')
    } finally {
      setRemoving(false)
    }
  }

  // Export to CSV
  const exportToCSV = () => {
    const csv = [
      ['Name', 'Email', 'Organization', 'Classifications', 'Email Sent', 'Account Created'],
      ...filteredAttendees.map(attendee => [
        attendee.name || '',
        attendee.email || '',
        attendee.organization || '',
        attendee.classifications?.map(c =>
          c === 'other' && attendee.classification_other
            ? attendee.classification_other
            : getClassificationDisplayName(c)
        ).join('; ') || '',
        attendee.emailSent ? 'Yes' : 'No',
        attendee.accountCreated ? 'Yes' : 'No',
      ])
    ].map(row => row.map(cell => `"${cell}"`).join(',')).join('\n')

    const blob = new Blob([csv], { type: 'text/csv' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `attendees-${new Date().toISOString().split('T')[0]}.csv`
    a.click()
    URL.revokeObjectURL(url)
  }

  const getClassificationBadges = (classifications: string[], classificationOther: string | null) => {
    if (!classifications || classifications.length === 0) return null

    return (
      <div className="flex flex-wrap gap-1">
        {classifications.map((classification) => (
          <Badge
            key={classification}
            variant="outline"
            className={`text-xs ${getClassificationBadgeClass(classification)}`}
          >
            {classification === 'other' && classificationOther
              ? classificationOther
              : getClassificationDisplayName(classification)}
          </Badge>
        ))}
      </div>
    )
  }

  return (
    <div className="space-y-4">
      {/* Search and Actions */}
      <div className="bg-white rounded-lg shadow p-4">
        <div className="flex flex-col sm:flex-row gap-4">
          {/* Search */}
          <div className="relative flex-1">
            <Search className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
            <Input
              placeholder="Search by name, email, or organization..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="pl-10"
            />
          </div>

          {/* Export Button */}
          <Button variant="outline" onClick={exportToCSV}>
            <Download className="mr-2 h-4 w-4" />
            Export CSV
          </Button>
        </div>
      </div>

      {/* Attendees Table */}
      <div className="bg-white rounded-lg shadow overflow-hidden">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Name</TableHead>
              <TableHead>Organization</TableHead>
              <TableHead>Classifications</TableHead>
              <TableHead className="text-center">
                <div className="flex items-center justify-center gap-1">
                  <Mail className="h-4 w-4" />
                  Email Sent
                </div>
              </TableHead>
              <TableHead className="text-center">
                <div className="flex items-center justify-center gap-1">
                  <UserCheck className="h-4 w-4" />
                  Account
                </div>
              </TableHead>
              <TableHead className="text-right">Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {filteredAttendees.map((attendee) => (
              <TableRow key={attendee.id}>
                <TableCell>
                  <div>
                    <div className="font-medium">{attendee.name || 'N/A'}</div>
                    <div className="text-sm text-gray-500">{attendee.email || 'N/A'}</div>
                  </div>
                </TableCell>
                <TableCell>{attendee.organization || 'N/A'}</TableCell>
                <TableCell>
                  {getClassificationBadges(attendee.classifications, attendee.classification_other)}
                </TableCell>
                <TableCell className="text-center">
                  {attendee.emailSent ? (
                    <CheckCircle className="h-5 w-5 text-green-500 mx-auto" />
                  ) : (
                    <XCircle className="h-5 w-5 text-gray-300 mx-auto" />
                  )}
                </TableCell>
                <TableCell className="text-center">
                  {attendee.accountCreated ? (
                    <CheckCircle className="h-5 w-5 text-green-500 mx-auto" />
                  ) : (
                    <XCircle className="h-5 w-5 text-gray-300 mx-auto" />
                  )}
                </TableCell>
                <TableCell className="text-right">
                  <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                      <Button variant="ghost" size="sm">
                        <MoreVertical className="h-4 w-4" />
                      </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent align="end">
                      <DropdownMenuItem asChild>
                        <Link href={`/admin/applications/${attendee.id}`}>
                          <Eye className="mr-2 h-4 w-4" />
                          View Application
                        </Link>
                      </DropdownMenuItem>
                      <DropdownMenuItem onClick={() => openEmailDialog(attendee)}>
                        {attendee.emailSent ? (
                          <>
                            <RefreshCw className="mr-2 h-4 w-4 text-blue-600" />
                            Resend Acceptance Email
                          </>
                        ) : (
                          <>
                            <Send className="mr-2 h-4 w-4 text-blue-600" />
                            Send Acceptance Email
                          </>
                        )}
                      </DropdownMenuItem>
                      <DropdownMenuItem
                        onClick={() => openRemoveDialog(attendee)}
                        className="text-red-600 focus:text-red-600 focus:bg-red-50"
                      >
                        <Trash2 className="mr-2 h-4 w-4" />
                        Remove from List
                      </DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>

        {filteredAttendees.length === 0 && (
          <div className="text-center py-12 text-gray-500">
            {searchTerm ? 'No attendees found matching your search.' : 'No accepted attendees yet.'}
          </div>
        )}
      </div>

      {/* Results Summary */}
      <div className="text-sm text-gray-600 text-right">
        Showing {filteredAttendees.length} of {attendees.length} attendees
      </div>

      {/* Email Confirmation Dialog */}
      {emailApplicant && (
        <SendEmailDialog
          open={emailDialogOpen}
          onOpenChange={setEmailDialogOpen}
          applicants={[emailApplicant]}
          onSend={() => sendAcceptanceEmail(emailApplicant)}
          isResend={emailApplicant.emailSent}
        />
      )}

      {/* Remove Confirmation Dialog */}
      <AlertDialog open={removeDialogOpen} onOpenChange={setRemoveDialogOpen}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Remove from Accepted List?</AlertDialogTitle>
            <AlertDialogDescription>
              Are you sure you want to remove <strong>{attendeeToRemove?.name}</strong> from the accepted list?
              Their application will be moved back to &quot;pending&quot; status.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel disabled={removing}>Cancel</AlertDialogCancel>
            <AlertDialogAction
              onClick={removeAttendee}
              disabled={removing}
              className="bg-red-600 hover:bg-red-700 focus:ring-red-600"
            >
              {removing ? 'Removing...' : 'Remove'}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  )
}
