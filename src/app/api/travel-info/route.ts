import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

// GET: Fetch current user's travel info
export async function GET() {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const { data, error } = await supabase
      .from('travel_info')
      .select('*')
      .eq('user_id', user.id)
      .single()

    if (error && error.code !== 'PGRST116') {
      // PGRST116 = no rows found, which is fine
      console.error('Error fetching travel info:', error)
      return NextResponse.json({ error: 'Failed to fetch travel info' }, { status: 500 })
    }

    return NextResponse.json({ data: data || null })
  } catch (error) {
    console.error('Travel info GET error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}

// PUT: Update current user's flight details
export async function PUT(request: Request) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const body = await request.json()

    // Only allow updating flight-related fields, not travel_budget
    const allowedFields = [
      'arrival_mode', 'arrival_date', 'arrival_flight_number', 'arrival_time',
      'departure_mode', 'departure_date', 'departure_flight_number', 'departure_time',
      'notes'
    ]

    const updateData: Record<string, string | null> = {}
    for (const field of allowedFields) {
      if (field in body) {
        updateData[field] = body[field] || null
      }
    }

    // Check if a row already exists
    const { data: existing } = await supabase
      .from('travel_info')
      .select('id')
      .eq('user_id', user.id)
      .single()

    if (existing) {
      const { error } = await supabase
        .from('travel_info')
        .update(updateData)
        .eq('user_id', user.id)

      if (error) {
        console.error('Error updating travel info:', error)
        return NextResponse.json({ error: 'Failed to update travel info' }, { status: 500 })
      }
    } else {
      const { error } = await supabase
        .from('travel_info')
        .insert({ user_id: user.id, ...updateData })

      if (error) {
        console.error('Error inserting travel info:', error)
        return NextResponse.json({ error: 'Failed to save travel info' }, { status: 500 })
      }
    }

    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('Travel info PUT error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
