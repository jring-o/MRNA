'use client'

import type { ReactNode } from 'react'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'

// Thin client shell so the (server-rendered) summary and individual views can
// share a tab toggle without making the whole results page a client component.
export function ResultsTabs({
  summary,
  individual,
  responseCount,
}: {
  summary: ReactNode
  individual: ReactNode
  responseCount: number
}) {
  return (
    <Tabs defaultValue="summary" className="space-y-4">
      <TabsList>
        <TabsTrigger value="summary">Summary</TabsTrigger>
        <TabsTrigger value="individual">Individual ({responseCount})</TabsTrigger>
      </TabsList>
      <TabsContent value="summary" className="space-y-6">
        {summary}
      </TabsContent>
      <TabsContent value="individual">{individual}</TabsContent>
    </Tabs>
  )
}
