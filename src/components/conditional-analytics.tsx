'use client'

import { useState, useEffect } from 'react'
import { Analytics } from '@vercel/analytics/next'

export function ConditionalAnalytics() {
  const [hasConsent, setHasConsent] = useState(false)

  useEffect(() => {
    // Check if user has consented to analytics
    const checkConsent = () => {
      const consent = localStorage.getItem('analytics-consent')
      setHasConsent(consent === 'true')
    }

    // Check on mount
    checkConsent()

    // Listen for consent changes
    const handleConsentChange = () => {
      checkConsent()
    }

    window.addEventListener('analytics-consent-changed', handleConsentChange)

    return () => {
      window.removeEventListener('analytics-consent-changed', handleConsentChange)
    }
  }, [])

  // Only render Analytics component if user has consented
  if (!hasConsent) return null

  return <Analytics />
}
