'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Separator } from '@/components/ui/separator'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Alert, AlertDescription } from '@/components/ui/alert'
import { toast } from 'sonner'
import {
  ArrowLeft,
  Clock,
  CheckCircle,
  XCircle,
  AlertCircle,
  User,
  Mail,
  Calendar,
  FileText,
  Link as LinkIcon,
  MessageSquare,
  History,
  Download,
  Edit,
  Save,
  X,
} from 'lucide-react'

type Application = {
  id: string
  user_id: string | null
  email: string
  name: string
  organization: string
  role: string
  status: 'pending' | 'accepted' | 'rejected' | 'waitlisted'
  reason_for_applying: string
  requirements_for_protocol: string | null
  relevant_experience: string | null
  admin_notes: string[] | null
  submitted_at: string
  reviewed_at: string | null
  reviewed_by: string | null
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

export function ApplicationReview({
  application,
  currentUserId
}: {
  application: Application
  currentUserId: string
}) {
  const router = useRouter()
  const [status, setStatus] = useState(application.status)
  const [adminNotes, setAdminNotes] = useState<string[]>(application.admin_notes || [])
  const [newNote, setNewNote] = useState('')
  const [isEditingNotes, setIsEditingNotes] = useState(false)
  const [isUpdating, setIsUpdating] = useState(false)

  const supabase = createClient()

  const getStatusBadge = (status: Application['status']) => {
    const variants = {
      pending: { icon: Clock, className: 'bg-yellow-100 text-yellow-800 border-yellow-300' },
      accepted: { icon: CheckCircle, className: 'bg-green-100 text-green-800 border-green-300' },
      rejected: { icon: XCircle, className: 'bg-red-100 text-red-800 border-red-300' },
      waitlisted: { icon: AlertCircle, className: 'bg-blue-100 text-blue-800 border-blue-300' },
    }

    const { icon: Icon, className } = variants[status]
    return (
      <Badge className={className}>
        <Icon className="w-3 h-3 mr-1" />
        {status}
      </Badge>
    )
  }

  const updateStatus = async (newStatus: Application['status']) => {
    setIsUpdating(true)
    try {
      const { error } = await supabase
        .from('applications')
        .update({
          status: newStatus,
          reviewed_at: new Date().toISOString(),
          reviewed_by: currentUserId,
        })
        .eq('id', application.id)

      if (error) throw error

      setStatus(newStatus)
      toast.success(`Application ${newStatus}`)

      // TODO: Send notification email to applicant
    } catch (error) {
      console.error('Error updating status:', error)
      toast.error('Failed to update status')
    } finally {
      setIsUpdating(false)
    }
  }

  const saveAdminNotes = async () => {
    setIsUpdating(true)
    try {
      const updatedNotes = newNote
        ? [...adminNotes, `[${new Date().toLocaleString()}] ${newNote}`]
        : adminNotes

      const { error } = await supabase
        .from('applications')
        .update({ admin_notes: updatedNotes })
        .eq('id', application.id)

      if (error) throw error

      setAdminNotes(updatedNotes)
      setNewNote('')
      setIsEditingNotes(false)
      toast.success('Notes saved')
    } catch (error) {
      console.error('Error saving notes:', error)
      toast.error('Failed to save notes')
    } finally {
      setIsUpdating(false)
    }
  }

  const exportApplication = () => {
    const data = {
      ...application,
      exported_at: new Date().toISOString(),
      exported_by: currentUserId,
    }

    const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `application-${application.name.replace(/\s+/g, '-').toLowerCase()}-${application.id.slice(0, 8)}.json`
    a.click()
    URL.revokeObjectURL(url)
  }

  // Parse admin notes from the admin_notes array
  const parsedLinks = application.admin_notes?.find(note => note.startsWith('Links:'))?.replace('Links: ', '').split(', ').filter(l => l !== 'None') || []
  const travelReqs = application.admin_notes?.find(note => note.startsWith('Travel Requirements:'))?.replace('Travel Requirements: ', '') || 'None'
  const dietaryReqs = application.admin_notes?.find(note => note.startsWith('Dietary Restrictions:'))?.replace('Dietary Restrictions: ', '') || 'None'
  const availability = application.admin_notes?.find(note => note.startsWith('Availability Confirmed:'))?.includes('Yes') || false

  // Get only actual admin comments (not the structured data)
  const adminComments = adminNotes.filter(note =>
    !note.startsWith('Links:') &&
    !note.startsWith('Travel Requirements:') &&
    !note.startsWith('Dietary Restrictions:') &&
    !note.startsWith('Availability Confirmed:')
  )

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Header */}
        <div className="mb-6">
          <Button
            variant="ghost"
            onClick={() => router.push('/admin/applications')}
            className="mb-4"
          >
            <ArrowLeft className="mr-2 h-4 w-4" />
            Back to Applications
          </Button>

          <div className="flex items-start justify-between">
            <div>
              <h1 className="text-3xl font-bold text-gray-900">{application.name}</h1>
              <p className="mt-1 text-gray-600">{application.role} at {application.organization}</p>
              <div className="mt-2 flex items-center gap-4">
                <div className="flex items-center text-sm text-gray-500">
                  <Mail className="mr-1 h-4 w-4" />
                  {application.email}
                </div>
                <div className="flex items-center text-sm text-gray-500">
                  <Calendar className="mr-1 h-4 w-4" />
                  Submitted {new Date(application.submitted_at).toLocaleDateString()}
                </div>
              </div>
            </div>
            <div className="flex items-center gap-2">
              {getStatusBadge(status)}
              <Button variant="outline" size="sm" onClick={exportApplication}>
                <Download className="mr-2 h-4 w-4" />
                Export
              </Button>
            </div>
          </div>
        </div>

        {/* Quick Actions */}
        <Card className="mb-6">
          <CardHeader>
            <CardTitle>Application Decision</CardTitle>
            <CardDescription>Update the application status</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="flex gap-2">
              <Button
                onClick={() => updateStatus('accepted')}
                disabled={isUpdating || status === 'accepted'}
                className="bg-green-600 hover:bg-green-700"
              >
                <CheckCircle className="mr-2 h-4 w-4" />
                Accept
              </Button>
              <Button
                onClick={() => updateStatus('waitlisted')}
                disabled={isUpdating || status === 'waitlisted'}
                className="bg-blue-600 hover:bg-blue-700"
              >
                <AlertCircle className="mr-2 h-4 w-4" />
                Waitlist
              </Button>
              <Button
                onClick={() => updateStatus('rejected')}
                disabled={isUpdating || status === 'rejected'}
                variant="destructive"
              >
                <XCircle className="mr-2 h-4 w-4" />
                Reject
              </Button>
              <Button
                onClick={() => updateStatus('pending')}
                disabled={isUpdating || status === 'pending'}
                variant="outline"
              >
                <Clock className="mr-2 h-4 w-4" />
                Set Pending
              </Button>
            </div>
            {application.reviewed_at && (
              <div className="mt-4 text-sm text-gray-500">
                Last reviewed on {new Date(application.reviewed_at).toLocaleString()}
                {application.reviewer && ` by ${application.reviewer.name}`}
              </div>
            )}
          </CardContent>
        </Card>

        {/* Application Content Tabs */}
        <Tabs defaultValue="application" className="space-y-4">
          <TabsList className="grid w-full grid-cols-4">
            <TabsTrigger value="application">Application</TabsTrigger>
            <TabsTrigger value="logistics">Logistics</TabsTrigger>
            <TabsTrigger value="account">Account Info</TabsTrigger>
            <TabsTrigger value="admin">Admin Notes</TabsTrigger>
          </TabsList>

          <TabsContent value="application" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center">
                  <FileText className="mr-2 h-5 w-5" />
                  Application Responses
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-6">
                <div>
                  <h3 className="font-semibold mb-2 text-gray-700">
                    Why do you want to participate?
                  </h3>
                  <div className="prose prose-sm max-w-none">
                    <p className="text-gray-600 whitespace-pre-wrap">{application.reason_for_applying}</p>
                  </div>
                  <div className="mt-2 text-xs text-gray-500">
                    {application.reason_for_applying.split(/\s+/).length} words
                  </div>
                </div>

                <Separator />

                <div>
                  <h3 className="font-semibold mb-2 text-gray-700">
                    What requirements would you have for an attribution protocol?
                  </h3>
                  <div className="prose prose-sm max-w-none">
                    <p className="text-gray-600 whitespace-pre-wrap">
                      {application.requirements_for_protocol || 'No response provided'}
                    </p>
                  </div>
                  {application.requirements_for_protocol && (
                    <div className="mt-2 text-xs text-gray-500">
                      {application.requirements_for_protocol.split(/\s+/).length} words
                    </div>
                  )}
                </div>

                {application.relevant_experience && (
                  <>
                    <Separator />
                    <div>
                      <h3 className="font-semibold mb-2 text-gray-700">
                        Relevant Experience
                      </h3>
                      <div className="prose prose-sm max-w-none">
                        <p className="text-gray-600 whitespace-pre-wrap">{application.relevant_experience}</p>
                      </div>
                      <div className="mt-2 text-xs text-gray-500">
                        {application.relevant_experience.split(/\s+/).length} words
                      </div>
                    </div>
                  </>
                )}

                {parsedLinks.length > 0 && (
                  <>
                    <Separator />
                    <div>
                      <h3 className="font-semibold mb-2 text-gray-700 flex items-center">
                        <LinkIcon className="mr-2 h-4 w-4" />
                        Links to Previous Work
                      </h3>
                      <div className="space-y-1">
                        {parsedLinks.map((link, index) => (
                          <a
                            key={index}
                            href={link}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="block text-blue-600 hover:underline text-sm"
                          >
                            {link}
                          </a>
                        ))}
                      </div>
                    </div>
                  </>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="logistics" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle>Workshop Logistics</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <h3 className="font-semibold text-sm text-gray-700 mb-1">Availability Confirmed</h3>
                    <Badge variant={availability ? 'default' : 'secondary'}>
                      {availability ? 'Yes' : 'No'}
                    </Badge>
                  </div>
                  <div>
                    <h3 className="font-semibold text-sm text-gray-700 mb-1">Workshop Days</h3>
                    <p className="text-sm text-gray-600">June 7-11, 2026 (5 days)</p>
                  </div>
                </div>

                <Separator />

                <div>
                  <h3 className="font-semibold text-sm text-gray-700 mb-1">Travel Requirements</h3>
                  <p className="text-sm text-gray-600">{travelReqs}</p>
                </div>

                <div>
                  <h3 className="font-semibold text-sm text-gray-700 mb-1">Dietary Restrictions</h3>
                  <p className="text-sm text-gray-600">{dietaryReqs}</p>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="account" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center">
                  <User className="mr-2 h-5 w-5" />
                  Account Information
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <h3 className="font-semibold text-sm text-gray-700 mb-1">Account Status</h3>
                    <Badge variant={application.users ? 'default' : 'outline'}>
                      {application.users ? 'Account Created' : 'No Account'}
                    </Badge>
                  </div>
                  {application.users?.created_at && (
                    <div>
                      <h3 className="font-semibold text-sm text-gray-700 mb-1">Account Created</h3>
                      <p className="text-sm text-gray-600">
                        {new Date(application.users.created_at).toLocaleDateString()}
                      </p>
                    </div>
                  )}
                </div>

                {application.users && (
                  <>
                    <Separator />
                    <div>
                      <h3 className="font-semibold text-sm text-gray-700 mb-1">User ID</h3>
                      <code className="text-xs bg-gray-100 px-2 py-1 rounded">
                        {application.users.id}
                      </code>
                    </div>
                  </>
                )}

                {!application.users && (
                  <Alert>
                    <AlertCircle className="h-4 w-4" />
                    <AlertDescription>
                      This applicant has not yet created an account. They applied using the email-only application system.
                    </AlertDescription>
                  </Alert>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="admin" className="space-y-4">
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle className="flex items-center">
                    <MessageSquare className="mr-2 h-5 w-5" />
                    Admin Notes & Comments
                  </CardTitle>
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => setIsEditingNotes(!isEditingNotes)}
                  >
                    {isEditingNotes ? (
                      <>
                        <X className="mr-2 h-4 w-4" />
                        Cancel
                      </>
                    ) : (
                      <>
                        <Edit className="mr-2 h-4 w-4" />
                        Add Note
                      </>
                    )}
                  </Button>
                </div>
              </CardHeader>
              <CardContent className="space-y-4">
                {/* Existing Comments */}
                {adminComments.length > 0 ? (
                  <div className="space-y-2">
                    {adminComments.map((note, index) => (
                      <div key={index} className="p-3 bg-gray-50 rounded-lg">
                        <p className="text-sm text-gray-700">{note}</p>
                      </div>
                    ))}
                  </div>
                ) : (
                  <p className="text-sm text-gray-500">No admin notes yet.</p>
                )}

                {/* Add New Note */}
                {isEditingNotes && (
                  <div className="space-y-2 pt-4 border-t">
                    <textarea
                      value={newNote}
                      onChange={(e) => setNewNote(e.target.value)}
                      placeholder="Add your notes here..."
                      className="w-full min-h-[100px] px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                    />
                    <div className="flex justify-end gap-2">
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => {
                          setNewNote('')
                          setIsEditingNotes(false)
                        }}
                      >
                        Cancel
                      </Button>
                      <Button
                        size="sm"
                        onClick={saveAdminNotes}
                        disabled={isUpdating || !newNote.trim()}
                      >
                        <Save className="mr-2 h-4 w-4" />
                        Save Note
                      </Button>
                    </div>
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Application History */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center">
                  <History className="mr-2 h-5 w-5" />
                  Application History
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-2">
                  <div className="flex items-center text-sm">
                    <div className="w-32 text-gray-500">Submitted</div>
                    <div>{new Date(application.submitted_at).toLocaleString()}</div>
                  </div>
                  {application.reviewed_at && (
                    <div className="flex items-center text-sm">
                      <div className="w-32 text-gray-500">Last Reviewed</div>
                      <div>
                        {new Date(application.reviewed_at).toLocaleString()}
                        {application.reviewer && ` by ${application.reviewer.name}`}
                      </div>
                    </div>
                  )}
                  <div className="flex items-center text-sm">
                    <div className="w-32 text-gray-500">Current Status</div>
                    <div>{getStatusBadge(status)}</div>
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  )
}