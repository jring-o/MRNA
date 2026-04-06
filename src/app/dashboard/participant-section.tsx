'use client'

import { ParticipantDashboard } from './participant-dashboard'

interface ParticipantSectionProps {
  userId: string
  userName: string
  isAdmin: boolean
}

export function ParticipantSection({ userId, userName, isAdmin }: ParticipantSectionProps) {
  return <ParticipantDashboard userId={userId} userName={userName} isAdmin={isAdmin} />
}