import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

const ALLOWED_EMAIL = 'jon@scios.tech'

export async function POST(request: Request) {
  try {
    const supabase = await createClient()

    // Verify user is authenticated
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Check if user is the allowed admin
    if (user.email !== ALLOWED_EMAIL) {
      return NextResponse.json({ error: 'Forbidden - Only jon@scios.tech can use this feature' }, { status: 403 })
    }

    // Parse request body
    const { name, email, organization, roles } = await request.json()

    if (!name || !email) {
      return NextResponse.json({ error: 'Name and email are required' }, { status: 400 })
    }

    // Ensure roles is an array
    const classificationRoles = Array.isArray(roles) ? roles : []

    // Check if an application already exists for this email
    const { data: existingApp } = await supabase
      .from('applications')
      .select('id')
      .eq('email', email)
      .single()

    if (existingApp) {
      return NextResponse.json(
        { error: 'An application already exists for this email' },
        { status: 400 }
      )
    }

    // Determine classification based on roles selection
    const classifications = classificationRoles.length > 0 ? classificationRoles : ['other']
    // classification_other is required when 'other' is in classifications
    const classificationOther = classifications.includes('other') ? 'Direct Invite' : null

    // Build role-specific fields based on classifications
    const roleFields: Record<string, string | null> = {
      researcher_use_case: classifications.includes('researcher') ? 'Direct invite' : null,
      researcher_future_impact: classifications.includes('researcher') ? 'Direct invite' : null,
      designer_ux_considerations: classifications.includes('designer') ? 'Direct invite' : null,
      engineer_working_on: classifications.includes('engineer') ? 'Direct invite' : null,
      engineer_schema_considerations: classifications.includes('engineer') ? 'Direct invite' : null,
      landscape_specialist_current_work: classifications.includes('landscape_specialist') ? 'Direct invite' : null,
      landscape_specialist_see_emerging: classifications.includes('landscape_specialist') ? 'Direct invite' : null,
    }

    // Create application record with status 'accepted'
    const { data: application, error: appError } = await supabase
      .from('applications')
      .insert({
        name,
        email,
        organization: organization || null,
        role: 'Direct Invite',
        status: 'accepted',
        submitted_at: new Date().toISOString(),
        reviewed_at: new Date().toISOString(),
        reviewed_by: user.id,
        voting_completed: true,
        voting_completed_at: new Date().toISOString(),
        classifications,
        classification_other: classificationOther,
        importance_of_schema: 'Direct invite - no application submitted',
        excited_projects: 'Direct invite - no application submitted',
        work_links: [{ description: 'Direct invite', role: 'Invitee', url: '' }],
        workshop_contribution: 'Direct invite - no application submitted',
        research_elements: 'Direct invite - no application submitted',
        ...roleFields,
      })
      .select()
      .single()

    if (appError) {
      console.error('Error creating application:', appError)
      return NextResponse.json({ error: 'Failed to create application record' }, { status: 500 })
    }

    return NextResponse.json({
      success: true,
      applicationId: application.id,
    })
  } catch (error) {
    console.error('Add person error:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
