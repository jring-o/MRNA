'use client'

import { useState, useMemo } from 'react'
import Link from 'next/link'
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
import { toast } from 'sonner'
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
} from 'lucide-react'

type Application = {
  id: string
  user_id: string | null
  email: string | null
  name: string | null
  organization: string | null
  role: string
  status: 'pending' | 'accepted' | 'rejected' | 'waitlisted'
  reason_for_applying: string
  requirements_for_protocol: string | null
  relevant_experience: string | null
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

type SortField = 'submitted_at' | 'name' | 'organization' | 'status'
type SortOrder = 'asc' | 'desc'

export function ApplicationsTable({ initialApplications }: { initialApplications: Application[] }) {
  const [applications, setApplications] = useState<Application[]>(initialApplications)
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set())
  const [searchTerm, setSearchTerm] = useState('')
  const [statusFilter, setStatusFilter] = useState<string>('all')
  const [sortField, setSortField] = useState<SortField>('submitted_at')
  const [sortOrder, setSortOrder] = useState<SortOrder>('desc')
  const [isUpdating, setIsUpdating] = useState(false)

  const supabase = createClient()

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
      let aValue: string | number | Date | null = a[sortField]
      let bValue: string | number | Date | null = b[sortField]

      if (sortField === 'submitted_at') {
        aValue = a.submitted_at ? new Date(a.submitted_at).getTime() : 0
        bValue = b.submitted_at ? new Date(b.submitted_at).getTime() : 0
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

  // Handle status update for single application
  const updateStatus = async (id: string, newStatus: Application['status']) => {
    setIsUpdating(true)
    try {
      const { error } = await supabase
        .from('applications')
        .update({
          status: newStatus,
          reviewed_at: new Date().toISOString(),
        })
        .eq('id', id)

      if (error) throw error

      // Update local state
      setApplications(apps =>
        apps.map(app =>
          app.id === id
            ? { ...app, status: newStatus, reviewed_at: new Date().toISOString() }
            : app
        )
      )

      toast.success(`Application ${newStatus}`)
    } catch (error) {
      console.error('Error updating status:', error)
      toast.error('Failed to update status')
    } finally {
      setIsUpdating(false)
    }
  }

  // Handle bulk status update
  const bulkUpdateStatus = async (newStatus: Application['status']) => {
    if (selectedIds.size === 0) {
      toast.error('No applications selected')
      return
    }

    setIsUpdating(true)
    try {
      const { error } = await supabase
        .from('applications')
        .update({
          status: newStatus,
          reviewed_at: new Date().toISOString(),
        })
        .in('id', Array.from(selectedIds))

      if (error) throw error

      // Update local state
      setApplications(apps =>
        apps.map(app =>
          selectedIds.has(app.id)
            ? { ...app, status: newStatus, reviewed_at: new Date().toISOString() }
            : app
        )
      )

      setSelectedIds(new Set())
      toast.success(`${selectedIds.size} applications updated`)
    } catch (error) {
      console.error('Error updating status:', error)
      toast.error('Failed to update applications')
    } finally {
      setIsUpdating(false)
    }
  }

  // Export to CSV
  const exportToCSV = () => {
    const csv = [
      ['Name', 'Email', 'Organization', 'Role', 'Status', 'Submitted At', 'Reason', 'Requirements', 'Experience'],
      ...filteredApplications.map(app => [
        app.name || '',
        app.email || '',
        app.organization || '',
        app.role,
        app.status,
        app.submitted_at ? new Date(app.submitted_at).toLocaleDateString() : '',
        app.reason_for_applying,
        app.requirements_for_protocol || '',
        app.relevant_experience || '',
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
    if (sortField === field) {
      setSortOrder(sortOrder === 'asc' ? 'desc' : 'asc')
    } else {
      setSortField(field)
      setSortOrder('desc')
    }
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
              onChange={(e) => setSearchTerm(e.target.value)}
              className="pl-10"
            />
          </div>

          {/* Status Filter */}
          <Select value={statusFilter} onValueChange={setStatusFilter}>
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
                onClick={() => bulkUpdateStatus('accepted')}
                disabled={isUpdating}
              >
                Accept All
              </Button>
              <Button
                size="sm"
                variant="outline"
                onClick={() => bulkUpdateStatus('waitlisted')}
                disabled={isUpdating}
              >
                Waitlist All
              </Button>
              <Button
                size="sm"
                variant="outline"
                onClick={() => bulkUpdateStatus('rejected')}
                disabled={isUpdating}
              >
                Reject All
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
                      <DropdownMenuSeparator />
                      <DropdownMenuItem
                        onClick={() => updateStatus(application.id, 'accepted')}
                        disabled={isUpdating}
                      >
                        <CheckCircle className="mr-2 h-4 w-4 text-green-600" />
                        Accept
                      </DropdownMenuItem>
                      <DropdownMenuItem
                        onClick={() => updateStatus(application.id, 'waitlisted')}
                        disabled={isUpdating}
                      >
                        <AlertCircle className="mr-2 h-4 w-4 text-blue-600" />
                        Waitlist
                      </DropdownMenuItem>
                      <DropdownMenuItem
                        onClick={() => updateStatus(application.id, 'rejected')}
                        disabled={isUpdating}
                      >
                        <XCircle className="mr-2 h-4 w-4 text-red-600" />
                        Reject
                      </DropdownMenuItem>
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
    </div>
  )
}