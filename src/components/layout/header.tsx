'use client'

import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { usePathname } from 'next/navigation'
import { cn } from '@/lib/utils'

export function Header() {
  const pathname = usePathname()

  const navItems = [
    { href: '/', label: 'Home' },
    { href: '/apply', label: 'Apply' },
    { href: '/blog', label: 'Blog' },
    { href: '/results', label: 'Results' },
  ]

  return (
    <header className="sticky top-0 z-50 w-full border-b bg-white/95 backdrop-blur supports-[backdrop-filter]:bg-white/60">
      <div className="container mx-auto flex h-16 items-center px-4">
        <Link href="/" className="mr-8 font-bold text-xl text-workshop-primary">
          Workshop 2026
        </Link>

        <nav className="flex gap-6 flex-1">
          {navItems.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className={cn(
                'text-sm font-medium transition-colors hover:text-workshop-primary',
                pathname === item.href
                  ? 'text-workshop-primary'
                  : 'text-gray-600'
              )}
            >
              {item.label}
            </Link>
          ))}
        </nav>

        <div className="flex gap-2">
          <Button variant="outline" size="sm" asChild>
            <Link href="/login">Login</Link>
          </Button>
          <Button size="sm" asChild>
            <Link href="/apply">Apply Now</Link>
          </Button>
        </div>
      </div>
    </header>
  )
}