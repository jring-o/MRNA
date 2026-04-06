import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

// GET: List all call resources (participants + admins)
export async function GET() {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { data, error } = await supabase
      .from('call_resources')
      .select('*, uploaded_by_user:users!call_resources_uploaded_by_fkey(name)')
      .order('call_date', { ascending: false, nullsFirst: false })
      .order('created_at', { ascending: false })

    if (error) {
      console.error('Error fetching call resources:', error)
      return NextResponse.json({ error: 'Failed to fetch call resources' }, { status: 500 })
    }

    return NextResponse.json({ data: data || [] })
  } catch (error) {
    console.error('Call resources GET error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}

// POST: Create a call resource record (admin only — RLS enforced)
export async function POST(request: Request) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const body = await request.json()

    const { data, error } = await supabase
      .from('call_resources')
      .insert({
        title: body.title,
        description: body.description || null,
        call_date: body.call_date || null,
        file_url: body.file_url || null,
        file_name: body.file_name || null,
        file_size: body.file_size || null,
        file_type: body.file_type || null,
        resource_type: body.resource_type || 'recording',
        uploaded_by: user.id,
      })
      .select()
      .single()

    if (error) {
      console.error('Error creating call resource:', error)
      return NextResponse.json({ error: 'Failed to create call resource' }, { status: 500 })
    }

    return NextResponse.json({ data })
  } catch (error) {
    console.error('Call resources POST error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}

// DELETE: Remove a call resource and its file (admin only — RLS enforced)
export async function DELETE(request: Request) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { id } = await request.json()

    // Fetch the resource to get the file path before deleting
    const { data: resource } = await supabase
      .from('call_resources')
      .select('file_url')
      .eq('id', id)
      .single()

    // Delete the file from storage if it exists and is a storage path
    if (resource?.file_url && !resource.file_url.startsWith('http')) {
      await supabase.storage.from('call-resources').remove([resource.file_url])
    }

    const { error } = await supabase
      .from('call_resources')
      .delete()
      .eq('id', id)

    if (error) {
      console.error('Error deleting call resource:', error)
      return NextResponse.json({ error: 'Failed to delete call resource' }, { status: 500 })
    }

    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('Call resources DELETE error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
