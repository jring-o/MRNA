'use client'

import { useState, useMemo, useEffect, useCallback } from 'react'
import Link from 'next/link'
import { useSearchParams, useRouter, usePathname } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Badge } from '@/components/ui/badge'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
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
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu'
import { Checkbox } from '@/components/ui/checkbox'
import { SendEmailDialog } from '@/components/admin/send-email-dialog'
import { AddPersonDialog } from '@/components/admin/add-person-dialog'
import { toast } from 'sonner'
import { getClassificationDisplayName, getClassificationBadgeClass } from '@/types/database'
import {
  Search,
  Filter,
  Download,
  MoreVertical,
  Eye,
  CheckCircle,
  XCircle,
  Clock,
  AlertCircle,
  ChevronUp,
  ChevronDown,
  ChevronsUpDown,
  Send,
  RefreshCw,
  Shield,
  Trash2,
} from 'lucide-react'

type Application = {
  id: string
  user_id: string | null
  email: string | null
  name: string | null
  organization: string | null
  role: string
  status: 'pending' | 'accepted' | 'rejected' | 'waitlisted'
  classifications: string[]
  classification_other: string | null
  admin_notes: string[] | null
  submitted_at: string | null
  reviewed_at: string | null
  reviewed_by: string | null
  users?: {
    id: string
    name: string
    email: string
    organization: string | null
  } | null
}

type SortField = 'submitted_at' | 'name' | 'organization' | 'status' | 'classifications'
type SortOrder = 'asc' | 'desc'

const SUPER_ADMIN_EMAIL = 'jon@scios.tech'

export function ApplicationsTable({
  initialApplications,
  userEmail,
  currentUserId,
}: {
  initialApplications: Application[]
  userEmail: string
  currentUserId: string
}) {
  const searchParams = useSearchParams()
  const router = useRouter()
  const pathname = usePathname()

  const [applications, setApplications] = useState<Application[]>(initialApplications)
  const isSuperAdmin = userEmail === SUPER_ADMIN_EMAIL
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set())

  // Initialize filters from URL params
  const [searchTerm, setSearchTerm] = useState(searchParams.get('search') || '')
  const [statusFilter, setStatusFilter] = useState<string>(searchParams.get('status') || 'all')
  const [sortField, setSortField] = useState<SortField>((searchParams.get('sort') as SortField) || 'submitted_at')
  const [sortOrder, setSortOrder] = useState<SortOrder>((searchParams.get('order') as SortOrder) || 'desc')
  const [emailSentMap, setEmailSentMap] = useState<Map<string, boolean>>(new Map())
  const [waitlistEmailSentMap, setWaitlistEmailSentMap] = useState<Map<string, boolean>>(new Map())
  const [emailDialogOpen, setEmailDialogOpen] = useState(false)
  const [emailApplicants, setEmailApplicants] = useState<Application[]>([])
  const [waitlistEmailDialogOpen, setWaitlistEmailDialogOpen] = useState(false)
  const [waitlistEmailApplicants, setWaitlistEmailApplicants] = useState<Application[]>([])

  const supabase = createClient()

  // Update URL when filters change
  const updateURL = useCallback((params: { search?: string; status?: string; sort?: string; order?: string }) => {
    const newParams = new URLSearchParams(searchParams.toString())

    Object.entries(params).forEach(([key, value]) => {
      if (value && value !== 'all' && value !== '' && !(key === 'sort' && value === 'submitted_at') && !(key === 'order' && value === 'desc')) {
        newParams.set(key, value)
      } else {
        newParams.delete(key)
      }
    })

    const queryString = newParams.toString()
    router.replace(`${pathname}${queryString ? `?${queryString}` : ''}`, { scroll: false })
  }, [searchParams, router, pathname])

  // Refresh applications list
  const refreshApplications = async () => {
    const { data } = await supabase
      .from('applications')
      .select('*')
      .order('submitted_at', { ascending: false })
    if (data) {
      setApplications(data)
    }
  }

  // Direct approve function (super admin only)
  const directApprove = async (appId: string) => {
    if (!isSuperAdmin) return

    try {
      const { error } = await supabase
        .from('applications')
        .update({
          status: 'accepted',
          reviewed_at: new Date().toISOString(),
          reviewed_by: currentUserId,
          voting_completed: true,
          voting_completed_at: new Date().toISOString(),
        })
        .eq('id', appId)

      if (error) {
        throw error
      }

      toast.success('Application directly approved')
      refreshApplications()
    } catch (error) {
      console.error('Error approving application:', error)
      toast.error('Failed to approve application')
    }
  }

  // Direct waitlist function (super admin only)
  const directWaitlist = async (appId: string) => {
    if (!isSuperAdmin) return

    try {
      const { error } = await supabase
        .from('applications')
        .update({
          status: 'waitlisted',
          reviewed_at: new Date().toISOString(),
          reviewed_by: currentUserId,
        })
        .eq('id', appId)

      if (error) {
        throw error
      }

      toast.success('Application added to waitlist')
      refreshApplications()
    } catch (error) {
      console.error('Error waitlisting application:', error)
      toast.error('Failed to add to waitlist')
    }
  }

  // Remove application function (super admin only)
  const removeApplication = async (appId: string) => {
    console.log('[removeApplication] Called with appId:', appId)
    console.log('[removeApplication] isSuperAdmin:', isSuperAdmin)
    console.log('[removeApplication] userEmail:', userEmail)

    if (!isSuperAdmin) {
      console.log('[removeApplication] Not super admin, returning early')
      return
    }

    console.log('[removeApplication] Showing confirm dialog...')
    const confirmed = confirm('Are you sure you want to remove this application? This action cannot be undone.')
    console.log('[removeApplication] User confirmed:', confirmed)

    if (!confirmed) {
      console.log('[removeApplication] User cancelled, returning')
      return
    }

    try {
      console.log('[removeApplication] Attempting to delete from database...')
      const { data, error, status, statusText } = await supabase
        .from('applications')
        .delete()
        .eq('id', appId)
        .select()

      console.log('[removeApplication] Delete response:', { data, error, status, statusText })

      if (error) {
        console.error('[removeApplication] Supabase error:', error)
        throw error
      }

      console.log('[removeApplication] Delete successful, refreshing applications...')
      toast.success('Application removed')
      await refreshApplications()
      console.log('[removeApplication] Refresh complete')
    } catch (error) {
      console.error('[removeApplication] Caught error:', error)
      toast.error('Failed to remove application')
    }
  }

  // Check for existing invite tokens on mount
  useEffect(() => {
    const checkExistingTokens = async () => {
      const acceptedApps = applications.filter(app => app.status === 'accepted')
      if (acceptedApps.length === 0) return

      const { data: tokens } = await supabase
        .from('invite_tokens')
        .select('application_id')
        .in('application_id', acceptedApps.map(app => app.id))

      if (tokens) {
        const sentMap = new Map<string, boolean>()
        tokens.forEach(token => {
          if (token.application_id) {
            sentMap.set(token.application_id, true)
          }
        })
        setEmailSentMap(sentMap)
      }
    }

    checkExistingTokens()
  }, [applications, supabase])

  // Filter and sort applications
  const filteredApplications = useMemo(() => {
    let filtered = [...applications]

    // Search filter
    if (searchTerm) {
      filtered = filtered.filter(app =>
        app.name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
        app.email?.toLowerCase().includes(searchTerm.toLowerCase()) ||
        app.organization?.toLowerCase().includes(searchTerm.toLowerCase()) ||
        app.role?.toLowerCase().includes(searchTerm.toLowerCase())
      )
    }

    // Status filter
    if (statusFilter !== 'all') {
      filtered = filtered.filter(app => app.status === statusFilter)
    }

    // Sort
    filtered.sort((a, b) => {
      let aValue: string | number | Date | null = a[sortField] as string | number | Date | null
      let bValue: string | number | Date | null = b[sortField] as string | number | Date | null

      if (sortField === 'submitted_at') {
        aValue = a.submitted_at ? new Date(a.submitted_at).getTime() : 0
        bValue = b.submitted_at ? new Date(b.submitted_at).getTime() : 0
      }

      if (sortField === 'classifications') {
        // Sort by first classification alphabetically
        aValue = a.classifications?.[0]?.toLowerCase() || ''
        bValue = b.classifications?.[0]?.toLowerCase() || ''
      }

      // Handle null values
      if (aValue === null) aValue = ''
      if (bValue === null) bValue = ''

      if (sortOrder === 'asc') {
        return aValue > bValue ? 1 : -1
      } else {
        return aValue < bValue ? 1 : -1
      }
    })

    return filtered
  }, [applications, searchTerm, statusFilter, sortField, sortOrder])

  // Send acceptance email to single applicant
  const sendAcceptanceEmail = async (applicant: Application) => {
    try {
      const response = await fetch('/api/emails/send-invite', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          applicationId: applicant.id,
          applicantEmail: applicant.email,
          applicantName: applicant.name,
        }),
      })

      if (!response.ok) {
        throw new Error('Failed to send email')
      }

      // Mark as sent in local state
      setEmailSentMap(prev => new Map(prev).set(applicant.id, true))
      return true
    } catch (error) {
      console.error('Error sending email:', error)
      throw error
    }
  }

  // Send acceptance emails to multiple applicants (sequentially to avoid rate limits)
  const sendBulkAcceptanceEmails = async () => {
    const eligible = emailApplicants.filter(app => app.status === 'accepted')
    let successful = 0
    let failed = 0

    for (const app of eligible) {
      try {
        await sendAcceptanceEmail(app)
        successful++
      } catch {
        failed++
      }
      // Wait 1.5s between sends to stay under Resend rate limits
      if (successful + failed < eligible.length) {
        await new Promise(resolve => setTimeout(resolve, 1500))
      }
    }

    if (failed > 0) {
      toast.warning(`Sent ${successful} email(s), ${failed} failed`)
    } else {
      toast.success(`Successfully sent ${successful} acceptance email(s)`)
    }
  }

  // Send waitlist email to single applicant
  const sendWaitlistEmail = async (applicant: Application) => {
    try {
      const response = await fetch('/api/emails/send-waitlist', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          applicationId: applicant.id,
          applicantEmail: applicant.email,
          applicantName: applicant.name,
        }),
      })

      if (!response.ok) {
        throw new Error('Failed to send email')
      }

      // Mark as sent in local state
      setWaitlistEmailSentMap(prev => new Map(prev).set(applicant.id, true))
      return true
    } catch (error) {
      console.error('Error sending waitlist email:', error)
      throw error
    }
  }

  // Send waitlist emails to multiple applicants (sequentially to avoid rate limits)
  const sendBulkWaitlistEmails = async () => {
    const eligible = waitlistEmailApplicants.filter(app => app.status === 'waitlisted')
    let successful = 0
    let failed = 0

    for (const app of eligible) {
      try {
        await sendWaitlistEmail(app)
        successful++
      } catch {
        failed++
      }
      // Wait 1.5s between sends to stay under Resend rate limits
      if (successful + failed < eligible.length) {
        await new Promise(resolve => setTimeout(resolve, 1500))
      }
    }

    if (failed > 0) {
      toast.warning(`Sent ${successful} waitlist email(s), ${failed} failed`)
    } else {
      toast.success(`Successfully sent ${successful} waitlist email(s)`)
    }
  }

  // Open email dialog for single applicant
  const openEmailDialog = (applicant: Application) => {
    setEmailApplicants([applicant])
    setEmailDialogOpen(true)
  }

  // Open email dialog for selected applicants
  const openBulkEmailDialog = () => {
    const selected = applications.filter(app => selectedIds.has(app.id))
    setEmailApplicants(selected)
    setEmailDialogOpen(true)
  }

  // Open waitlist email dialog for single applicant
  const openWaitlistEmailDialog = (applicant: Application) => {
    setWaitlistEmailApplicants([applicant])
    setWaitlistEmailDialogOpen(true)
  }

  // Open waitlist email dialog for selected applicants
  const openBulkWaitlistEmailDialog = () => {
    const selected = applications.filter(app => selectedIds.has(app.id))
    setWaitlistEmailApplicants(selected)
    setWaitlistEmailDialogOpen(true)
  }

  // Export to CSV
  const exportToCSV = () => {
    const csv = [
      ['Name', 'Email', 'Organization', 'Role', 'Classifications', 'Status', 'Submitted At'],
      ...filteredApplications.map(app => [
        app.name || '',
        app.email || '',
        app.organization || '',
        app.role,
        app.classifications?.map(c => c === 'other' && app.classification_other ? app.classification_other : c).join('; ') || '',
        app.status,
        app.submitted_at ? new Date(app.submitted_at).toLocaleDateString() : '',
      ])
    ].map(row => row.map(cell => `"${cell}"`).join(',')).join('\n')

    const blob = new Blob([csv], { type: 'text/csv' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `applications-${new Date().toISOString().split('T')[0]}.csv`
    a.click()
    URL.revokeObjectURL(url)
  }

  // Toggle selection
  const toggleSelection = (id: string) => {
    const newSelection = new Set(selectedIds)
    if (newSelection.has(id)) {
      newSelection.delete(id)
    } else {
      newSelection.add(id)
    }
    setSelectedIds(newSelection)
  }

  const toggleAllSelection = () => {
    if (selectedIds.size === filteredApplications.length) {
      setSelectedIds(new Set())
    } else {
      setSelectedIds(new Set(filteredApplications.map(app => app.id)))
    }
  }

  // Sort handler
  const handleSort = (field: SortField) => {
    let newOrder: SortOrder = 'desc'
    if (sortField === field) {
      newOrder = sortOrder === 'asc' ? 'desc' : 'asc'
      setSortOrder(newOrder)
    } else {
      setSortField(field)
      setSortOrder('desc')
    }
    updateURL({ search: searchTerm, status: statusFilter, sort: field, order: newOrder })
  }

  const getSortIcon = (field: SortField) => {
    if (sortField !== field) return <ChevronsUpDown className="ml-1 h-4 w-4 opacity-50" />
    return sortOrder === 'asc'
      ? <ChevronUp className="ml-1 h-4 w-4" />
      : <ChevronDown className="ml-1 h-4 w-4" />
  }

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

  const getClassificationBadges = (classifications: string[], classificationOther: string | null) => {
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
      {/* Filters and Actions */}
      <div className="bg-white rounded-lg shadow p-4">
        <div className="flex flex-col lg:flex-row gap-4">
          {/* Search */}
          <div className="relative flex-1">
            <Search className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
            <Input
              placeholder="Search by name, email, organization, or role..."
              value={searchTerm}
              onChange={(e) => {
                setSearchTerm(e.target.value)
                updateURL({ search: e.target.value, status: statusFilter, sort: sortField, order: sortOrder })
              }}
              className="pl-10"
            />
          </div>

          {/* Status Filter */}
          <Select value={statusFilter} onValueChange={(value) => {
            setStatusFilter(value)
            updateURL({ search: searchTerm, status: value, sort: sortField, order: sortOrder })
          }}>
            <SelectTrigger className="w-[180px]">
              <Filter className="mr-2 h-4 w-4" />
              <SelectValue placeholder="Filter by status" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All Status</SelectItem>
              <SelectItem value="pending">Pending</SelectItem>
              <SelectItem value="accepted">Accepted</SelectItem>
              <SelectItem value="rejected">Rejected</SelectItem>
              <SelectItem value="waitlisted">Waitlisted</SelectItem>
            </SelectContent>
          </Select>

          {/* Export Button */}
          <Button variant="outline" onClick={exportToCSV}>
            <Download className="mr-2 h-4 w-4" />
            Export CSV
          </Button>

          {/* Super Admin: Add Person Button */}
          {isSuperAdmin && (
            <AddPersonDialog onPersonAdded={refreshApplications} />
          )}
        </div>

        {/* Bulk Actions */}
        {selectedIds.size > 0 && (
          <div className="mt-4 flex items-center gap-4 p-3 bg-blue-50 rounded-lg">
            <span className="text-sm text-blue-900">
              {selectedIds.size} application{selectedIds.size > 1 ? 's' : ''} selected
            </span>
            <div className="flex gap-2">
              <Button
                size="sm"
                variant="outline"
                onClick={openBulkEmailDialog}
                className="border-blue-600 text-blue-600 hover:bg-blue-50"
              >
                <Send className="mr-2 h-4 w-4" />
                Send Acceptance Emails
              </Button>
              <Button
                size="sm"
                variant="outline"
                onClick={openBulkWaitlistEmailDialog}
                className="border-amber-600 text-amber-600 hover:bg-amber-50"
              >
                <Send className="mr-2 h-4 w-4" />
                Send Waitlist Emails
              </Button>
            </div>
            <Button
              size="sm"
              variant="ghost"
              onClick={() => setSelectedIds(new Set())}
            >
              Clear Selection
            </Button>
          </div>
        )}
      </div>

      {/* Applications Table */}
      <div className="bg-white rounded-lg shadow overflow-hidden">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead className="w-12">
                <Checkbox
                  checked={selectedIds.size === filteredApplications.length && filteredApplications.length > 0}
                  onCheckedChange={toggleAllSelection}
                />
              </TableHead>
              <TableHead>
                <button
                  className="flex items-center font-medium hover:text-gray-900"
                  onClick={() => handleSort('name')}
                >
                  Applicant
                  {getSortIcon('name')}
                </button>
              </TableHead>
              <TableHead>
                <button
                  className="flex items-center font-medium hover:text-gray-900"
                  onClick={() => handleSort('organization')}
                >
                  Organization
                  {getSortIcon('organization')}
                </button>
              </TableHead>
              <TableHead>Role</TableHead>
              <TableHead>
                <button
                  className="flex items-center font-medium hover:text-gray-900"
                  onClick={() => handleSort('classifications')}
                >
                  Classifications
                  {getSortIcon('classifications')}
                </button>
              </TableHead>
              <TableHead>
                <button
                  className="flex items-center font-medium hover:text-gray-900"
                  onClick={() => handleSort('status')}
                >
                  Status
                  {getSortIcon('status')}
                </button>
              </TableHead>
              <TableHead>
                <button
                  className="flex items-center font-medium hover:text-gray-900"
                  onClick={() => handleSort('submitted_at')}
                >
                  Submitted
                  {getSortIcon('submitted_at')}
                </button>
              </TableHead>
              <TableHead className="text-right">Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {filteredApplications.map((application) => (
              <TableRow key={application.id}>
                <TableCell>
                  <Checkbox
                    checked={selectedIds.has(application.id)}
                    onCheckedChange={() => toggleSelection(application.id)}
                  />
                </TableCell>
                <TableCell>
                  <div>
                    <div className="font-medium">{application.name || 'N/A'}</div>
                    <div className="text-sm text-gray-500">{application.email || 'N/A'}</div>
                  </div>
                </TableCell>
                <TableCell>{application.organization || 'N/A'}</TableCell>
                <TableCell>
                  <div className="text-sm">{application.role}</div>
                </TableCell>
                <TableCell>
                  {application.classifications && application.classifications.length > 0
                    ? getClassificationBadges(application.classifications, application.classification_other)
                    : <span className="text-sm text-gray-400">N/A</span>
                  }
                </TableCell>
                <TableCell>{getStatusBadge(application.status)}</TableCell>
                <TableCell>
                  <div className="text-sm">
                    {application.submitted_at ? new Date(application.submitted_at).toLocaleDateString() : 'N/A'}
                  </div>
                  <div className="text-xs text-gray-500">
                    {application.submitted_at ? new Date(application.submitted_at).toLocaleTimeString() : ''}
                  </div>
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
                        <Link href={`/admin/applications/${application.id}`}>
                          <Eye className="mr-2 h-4 w-4" />
                          View Details
                        </Link>
                      </DropdownMenuItem>
                      {/* Super Admin: Direct Approve */}
                      {isSuperAdmin && application.status !== 'accepted' && (
                        <>
                          <DropdownMenuSeparator />
                          <DropdownMenuItem
                            onClick={() => directApprove(application.id)}
                            className="text-green-600 focus:text-green-600 focus:bg-green-50"
                          >
                            <Shield className="mr-2 h-4 w-4" />
                            Direct Approve
                          </DropdownMenuItem>
                        </>
                      )}
                      {/* Super Admin: Direct Waitlist */}
                      {isSuperAdmin && application.status !== 'waitlisted' && application.status !== 'accepted' && (
                        <DropdownMenuItem
                          onClick={() => directWaitlist(application.id)}
                          className="text-amber-600 focus:text-amber-600 focus:bg-amber-50"
                        >
                          <Clock className="mr-2 h-4 w-4" />
                          Direct Waitlist
                        </DropdownMenuItem>
                      )}
                      {/* Super Admin: Remove Application */}
                      {isSuperAdmin && (
                        <>
                          <DropdownMenuSeparator />
                          <DropdownMenuItem
                            onClick={() => removeApplication(application.id)}
                            className="text-red-600 focus:text-red-600 focus:bg-red-50"
                          >
                            <Trash2 className="mr-2 h-4 w-4" />
                            Remove
                          </DropdownMenuItem>
                        </>
                      )}
                      {application.status === 'accepted' && (
                        <>
                          <DropdownMenuSeparator />
                          <DropdownMenuItem
                            onClick={() => openEmailDialog(application)}
                          >
                            {emailSentMap.get(application.id) ? (
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
                        </>
                      )}
                      {application.status === 'waitlisted' && (
                        <>
                          <DropdownMenuSeparator />
                          <DropdownMenuItem
                            onClick={() => openWaitlistEmailDialog(application)}
                          >
                            {waitlistEmailSentMap.get(application.id) ? (
                              <>
                                <RefreshCw className="mr-2 h-4 w-4 text-amber-600" />
                                Resend Waitlist Email
                              </>
                            ) : (
                              <>
                                <Send className="mr-2 h-4 w-4 text-amber-600" />
                                Send Waitlist Email
                              </>
                            )}
                          </DropdownMenuItem>
                        </>
                      )}
                    </DropdownMenuContent>
                  </DropdownMenu>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>

        {filteredApplications.length === 0 && (
          <div className="text-center py-12 text-gray-500">
            No applications found matching your criteria.
          </div>
        )}
      </div>

      {/* Results Summary */}
      <div className="text-sm text-gray-600 text-right">
        Showing {filteredApplications.length} of {applications.length} applications
      </div>

      {/* Email Confirmation Dialog */}
      <SendEmailDialog
        open={emailDialogOpen}
        onOpenChange={setEmailDialogOpen}
        applicants={emailApplicants}
        onSend={sendBulkAcceptanceEmails}
        isResend={emailApplicants.length === 1 && emailSentMap.get(emailApplicants[0]?.id) === true}
        emailType="acceptance"
      />

      {/* Waitlist Email Confirmation Dialog */}
      <SendEmailDialog
        open={waitlistEmailDialogOpen}
        onOpenChange={setWaitlistEmailDialogOpen}
        applicants={waitlistEmailApplicants}
        onSend={sendBulkWaitlistEmails}
        isResend={waitlistEmailApplicants.length === 1 && waitlistEmailSentMap.get(waitlistEmailApplicants[0]?.id) === true}
        emailType="waitlist"
      />
    </div>
  )
}