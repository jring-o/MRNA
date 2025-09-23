'use client'

import { ParticipantDashboard } from './participant-dashboard'

interface ParticipantSectionProps {
  userId: string
  userName: string
}

export function ParticipantSection({ userId, userName }: ParticipantSectionProps) {
  return <ParticipantDashboard userId={userId} userName={userName} />
}