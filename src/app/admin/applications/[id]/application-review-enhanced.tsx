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
import { VotingPanel } from '@/components/admin/voting-panel'
import { CommentsPanel } from '@/components/admin/comments-panel'
import type { ApplicationWithVoting } from '@/types/database'
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
  Download,
  Users,
  Vote,
} from 'lucide-react'

// Extended Application type that includes voting fields and relations
type Application = ApplicationWithVoting & {
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
        } as never)
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

  // Parse admin notes from the admin_notes array (if any legacy data exists)
  const parsedLinks = application.admin_notes?.find(note => note.startsWith('Links:'))?.replace('Links: ', '').split(', ').filter(l => l !== 'None') || []
  const travelReqs = application.admin_notes?.find(note => note.startsWith('Travel Requirements:'))?.replace('Travel Requirements: ', '') || 'None'
  const dietaryReqs = application.admin_notes?.find(note => note.startsWith('Dietary Restrictions:'))?.replace('Dietary Restrictions: ', '') || 'None'
  const availability = application.admin_notes?.find(note => note.startsWith('Availability Confirmed:'))?.includes('Yes') || false

  // Check if voting is enabled (we have voting data)
  const hasVotingData = application.total_votes !== undefined && application.total_votes !== null

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
                {hasVotingData && (
                  <div className="flex items-center text-sm text-gray-500">
                    <Users className="mr-1 h-4 w-4" />
                    {application.total_votes} votes
                  </div>
                )}
              </div>
            </div>
            <div className="flex items-center gap-2">
              {getStatusBadge(status)}
              {application.voting_completed && (
                <Badge className="bg-purple-100 text-purple-800 border-purple-300">
                  <Vote className="mr-1 h-3 w-3" />
                  Voted
                </Badge>
              )}
              <Button variant="outline" size="sm" onClick={exportApplication}>
                <Download className="mr-2 h-4 w-4" />
                Export
              </Button>
            </div>
          </div>
        </div>

        {/* Quick Actions (only show if voting is not enabled or voting is complete) */}
        {(!hasVotingData || application.voting_completed) && (
          <Card className="mb-6">
            <CardHeader>
              <CardTitle>Application Decision</CardTitle>
              <CardDescription>
                {hasVotingData && application.voting_completed
                  ? 'Voting is complete. You can now make the final decision.'
                  : 'Update the application status'
                }
              </CardDescription>
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
        )}

        {/* Application Content Tabs */}
        <Tabs defaultValue="application" className="space-y-4">
          <TabsList className={hasVotingData ? "grid w-full grid-cols-5" : "grid w-full grid-cols-4"}>
            <TabsTrigger value="application">Application</TabsTrigger>
            {hasVotingData && <TabsTrigger value="voting">Voting</TabsTrigger>}
            <TabsTrigger value="comments">Comments</TabsTrigger>
            <TabsTrigger value="logistics">Logistics</TabsTrigger>
            <TabsTrigger value="account">Account</TabsTrigger>
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

          {hasVotingData && (
            <TabsContent value="voting" className="space-y-4">
              <VotingPanel
                application={application}
                currentUserId={currentUserId}
                onVoteChange={() => router.refresh()}
              />
            </TabsContent>
          )}

          <TabsContent value="comments" className="space-y-4">
            <CommentsPanel
              applicationId={application.id}
              currentUserId={currentUserId}
              isApplicantView={false}
              onCommentAdded={() => router.refresh()}
            />
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
                    <p className="text-sm text-gray-600">Spring 2026 (4 days)</p>
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
        </Tabs>
      </div>
    </div>
  )
}