import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { createClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'

async function signOut() {
  'use server'

  const supabase = await createClient()
  await supabase.auth.signOut()
  redirect('/login')
}

export async function AuthHeader() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  return (
    <header className="sticky top-0 z-50 w-full border-b bg-white/95 backdrop-blur supports-[backdrop-filter]:bg-white/60">
      <div className="container mx-auto flex h-16 items-center px-4">
        <Link href="/" className="mr-8 font-bold text-xl text-workshop-primary">
          MIRA 2026
        </Link>

        <nav className="flex gap-6 flex-1">
          <Link
            href="/"
            className="text-sm font-medium transition-colors hover:text-workshop-primary text-gray-600"
          >
            Home
          </Link>
          {user && (
            <Link
              href="/dashboard"
              className="text-sm font-medium transition-colors hover:text-workshop-primary text-gray-600"
            >
              Dashboard
            </Link>
          )}
          <Link
            href="/blog"
            className="text-sm font-medium transition-colors hover:text-workshop-primary text-gray-600"
          >
            Blog
          </Link>
          <Link
            href="/results"
            className="text-sm font-medium transition-colors hover:text-workshop-primary text-gray-600"
          >
            Results
          </Link>
        </nav>

        <div className="flex gap-2">
          {user ? (
            <>
              <span className="text-sm text-gray-600 flex items-center mr-2">
                {user.email}
              </span>
              <form action={signOut}>
                <Button type="submit" variant="outline" size="sm">
                  Logout
                </Button>
              </form>
            </>
          ) : (
            <>
              <Button variant="outline" size="sm" asChild>
                <Link href="/login">Login</Link>
              </Button>
              <Button size="sm" asChild>
                <Link href="/apply">Apply Now</Link>
              </Button>
            </>
          )}
        </div>
      </div>
    </header>
  )
}