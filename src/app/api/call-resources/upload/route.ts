import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

// POST: Generate a signed upload URL so the client can upload directly to
// Supabase Storage, bypassing the Next.js body-size limit.
export async function POST(request: Request) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const role = user.app_metadata?.role
    if (role !== 'admin') {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }

    const { fileName, contentType } = await request.json()

    if (!fileName) {
      return NextResponse.json({ error: 'fileName is required' }, { status: 400 })
    }

    // Build a unique storage path: YYYY-MM/uuid-filename
    const now = new Date()
    const folder = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}`
    const uniqueName = `${crypto.randomUUID()}-${fileName}`
    const storagePath = `${folder}/${uniqueName}`

    const { data, error } = await supabase.storage
      .from('call-resources')
      .createSignedUploadUrl(storagePath)

    if (error) {
      console.error('Signed upload URL error:', error)
      return NextResponse.json({ error: 'Failed to create upload URL' }, { status: 500 })
    }

    return NextResponse.json({
      data: {
        signedUrl: data.signedUrl,
        token: data.token,
        path: storagePath,
        contentType: contentType || 'application/octet-stream',
      }
    })
  } catch (error) {
    console.error('Upload URL error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
