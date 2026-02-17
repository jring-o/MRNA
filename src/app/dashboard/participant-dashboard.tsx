'use client'

import { useState, useEffect, useCallback } from 'react'
import Image from 'next/image'
import { createClient } from '@/lib/supabase/client'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import { Alert, AlertDescription } from '@/components/ui/alert'
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
  Mail
} from 'lucide-react'
import { ParticipantProfileSheet } from './participant-profile-sheet'

interface ParticipantProfile {
  id: string
  name: string | null
  email: string
  organization: string | null
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
  const [selectedParticipant, setSelectedParticipant] = useState<ParticipantProfile | null>(null)
  const [sheetOpen, setSheetOpen] = useState(false)
  const supabase = createClient()

  const loadParticipants = useCallback(async () => {
    try {
      // Query users directly — the participants_view_other_participants
      // RLS policy already filters to only participant-role users.
      const { data: users, error } = await supabase
        .from('users')
        .select('id, name, email, organization')
        .order('name')

      if (error) throw error

      setParticipants(users || [])
    } catch (error) {
      console.error('Error loading participants:', error)
    } finally {
      setLoading(false)
    }
  }, [supabase])

  useEffect(() => {
    loadParticipants()
  }, [loadParticipants])

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
            <li>Complete the <a href="https://www.when2meet.com/?35097357-s1ivK" target="_blank" rel="noopener noreferrer" className="underline font-medium">When2Meet</a> for our Kickoff Call</li>
          </ul>
        </AlertDescription>
      </Alert>

      {/* Main Content Tabs */}
      <Tabs defaultValue="participants" className="space-y-4">
        <TabsList className="grid w-full grid-cols-5">
          <TabsTrigger value="participants">Participants</TabsTrigger>
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
              <CardContent className="space-y-3">
                <div className="space-y-2">
                  <div className="flex items-start space-x-2">
                    <CheckCircle2 className="h-4 w-4 text-green-600 mt-0.5" />
                    <div className="text-sm">
                      <strong>Airport:</strong> Dublin Airport (DUB)
                    </div>
                  </div>
                  <div className="flex items-start space-x-2">
                    <CheckCircle2 className="h-4 w-4 text-green-600 mt-0.5" />
                    <div className="text-sm">
                      <strong>Arrival Date:</strong> June 7, 2026
                    </div>
                  </div>
                  <div className="flex items-start space-x-2">
                    <Info className="h-4 w-4 text-gray-400 mt-0.5" />
                    <div className="text-sm text-gray-500">
                      <strong>Ground Transportation:</strong> Coming soon
                    </div>
                  </div>
                </div>
                <div className="p-3 rounded-lg bg-amber-50 border border-amber-200 text-sm text-amber-800">
                  <strong>Please do not book flights yet.</strong> We are working with our fiscal sponsor to determine the best way to arrange air travel. We will share booking instructions with you soon.
                </div>
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
