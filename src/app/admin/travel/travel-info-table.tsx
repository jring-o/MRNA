'use client'

import { useState, useEffect } from 'react'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import { Download, CheckCircle, Clock } from 'lucide-react'
import { toast } from 'sonner'

type TravelEntry = {
  id: string
  user_id: string
  travel_budget: number | null
  arrival_mode: string | null
  arrival_date: string | null
  arrival_flight_number: string | null
  arrival_time: string | null
  departure_mode: string | null
  departure_date: string | null
  departure_flight_number: string | null
  departure_time: string | null
  notes: string | null
  users: {
    name: string
    email: string
    organization: string | null
  }
}

function formatMode(mode: string | null): string {
  if (!mode) return '-'
  const labels: Record<string, string> = {
    flight: 'Flight',
    train: 'Train',
    already_in_ireland: 'Already in Ireland',
    other: 'Other',
  }
  return labels[mode] || mode
}

function formatDate(date: string | null): string {
  if (!date) return '-'
  return new Date(date + 'T00:00:00').toLocaleDateString('en-US', {
    month: 'short',
    day: 'numeric',
  })
}

function formatTime(time: string | null): string {
  if (!time) return '-'
  const [hours, minutes] = time.split(':')
  const h = parseInt(hours)
  const ampm = h >= 12 ? 'PM' : 'AM'
  const h12 = h % 12 || 12
  return `${h12}:${minutes} ${ampm}`
}

export function TravelInfoTable() {
  const [entries, setEntries] = useState<TravelEntry[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function load() {
      try {
        const response = await fetch('/api/admin/travel-info')
        if (!response.ok) throw new Error('Failed to load')
        const { data } = await response.json()
        setEntries(data || [])
      } catch (error) {
        console.error('Error loading travel info:', error)
        toast.error('Failed to load travel information')
      } finally {
        setLoading(false)
      }
    }
    load()
  }, [])

  const hasFlightInfo = (entry: TravelEntry) =>
    entry.arrival_flight_number || entry.arrival_time || entry.departure_flight_number || entry.departure_time

  const submitted = entries.filter(hasFlightInfo).length
  const total = entries.length

  const exportToCSV = () => {
    const csv = [
      ['Name', 'Email', 'Organization', 'Budget', 'Arrival Mode', 'Arrival Date', 'Arrival Flight/Train', 'Arrival Time', 'Departure Mode', 'Departure Date', 'Departure Flight/Train', 'Departure Time', 'Notes'],
      ...entries.map(e => [
        e.users?.name || '',
        e.users?.email || '',
        e.users?.organization || '',
        e.travel_budget ? `$${e.travel_budget}` : '',
        formatMode(e.arrival_mode),
        e.arrival_date || '',
        e.arrival_flight_number || '',
        e.arrival_time || '',
        formatMode(e.departure_mode),
        e.departure_date || '',
        e.departure_flight_number || '',
        e.departure_time || '',
        e.notes || '',
      ])
    ].map(row => row.map(cell => `"${cell}"`).join(',')).join('\n')

    const blob = new Blob([csv], { type: 'text/csv' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `travel-info-${new Date().toISOString().split('T')[0]}.csv`
    a.click()
    URL.revokeObjectURL(url)
  }

  if (loading) {
    return <div className="text-center py-12 text-gray-500">Loading travel information...</div>
  }

  return (
    <div className="space-y-4">
      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-white rounded-lg shadow p-6 border-l-4 border-blue-500">
          <div className="text-sm font-medium text-gray-500">Total Participants</div>
          <div className="mt-1 text-3xl font-bold text-blue-600">{total}</div>
        </div>
        <div className="bg-white rounded-lg shadow p-6 border-l-4 border-green-500">
          <div className="text-sm font-medium text-gray-500">Flight Info Submitted</div>
          <div className="mt-1 text-3xl font-bold text-green-600">{submitted}</div>
        </div>
        <div className="bg-white rounded-lg shadow p-6 border-l-4 border-amber-500">
          <div className="text-sm font-medium text-gray-500">Pending</div>
          <div className="mt-1 text-3xl font-bold text-amber-600">{total - submitted}</div>
        </div>
      </div>

      {/* Actions */}
      <div className="bg-white rounded-lg shadow p-4 flex justify-end">
        <Button variant="outline" onClick={exportToCSV}>
          <Download className="mr-2 h-4 w-4" />
          Export CSV
        </Button>
      </div>

      {/* Table */}
      <div className="bg-white rounded-lg shadow overflow-hidden">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Name</TableHead>
              <TableHead className="text-center">Budget</TableHead>
              <TableHead className="text-center">Status</TableHead>
              <TableHead>Arrival</TableHead>
              <TableHead>Departure</TableHead>
              <TableHead>Notes</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {entries.map((entry) => (
              <TableRow key={entry.id}>
                <TableCell>
                  <div>
                    <div className="font-medium">{entry.users?.name || 'N/A'}</div>
                    <div className="text-sm text-gray-500">{entry.users?.email || 'N/A'}</div>
                  </div>
                </TableCell>
                <TableCell className="text-center">
                  {entry.travel_budget ? (
                    <Badge variant="outline" className="text-green-700 border-green-300 bg-green-50">
                      ${entry.travel_budget.toLocaleString()}
                    </Badge>
                  ) : (
                    <span className="text-gray-400">-</span>
                  )}
                </TableCell>
                <TableCell className="text-center">
                  {hasFlightInfo(entry) ? (
                    <CheckCircle className="h-5 w-5 text-green-500 mx-auto" />
                  ) : (
                    <Clock className="h-5 w-5 text-amber-400 mx-auto" />
                  )}
                </TableCell>
                <TableCell>
                  {hasFlightInfo(entry) ? (
                    <div className="text-sm space-y-0.5">
                      <div className="flex items-center gap-1">
                        <Badge variant="secondary" className="text-xs">
                          {formatMode(entry.arrival_mode)}
                        </Badge>
                      </div>
                      <div className="text-gray-600">
                        {formatDate(entry.arrival_date)}
                        {entry.arrival_time && ` at ${formatTime(entry.arrival_time)}`}
                      </div>
                      {entry.arrival_flight_number && (
                        <div className="font-mono text-xs text-gray-500">{entry.arrival_flight_number}</div>
                      )}
                    </div>
                  ) : (
                    <span className="text-gray-400 text-sm">Not submitted</span>
                  )}
                </TableCell>
                <TableCell>
                  {hasFlightInfo(entry) ? (
                    <div className="text-sm space-y-0.5">
                      <div className="flex items-center gap-1">
                        <Badge variant="secondary" className="text-xs">
                          {formatMode(entry.departure_mode)}
                        </Badge>
                      </div>
                      <div className="text-gray-600">
                        {formatDate(entry.departure_date)}
                        {entry.departure_time && ` at ${formatTime(entry.departure_time)}`}
                      </div>
                      {entry.departure_flight_number && (
                        <div className="font-mono text-xs text-gray-500">{entry.departure_flight_number}</div>
                      )}
                    </div>
                  ) : (
                    <span className="text-gray-400 text-sm">-</span>
                  )}
                </TableCell>
                <TableCell>
                  {entry.notes ? (
                    <p className="text-sm text-gray-600 max-w-xs truncate" title={entry.notes}>
                      {entry.notes}
                    </p>
                  ) : (
                    <span className="text-gray-400 text-sm">-</span>
                  )}
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>

        {entries.length === 0 && (
          <div className="text-center py-12 text-gray-500">
            No travel information found. Budgets will appear once the migration has been applied.
          </div>
        )}
      </div>
    </div>
  )
}
