'use client'

import { useState, useMemo, useRef, useEffect } from 'react'
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Badge } from '@/components/ui/badge'
import { TiptapEditor } from './tiptap-editor'
import { toast } from 'sonner'
import { Loader2, Send, X, Search, Users, Shield, Globe } from 'lucide-react'

interface UserInfo {
  id: string
  name: string
  email: string
  role: 'participant' | 'admin'
}

type RecipientMode = 'all' | 'participants' | 'admins' | 'custom'

interface ComposeMessageDialogProps {
  open: boolean
  onOpenChange: (open: boolean) => void
  onMessageSent: () => void
  users: UserInfo[]
}

function getUsersForMode(users: UserInfo[], mode: RecipientMode): UserInfo[] {
  switch (mode) {
    case 'participants':
      return users.filter(u => u.role === 'participant')
    case 'admins':
      return users.filter(u => u.role === 'admin')
    default:
      return users
  }
}

export function ComposeMessageDialog({ open, onOpenChange, onMessageSent, users }: ComposeMessageDialogProps) {
  const [subject, setSubject] = useState('')
  const [content, setContent] = useState('')
  const [sending, setSending] = useState(false)
  const [selectedUserIds, setSelectedUserIds] = useState<Set<string>>(new Set(users.map(u => u.id)))
  const [recipientMode, setRecipientMode] = useState<RecipientMode>('all')
  const [searchQuery, setSearchQuery] = useState('')
  const [searchOpen, setSearchOpen] = useState(false)
  const searchRef = useRef<HTMLDivElement>(null)

  // Reset recipients when dialog opens
  useEffect(() => {
    if (open) {
      setSelectedUserIds(new Set(users.map(u => u.id)))
      setRecipientMode('all')
      setSearchQuery('')
      setSearchOpen(false)
    }
  }, [open, users])

  // Close search dropdown on outside click
  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (searchRef.current && !searchRef.current.contains(e.target as Node)) {
        setSearchOpen(false)
      }
    }
    document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [])

  const selectedUsers = useMemo(
    () => users.filter(u => selectedUserIds.has(u.id)),
    [users, selectedUserIds]
  )

  const searchResults = useMemo(() => {
    if (!searchQuery.trim()) return []
    const q = searchQuery.toLowerCase()
    return users.filter(
      u => !selectedUserIds.has(u.id) &&
        (u.name.toLowerCase().includes(q) || u.email.toLowerCase().includes(q))
    )
  }, [users, selectedUserIds, searchQuery])

  function handleGroupSelect(mode: RecipientMode) {
    setRecipientMode(mode)
    const groupUsers = getUsersForMode(users, mode)
    setSelectedUserIds(new Set(groupUsers.map(u => u.id)))
  }

  function removeUser(userId: string) {
    setSelectedUserIds(prev => {
      const next = new Set(prev)
      next.delete(userId)
      return next
    })
    setRecipientMode('custom')
  }

  function addUser(userId: string) {
    setSelectedUserIds(prev => new Set(prev).add(userId))
    setRecipientMode('custom')
    setSearchQuery('')
    setSearchOpen(false)
  }

  const handleSend = async () => {
    if (!subject.trim() || !content.trim() || content === '<p></p>') {
      toast.error('Please fill in both subject and message content')
      return
    }

    if (selectedUserIds.size === 0) {
      toast.error('Please select at least one recipient')
      return
    }

    setSending(true)

    try {
      // Extract plain text from HTML
      const tempDiv = document.createElement('div')
      tempDiv.innerHTML = content
      const contentPlain = tempDiv.textContent || tempDiv.innerText || ''

      const body: Record<string, unknown> = {
        subject: subject.trim(),
        content,
        contentPlain: contentPlain.trim(),
      }

      // Send recipientIds for all modes except 'all' (backward compat)
      if (recipientMode !== 'all') {
        body.recipientIds = Array.from(selectedUserIds)
      }

      const response = await fetch('/api/messages/send', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body),
      })

      const result = await response.json()

      if (!response.ok) {
        throw new Error(result.error || 'Failed to send message')
      }

      toast.success(`Message sent! ${result.emailsSent} email${result.emailsSent !== 1 ? 's' : ''} delivered.`)

      setSubject('')
      setContent('')
      onOpenChange(false)
      onMessageSent()
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'Failed to send message')
    } finally {
      setSending(false)
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>Compose Message</DialogTitle>
          <DialogDescription>
            Send a message to selected recipients. It will be emailed and posted on the messages page.
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4">
          {/* Recipient Selector */}
          <div className="space-y-2">
            <Label>Recipients</Label>

            {/* Group toggle buttons */}
            <div className="flex gap-2">
              <Button
                type="button"
                size="sm"
                variant={recipientMode === 'all' ? 'default' : 'outline'}
                onClick={() => handleGroupSelect('all')}
                disabled={sending}
              >
                <Globe className="mr-1.5 h-3.5 w-3.5" />
                All
              </Button>
              <Button
                type="button"
                size="sm"
                variant={recipientMode === 'participants' ? 'default' : 'outline'}
                onClick={() => handleGroupSelect('participants')}
                disabled={sending}
              >
                <Users className="mr-1.5 h-3.5 w-3.5" />
                Participants
              </Button>
              <Button
                type="button"
                size="sm"
                variant={recipientMode === 'admins' ? 'default' : 'outline'}
                onClick={() => handleGroupSelect('admins')}
                disabled={sending}
              >
                <Shield className="mr-1.5 h-3.5 w-3.5" />
                Admins
              </Button>
              {recipientMode === 'custom' && (
                <Badge variant="secondary" className="self-center">
                  Custom
                </Badge>
              )}
            </div>

            {/* Selected user badges */}
            {selectedUsers.length > 0 && selectedUsers.length <= 20 && (
              <div className="flex flex-wrap gap-1.5 max-h-24 overflow-y-auto">
                {selectedUsers.map(user => (
                  <Badge
                    key={user.id}
                    variant="secondary"
                    className="flex items-center gap-1 pr-1"
                  >
                    <span className="truncate max-w-[150px]">{user.name}</span>
                    <button
                      type="button"
                      onClick={() => removeUser(user.id)}
                      className="ml-0.5 rounded-full p-0.5 hover:bg-gray-300/50"
                      disabled={sending}
                    >
                      <X className="h-3 w-3" />
                    </button>
                  </Badge>
                ))}
              </div>
            )}

            {selectedUsers.length > 20 && (
              <p className="text-sm text-muted-foreground">
                {selectedUsers.length} recipients selected
              </p>
            )}

            {selectedUsers.length === 0 && (
              <p className="text-sm text-destructive">
                No recipients selected
              </p>
            )}

            {/* Search to add individuals */}
            <div className="relative" ref={searchRef}>
              <div className="relative">
                <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
                <Input
                  placeholder="Search to add recipients..."
                  value={searchQuery}
                  onChange={e => {
                    setSearchQuery(e.target.value)
                    setSearchOpen(true)
                  }}
                  onFocus={() => { if (searchQuery) setSearchOpen(true) }}
                  className="pl-9"
                  disabled={sending}
                />
              </div>
              {searchOpen && searchResults.length > 0 && (
                <div className="absolute z-50 mt-1 w-full rounded-md border bg-popover shadow-lg max-h-40 overflow-y-auto">
                  {searchResults.map(user => (
                    <button
                      key={user.id}
                      type="button"
                      className="w-full text-left px-3 py-2 text-sm hover:bg-accent hover:text-accent-foreground"
                      onClick={() => addUser(user.id)}
                    >
                      <span className="font-medium">{user.name}</span>
                      <span className="ml-2 text-muted-foreground">{user.email}</span>
                    </button>
                  ))}
                </div>
              )}
            </div>
          </div>

          <div className="space-y-2">
            <Label htmlFor="subject">Subject</Label>
            <Input
              id="subject"
              value={subject}
              onChange={e => setSubject(e.target.value)}
              placeholder="Message subject"
              disabled={sending}
            />
          </div>

          <div className="space-y-2">
            <Label>Message</Label>
            <TiptapEditor
              content={content}
              onChange={setContent}
              placeholder="Write your message..."
            />
          </div>
        </div>

        <DialogFooter>
          <Button
            variant="outline"
            onClick={() => onOpenChange(false)}
            disabled={sending}
          >
            Cancel
          </Button>
          <Button onClick={handleSend} disabled={sending || selectedUserIds.size === 0}>
            {sending ? (
              <>
                <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                Sending...
              </>
            ) : (
              <>
                <Send className="mr-2 h-4 w-4" />
                Send &amp; Email
              </>
            )}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  )
}
