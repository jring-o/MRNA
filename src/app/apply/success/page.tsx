'use client'

import { Suspense } from 'react'
import { useSearchParams } from 'next/navigation'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { CheckCircle2, Mail, Calendar, ArrowRight } from 'lucide-react'

function ApplicationSuccessContent() {
  const searchParams = useSearchParams()
  const email = searchParams.get('email') || ''

  return (
    <div className="min-h-screen bg-gradient-to-br from-green-50 via-white to-blue-50 flex items-center justify-center px-4">
      <div className="max-w-2xl w-full">
        {/* Success Card */}
        <Card className="shadow-xl">
          <CardHeader className="text-center pb-4">
            <div className="mx-auto w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mb-4">
              <CheckCircle2 className="w-12 h-12 text-green-600" />
            </div>
            <CardTitle className="text-3xl">Application Submitted!</CardTitle>
            <CardDescription className="text-lg">
              Thank you for applying to MIRA, Modular Interoperable Research Attribution
            </CardDescription>
          </CardHeader>

          <CardContent className="space-y-6">
            {/* Email Confirmation */}
            <div className="rounded-lg bg-blue-50 p-4">
              <div className="flex items-start">
                <Mail className="h-5 w-5 text-blue-600 mt-0.5 flex-shrink-0" />
                <div className="ml-3">
                  <h3 className="text-sm font-semibold text-gray-900">Confirmation Email Sent</h3>
                  <p className="text-sm text-gray-600 mt-1">
                    We&apos;ve sent a confirmation to <span className="font-medium">{email}</span>
                  </p>
                  <p className="text-sm text-gray-600 mt-1">
                    Please check your inbox (and spam folder) for details about your application.
                  </p>
                </div>
              </div>
            </div>

            {/* What Happens Next */}
            <div className="space-y-4">
              <h3 className="font-semibold text-gray-900">What happens next?</h3>

              <div className="space-y-3">
                <div className="flex items-start">
                  <div className="flex-shrink-0 w-8 h-8 bg-gray-100 rounded-full flex items-center justify-center text-sm font-medium">
                    1
                  </div>
                  <div className="ml-3">
                    <p className="text-sm font-medium text-gray-900">Application Review</p>
                    <p className="text-sm text-gray-600">
                      Our team will carefully review your application over the next 2-3 weeks
                    </p>
                  </div>
                </div>

                <div className="flex items-start">
                  <div className="flex-shrink-0 w-8 h-8 bg-gray-100 rounded-full flex items-center justify-center text-sm font-medium">
                    2
                  </div>
                  <div className="ml-3">
                    <p className="text-sm font-medium text-gray-900">Decision Notification</p>
                    <p className="text-sm text-gray-600">
                      You&apos;ll receive an email with our decision and next steps
                    </p>
                  </div>
                </div>

                <div className="flex items-start">
                  <div className="flex-shrink-0 w-8 h-8 bg-gray-100 rounded-full flex items-center justify-center text-sm font-medium">
                    3
                  </div>
                  <div className="ml-3">
                    <p className="text-sm font-medium text-gray-900">Workshop Preparation</p>
                    <p className="text-sm text-gray-600">
                      If accepted, you&apos;ll gain access to pre-workshop materials and collaboration tools
                    </p>
                  </div>
                </div>
              </div>
            </div>

            {/* Important Dates */}
            <div className="rounded-lg bg-gray-50 p-4">
              <div className="flex items-start">
                <Calendar className="h-5 w-5 text-gray-600 mt-0.5 flex-shrink-0" />
                <div className="ml-3">
                  <h3 className="text-sm font-semibold text-gray-900">Important Dates</h3>
                  <ul className="text-sm text-gray-600 mt-2 space-y-1">
                    <li>• Application deadline: Fall 2025</li>
                    <li>• Decisions announced: 2-3 weeks after submission</li>
                    <li>• Workshop dates: June 7-11, 2026 (5 days)</li>
                  </ul>
                </div>
              </div>
            </div>

            {/* Action Buttons */}
            <div className="space-y-3 pt-4">
              <Button asChild className="w-full" variant="default">
                <Link href={`/status?email=${encodeURIComponent(email)}`}>
                  Check Application Status
                  <ArrowRight className="ml-2 h-4 w-4" />
                </Link>
              </Button>

              <Button asChild className="w-full" variant="outline">
                <Link href="/">
                  Back to Homepage
                </Link>
              </Button>
            </div>

            {/* Save Email Reminder */}
            <div className="text-center">
              <p className="text-xs text-gray-500">
                Save this email address to check your application status:
              </p>
              <p className="text-sm font-mono font-medium text-gray-700 mt-1">
                {email}
              </p>
            </div>
          </CardContent>
        </Card>

        {/* Footer Links */}
        <div className="mt-8 text-center text-sm text-gray-600">
          <Link href="/blog" className="text-blue-600 hover:text-blue-500">
            Learn more about the workshop
          </Link>
          {' • '}
          <Link href="/contact" className="text-blue-600 hover:text-blue-500">
            Contact us
          </Link>
        </div>
      </div>
    </div>
  )
}

export default function ApplicationSuccessPage() {
  return (
    <Suspense fallback={
      <div className="min-h-screen bg-gradient-to-br from-green-50 via-white to-blue-50 flex items-center justify-center px-4">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900">Loading...</h1>
        </div>
      </div>
    }>
      <ApplicationSuccessContent />
    </Suspense>
  )
}