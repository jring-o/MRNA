'use client'

import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { CheckCircle2, Calendar, Mail } from 'lucide-react'

export default function ConfirmedPage() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-slate-50 via-white to-blue-50 p-4">
      <Card className="w-full max-w-lg border-0 shadow-xl">
        <CardContent className="pt-8 pb-8">
          <div className="flex flex-col items-center text-center space-y-6">
            <div className="inline-flex items-center justify-center w-20 h-20 bg-green-100 rounded-full">
              <CheckCircle2 className="w-10 h-10 text-green-600" />
            </div>

            <div className="space-y-2">
              <h1 className="text-2xl font-bold text-gray-900">
                You&apos;re Confirmed!
              </h1>
              <p className="text-gray-600">
                Thank you for confirming your attendance at MIRA.
              </p>
            </div>

            <div className="bg-blue-50 rounded-lg p-6 w-full space-y-4">
              <div className="flex items-center gap-3">
                <Calendar className="w-5 h-5 text-blue-600 flex-shrink-0" />
                <div className="text-left">
                  <p className="font-medium text-gray-900">June 7-11, 2026</p>
                  <p className="text-sm text-gray-600">The Deerstone Eco Hideaway, Ireland</p>
                </div>
              </div>
            </div>

            <div className="bg-amber-50 border border-amber-200 rounded-lg p-4 w-full">
              <p className="text-amber-800 text-sm">
                <strong>What&apos;s next?</strong> We&apos;re putting the finishing touches on
                the participant platform. We&apos;ll reach out via email in the coming weeks
                with access to the dashboard, pre-workshop materials, and next steps.
              </p>
            </div>

            <div className="flex items-center gap-2 text-sm text-gray-500">
              <Mail className="w-4 h-4" />
              <span>Keep an eye on your inbox!</span>
            </div>

            <Button asChild variant="outline" className="mt-4">
              <Link href="/">Return to Homepage</Link>
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
