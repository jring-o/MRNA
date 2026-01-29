/**
 * Seed script to import confirmed attendees from CSV
 * Run with: npx tsx scripts/seed-confirmed-attendees.ts
 */

import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'

// Load environment variables
dotenv.config({ path: '.env.local' })

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseServiceKey)

// Map CSV types to our classification values
function mapTypeToClassifications(type: string): string[] {
  if (!type || type.trim() === '') return ['other']

  const typeMap: Record<string, string> = {
    'designer': 'designer',
    'engineer': 'engineer',
    'landscape/ecosystem': 'landscape_specialist',
    'researcher': 'researcher',
  }

  const types = type.split(',').map(t => t.trim().toLowerCase())
  const classifications = types
    .map(t => typeMap[t])
    .filter(Boolean)

  return classifications.length > 0 ? classifications : ['other']
}

// Generate placeholder email from name
function generatePlaceholderEmail(name: string): string {
  const cleanName = name
    .toLowerCase()
    .replace(/\s*\([^)]*\)\s*/g, '') // Remove parenthetical info
    .replace(/[^a-z0-9\s]/g, '') // Remove special chars
    .trim()
    .replace(/\s+/g, '.') // Replace spaces with dots

  return `${cleanName}@placeholder.local`
}

// Extract organization from name if in parentheses
function extractOrganization(name: string): string | null {
  const match = name.match(/\(([^)]+)\)/)
  return match ? match[1] : null
}

// Clean name (remove parenthetical info)
function cleanName(name: string): string {
  return name.replace(/\s*\([^)]*\)\s*/g, '').trim()
}

// Confirmed attendees from CSV
const confirmedAttendees = [
  { name: 'Saif (Fylo)', type: 'Designer, Engineer' },
  { name: 'Joel (Discourse Graphs)', type: 'Landscape/Ecosystem, Researcher' },
  { name: 'Anton (bNext)', type: 'Researcher' },
  { name: 'Marc-Antoine (Discourse Graphs)', type: 'Engineer' },
  { name: 'Ronen (Cosmik)', type: 'Landscape/Ecosystem' },
  { name: 'Monica (Creative commons)', type: 'Landscape/Ecosystem' },
  { name: 'Martin (Coordination network)', type: 'Engineer' },
  { name: 'Morgan (Engineer)', type: 'Engineer, Researcher' },
  { name: 'Luke (KOI)', type: 'Engineer' },
  { name: 'Kate Lee (U Toronto)', type: 'Researcher' },
  { name: 'Tracy Teal (OpenRxiv)', type: 'Landscape/Ecosystem' },
  { name: 'Jon', type: '' },
  { name: 'Ellie', type: '' },
  { name: 'Matt', type: 'Researcher' },
  { name: 'Sean Moore (McGill)', type: 'Researcher' },
]

async function seedAttendees() {
  console.log('Starting to seed confirmed attendees...\n')

  let successCount = 0
  let skipCount = 0
  let errorCount = 0

  for (const attendee of confirmedAttendees) {
    const name = cleanName(attendee.name)
    const email = generatePlaceholderEmail(attendee.name)
    const organization = extractOrganization(attendee.name)
    const classifications = mapTypeToClassifications(attendee.type)

    // Check if already exists
    const { data: existing } = await supabase
      .from('applications')
      .select('id')
      .eq('email', email)
      .single()

    if (existing) {
      console.log(`⏭️  Skipping ${name} - already exists`)
      skipCount++
      continue
    }

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

    // Insert new attendee
    const { error } = await supabase
      .from('applications')
      .insert({
        name,
        email,
        organization,
        role: 'Direct Invite',
        status: 'accepted',
        submitted_at: new Date().toISOString(),
        reviewed_at: new Date().toISOString(),
        voting_completed: true,
        voting_completed_at: new Date().toISOString(),
        classifications,
        classification_other: classifications.includes('other') ? 'Confirmed Invitee' : null,
        importance_of_schema: 'Direct invite - no application submitted',
        excited_projects: 'Direct invite - no application submitted',
        work_links: [{ description: 'Direct invite', role: 'Invitee', url: '' }],
        workshop_contribution: 'Direct invite - no application submitted',
        research_elements: 'Direct invite - no application submitted',
        ...roleFields,
      })

    if (error) {
      console.error(`❌ Error adding ${name}:`, error.message)
      errorCount++
    } else {
      console.log(`✅ Added ${name} (${email}) - ${classifications.join(', ')}`)
      successCount++
    }
  }

  console.log('\n--- Summary ---')
  console.log(`✅ Added: ${successCount}`)
  console.log(`⏭️  Skipped: ${skipCount}`)
  console.log(`❌ Errors: ${errorCount}`)
}

seedAttendees()
  .then(() => {
    console.log('\nDone!')
    process.exit(0)
  })
  .catch((err) => {
    console.error('Fatal error:', err)
    process.exit(1)
  })
