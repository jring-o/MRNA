'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { Checkbox } from '@/components/ui/checkbox'
import { X, Cookie, BarChart3 } from 'lucide-react'

export function CookieConsent() {
  const [showBanner, setShowBanner] = useState(false)
  const [showPreferences, setShowPreferences] = useState(false)
  const [analyticsEnabled, setAnalyticsEnabled] = useState(false)

  useEffect(() => {
    // Check if user has already given consent
    const consent = localStorage.getItem('cookie-consent')
    if (!consent) {
      // Show banner after a short delay for better UX
      setTimeout(() => setShowBanner(true), 1000)
    }

    // Load current analytics preference
    const analyticsPref = localStorage.getItem('analytics-consent')
    setAnalyticsEnabled(analyticsPref === 'true')
  }, [])

  const handleAcceptAll = () => {
    localStorage.setItem('cookie-consent', 'accepted')
    localStorage.setItem('analytics-consent', 'true')
    setShowBanner(false)
    // Trigger analytics reload
    window.dispatchEvent(new Event('analytics-consent-changed'))
  }

  const handleEssentialOnly = () => {
    localStorage.setItem('cookie-consent', 'accepted')
    localStorage.setItem('analytics-consent', 'false')
    setShowBanner(false)
  }

  const handleSavePreferences = () => {
    localStorage.setItem('cookie-consent', 'accepted')
    localStorage.setItem('analytics-consent', analyticsEnabled ? 'true' : 'false')
    setShowBanner(false)
    setShowPreferences(false)
    if (analyticsEnabled) {
      window.dispatchEvent(new Event('analytics-consent-changed'))
    }
  }

  if (!showBanner) return null

  if (showPreferences) {
    return (
      <div className="fixed bottom-0 left-0 right-0 z-50 p-4 animate-in slide-in-from-bottom duration-500">
        <div className="max-w-4xl mx-auto bg-white border border-gray-200 rounded-lg shadow-2xl">
          <div className="p-6">
            <div className="flex items-start gap-4">
              <div className="flex-1">
                <h3 className="text-lg font-semibold text-gray-900 mb-4">
                  Cookie Preferences
                </h3>

                {/* Essential Cookies */}
                <div className="mb-4 pb-4 border-b">
                  <div className="flex items-start gap-3">
                    <Cookie className="h-5 w-5 text-blue-600 mt-1 flex-shrink-0" />
                    <div className="flex-1">
                      <div className="flex items-center justify-between mb-1">
                        <h4 className="font-semibold text-gray-900">Essential Cookies</h4>
                        <span className="text-xs bg-gray-200 text-gray-700 px-2 py-1 rounded">Always Active</span>
                      </div>
                      <p className="text-sm text-gray-600">
                        Required for authentication and site functionality. Cannot be disabled.
                      </p>
                    </div>
                  </div>
                </div>

                {/* Analytics Cookies */}
                <div className="mb-6">
                  <div className="flex items-start gap-3">
                    <BarChart3 className="h-5 w-5 text-purple-600 mt-1 flex-shrink-0" />
                    <div className="flex-1">
                      <div className="flex items-center justify-between mb-1">
                        <h4 className="font-semibold text-gray-900">Analytics Cookies (Optional)</h4>
                        <div className="flex items-center gap-2">
                          <Checkbox
                            id="analytics-toggle"
                            checked={analyticsEnabled}
                            onCheckedChange={(checked) => setAnalyticsEnabled(checked as boolean)}
                          />
                          <label htmlFor="analytics-toggle" className="text-sm text-gray-700 cursor-pointer">
                            {analyticsEnabled ? 'Enabled' : 'Disabled'}
                          </label>
                        </div>
                      </div>
                      <p className="text-sm text-gray-600">
                        Help us understand how visitors use our website through anonymized page view data.
                        Provided by Vercel Analytics (privacy-friendly, no personal data collected).
                      </p>
                    </div>
                  </div>
                </div>

                <p className="text-xs text-gray-500 mb-4">
                  Learn more in our{' '}
                  <Link href="/privacy" className="text-blue-600 hover:underline">
                    Privacy Policy
                  </Link>
                </p>

                <div className="flex justify-end">
                  <Button
                    onClick={handleSavePreferences}
                    size="sm"
                    className="bg-blue-600 hover:bg-blue-700 text-white"
                  >
                    Save Preferences
                  </Button>
                </div>
              </div>
              <button
                onClick={handleEssentialOnly}
                className="flex-shrink-0 text-gray-400 hover:text-gray-600 transition-colors"
                aria-label="Close"
              >
                <X className="h-5 w-5" />
              </button>
            </div>
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="fixed bottom-0 left-0 right-0 z-50 p-4 animate-in slide-in-from-bottom duration-500">
      <div className="max-w-4xl mx-auto bg-white border border-gray-200 rounded-lg shadow-2xl">
        <div className="p-6">
          <div className="flex items-start gap-4">
            <div className="flex-shrink-0">
              <Cookie className="h-6 w-6 text-blue-600" />
            </div>
            <div className="flex-1">
              <h3 className="text-lg font-semibold text-gray-900 mb-2">
                Cookie Notice
              </h3>
              <p className="text-sm text-gray-600 leading-relaxed mb-4">
                We use essential cookies for authentication and optional analytics cookies to understand how visitors
                use our website. You can choose to accept all cookies or only essential ones.
              </p>
              <p className="text-xs text-gray-500 mb-4">
                Learn more in our{' '}
                <Link href="/privacy" className="text-blue-600 hover:underline">
                  Privacy Policy
                </Link>
              </p>
              <div className="flex gap-3 flex-wrap">
                <Button
                  onClick={handleAcceptAll}
                  size="sm"
                  className="bg-blue-600 hover:bg-blue-700 text-white"
                >
                  Accept All
                </Button>
                <Button
                  onClick={handleEssentialOnly}
                  variant="outline"
                  size="sm"
                >
                  Essential Only
                </Button>
                <Button
                  onClick={() => {
                    // Load current preference when opening modal
                    const analyticsPref = localStorage.getItem('analytics-consent')
                    setAnalyticsEnabled(analyticsPref === 'true')
                    setShowPreferences(true)
                  }}
                  variant="ghost"
                  size="sm"
                  className="text-gray-600"
                >
                  Manage Preferences
                </Button>
              </div>
            </div>
            <button
              onClick={handleEssentialOnly}
              className="flex-shrink-0 text-gray-400 hover:text-gray-600 transition-colors"
              aria-label="Close"
            >
              <X className="h-5 w-5" />
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}
