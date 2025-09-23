'use client'

import { useState, useEffect, useCallback } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import { Alert, AlertDescription } from '@/components/ui/alert'
import { Separator } from '@/components/ui/separator'
import {
  Users,
  Calendar,
  MapPin,
  Plane,
  Hotel,
  Coffee,
  MessageSquare,
  CheckCircle2,
  Info,
  Mail,
  Globe,
  BookOpen,
  Utensils,
  Wifi,
  Heart,
  AlertCircle,
  Sparkles,
  Video,
  FileText,
  Download,
  ExternalLink
} from 'lucide-react'

interface ParticipantProfile {
  id: string
  name: string | null
  email: string
  organization: string | null
  bio?: string
  research_interests?: string[]
  linkedin?: string
  twitter?: string
}

interface WorkshopSession {
  id: string
  day: number
  time: string
  title: string
  description: string
  type: 'plenary' | 'breakout' | 'social' | 'meal'
  required: boolean
  facilitator?: string
}

export function ParticipantDashboard({
  userId,
  userName
}: {
  userId: string
  userName: string
}) {
  const [participants, setParticipants] = useState<ParticipantProfile[]>([])
  const [loading, setLoading] = useState(true)
  const supabase = createClient()

  const loadParticipants = useCallback(async () => {
    try {
      // Load all users who have created accounts from accepted applications
      // This includes both regular participants and admins
      const { data: acceptedApps, error: appError } = await supabase
        .from('applications')
        .select('email, name, organization, user_id')
        .eq('status', 'accepted')
        .not('user_id', 'is', null)

      if (appError) throw appError

      // Get user details for all accepted participants
      const userIds = acceptedApps
        ?.map(app => app.user_id)
        .filter((id): id is string => Boolean(id)) || []

      if (userIds.length > 0) {
        const { data: users, error: usersError } = await supabase
          .from('users')
          .select('*')
          .in('id', userIds)
          .order('name')

        if (usersError) throw usersError

        // Merge user data with application data for organization info
        const participantList = users?.map(user => {
          const app = acceptedApps?.find(a => a.user_id === user.id)
          return {
            ...user,
            organization: user.organization || app?.organization || null
          }
        }) || []

        setParticipants(participantList)
      } else {
        setParticipants([])
      }
    } catch (error) {
      console.error('Error loading participants:', error)
    } finally {
      setLoading(false)
    }
  }, [supabase])

  useEffect(() => {
    loadParticipants()
  }, [loadParticipants])

  // Mock workshop schedule - in production, this would come from the database
  const schedule: WorkshopSession[] = [
    {
      id: '1',
      day: 1,
      time: '8:00 AM',
      title: 'Registration & Welcome Breakfast',
      description: 'Check-in, receive workshop materials, and network over breakfast',
      type: 'meal',
      required: true
    },
    {
      id: '2',
      day: 1,
      time: '9:00 AM',
      title: 'Opening Keynote: The Future of Scientific Attribution',
      description: 'Setting the vision for modular research and collaborative science',
      type: 'plenary',
      required: true,
      facilitator: 'Dr. Sarah Chen'
    },
    {
      id: '3',
      day: 1,
      time: '10:30 AM',
      title: 'Lightning Talks: Current Attribution Challenges',
      description: 'Participants share 5-minute perspectives on attribution problems in their fields',
      type: 'plenary',
      required: true
    },
    {
      id: '4',
      day: 1,
      time: '12:00 PM',
      title: 'Lunch & Networking',
      description: 'Structured networking lunch with topic tables',
      type: 'meal',
      required: true
    },
    {
      id: '5',
      day: 1,
      time: '2:00 PM',
      title: 'Breakout: Technical Standards Working Group',
      description: 'Deep dive into technical requirements for attribution protocols',
      type: 'breakout',
      required: false
    },
    {
      id: '6',
      day: 2,
      time: '9:00 AM',
      title: 'Design Sprint: Attribution Protocol MVP',
      description: 'Hands-on session to prototype attribution mechanisms',
      type: 'breakout',
      required: true,
      facilitator: 'Alex Rivera'
    },
    {
      id: '7',
      day: 2,
      time: '6:00 PM',
      title: 'Group Dinner',
      description: 'Optional group dinner at a local restaurant',
      type: 'social',
      required: false
    }
  ]

  const getSessionBadgeColor = (type: WorkshopSession['type']) => {
    switch (type) {
      case 'plenary': return 'bg-blue-100 text-blue-800'
      case 'breakout': return 'bg-green-100 text-green-800'
      case 'social': return 'bg-purple-100 text-purple-800'
      case 'meal': return 'bg-orange-100 text-orange-800'
      default: return 'bg-gray-100 text-gray-800'
    }
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
                <span className="font-medium">May 12-15, 2026</span>
                <span className="text-gray-400">•</span>
                <MapPin className="h-4 w-4 text-blue-600" />
                <span className="font-medium">Columbia University, NYC</span>
              </div>
            </div>
          </div>
          <Badge className="bg-blue-600 text-white border-0 px-3 py-1">
            Workshop Participant
          </Badge>
        </div>
      </div>

      {/* Important Pre-Workshop Tasks */}
      <Alert className="border-amber-200 bg-amber-50">
        <Sparkles className="h-4 w-4 text-amber-600" />
        <AlertDescription>
          <strong className="text-amber-900">Pre-Workshop Tasks:</strong>
          <ul className="mt-2 space-y-1 text-sm">
            <li>• Complete your participant profile (due 2 weeks before)</li>
            <li>• Review pre-reading materials in the Resources tab</li>
            <li>• Book your travel and accommodation</li>
            <li>• Join the workshop Slack channel</li>
          </ul>
        </AlertDescription>
      </Alert>

      {/* Main Content Tabs */}
      <Tabs defaultValue="participants" className="space-y-4">
        <TabsList className="grid w-full grid-cols-5">
          <TabsTrigger value="participants">Participants</TabsTrigger>
          <TabsTrigger value="schedule">Schedule</TabsTrigger>
          <TabsTrigger value="logistics">Logistics</TabsTrigger>
          <TabsTrigger value="resources">Resources</TabsTrigger>
          <TabsTrigger value="connect">Connect</TabsTrigger>
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
                Connect with the 20 researchers joining you at the workshop
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
                      className="flex items-start space-x-3 p-4 rounded-lg border hover:bg-gray-50 transition-colors"
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
                      {participant.id !== userId && (
                        <Button size="sm" variant="ghost">
                          <MessageSquare className="h-4 w-4" />
                        </Button>
                      )}
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

        {/* Workshop Schedule */}
        <TabsContent value="schedule" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center">
                <Calendar className="mr-2 h-5 w-5" />
                Workshop Schedule
              </CardTitle>
              <CardDescription>
                4-day intensive workshop program
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-6">
                {[1, 2, 3, 4].map((day) => (
                  <div key={day}>
                    <h3 className="font-semibold text-lg mb-3 flex items-center">
                      <div className="h-8 w-8 rounded-full bg-blue-600 text-white flex items-center justify-center text-sm font-bold mr-3">
                        {day}
                      </div>
                      Day {day}
                    </h3>
                    <div className="space-y-2 ml-11">
                      {schedule
                        .filter(session => session.day === day)
                        .map((session) => (
                          <div
                            key={session.id}
                            className="flex items-start space-x-3 p-3 rounded-lg border hover:bg-gray-50 transition-colors"
                          >
                            <div className="text-sm text-gray-500 font-medium w-20 pt-1">
                              {session.time}
                            </div>
                            <div className="flex-1">
                              <div className="flex items-center space-x-2 mb-1">
                                <p className="font-medium">{session.title}</p>
                                <Badge className={`text-xs ${getSessionBadgeColor(session.type)}`}>
                                  {session.type}
                                </Badge>
                                {session.required && (
                                  <Badge variant="outline" className="text-xs">
                                    Required
                                  </Badge>
                                )}
                              </div>
                              <p className="text-sm text-gray-600">{session.description}</p>
                              {session.facilitator && (
                                <p className="text-xs text-gray-500 mt-1">
                                  Facilitated by {session.facilitator}
                                </p>
                              )}
                            </div>
                          </div>
                        ))}
                    </div>
                  </div>
                ))}
              </div>

              <Alert className="mt-6">
                <Info className="h-4 w-4" />
                <AlertDescription>
                  <strong>Note:</strong> This is a preliminary schedule. Final timing and sessions
                  will be confirmed 2 weeks before the workshop.
                </AlertDescription>
              </Alert>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Logistics Information */}
        <TabsContent value="logistics" className="space-y-4">
          <div className="grid gap-4">
            {/* Location */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center text-lg">
                  <MapPin className="mr-2 h-5 w-5 text-red-600" />
                  Venue
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <div>
                  <p className="font-medium">Columbia University</p>
                  <p className="text-sm text-gray-600">Schapiro Center for Engineering and Physical Science Research</p>
                  <p className="text-sm text-gray-600">530 West 120th Street, New York, NY 10027</p>
                </div>
                <Button variant="outline" className="w-full">
                  <ExternalLink className="mr-2 h-4 w-4" />
                  View on Google Maps
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
              <CardContent className="space-y-3">
                <div className="space-y-2">
                  <div className="flex items-start space-x-2">
                    <CheckCircle2 className="h-4 w-4 text-green-600 mt-0.5" />
                    <div className="text-sm">
                      <strong>Airports:</strong> JFK, Newark (EWR), or LaGuardia (LGA)
                    </div>
                  </div>
                  <div className="flex items-start space-x-2">
                    <CheckCircle2 className="h-4 w-4 text-green-600 mt-0.5" />
                    <div className="text-sm">
                      <strong>Train:</strong> Penn Station (Amtrak) - 20 min to venue via subway
                    </div>
                  </div>
                  <div className="flex items-start space-x-2">
                    <CheckCircle2 className="h-4 w-4 text-green-600 mt-0.5" />
                    <div className="text-sm">
                      <strong>Subway:</strong> 1 train to 116th Street - Columbia University
                    </div>
                  </div>
                </div>
                <Alert>
                  <Info className="h-4 w-4" />
                  <AlertDescription className="text-sm">
                    Travel stipends up to $500 are available for participants traveling from outside the NYC metro area.
                  </AlertDescription>
                </Alert>
              </CardContent>
            </Card>

            {/* Accommodation */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center text-lg">
                  <Hotel className="mr-2 h-5 w-5 text-purple-600" />
                  Accommodation
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <div className="space-y-3">
                  <div className="p-3 rounded-lg border bg-blue-50">
                    <p className="font-medium text-sm">Recommended Hotel</p>
                    <p className="text-sm text-gray-600">The Aloft Harlem</p>
                    <p className="text-xs text-gray-500">Special workshop rate: $189/night</p>
                    <p className="text-xs text-gray-500">Booking code: MODRES2026</p>
                  </div>
                  <div className="space-y-1 text-sm">
                    <p className="font-medium">Alternative Options:</p>
                    <ul className="space-y-1 text-gray-600">
                      <li>• Broadway Hotel and Hostel (budget)</li>
                      <li>• The High Line Hotel (premium)</li>
                      <li>• Airbnb options in Morningside Heights</li>
                    </ul>
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* Meals & Dietary */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center text-lg">
                  <Utensils className="mr-2 h-5 w-5 text-green-600" />
                  Meals & Dietary
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <div className="space-y-2 text-sm">
                  <div className="flex items-start space-x-2">
                    <Coffee className="h-4 w-4 text-gray-600 mt-0.5" />
                    <span>Breakfast and lunch provided all workshop days</span>
                  </div>
                  <div className="flex items-start space-x-2">
                    <Utensils className="h-4 w-4 text-gray-600 mt-0.5" />
                    <span>Group dinners on Days 1 and 3 (optional)</span>
                  </div>
                  <div className="flex items-start space-x-2">
                    <Heart className="h-4 w-4 text-gray-600 mt-0.5" />
                    <span>All dietary restrictions accommodated</span>
                  </div>
                </div>
                <Alert>
                  <AlertCircle className="h-4 w-4" />
                  <AlertDescription className="text-sm">
                    Please update your dietary preferences in your profile by March 1st.
                  </AlertDescription>
                </Alert>
              </CardContent>
            </Card>

            {/* What to Bring */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center text-lg">
                  <FileText className="mr-2 h-5 w-5 text-orange-600" />
                  What to Bring
                </CardTitle>
              </CardHeader>
              <CardContent>
                <ul className="space-y-2 text-sm">
                  <li className="flex items-start space-x-2">
                    <CheckCircle2 className="h-4 w-4 text-green-600 mt-0.5" />
                    <span>Laptop for workshop activities</span>
                  </li>
                  <li className="flex items-start space-x-2">
                    <CheckCircle2 className="h-4 w-4 text-green-600 mt-0.5" />
                    <span>Business cards for networking</span>
                  </li>
                  <li className="flex items-start space-x-2">
                    <CheckCircle2 className="h-4 w-4 text-green-600 mt-0.5" />
                    <span>Comfortable attire (dress code: smart casual)</span>
                  </li>
                  <li className="flex items-start space-x-2">
                    <CheckCircle2 className="h-4 w-4 text-green-600 mt-0.5" />
                    <span>Reusable water bottle</span>
                  </li>
                  <li className="flex items-start space-x-2">
                    <Wifi className="h-4 w-4 text-blue-600 mt-0.5" />
                    <span>WiFi provided at venue</span>
                  </li>
                </ul>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        {/* Resources */}
        <TabsContent value="resources" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center">
                <BookOpen className="mr-2 h-5 w-5" />
                Workshop Resources
              </CardTitle>
              <CardDescription>
                Materials and readings to prepare for the workshop
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div>
                  <h4 className="font-medium mb-3">Pre-Workshop Reading</h4>
                  <div className="space-y-2">
                    <div className="flex items-center justify-between p-3 rounded-lg border hover:bg-gray-50 transition-colors">
                      <div className="flex items-center space-x-3">
                        <FileText className="h-5 w-5 text-gray-400" />
                        <div>
                          <p className="text-sm font-medium">Attribution in Open Science</p>
                          <p className="text-xs text-gray-500">White paper on current challenges</p>
                        </div>
                      </div>
                      <Button size="sm" variant="ghost">
                        <Download className="h-4 w-4" />
                      </Button>
                    </div>
                    <div className="flex items-center justify-between p-3 rounded-lg border hover:bg-gray-50 transition-colors">
                      <div className="flex items-center space-x-3">
                        <FileText className="h-5 w-5 text-gray-400" />
                        <div>
                          <p className="text-sm font-medium">Modular Research Framework</p>
                          <p className="text-xs text-gray-500">Introduction to modular research concepts</p>
                        </div>
                      </div>
                      <Button size="sm" variant="ghost">
                        <Download className="h-4 w-4" />
                      </Button>
                    </div>
                    <div className="flex items-center justify-between p-3 rounded-lg border hover:bg-gray-50 transition-colors">
                      <div className="flex items-center space-x-3">
                        <FileText className="h-5 w-5 text-gray-400" />
                        <div>
                          <p className="text-sm font-medium">Case Studies Collection</p>
                          <p className="text-xs text-gray-500">Examples from various fields</p>
                        </div>
                      </div>
                      <Button size="sm" variant="ghost">
                        <Download className="h-4 w-4" />
                      </Button>
                    </div>
                  </div>
                </div>

                <Separator />

                <div>
                  <h4 className="font-medium mb-3">Workshop Tools</h4>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                    <Button variant="outline" className="justify-start">
                      <Video className="mr-2 h-4 w-4" />
                      Zoom Link for Remote Sessions
                    </Button>
                    <Button variant="outline" className="justify-start">
                      <MessageSquare className="mr-2 h-4 w-4" />
                      Slack Workspace
                    </Button>
                    <Button variant="outline" className="justify-start">
                      <FileText className="mr-2 h-4 w-4" />
                      Shared Google Drive
                    </Button>
                    <Button variant="outline" className="justify-start">
                      <Globe className="mr-2 h-4 w-4" />
                      Collaboration Platform
                    </Button>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Connect */}
        <TabsContent value="connect" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center">
                <MessageSquare className="mr-2 h-5 w-5" />
                Stay Connected
              </CardTitle>
              <CardDescription>
                Communication channels and important contacts
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <h4 className="font-medium mb-3">Workshop Organizers</h4>
                <div className="space-y-3">
                  <div className="flex items-center space-x-3 p-3 rounded-lg border">
                    <Avatar className="h-10 w-10">
                      <AvatarFallback>WO</AvatarFallback>
                    </Avatar>
                    <div className="flex-1">
                      <p className="font-medium">Workshop Coordination Team</p>
                      <p className="text-sm text-gray-600">workshop@modularresearch.org</p>
                    </div>
                    <Button size="sm" variant="outline">
                      <Mail className="h-4 w-4" />
                    </Button>
                  </div>
                  <div className="flex items-center space-x-3 p-3 rounded-lg border">
                    <Avatar className="h-10 w-10">
                      <AvatarFallback>SC</AvatarFallback>
                    </Avatar>
                    <div className="flex-1">
                      <p className="font-medium">Dr. Sarah Chen</p>
                      <p className="text-sm text-gray-600">Lead Facilitator</p>
                    </div>
                    <Button size="sm" variant="outline">
                      <Mail className="h-4 w-4" />
                    </Button>
                  </div>
                </div>
              </div>

              <Separator />

              <div>
                <h4 className="font-medium mb-3">Quick Links</h4>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                  <Button variant="outline" className="justify-start">
                    <MessageSquare className="mr-2 h-4 w-4 text-purple-600" />
                    Join Slack Channel
                  </Button>
                  <Button variant="outline" className="justify-start">
                    <Users className="mr-2 h-4 w-4 text-blue-600" />
                    Participant Directory
                  </Button>
                  <Button variant="outline" className="justify-start">
                    <Calendar className="mr-2 h-4 w-4 text-green-600" />
                    Add to Calendar
                  </Button>
                  <Button variant="outline" className="justify-start">
                    <Globe className="mr-2 h-4 w-4 text-orange-600" />
                    Workshop Website
                  </Button>
                </div>
              </div>

              <Alert>
                <Info className="h-4 w-4" />
                <AlertDescription>
                  <strong>Emergency Contact:</strong> For urgent matters during the workshop,
                  call +1 (555) 123-4567 (available 24/7 during workshop days).
                </AlertDescription>
              </Alert>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  )
}