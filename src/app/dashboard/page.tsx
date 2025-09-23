'use server'

import { redirect } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import {
  Users,
  FileText,
  Calendar,
  Settings,
  MessageSquare,
  TrendingUp,
  CheckCircle2,
  Clock,
  ArrowRight,
  Zap,
  Target,
  Award,
  BookOpen,
  Briefcase,
  Globe
} from 'lucide-react'

export default async function DashboardPage() {
  const supabase = await createClient()

  // Get the current user
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  // Get user role from app_metadata
  const role = user.app_metadata?.role || 'applicant'

  // Get user profile
  const { data: profile } = await supabase
    .from('users')
    .select('*')
    .eq('id', user.id)
    .single()

  const initials = profile?.name
    ? profile.name.split(' ').map(n => n[0]).join('').toUpperCase()
    : user.email?.[0].toUpperCase() || 'U'

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-white to-blue-50">
      {/* Header */}
      <div className="bg-white border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            <div className="flex items-center">
              <h1 className="text-xl font-bold bg-gradient-to-r from-blue-600 to-cyan-600 bg-clip-text text-transparent">
                Modular Research Workshop
              </h1>
            </div>
            <div className="flex items-center space-x-4">
              <Badge variant={role === 'admin' ? 'default' : role === 'participant' ? 'secondary' : 'outline'}>
                {role}
              </Badge>
              <Avatar>
                <AvatarFallback className="bg-gradient-to-r from-blue-600 to-cyan-600 text-white">
                  {initials}
                </AvatarFallback>
              </Avatar>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        {/* Welcome Section */}
        <div className="mb-8">
          <h2 className="text-3xl font-bold text-gray-900 mb-2">
            Welcome back, {profile?.name || 'Researcher'}!
          </h2>
          <p className="text-gray-600">
            {role === 'admin' && 'Manage the workshop and review applications from your dashboard.'}
            {role === 'participant' && 'Access workshop resources and collaborate with fellow researchers.'}
            {role === 'applicant' && 'Complete your application to join the Spring 2026 workshop.'}
          </p>
        </div>

        {role === 'admin' && (
          <div className="space-y-6">
            {/* Stats Overview */}
            <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
              <Card>
                <CardHeader className="pb-3">
                  <CardTitle className="text-sm font-medium text-gray-500">Total Applications</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold">47</div>
                  <p className="text-xs text-muted-foreground flex items-center mt-1">
                    <TrendingUp className="w-3 h-3 mr-1 text-green-500" />
                    +12% from last week
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader className="pb-3">
                  <CardTitle className="text-sm font-medium text-gray-500">Under Review</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold">23</div>
                  <p className="text-xs text-muted-foreground flex items-center mt-1">
                    <Clock className="w-3 h-3 mr-1 text-yellow-500" />
                    Awaiting decision
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader className="pb-3">
                  <CardTitle className="text-sm font-medium text-gray-500">Accepted</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold">18</div>
                  <p className="text-xs text-muted-foreground flex items-center mt-1">
                    <CheckCircle2 className="w-3 h-3 mr-1 text-green-500" />
                    Target: 20-22
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader className="pb-3">
                  <CardTitle className="text-sm font-medium text-gray-500">Days to Workshop</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold">142</div>
                  <p className="text-xs text-muted-foreground flex items-center mt-1">
                    <Calendar className="w-3 h-3 mr-1 text-blue-500" />
                    Spring 2026
                  </p>
                </CardContent>
              </Card>
            </div>

            {/* Admin Actions */}
            <Tabs defaultValue="applications" className="space-y-4">
              <TabsList>
                <TabsTrigger value="applications">Applications</TabsTrigger>
                <TabsTrigger value="workshop">Workshop Setup</TabsTrigger>
                <TabsTrigger value="communications">Communications</TabsTrigger>
              </TabsList>

              <TabsContent value="applications" className="space-y-4">
                <Card>
                  <CardHeader>
                    <CardTitle>Recent Applications</CardTitle>
                    <CardDescription>Review and manage workshop applications</CardDescription>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="space-y-3">
                      <div className="flex items-center justify-between p-3 rounded-lg border hover:bg-gray-50 transition-colors">
                        <div className="flex items-center space-x-3">
                          <Avatar className="h-8 w-8">
                            <AvatarFallback>AS</AvatarFallback>
                          </Avatar>
                          <div>
                            <p className="text-sm font-medium">Alex Smith</p>
                            <p className="text-xs text-gray-500">MIT - Computational Biology</p>
                          </div>
                        </div>
                        <div className="flex items-center space-x-2">
                          <Badge variant="outline" className="text-xs">New</Badge>
                          <Button size="sm" variant="ghost">
                            Review <ArrowRight className="ml-1 h-3 w-3" />
                          </Button>
                        </div>
                      </div>
                      <div className="flex items-center justify-between p-3 rounded-lg border hover:bg-gray-50 transition-colors">
                        <div className="flex items-center space-x-3">
                          <Avatar className="h-8 w-8">
                            <AvatarFallback>JD</AvatarFallback>
                          </Avatar>
                          <div>
                            <p className="text-sm font-medium">Jamie Davis</p>
                            <p className="text-xs text-gray-500">Stanford - Systems Design</p>
                          </div>
                        </div>
                        <div className="flex items-center space-x-2">
                          <Badge variant="secondary" className="text-xs">In Review</Badge>
                          <Button size="sm" variant="ghost">
                            Continue <ArrowRight className="ml-1 h-3 w-3" />
                          </Button>
                        </div>
                      </div>
                    </div>
                    <Button className="w-full" variant="outline">
                      View All Applications
                    </Button>
                  </CardContent>
                </Card>
              </TabsContent>

              <TabsContent value="workshop" className="space-y-4">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <Card className="hover:shadow-lg transition-shadow cursor-pointer">
                    <CardHeader>
                      <CardTitle className="flex items-center">
                        <Users className="mr-2 h-5 w-5 text-blue-600" />
                        Manage Participants
                      </CardTitle>
                    </CardHeader>
                    <CardContent>
                      <p className="text-sm text-gray-600">Configure participant access and roles</p>
                    </CardContent>
                  </Card>
                  <Card className="hover:shadow-lg transition-shadow cursor-pointer">
                    <CardHeader>
                      <CardTitle className="flex items-center">
                        <Calendar className="mr-2 h-5 w-5 text-green-600" />
                        Schedule Sessions
                      </CardTitle>
                    </CardHeader>
                    <CardContent>
                      <p className="text-sm text-gray-600">Plan workshop agenda and breakout sessions</p>
                    </CardContent>
                  </Card>
                  <Card className="hover:shadow-lg transition-shadow cursor-pointer">
                    <CardHeader>
                      <CardTitle className="flex items-center">
                        <FileText className="mr-2 h-5 w-5 text-purple-600" />
                        Workshop Content
                      </CardTitle>
                    </CardHeader>
                    <CardContent>
                      <p className="text-sm text-gray-600">Upload materials and resources</p>
                    </CardContent>
                  </Card>
                  <Card className="hover:shadow-lg transition-shadow cursor-pointer">
                    <CardHeader>
                      <CardTitle className="flex items-center">
                        <Settings className="mr-2 h-5 w-5 text-orange-600" />
                        Settings
                      </CardTitle>
                    </CardHeader>
                    <CardContent>
                      <p className="text-sm text-gray-600">Configure workshop parameters</p>
                    </CardContent>
                  </Card>
                </div>
              </TabsContent>

              <TabsContent value="communications" className="space-y-4">
                <Card>
                  <CardHeader>
                    <CardTitle>Announcements</CardTitle>
                    <CardDescription>Send updates to applicants and participants</CardDescription>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <Button className="w-full">
                      <MessageSquare className="mr-2 h-4 w-4" />
                      Compose Announcement
                    </Button>
                  </CardContent>
                </Card>
              </TabsContent>
            </Tabs>
          </div>
        )}

        {role === 'participant' && (
          <div className="space-y-6">
            {/* Welcome Card */}
            <Card className="bg-gradient-to-r from-blue-600 to-cyan-600 text-white">
              <CardHeader>
                <CardTitle className="text-2xl">Congratulations! You&apos;re In!</CardTitle>
                <CardDescription className="text-blue-100">
                  You&apos;ve been selected for the Spring 2026 Modular Research Attribution Workshop
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="flex items-center space-x-2">
                  <Award className="h-5 w-5" />
                  <span className="text-sm">One of 20 selected researchers worldwide</span>
                </div>
              </CardContent>
            </Card>

            {/* Quick Actions */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <Card className="hover:shadow-lg transition-all hover:scale-105 cursor-pointer">
                <CardHeader>
                  <CardTitle className="text-lg flex items-center">
                    <Zap className="mr-2 h-5 w-5 text-yellow-500" />
                    Workshop Hub
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-gray-600">Access workshop materials and agenda</p>
                  <Button className="w-full mt-4" variant="outline">
                    Enter Hub
                  </Button>
                </CardContent>
              </Card>

              <Card className="hover:shadow-lg transition-all hover:scale-105 cursor-pointer">
                <CardHeader>
                  <CardTitle className="text-lg flex items-center">
                    <Users className="mr-2 h-5 w-5 text-blue-500" />
                    Breakout Rooms
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-gray-600">Join collaborative sessions</p>
                  <Button className="w-full mt-4" variant="outline">
                    Join Room
                  </Button>
                </CardContent>
              </Card>

              <Card className="hover:shadow-lg transition-all hover:scale-105 cursor-pointer">
                <CardHeader>
                  <CardTitle className="text-lg flex items-center">
                    <MessageSquare className="mr-2 h-5 w-5 text-green-500" />
                    Discussions
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-gray-600">Connect with other participants</p>
                  <Button className="w-full mt-4" variant="outline">
                    Open Chat
                  </Button>
                </CardContent>
              </Card>
            </div>

            {/* Upcoming Sessions */}
            <Card>
              <CardHeader>
                <CardTitle>Your Schedule</CardTitle>
                <CardDescription>Upcoming workshop sessions</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  <div className="flex items-center justify-between p-3 rounded-lg bg-blue-50">
                    <div className="flex items-center space-x-3">
                      <div className="h-10 w-10 rounded-lg bg-blue-600 text-white flex items-center justify-center font-bold">
                        D1
                      </div>
                      <div>
                        <p className="font-medium">Opening Keynote & Introductions</p>
                        <p className="text-sm text-gray-500">Day 1 - 9:00 AM</p>
                      </div>
                    </div>
                    <Badge>Required</Badge>
                  </div>
                  <div className="flex items-center justify-between p-3 rounded-lg bg-green-50">
                    <div className="flex items-center space-x-3">
                      <div className="h-10 w-10 rounded-lg bg-green-600 text-white flex items-center justify-center font-bold">
                        D2
                      </div>
                      <div>
                        <p className="font-medium">Standards Design Workshop</p>
                        <p className="text-sm text-gray-500">Day 2 - 10:00 AM</p>
                      </div>
                    </div>
                    <Badge variant="secondary">Breakout</Badge>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        )}

        {role === 'applicant' && (
          <div className="space-y-6">
            {/* Application CTA */}
            <Card className="border-2 border-dashed border-blue-300 bg-blue-50/50">
              <CardHeader>
                <CardTitle className="flex items-center">
                  <Target className="mr-2 h-5 w-5 text-blue-600" />
                  Start Your Journey
                </CardTitle>
                <CardDescription>
                  Join leading researchers in revolutionizing scientific attribution
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
                  <div className="text-center">
                    <div className="text-2xl font-bold text-blue-600">4</div>
                    <p className="text-sm text-gray-600">Days</p>
                  </div>
                  <div className="text-center">
                    <div className="text-2xl font-bold text-blue-600">20</div>
                    <p className="text-sm text-gray-600">Researchers</p>
                  </div>
                  <div className="text-center">
                    <div className="text-2xl font-bold text-blue-600">$100k</div>
                    <p className="text-sm text-gray-600">TNF Funding</p>
                  </div>
                </div>
                <Button className="w-full" size="lg" asChild>
                  <Link href="/apply">
                    <FileText className="mr-2 h-4 w-4" />
                    Begin Application
                  </Link>
                </Button>
              </CardContent>
            </Card>

            {/* Why Apply */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg flex items-center">
                    <Globe className="mr-2 h-5 w-5 text-purple-600" />
                    Global Impact
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-gray-600">
                    Shape the future of how scientific contributions are recognized and attributed
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg flex items-center">
                    <Briefcase className="mr-2 h-5 w-5 text-orange-600" />
                    Career Growth
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-gray-600">
                    Connect with leading researchers and expand your professional network
                  </p>
                </CardContent>
              </Card>
            </div>

            {/* Resources */}
            <Card>
              <CardHeader>
                <CardTitle>Learn More</CardTitle>
                <CardDescription>Resources to help with your application</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  <a href="#" className="flex items-center justify-between p-3 rounded-lg border hover:bg-gray-50 transition-colors group">
                    <div className="flex items-center space-x-3">
                      <BookOpen className="h-5 w-5 text-gray-400" />
                      <div>
                        <p className="font-medium">Workshop Overview</p>
                        <p className="text-sm text-gray-500">Goals, format, and expected outcomes</p>
                      </div>
                    </div>
                    <ArrowRight className="h-4 w-4 text-gray-400 group-hover:translate-x-1 transition-transform" />
                  </a>
                  <a href="#" className="flex items-center justify-between p-3 rounded-lg border hover:bg-gray-50 transition-colors group">
                    <div className="flex items-center space-x-3">
                      <Users className="h-5 w-5 text-gray-400" />
                      <div>
                        <p className="font-medium">Past Participants</p>
                        <p className="text-sm text-gray-500">See who&apos;s attended previous workshops</p>
                      </div>
                    </div>
                    <ArrowRight className="h-4 w-4 text-gray-400 group-hover:translate-x-1 transition-transform" />
                  </a>
                </div>
              </CardContent>
            </Card>
          </div>
        )}
      </div>
    </div>
  )
}