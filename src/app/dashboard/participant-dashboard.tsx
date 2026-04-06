'use client'

import { useState, useEffect, useCallback } from 'react'
import Image from 'next/image'
import { createClient } from '@/lib/supabase/client'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import { Alert, AlertDescription } from '@/components/ui/alert'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { toast } from 'sonner'
import {
  Users,
  Calendar,
  MapPin,
  Plane,
  MessageSquare,
  CheckCircle2,
  Info,
  Clock,
  ExternalLink,
  Home,
  Utensils,
  Presentation,
  Wifi,
  Flame,
  Coffee,
  Mail,
  DollarSign,
  FileText,
  Bus,
  Shield,
  Receipt,
  Save,
  Loader2,
  Pencil,
  Train
} from 'lucide-react'
import { ParticipantProfileSheet } from './participant-profile-sheet'
import { CallResourcesTab } from './call-resources-tab'

interface ParticipantProfile {
  id: string
  name: string | null
  organization: string | null
}

export function ParticipantDashboard({
  userId,
  userName,
  isAdmin = false
}: {
  userId: string
  userName: string
  isAdmin?: boolean
}) {
  const [participants, setParticipants] = useState<ParticipantProfile[]>([])
  const [loading, setLoading] = useState(true)
  const [selectedParticipant, setSelectedParticipant] = useState<ParticipantProfile | null>(null)
  const [sheetOpen, setSheetOpen] = useState(false)
  const supabase = createClient()

  // Travel info state
  const [travelInfo, setTravelInfo] = useState<{
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
  } | null>(null)
  const [travelLoading, setTravelLoading] = useState(true)
  const [travelSaving, setTravelSaving] = useState(false)
  const [editingFlight, setEditingFlight] = useState(false)

  // Flight form state
  const [flightForm, setFlightForm] = useState({
    arrival_mode: 'flight',
    arrival_date: '2026-06-07',
    arrival_flight_number: '',
    arrival_time: '',
    departure_mode: 'flight',
    departure_date: '2026-06-11',
    departure_flight_number: '',
    departure_time: '',
    notes: '',
  })

  const loadParticipants = useCallback(async () => {
    try {
      // Query users directly — the participants_view_other_participants
      // RLS policy already filters to only participant-role users.
      const { data: users, error } = await supabase
        .from('users')
        .select('id, name, organization')
        .order('name')

      if (error) throw error

      setParticipants(users || [])
    } catch (error) {
      console.error('Error loading participants:', error)
    } finally {
      setLoading(false)
    }
  }, [supabase])

  const loadTravelInfo = useCallback(async () => {
    try {
      const response = await fetch('/api/travel-info')
      if (response.ok) {
        const { data } = await response.json()
        if (data) {
          setTravelInfo(data)
          setFlightForm({
            arrival_mode: data.arrival_mode || 'flight',
            arrival_date: data.arrival_date || '2026-06-07',
            arrival_flight_number: data.arrival_flight_number || '',
            arrival_time: data.arrival_time || '',
            departure_mode: data.departure_mode || 'flight',
            departure_date: data.departure_date || '2026-06-11',
            departure_flight_number: data.departure_flight_number || '',
            departure_time: data.departure_time || '',
            notes: data.notes || '',
          })
        }
      }
    } catch (error) {
      console.error('Error loading travel info:', error)
    } finally {
      setTravelLoading(false)
    }
  }, [])

  const saveFlightInfo = async () => {
    setTravelSaving(true)
    try {
      const response = await fetch('/api/travel-info', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(flightForm),
      })

      if (!response.ok) {
        throw new Error('Failed to save')
      }

      toast.success('Flight information saved successfully')
      setEditingFlight(false)
      loadTravelInfo()
    } catch (error) {
      console.error('Error saving flight info:', error)
      toast.error('Failed to save flight information')
    } finally {
      setTravelSaving(false)
    }
  }

  useEffect(() => {
    loadParticipants()
    loadTravelInfo()
  }, [loadParticipants, loadTravelInfo])

  function ComingSoonPlaceholder({ icon: Icon, title }: { icon: React.ComponentType<{ className?: string }>, title: string }) {
    return (
      <div className="text-center py-12">
        <Icon className="h-12 w-12 text-gray-300 mx-auto mb-3" />
        <h3 className="text-lg font-medium text-gray-900 mb-1">{title}</h3>
        <p className="text-sm text-gray-500">Coming soon</p>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Welcome Section */}
      <div className="bg-gradient-to-r from-blue-50 to-indigo-50 rounded-lg border border-blue-200 p-6">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-4">
            <div>
              <h2 className="text-2xl font-semibold text-gray-900">Welcome back, {userName}</h2>
              <div className="flex items-center gap-2 mt-2 text-sm text-gray-600">
                <Calendar className="h-4 w-4 text-blue-600" />
                <span className="font-medium">June 7-11, 2026</span>
                <span className="text-gray-400">&bull;</span>
                <MapPin className="h-4 w-4 text-blue-600" />
                <span className="font-medium">The Deerstone Eco Hideaway, Ireland</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Pre-Workshop Tasks */}
      <Alert className="border-amber-300 bg-amber-50">
        <Clock className="h-4 w-4 text-amber-600" />
        <AlertDescription>
          <strong className="text-amber-900">Pre-Workshop Tasks:</strong>
          <ul className="mt-2 space-y-1 text-sm text-amber-800 list-disc list-inside">
            <li>Fill out your profile by clicking your name in the participants list</li>
            <li>Review the Logistics and Expectations tabs</li>
            <li>Fill in your flight information in the Logistics tab</li>
          </ul>
        </AlertDescription>
      </Alert>

      {/* Main Content Tabs */}
      <Tabs defaultValue="participants" className="space-y-4">
        <TabsList className="grid w-full grid-cols-6">
          <TabsTrigger value="participants">Participants</TabsTrigger>
          <TabsTrigger value="calls">Resources</TabsTrigger>
          <TabsTrigger value="schedule">Schedule</TabsTrigger>
          <TabsTrigger value="logistics">Logistics</TabsTrigger>
          <TabsTrigger value="expectations">Expectations</TabsTrigger>
          <TabsTrigger value="support">Support</TabsTrigger>
        </TabsList>

        {/* Participants Directory */}
        <TabsContent value="participants" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center">
                <Users className="mr-2 h-5 w-5" />
                Workshop Participants
              </CardTitle>
              <CardDescription>
                Meet the researchers and practitioners joining you at the workshop
              </CardDescription>
            </CardHeader>
            <CardContent>
              {loading ? (
                <div className="text-center py-8 text-gray-500">Loading participants...</div>
              ) : participants.length > 0 ? (
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {participants.map((participant) => (
                    <div
                      key={participant.id}
                      className="flex items-start space-x-3 p-4 rounded-lg border hover:bg-gray-50 transition-colors cursor-pointer"
                      onClick={() => {
                        setSelectedParticipant(participant)
                        setSheetOpen(true)
                      }}
                    >
                      <Avatar className="h-10 w-10">
                        <AvatarFallback className="bg-gradient-to-br from-blue-600 to-cyan-600 text-white">
                          {participant.name?.split(' ').map(n => n[0]).join('').toUpperCase() || 'P'}
                        </AvatarFallback>
                      </Avatar>
                      <div className="flex-1 min-w-0">
                        <p className="font-medium text-sm">{participant.name || 'Participant'}</p>
                        <p className="text-xs text-gray-600 truncate">{participant.organization}</p>
                      </div>
                    </div>
                  ))}
                </div>
              ) : (
                <div className="text-center py-8">
                  <Users className="h-12 w-12 text-gray-300 mx-auto mb-3" />
                  <p className="text-gray-500">Participant list will be available soon</p>
                  <p className="text-sm text-gray-400 mt-1">Check back closer to the workshop date</p>
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        {/* Call Recordings & Notes */}
        <TabsContent value="calls" className="space-y-4">
          <CallResourcesTab isAdmin={isAdmin} />
        </TabsContent>

        {/* Workshop Schedule */}
        <TabsContent value="schedule" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center">
                <Calendar className="mr-2 h-5 w-5" />
                Workshop Schedule
              </CardTitle>
              <CardDescription>
                June 7-11, 2026
              </CardDescription>
            </CardHeader>
            <CardContent>
              <ComingSoonPlaceholder icon={Calendar} title="Schedule" />
            </CardContent>
          </Card>
        </TabsContent>

        {/* Logistics Information */}
        <TabsContent value="logistics" className="space-y-4">
          <div className="grid gap-4">
            {/* Venue */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center text-lg">
                  <MapPin className="mr-2 h-5 w-5 text-red-600" />
                  Venue
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <div>
                  <p className="font-medium">The Deerstone Eco Hideaway</p>
                  <p className="text-sm text-gray-600">Ireland</p>
                </div>
                <Button variant="outline" className="w-full" asChild>
                  <a href="https://thedeerstone.ie/" target="_blank" rel="noopener noreferrer">
                    <ExternalLink className="mr-2 h-4 w-4" />
                    Visit Venue Website
                  </a>
                </Button>
              </CardContent>
            </Card>

            {/* Travel */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center text-lg">
                  <Plane className="mr-2 h-5 w-5 text-blue-600" />
                  Travel Information
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="space-y-2">
                  <div className="flex items-start space-x-2">
                    <CheckCircle2 className="h-4 w-4 text-green-600 mt-0.5" />
                    <div className="text-sm">
                      <strong>Airport:</strong> Dublin Airport (DUB) &mdash; please aim to arrive before noon on Sunday, June 7th
                    </div>
                  </div>
                  <div className="flex items-start space-x-2">
                    <CheckCircle2 className="h-4 w-4 text-green-600 mt-0.5" />
                    <div className="text-sm">
                      <strong>Departure:</strong> Workshop ends June 11th after breakfast
                    </div>
                  </div>
                  <div className="flex items-start space-x-2">
                    <Bus className="h-4 w-4 text-blue-600 mt-0.5" />
                    <div className="text-sm">
                      <strong>Ground Transportation:</strong> Shuttles will be organized from Dublin Airport to Deerestone on arrival, and back to Dublin Airport / train station on departure
                    </div>
                  </div>
                  <div className="flex items-start space-x-2">
                    <Info className="h-4 w-4 text-blue-600 mt-0.5" />
                    <div className="text-sm">
                      If you plan to already be in Ireland before the workshop, or if you&apos;ll be arriving by train, please let us know so we can organize the necessary shuttles for you.
                    </div>
                  </div>
                </div>

                <div className="border-t pt-4 space-y-2">
                  <div className="flex items-start space-x-2">
                    <Calendar className="h-4 w-4 text-gray-600 mt-0.5" />
                    <div className="text-sm">
                      <strong>Arriving or Departing on Different Days:</strong> You are welcome to book flights on days other than the 7th or 11th, but please note that you will be responsible for any expenses not directly related to the workshop or getting between the airport and Deerestone.
                    </div>
                  </div>
                  <div className="flex items-start space-x-2">
                    <Shield className="h-4 w-4 text-gray-600 mt-0.5" />
                    <div className="text-sm">
                      <strong>Visa Requirements:</strong> Please look into any visa requirements for entering Ireland based on your country of origin, and ensure you have the necessary documentation in place before traveling.
                    </div>
                  </div>
                </div>

                <div className="border-t pt-4 space-y-2">
                  {travelLoading ? (
                    <div className="text-sm text-gray-500">Loading travel budget...</div>
                  ) : travelInfo?.travel_budget ? (
                    <div className="flex items-start space-x-2">
                      <DollarSign className="h-4 w-4 text-green-600 mt-0.5" />
                      <div className="text-sm">
                        <strong>Your Travel Budget:</strong> Up to <span className="font-semibold text-green-700">${travelInfo.travel_budget.toLocaleString()}</span> to cover your flights and related travel expenses. If you anticipate needing additional budget, please reach out to us at <a href="mailto:contact@scios.tech" className="text-blue-600 hover:underline">contact@scios.tech</a>.
                      </div>
                    </div>
                  ) : (
                    <div className="flex items-start space-x-2">
                      <DollarSign className="h-4 w-4 text-gray-400 mt-0.5" />
                      <div className="text-sm text-gray-500">
                        <strong>Travel Budget:</strong> Your travel budget information will be available soon. If you have questions, please reach out to <a href="mailto:contact@scios.tech" className="text-blue-600 hover:underline">contact@scios.tech</a>.
                      </div>
                    </div>
                  )}
                  <div className="flex items-start space-x-2">
                    <Receipt className="h-4 w-4 text-gray-600 mt-0.5" />
                    <div className="text-sm">
                      <strong>Reimbursements:</strong> We will be sending out a reimbursement form closer to the workshop date. Please save all of your travel receipts so you&apos;re ready to submit them when the time comes.
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* Flight Information */}
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div>
                    <CardTitle className="flex items-center text-lg">
                      <FileText className="mr-2 h-5 w-5 text-indigo-600" />
                      Your Travel Details
                    </CardTitle>
                    <CardDescription>
                      {travelInfo?.arrival_mode && !editingFlight
                        ? 'Your submitted travel information'
                        : 'Please enter your travel details so we can organize shuttle transport for you'}
                    </CardDescription>
                  </div>
                  {travelInfo?.arrival_mode && !editingFlight && !travelLoading && (
                    <Button variant="outline" size="sm" onClick={() => setEditingFlight(true)}>
                      <Pencil className="mr-2 h-4 w-4" />
                      Edit
                    </Button>
                  )}
                </div>
              </CardHeader>
              <CardContent>
                {travelLoading ? (
                  <div className="text-center py-8 text-gray-500">Loading...</div>
                ) : travelInfo?.arrival_mode && !editingFlight ? (
                  /* ── Summary View ── */
                  <div className="space-y-4">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                      {/* Arrival summary */}
                      <div className="p-4 rounded-lg border space-y-2">
                        <h4 className="font-medium text-sm flex items-center gap-2 text-green-700">
                          {travelInfo.arrival_mode === 'train'
                            ? <Train className="h-4 w-4" />
                            : <Plane className="h-4 w-4" />}
                          Arrival
                        </h4>
                        <div className="space-y-1 text-sm">
                          <div className="flex justify-between">
                            <span className="text-gray-500">Mode</span>
                            <span className="font-medium">
                              {travelInfo.arrival_mode === 'flight' && 'Flight'}
                              {travelInfo.arrival_mode === 'train' && 'Train'}
                              {travelInfo.arrival_mode === 'already_in_ireland' && 'Already in Ireland'}
                              {travelInfo.arrival_mode === 'other' && 'Other'}
                            </span>
                          </div>
                          {travelInfo.arrival_date && (
                            <div className="flex justify-between">
                              <span className="text-gray-500">Date</span>
                              <span className="font-medium">
                                {new Date(travelInfo.arrival_date + 'T00:00:00').toLocaleDateString('en-US', {
                                  weekday: 'short', month: 'short', day: 'numeric', year: 'numeric'
                                })}
                              </span>
                            </div>
                          )}
                          {travelInfo.arrival_flight_number && (
                            <div className="flex justify-between">
                              <span className="text-gray-500">
                                {travelInfo.arrival_mode === 'train' ? 'Train' : 'Flight'}
                              </span>
                              <span className="font-medium font-mono">{travelInfo.arrival_flight_number}</span>
                            </div>
                          )}
                          {travelInfo.arrival_time && (
                            <div className="flex justify-between">
                              <span className="text-gray-500">Arrives</span>
                              <span className="font-medium">
                                {(() => {
                                  const [h, m] = travelInfo.arrival_time!.split(':')
                                  const hr = parseInt(h)
                                  return `${hr % 12 || 12}:${m} ${hr >= 12 ? 'PM' : 'AM'}`
                                })()}
                              </span>
                            </div>
                          )}
                        </div>
                      </div>

                      {/* Departure summary */}
                      <div className="p-4 rounded-lg border space-y-2">
                        <h4 className="font-medium text-sm flex items-center gap-2 text-red-700">
                          {travelInfo.departure_mode === 'train'
                            ? <Train className="h-4 w-4" />
                            : <Plane className="h-4 w-4" />}
                          Departure
                        </h4>
                        <div className="space-y-1 text-sm">
                          <div className="flex justify-between">
                            <span className="text-gray-500">Mode</span>
                            <span className="font-medium">
                              {travelInfo.departure_mode === 'flight' && 'Flight'}
                              {travelInfo.departure_mode === 'train' && 'Train'}
                              {travelInfo.departure_mode === 'other' && 'Other'}
                              {!travelInfo.departure_mode && '-'}
                            </span>
                          </div>
                          {travelInfo.departure_date && (
                            <div className="flex justify-between">
                              <span className="text-gray-500">Date</span>
                              <span className="font-medium">
                                {new Date(travelInfo.departure_date + 'T00:00:00').toLocaleDateString('en-US', {
                                  weekday: 'short', month: 'short', day: 'numeric', year: 'numeric'
                                })}
                              </span>
                            </div>
                          )}
                          {travelInfo.departure_flight_number && (
                            <div className="flex justify-between">
                              <span className="text-gray-500">
                                {travelInfo.departure_mode === 'train' ? 'Train' : 'Flight'}
                              </span>
                              <span className="font-medium font-mono">{travelInfo.departure_flight_number}</span>
                            </div>
                          )}
                          {travelInfo.departure_time && (
                            <div className="flex justify-between">
                              <span className="text-gray-500">Departs</span>
                              <span className="font-medium">
                                {(() => {
                                  const [h, m] = travelInfo.departure_time!.split(':')
                                  const hr = parseInt(h)
                                  return `${hr % 12 || 12}:${m} ${hr >= 12 ? 'PM' : 'AM'}`
                                })()}
                              </span>
                            </div>
                          )}
                        </div>
                      </div>
                    </div>

                    {travelInfo.notes && (
                      <div className="p-3 rounded-lg bg-gray-50 border text-sm">
                        <span className="text-gray-500 font-medium">Notes:</span>{' '}
                        <span className="text-gray-700">{travelInfo.notes}</span>
                      </div>
                    )}
                  </div>
                ) : (
                  /* ── Edit Form ── */
                  <div className="space-y-6">
                    {/* Arrival Section */}
                    <div className="space-y-4">
                      <h4 className="font-medium text-sm flex items-center gap-2">
                        <Plane className="h-4 w-4 text-green-600" />
                        Arrival
                      </h4>
                      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div className="space-y-2">
                          <Label htmlFor="arrival_mode">Arriving by</Label>
                          <Select
                            value={flightForm.arrival_mode}
                            onValueChange={(value) => setFlightForm(prev => ({ ...prev, arrival_mode: value }))}
                          >
                            <SelectTrigger id="arrival_mode">
                              <SelectValue />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="flight">Flight</SelectItem>
                              <SelectItem value="train">Train</SelectItem>
                              <SelectItem value="already_in_ireland">Already in Ireland</SelectItem>
                              <SelectItem value="other">Other</SelectItem>
                            </SelectContent>
                          </Select>
                        </div>
                        <div className="space-y-2">
                          <Label htmlFor="arrival_date">Arrival Date</Label>
                          <Input
                            id="arrival_date"
                            type="date"
                            value={flightForm.arrival_date}
                            onChange={(e) => setFlightForm(prev => ({ ...prev, arrival_date: e.target.value }))}
                          />
                        </div>
                        {flightForm.arrival_mode === 'already_in_ireland' && (
                          <div className="md:col-span-2 p-3 rounded-lg bg-blue-50 border border-blue-200 text-sm text-blue-800">
                            Please use the notes field below to let us know where you&apos;ll be coming from so we can arrange transport to Deerestone.
                          </div>
                        )}
                        {(flightForm.arrival_mode === 'flight' || flightForm.arrival_mode === 'train') && (
                          <>
                            <div className="space-y-2">
                              <Label htmlFor="arrival_flight_number">
                                {flightForm.arrival_mode === 'flight' ? 'Flight Number' : 'Train Details'}
                              </Label>
                              <Input
                                id="arrival_flight_number"
                                placeholder={flightForm.arrival_mode === 'flight' ? 'e.g., EI 123' : 'e.g., Enterprise Belfast-Dublin'}
                                value={flightForm.arrival_flight_number}
                                onChange={(e) => setFlightForm(prev => ({ ...prev, arrival_flight_number: e.target.value }))}
                              />
                            </div>
                            <div className="space-y-2">
                              <Label htmlFor="arrival_time">
                                {flightForm.arrival_mode === 'flight'
                                  ? 'Estimated Arrival Time at Dublin Airport'
                                  : 'Estimated Arrival Time at Dublin Station'}
                              </Label>
                              <Input
                                id="arrival_time"
                                type="time"
                                value={flightForm.arrival_time}
                                onChange={(e) => setFlightForm(prev => ({ ...prev, arrival_time: e.target.value }))}
                              />
                            </div>
                          </>
                        )}
                      </div>
                    </div>

                    {/* Departure Section */}
                    <div className="space-y-4 border-t pt-4">
                      <h4 className="font-medium text-sm flex items-center gap-2">
                        <Plane className="h-4 w-4 text-red-600 rotate-45" />
                        Departure
                      </h4>
                      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div className="space-y-2">
                          <Label htmlFor="departure_mode">Departing by</Label>
                          <Select
                            value={flightForm.departure_mode}
                            onValueChange={(value) => setFlightForm(prev => ({ ...prev, departure_mode: value }))}
                          >
                            <SelectTrigger id="departure_mode">
                              <SelectValue />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="flight">Flight</SelectItem>
                              <SelectItem value="train">Train</SelectItem>
                              <SelectItem value="other">Other</SelectItem>
                            </SelectContent>
                          </Select>
                        </div>
                        <div className="space-y-2">
                          <Label htmlFor="departure_date">Departure Date</Label>
                          <Input
                            id="departure_date"
                            type="date"
                            value={flightForm.departure_date}
                            onChange={(e) => setFlightForm(prev => ({ ...prev, departure_date: e.target.value }))}
                          />
                        </div>
                        {(flightForm.departure_mode === 'flight' || flightForm.departure_mode === 'train') && (
                          <>
                            <div className="space-y-2">
                              <Label htmlFor="departure_flight_number">
                                {flightForm.departure_mode === 'flight' ? 'Flight Number' : 'Train Details'}
                              </Label>
                              <Input
                                id="departure_flight_number"
                                placeholder={flightForm.departure_mode === 'flight' ? 'e.g., EI 456' : 'e.g., Enterprise Dublin-Belfast'}
                                value={flightForm.departure_flight_number}
                                onChange={(e) => setFlightForm(prev => ({ ...prev, departure_flight_number: e.target.value }))}
                              />
                            </div>
                            <div className="space-y-2">
                              <Label htmlFor="departure_time">
                                {flightForm.departure_mode === 'flight'
                                  ? 'Departure Time from Dublin Airport'
                                  : 'Departure Time from Dublin Station'}
                              </Label>
                              <Input
                                id="departure_time"
                                type="time"
                                value={flightForm.departure_time}
                                onChange={(e) => setFlightForm(prev => ({ ...prev, departure_time: e.target.value }))}
                              />
                            </div>
                          </>
                        )}
                      </div>
                    </div>

                    {/* Notes */}
                    <div className="space-y-2 border-t pt-4">
                      <Label htmlFor="travel_notes">Additional Notes</Label>
                      <Textarea
                        id="travel_notes"
                        placeholder="Any special travel arrangements, requests, or information we should know about..."
                        value={flightForm.notes}
                        onChange={(e) => setFlightForm(prev => ({ ...prev, notes: e.target.value }))}
                        rows={3}
                      />
                    </div>

                    {/* Action Buttons */}
                    <div className="flex justify-end gap-2">
                      {editingFlight && (
                        <Button
                          variant="outline"
                          onClick={() => {
                            // Reset form to saved values
                            if (travelInfo) {
                              setFlightForm({
                                arrival_mode: travelInfo.arrival_mode || 'flight',
                                arrival_date: travelInfo.arrival_date || '2026-06-07',
                                arrival_flight_number: travelInfo.arrival_flight_number || '',
                                arrival_time: travelInfo.arrival_time || '',
                                departure_mode: travelInfo.departure_mode || 'flight',
                                departure_date: travelInfo.departure_date || '2026-06-11',
                                departure_flight_number: travelInfo.departure_flight_number || '',
                                departure_time: travelInfo.departure_time || '',
                                notes: travelInfo.notes || '',
                              })
                            }
                            setEditingFlight(false)
                          }}
                        >
                          Cancel
                        </Button>
                      )}
                      <Button onClick={saveFlightInfo} disabled={travelSaving}>
                        {travelSaving ? (
                          <>
                            <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                            Saving...
                          </>
                        ) : (
                          <>
                            <Save className="mr-2 h-4 w-4" />
                            Save Travel Details
                          </>
                        )}
                      </Button>
                    </div>
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Working Spaces */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center text-lg">
                  <Presentation className="mr-2 h-5 w-5 text-indigo-600" />
                  Working Spaces
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex gap-6">
                  <div className="flex-1 space-y-5 py-2">
                    <div className="space-y-2">
                      <p className="font-medium">The Roundhouse</p>
                      <p className="text-sm text-gray-600">Our main workshop space. A circular room designed to foster open dialogue and collaboration, equipped with high-speed wifi, wireless projector, flipcharts, and flexible seating.</p>
                    </div>
                    <div className="space-y-2">
                      <p className="font-medium">The Barn</p>
                      <p className="text-sm text-gray-600">A relaxed space for breaks and informal conversations, with a firepit and refreshments.</p>
                    </div>
                    <div className="flex items-center gap-2 text-sm text-gray-500 pt-2 border-t">
                      <Wifi className="h-4 w-4" />
                      <span>All spaces have high-speed wifi, AV equipment, and indoor/outdoor breakout options.</span>
                    </div>
                  </div>
                  <div className="relative w-80 h-72 flex-shrink-0">
                    <div className="absolute bottom-0 left-0 w-64 h-44 rounded-lg overflow-hidden shadow-lg -rotate-2">
                      <Image
                        src="/images/venue/barn-interior.jpg"
                        alt="The Barn — cozy social space"
                        fill
                        className="object-cover"
                      />
                    </div>
                    <div className="absolute top-0 right-0 w-64 h-44 rounded-lg overflow-hidden shadow-lg rotate-2">
                      <Image
                        src="/images/venue/roundhouse-interior.jpg"
                        alt="The Roundhouse — circular workshop space"
                        fill
                        className="object-cover"
                      />
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* Accommodation */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center text-lg">
                  <Home className="mr-2 h-5 w-5 text-purple-600" />
                  Accommodation
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex gap-6">
                  <div className="flex-1 space-y-4 py-2">
                    <p className="text-sm text-gray-600">
                      All participants will stay on-site at The Deerstone in private ensuite bedrooms. The property has 22 bedrooms across three accommodation types:
                    </p>
                    <div className="space-y-3">
                      <div className="p-3 rounded-lg border">
                        <p className="font-medium text-sm">Cottages</p>
                        <p className="text-sm text-gray-600">Three-bedroom retreats with shared living space, stove, kitchenette, outdoor patio, and hot tub. King ensuite bedrooms with VOYA organic toiletries, bathrobes, and spa towels.</p>
                      </div>
                      <div className="p-3 rounded-lg border">
                        <p className="font-medium text-sm">Shepherd&apos;s Huts</p>
                        <p className="text-sm text-gray-600">Standalone rustic hideaways with a private double ensuite, kitchenette, stove, and outdoor terrace.</p>
                      </div>
                      <div className="p-3 rounded-lg border">
                        <p className="font-medium text-sm">Lodge Guest Rooms</p>
                        <p className="text-sm text-gray-600">Ensuite bedrooms in the main lodge with super king beds, Irish linen, and natural wool bedding.</p>
                      </div>
                    </div>
                    <p className="text-sm text-gray-500">
                      All rooms include private bathrooms, hairdryer, bathrobes, and eco-friendly amenities. Room assignments will be shared closer to the workshop.
                    </p>
                    <p className="text-sm text-gray-500 italic">
                      We believe that this workshop experience will be most valuable for our attendees if they are fully present; hence, we are asking partners, families, and others not to join participants during the meeting, unless related to family care obligations or another special case, which you should discuss with us.
                    </p>
                  </div>
                  <div className="relative w-80 h-72 flex-shrink-0">
                    <div className="absolute top-0 left-0 w-64 h-44 rounded-lg overflow-hidden shadow-lg -rotate-1">
                      <Image
                        src="/images/venue/cottage-exterior.png"
                        alt="Cottage exterior nestled in greenery"
                        fill
                        className="object-cover"
                      />
                    </div>
                    <div className="absolute bottom-0 right-0 w-64 h-44 rounded-lg overflow-hidden shadow-lg rotate-1">
                      <Image
                        src="/images/venue/bedroom.png"
                        alt="Ensuite bedroom with cozy bedding"
                        fill
                        className="object-cover"
                      />
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* Meals & Dietary */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center text-lg">
                  <Utensils className="mr-2 h-5 w-5 text-green-600" />
                  Meals &amp; Dietary
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex gap-6">
                  <div className="flex-1 space-y-4 py-2">
                    <p className="text-sm text-gray-600">
                      All meals are included and prepared on-site by The Deerstone&apos;s in-house chefs. Dining takes place in The Shed, a communal long-table space. Much of the food is grown in the venue&apos;s own polytunnels, herb gardens, and vegetable gardens.
                    </p>
                    <div className="space-y-2">
                      <div className="flex items-start space-x-2">
                        <Coffee className="h-4 w-4 text-amber-600 mt-0.5 flex-shrink-0" />
                        <div className="text-sm">
                          <strong>Breakfast</strong> — Fresh seasonal spreads including overnight oats, egg &amp; avocado bowls, sourdough, pastries, fresh-pressed juice, tea &amp; coffee
                        </div>
                      </div>
                      <div className="flex items-start space-x-2">
                        <Utensils className="h-4 w-4 text-green-600 mt-0.5 flex-shrink-0" />
                        <div className="text-sm">
                          <strong>Lunch</strong> — Seasonal soups, salads, and mains
                        </div>
                      </div>
                      <div className="flex items-start space-x-2">
                        <Flame className="h-4 w-4 text-orange-600 mt-0.5 flex-shrink-0" />
                        <div className="text-sm">
                          <strong>Dinner</strong> — Multi-course chef&apos;s table or casual BBQ, featuring local Irish ingredients
                        </div>
                      </div>
                    </div>
                    <p className="text-sm text-gray-500">
                      Vegetarian and vegan options are available at every meal. If you have dietary restrictions or allergies, please let us know and the kitchen will accommodate you.
                    </p>
                  </div>
                  <div className="relative w-80 h-56 flex-shrink-0 self-center">
                    <div className="absolute inset-0 rounded-lg overflow-hidden shadow-lg rotate-1">
                      <Image
                        src="/images/venue/the-shed.jpg"
                        alt="The Shed — communal long-table dining space"
                        fill
                        className="object-cover"
                      />
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* What to Bring */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center text-lg">
                  <MessageSquare className="mr-2 h-5 w-5 text-orange-600" />
                  What to Bring
                </CardTitle>
              </CardHeader>
              <CardContent>
                <ComingSoonPlaceholder icon={MessageSquare} title="Packing List" />
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        {/* Expectations */}
        <TabsContent value="expectations" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center">
                <CheckCircle2 className="mr-2 h-5 w-5" />
                Workshop Expectations
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="space-y-4">
                <div className="space-y-2">
                  <h4 className="font-medium text-sm">This is a production-focused event</h4>
                  <p className="text-sm text-gray-600">
                    We will be participating in product development activities — things like user research, design exercises, and prototyping. Some of this may feel unfamiliar, and that&apos;s okay. The goal is to build something together, and we&apos;ll guide you through every step of the process.
                  </p>
                </div>
                <div className="space-y-2">
                  <h4 className="font-medium text-sm">Professional environment</h4>
                  <p className="text-sm text-gray-600">
                    While we want everyone to have fun, get to know one another, and enjoy the setting, please remember that this is a professional event. We ask all participants to conduct themselves accordingly and to be respectful of one another at all times.
                  </p>
                </div>
                <div className="space-y-2">
                  <h4 className="font-medium text-sm">Be present</h4>
                  <p className="text-sm text-gray-600">
                    We have brought together a small, carefully selected group because we believe each of you has something valuable to contribute. The workshop works best when everyone is fully engaged. We encourage you to minimize outside distractions and come ready to actively participate.
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Support */}
        <TabsContent value="support" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center">
                <Mail className="mr-2 h-5 w-5" />
                Contact Us
              </CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-sm text-gray-600 mb-4">
                If you ever need to reach out — whether it&apos;s a question about logistics, a special request, or anything else — don&apos;t hesitate to contact us.
              </p>
              <div className="space-y-3">
                <div className="flex items-center space-x-3 p-3 rounded-lg border">
                  <Mail className="h-4 w-4 text-blue-600 flex-shrink-0" />
                  <div className="text-sm">
                    <span className="font-medium">All Organizers</span>
                    <span className="text-gray-400 mx-2">&mdash;</span>
                    <a href="mailto:contact@scios.tech" className="text-blue-600 hover:underline">contact@scios.tech</a>
                  </div>
                </div>
                <div className="flex items-center space-x-3 p-3 rounded-lg border">
                  <Mail className="h-4 w-4 text-blue-600 flex-shrink-0" />
                  <div className="text-sm">
                    <span className="font-medium">Jon</span>
                    <span className="text-gray-400 mx-2">&mdash;</span>
                    <a href="mailto:jon@scios.tech" className="text-blue-600 hover:underline">jon@scios.tech</a>
                  </div>
                </div>
                <div className="flex items-center space-x-3 p-3 rounded-lg border">
                  <Mail className="h-4 w-4 text-blue-600 flex-shrink-0" />
                  <div className="text-sm">
                    <span className="font-medium">Ellie</span>
                    <span className="text-gray-400 mx-2">&mdash;</span>
                    <a href="mailto:ellie@scios.tech" className="text-blue-600 hover:underline">ellie@scios.tech</a>
                  </div>
                </div>
                <div className="flex items-center space-x-3 p-3 rounded-lg border">
                  <Mail className="h-4 w-4 text-blue-600 flex-shrink-0" />
                  <div className="text-sm">
                    <span className="font-medium">Matt</span>
                    <span className="text-gray-400 mx-2">&mdash;</span>
                    <a href="mailto:akamatsm@uw.edu" className="text-blue-600 hover:underline">akamatsm@uw.edu</a>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>

      <ParticipantProfileSheet
        participant={selectedParticipant}
        open={sheetOpen}
        onOpenChange={setSheetOpen}
        currentUserId={userId}
        onProfileUpdated={loadParticipants}
      />
    </div>
  )
}
