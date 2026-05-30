'use client'

import { useEditor, EditorContent, type Editor } from '@tiptap/react'
import StarterKit from '@tiptap/starter-kit'
import Link from '@tiptap/extension-link'
import { TableKit } from '@tiptap/extension-table'
import { marked } from 'marked'
import { useCallback, useRef } from 'react'
import {
  Bold,
  Italic,
  Heading2,
  Heading3,
  List,
  ListOrdered,
  Link as LinkIcon,
  Quote,
} from 'lucide-react'
import { Button } from '@/components/ui/button'

interface TiptapEditorProps {
  content: string
  onChange: (html: string) => void
  placeholder?: string
}

// Detects whether pasted plain text is markdown so we can convert it to rich
// content. TipTap only converts inline marks (bold, links) on paste — block
// syntax like headings and lists needs this handler to render correctly.
function looksLikeMarkdown(text: string): boolean {
  return (
    /(^|\n)\s{0,3}#{1,6}\s/.test(text) ||   // headings
    /(^|\n)\s*[-*+]\s+/.test(text) ||        // bullet lists
    /(^|\n)\s*\d+\.\s+/.test(text) ||        // ordered lists
    /(^|\n)\s*>\s+/.test(text) ||            // blockquotes
    /(^|\n)\s*```/.test(text) ||             // code fences
    /\*\*[^*\n]+\*\*/.test(text) ||          // bold
    /\[[^\]]+\]\([^)\s]+\)/.test(text)       // links
  )
}

export function TiptapEditor({ content, onChange, placeholder }: TiptapEditorProps) {
  const editorRef = useRef<Editor | null>(null)

  const editor = useEditor({
    immediatelyRender: false,
    extensions: [
      StarterKit.configure({
        heading: {
          levels: [1, 2, 3, 4],
        },
      }),
      Link.configure({
        openOnClick: false,
        HTMLAttributes: {
          class: 'text-blue-600 underline',
        },
      }),
      TableKit.configure({
        table: { resizable: false },
      }),
    ],
    content,
    onCreate: ({ editor }) => {
      editorRef.current = editor
    },
    onUpdate: ({ editor }) => {
      onChange(editor.getHTML())
    },
    editorProps: {
      attributes: {
        class: 'prose prose-sm max-w-none min-h-[200px] p-3 focus:outline-none',
        ...(placeholder ? { 'data-placeholder': placeholder } : {}),
      },
      // Convert pasted markdown (headings, lists, etc.) into rich content.
      handlePaste: (_view, event) => {
        const clipboard = event.clipboardData
        if (!clipboard) return false

        // Let TipTap handle rich (HTML) pastes — e.g. copied from a web page.
        const html = clipboard.getData('text/html')
        if (html && html.trim()) return false

        const text = clipboard.getData('text/plain')
        if (!text || !looksLikeMarkdown(text)) return false

        const rendered = marked.parse(text, { gfm: true, breaks: true }) as string
        const ed = editorRef.current
        if (!ed) return false

        if (ed.isEmpty) {
          ed.commands.setContent(rendered)
        } else {
          ed.commands.insertContent(rendered)
        }
        return true
      },
    },
  })

  const setLink = useCallback(() => {
    if (!editor) return

    const previousUrl = editor.getAttributes('link').href
    const url = window.prompt('URL', previousUrl)

    if (url === null) return

    if (url === '') {
      editor.chain().focus().extendMarkRange('link').unsetLink().run()
      return
    }

    editor.chain().focus().extendMarkRange('link').setLink({ href: url }).run()
  }, [editor])

  if (!editor) return null

  return (
    <div className="border rounded-md">
      <div className="flex flex-wrap gap-1 border-b p-2 bg-gray-50">
        <Button
          type="button"
          variant={editor.isActive('bold') ? 'default' : 'ghost'}
          size="icon"
          className="h-8 w-8"
          onClick={() => editor.chain().focus().toggleBold().run()}
        >
          <Bold className="h-4 w-4" />
        </Button>
        <Button
          type="button"
          variant={editor.isActive('italic') ? 'default' : 'ghost'}
          size="icon"
          className="h-8 w-8"
          onClick={() => editor.chain().focus().toggleItalic().run()}
        >
          <Italic className="h-4 w-4" />
        </Button>
        <Button
          type="button"
          variant={editor.isActive('heading', { level: 2 }) ? 'default' : 'ghost'}
          size="icon"
          className="h-8 w-8"
          onClick={() => editor.chain().focus().toggleHeading({ level: 2 }).run()}
        >
          <Heading2 className="h-4 w-4" />
        </Button>
        <Button
          type="button"
          variant={editor.isActive('heading', { level: 3 }) ? 'default' : 'ghost'}
          size="icon"
          className="h-8 w-8"
          onClick={() => editor.chain().focus().toggleHeading({ level: 3 }).run()}
        >
          <Heading3 className="h-4 w-4" />
        </Button>
        <Button
          type="button"
          variant={editor.isActive('bulletList') ? 'default' : 'ghost'}
          size="icon"
          className="h-8 w-8"
          onClick={() => editor.chain().focus().toggleBulletList().run()}
        >
          <List className="h-4 w-4" />
        </Button>
        <Button
          type="button"
          variant={editor.isActive('orderedList') ? 'default' : 'ghost'}
          size="icon"
          className="h-8 w-8"
          onClick={() => editor.chain().focus().toggleOrderedList().run()}
        >
          <ListOrdered className="h-4 w-4" />
        </Button>
        <Button
          type="button"
          variant={editor.isActive('link') ? 'default' : 'ghost'}
          size="icon"
          className="h-8 w-8"
          onClick={setLink}
        >
          <LinkIcon className="h-4 w-4" />
        </Button>
        <Button
          type="button"
          variant={editor.isActive('blockquote') ? 'default' : 'ghost'}
          size="icon"
          className="h-8 w-8"
          onClick={() => editor.chain().focus().toggleBlockquote().run()}
        >
          <Quote className="h-4 w-4" />
        </Button>
      </div>
      <EditorContent editor={editor} />
    </div>
  )
}
