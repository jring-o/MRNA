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
import { Checkbox } from '@/components/ui/checkbox'
import { useForm, useFieldArray } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import * as z from 'zod'
import type { Classification } from '@/types/database'
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
  Plus,
  Trash2
} from 'lucide-react'

// Custom word count validator function
const wordCount = (max: number, maxMessage: string) => {
  return z.string().min(1, 'This field is required').superRefine((val, ctx) => {
    const words = val?.trim().split(/\s+/).filter(word => word.length > 0).length || 0

    if (words > max) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: maxMessage,
      })
    }
  })
}

// Form validation schema - dynamic based on classifications
const createApplicationSchema = (classifications: string[]) => {
  const baseSchema = {
    // Page 1: Personal Information & Classifications
    name: z.string().min(2, 'Name must be at least 2 characters'),
    email: z.string().email('Invalid email address'),
    organization: z.string().min(2, 'Organization is required'),
    role: z.string().min(2, 'Role/Title is required'),
    classifications: z.array(z.string()).min(1, 'Select at least one classification'),
    classification_other: z.string().optional(),

    // Page 2: Universal Questions (all applicants)
    importance_of_schema: wordCount(200, 'Maximum 200 words allowed'),
    excited_projects: wordCount(200, 'Maximum 200 words allowed'),
    work_links: z.array(z.object({
      url: z.string().url('Invalid URL format').or(z.literal('')),
      role: z.string().min(1, 'Role description is required'),
    })).min(1, 'At least one link is required').max(5, 'Maximum 5 links allowed'),
    workshop_contribution: wordCount(200, 'Maximum 200 words allowed'),
    research_elements: wordCount(200, 'Maximum 200 words allowed'),

    // Page 3: Logistics
    availability_confirmed: z.boolean().refine(val => val === true, {
      message: 'You must confirm availability'
    }),
    travel_requirements: z.string().optional(),
    dietary_restrictions: z.string().optional(),
  }

  // Conditionally add role-specific fields
  const roleSpecificFields: any = {}

  if (classifications.includes('researcher')) {
    roleSpecificFields.researcher_use_case = wordCount(200, 'Maximum 200 words allowed')
    roleSpecificFields.researcher_future_impact = wordCount(200, 'Maximum 200 words allowed')
  }

  if (classifications.includes('designer')) {
    roleSpecificFields.designer_ux_considerations = wordCount(200, 'Maximum 200 words allowed')
  }

  if (classifications.includes('engineer')) {
    roleSpecificFields.engineer_working_on = wordCount(200, 'Maximum 200 words allowed')
    roleSpecificFields.engineer_schema_considerations = wordCount(200, 'Maximum 200 words allowed')
  }

  if (classifications.includes('conceptionalist')) {
    roleSpecificFields.conceptionalist_unlock = wordCount(200, 'Maximum 200 words allowed')
    roleSpecificFields.conceptionalist_enable = wordCount(200, 'Maximum 200 words allowed')
  }

  // Check if 'other' selected and require classification_other
  if (classifications.includes('other')) {
    baseSchema.classification_other = z.string()
      .min(1, 'Please specify your classification')
      .max(15, 'Maximum 15 characters allowed')
  }

  return z.object({ ...baseSchema, ...roleSpecificFields })
}

type ApplicationFormData = z.infer<ReturnType<typeof createApplicationSchema>>

const steps = [
  { id: 1, name: 'Personal Info & Classification', icon: User },
  { id: 2, name: 'Application Questions', icon: FileText },
  { id: 3, name: 'Logistics', icon: Calendar },
]

const classificationOptions: { value: Classification; label: string }[] = [
  { value: 'researcher', label: 'Researcher' },
  { value: 'engineer', label: 'Engineer' },
  { value: 'designer', label: 'Designer' },
  { value: 'conceptionalist', label: 'Conceptionalist' },
  { value: 'other', label: 'Other' },
]

export default function ApplyPage() {
  const router = useRouter()
  const [currentStep, setCurrentStep] = useState(1)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [selectedClassifications, setSelectedClassifications] = useState<string[]>([])
  const [wordCounts, setWordCounts] = useState<Record<string, number>>({})

  const {
    register,
    handleSubmit,
    formState: { errors },
    trigger,
    watch,
    control,
    setValue,
  } = useForm<ApplicationFormData>({
    resolver: zodResolver(createApplicationSchema(selectedClassifications)),
    mode: 'onChange',
    defaultValues: {
      classifications: [],
      work_links: [{ url: '', role: '' }],
      availability_confirmed: false,
    }
  })

  const { fields, append, remove } = useFieldArray({
    control,
    name: 'work_links',
  })

  const watchClassifications = watch('classifications')

  const updateWordCount = (field: string, value: string) => {
    const words = value?.trim().split(/\s+/).filter(word => word.length > 0).length || 0
    setWordCounts(prev => ({ ...prev, [field]: words }))
  }

  const handleClassificationChange = (classification: string, checked: boolean) => {
    const current = watchClassifications || []
    let updated: string[]

    if (checked) {
      updated = [...current, classification]
    } else {
      updated = current.filter(c => c !== classification)
    }

    setValue('classifications', updated)
    setSelectedClassifications(updated)
  }

  const nextStep = async () => {
    // Validate current step fields
    let fieldsToValidate: (keyof ApplicationFormData)[] = []

    if (currentStep === 1) {
      fieldsToValidate = ['name', 'email', 'organization', 'role', 'classifications']
      if (selectedClassifications.includes('other')) {
        fieldsToValidate.push('classification_other')
      }
    } else if (currentStep === 2) {
      // Validate universal questions
      fieldsToValidate = [
        'importance_of_schema',
        'excited_projects',
        'work_links',
        'workshop_contribution',
        'research_elements',
      ]

      // Validate role-specific questions based on classifications
      if (selectedClassifications.includes('researcher')) {
        fieldsToValidate.push('researcher_use_case', 'researcher_future_impact')
      }
      if (selectedClassifications.includes('designer')) {
        fieldsToValidate.push('designer_ux_considerations')
      }
      if (selectedClassifications.includes('engineer')) {
        fieldsToValidate.push('engineer_working_on', 'engineer_schema_considerations')
      }
      if (selectedClassifications.includes('conceptionalist')) {
        fieldsToValidate.push('conceptionalist_unlock', 'conceptionalist_enable')
      }
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

      // Filter out empty work links
      const validWorkLinks = data.work_links.filter(link => link.url && link.role)

      // Submit application
      const applicationData: any = {
        // Personal info
        email: data.email,
        name: data.name,
        organization: data.organization,
        role: data.role,

        // Classifications
        classifications: data.classifications,
        classification_other: data.classification_other || null,

        // Universal questions
        importance_of_schema: data.importance_of_schema,
        excited_projects: data.excited_projects,
        work_links: validWorkLinks,
        workshop_contribution: data.workshop_contribution,
        research_elements: data.research_elements,

        // Role-specific questions (conditionally included)
        researcher_use_case: data.classifications.includes('researcher') ? data.researcher_use_case : null,
        researcher_future_impact: data.classifications.includes('researcher') ? data.researcher_future_impact : null,
        designer_ux_considerations: data.classifications.includes('designer') ? data.designer_ux_considerations : null,
        engineer_working_on: data.classifications.includes('engineer') ? data.engineer_working_on : null,
        engineer_schema_considerations: data.classifications.includes('engineer') ? data.engineer_schema_considerations : null,
        conceptionalist_unlock: data.classifications.includes('conceptionalist') ? data.conceptionalist_unlock : null,
        conceptionalist_enable: data.classifications.includes('conceptionalist') ? data.conceptionalist_enable : null,

        // Logistics stored in admin_notes for now
        admin_notes: [
          `Availability Confirmed: ${data.availability_confirmed ? 'Yes' : 'No'}`,
          `Travel Requirements: ${data.travel_requirements || 'None'}`,
          `Dietary Restrictions: ${data.dietary_restrictions || 'None'}`,
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
                {currentStep === 1 && 'Personal Information & Classification'}
                {currentStep === 2 && 'Application Questions'}
                {currentStep === 3 && 'Logistics & Confirmation'}
              </CardTitle>
              <CardDescription>
                {currentStep === 1 && 'Tell us about yourself and how you classify your work'}
                {currentStep === 2 && 'Share your perspectives and motivations'}
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

              {/* Step 1: Personal Information & Classifications */}
              {currentStep === 1 && (
                <div className="space-y-6">
                  {/* Personal Info */}
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

                  <Separator />

                  {/* Classifications */}
                  <div>
                    <Label className="text-base">How would you classify yourself? *</Label>
                    <p className="text-sm text-gray-500 mb-4">Select one or more that apply</p>

                    <div className="space-y-3">
                      {classificationOptions.map((option) => (
                        <div key={option.value} className="flex items-start space-x-3">
                          <Checkbox
                            id={option.value}
                            checked={watchClassifications?.includes(option.value)}
                            onCheckedChange={(checked) =>
                              handleClassificationChange(option.value, checked as boolean)
                            }
                            className="mt-1"
                          />
                          <div className="flex-1">
                            <Label
                              htmlFor={option.value}
                              className="text-sm font-normal cursor-pointer"
                            >
                              {option.label}
                            </Label>

                            {/* Show text input for "Other" */}
                            {option.value === 'other' && watchClassifications?.includes('other') && (
                              <Input
                                {...register('classification_other')}
                                placeholder="Specify your classification (max 15 characters)"
                                className={`mt-2 ${errors.classification_other ? 'border-red-500' : ''}`}
                                maxLength={15}
                              />
                            )}
                          </div>
                        </div>
                      ))}
                    </div>

                    {errors.classifications && (
                      <p className="text-sm text-red-500 mt-2">{errors.classifications.message}</p>
                    )}
                    {errors.classification_other && (
                      <p className="text-sm text-red-500 mt-2">{errors.classification_other.message}</p>
                    )}
                  </div>
                </div>
              )}

              {/* Step 2: Application Questions */}
              {currentStep === 2 && (
                <div className="space-y-8">
                  {/* Universal Questions Section */}
                  <div className="space-y-6">
                    <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
                      <h3 className="font-semibold text-blue-900 mb-1">Questions for All Applicants</h3>
                      <p className="text-sm text-blue-700">Everyone answers these questions</p>
                    </div>

                    {/* Question 1 */}
                    <div>
                      <div className="flex items-center justify-between mb-2">
                        <Label htmlFor="importance_of_schema">
                          Why is an interoperable Research attribution Schema important to you? *
                        </Label>
                        <span className="text-xs text-gray-500">
                          {wordCounts.importance_of_schema || 0}/200 words
                        </span>
                      </div>
                      <textarea
                        id="importance_of_schema"
                        {...register('importance_of_schema', {
                          onChange: (e) => updateWordCount('importance_of_schema', e.target.value)
                        })}
                        className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                          errors.importance_of_schema ? 'border-red-500' : 'border-gray-300'
                        }`}
                        placeholder="Share why this matters to you..."
                      />
                      {errors.importance_of_schema && (
                        <p className="text-sm text-red-500 mt-1">{errors.importance_of_schema.message}</p>
                      )}
                    </div>

                    {/* Question 2 */}
                    <div>
                      <div className="flex items-center justify-between mb-2">
                        <Label htmlFor="excited_projects">
                          What other science, science infrastructure, open science, modular research, etc. projects are you excited about? *
                        </Label>
                        <span className="text-xs text-gray-500">
                          {wordCounts.excited_projects || 0}/200 words
                        </span>
                      </div>
                      <textarea
                        id="excited_projects"
                        {...register('excited_projects', {
                          onChange: (e) => updateWordCount('excited_projects', e.target.value)
                        })}
                        className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                          errors.excited_projects ? 'border-red-500' : 'border-gray-300'
                        }`}
                        placeholder="Tell us about projects that inspire you..."
                      />
                      {errors.excited_projects && (
                        <p className="text-sm text-red-500 mt-1">{errors.excited_projects.message}</p>
                      )}
                    </div>

                    {/* Question 3: Work Links */}
                    <div>
                      <Label>Links to what you&apos;re working on *</Label>
                      <p className="text-sm text-gray-500 mb-3">Add 1-5 links with a description of your role</p>
                      <div className="space-y-3">
                        {fields.map((field, index) => (
                          <div key={field.id} className="flex gap-2 items-start">
                            <div className="flex-1 space-y-2">
                              <Input
                                {...register(`work_links.${index}.url` as const)}
                                placeholder="https://example.com/your-project"
                                className={errors.work_links?.[index]?.url ? 'border-red-500' : ''}
                              />
                              <Input
                                {...register(`work_links.${index}.role` as const)}
                                placeholder="Your role (e.g., Lead Developer, PI, Designer)"
                                className={errors.work_links?.[index]?.role ? 'border-red-500' : ''}
                              />
                            </div>
                            {fields.length > 1 && (
                              <Button
                                type="button"
                                variant="outline"
                                size="icon"
                                onClick={() => remove(index)}
                                className="mt-0"
                              >
                                <Trash2 className="h-4 w-4" />
                              </Button>
                            )}
                          </div>
                        ))}
                        {fields.length < 5 && (
                          <Button
                            type="button"
                            variant="outline"
                            size="sm"
                            onClick={() => append({ url: '', role: '' })}
                            className="w-full"
                          >
                            <Plus className="h-4 w-4 mr-2" />
                            Add another link
                          </Button>
                        )}
                      </div>
                      {errors.work_links && (
                        <p className="text-sm text-red-500 mt-1">
                          {typeof errors.work_links.message === 'string'
                            ? errors.work_links.message
                            : 'Please provide valid links and role descriptions'}
                        </p>
                      )}
                    </div>

                    {/* Question 4 */}
                    <div>
                      <div className="flex items-center justify-between mb-2">
                        <Label htmlFor="workshop_contribution">
                          What would you add to this workshop if you came (specific experience, perspective, etc)? *
                        </Label>
                        <span className="text-xs text-gray-500">
                          {wordCounts.workshop_contribution || 0}/200 words
                        </span>
                      </div>
                      <textarea
                        id="workshop_contribution"
                        {...register('workshop_contribution', {
                          onChange: (e) => updateWordCount('workshop_contribution', e.target.value)
                        })}
                        className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                          errors.workshop_contribution ? 'border-red-500' : 'border-gray-300'
                        }`}
                        placeholder="What unique perspective or skills would you bring..."
                      />
                      {errors.workshop_contribution && (
                        <p className="text-sm text-red-500 mt-1">{errors.workshop_contribution.message}</p>
                      )}
                    </div>

                    {/* Question 5 */}
                    <div>
                      <div className="flex items-center justify-between mb-2">
                        <Label htmlFor="research_elements">
                          What elements or outputs of the research process would you define? For example: A Claim, a dataset, etc. *
                        </Label>
                        <span className="text-xs text-gray-500">
                          {wordCounts.research_elements || 0}/200 words
                        </span>
                      </div>
                      <textarea
                        id="research_elements"
                        {...register('research_elements', {
                          onChange: (e) => updateWordCount('research_elements', e.target.value)
                        })}
                        className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                          errors.research_elements ? 'border-red-500' : 'border-gray-300'
                        }`}
                        placeholder="Define the key elements you'd want to track..."
                      />
                      {errors.research_elements && (
                        <p className="text-sm text-red-500 mt-1">{errors.research_elements.message}</p>
                      )}
                    </div>
                  </div>

                  {/* Role-Specific Questions */}
                  {selectedClassifications.includes('researcher') && (
                    <div className="space-y-6">
                      <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
                        <h3 className="font-semibold text-blue-900 mb-1">Questions for Researchers</h3>
                        <p className="text-sm text-blue-700">Because you selected Researcher</p>
                      </div>

                      <div>
                        <div className="flex items-center justify-between mb-2">
                          <Label htmlFor="researcher_use_case">
                            What is your immediate use-case for modular research sharing and/or attribution? *
                          </Label>
                          <span className="text-xs text-gray-500">
                            {wordCounts.researcher_use_case || 0}/200 words
                          </span>
                        </div>
                        <textarea
                          id="researcher_use_case"
                          {...register('researcher_use_case', {
                            onChange: (e) => updateWordCount('researcher_use_case', e.target.value)
                          })}
                          className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                            errors.researcher_use_case ? 'border-red-500' : 'border-gray-300'
                          }`}
                          placeholder="Describe your current use case..."
                        />
                        {errors.researcher_use_case && (
                          <p className="text-sm text-red-500 mt-1">{errors.researcher_use_case.message}</p>
                        )}
                      </div>

                      <div>
                        <div className="flex items-center justify-between mb-2">
                          <Label htmlFor="researcher_future_impact">
                            What impact might more granular research sharing and attribution have for you or your collaborations in the future? *
                          </Label>
                          <span className="text-xs text-gray-500">
                            {wordCounts.researcher_future_impact || 0}/200 words
                          </span>
                        </div>
                        <textarea
                          id="researcher_future_impact"
                          {...register('researcher_future_impact', {
                            onChange: (e) => updateWordCount('researcher_future_impact', e.target.value)
                          })}
                          className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                            errors.researcher_future_impact ? 'border-red-500' : 'border-gray-300'
                          }`}
                          placeholder="Describe the potential future impact..."
                        />
                        {errors.researcher_future_impact && (
                          <p className="text-sm text-red-500 mt-1">{errors.researcher_future_impact.message}</p>
                        )}
                      </div>
                    </div>
                  )}

                  {selectedClassifications.includes('designer') && (
                    <div className="space-y-6">
                      <div className="bg-pink-50 border border-pink-200 rounded-lg p-4">
                        <h3 className="font-semibold text-pink-900 mb-1">Questions for Designers</h3>
                        <p className="text-sm text-pink-700">Because you selected Designer</p>
                      </div>

                      <div>
                        <div className="flex items-center justify-between mb-2">
                          <Label htmlFor="designer_ux_considerations">
                            What are the most important considerations when doing UX/design for researchers and pulling/publishing data across multiple platforms with differing schemas? *
                          </Label>
                          <span className="text-xs text-gray-500">
                            {wordCounts.designer_ux_considerations || 0}/200 words
                          </span>
                        </div>
                        <textarea
                          id="designer_ux_considerations"
                          {...register('designer_ux_considerations', {
                            onChange: (e) => updateWordCount('designer_ux_considerations', e.target.value)
                          })}
                          className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                            errors.designer_ux_considerations ? 'border-red-500' : 'border-gray-300'
                          }`}
                          placeholder="Share your design perspectives..."
                        />
                        {errors.designer_ux_considerations && (
                          <p className="text-sm text-red-500 mt-1">{errors.designer_ux_considerations.message}</p>
                        )}
                      </div>
                    </div>
                  )}

                  {selectedClassifications.includes('engineer') && (
                    <div className="space-y-6">
                      <div className="bg-purple-50 border border-purple-200 rounded-lg p-4">
                        <h3 className="font-semibold text-purple-900 mb-1">Questions for Engineers</h3>
                        <p className="text-sm text-purple-700">Because you selected Engineer</p>
                      </div>

                      <div>
                        <div className="flex items-center justify-between mb-2">
                          <Label htmlFor="engineer_working_on">
                            What are you working on that would use an interoperable research attribution schema - How? *
                          </Label>
                          <span className="text-xs text-gray-500">
                            {wordCounts.engineer_working_on || 0}/200 words
                          </span>
                        </div>
                        <textarea
                          id="engineer_working_on"
                          {...register('engineer_working_on', {
                            onChange: (e) => updateWordCount('engineer_working_on', e.target.value)
                          })}
                          className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                            errors.engineer_working_on ? 'border-red-500' : 'border-gray-300'
                          }`}
                          placeholder="Describe your engineering work..."
                        />
                        {errors.engineer_working_on && (
                          <p className="text-sm text-red-500 mt-1">{errors.engineer_working_on.message}</p>
                        )}
                      </div>

                      <div>
                        <div className="flex items-center justify-between mb-2">
                          <Label htmlFor="engineer_schema_considerations">
                            What are the most important considerations when designing and implementing a shared schema or crosswalks across multiple platforms/tools? *
                          </Label>
                          <span className="text-xs text-gray-500">
                            {wordCounts.engineer_schema_considerations || 0}/200 words
                          </span>
                        </div>
                        <textarea
                          id="engineer_schema_considerations"
                          {...register('engineer_schema_considerations', {
                            onChange: (e) => updateWordCount('engineer_schema_considerations', e.target.value)
                          })}
                          className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                            errors.engineer_schema_considerations ? 'border-red-500' : 'border-gray-300'
                          }`}
                          placeholder="Share your technical perspectives..."
                        />
                        {errors.engineer_schema_considerations && (
                          <p className="text-sm text-red-500 mt-1">{errors.engineer_schema_considerations.message}</p>
                        )}
                      </div>
                    </div>
                  )}

                  {selectedClassifications.includes('conceptionalist') && (
                    <div className="space-y-6">
                      <div className="bg-amber-50 border border-amber-200 rounded-lg p-4">
                        <h3 className="font-semibold text-amber-900 mb-1">Questions for Conceptionalists</h3>
                        <p className="text-sm text-amber-700">Because you selected Conceptionalist</p>
                      </div>

                      <div>
                        <div className="flex items-center justify-between mb-2">
                          <Label htmlFor="conceptionalist_unlock">
                            What would an interoperable attribution schema unlock for one of your existing projects? *
                          </Label>
                          <span className="text-xs text-gray-500">
                            {wordCounts.conceptionalist_unlock || 0}/200 words
                          </span>
                        </div>
                        <textarea
                          id="conceptionalist_unlock"
                          {...register('conceptionalist_unlock', {
                            onChange: (e) => updateWordCount('conceptionalist_unlock', e.target.value)
                          })}
                          className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                            errors.conceptionalist_unlock ? 'border-red-500' : 'border-gray-300'
                          }`}
                          placeholder="Describe what would be unlocked..."
                        />
                        {errors.conceptionalist_unlock && (
                          <p className="text-sm text-red-500 mt-1">{errors.conceptionalist_unlock.message}</p>
                        )}
                      </div>

                      <div>
                        <div className="flex items-center justify-between mb-2">
                          <Label htmlFor="conceptionalist_enable">
                            What new projects might an interoperable attribution schema enable, broadly speaking? *
                          </Label>
                          <span className="text-xs text-gray-500">
                            {wordCounts.conceptionalist_enable || 0}/200 words
                          </span>
                        </div>
                        <textarea
                          id="conceptionalist_enable"
                          {...register('conceptionalist_enable', {
                            onChange: (e) => updateWordCount('conceptionalist_enable', e.target.value)
                          })}
                          className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                            errors.conceptionalist_enable ? 'border-red-500' : 'border-gray-300'
                          }`}
                          placeholder="Describe potential new projects..."
                        />
                        {errors.conceptionalist_enable && (
                          <p className="text-sm text-red-500 mt-1">{errors.conceptionalist_enable.message}</p>
                        )}
                      </div>
                    </div>
                  )}
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
                            <li>Date: June 7-11, 2026</li>
                            <li>Duration: 5 days intensive workshop</li>
                            <li>Format: In-person collaboration</li>
                            <li>Location: The Deerstone Eco Hideaway, Ireland</li>
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
                          I confirm my availability for the full 5-day workshop *
                        </Label>
                        <p className="text-sm text-gray-500 mt-1">
                          You must be able to attend all workshop days (June 7-11, 2026)
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
          <Link href="/status" className="text-blue-600 hover:text-blue-500">
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
