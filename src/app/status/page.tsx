'use client'

import { useState, useEffect, Suspense } from 'react'
import Link from 'next/link'
import { useSearchParams } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Alert, AlertDescription } from '@/components/ui/alert'
import { Badge } from '@/components/ui/badge'
import { ArrowLeft, CheckCircle2, Clock, XCircle, AlertCircle, Mail, Download, Trash2 } from 'lucide-react'

function StatusPageContent() {
  const searchParams = useSearchParams()
  const [email, setEmail] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [application, setApplication] = useState<Record<string, unknown> | null>(null)
  const [checked, setChecked] = useState(false)
  const [isDeleting, setIsDeleting] = useState(false)
  const [isExporting, setIsExporting] = useState(false)

  // Pre-fill email from URL if provided
  useEffect(() => {
    const emailParam = searchParams.get('email')
    if (emailParam) {
      setEmail(emailParam)
    }
  }, [searchParams])

  const checkStatus = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError(null)
    setApplication(null)

    try {
      const supabase = createClient()

      // Query application directly by email (no account needed)
      const { data: applicationData, error: applicationError } = await supabase
        .from('applications')
        .select('*')
        .eq('email', email)
        .single()

      if (applicationError || !applicationData) {
        setError('No application found for this email address.')
        setLoading(false)
        setChecked(true)
        return
      }

      setApplication(applicationData)
      setChecked(true)
    } catch (err) {
      console.error('Status check error:', err)
      setError('An error occurred while checking your status.')
    } finally {
      setLoading(false)
    }
  }

  const getStatusBadge = (status: string) => {
    switch (status) {
      case 'pending':
        return (
          <Badge className="bg-yellow-100 text-yellow-800 border-yellow-300">
            <Clock className="w-3 h-3 mr-1" />
            Under Review
          </Badge>
        )
      case 'accepted':
        return (
          <Badge className="bg-green-100 text-green-800 border-green-300">
            <CheckCircle2 className="w-3 h-3 mr-1" />
            Accepted
          </Badge>
        )
      case 'rejected':
        return (
          <Badge className="bg-red-100 text-red-800 border-red-300">
            <XCircle className="w-3 h-3 mr-1" />
            Not Selected
          </Badge>
        )
      case 'waitlisted':
        return (
          <Badge className="bg-blue-100 text-blue-800 border-blue-300">
            <AlertCircle className="w-3 h-3 mr-1" />
            Waitlisted
          </Badge>
        )
      default:
        return null
    }
  }

  const getStatusMessage = (status: string) => {
    switch (status) {
      case 'pending':
        return {
          title: 'Your application is under review',
          description: 'Our team will review all applications after the January 1, 2026 deadline. All applicants will be notified of their status on January 15, 2026 via email.',
          color: 'yellow'
        }
      case 'accepted':
        return {
          title: 'Congratulations! You\'ve been accepted!',
          description: 'Welcome to the workshop! Please check your email for next steps and important information about the workshop. You can also log in to your dashboard to access participant resources.',
          color: 'green'
        }
      case 'rejected':
        return {
          title: 'Thank you for your application',
          description: 'Unfortunately, we are unable to offer you a place in this workshop. Due to the limited number of spots and high volume of excellent applications, we had to make difficult decisions. We encourage you to apply for future workshops.',
          color: 'red'
        }
      case 'waitlisted':
        return {
          title: 'You\'re on the waitlist',
          description: 'Your application was strong, and you\'ve been placed on our waitlist. If a spot becomes available, we will contact you immediately. Please keep your calendar flexible for the workshop dates.',
          color: 'blue'
        }
      default:
        return null
    }
  }

  const handleExportData = () => {
    if (!application) return

    setIsExporting(true)
    try {
      // Create a clean copy of the application data
      const exportData = {
        ...application,
        exported_at: new Date().toISOString(),
        exported_by: email
      }

      // Convert to JSON and download
      const dataStr = JSON.stringify(exportData, null, 2)
      const dataBlob = new Blob([dataStr], { type: 'application/json' })
      const url = URL.createObjectURL(dataBlob)
      const link = document.createElement('a')
      link.href = url
      link.download = `mira-application-${application.id}.json`
      document.body.appendChild(link)
      link.click()
      document.body.removeChild(link)
      URL.revokeObjectURL(url)
    } catch (err) {
      console.error('Export error:', err)
      setError('Failed to export data. Please try again.')
    } finally {
      setIsExporting(false)
    }
  }

  const handleDeleteApplication = async () => {
    if (!application) return

    if (!confirm('Are you sure you want to delete your application? This action cannot be undone.')) {
      return
    }

    setIsDeleting(true)
    setError(null)

    try {
      const response = await fetch('/api/applications/delete', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          applicationId: application.id,
          email: email,
        }),
      })

      const result = await response.json()

      if (!response.ok) {
        throw new Error(result.error || 'Failed to delete application')
      }

      // Success - show message and reset
      alert('Your application has been successfully deleted.')
      setApplication(null)
      setChecked(false)
      setEmail('')
    } catch (err) {
      console.error('Delete error:', err)
      setError(err instanceof Error ? err.message : 'Failed to delete application. Please try again.')
    } finally {
      setIsDeleting(false)
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-white to-blue-50 py-12 px-4">
      <div className="max-w-2xl mx-auto">
        {/* Header */}
        <div className="text-center mb-8">
          <h1 className="text-4xl font-bold text-gray-900 mb-2">
            Check Application Status
          </h1>
          <p className="text-lg text-gray-600">
            Enter your email to view your workshop application status
          </p>
        </div>

        {/* Status Check Form */}
        {!checked && (
          <Card className="shadow-xl">
            <CardHeader>
              <CardTitle>Application Status Lookup</CardTitle>
              <CardDescription>
                Enter the email address you used when submitting your application
              </CardDescription>
            </CardHeader>
            <form onSubmit={checkStatus}>
              <CardContent className="space-y-4">
                {error && (
                  <Alert variant="destructive">
                    <AlertCircle className="h-4 w-4" />
                    <AlertDescription>{error}</AlertDescription>
                  </Alert>
                )}

                <div>
                  <Label htmlFor="email">Email Address</Label>
                  <div className="relative">
                    <Mail className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
                    <Input
                      id="email"
                      type="email"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      placeholder="you@example.com"
                      className="pl-10"
                      required
                    />
                  </div>
                </div>

                <Button type="submit" className="w-full" disabled={loading}>
                  {loading ? 'Checking...' : 'Check Status'}
                </Button>
              </CardContent>
            </form>
          </Card>
        )}

        {/* Status Results */}
        {checked && !application && (
          <Card className="shadow-xl">
            <CardContent className="pt-6">
              <div className="text-center py-8">
                <XCircle className="w-16 h-16 text-gray-400 mx-auto mb-4" />
                <h3 className="text-lg font-semibold text-gray-900 mb-2">
                  No Application Found
                </h3>
                <p className="text-gray-600 mb-6">
                  We couldn&apos;t find an application associated with {email}
                </p>
                <div className="space-y-3">
                  <Button variant="outline" onClick={() => { setChecked(false); setEmail(''); }} className="w-full">
                    Try Another Email
                  </Button>
                  <Button asChild className="w-full">
                    <Link href="/apply">Submit New Application</Link>
                  </Button>
                </div>
              </div>
            </CardContent>
          </Card>
        )}

        {checked && application && (
          <div className="space-y-6">
            {/* Application Status Card */}
            <Card className="shadow-xl">
              <CardHeader>
                <div className="flex items-start justify-between">
                  <div>
                    <CardTitle className="text-2xl">{application.name as string}</CardTitle>
                    <CardDescription className="text-base">
                      {application.organization as string} • {application.role as string}
                    </CardDescription>
                  </div>
                  {getStatusBadge(application.status as string)}
                </div>
              </CardHeader>
              <CardContent>
                {(() => {
                  const message = getStatusMessage(application.status as string)
                  if (!message) return null

                  return (
                    <Alert className={`border-${message.color}-200 bg-${message.color}-50`}>
                      <AlertCircle className="h-4 w-4" />
                      <div>
                        <p className="font-semibold mb-1">{message.title}</p>
                        <AlertDescription>{message.description}</AlertDescription>
                      </div>
                    </Alert>
                  )
                })()}

                {/* Application Timeline */}
                <div className="mt-6 pt-6 border-t">
                  <h3 className="text-sm font-semibold text-gray-900 mb-4">Application Timeline</h3>
                  <div className="space-y-3">
                    <div className="flex items-start">
                      <div className="flex-shrink-0">
                        <CheckCircle2 className="w-5 h-5 text-green-500" />
                      </div>
                      <div className="ml-3">
                        <p className="text-sm font-medium text-gray-900">Application Submitted</p>
                        <p className="text-xs text-gray-500">
                          {new Date(application.submitted_at as string).toLocaleDateString('en-US', {
                            year: 'numeric',
                            month: 'long',
                            day: 'numeric',
                            hour: '2-digit',
                            minute: '2-digit'
                          })}
                        </p>
                      </div>
                    </div>

                    {(application.reviewed_at as string) && (
                      <div className="flex items-start">
                        <div className="flex-shrink-0">
                          <CheckCircle2 className="w-5 h-5 text-green-500" />
                        </div>
                        <div className="ml-3">
                          <p className="text-sm font-medium text-gray-900">Application Reviewed</p>
                          <p className="text-xs text-gray-500">
                            {new Date(application.reviewed_at as string).toLocaleDateString('en-US', {
                              year: 'numeric',
                              month: 'long',
                              day: 'numeric'
                            })}
                          </p>
                        </div>
                      </div>
                    )}
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* GDPR Actions */}
            <Card className="shadow-xl border-blue-200">
              <CardHeader>
                <CardTitle className="text-base">Your Data Rights</CardTitle>
                <CardDescription>Download or delete your application data</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  <Button
                    onClick={handleExportData}
                    variant="outline"
                    className="w-full"
                    disabled={isExporting}
                  >
                    <Download className="mr-2 h-4 w-4" />
                    {isExporting ? 'Exporting...' : 'Export My Data (JSON)'}
                  </Button>
                  <Button
                    onClick={handleDeleteApplication}
                    variant="destructive"
                    className="w-full"
                    disabled={isDeleting}
                  >
                    <Trash2 className="mr-2 h-4 w-4" />
                    {isDeleting ? 'Deleting...' : 'Delete My Application'}
                  </Button>
                  <p className="text-xs text-gray-500 mt-2">
                    Learn more about your rights in our{' '}
                    <Link href="/privacy" className="text-blue-600 hover:underline">Privacy Policy</Link>
                  </p>
                </div>
              </CardContent>
            </Card>

            {/* Action Buttons */}
            <Card className="shadow-xl">
              <CardContent className="pt-6">
                <div className="space-y-3">
                  {(application.status as string) === 'accepted' && (
                    <Button asChild className="w-full">
                      <Link href="/login">
                        Access Participant Dashboard
                      </Link>
                    </Button>
                  )}
                  <Button variant="outline" onClick={() => { setChecked(false); setEmail(''); setApplication(null); }} className="w-full">
                    <ArrowLeft className="mr-2 h-4 w-4" />
                    Check Another Application
                  </Button>
                </div>
              </CardContent>
            </Card>
          </div>
        )}

        {/* Footer Links */}
        <div className="mt-8 text-center text-sm text-gray-600">
          <Link href="/apply" className="text-blue-600 hover:text-blue-500">
            Submit New Application
          </Link>
          {' • '}
          <Link href="/login" className="text-blue-600 hover:text-blue-500">
            Login to Dashboard
          </Link>
          {' • '}
          <Link href="/" className="text-blue-600 hover:text-blue-500">
            Back to Homepage
          </Link>
        </div>
      </div>
    </div>
  )
}

export default function StatusPage() {
  return (
    <Suspense fallback={
      <div className="min-h-screen bg-gradient-to-br from-slate-50 via-white to-blue-50 py-12 px-4">
        <div className="max-w-2xl mx-auto">
          <div className="text-center">
            <h1 className="text-4xl font-bold text-gray-900 mb-2">Loading...</h1>
          </div>
        </div>
      </div>
    }>
      <StatusPageContent />
    </Suspense>
  )
}