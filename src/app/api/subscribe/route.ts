import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

// Good-enough email shape check. The DB has a case-insensitive unique index and
// the honeypot stops most bots; this just rejects obvious junk early.
const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
const ALLOWED_SOURCES = new Set(['hero', 'get-involved'])

export async function POST(request: Request) {
  try {
    let body: { email?: unknown; source?: unknown; company?: unknown }
    try {
      body = await request.json()
    } catch {
      return NextResponse.json({ error: 'Invalid request.' }, { status: 400 })
    }

    // Honeypot: the hidden "company" field is only ever filled by bots. Pretend
    // success so they don't learn they were filtered.
    if (typeof body.company === 'string' && body.company.trim() !== '') {
      return NextResponse.json({ success: true })
    }

    const email =
      typeof body.email === 'string' ? body.email.trim().toLowerCase() : ''
    if (!email || email.length > 254 || !EMAIL_RE.test(email)) {
      return NextResponse.json(
        { error: 'Please enter a valid email address.' },
        { status: 400 }
      )
    }

    const source =
      typeof body.source === 'string' && ALLOWED_SOURCES.has(body.source)
        ? body.source
        : null

    const supabase = await createClient()
    const { error } = await supabase
      .from('subscribers')
      .insert({ email, source })

    if (error) {
      // 23505 = unique_violation -> already on the list, treat as success.
      if (error.code === '23505') {
        return NextResponse.json({ success: true, alreadySubscribed: true })
      }
      console.error('subscribe insert error:', error)
      return NextResponse.json(
        { error: 'Something went wrong. Please try again.' },
        { status: 500 }
      )
    }

    return NextResponse.json({ success: true })
  } catch (err) {
    console.error('subscribe unexpected error:', err)
    return NextResponse.json(
      { error: 'Something went wrong. Please try again.' },
      { status: 500 }
    )
  }
}
