/**
 * Read-only: list participants who signed up for a lightning talk
 * (lightning_talk_interest = true), shuffled into a random order.
 * Run with: npx tsx scripts/list-lightning-talks-random.ts
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

type Row = {
  lightning_talk_interest: boolean | null
  users: { name: string | null; email: string | null } | null
}

// Fisher-Yates shuffle
function shuffle<T>(arr: T[]): T[] {
  const a = [...arr]
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1))
    ;[a[i], a[j]] = [a[j], a[i]]
  }
  return a
}

async function run() {
  const { data, error } = await supabase
    .from('participant_profiles')
    .select('lightning_talk_interest, users(name, email)')

  if (error) {
    console.error('Query error:', error.message)
    process.exit(1)
  }

  const rows = (data as unknown as Row[]) || []
  const signedUp = rows.filter(r => r.lightning_talk_interest === true)
  const ordered = shuffle(signedUp)

  console.log(`Lightning talk sign-ups (${ordered.length}) — random order:\n`)
  ordered.forEach((r, i) => {
    const name = r.users?.name || '(no name)'
    const email = r.users?.email || '?'
    console.log(`  ${i + 1}. ${name} <${email}>`)
  })
}

run()
  .then(() => process.exit(0))
  .catch(e => {
    console.error('Fatal:', e)
    process.exit(1)
  })
