'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Textarea } from '@/components/ui/textarea'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from '@/components/ui/dialog'
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { toast } from 'sonner'
import {
  Plus,
  CheckCircle,
  Circle,
  Clock,
  AlertCircle,
  Calendar,
  User,
  MessageSquare,
  Edit,
  Trash2,
  ChevronRight,
  ChevronDown,
  Flag,
  X,
} from 'lucide-react'

interface TodoWithUsers {
  id: string
  title: string
  description: string | null
  status: 'pending' | 'in_progress' | 'completed' | 'cancelled'
  priority: 'low' | 'medium' | 'high' | 'urgent'
  assigned_to: string | null
  created_by: string
  due_date: string | null
  completed_at: string | null
  completed_by: string | null
  created_at: string
  updated_at: string
  creator_name: string
  creator_email: string
  assignee_name: string | null
  assignee_email: string | null
  completer_name: string | null
  comment_count: number
}

interface TodoComment {
  id: string
  todo_id: string
  author_id: string
  content: string
  created_at: string | null
  edited_at: string | null
  author?: {
    name: string
    email: string
  }
}

interface Admin {
  id: string
  name: string
  email: string
}

interface AdminTodoListProps {
  initialTodos: TodoWithUsers[]
  admins: Admin[]
  currentUserId: string
}

export function AdminTodoList({ initialTodos, admins, currentUserId }: AdminTodoListProps) {
  const [todos, setTodos] = useState<TodoWithUsers[]>(initialTodos)
  const [filteredTodos, setFilteredTodos] = useState<TodoWithUsers[]>(initialTodos)
  const [isAddingTodo, setIsAddingTodo] = useState(false)
  const [editingTodo, setEditingTodo] = useState<string | null>(null)
  const [expandedTodos, setExpandedTodos] = useState<Set<string>>(new Set())
  const [todoComments, setTodoComments] = useState<Record<string, TodoComment[]>>({})
  const [activeFilter, setActiveFilter] = useState<'all' | 'my_todos' | 'assigned_to_me'>('all')
  const [statusFilter, setStatusFilter] = useState<string>('all')
  const [priorityFilter, setPriorityFilter] = useState<string>('all')

  // New todo form state
  const [newTodo, setNewTodo] = useState<{
    title: string
    description: string
    priority: 'low' | 'medium' | 'high' | 'urgent'
    assigned_to: string
    due_date: string
  }>({
    title: '',
    description: '',
    priority: 'medium',
    assigned_to: '',
    due_date: '',
  })

  // Edit todo form state
  const [editForm, setEditForm] = useState<Partial<TodoWithUsers>>({})

  const supabase = createClient()

  useEffect(() => {
    // Subscribe to real-time updates for todos
    const todosChannel = supabase
      .channel('admin_todos_changes')
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'admin_todos' },
        () => {
          loadTodos()
        }
      )
      .subscribe()

    // Subscribe to real-time updates for comments
    const commentsChannel = supabase
      .channel('admin_todo_comments_changes')
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'admin_todo_comments' },
        () => {
          // Reload comments for expanded todos
          expandedTodos.forEach(todoId => loadComments(todoId))
        }
      )
      .subscribe()

    return () => {
      supabase.removeChannel(todosChannel)
      supabase.removeChannel(commentsChannel)
    }
  }, [expandedTodos])

  useEffect(() => {
    applyFilters()
  }, [todos, activeFilter, statusFilter, priorityFilter])

  const loadTodos = async () => {
    const { data: todosData } = await supabase
      .from('admin_todos_with_users')
      .select('*')
      .order('created_at', { ascending: false })

    if (todosData) {
      // Filter and transform todos to ensure required fields are not null
      const validTodos = todosData.filter(todo =>
        todo.id &&
        todo.title &&
        todo.status &&
        todo.priority &&
        todo.created_by &&
        todo.created_at &&
        todo.updated_at &&
        todo.creator_name &&
        todo.creator_email
      ).map(todo => ({
        ...todo,
        id: todo.id!,
        title: todo.title!,
        status: todo.status!,
        priority: todo.priority!,
        created_by: todo.created_by!,
        created_at: todo.created_at!,
        updated_at: todo.updated_at!,
        creator_name: todo.creator_name!,
        creator_email: todo.creator_email!,
        comment_count: todo.comment_count || 0
      }))
      setTodos(validTodos as TodoWithUsers[])
    }
  }

  const loadComments = async (todoId: string) => {
    const { data } = await supabase
      .from('admin_todo_comments')
      .select(`
        *,
        author:users!author_id(name, email)
      `)
      .eq('todo_id', todoId)
      .order('created_at', { ascending: true })

    if (data) {
      setTodoComments(prev => ({ ...prev, [todoId]: data }))
    }
  }

  const applyFilters = () => {
    let filtered = [...todos]

    // Apply main filter
    if (activeFilter === 'my_todos') {
      filtered = filtered.filter(todo => todo.created_by === currentUserId)
    } else if (activeFilter === 'assigned_to_me') {
      filtered = filtered.filter(todo => todo.assigned_to === currentUserId)
    }

    // Apply status filter
    if (statusFilter !== 'all') {
      filtered = filtered.filter(todo => todo.status === statusFilter)
    }

    // Apply priority filter
    if (priorityFilter !== 'all') {
      filtered = filtered.filter(todo => todo.priority === priorityFilter)
    }

    // Sort by priority and due date
    filtered.sort((a, b) => {
      // Urgent items first
      const priorityOrder = { urgent: 0, high: 1, medium: 2, low: 3 }
      const priorityDiff = priorityOrder[a.priority] - priorityOrder[b.priority]
      if (priorityDiff !== 0) return priorityDiff

      // Then by due date (earliest first)
      if (a.due_date && b.due_date) {
        return new Date(a.due_date).getTime() - new Date(b.due_date).getTime()
      }
      if (a.due_date) return -1
      if (b.due_date) return 1

      // Finally by creation date (newest first)
      return new Date(b.created_at).getTime() - new Date(a.created_at).getTime()
    })

    setFilteredTodos(filtered)
  }

  const createTodo = async () => {
    if (!newTodo.title.trim()) {
      toast.error('Title is required')
      return
    }

    try {
      const { error } = await supabase
        .from('admin_todos')
        .insert({
          title: newTodo.title.trim(),
          description: newTodo.description.trim() || null,
          priority: newTodo.priority,
          assigned_to: newTodo.assigned_to || null,
          due_date: newTodo.due_date || null,
          created_by: currentUserId,
        })

      if (error) throw error

      toast.success('Todo created')
      setNewTodo({ title: '', description: '', priority: 'medium', assigned_to: '', due_date: '' })
      setIsAddingTodo(false)

      // Immediately refresh the todos list
      await loadTodos()
    } catch (error) {
      console.error('Error creating todo:', error)
      toast.error('Failed to create todo')
    }
  }

  const updateTodo = async (todoId: string) => {
    try {
      const { error } = await supabase
        .from('admin_todos')
        .update(editForm)
        .eq('id', todoId)

      if (error) throw error

      toast.success('Todo updated')
      setEditingTodo(null)
      setEditForm({})

      // Immediately refresh the todos list
      await loadTodos()
    } catch (error) {
      console.error('Error updating todo:', error)
      toast.error('Failed to update todo')
    }
  }

  const toggleTodoStatus = async (todo: TodoWithUsers) => {
    const newStatus = todo.status === 'completed' ? 'pending' : 'completed'

    try {
      const { error } = await supabase
        .from('admin_todos')
        .update({ status: newStatus })
        .eq('id', todo.id)

      if (error) throw error

      toast.success(newStatus === 'completed' ? 'Todo completed!' : 'Todo reopened')

      // Immediately refresh the todos list
      await loadTodos()
    } catch (error) {
      console.error('Error updating todo status:', error)
      toast.error('Failed to update status')
    }
  }

  const deleteTodo = async (todoId: string) => {
    if (!confirm('Are you sure you want to delete this todo?')) return

    try {
      const { error } = await supabase
        .from('admin_todos')
        .delete()
        .eq('id', todoId)

      if (error) throw error

      toast.success('Todo deleted')

      // Immediately refresh the todos list
      await loadTodos()
    } catch (error) {
      console.error('Error deleting todo:', error)
      toast.error('Failed to delete todo')
    }
  }

  const addComment = async (todoId: string, content: string) => {
    if (!content.trim()) return

    try {
      const { error } = await supabase
        .from('admin_todo_comments')
        .insert({
          todo_id: todoId,
          author_id: currentUserId,
          content: content.trim(),
        })

      if (error) throw error

      toast.success('Comment added')
      loadComments(todoId)
    } catch (error) {
      console.error('Error adding comment:', error)
      toast.error('Failed to add comment')
    }
  }

  const toggleExpanded = (todoId: string) => {
    const newExpanded = new Set(expandedTodos)
    if (newExpanded.has(todoId)) {
      newExpanded.delete(todoId)
    } else {
      newExpanded.add(todoId)
      loadComments(todoId)
    }
    setExpandedTodos(newExpanded)
  }

  const getPriorityIcon = (priority: string) => {
    if (priority === 'urgent') return <AlertCircle className="h-4 w-4 text-red-500" />
    if (priority === 'high') return <Flag className="h-4 w-4 text-orange-500" />
    if (priority === 'medium') return <Flag className="h-4 w-4 text-yellow-500" />
    return <Flag className="h-4 w-4 text-gray-400" />
  }

  const getStatusIcon = (status: string) => {
    if (status === 'completed') return <CheckCircle className="h-5 w-5 text-green-500" />
    if (status === 'in_progress') return <Clock className="h-5 w-5 text-blue-500" />
    if (status === 'cancelled') return <X className="h-5 w-5 text-gray-500" />
    return <Circle className="h-5 w-5 text-gray-400" />
  }

  const renderTodo = (todo: TodoWithUsers) => {
    const isExpanded = expandedTodos.has(todo.id)
    const isEditing = editingTodo === todo.id
    const comments = todoComments[todo.id] || []

    return (
      <Card key={todo.id} className={todo.status === 'completed' ? 'opacity-75' : ''}>
        <CardContent className="p-4">
          {/* Todo Header */}
          <div className="flex items-start justify-between">
            <div className="flex items-start space-x-3 flex-1">
              <button
                onClick={() => toggleTodoStatus(todo)}
                className="mt-0.5"
              >
                {getStatusIcon(todo.status)}
              </button>

              <div className="flex-1">
                {isEditing ? (
                  <div className="space-y-3">
                    <Input
                      value={editForm.title || todo.title}
                      onChange={(e) => setEditForm({ ...editForm, title: e.target.value })}
                      placeholder="Todo title"
                    />
                    <Textarea
                      value={editForm.description || todo.description || ''}
                      onChange={(e) => setEditForm({ ...editForm, description: e.target.value })}
                      placeholder="Description"
                      rows={2}
                    />
                    <div className="grid grid-cols-3 gap-2">
                      <Select
                        value={editForm.priority || todo.priority}
                        onValueChange={(value) => setEditForm({ ...editForm, priority: value as 'low' | 'medium' | 'high' | 'urgent' })}
                      >
                        <SelectTrigger>
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="low">Low</SelectItem>
                          <SelectItem value="medium">Medium</SelectItem>
                          <SelectItem value="high">High</SelectItem>
                          <SelectItem value="urgent">Urgent</SelectItem>
                        </SelectContent>
                      </Select>
                      <Select
                        value={editForm.assigned_to || todo.assigned_to || 'unassigned'}
                        onValueChange={(value) => setEditForm({ ...editForm, assigned_to: value === 'unassigned' ? null : value })}
                      >
                        <SelectTrigger>
                          <SelectValue placeholder="Unassigned" />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="unassigned">Unassigned</SelectItem>
                          {admins.map(admin => (
                            <SelectItem key={admin.id} value={admin.id}>
                              {admin.name}
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                      <Input
                        type="date"
                        value={editForm.due_date || todo.due_date || ''}
                        onChange={(e) => setEditForm({ ...editForm, due_date: e.target.value || null })}
                      />
                    </div>
                    <div className="flex gap-2">
                      <Button size="sm" onClick={() => updateTodo(todo.id)}>
                        Save
                      </Button>
                      <Button
                        size="sm"
                        variant="outline"
                        onClick={() => {
                          setEditingTodo(null)
                          setEditForm({})
                        }}
                      >
                        Cancel
                      </Button>
                    </div>
                  </div>
                ) : (
                  <>
                    <div className="flex items-center gap-2">
                      <h3 className={`font-medium ${todo.status === 'completed' ? 'line-through' : ''}`}>
                        {todo.title}
                      </h3>
                      {getPriorityIcon(todo.priority)}
                    </div>
                    {todo.description && (
                      <p className="text-sm text-gray-600 mt-1">{todo.description}</p>
                    )}
                    <div className="flex items-center gap-4 mt-2 text-xs text-gray-500">
                      <span>Created by {todo.creator_name}</span>
                      {todo.assignee_name && (
                        <span className="flex items-center gap-1">
                          <User className="h-3 w-3" />
                          {todo.assignee_name}
                        </span>
                      )}
                      {todo.due_date && (
                        <span className="flex items-center gap-1">
                          <Calendar className="h-3 w-3" />
                          {new Date(todo.due_date).toLocaleDateString()}
                        </span>
                      )}
                      {comments.length > 0 && (
                        <span className="flex items-center gap-1">
                          <MessageSquare className="h-3 w-3" />
                          {comments.length}
                        </span>
                      )}
                    </div>
                  </>
                )}
              </div>
            </div>

            {!isEditing && (
              <div className="flex items-center gap-2">
                <button
                  onClick={() => toggleExpanded(todo.id)}
                  className="text-gray-500 hover:text-gray-700"
                >
                  {isExpanded ? <ChevronDown className="h-4 w-4" /> : <ChevronRight className="h-4 w-4" />}
                </button>
                <button
                  onClick={() => {
                    setEditingTodo(todo.id)
                    setEditForm({
                      title: todo.title,
                      description: todo.description,
                      priority: todo.priority,
                      assigned_to: todo.assigned_to,
                      due_date: todo.due_date,
                    })
                  }}
                  className="text-gray-500 hover:text-gray-700"
                >
                  <Edit className="h-4 w-4" />
                </button>
                <button
                  onClick={() => deleteTodo(todo.id)}
                  className="text-gray-500 hover:text-red-600"
                >
                  <Trash2 className="h-4 w-4" />
                </button>
              </div>
            )}
          </div>

          {/* Expanded Section with Comments */}
          {isExpanded && (
            <div className="mt-4 pt-4 border-t">
              <div className="space-y-3">
                {comments.map(comment => (
                  <div key={comment.id} className="flex items-start gap-2">
                    <div className="w-2 h-2 rounded-full bg-gray-400 mt-1.5" />
                    <div className="flex-1">
                      <div className="text-sm">
                        <span className="font-medium">{comment.author?.name}</span>
                        <span className="text-gray-500 ml-2">
                          {comment.created_at ? new Date(comment.created_at).toLocaleString() : 'Unknown date'}
                        </span>
                      </div>
                      <p className="text-sm text-gray-700 mt-0.5">{comment.content}</p>
                    </div>
                  </div>
                ))}
              </div>

              {/* Add Comment */}
              <div className="mt-3">
                <AddComment
                  onAdd={(content) => addComment(todo.id, content)}
                  placeholder="Add a comment..."
                />
              </div>
            </div>
          )}
        </CardContent>
      </Card>
    )
  }

  return (
    <div>
      {/* Header */}
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Admin Todo List</h1>
        <p className="text-gray-600 mt-1">Internal task management for the admin team</p>
      </div>

      {/* Filters and Add Button */}
      <div className="mb-6 space-y-4">
        <div className="flex items-center justify-between">
          <Tabs value={activeFilter} onValueChange={(v) => setActiveFilter(v as 'all' | 'my_todos' | 'assigned_to_me')}>
            <TabsList>
              <TabsTrigger value="all">All Todos</TabsTrigger>
              <TabsTrigger value="my_todos">Created by Me</TabsTrigger>
              <TabsTrigger value="assigned_to_me">Assigned to Me</TabsTrigger>
            </TabsList>
          </Tabs>

          <Button onClick={() => setIsAddingTodo(true)}>
            <Plus className="mr-2 h-4 w-4" />
            Add Todo
          </Button>
        </div>

        <div className="flex gap-2">
          <Select value={statusFilter} onValueChange={setStatusFilter}>
            <SelectTrigger className="w-[150px]">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All Status</SelectItem>
              <SelectItem value="pending">Pending</SelectItem>
              <SelectItem value="in_progress">In Progress</SelectItem>
              <SelectItem value="completed">Completed</SelectItem>
              <SelectItem value="cancelled">Cancelled</SelectItem>
            </SelectContent>
          </Select>

          <Select value={priorityFilter} onValueChange={setPriorityFilter}>
            <SelectTrigger className="w-[150px]">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All Priority</SelectItem>
              <SelectItem value="urgent">Urgent</SelectItem>
              <SelectItem value="high">High</SelectItem>
              <SelectItem value="medium">Medium</SelectItem>
              <SelectItem value="low">Low</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>

      {/* Todo List */}
      <div className="space-y-3">
        {filteredTodos.map(todo => renderTodo(todo))}

        {filteredTodos.length === 0 && (
          <Card>
            <CardContent className="text-center py-12">
              <p className="text-gray-500">No todos found. Create your first todo!</p>
            </CardContent>
          </Card>
        )}
      </div>

      {/* Add Todo Dialog */}
      <Dialog open={isAddingTodo} onOpenChange={setIsAddingTodo}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Add New Todo</DialogTitle>
            <DialogDescription>
              Create a new task for the admin team to track.
            </DialogDescription>
          </DialogHeader>

          <div className="space-y-4">
            <div>
              <label className="text-sm font-medium">Title *</label>
              <Input
                value={newTodo.title}
                onChange={(e) => setNewTodo({ ...newTodo, title: e.target.value })}
                placeholder="Enter todo title"
              />
            </div>

            <div>
              <label className="text-sm font-medium">Description</label>
              <Textarea
                value={newTodo.description}
                onChange={(e) => setNewTodo({ ...newTodo, description: e.target.value })}
                placeholder="Add details..."
                rows={3}
              />
            </div>

            <div className="grid grid-cols-3 gap-4">
              <div>
                <label className="text-sm font-medium">Priority</label>
                <Select
                  value={newTodo.priority}
                  onValueChange={(value) => setNewTodo({ ...newTodo, priority: value as 'low' | 'medium' | 'high' | 'urgent' })}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="low">Low</SelectItem>
                    <SelectItem value="medium">Medium</SelectItem>
                    <SelectItem value="high">High</SelectItem>
                    <SelectItem value="urgent">Urgent</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div>
                <label className="text-sm font-medium">Assign To</label>
                <Select
                  value={newTodo.assigned_to || 'unassigned'}
                  onValueChange={(value) => setNewTodo({ ...newTodo, assigned_to: value === 'unassigned' ? '' : value })}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Unassigned" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="unassigned">Unassigned</SelectItem>
                    {admins.map(admin => (
                      <SelectItem key={admin.id} value={admin.id}>
                        {admin.name}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div>
                <label className="text-sm font-medium">Due Date</label>
                <Input
                  type="date"
                  value={newTodo.due_date}
                  onChange={(e) => setNewTodo({ ...newTodo, due_date: e.target.value })}
                />
              </div>
            </div>
          </div>

          <DialogFooter>
            <Button variant="outline" onClick={() => setIsAddingTodo(false)}>
              Cancel
            </Button>
            <Button onClick={createTodo}>
              Create Todo
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  )
}

// Simple comment input component
function AddComment({ onAdd, placeholder }: { onAdd: (content: string) => void; placeholder: string }) {
  const [comment, setComment] = useState('')

  const handleSubmit = () => {
    if (comment.trim()) {
      onAdd(comment)
      setComment('')
    }
  }

  return (
    <div className="flex gap-2">
      <Input
        value={comment}
        onChange={(e) => setComment(e.target.value)}
        placeholder={placeholder}
        onKeyPress={(e) => e.key === 'Enter' && handleSubmit()}
      />
      <Button size="sm" onClick={handleSubmit} disabled={!comment.trim()}>
        Add
      </Button>
    </div>
  )
}