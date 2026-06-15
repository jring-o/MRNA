/**
 * Read-only: compare current travel_info arrival data in Supabase against the
 * snapshot recorded in dublin-arrivals.md, and report any changes.
 * Run with: npx tsx scripts/check-arrivals.ts
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

// Snapshot from dublin-arrivals.md (email -> arrival fields)
const SNAPSHOT: Record<string, { date: string; time: string; flight: string }> = {
  'nokome@stencila.io': { date: '2026-06-06', time: '08:20', flight: 'AF1616' },
  'ellie@scios.tech': { date: '2026-06-06', time: '09:40', flight: 'B6 841' },
  'ellie.rennie@rmit.edu.au': { date: '2026-06-06', time: '09:40', flight: 'BA826' },
  'jon@scios.tech': { date: '2026-06-06', time: '11:00', flight: 'UA4187' },
  'antonmolina@bnext.bio': { date: '2026-06-06', time: '11:45', flight: 'AA 8324' },
  'paul@homeworld.bio': { date: '2026-06-06', time: '11:45', flight: 'EI 60' },
  'akamatsm@uw.edu': { date: '2026-06-06', time: '12:15', flight: 'EI52' },
  'mathis.federico@bycelium.com': { date: '2026-06-07', time: '06:45', flight: 'FR23' },
  'shaobsh@gmail.com': { date: '2026-06-07', time: '07:30', flight: 'UA 23' },
  'frida.arreytakubetang@gmail.com': { date: '2026-06-07', time: '08:00', flight: 'FR5419' },
  'morgan@quantumbiology.org': { date: '2026-06-07', time: '08:15', flight: 'EI0114' },
  'monica@creativecommons.org': { date: '2026-06-07', time: '08:15', flight: 'AC800' },
  'joelchan@umd.edu': { date: '2026-06-07', time: '08:22', flight: 'B6353' },
  'hyunokate.lee@utoronto.ca': { date: '2026-06-07', time: '08:45', flight: 'DELTA 2539' },
  'sekhar.ramakrishnan@astera.org': { date: '2026-06-07', time: '08:55', flight: 'LX 402' },
  'rodrigo.miguelesramirez@mail.mcgill.ca': { date: '2026-06-07', time: '09:20', flight: 'WS 46' },
  'maparent@conversence.com': { date: '2026-06-07', time: '09:20', flight: 'WS46' },
  'sean.moore3@mail.mcgill.ca': { date: '2026-06-07', time: '09:20', flight: 'WS 46' },
  'luke@block.science': { date: '2026-06-07', time: '11:10', flight: 'UA317' },
  'p.shannon@elifesciences.org': { date: '2026-06-07', time: '12:20', flight: 'FR338' },
  'ronen@cosmik.network': { date: '2026-06-07', time: '18:20', flight: '0169' },
  'a.campbell@digital-science.com': { date: '2026-06-07', time: '19:15', flight: 'Enterprise — Belfast → Dublin' },
  'm@jmartink.org': { date: '2026-06-07', time: '19:25', flight: 'BA4468' },
}

const normTime = (t: string | null) => (t ? t.slice(0, 5) : '')
const normFlight = (f: string | null) => (f || '').replace(/\s+/g, '').toUpperCase()

async function run() {
  const { data, error } = await supabase
    .from('travel_info')
    .select('arrival_date, arrival_time, arrival_flight_number, arrival_mode, updated_at, users(name, email)')

  if (error) {
    console.error('Query error:', error.message)
    process.exit(1)
  }

  type Row = {
    arrival_date: string | null
    arrival_time: string | null
    arrival_flight_number: string | null
    arrival_mode: string | null
    updated_at: string | null
    users: { name: string | null; email: string | null } | null
  }

  const rows = (data as unknown as Row[]) || []
  const seen = new Set<string>()
  const changes: string[] = []
  const newPeople: string[] = []

  for (const r of rows) {
    const email = (r.users?.email || '').toLowerCase()
    const name = r.users?.name || email || '(unknown)'
    if (!email) continue
    seen.add(email)

    const snap = SNAPSHOT[email]
    if (!snap) {
      newPeople.push(
        `  + ${name} <${email}>: ${r.arrival_date} ${normTime(r.arrival_time)} ${r.arrival_flight_number || ''} (${r.arrival_mode || '?'})`
      )
      continue
    }

    const diffs: string[] = []
    if ((r.arrival_date || '') !== snap.date) diffs.push(`date ${snap.date} -> ${r.arrival_date || '(null)'}`)
    if (normTime(r.arrival_time) !== snap.time) diffs.push(`time ${snap.time} -> ${normTime(r.arrival_time) || '(null)'}`)
    if (normFlight(r.arrival_flight_number) !== normFlight(snap.flight))
      diffs.push(`flight "${snap.flight}" -> "${r.arrival_flight_number || '(null)'}"`)

    if (diffs.length) {
      const when = r.updated_at ? r.updated_at.slice(0, 16).replace('T', ' ') : '?'
      changes.push(`  * ${name} <${email}> [updated ${when}]\n      ${diffs.join('\n      ')}`)
    }
  }

  const missing = Object.keys(SNAPSHOT).filter(e => !seen.has(e))

  console.log(`Fetched ${rows.length} travel_info rows; snapshot has ${Object.keys(SNAPSHOT).length} people.\n`)

  console.log(changes.length ? `CHANGED ARRIVALS (${changes.length}):` : 'CHANGED ARRIVALS: none')
  changes.forEach(c => console.log(c))

  console.log(`\n${newPeople.length ? `NEW / NOT IN SNAPSHOT (${newPeople.length}):` : 'NEW / NOT IN SNAPSHOT: none'}`)
  newPeople.forEach(p => console.log(p))

  console.log(`\n${missing.length ? `IN SNAPSHOT BUT NO DB ROW (${missing.length}):` : 'IN SNAPSHOT BUT NO DB ROW: none'}`)
  missing.forEach(m => console.log(`  - ${m}`))
}

run()
  .then(() => process.exit(0))
  .catch(e => {
    console.error('Fatal:', e)
    process.exit(1)
  })
