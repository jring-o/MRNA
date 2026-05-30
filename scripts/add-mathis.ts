/**
 * One-off: add Mathis Federico as a confirmed engineer participant + invite token.
 * Run with: npx tsx scripts/add-mathis.ts
 */

import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseServiceKey)

const EMAIL = 'mathis.federico@bycelium.com'
const NAME = 'Mathis Federico'
const ORG = 'Bycelium'
const TOKEN = 'INVITE-MATHIS-FEDERICO'

async function run() {
  // 1) application (idempotent)
  const { data: existingApp } = await supabase
    .from('applications')
    .select('id')
    .eq('email', EMAIL)
    .maybeSingle()

  let applicationId = existingApp?.id ?? null

  if (applicationId) {
    console.log(`Application already exists for ${EMAIL} (${applicationId}) — skipping insert`)
  } else {
    const { data: inserted, error: appErr } = await supabase
      .from('applications')
      .insert({
        name: NAME,
        email: EMAIL,
        organization: ORG,
        role: 'Direct Invite',
        status: 'accepted',
        submitted_at: new Date().toISOString(),
        reviewed_at: new Date().toISOString(),
        voting_completed: true,
        voting_completed_at: new Date().toISOString(),
        classifications: ['engineer'],
        importance_of_schema: 'Direct invite - no application submitted',
        excited_projects: 'Direct invite - no application submitted',
        work_links: [{ description: 'Direct invite', role: 'Invitee', url: '' }],
        workshop_contribution: 'Direct invite - no application submitted',
        research_elements: 'Direct invite - no application submitted',
        engineer_working_on: 'Direct invite',
        engineer_schema_considerations: 'Direct invite',
      })
      .select('id')
      .single()

    if (appErr) {
      console.error('Error inserting application:', appErr.message)
      process.exit(1)
    }
    applicationId = inserted!.id
    console.log(`Inserted application ${applicationId}`)
  }

  // 2) invite token (idempotent on token string)
  const { data: existingTok } = await supabase
    .from('invite_tokens')
    .select('token, used, expires_at')
    .eq('token', TOKEN)
    .maybeSingle()

  if (existingTok) {
    console.log(`Invite token "${TOKEN}" already exists (used=${existingTok.used}, expires_at=${existingTok.expires_at}) — skipping insert`)
  } else {
    const expiresAt = new Date(Date.now() + 48 * 60 * 60 * 1000).toISOString()
    const { error: tokErr } = await supabase
      .from('invite_tokens')
      .insert({
        email: EMAIL,
        token: TOKEN,
        application_id: applicationId,
        used: false,
        expires_at: expiresAt,
      })
    if (tokErr) {
      console.error('Error inserting invite token:', tokErr.message)
      process.exit(1)
    }
    console.log(`Inserted invite token "${TOKEN}" (expires ${expiresAt})`)
  }

  console.log('\nSignup link:')
  console.log(`https://mrna-nine.vercel.app/signup?token=${TOKEN}&email=${encodeURIComponent(EMAIL)}`)
}

run()
  .then(() => process.exit(0))
  .catch((e) => {
    console.error('Fatal:', e)
    process.exit(1)
  })
