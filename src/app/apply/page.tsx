'use client'

import { useState, useRef, useEffect } from 'react'
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
import type { Classification, Inserts } from '@/types/database'
import {
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

// Complete form schema with all possible fields
const applicationSchema = z.object({
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
  work_items: z.array(z.object({
    description: z.string().min(1, 'Description is required'),
    role: z.string().min(1, 'Role is required'),
    url: z.string().url('Invalid URL format').optional().or(z.literal('')),
  })).min(1, 'At least one work example is required').max(5, 'Maximum 5 work examples allowed'),
  workshop_contribution: wordCount(200, 'Maximum 200 words allowed'),
  research_elements: wordCount(200, 'Maximum 200 words allowed'),

  // Role-specific questions (all optional, validated conditionally)
  researcher_use_case: wordCount(200, 'Maximum 200 words allowed').optional(),
  researcher_future_impact: wordCount(200, 'Maximum 200 words allowed').optional(),
  designer_ux_considerations: wordCount(200, 'Maximum 200 words allowed').optional(),
  engineer_working_on: wordCount(200, 'Maximum 200 words allowed').optional(),
  engineer_schema_considerations: wordCount(200, 'Maximum 200 words allowed').optional(),
  landscape_specialist_current_work: wordCount(200, 'Maximum 200 words allowed').optional(),
  landscape_specialist_see_emerging: wordCount(200, 'Maximum 200 words allowed').optional(),

  // Page 3: Logistics
  availability_confirmed: z.boolean().refine(val => val === true, {
    message: 'You must confirm availability'
  }),
  travel_requirements: z.string().optional(),
  dietary_restrictions: z.string().optional(),
}).superRefine((data, ctx) => {
  // Validate classification_other if 'other' is selected
  if (data.classifications.includes('other')) {
    if (!data.classification_other || data.classification_other.trim().length === 0) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'Please specify your classification when selecting "Other"',
        path: ['classification_other'],
      })
    } else if (data.classification_other.length > 15) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'Classification must be 15 characters or less',
        path: ['classification_other'],
      })
    }
  }

  // Validate researcher questions if 'researcher' is selected
  if (data.classifications.includes('researcher')) {
    if (!data.researcher_use_case || data.researcher_use_case.trim().length === 0) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'This question is required for researchers',
        path: ['researcher_use_case'],
      })
    }
    if (!data.researcher_future_impact || data.researcher_future_impact.trim().length === 0) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'This question is required for researchers',
        path: ['researcher_future_impact'],
      })
    }
  }

  // Validate designer questions if 'designer' is selected
  if (data.classifications.includes('designer')) {
    if (!data.designer_ux_considerations || data.designer_ux_considerations.trim().length === 0) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'This question is required for designers',
        path: ['designer_ux_considerations'],
      })
    }
  }

  // Validate engineer questions if 'engineer' is selected
  if (data.classifications.includes('engineer')) {
    if (!data.engineer_working_on || data.engineer_working_on.trim().length === 0) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'This question is required for engineers',
        path: ['engineer_working_on'],
      })
    }
    if (!data.engineer_schema_considerations || data.engineer_schema_considerations.trim().length === 0) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'This question is required for engineers',
        path: ['engineer_schema_considerations'],
      })
    }
  }

  // Validate landscape/ecosystem specialist questions if 'landscape_specialist' is selected
  if (data.classifications.includes('landscape_specialist')) {
    if (!data.landscape_specialist_current_work || data.landscape_specialist_current_work.trim().length === 0) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'This question is required for landscape/ecosystem specialists',
        path: ['landscape_specialist_current_work'],
      })
    }
    if (!data.landscape_specialist_see_emerging || data.landscape_specialist_see_emerging.trim().length === 0) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'This question is required for landscape/ecosystem specialists',
        path: ['landscape_specialist_see_emerging'],
      })
    }
  }
})

type ApplicationFormData = z.infer<typeof applicationSchema>

const classificationOptions: { value: Classification; label: string }[] = [
  { value: 'researcher', label: 'Researcher' },
  { value: 'engineer', label: 'Engineer' },
  { value: 'designer', label: 'Designer' },
  { value: 'landscape_specialist', label: 'Landscape/Ecosystem Specialist' },
  { value: 'other', label: 'Other' },
]

export default function ApplyPage() {
  const router = useRouter()
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [selectedClassifications, setSelectedClassifications] = useState<string[]>([])
  const [wordCounts, setWordCounts] = useState<Record<string, number>>({})
  const classificationsRef = useRef<HTMLDivElement>(null)

  const {
    register,
    handleSubmit,
    formState: { errors },
    watch,
    control,
    setValue,
  } = useForm<ApplicationFormData>({
    resolver: zodResolver(applicationSchema),
    mode: 'onChange',
    defaultValues: {
      classifications: [],
      work_items: [{ description: '', role: '', url: '' }],
      availability_confirmed: false,
    }
  })

  const { fields, append, remove } = useFieldArray({
    control,
    name: 'work_items',
  })

  const watchClassifications = watch('classifications')

  // Scroll to classifications section if there's a validation error
  useEffect(() => {
    if (errors.classifications && classificationsRef.current) {
      classificationsRef.current.scrollIntoView({
        behavior: 'smooth',
        block: 'center'
      })
    }
  }, [errors.classifications])

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

      // Filter out completely empty work items (both description and role are empty)
      const validWorkItems = data.work_items.filter(
        item => item.description.trim() !== '' || item.role.trim() !== ''
      )

      // Submit application
      // TODO: Regenerate Supabase types after running migration 015
      const applicationData = {
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
        work_links: validWorkItems,
        workshop_contribution: data.workshop_contribution,
        research_elements: data.research_elements,

        // Role-specific questions (conditionally included)
        researcher_use_case: data.researcher_use_case || null,
        researcher_future_impact: data.researcher_future_impact || null,
        designer_ux_considerations: data.designer_ux_considerations || null,
        engineer_working_on: data.engineer_working_on || null,
        engineer_schema_considerations: data.engineer_schema_considerations || null,
        landscape_specialist_current_work: data.landscape_specialist_current_work || null,
        landscape_specialist_see_emerging: data.landscape_specialist_see_emerging || null,

        // Logistics stored in admin_notes for now
        admin_notes: [
          `Availability Confirmed: ${data.availability_confirmed ? 'Yes' : 'No'}`,
          `Travel Requirements: ${data.travel_requirements || 'None'}`,
          `Dietary Restrictions: ${data.dietary_restrictions || 'None'}`,
        ],
      } as Inserts<'applications'>

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

        {/* Form Card */}
        <form onSubmit={handleSubmit(onSubmit)}>
          <Card className="shadow-xl">
            <CardHeader>
              <CardTitle>Workshop Application</CardTitle>
              <CardDescription>
                Complete all sections below to apply to the MIRA workshop
              </CardDescription>
            </CardHeader>

            <CardContent className="space-y-8">
              {error && (
                <Alert variant="destructive">
                  <AlertCircle className="h-4 w-4" />
                  <AlertDescription>{error}</AlertDescription>
                </Alert>
              )}

              {/* Section 1: Personal Information & Classifications */}
              <div className="space-y-6">
                <div className="border-l-4 border-blue-600 pl-4">
                  <h2 className="text-2xl font-bold text-gray-900">1. Personal Information & Classification</h2>
                  <p className="text-sm text-gray-600 mt-1">Tell us about yourself and how you classify your work</p>
                </div>
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
                  <div ref={classificationsRef}>
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
              </div>

              <Separator />

              {/* Section 2: Application Questions */}
              <div className="space-y-6">
                <div className="border-l-4 border-purple-600 pl-4">
                  <h2 className="text-2xl font-bold text-gray-900">2. Application Questions</h2>
                  <p className="text-sm text-gray-600 mt-1">Share your perspectives and motivations</p>
                </div>
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

                    {/* Question 3: Share Your Past/Current Work */}
                    <div>
                      <Label>Share your past/current work *</Label>
                      <p className="text-sm text-gray-500 mb-3">Add 1-5 examples of your work with a description and your role (link optional)</p>
                      <div className="space-y-4">
                        {fields.map((field, index) => (
                          <div key={field.id} className="border rounded-lg p-4 bg-gray-50">
                            <div className="flex gap-2 items-start mb-3">
                              <div className="flex-1">
                                <Label className="text-xs text-gray-600">Work Example #{index + 1}</Label>
                              </div>
                              {fields.length > 1 && (
                                <Button
                                  type="button"
                                  variant="outline"
                                  size="icon"
                                  onClick={() => remove(index)}
                                  className="h-8 w-8"
                                >
                                  <Trash2 className="h-4 w-4" />
                                </Button>
                              )}
                            </div>
                            <div className="space-y-3">
                              <div>
                                <Label htmlFor={`work_items.${index}.description`} className="text-sm">
                                  Description *
                                </Label>
                                <textarea
                                  id={`work_items.${index}.description`}
                                  {...register(`work_items.${index}.description` as const)}
                                  placeholder="Describe the project, research, or work you contributed to..."
                                  className={`w-full min-h-[80px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                                    errors.work_items?.[index]?.description ? 'border-red-500' : 'border-gray-300'
                                  }`}
                                />
                                {errors.work_items?.[index]?.description && (
                                  <p className="text-sm text-red-500 mt-1">{errors.work_items[index]?.description?.message}</p>
                                )}
                              </div>
                              <div>
                                <Label htmlFor={`work_items.${index}.role`} className="text-sm">
                                  Your Role *
                                </Label>
                                <Input
                                  id={`work_items.${index}.role`}
                                  {...register(`work_items.${index}.role` as const)}
                                  placeholder="e.g., Lead Developer, PI, Designer, Research Assistant"
                                  className={errors.work_items?.[index]?.role ? 'border-red-500' : ''}
                                />
                                {errors.work_items?.[index]?.role && (
                                  <p className="text-sm text-red-500 mt-1">{errors.work_items[index]?.role?.message}</p>
                                )}
                              </div>
                              <div>
                                <Label htmlFor={`work_items.${index}.url`} className="text-sm">
                                  Link (Optional)
                                </Label>
                                <Input
                                  id={`work_items.${index}.url`}
                                  {...register(`work_items.${index}.url` as const)}
                                  placeholder="https://example.com/your-project (if publicly available)"
                                  className={errors.work_items?.[index]?.url ? 'border-red-500' : ''}
                                />
                                {errors.work_items?.[index]?.url && (
                                  <p className="text-sm text-red-500 mt-1">{errors.work_items[index]?.url?.message}</p>
                                )}
                              </div>
                            </div>
                          </div>
                        ))}
                        {fields.length < 5 && (
                          <Button
                            type="button"
                            variant="outline"
                            size="sm"
                            onClick={() => append({ description: '', role: '', url: '' })}
                            className="w-full"
                          >
                            <Plus className="h-4 w-4 mr-2" />
                            Add another work example
                          </Button>
                        )}
                      </div>
                      {errors.work_items && (
                        <p className="text-sm text-red-500 mt-1">
                          {typeof errors.work_items.message === 'string'
                            ? errors.work_items.message
                            : 'Please provide valid work examples'}
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

                  {selectedClassifications.includes('landscape_specialist') && (
                    <div className="space-y-6">
                      <div className="bg-amber-50 border border-amber-200 rounded-lg p-4">
                        <h3 className="font-semibold text-amber-900 mb-1">Questions for Landscape/Ecosystem Specialists</h3>
                        <p className="text-sm text-amber-700">Because you selected Landscape/Ecosystem Specialist</p>
                      </div>

                      <div>
                        <div className="flex items-center justify-between mb-2">
                          <Label htmlFor="landscape_specialist_current_work">
                            What would an interoperable attribution schema unlock for one of your existing projects? *
                          </Label>
                          <span className="text-xs text-gray-500">
                            {wordCounts.landscape_specialist_current_work || 0}/200 words
                          </span>
                        </div>
                        <textarea
                          id="landscape_specialist_current_work"
                          {...register('landscape_specialist_current_work', {
                            onChange: (e) => updateWordCount('landscape_specialist_current_work', e.target.value)
                          })}
                          className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                            errors.landscape_specialist_current_work ? 'border-red-500' : 'border-gray-300'
                          }`}
                          placeholder="Describe what would be unlocked..."
                        />
                        {errors.landscape_specialist_current_work && (
                          <p className="text-sm text-red-500 mt-1">{errors.landscape_specialist_current_work.message}</p>
                        )}
                      </div>

                      <div>
                        <div className="flex items-center justify-between mb-2">
                          <Label htmlFor="landscape_specialist_see_emerging">
                            What new projects might an interoperable attribution schema enable, broadly speaking? *
                          </Label>
                          <span className="text-xs text-gray-500">
                            {wordCounts.landscape_specialist_see_emerging || 0}/200 words
                          </span>
                        </div>
                        <textarea
                          id="landscape_specialist_see_emerging"
                          {...register('landscape_specialist_see_emerging', {
                            onChange: (e) => updateWordCount('landscape_specialist_see_emerging', e.target.value)
                          })}
                          className={`w-full min-h-[120px] px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                            errors.landscape_specialist_see_emerging ? 'border-red-500' : 'border-gray-300'
                          }`}
                          placeholder="Describe potential new projects..."
                        />
                        {errors.landscape_specialist_see_emerging && (
                          <p className="text-sm text-red-500 mt-1">{errors.landscape_specialist_see_emerging.message}</p>
                        )}
                      </div>
                    </div>
                  )}
                </div>
              </div>

              <Separator />

              {/* Section 3: Logistics */}
              <div className="space-y-6">
                <div className="border-l-4 border-green-600 pl-4">
                  <h2 className="text-2xl font-bold text-gray-900">3. Logistics & Confirmation</h2>
                  <p className="text-sm text-gray-600 mt-1">Confirm availability and provide logistics information</p>
                </div>
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
                      <li>• <strong>Application deadline:</strong> January 1, 2026</li>
                      <li>• You&apos;ll receive a confirmation email after submission</li>
                      <li>• <strong>Decisions announced:</strong> January 15, 2026</li>
                      <li>• You can check your status anytime using your email</li>
                    </ul>
                  </div>
                </div>
              </div>
            </CardContent>

            <CardFooter className="flex justify-end">
              <Button type="submit" disabled={isSubmitting} size="lg">
                {isSubmitting ? (
                  <>
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                    Submitting Application...
                  </>
                ) : (
                  'Submit Application'
                )}
              </Button>
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
