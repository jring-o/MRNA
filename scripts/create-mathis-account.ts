/**
 * Create Mathis Federico's auth account directly with a password.
 * Run with: npx tsx scripts/create-mathis-account.ts
 */

import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'
import { randomBytes } from 'crypto'

dotenv.config({ path: '.env.local' })

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY!

const supabase = createClient(supabaseUrl, supabaseServiceKey, {
  auth: { autoRefreshToken: false, persistSession: false },
})

const EMAIL = 'mathis.federico@bycelium.com'
const NAME = 'Mathis Federico'

// Generate a readable random password
function genPassword() {
  return randomBytes(12).toString('base64url')
}

async function run() {
  const password = genPassword()

  const { data: created, error: createErr } = await supabase.auth.admin.createUser({
    email: EMAIL,
    password,
    email_confirm: true,
    user_metadata: { full_name: NAME },
    app_metadata: { role: 'participant' },
  })

  if (createErr) {
    console.error('createUser error:', createErr.message)
    process.exit(1)
  }

  const userId = created.user!.id
  console.log(`Created auth user ${userId} for ${EMAIL}`)

  // Link existing accepted application to this user if needed
  const { data: app } = await supabase
    .from('applications')
    .select('id, user_id')
    .eq('email', EMAIL)
    .maybeSingle()

  if (app && !app.user_id) {
    const { error: linkErr } = await supabase
      .from('applications')
      .update({ user_id: userId })
      .eq('id', app.id)
    if (linkErr) {
      console.warn('Could not link application.user_id:', linkErr.message)
    } else {
      console.log(`Linked application ${app.id} → user ${userId}`)
    }
  }

  console.log('\n=== CREDENTIALS ===')
  console.log(`Email:    ${EMAIL}`)
  console.log(`Password: ${password}`)
  console.log(`Login:    https://mrna-nine.vercel.app/login`)
}

run()
  .then(() => process.exit(0))
  .catch((e) => {
    console.error('Fatal:', e)
    process.exit(1)
  })
