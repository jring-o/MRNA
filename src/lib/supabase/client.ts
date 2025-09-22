import { createBrowserClient } from '@supabase/ssr'
import type { Database } from '@/types/supabase'

/**
 * Create a Supabase client for client-side operations
 * This is a singleton that can be used across client components
 */
export function createClient() {
  return createBrowserClient<Database>(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  )
}