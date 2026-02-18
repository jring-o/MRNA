'use client'

import { useState, useEffect, useCallback } from 'react'
import { createClient } from '@/lib/supabase/client'
import { useForm, useFieldArray } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import * as z from 'zod'
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
  SheetDescription,
} from '@/components/ui/sheet'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Separator } from '@/components/ui/separator'
import { Textarea } from '@/components/ui/textarea'
import {
  Pencil,
  Loader2,
  Plus,
  X,
  MapPin,
  BookOpen,
  Lightbulb,
  Sparkles,
  Heart,
  PawPrint,
  Users,
  FileText,
  ExternalLink,
} from 'lucide-react'
import { toast } from 'sonner'
import type { ParticipantProfile } from '@/types/database'
import {
  parseReadingList,
  parseInspirations,
  parseUnsungRoles,
  parseCoolProjects,
} from '@/types/database'

// ─── Types ───────────────────────────────────────────────

interface ParticipantUser {
  id: string
  name: string | null
  organization: string | null
}

interface ParticipantProfileSheetProps {
  participant: ParticipantUser | null
  open: boolean
  onOpenChange: (open: boolean) => void
  currentUserId: string
  onProfileUpdated?: () => void
}

// ─── Schema ──────────────────────────────────────────────

const profileSchema = z.object({
  name: z.string().min(1, 'Name is required'),
  organization: z.string().optional(),
  description: z.string().optional(),
  location: z.string().optional(),
  schema_motivation: z.string().optional(),
  reading_list: z.array(z.object({
    title: z.string(),
    author: z.string(),
  })),
  who_inspires_you: z.array(z.object({
    name: z.string(),
    reason: z.string(),
  })),
  best_sidequests: z.string().optional(),
  revolutionary_animal: z.string().optional(),
  undersung_roles: z.array(z.object({
    value: z.string(),
  })),
  cool_projects: z.array(z.object({
    url: z.string(),
    description: z.string(),
  })),
})

type ProfileFormData = z.infer<typeof profileSchema>

// ─── ProfileField (read-only) ────────────────────────────

function ProfileField({
  icon: Icon,
  label,
  children,
  isOwn,
}: {
  icon: React.ComponentType<{ className?: string }>
  label: string
  children: React.ReactNode
  isOwn: boolean
}) {
  // If empty and not own profile, hide entirely
  if (!children && !isOwn) return null

  return (
    <div className="space-y-1">
      <div className="flex items-center gap-2 text-sm font-medium text-gray-500">
        <Icon className="h-4 w-4" />
        {label}
      </div>
      {children ? (
        <div className="text-sm text-gray-900 pl-6 whitespace-pre-line">{children}</div>
      ) : (
        <p className="text-sm text-gray-400 italic pl-6">Not yet filled in</p>
      )}
    </div>
  )
}

// ─── Component ───────────────────────────────────────────

export function ParticipantProfileSheet({
  participant,
  open,
  onOpenChange,
  currentUserId,
  onProfileUpdated,
}: ParticipantProfileSheetProps) {
  const supabase = createClient()
  const [isEditing, setIsEditing] = useState(false)
  const [saving, setSaving] = useState(false)
  const [profileLoading, setProfileLoading] = useState(false)
  const [profile, setProfile] = useState<ParticipantProfile | null>(null)

  const isOwnProfile = participant?.id === currentUserId

  // ─── Form setup ─────────────────────────────────────────

  const form = useForm<ProfileFormData>({
    resolver: zodResolver(profileSchema),
    defaultValues: {
      name: '',
      organization: '',
      description: '',
      location: '',
      schema_motivation: '',
      reading_list: [],
      who_inspires_you: [],
      best_sidequests: '',
      revolutionary_animal: '',
      undersung_roles: [],
      cool_projects: [],
    },
  })

  const readingListArray = useFieldArray({ control: form.control, name: 'reading_list' })
  const inspiresArray = useFieldArray({ control: form.control, name: 'who_inspires_you' })
  const rolesArray = useFieldArray({ control: form.control, name: 'undersung_roles' })
  const projectsArray = useFieldArray({ control: form.control, name: 'cool_projects' })

  // ─── Fetch profile data ─────────────────────────────────

  const fetchProfile = useCallback(async (userId: string) => {
    setProfileLoading(true)
    try {
      const { data, error } = await supabase
        .from('participant_profiles')
        .select('*')
        .eq('user_id', userId)
        .maybeSingle()

      if (error) throw error
      setProfile(data)
    } catch (error) {
      console.error('Error fetching profile:', error)
    } finally {
      setProfileLoading(false)
    }
  }, [supabase])

  useEffect(() => {
    if (open && participant) {
      fetchProfile(participant.id)
    }
    if (!open) {
      setIsEditing(false)
      setProfile(null)
    }
  }, [open, participant, fetchProfile])

  // ─── Edit mode ──────────────────────────────────────────

  const handleEdit = () => {
    if (!participant) return
    const readingList = profile ? parseReadingList(profile.reading_list) : []
    const inspirations = profile ? parseInspirations(profile.who_inspires_you) : []
    const unsungRoles = profile ? parseUnsungRoles(profile.undersung_roles) : []
    const coolProjects = profile ? parseCoolProjects(profile.cool_projects) : []

    form.reset({
      name: participant.name || '',
      organization: participant.organization || '',
      description: profile?.description || '',
      location: profile?.location || '',
      schema_motivation: profile?.schema_motivation || '',
      reading_list: readingList.length > 0 ? readingList : [],
      who_inspires_you: inspirations.length > 0 ? inspirations : [],
      best_sidequests: profile?.best_sidequests || '',
      revolutionary_animal: profile?.revolutionary_animal || '',
      undersung_roles: unsungRoles.length > 0
        ? unsungRoles.map(r => ({ value: r }))
        : [],
      cool_projects: coolProjects.length > 0 ? coolProjects : [],
    })
    setIsEditing(true)
  }

  const handleCancelEdit = () => {
    setIsEditing(false)
  }

  // ─── Save ───────────────────────────────────────────────

  const onSubmit = async (data: ProfileFormData) => {
    if (!participant) return
    setSaving(true)

    try {
      // 1. Update users table (name + organization)
      const { error: userError } = await supabase
        .from('users')
        .update({
          name: data.name.trim(),
          organization: data.organization?.trim() || null,
        })
        .eq('id', currentUserId)

      if (userError) throw userError

      // 2. Upsert participant_profiles
      const profileFields = {
        user_id: currentUserId,
        description: data.description?.trim() || null,
        location: data.location?.trim() || null,
        schema_motivation: data.schema_motivation?.trim() || null,
        reading_list: data.reading_list.filter(r => r.title.trim() || r.author.trim()),
        who_inspires_you: data.who_inspires_you.filter(w => w.name.trim() || w.reason.trim()),
        best_sidequests: data.best_sidequests?.trim() || null,
        revolutionary_animal: data.revolutionary_animal?.trim() || null,
        undersung_roles: data.undersung_roles
          .map(r => r.value.trim())
          .filter(Boolean),
        cool_projects: data.cool_projects.filter(p => p.url.trim() || p.description.trim()),
      }

      const { error: profileError } = await supabase
        .from('participant_profiles')
        .upsert(profileFields, { onConflict: 'user_id' })

      if (profileError) throw profileError

      toast.success('Profile updated')
      setIsEditing(false)
      await fetchProfile(currentUserId)
      onProfileUpdated?.()
    } catch (error) {
      console.error('Error updating profile:', error)
      toast.error('Failed to update profile')
    } finally {
      setSaving(false)
    }
  }

  // ─── Open/close handling ────────────────────────────────

  const handleOpenChange = (isOpen: boolean) => {
    if (!isOpen) {
      setIsEditing(false)
    }
    onOpenChange(isOpen)
  }

  if (!participant) return null

  const initials = participant.name
    ? participant.name.split(' ').map(n => n[0]).join('').toUpperCase()
    : 'P'

  // Parsed profile data for read-only view
  const readingList = profile ? parseReadingList(profile.reading_list) : []
  const inspirations = profile ? parseInspirations(profile.who_inspires_you) : []
  const unsungRoles = profile ? parseUnsungRoles(profile.undersung_roles) : []
  const coolProjects = profile ? parseCoolProjects(profile.cool_projects) : []

  // ─── Render ─────────────────────────────────────────────

  return (
    <Sheet open={open} onOpenChange={handleOpenChange}>
      <SheetContent side="right" className="sm:max-w-lg flex flex-col">
        <SheetHeader className="flex-shrink-0">
          <div className="flex items-start gap-4">
            <Avatar className="h-16 w-16">
              <AvatarFallback className="bg-gradient-to-br from-blue-600 to-cyan-600 text-white text-xl">
                {initials}
              </AvatarFallback>
            </Avatar>
            <div className="flex-1 min-w-0 pt-1">
              <SheetTitle className="text-xl">
                {participant.name || 'Participant'}
              </SheetTitle>
              <SheetDescription className="mt-1">
                {participant.organization || '\u00A0'}
              </SheetDescription>
              {isOwnProfile && !isEditing && (
                <Button variant="outline" size="sm" className="mt-2" onClick={handleEdit}>
                  <Pencil className="h-3 w-3 mr-1.5" />
                  Edit Profile
                </Button>
              )}
            </div>
          </div>
        </SheetHeader>

        <div className="flex-1 overflow-y-auto mt-6">
          {isEditing ? (
            /* ──── Edit Mode ──── */
            <form
              id="profile-form"
              onSubmit={form.handleSubmit(onSubmit)}
              className="space-y-6 pb-24"
            >
              {/* Name + Organization */}
              <div className="space-y-4">
                <div>
                  <Label htmlFor="edit-name">Name *</Label>
                  <Input
                    id="edit-name"
                    {...form.register('name')}
                    className="mt-1"
                  />
                  {form.formState.errors.name && (
                    <p className="text-sm text-red-500 mt-1">{form.formState.errors.name.message}</p>
                  )}
                </div>
                <div>
                  <Label htmlFor="edit-org">Organization</Label>
                  <Input
                    id="edit-org"
                    {...form.register('organization')}
                    placeholder="Your organization"
                    className="mt-1"
                  />
                </div>
              </div>

              <Separator />

              {/* Description */}
              <div>
                <Label htmlFor="edit-description">A short bio...</Label>
                <Textarea
                  id="edit-description"
                  {...form.register('description')}
                  placeholder="Tell everyone a bit about yourself"
                  className="mt-1"
                  rows={3}
                />
              </div>

              {/* Location */}
              <div>
                <Label htmlFor="edit-location">Where are you based?</Label>
                <Input
                  id="edit-location"
                  {...form.register('location')}
                  placeholder="e.g. London, UK"
                  className="mt-1"
                />
              </div>

              {/* Cool Projects */}
              <div className="space-y-3">
                <Label>Projects you should check out</Label>
                <p className="text-xs text-gray-500">Share links to projects worth exploring</p>
                {projectsArray.fields.map((field, index) => (
                  <div key={field.id} className="flex gap-2 items-start">
                    <div className="flex-1 space-y-2">
                      <Input
                        {...form.register(`cool_projects.${index}.url`)}
                        placeholder="https://..."
                      />
                      <Input
                        {...form.register(`cool_projects.${index}.description`)}
                        placeholder="Brief description"
                      />
                    </div>
                    <Button
                      type="button"
                      variant="ghost"
                      size="icon"
                      className="h-8 w-8 flex-shrink-0 mt-1"
                      onClick={() => projectsArray.remove(index)}
                    >
                      <X className="h-4 w-4" />
                    </Button>
                  </div>
                ))}
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  onClick={() => projectsArray.append({ url: '', description: '' })}
                >
                  <Plus className="h-4 w-4 mr-1" />
                  Add project
                </Button>
              </div>

              {/* Inspiring Moment */}
              <div>
                <Label htmlFor="edit-schema-motivation">Why in the world are you thinking about schemas all day?</Label>
                <Textarea
                  id="edit-schema-motivation"
                  {...form.register('schema_motivation')}
                  placeholder="What keeps you coming back to schemas..."
                  className="mt-1"
                  rows={3}
                />
              </div>

              {/* Reading List */}
              <div className="space-y-3">
                <Label>Reading list</Label>
                <p className="text-xs text-gray-500">Books, papers, or articles you&apos;d recommend</p>
                {readingListArray.fields.map((field, index) => (
                  <div key={field.id} className="flex gap-2 items-start">
                    <div className="flex-1 space-y-2">
                      <Input
                        {...form.register(`reading_list.${index}.title`)}
                        placeholder="Title"
                      />
                      <Input
                        {...form.register(`reading_list.${index}.author`)}
                        placeholder="Author"
                      />
                    </div>
                    <Button
                      type="button"
                      variant="ghost"
                      size="icon"
                      className="h-8 w-8 flex-shrink-0 mt-1"
                      onClick={() => readingListArray.remove(index)}
                    >
                      <X className="h-4 w-4" />
                    </Button>
                  </div>
                ))}
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  onClick={() => readingListArray.append({ title: '', author: '' })}
                >
                  <Plus className="h-4 w-4 mr-1" />
                  Add item
                </Button>
              </div>

              {/* Who Inspires You */}
              <div className="space-y-3">
                <Label>Who inspires you?</Label>
                <p className="text-xs text-gray-500">People who have shaped your thinking</p>
                {inspiresArray.fields.map((field, index) => (
                  <div key={field.id} className="flex gap-2 items-start">
                    <div className="flex-1 space-y-2">
                      <Input
                        {...form.register(`who_inspires_you.${index}.name`)}
                        placeholder="Name"
                      />
                      <Input
                        {...form.register(`who_inspires_you.${index}.reason`)}
                        placeholder="Why they inspire you"
                      />
                    </div>
                    <Button
                      type="button"
                      variant="ghost"
                      size="icon"
                      className="h-8 w-8 flex-shrink-0 mt-1"
                      onClick={() => inspiresArray.remove(index)}
                    >
                      <X className="h-4 w-4" />
                    </Button>
                  </div>
                ))}
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  onClick={() => inspiresArray.append({ name: '', reason: '' })}
                >
                  <Plus className="h-4 w-4 mr-1" />
                  Add person
                </Button>
              </div>

              {/* Best Sidequests */}
              <div>
                <Label htmlFor="edit-sidequests">What are the best sidequests you&apos;ve gone on?</Label>
                <Textarea
                  id="edit-sidequests"
                  {...form.register('best_sidequests')}
                  placeholder="Adventures, detours, happy accidents..."
                  className="mt-1"
                  rows={3}
                />
              </div>

              {/* Favorite Animal */}
              <div>
                <Label htmlFor="edit-animal">Which animal is most likely to revolutionize science?</Label>
                <Input
                  id="edit-animal"
                  {...form.register('revolutionary_animal')}
                  placeholder="e.g. Octopus"
                  className="mt-1"
                />
              </div>

              {/* Undersung Roles */}
              <div className="space-y-3">
                <Label>Undersung roles in research</Label>
                <p className="text-xs text-gray-500">Roles that deserve more recognition</p>
                {rolesArray.fields.map((field, index) => (
                  <div key={field.id} className="flex gap-2 items-center">
                    <Input
                      {...form.register(`undersung_roles.${index}.value`)}
                      placeholder="e.g. Data curator"
                      className="flex-1"
                    />
                    <Button
                      type="button"
                      variant="ghost"
                      size="icon"
                      className="h-8 w-8 flex-shrink-0"
                      onClick={() => rolesArray.remove(index)}
                    >
                      <X className="h-4 w-4" />
                    </Button>
                  </div>
                ))}
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  onClick={() => rolesArray.append({ value: '' })}
                >
                  <Plus className="h-4 w-4 mr-1" />
                  Add role
                </Button>
              </div>

            </form>
          ) : profileLoading ? (
            <div className="flex items-center justify-center py-12">
              <Loader2 className="h-6 w-6 animate-spin text-gray-400" />
            </div>
          ) : (
            /* ──── Read-only View ──── */
            <div className="space-y-5">
              <ProfileField icon={FileText} label="Bio" isOwn={isOwnProfile}>
                {profile?.description || null}
              </ProfileField>

              <ProfileField icon={MapPin} label="Location" isOwn={isOwnProfile}>
                {profile?.location || null}
              </ProfileField>

              <ProfileField icon={ExternalLink} label="Projects you should check out" isOwn={isOwnProfile}>
                {coolProjects.length > 0 ? (
                  <ul className="space-y-2">
                    {coolProjects.map((project, i) => (
                      <li key={i}>
                        <a
                          href={project.url}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-blue-600 hover:underline break-all"
                        >
                          {project.url}
                        </a>
                        {project.description && (
                          <p className="text-gray-600 text-xs mt-0.5">{project.description}</p>
                        )}
                      </li>
                    ))}
                  </ul>
                ) : null}
              </ProfileField>

              <ProfileField icon={Sparkles} label="Why in the world are you thinking about schemas all day?" isOwn={isOwnProfile}>
                {profile?.schema_motivation || null}
              </ProfileField>

              <ProfileField icon={BookOpen} label="Reading list" isOwn={isOwnProfile}>
                {readingList.length > 0 ? (
                  <ul className="space-y-1">
                    {readingList.map((item, i) => (
                      <li key={i}>
                        <em>{item.title}</em>{item.author ? ` by ${item.author}` : ''}
                      </li>
                    ))}
                  </ul>
                ) : null}
              </ProfileField>

              <ProfileField icon={Heart} label="Who inspires you" isOwn={isOwnProfile}>
                {inspirations.length > 0 ? (
                  <ul className="space-y-2">
                    {inspirations.map((item, i) => (
                      <li key={i}>
                        <span className="font-medium">{item.name}</span>
                        {item.reason && (
                          <span className="text-gray-600"> &mdash; {item.reason}</span>
                        )}
                      </li>
                    ))}
                  </ul>
                ) : null}
              </ProfileField>

              <ProfileField icon={Lightbulb} label="Best sidequests" isOwn={isOwnProfile}>
                {profile?.best_sidequests || null}
              </ProfileField>

              <ProfileField icon={PawPrint} label="Which animal is most likely to revolutionize science?" isOwn={isOwnProfile}>
                {profile?.revolutionary_animal || null}
              </ProfileField>

              <ProfileField icon={Users} label="Undersung roles in research" isOwn={isOwnProfile}>
                {unsungRoles.length > 0 ? (
                  <div className="flex flex-wrap gap-2">
                    {unsungRoles.map((role, i) => (
                      <span
                        key={i}
                        className="inline-block bg-gray-100 text-gray-700 text-xs px-2 py-1 rounded-full"
                      >
                        {role}
                      </span>
                    ))}
                  </div>
                ) : null}
              </ProfileField>

            </div>
          )}
        </div>

        {/* Sticky save/cancel bar */}
        {isEditing && (
          <div className="flex-shrink-0 border-t bg-white pt-4 pb-2 flex gap-2">
            <Button
              type="submit"
              form="profile-form"
              disabled={saving}
              className="flex-1"
            >
              {saving ? <Loader2 className="h-4 w-4 animate-spin mr-2" /> : null}
              Save
            </Button>
            <Button
              type="button"
              variant="ghost"
              onClick={handleCancelEdit}
              disabled={saving}
            >
              Cancel
            </Button>
          </div>
        )}
      </SheetContent>
    </Sheet>
  )
}
