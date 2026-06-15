/**
 * Read-only: list participants by their lightning_talk_interest opt-in.
 * Run with: npx tsx scripts/check-lightning-talks.ts
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

async function run() {
  const { data, error } = await supabase
    .from('participant_profiles')
    .select('lightning_talk_interest, updated_at, users(name, email)')

  if (error) {
    console.error('Query error:', error.message)
    process.exit(1)
  }

  type Row = {
    lightning_talk_interest: boolean | null
    updated_at: string | null
    users: { name: string | null; email: string | null } | null
  }

  const rows = (data as unknown as Row[]) || []
  const fmt = (r: Row) => `  ${r.users?.name || '(no name)'} <${r.users?.email || '?'}>`

  const yes = rows.filter(r => r.lightning_talk_interest === true)
  const no = rows.filter(r => r.lightning_talk_interest === false)
  const unanswered = rows.filter(r => r.lightning_talk_interest == null)

  console.log(`Total participant profiles: ${rows.length}\n`)
  console.log(`WANT TO GIVE A LIGHTNING TALK (${yes.length}):`)
  yes.map(fmt).sort().forEach(l => console.log(l))
  console.log(`\nExplicitly NO (${no.length}) | No answer (${unanswered.length})`)
}

run()
  .then(() => process.exit(0))
  .catch(e => {
    console.error('Fatal:', e)
    process.exit(1)
  })
