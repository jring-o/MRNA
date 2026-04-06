import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

// GET: Generate a signed download URL for a call resource file
export async function GET(request: Request) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Only participants and admins can download call resources
    const role = user.app_metadata?.role
    if (role !== 'participant' && role !== 'admin') {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }

    const { searchParams } = new URL(request.url)
    const path = searchParams.get('path')

    if (!path) {
      return NextResponse.json({ error: 'No path provided' }, { status: 400 })
    }

    // Create a signed URL valid for 1 hour
    const { data, error } = await supabase.storage
      .from('call-resources')
      .createSignedUrl(path, 3600)

    if (error) {
      console.error('Signed URL error:', error)
      return NextResponse.json({ error: 'Failed to generate download link' }, { status: 500 })
    }

    return NextResponse.json({ url: data.signedUrl })
  } catch (error) {
    console.error('Download URL error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
