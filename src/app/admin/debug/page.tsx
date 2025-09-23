'use client'

import { useEffect, useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'

export default function DebugPage() {
  const [debugInfo, setDebugInfo] = useState<Record<string, unknown> | null>(null)
  const [jwtDebug, setJwtDebug] = useState<Record<string, unknown> | null>(null)
  const [session, setSession] = useState<Record<string, unknown> | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const checkAuth = async () => {
      try {
        const supabase = createClient()

        // Get session
        const { data: { session: currentSession } } = await supabase.auth.getSession()
        setSession(currentSession as Record<string, unknown> | null)

        // Get user
        const { data: { user } } = await supabase.auth.getUser()

        // Try to call the debug function
        const { data: debugData, error: debugError } = await supabase
          .rpc('debug_jwt')

        if (debugError) {
          console.error('Debug function error:', debugError)
          setError(`Debug function error: ${debugError.message}`)
        }

        setJwtDebug(debugData as Record<string, unknown> | null)

        // Test the comments query
        const { data: testData, error: testError } = await supabase
          .from('application_comments')
          .select(`
            id,
            author:users!author_id(id, name, email)
          `)
          .limit(1)

        setDebugInfo({
          user,
          testQuery: testData,
          testError: testError?.message || null,
          sessionToken: currentSession?.access_token ? 'Present' : 'Missing',
        })
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Unknown error')
      } finally {
        setLoading(false)
      }
    }

    checkAuth()
  }, [])

  if (loading) return <div className="p-8">Loading debug info...</div>

  return (
    <div className="container mx-auto p-8 space-y-6">
      <h1 className="text-2xl font-bold">Debug Page - JWT and Auth Info</h1>

      {error && (
        <Card className="border-red-500">
          <CardHeader>
            <CardTitle className="text-red-600">Error</CardTitle>
          </CardHeader>
          <CardContent>
            <pre className="text-sm">{error}</pre>
          </CardContent>
        </Card>
      )}

      <Card>
        <CardHeader>
          <CardTitle>Session Info</CardTitle>
        </CardHeader>
        <CardContent>
          <pre className="text-xs overflow-auto">
            {JSON.stringify({
              hasSession: !!session,
              // eslint-disable-next-line @typescript-eslint/no-explicit-any
              accessToken: (session as any)?.access_token ? 'Present' : 'Missing',
              // eslint-disable-next-line @typescript-eslint/no-explicit-any
              expiresAt: (session as any)?.expires_at,
              // eslint-disable-next-line @typescript-eslint/no-explicit-any
              user: (session as any)?.user?.email,
              // eslint-disable-next-line @typescript-eslint/no-explicit-any
              appMetadata: (session as any)?.user?.app_metadata,
            }, null, 2)}
          </pre>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>JWT Debug (from database function)</CardTitle>
        </CardHeader>
        <CardContent>
          <pre className="text-xs overflow-auto">
            {JSON.stringify(jwtDebug, null, 2)}
          </pre>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Auth Debug Info</CardTitle>
        </CardHeader>
        <CardContent>
          <pre className="text-xs overflow-auto">
            {JSON.stringify(debugInfo, null, 2)}
          </pre>
        </CardContent>
      </Card>
    </div>
  )
}