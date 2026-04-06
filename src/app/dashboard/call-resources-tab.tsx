'use client'

import { useState, useEffect, useCallback, useRef } from 'react'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { toast } from 'sonner'
import {
  Video,
  FileText,
  Mic,
  Presentation,
  File,
  Download,
  Trash2,
  Plus,
  Loader2,
  Upload,
  Calendar,
  User,
} from 'lucide-react'

interface CallResource {
  id: string
  title: string
  description: string | null
  call_date: string | null
  file_url: string | null
  file_name: string | null
  file_size: number | null
  file_type: string | null
  resource_type: string
  uploaded_by: string | null
  created_at: string
  uploaded_by_user: { name: string | null } | null
}

const RESOURCE_TYPE_CONFIG: Record<string, { label: string; icon: typeof FileText; color: string }> = {
  recording: { label: 'Recording', icon: Video, color: 'text-red-600 bg-red-50' },
  notes: { label: 'Notes', icon: FileText, color: 'text-blue-600 bg-blue-50' },
  agenda: { label: 'Agenda', icon: File, color: 'text-green-600 bg-green-50' },
  slides: { label: 'Slides', icon: Presentation, color: 'text-purple-600 bg-purple-50' },
  other: { label: 'Other', icon: File, color: 'text-gray-600 bg-gray-50' },
}

function formatFileSize(bytes: number): string {
  if (bytes < 1024) return `${bytes} B`
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`
  if (bytes < 1024 * 1024 * 1024) return `${(bytes / (1024 * 1024)).toFixed(1)} MB`
  return `${(bytes / (1024 * 1024 * 1024)).toFixed(1)} GB`
}

export function CallResourcesTab({ isAdmin }: { isAdmin: boolean }) {
  const [resources, setResources] = useState<CallResource[]>([])
  const [loading, setLoading] = useState(true)
  const [showUploadForm, setShowUploadForm] = useState(false)
  const [uploading, setUploading] = useState(false)
  const [deleting, setDeleting] = useState<string | null>(null)
  const fileInputRef = useRef<HTMLInputElement>(null)

  const [form, setForm] = useState({
    title: '',
    description: '',
    call_date: '',
    resource_type: 'recording',
  })
  const [selectedFile, setSelectedFile] = useState<File | null>(null)

  const loadResources = useCallback(async () => {
    try {
      const response = await fetch('/api/call-resources')
      if (response.ok) {
        const { data } = await response.json()
        setResources(data || [])
      }
    } catch (error) {
      console.error('Error loading call resources:', error)
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    loadResources()
  }, [loadResources])

  const handleUpload = async () => {
    if (!form.title.trim()) {
      toast.error('Please enter a title')
      return
    }

    setUploading(true)
    try {
      let fileData = null

      // Upload file directly to Supabase Storage via signed URL
      if (selectedFile) {
        // 1. Get a signed upload URL from our API
        const uploadRes = await fetch('/api/call-resources/upload', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            fileName: selectedFile.name,
            contentType: selectedFile.type,
          }),
        })

        if (!uploadRes.ok) {
          const err = await uploadRes.json()
          throw new Error(err.error || 'Failed to prepare upload')
        }

        const { data: uploadData } = await uploadRes.json()

        // 2. Upload the file directly to Supabase Storage
        const storageRes = await fetch(uploadData.signedUrl, {
          method: 'PUT',
          headers: { 'Content-Type': selectedFile.type },
          body: selectedFile,
        })

        if (!storageRes.ok) {
          throw new Error('Failed to upload file')
        }

        fileData = {
          path: uploadData.path,
          file_name: selectedFile.name,
          file_size: selectedFile.size,
          file_type: selectedFile.type,
        }
      }

      // Create the resource record
      const res = await fetch('/api/call-resources', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          title: form.title,
          description: form.description || null,
          call_date: form.call_date || null,
          resource_type: form.resource_type,
          file_url: fileData?.path || null,
          file_name: fileData?.file_name || null,
          file_size: fileData?.file_size || null,
          file_type: fileData?.file_type || null,
        }),
      })

      if (!res.ok) {
        throw new Error('Failed to create resource')
      }

      toast.success('Resource added successfully')
      setForm({ title: '', description: '', call_date: '', resource_type: 'recording' })
      setSelectedFile(null)
      if (fileInputRef.current) fileInputRef.current.value = ''
      setShowUploadForm(false)
      loadResources()
    } catch (error) {
      console.error('Upload error:', error)
      toast.error(error instanceof Error ? error.message : 'Failed to upload resource')
    } finally {
      setUploading(false)
    }
  }

  const handleDownload = async (resource: CallResource) => {
    if (!resource.file_url) return

    // If it's an external URL, open directly
    if (resource.file_url.startsWith('http')) {
      window.open(resource.file_url, '_blank')
      return
    }

    // Get a signed URL for storage files
    try {
      const res = await fetch(`/api/call-resources/download?path=${encodeURIComponent(resource.file_url)}`)
      if (!res.ok) throw new Error('Failed to get download link')
      const { url } = await res.json()
      window.open(url, '_blank')
    } catch (error) {
      console.error('Download error:', error)
      toast.error('Failed to download file')
    }
  }

  const handleDelete = async (id: string) => {
    if (!confirm('Are you sure you want to delete this resource?')) return

    setDeleting(id)
    try {
      const res = await fetch('/api/call-resources', {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id }),
      })

      if (!res.ok) throw new Error('Failed to delete')
      toast.success('Resource deleted')
      loadResources()
    } catch (error) {
      console.error('Delete error:', error)
      toast.error('Failed to delete resource')
    } finally {
      setDeleting(null)
    }
  }

  // Group resources by call date
  const grouped = resources.reduce<Record<string, CallResource[]>>((acc, r) => {
    const key = r.call_date || 'undated'
    if (!acc[key]) acc[key] = []
    acc[key].push(r)
    return acc
  }, {})

  const sortedDates = Object.keys(grouped).sort((a, b) => {
    if (a === 'undated') return 1
    if (b === 'undated') return -1
    return b.localeCompare(a)
  })

  return (
    <div className="space-y-4">
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle className="flex items-center">
                <Mic className="mr-2 h-5 w-5" />
                Call Recordings &amp; Notes
              </CardTitle>
              <CardDescription>
                Recordings, notes, and materials from our calls
              </CardDescription>
            </div>
            {isAdmin && (
              <Button
                onClick={() => setShowUploadForm(!showUploadForm)}
                variant={showUploadForm ? 'outline' : 'default'}
                size="sm"
              >
                <Plus className="mr-2 h-4 w-4" />
                {showUploadForm ? 'Cancel' : 'Add Resource'}
              </Button>
            )}
          </div>
        </CardHeader>
        <CardContent>
          {/* Admin Upload Form */}
          {isAdmin && showUploadForm && (
            <div className="mb-6 p-4 rounded-lg border-2 border-dashed border-blue-200 bg-blue-50/50 space-y-4">
              <h4 className="font-medium text-sm">Add a new resource</h4>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="resource-title">Title *</Label>
                  <Input
                    id="resource-title"
                    placeholder="e.g., Kick-off Call Recording"
                    value={form.title}
                    onChange={(e) => setForm(prev => ({ ...prev, title: e.target.value }))}
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="resource-date">Call Date</Label>
                  <Input
                    id="resource-date"
                    type="date"
                    value={form.call_date}
                    onChange={(e) => setForm(prev => ({ ...prev, call_date: e.target.value }))}
                  />
                </div>
              </div>

              <div className="space-y-2">
                <Label htmlFor="resource-type">Type</Label>
                <Select
                  value={form.resource_type}
                  onValueChange={(value) => setForm(prev => ({ ...prev, resource_type: value }))}
                >
                  <SelectTrigger id="resource-type">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="recording">Recording</SelectItem>
                    <SelectItem value="notes">Notes</SelectItem>
                    <SelectItem value="agenda">Agenda</SelectItem>
                    <SelectItem value="slides">Slides</SelectItem>
                    <SelectItem value="other">Other</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <Label htmlFor="resource-description">Description</Label>
                <Textarea
                  id="resource-description"
                  placeholder="Brief description of this resource..."
                  value={form.description}
                  onChange={(e) => setForm(prev => ({ ...prev, description: e.target.value }))}
                  rows={2}
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="resource-file">File</Label>
                <Input
                  id="resource-file"
                  ref={fileInputRef}
                  type="file"
                  onChange={(e) => setSelectedFile(e.target.files?.[0] || null)}
                  accept="audio/*,video/*,.pdf,.doc,.docx,.pptx,.ppt,.txt,.md,image/*"
                />
                {selectedFile && (
                  <p className="text-xs text-gray-500">
                    {selectedFile.name} ({formatFileSize(selectedFile.size)})
                  </p>
                )}
              </div>

              <div className="flex justify-end">
                <Button onClick={handleUpload} disabled={uploading}>
                  {uploading ? (
                    <>
                      <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                      Uploading...
                    </>
                  ) : (
                    <>
                      <Upload className="mr-2 h-4 w-4" />
                      Add Resource
                    </>
                  )}
                </Button>
              </div>
            </div>
          )}

          {/* Resources List */}
          {loading ? (
            <div className="text-center py-8 text-gray-500">Loading resources...</div>
          ) : resources.length === 0 ? (
            <div className="text-center py-12">
              <Mic className="h-12 w-12 text-gray-300 mx-auto mb-3" />
              <h3 className="text-lg font-medium text-gray-900 mb-1">No resources yet</h3>
              <p className="text-sm text-gray-500">
                Recordings and notes from calls will appear here
              </p>
            </div>
          ) : (
            <div className="space-y-6">
              {sortedDates.map((date) => (
                <div key={date}>
                  <h4 className="text-sm font-medium text-gray-500 mb-3 flex items-center gap-2">
                    <Calendar className="h-4 w-4" />
                    {date === 'undated'
                      ? 'General Resources'
                      : new Date(date + 'T00:00:00').toLocaleDateString('en-US', {
                          weekday: 'long',
                          month: 'long',
                          day: 'numeric',
                          year: 'numeric',
                        })}
                  </h4>
                  <div className="space-y-2">
                    {grouped[date].map((resource) => {
                      const config = RESOURCE_TYPE_CONFIG[resource.resource_type] || RESOURCE_TYPE_CONFIG.other
                      const Icon = config.icon
                      return (
                        <div
                          key={resource.id}
                          className="flex items-center gap-3 p-3 rounded-lg border hover:bg-gray-50 transition-colors"
                        >
                          <div className={`p-2 rounded-lg ${config.color}`}>
                            <Icon className="h-4 w-4" />
                          </div>
                          <div className="flex-1 min-w-0">
                            <p className="font-medium text-sm">{resource.title}</p>
                            {resource.description && (
                              <p className="text-xs text-gray-500 mt-0.5 line-clamp-1">
                                {resource.description}
                              </p>
                            )}
                            <div className="flex items-center gap-3 mt-1 text-xs text-gray-400">
                              <span className="inline-flex items-center gap-1">
                                {config.label}
                              </span>
                              {resource.file_size && (
                                <span>{formatFileSize(resource.file_size)}</span>
                              )}
                              {resource.uploaded_by_user?.name && (
                                <span className="inline-flex items-center gap-1">
                                  <User className="h-3 w-3" />
                                  {resource.uploaded_by_user.name}
                                </span>
                              )}
                            </div>
                          </div>
                          <div className="flex items-center gap-1">
                            {resource.file_url && (
                              <Button
                                variant="ghost"
                                size="sm"
                                onClick={() => handleDownload(resource)}
                                title="Download"
                              >
                                <Download className="h-4 w-4" />
                              </Button>
                            )}
                            {isAdmin && (
                              <Button
                                variant="ghost"
                                size="sm"
                                onClick={() => handleDelete(resource.id)}
                                disabled={deleting === resource.id}
                                title="Delete"
                                className="text-red-500 hover:text-red-700 hover:bg-red-50"
                              >
                                {deleting === resource.id ? (
                                  <Loader2 className="h-4 w-4 animate-spin" />
                                ) : (
                                  <Trash2 className="h-4 w-4" />
                                )}
                              </Button>
                            )}
                          </div>
                        </div>
                      )
                    })}
                  </div>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  )
}
