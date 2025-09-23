'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'
import { Alert, AlertDescription } from '@/components/ui/alert'
import { Separator } from '@/components/ui/separator'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import * as z from 'zod'
import {
  ArrowLeft,
  ArrowRight,
  User,
  FileText,
  Calendar,
  Check,
  Loader2,
  Info,
  AlertCircle,
  Building,
  Link as LinkIcon
} from 'lucide-react'

// Custom word count validator function
const wordCount = (min: number, max: number, minMessage: string, maxMessage: string) => {
  return z.string().superRefine((val, ctx) => {
    const words = val?.trim().split(/\s+/).filter(word => word.length > 0).length || 0

    if (words < min && min > 0) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: minMessage,
      })
    }

    if (words > max) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: maxMessage,
      })
    }
  })
}

// Form validation schema
const applicationSchema = z.object({
  // Personal Information
  name: z.string().min(2, 'Name must be at least 2 characters'),
  email: z.string().email('Invalid email address'),
  organization: z.string().min(2, 'Organization is required'),
  role: z.string().min(2, 'Role/Title is required'),

  // Application Content - Now with proper word count validation
  reason_for_applying: wordCount(
    50, 500,
    'Please provide at least 50 words',
    'Maximum 500 words allowed'
  ),
  requirements_for_protocol: wordCount(
    30, 300,
    'Please provide at least 30 words',
    'Maximum 300 words allowed'
  ),
  relevant_experience: wordCount(
    0, 300,
    '',
    'Maximum 300 words allowed'
  ).optional().or(z.literal('')),
  links: z.array(z.string().url().or(z.literal(''))).max(3).optional(),

  // Logistics
  availability_confirmed: z.boolean().refine(val => val === true, {
    message: 'You must confirm availability'
  }),
  travel_requirements: z.string().optional(),
  dietary_restrictions: z.string().optional(),
})

type ApplicationFormData = z.infer<typeof applicationSchema>

const steps = [
  { id: 1, name: 'Personal Info', icon: User },
  { id: 2, name: 'Application', icon: FileText },
  { id: 3, name: 'Logistics', icon: Calendar },
]

export default function ApplyPage() {
  const router = useRouter()
  const [currentStep, setCurrentStep] = useState(1)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [wordCounts, setWordCounts] = useState({
    reason_for_applying: 0,
    requirements_for_protocol: 0,
    relevant_experience: 0,
  })

  const {
    register,
    handleSubmit,
    formState: { errors },
    trigger,
  } = useForm<ApplicationFormData>({
    resolver: zodResolver(applicationSchema),
    mode: 'onChange',
    defaultValues: {
      links: ['', '', ''],
      availability_confirmed: false,
    }
  })

  const updateWordCount = (field: keyof typeof wordCounts, value: string) => {
    const words = value?.trim().split(/\s+/).filter(word => word.length > 0).length || 0
    setWordCounts(prev => ({ ...prev, [field]: words }))
  }

  const nextStep = async () => {
    // Validate current step fields
    let fieldsToValidate: (keyof ApplicationFormData)[] = []

    if (currentStep === 1) {
      fieldsToValidate = ['name', 'email', 'organization', 'role']
    } else if (currentStep === 2) {
      fieldsToValidate = ['reason_for_applying', 'requirements_for_protocol']
    }

    const isValid = await trigger(fieldsToValidate)
    if (isValid) {
      setCurrentStep(prev => Math.min(prev + 1, steps.length))
    }
  }

  const prevStep = () => {
    setCurrentStep(prev => Math.max(prev - 1, 1))
  }

  const onSubmit = async (data: ApplicationFormData) => {
    setIsSubmitting(true)
    setError(null)

    try {
      const supabase = createClient()

      // Check if an application already exists for this email
      const { data: existingApp } = await supabase
        .from('applications')
        .select('id')
        .eq('email', data.email)
        .single()

      if (existingApp) {
        setError('An application has already been submitted with this email address. Please check your application status.')
        setIsSubmitting(false)
        return
      }

      // Submit application directly (no account required)
      const applicationData = {
        // Include email, name, org directly in application
        email: data.email,
        name: data.name,
        organization: data.organization,
        role: data.role,
        reason_for_applying: data.reason_for_applying,
        requirements_for_protocol: data.requirements_for_protocol,
        relevant_experience: data.relevant_experience || null,
        // Store additional data in admin_notes temporarily
        admin_notes: [
          `Links: ${data.links?.filter(l => l).join(', ') || 'None'}`,
          `Travel Requirements: ${data.travel_requirements || 'None'}`,
          `Dietary Restrictions: ${data.dietary_restrictions || 'None'}`,
          `Availability Confirmed: ${data.availability_confirmed ? 'Yes' : 'No'}`
        ],
      }

      const { data: newApplication, error: applicationError } = await supabase
        .from('applications')
        .insert(applicationData)
        .select()
        .single()

      if (applicationError) {
        console.error('Application error:', applicationError)
        setError('Failed to submit application. Please try again.')
        setIsSubmitting(false)
        return
      }

      // Send confirmation email
      try {
        await fetch('/api/emails/send-confirmation', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            applicationId: newApplication.id,
            applicantEmail: data.email,
            applicantName: data.name,
            organization: data.organization || '',
            submittedAt: new Date().toISOString(),
          }),
        })
      } catch (emailError) {
        // Don't block submission if email fails
        console.error('Failed to send confirmation email:', emailError)
      }

      // Redirect to success page with email for status checking
      router.push(`/apply/success?email=${encodeURIComponent(data.email)}`)
    } catch (err) {
      console.error('Submission error:', err)
      setError('An unexpected error occurred. Please try again.')
      setIsSubmitting(false)
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-white to-blue-50">
      <div className="max-w-4xl mx-auto py-12 px-4">
        {/* Header */}
        <div className="text-center mb-8">
          <h1 className="text-4xl font-bold text-gray-900 mb-2">
            Apply to the Workshop
          </h1>
          <p className="text-lg text-gray-600">
            Join leading researchers in revolutionizing scientific attribution
          </p>
        </div>

        {/* Progress Steps */}
        <div className="mb-8">
          <div className="flex items-center justify-between">
            {steps.map((step, index) => {
              const Icon = step.icon
              return (
                <div key={step.id} className="flex-1 relative">
                  <div className="flex items-center">
                    <div
                      className={`
                        w-12 h-12 rounded-full flex items-center justify-center transition-all
                        ${currentStep > step.id
                          ? 'bg-green-600 text-white'
                          : currentStep === step.id
                          ? 'bg-blue-600 text-white ring-4 ring-blue-100'
                          : 'bg-gray-200 text-gray-500'}
                      `}
                    >
                      {currentStep > step.id ? (
                        <Check className="w-5 h-5" />
                      ) : (
                        <Icon className="w-5 h-5" />
                      )}
                    </div>
                    <div className="ml-3">
                      <p className={`text-sm font-medium ${
                        currentStep >= step.id ? 'text-gray-900' : 'text-gray-500'
                      }`}>
                        Step {step.id}
                      </p>
                      <p className={`text-xs ${
                        currentStep >= step.id ? 'text-gray-600' : 'text-gray-400'
                      }`}>
                        {step.name}
                      </p>
                    </div>
                  </div>
                  {index < steps.length - 1 && (
                    <div className={`
                      absolute top-6 left-12 w-full h-0.5 transition-all
                      ${currentStep > step.id ? 'bg-green-600' : 'bg-gray-200'}
                    `} />
                  )}
                </div>
              )
            })}
          </div>
        </div>

        {/* Form Card */}
        <form onSubmit={handleSubmit(onSubmit)}>
          <Card className="shadow-xl">
            <CardHeader>
              <CardTitle>
                {currentStep === 1 && 'Personal Information'}
                {currentStep === 2 && 'Application Details'}
                {currentStep === 3 && 'Logistics & Confirmation'}
              </CardTitle>
              <CardDescription>
                {currentStep === 1 && 'Tell us about yourself and your current role'}
                {currentStep === 2 && 'Share your motivation and relevant experience'}
                {currentStep === 3 && 'Confirm availability and provide logistics information'}
              </CardDescription>
            </CardHeader>

            <CardContent className="space-y-6">
              {error && (
                <Alert variant="destructive">
                  <AlertCircle className="h-4 w-4" />
                  <AlertDescription>{error}</AlertDescription>
                </Alert>
              )}

              {/* Step 1: Personal Information */}
              {currentStep === 1 && (
                <div className="space-y-4">
                  <div>
                    <Label htmlFor="name">Full Name *</Label>
                    <Input
                      id="name"
                      {...register('name')}
                      placeholder="Jane Smith"
                      className={errors.name ? 'border-red-500' : ''}
                    />
                    {errors.name && (
                      <p className="text-sm text-red-500 mt-1">{errors.name.message}</p>
                    )}
                  </div>

                  <div>
                    <Label htmlFor="email">Email Address *</Label>
                    <Input
                      id="email"
                      type="email"
                      {...register('email')}
                      placeholder="jane@university.edu"
                      className={errors.email ? 'border-red-500' : ''}
                    />
                    {errors.email && (
                      <p className="text-sm text-red-500 mt-1">{errors.email.message}</p>
                    )}
                  </div>

                  <div>
                    <Label htmlFor="organization">Organization/Institution *</Label>
                    <div className="relative">
                      <Building className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
                      <Input
                        id="organization"
                        {...register('organization')}
                        placeholder="MIT Media Lab"
                        className={`pl-10 ${errors.organization ? 'border-red-500' : ''}`}
                      />
                    </div>
                    {errors.organization && (
                      <p className="text-sm text-red-500 mt-1">{errors.organization.message}</p>
                    )}
                  </div>

                  <div>
                    <Label htmlFor="role">Current Role/Title *</Label>
                    <Input
                      id="role"
                      {...register('role')}
                      placeholder="Research Scientist"
                      className={errors.role ? 'border-red-500' : ''}
                    />
                    {errors.role && (
                      <p className="text-sm text-red-500 mt-1">{errors.role.message}</p>
                    )}
                  </div>
                </div>
              )}

              {/* Step 2: Application Content */}
              {currentStep === 2 && (
                <div className="space-y-6">
                  <div>
                    <div className="flex items-center justify-between mb-2">
                      <Label htmlFor="reason_for_applying">Why do you want to participate? *</Label>
                      <span className="text-xs text-gray-500">
                        {wordCounts.reason_for_applying}/500 words
                      </span>
                    </div>
                    <textarea
                      id="reason_for_applying"
                      {...register('reason_for_applying', {
                        onChange: (e) => updateWordCount('reason_for_applying', e.target.value)
                      })}
                      className={`w-full min-h-[150px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                        errors.reason_for_applying ? 'border-red-500' : 'border-gray-300'
                      }`}
                      placeholder="Describe your motivation for participating in this workshop and how it aligns with your research goals..."
                    />
                    {errors.reason_for_applying && (
                      <p className="text-sm text-red-500 mt-1">{errors.reason_for_applying.message}</p>
                    )}
                  </div>

                  <div>
                    <div className="flex items-center justify-between mb-2">
                      <Label htmlFor="requirements_for_protocol">
                        What requirements would you have for an attribution protocol? *
                      </Label>
                      <span className="text-xs text-gray-500">
                        {wordCounts.requirements_for_protocol}/300 words
                      </span>
                    </div>
                    <textarea
                      id="requirements_for_protocol"
                      {...register('requirements_for_protocol', {
                        onChange: (e) => updateWordCount('requirements_for_protocol', e.target.value)
                      })}
                      className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                        errors.requirements_for_protocol ? 'border-red-500' : 'border-gray-300'
                      }`}
                      placeholder="Describe specific features or capabilities you would need in a research attribution system..."
                    />
                    {errors.requirements_for_protocol && (
                      <p className="text-sm text-red-500 mt-1">{errors.requirements_for_protocol.message}</p>
                    )}
                  </div>

                  <div>
                    <div className="flex items-center justify-between mb-2">
                      <Label htmlFor="relevant_experience">
                        Relevant Experience (Optional)
                      </Label>
                      <span className="text-xs text-gray-500">
                        {wordCounts.relevant_experience}/300 words
                      </span>
                    </div>
                    <textarea
                      id="relevant_experience"
                      {...register('relevant_experience', {
                        onChange: (e) => updateWordCount('relevant_experience', e.target.value)
                      })}
                      className="w-full min-h-[120px] px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      placeholder="Share any relevant experience with attribution systems, collaborative research, or protocol design..."
                    />
                    {errors.relevant_experience && (
                      <p className="text-sm text-red-500 mt-1">{errors.relevant_experience.message}</p>
                    )}
                  </div>

                  <div>
                    <Label>Links to Previous Work (Optional)</Label>
                    <p className="text-sm text-gray-500 mb-2">Add up to 3 URLs to relevant publications or projects</p>
                    <div className="space-y-2">
                      {[0, 1, 2].map((index) => (
                        <div key={index} className="relative">
                          <LinkIcon className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
                          <Input
                            {...register(`links.${index}` as const)}
                            placeholder="https://example.com/your-work"
                            className="pl-10"
                          />
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              )}

              {/* Step 3: Logistics */}
              {currentStep === 3 && (
                <div className="space-y-6">
                  <div className="rounded-lg bg-blue-50 p-4">
                    <div className="flex">
                      <Info className="h-5 w-5 text-blue-400 flex-shrink-0" />
                      <div className="ml-3">
                        <h3 className="text-sm font-medium text-blue-800">Workshop Details</h3>
                        <div className="mt-2 text-sm text-blue-700">
                          <ul className="list-disc space-y-1 pl-5">
                            <li>Date: Spring 2026 (exact dates TBD)</li>
                            <li>Duration: 4 days intensive workshop</li>
                            <li>Format: In-person collaboration</li>
                            <li>Participants: 18-22 researchers</li>
                          </ul>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div className="space-y-4">
                    <div className="flex items-start">
                      <input
                        id="availability_confirmed"
                        type="checkbox"
                        {...register('availability_confirmed')}
                        className="mt-1 h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                      />
                      <div className="ml-3">
                        <Label htmlFor="availability_confirmed" className="cursor-pointer">
                          I confirm my availability for the full 4-day workshop *
                        </Label>
                        <p className="text-sm text-gray-500 mt-1">
                          You must be able to attend all workshop days
                        </p>
                      </div>
                    </div>
                    {errors.availability_confirmed && (
                      <p className="text-sm text-red-500">{errors.availability_confirmed.message}</p>
                    )}
                  </div>

                  <div>
                    <Label htmlFor="travel_requirements">Travel Requirements (Optional)</Label>
                    <textarea
                      id="travel_requirements"
                      {...register('travel_requirements')}
                      className="w-full min-h-[80px] px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      placeholder="Any special travel requirements or accommodations needed..."
                    />
                  </div>

                  <div>
                    <Label htmlFor="dietary_restrictions">Dietary Restrictions (Optional)</Label>
                    <Input
                      id="dietary_restrictions"
                      {...register('dietary_restrictions')}
                      placeholder="Vegetarian, vegan, allergies, etc."
                    />
                  </div>

                  <Separator />

                  <div className="rounded-lg bg-gray-50 p-4">
                    <h3 className="text-sm font-medium text-gray-900 mb-2">Before you submit:</h3>
                    <ul className="text-sm text-gray-600 space-y-1">
                      <li>• Applications are reviewed on a rolling basis</li>
                      <li>• You&apos;ll receive a confirmation email after submission</li>
                      <li>• Decisions will be communicated within 2-3 weeks</li>
                      <li>• You can check your status anytime using your email</li>
                    </ul>
                  </div>
                </div>
              )}
            </CardContent>

            <CardFooter className="flex justify-between">
              <Button
                type="button"
                variant="outline"
                onClick={prevStep}
                disabled={currentStep === 1}
                className={currentStep === 1 ? 'invisible' : ''}
              >
                <ArrowLeft className="mr-2 h-4 w-4" />
                Previous
              </Button>

              {currentStep < steps.length ? (
                <Button type="button" onClick={nextStep}>
                  Next
                  <ArrowRight className="ml-2 h-4 w-4" />
                </Button>
              ) : (
                <Button type="submit" disabled={isSubmitting}>
                  {isSubmitting ? (
                    <>
                      <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                      Submitting...
                    </>
                  ) : (
                    <>
                      Submit Application
                      <Check className="ml-2 h-4 w-4" />
                    </>
                  )}
                </Button>
              )}
            </CardFooter>
          </Card>
        </form>

        {/* Footer Links */}
        <div className="mt-8 text-center text-sm text-gray-600">
          <Link href="/login" className="text-blue-600 hover:text-blue-500">
            Already applied? Check your status
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