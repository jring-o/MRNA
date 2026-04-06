import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

// POST: Upload a file to the call-resources storage bucket (admin only)
export async function POST(request: Request) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Check admin role server-side as an extra guard
    const role = user.app_metadata?.role
    if (role !== 'admin') {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }

    const formData = await request.formData()
    const file = formData.get('file') as File | null

    if (!file) {
      return NextResponse.json({ error: 'No file provided' }, { status: 400 })
    }

    // Create a unique path: YYYY-MM/uuid-filename
    const now = new Date()
    const folder = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}`
    const uniqueName = `${crypto.randomUUID()}-${file.name}`
    const storagePath = `${folder}/${uniqueName}`

    const { error: uploadError } = await supabase.storage
      .from('call-resources')
      .upload(storagePath, file, {
        contentType: file.type,
        upsert: false,
      })

    if (uploadError) {
      console.error('Storage upload error:', uploadError)
      return NextResponse.json({ error: 'Failed to upload file' }, { status: 500 })
    }

    return NextResponse.json({
      data: {
        path: storagePath,
        file_name: file.name,
        file_size: file.size,
        file_type: file.type,
      }
    })
  } catch (error) {
    console.error('Upload error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
