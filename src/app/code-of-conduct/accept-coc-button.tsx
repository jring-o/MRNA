'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { CheckCircle2 } from 'lucide-react'

export function AcceptCocButton({ userId }: { userId: string }) {
  const [loading, setLoading] = useState(false)
  const router = useRouter()
  const supabase = createClient()

  async function handleAccept() {
    setLoading(true)
    const { error } = await supabase
      .from('users')
      .update({ coc_accepted_at: new Date().toISOString() })
      .eq('id', userId)

    if (error) {
      console.error('Error accepting CoC:', error)
      setLoading(false)
      return
    }

    router.push('/dashboard')
  }

  return (
    <div className="bg-green-50 border border-green-200 rounded-lg p-6 text-center space-y-4">
      <p className="text-sm text-green-800 font-medium">
        By clicking the button below, you confirm that you have read and agree to abide by this Code of Conduct.
      </p>
      <Button
        onClick={handleAccept}
        disabled={loading}
        size="lg"
        className="bg-green-600 hover:bg-green-700 text-white"
      >
        <CheckCircle2 className="mr-2 h-5 w-5" />
        {loading ? 'Accepting...' : 'I Accept the Code of Conduct'}
      </Button>
    </div>
  )
}
