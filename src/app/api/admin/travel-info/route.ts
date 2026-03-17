import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

// GET: Fetch all participants' travel info (admin only)
export async function GET() {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    if (user.app_metadata?.role !== 'admin') {
      return NextResponse.json({ error: 'Forbidden - Admin only' }, { status: 403 })
    }

    // Join travel_info with users to get names and emails
    const { data, error } = await supabase
      .from('travel_info')
      .select(`
        *,
        users:user_id (
          name,
          email,
          organization
        )
      `)
      .order('created_at')

    if (error) {
      console.error('Error fetching travel info:', error)
      return NextResponse.json({ error: 'Failed to fetch travel info' }, { status: 500 })
    }

    return NextResponse.json({ data: data || [] })
  } catch (error) {
    console.error('Admin travel info GET error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
