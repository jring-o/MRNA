'use client'

import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Separator } from '@/components/ui/separator'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Alert, AlertDescription } from '@/components/ui/alert'
import { VotingPanel } from '@/components/admin/voting-panel'
import { CommentsPanel } from '@/components/admin/comments-panel'
import { InviteTokenGenerator } from '@/components/admin/invite-token-generator'
import type { ApplicationWithVoting } from '@/types/database'
import { parseWorkLinks, getClassificationDisplayName, getClassificationBadgeClass } from '@/types/database'
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
  Layers,
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
  const status = application.status

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
    a.download = `application-${(application.name || 'unknown').replace(/\s+/g, '-').toLowerCase()}-${application.id.slice(0, 8)}.json`
    a.click()
    URL.revokeObjectURL(url)
  }

  // Parse work links from JSONB
  const workLinks = parseWorkLinks(application.work_links)

  // Parse admin notes for logistics data
  const travelReqs = application.admin_notes?.find(note => note.startsWith('Travel Requirements:'))?.replace('Travel Requirements: ', '') || 'None'
  const dietaryReqs = application.admin_notes?.find(note => note.startsWith('Dietary Restrictions:'))?.replace('Dietary Restrictions: ', '') || 'None'
  const availability = application.admin_notes?.find(note => note.startsWith('Availability Confirmed:'))?.includes('Yes') || false

  // Check if voting is enabled (we have voting data)
  const hasVotingData = application.total_votes !== undefined && application.total_votes !== null

  // Helper to display classifications
  const getClassificationBadges = (classifications: string[], classificationOther: string | null) => {
    if (!classifications || classifications.length === 0) return null

    return (
      <div className="flex flex-wrap gap-2">
        {classifications.map((classification) => (
          <Badge
            key={classification}
            variant="outline"
            className={getClassificationBadgeClass(classification)}
          >
            <Layers className="mr-1 h-3 w-3" />
            {classification === 'other' && classificationOther
              ? classificationOther
              : getClassificationDisplayName(classification)}
          </Badge>
        ))}
      </div>
    )
  }

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
                  Submitted {application.submitted_at ? new Date(application.submitted_at).toLocaleDateString() : 'Unknown'}
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
            {/* Classifications Card */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center">
                  <Layers className="mr-2 h-5 w-5" />
                  Classifications
                </CardTitle>
              </CardHeader>
              <CardContent>
                {getClassificationBadges(application.classifications || [], application.classification_other || null)}
              </CardContent>
            </Card>

            {/* Universal Questions */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center">
                  <FileText className="mr-2 h-5 w-5" />
                  Universal Questions
                </CardTitle>
                <CardDescription>Questions answered by all applicants</CardDescription>
              </CardHeader>
              <CardContent className="space-y-6">
                <div>
                  <h3 className="font-semibold mb-2 text-gray-700">
                    Why is an interoperable Research attribution Schema important to you?
                  </h3>
                  <div className="prose prose-sm max-w-none">
                    <p className="text-gray-600 whitespace-pre-wrap">{application.importance_of_schema || 'No response'}</p>
                  </div>
                  {application.importance_of_schema && (
                    <div className="mt-2 text-xs text-gray-500">
                      {application.importance_of_schema.split(/\s+/).filter(w => w).length} words
                    </div>
                  )}
                </div>

                <Separator />

                <div>
                  <h3 className="font-semibold mb-2 text-gray-700">
                    What other science/infrastructure/open science projects are you excited about?
                  </h3>
                  <div className="prose prose-sm max-w-none">
                    <p className="text-gray-600 whitespace-pre-wrap">{application.excited_projects || 'No response'}</p>
                  </div>
                  {application.excited_projects && (
                    <div className="mt-2 text-xs text-gray-500">
                      {application.excited_projects.split(/\s+/).filter(w => w).length} words
                    </div>
                  )}
                </div>

                <Separator />

                <div>
                  <h3 className="font-semibold mb-2 text-gray-700 flex items-center">
                    <LinkIcon className="mr-2 h-4 w-4" />
                    Past/Current Work Examples
                  </h3>
                  {workLinks.length > 0 ? (
                    <div className="space-y-4">
                      {workLinks.map((item: { description?: string; role?: string; url?: string }, index: number) => (
                        <div key={index} className="border-l-2 border-blue-500 pl-4 py-2 bg-gray-50 rounded-r">
                          <div className="space-y-2">
                            <div>
                              <p className="text-xs font-medium text-gray-500 uppercase mb-1">Description</p>
                              <p className="text-sm text-gray-900 whitespace-pre-wrap">{item.description || 'No description'}</p>
                            </div>
                            <div>
                              <p className="text-xs font-medium text-gray-500 uppercase mb-1">Role</p>
                              <p className="text-sm text-gray-700">{item.role || 'No role specified'}</p>
                            </div>
                            {item.url && item.url.trim() !== '' && (
                              <div>
                                <p className="text-xs font-medium text-gray-500 uppercase mb-1">Link</p>
                                <a
                                  href={item.url}
                                  target="_blank"
                                  rel="noopener noreferrer"
                                  className="text-blue-600 hover:underline text-sm break-all"
                                >
                                  {item.url}
                                </a>
                              </div>
                            )}
                          </div>
                        </div>
                      ))}
                    </div>
                  ) : (
                    <p className="text-sm text-gray-500">No work examples provided</p>
                  )}
                </div>

                <Separator />

                <div>
                  <h3 className="font-semibold mb-2 text-gray-700">
                    What would you add to this workshop if you came?
                  </h3>
                  <div className="prose prose-sm max-w-none">
                    <p className="text-gray-600 whitespace-pre-wrap">{application.workshop_contribution || 'No response'}</p>
                  </div>
                  {application.workshop_contribution && (
                    <div className="mt-2 text-xs text-gray-500">
                      {application.workshop_contribution.split(/\s+/).filter(w => w).length} words
                    </div>
                  )}
                </div>

                <Separator />

                <div>
                  <h3 className="font-semibold mb-2 text-gray-700">
                    What elements or outputs of the research process would you define?
                  </h3>
                  <div className="prose prose-sm max-w-none">
                    <p className="text-gray-600 whitespace-pre-wrap">{application.research_elements || 'No response'}</p>
                  </div>
                  {application.research_elements && (
                    <div className="mt-2 text-xs text-gray-500">
                      {application.research_elements.split(/\s+/).filter(w => w).length} words
                    </div>
                  )}
                </div>
              </CardContent>
            </Card>

            {/* Role-Specific Questions */}
            {application.classifications?.includes('researcher') && (
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center">
                    <FileText className="mr-2 h-5 w-5 text-blue-600" />
                    Researcher Questions
                  </CardTitle>
                  <CardDescription>Specific to Researcher classification</CardDescription>
                </CardHeader>
                <CardContent className="space-y-6">
                  <div>
                    <h3 className="font-semibold mb-2 text-gray-700">
                      Immediate use-case for modular research sharing/attribution?
                    </h3>
                    <div className="prose prose-sm max-w-none">
                      <p className="text-gray-600 whitespace-pre-wrap">{application.researcher_use_case || 'No response'}</p>
                    </div>
                    {application.researcher_use_case && (
                      <div className="mt-2 text-xs text-gray-500">
                        {application.researcher_use_case.split(/\s+/).filter(w => w).length} words
                      </div>
                    )}
                  </div>

                  <Separator />

                  <div>
                    <h3 className="font-semibold mb-2 text-gray-700">
                      Future impact of granular research sharing?
                    </h3>
                    <div className="prose prose-sm max-w-none">
                      <p className="text-gray-600 whitespace-pre-wrap">{application.researcher_future_impact || 'No response'}</p>
                    </div>
                    {application.researcher_future_impact && (
                      <div className="mt-2 text-xs text-gray-500">
                        {application.researcher_future_impact.split(/\s+/).filter(w => w).length} words
                      </div>
                    )}
                  </div>
                </CardContent>
              </Card>
            )}

            {application.classifications?.includes('designer') && (
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center">
                    <FileText className="mr-2 h-5 w-5 text-pink-600" />
                    Designer Questions
                  </CardTitle>
                  <CardDescription>Specific to Designer classification</CardDescription>
                </CardHeader>
                <CardContent>
                  <div>
                    <h3 className="font-semibold mb-2 text-gray-700">
                      Important considerations for UX/design across platforms?
                    </h3>
                    <div className="prose prose-sm max-w-none">
                      <p className="text-gray-600 whitespace-pre-wrap">{application.designer_ux_considerations || 'No response'}</p>
                    </div>
                    {application.designer_ux_considerations && (
                      <div className="mt-2 text-xs text-gray-500">
                        {application.designer_ux_considerations.split(/\s+/).filter(w => w).length} words
                      </div>
                    )}
                  </div>
                </CardContent>
              </Card>
            )}

            {application.classifications?.includes('engineer') && (
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center">
                    <FileText className="mr-2 h-5 w-5 text-purple-600" />
                    Engineer Questions
                  </CardTitle>
                  <CardDescription>Specific to Engineer classification</CardDescription>
                </CardHeader>
                <CardContent className="space-y-6">
                  <div>
                    <h3 className="font-semibold mb-2 text-gray-700">
                      What are you working on that would use the schema - How?
                    </h3>
                    <div className="prose prose-sm max-w-none">
                      <p className="text-gray-600 whitespace-pre-wrap">{application.engineer_working_on || 'No response'}</p>
                    </div>
                    {application.engineer_working_on && (
                      <div className="mt-2 text-xs text-gray-500">
                        {application.engineer_working_on.split(/\s+/).filter(w => w).length} words
                      </div>
                    )}
                  </div>

                  <Separator />

                  <div>
                    <h3 className="font-semibold mb-2 text-gray-700">
                      Important considerations for designing shared schema/crosswalks?
                    </h3>
                    <div className="prose prose-sm max-w-none">
                      <p className="text-gray-600 whitespace-pre-wrap">{application.engineer_schema_considerations || 'No response'}</p>
                    </div>
                    {application.engineer_schema_considerations && (
                      <div className="mt-2 text-xs text-gray-500">
                        {application.engineer_schema_considerations.split(/\s+/).filter(w => w).length} words
                      </div>
                    )}
                  </div>
                </CardContent>
              </Card>
            )}

            {application.classifications?.includes('conceptionalist') && (
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center">
                    <FileText className="mr-2 h-5 w-5 text-amber-600" />
                    Conceptionalist Questions
                  </CardTitle>
                  <CardDescription>Specific to Conceptionalist classification</CardDescription>
                </CardHeader>
                <CardContent className="space-y-6">
                  <div>
                    <h3 className="font-semibold mb-2 text-gray-700">
                      What would schema unlock for existing projects?
                    </h3>
                    <div className="prose prose-sm max-w-none">
                      <p className="text-gray-600 whitespace-pre-wrap">{application.conceptionalist_unlock || 'No response'}</p>
                    </div>
                    {application.conceptionalist_unlock && (
                      <div className="mt-2 text-xs text-gray-500">
                        {application.conceptionalist_unlock.split(/\s+/).filter(w => w).length} words
                      </div>
                    )}
                  </div>

                  <Separator />

                  <div>
                    <h3 className="font-semibold mb-2 text-gray-700">
                      What new projects might schema enable?
                    </h3>
                    <div className="prose prose-sm max-w-none">
                      <p className="text-gray-600 whitespace-pre-wrap">{application.conceptionalist_enable || 'No response'}</p>
                    </div>
                    {application.conceptionalist_enable && (
                      <div className="mt-2 text-xs text-gray-500">
                        {application.conceptionalist_enable.split(/\s+/).filter(w => w).length} words
                      </div>
                    )}
                  </div>
                </CardContent>
              </Card>
            )}
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

            {/* Invite Token Generator for accepted applications */}
            <InviteTokenGenerator
              applicationId={application.id}
              applicationEmail={application.email || ''}
              applicationStatus={application.status}
              applicantName={application.name || ''}
            />
          </TabsContent>
        </Tabs>
      </div>
    </div>
  )
}