'use client'

import { useState, useEffect, Suspense } from 'react'
import { useRouter, useSearchParams } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'
import { Alert, AlertDescription } from '@/components/ui/alert'
import { Mail, Lock, User, Building, ArrowRight, CheckCircle2, AlertCircle, XCircle } from 'lucide-react'

function SignUpContent() {
  const router = useRouter()
  const searchParams = useSearchParams()
  const token = searchParams.get('token')
  const email = searchParams.get('email')

  const [formData, setFormData] = useState({
    email: email || '',
    password: '',
    name: '',
    organization: ''
  })
  const [error, setError] = useState<string | null>(null)
  const [loading, setLoading] = useState(false)
  const [validatingToken, setValidatingToken] = useState(true)
  const [tokenValid, setTokenValid] = useState(false)

  useEffect(() => {
    validateInviteToken()
  }, [token, email]) // eslint-disable-line react-hooks/exhaustive-deps

  const validateInviteToken = async () => {
    if (!token || !email) {
      setError('Invalid invitation link. Please use the link from your acceptance email.')
      setValidatingToken(false)
      return
    }

    const supabase = createClient()

    // Check if token is valid
    const { data, error } = await supabase
      .from('invite_tokens')
      .select('*')
      .eq('token', token)
      .eq('email', email)
      .eq('used', false)
      .gte('expires_at', new Date().toISOString())
      .single()

    if (error || !data) {
      setError('This invitation link is invalid or has expired. Please contact the workshop organizers.')
      setTokenValid(false)
    } else {
      setTokenValid(true)
    }
    setValidatingToken(false)
  }

  const handleSignUp = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError(null)

    if (!tokenValid || !token) {
      setError('Invalid invitation token')
      setLoading(false)
      return
    }

    const supabase = createClient()

    // Validate token again and mark as used
    const { data: tokenData, error: tokenError } = await supabase.rpc(
      'validate_invite_token',
      { p_token: token, p_email: formData.email }
    )

    if (tokenError || !tokenData) {
      setError('Failed to validate invitation token')
      setLoading(false)
      return
    }

    // Sign up the user
    const { error: authError } = await supabase.auth.signUp({
      email: formData.email,
      password: formData.password,
      options: {
        data: {
          name: formData.name,
          organization: formData.organization,
          role: 'participant' // Set role to participant
        }
      }
    })

    if (authError) {
      setError(authError.message)
      setLoading(false)
      return
    }

    // Since we disabled email confirmation, always go to dashboard
    router.push('/dashboard')
    router.refresh()
  }

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    })
  }

  if (validatingToken) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-slate-50 via-white to-blue-50">
        <Card className="w-full max-w-md">
          <CardContent className="pt-6">
            <div className="flex flex-col items-center space-y-4">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
              <p className="text-gray-600">Validating your invitation...</p>
            </div>
          </CardContent>
        </Card>
      </div>
    )
  }

  if (!tokenValid) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-slate-50 via-white to-blue-50">
        <Card className="w-full max-w-md">
          <CardContent className="pt-6">
            <div className="flex flex-col items-center space-y-4">
              <XCircle className="w-12 h-12 text-red-500" />
              <h3 className="text-lg font-semibold">Invalid Invitation</h3>
              <p className="text-center text-gray-600">{error}</p>
              <div className="flex flex-col space-y-2 w-full">
                <Button asChild variant="outline">
                  <Link href="/apply">Apply for the Workshop</Link>
                </Button>
                <Button asChild variant="outline">
                  <Link href="/status">Check Application Status</Link>
                </Button>
                <Button asChild variant="outline">
                  <Link href="/">Return to Homepage</Link>
                </Button>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    )
  }

  return (
    <div className="min-h-screen flex bg-gradient-to-br from-slate-50 via-white to-blue-50">
      {/* Left Side - Welcome Message */}
      <div className="hidden lg:flex lg:w-1/2 bg-gradient-to-br from-cyan-600 to-blue-600 p-12 relative overflow-hidden">
        <div className="absolute inset-0 bg-grid-white/10 bg-grid-16 [mask-image:radial-gradient(ellipse_at_center,transparent_20%,black)]"></div>
        <div className="relative z-10 flex flex-col justify-center text-white">
          <div>
            <h1 className="text-4xl font-bold mb-4">
              Welcome to the Workshop!
            </h1>
            <p className="text-blue-100 text-lg mb-8">
              You&apos;ve been accepted to the Modular Research Attribution Workshop
            </p>
          </div>

          <div className="space-y-6">
            <div className="bg-white/10 backdrop-blur-sm rounded-lg p-6">
              <h3 className="text-xl font-semibold mb-4">Congratulations! 🎉</h3>
              <p className="text-blue-50 mb-4">
                Your application has been accepted. Create your account to access:
              </p>
              <ul className="space-y-3">
                <li className="flex items-start space-x-3">
                  <CheckCircle2 className="w-5 h-5 flex-shrink-0 text-blue-200 mt-0.5" />
                  <span className="text-blue-50">Participant directory and profiles</span>
                </li>
                <li className="flex items-start space-x-3">
                  <CheckCircle2 className="w-5 h-5 flex-shrink-0 text-blue-200 mt-0.5" />
                  <span className="text-blue-50">Workshop schedule and logistics</span>
                </li>
                <li className="flex items-start space-x-3">
                  <CheckCircle2 className="w-5 h-5 flex-shrink-0 text-blue-200 mt-0.5" />
                  <span className="text-blue-50">Pre-workshop collaboration tools</span>
                </li>
                <li className="flex items-start space-x-3">
                  <CheckCircle2 className="w-5 h-5 flex-shrink-0 text-blue-200 mt-0.5" />
                  <span className="text-blue-50">Shared resources and documents</span>
                </li>
              </ul>
            </div>
          </div>

          <div className="mt-8">
            <div className="bg-white/10 backdrop-blur-sm rounded-lg p-6">
              <p className="text-blue-100 text-sm mb-2">Workshop Details</p>
              <div className="grid grid-cols-2 gap-4 text-sm">
                <div>
                  <p className="text-blue-200">Date</p>
                  <p className="font-semibold">Spring 2026</p>
                </div>
                <div>
                  <p className="text-blue-200">Duration</p>
                  <p className="font-semibold">4 Days</p>
                </div>
                <div>
                  <p className="text-blue-200">Format</p>
                  <p className="font-semibold">In-Person</p>
                </div>
                <div>
                  <p className="text-blue-200">Your Status</p>
                  <p className="font-semibold text-green-300">Accepted</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Right Side - Signup Form */}
      <div className="flex-1 flex items-center justify-center p-8">
        <div className="w-full max-w-md space-y-8">
          <div className="text-center">
            <div className="inline-flex items-center justify-center w-16 h-16 bg-green-100 rounded-full mb-4">
              <CheckCircle2 className="w-8 h-8 text-green-600" />
            </div>
            <h2 className="text-3xl font-bold text-gray-900 mb-2">
              Create Your Account
            </h2>
            <p className="text-gray-600">
              Complete your registration for the workshop
            </p>
          </div>

          <Card className="border-0 shadow-xl">
            <form onSubmit={handleSignUp}>
              <CardHeader className="pb-4">
                <CardTitle>Participant Registration</CardTitle>
                <CardDescription>
                  Set up your account to access workshop resources
                </CardDescription>
              </CardHeader>

              <CardContent className="space-y-4">
                {error && (
                  <Alert variant="destructive">
                    <AlertCircle className="h-4 w-4" />
                    <AlertDescription>{error}</AlertDescription>
                  </Alert>
                )}

                <Alert>
                  <CheckCircle2 className="h-4 w-4" />
                  <AlertDescription>
                    Registering as <span className="font-semibold">{email}</span>
                  </AlertDescription>
                </Alert>

                <div className="space-y-2">
                  <Label htmlFor="name">Full Name *</Label>
                  <div className="relative">
                    <User className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
                    <Input
                      id="name"
                      name="name"
                      type="text"
                      placeholder="Your full name"
                      value={formData.name}
                      onChange={handleChange}
                      className="pl-10"
                      required
                    />
                  </div>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="email">Email Address *</Label>
                  <div className="relative">
                    <Mail className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
                    <Input
                      id="email"
                      name="email"
                      type="email"
                      value={formData.email}
                      className="pl-10 bg-gray-50"
                      disabled
                      required
                    />
                  </div>
                  <p className="text-xs text-gray-500">
                    This email is linked to your accepted application
                  </p>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="organization">Organization</Label>
                  <div className="relative">
                    <Building className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
                    <Input
                      id="organization"
                      name="organization"
                      type="text"
                      placeholder="Your institution or company"
                      value={formData.organization}
                      onChange={handleChange}
                      className="pl-10"
                    />
                  </div>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="password">Create Password *</Label>
                  <div className="relative">
                    <Lock className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
                    <Input
                      id="password"
                      name="password"
                      type="password"
                      placeholder="Choose a secure password"
                      value={formData.password}
                      onChange={handleChange}
                      className="pl-10"
                      required
                    />
                  </div>
                  <p className="text-xs text-gray-500">
                    At least 6 characters
                  </p>
                </div>
              </CardContent>

              <CardFooter className="flex flex-col space-y-4">
                <Button
                  type="submit"
                  className="w-full"
                  size="lg"
                  disabled={loading}
                >
                  {loading ? (
                    <>
                      <div className="mr-2 h-4 w-4 animate-spin rounded-full border-2 border-white border-t-transparent" />
                      Creating account...
                    </>
                  ) : (
                    <>
                      Complete Registration
                      <ArrowRight className="ml-2 h-4 w-4" />
                    </>
                  )}
                </Button>

                <p className="text-xs text-center text-gray-500">
                  By creating an account, you confirm your participation in the
                  Spring 2026 workshop and agree to collaborate respectfully.
                </p>
              </CardFooter>
            </form>
          </Card>
        </div>
      </div>
    </div>
  )
}

export default function SignUpPage() {
  return (
    <Suspense fallback={
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-slate-50 via-white to-blue-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600">Loading...</p>
        </div>
      </div>
    }>
      <SignUpContent />
    </Suspense>
  )
}