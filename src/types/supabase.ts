export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type UserRole = 'applicant' | 'admin' | 'participant'

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "13.0.5"
  }
  public: {
    Tables: {
      admin_todo_comments: {
        Row: {
          author_id: string
          content: string
          created_at: string | null
          edited_at: string | null
          id: string
          todo_id: string
        }
        Insert: {
          author_id: string
          content: string
          created_at?: string | null
          edited_at?: string | null
          id?: string
          todo_id: string
        }
        Update: {
          author_id?: string
          content?: string
          created_at?: string | null
          edited_at?: string | null
          id?: string
          todo_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "admin_todo_comments_author_id_fkey"
            columns: ["author_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "admin_todo_comments_todo_id_fkey"
            columns: ["todo_id"]
            isOneToOne: false
            referencedRelation: "admin_todos"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "admin_todo_comments_todo_id_fkey"
            columns: ["todo_id"]
            isOneToOne: false
            referencedRelation: "admin_todos_with_users"
            referencedColumns: ["id"]
          },
        ]
      }
      admin_todos: {
        Row: {
          assigned_to: string | null
          completed_at: string | null
          completed_by: string | null
          created_at: string | null
          created_by: string
          description: string | null
          due_date: string | null
          id: string
          priority: Database["public"]["Enums"]["todo_priority"] | null
          status: Database["public"]["Enums"]["todo_status"] | null
          title: string
          updated_at: string | null
        }
        Insert: {
          assigned_to?: string | null
          completed_at?: string | null
          completed_by?: string | null
          created_at?: string | null
          created_by: string
          description?: string | null
          due_date?: string | null
          id?: string
          priority?: Database["public"]["Enums"]["todo_priority"] | null
          status?: Database["public"]["Enums"]["todo_status"] | null
          title: string
          updated_at?: string | null
        }
        Update: {
          assigned_to?: string | null
          completed_at?: string | null
          completed_by?: string | null
          created_at?: string | null
          created_by?: string
          description?: string | null
          due_date?: string | null
          id?: string
          priority?: Database["public"]["Enums"]["todo_priority"] | null
          status?: Database["public"]["Enums"]["todo_status"] | null
          title?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "admin_todos_assigned_to_fkey"
            columns: ["assigned_to"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "admin_todos_completed_by_fkey"
            columns: ["completed_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "admin_todos_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      application_comments: {
        Row: {
          application_id: string
          author_id: string
          content: string
          created_at: string | null
          deleted_at: string | null
          edited_at: string | null
          id: string
          is_internal: boolean | null
          parent_id: string | null
        }
        Insert: {
          application_id: string
          author_id: string
          content: string
          created_at?: string | null
          deleted_at?: string | null
          edited_at?: string | null
          id?: string
          is_internal?: boolean | null
          parent_id?: string | null
        }
        Update: {
          application_id?: string
          author_id?: string
          content?: string
          created_at?: string | null
          deleted_at?: string | null
          edited_at?: string | null
          id?: string
          is_internal?: boolean | null
          parent_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "application_comments_application_id_fkey"
            columns: ["application_id"]
            isOneToOne: false
            referencedRelation: "application_voting_summary"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "application_comments_application_id_fkey"
            columns: ["application_id"]
            isOneToOne: false
            referencedRelation: "applications"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "application_comments_author_id_fkey"
            columns: ["author_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "application_comments_parent_id_fkey"
            columns: ["parent_id"]
            isOneToOne: false
            referencedRelation: "application_comments"
            referencedColumns: ["id"]
          },
        ]
      }
      application_votes: {
        Row: {
          admin_id: string
          application_id: string
          comment: string | null
          created_at: string | null
          id: string
          updated_at: string | null
          vote: Database["public"]["Enums"]["vote_type"]
        }
        Insert: {
          admin_id: string
          application_id: string
          comment?: string | null
          created_at?: string | null
          id?: string
          updated_at?: string | null
          vote: Database["public"]["Enums"]["vote_type"]
        }
        Update: {
          admin_id?: string
          application_id?: string
          comment?: string | null
          created_at?: string | null
          id?: string
          updated_at?: string | null
          vote?: Database["public"]["Enums"]["vote_type"]
        }
        Relationships: [
          {
            foreignKeyName: "application_votes_admin_id_fkey"
            columns: ["admin_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "application_votes_application_id_fkey"
            columns: ["application_id"]
            isOneToOne: false
            referencedRelation: "application_voting_summary"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "application_votes_application_id_fkey"
            columns: ["application_id"]
            isOneToOne: false
            referencedRelation: "applications"
            referencedColumns: ["id"]
          },
        ]
      }
      applications: {
        Row: {
          abstain_votes: number | null
          admin_notes: string[] | null
          approve_votes: number | null
          email: string | null
          id: string
          name: string | null
          organization: string | null
          reject_votes: number | null
          reviewed_at: string | null
          reviewed_by: string | null
          role: string
          status: Database["public"]["Enums"]["application_status"]
          submitted_at: string | null
          total_votes: number | null
          updated_at: string | null
          user_id: string | null
          voting_completed: boolean | null
          voting_completed_at: string | null
          // Classification fields
          classifications: string[]
          classification_other: string | null
          // Universal questions (all applicants)
          importance_of_schema: string
          excited_projects: string
          work_links: Json
          workshop_contribution: string
          research_elements: string
          // Role-specific questions (conditional)
          researcher_use_case: string | null
          researcher_future_impact: string | null
          designer_ux_considerations: string | null
          engineer_working_on: string | null
          engineer_schema_considerations: string | null
          conceptionalist_unlock: string | null
          conceptionalist_enable: string | null
        }
        Insert: {
          abstain_votes?: number | null
          admin_notes?: string[] | null
          approve_votes?: number | null
          email?: string | null
          id?: string
          name?: string | null
          organization?: string | null
          reject_votes?: number | null
          reviewed_at?: string | null
          reviewed_by?: string | null
          role: string
          status?: Database["public"]["Enums"]["application_status"]
          submitted_at?: string | null
          total_votes?: number | null
          updated_at?: string | null
          user_id?: string | null
          voting_completed?: boolean | null
          voting_completed_at?: string | null
          // Classification fields
          classifications: string[]
          classification_other?: string | null
          // Universal questions (all applicants)
          importance_of_schema: string
          excited_projects: string
          work_links: Json
          workshop_contribution: string
          research_elements: string
          // Role-specific questions (conditional)
          researcher_use_case?: string | null
          researcher_future_impact?: string | null
          designer_ux_considerations?: string | null
          engineer_working_on?: string | null
          engineer_schema_considerations?: string | null
          conceptionalist_unlock?: string | null
          conceptionalist_enable?: string | null
        }
        Update: {
          abstain_votes?: number | null
          admin_notes?: string[] | null
          approve_votes?: number | null
          email?: string | null
          id?: string
          name?: string | null
          organization?: string | null
          reject_votes?: number | null
          reviewed_at?: string | null
          reviewed_by?: string | null
          role?: string
          status?: Database["public"]["Enums"]["application_status"]
          submitted_at?: string | null
          total_votes?: number | null
          updated_at?: string | null
          user_id?: string | null
          voting_completed?: boolean | null
          voting_completed_at?: string | null
          // Classification fields
          classifications?: string[]
          classification_other?: string | null
          // Universal questions (all applicants)
          importance_of_schema?: string
          excited_projects?: string
          work_links?: Json
          workshop_contribution?: string
          research_elements?: string
          // Role-specific questions (conditional)
          researcher_use_case?: string | null
          researcher_future_impact?: string | null
          designer_ux_considerations?: string | null
          engineer_working_on?: string | null
          engineer_schema_considerations?: string | null
          conceptionalist_unlock?: string | null
          conceptionalist_enable?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "applications_reviewed_by_fkey"
            columns: ["reviewed_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "applications_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      invite_tokens: {
        Row: {
          id: string
          email: string
          token: string
          application_id: string | null
          used: boolean
          used_at: string | null
          created_at: string | null
          expires_at: string | null
        }
        Insert: {
          id?: string
          email: string
          token: string
          application_id?: string | null
          used?: boolean
          used_at?: string | null
          created_at?: string | null
          expires_at?: string | null
        }
        Update: {
          id?: string
          email?: string
          token?: string
          application_id?: string | null
          used?: boolean
          used_at?: string | null
          created_at?: string | null
          expires_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "invite_tokens_application_id_fkey"
            columns: ["application_id"]
            isOneToOne: false
            referencedRelation: "applications"
            referencedColumns: ["id"]
          },
        ]
      }
      blog_posts: {
        Row: {
          author_id: string
          content: string
          created_at: string | null
          featured: boolean | null
          id: string
          published: boolean | null
          slug: string
          title: string
          updated_at: string | null
        }
        Insert: {
          author_id: string
          content: string
          created_at?: string | null
          featured?: boolean | null
          id?: string
          published?: boolean | null
          slug: string
          title: string
          updated_at?: string | null
        }
        Update: {
          author_id?: string
          content?: string
          created_at?: string | null
          featured?: boolean | null
          id?: string
          published?: boolean | null
          slug?: string
          title?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "blog_posts_author_id_fkey"
            columns: ["author_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      breakout_rooms: {
        Row: {
          active: boolean | null
          created_at: string | null
          description: string | null
          drive_folder_url: string | null
          id: string
          max_participants: number | null
          name: string
          updated_at: string | null
          whiteboard_url: string | null
        }
        Insert: {
          active?: boolean | null
          created_at?: string | null
          description?: string | null
          drive_folder_url?: string | null
          id?: string
          max_participants?: number | null
          name: string
          updated_at?: string | null
          whiteboard_url?: string | null
        }
        Update: {
          active?: boolean | null
          created_at?: string | null
          description?: string | null
          drive_folder_url?: string | null
          id?: string
          max_participants?: number | null
          name?: string
          updated_at?: string | null
          whiteboard_url?: string | null
        }
        Relationships: []
      }
      comments: {
        Row: {
          content: string
          created_at: string | null
          id: string
          parent_id: string | null
          target_id: string
          target_type: string
          updated_at: string | null
          user_id: string
        }
        Insert: {
          content: string
          created_at?: string | null
          id?: string
          parent_id?: string | null
          target_id: string
          target_type: string
          updated_at?: string | null
          user_id: string
        }
        Update: {
          content?: string
          created_at?: string | null
          id?: string
          parent_id?: string | null
          target_id?: string
          target_type?: string
          updated_at?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "comments_parent_id_fkey"
            columns: ["parent_id"]
            isOneToOne: false
            referencedRelation: "comments"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "comments_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      daily_reflections: {
        Row: {
          content: Json
          created_at: string | null
          id: string
          reflection_type: Database["public"]["Enums"]["reflection_type"]
          updated_at: string | null
          user_id: string
          workshop_day: number
        }
        Insert: {
          content: Json
          created_at?: string | null
          id?: string
          reflection_type: Database["public"]["Enums"]["reflection_type"]
          updated_at?: string | null
          user_id: string
          workshop_day: number
        }
        Update: {
          content?: Json
          created_at?: string | null
          id?: string
          reflection_type?: Database["public"]["Enums"]["reflection_type"]
          updated_at?: string | null
          user_id?: string
          workshop_day?: number
        }
        Relationships: [
          {
            foreignKeyName: "daily_reflections_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      photo_gallery: {
        Row: {
          caption: string | null
          created_at: string | null
          id: string
          image_url: string
          room_id: string | null
          tags: string[] | null
          user_id: string
          workshop_day: number | null
        }
        Insert: {
          caption?: string | null
          created_at?: string | null
          id?: string
          image_url: string
          room_id?: string | null
          tags?: string[] | null
          user_id: string
          workshop_day?: number | null
        }
        Update: {
          caption?: string | null
          created_at?: string | null
          id?: string
          image_url?: string
          room_id?: string | null
          tags?: string[] | null
          user_id?: string
          workshop_day?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "photo_gallery_room_id_fkey"
            columns: ["room_id"]
            isOneToOne: false
            referencedRelation: "breakout_rooms"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "photo_gallery_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      room_participants: {
        Row: {
          id: string
          joined_at: string | null
          room_id: string
          user_id: string
        }
        Insert: {
          id?: string
          joined_at?: string | null
          room_id: string
          user_id: string
        }
        Update: {
          id?: string
          joined_at?: string | null
          room_id?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "room_participants_room_id_fkey"
            columns: ["room_id"]
            isOneToOne: false
            referencedRelation: "breakout_rooms"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "room_participants_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      schema_iterations: {
        Row: {
          created_at: string | null
          created_by: string
          description: string | null
          id: string
          is_current: boolean | null
          schema_data: Json
          title: string
          version: string
        }
        Insert: {
          created_at?: string | null
          created_by: string
          description?: string | null
          id?: string
          is_current?: boolean | null
          schema_data: Json
          title: string
          version: string
        }
        Update: {
          created_at?: string | null
          created_by?: string
          description?: string | null
          id?: string
          is_current?: boolean | null
          schema_data?: Json
          title?: string
          version?: string
        }
        Relationships: [
          {
            foreignKeyName: "schema_iterations_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      tasks: {
        Row: {
          assignee_id: string | null
          created_at: string | null
          created_by: string
          description: string | null
          due_date: string | null
          id: string
          priority: Database["public"]["Enums"]["task_priority"] | null
          status: Database["public"]["Enums"]["task_status"]
          title: string
          updated_at: string | null
        }
        Insert: {
          assignee_id?: string | null
          created_at?: string | null
          created_by: string
          description?: string | null
          due_date?: string | null
          id?: string
          priority?: Database["public"]["Enums"]["task_priority"] | null
          status?: Database["public"]["Enums"]["task_status"]
          title: string
          updated_at?: string | null
        }
        Update: {
          assignee_id?: string | null
          created_at?: string | null
          created_by?: string
          description?: string | null
          due_date?: string | null
          id?: string
          priority?: Database["public"]["Enums"]["task_priority"] | null
          status?: Database["public"]["Enums"]["task_status"]
          title?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "tasks_assignee_id_fkey"
            columns: ["assignee_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "tasks_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      users: {
        Row: {
          created_at: string | null
          email: string
          id: string
          last_login: string | null
          name: string
          organization: string | null
          profile_image_url: string | null
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          email: string
          id: string
          last_login?: string | null
          name: string
          organization?: string | null
          profile_image_url?: string | null
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          email?: string
          id?: string
          last_login?: string | null
          name?: string
          organization?: string | null
          profile_image_url?: string | null
          updated_at?: string | null
        }
        Relationships: []
      }
      voting_config: {
        Row: {
          approval_threshold: number | null
          auto_approve_enabled: boolean | null
          auto_reject_enabled: boolean | null
          created_at: string | null
          id: string
          min_votes_required: number | null
          rejection_threshold: number | null
          updated_at: string | null
        }
        Insert: {
          approval_threshold?: number | null
          auto_approve_enabled?: boolean | null
          auto_reject_enabled?: boolean | null
          created_at?: string | null
          id?: string
          min_votes_required?: number | null
          rejection_threshold?: number | null
          updated_at?: string | null
        }
        Update: {
          approval_threshold?: number | null
          auto_approve_enabled?: boolean | null
          auto_reject_enabled?: boolean | null
          created_at?: string | null
          id?: string
          min_votes_required?: number | null
          rejection_threshold?: number | null
          updated_at?: string | null
        }
        Relationships: []
      }
    }
    Views: {
      admin_todos_with_users: {
        Row: {
          assigned_to: string | null
          assignee_email: string | null
          assignee_name: string | null
          comment_count: number | null
          completed_at: string | null
          completed_by: string | null
          completer_name: string | null
          created_at: string | null
          created_by: string | null
          creator_email: string | null
          creator_name: string | null
          description: string | null
          due_date: string | null
          id: string | null
          priority: Database["public"]["Enums"]["todo_priority"] | null
          status: Database["public"]["Enums"]["todo_status"] | null
          title: string | null
          updated_at: string | null
        }
        Relationships: [
          {
            foreignKeyName: "admin_todos_assigned_to_fkey"
            columns: ["assigned_to"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "admin_todos_completed_by_fkey"
            columns: ["completed_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "admin_todos_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      application_voting_summary: {
        Row: {
          abstain_votes: number | null
          approval_percentage: number | null
          approve_votes: number | null
          email: string | null
          id: string | null
          name: string | null
          reject_votes: number | null
          rejection_percentage: number | null
          status: Database["public"]["Enums"]["application_status"] | null
          total_votes: number | null
          votes: Json[] | null
          voting_completed: boolean | null
        }
        Relationships: []
      }
    }
    Functions: {
      auth_role: {
        Args: Record<PropertyKey, never>
        Returns: string
      }
      debug_jwt: {
        Args: Record<PropertyKey, never>
        Returns: Json
      }
      get_admin_users: {
        Args: Record<PropertyKey, never>
        Returns: {
          created_at: string
          email: string
          id: string
          name: string
          profile_image_url: string
        }[]
      }
      get_application_comments: {
        Args: { p_application_id: string }
        Returns: {
          application_id: string
          author_id: string
          author_name: string
          content: string
          created_at: string
          deleted_at: string
          depth: number
          edited_at: string
          id: string
          is_internal: boolean
          parent_id: string
        }[]
      }
      get_voting_statistics: {
        Args: Record<PropertyKey, never>
        Returns: {
          auto_approved: number
          auto_rejected: number
          average_votes_per_application: number
          completed_votes: number
          pending_votes: number
          total_applications: number
        }[]
      }
      is_admin: {
        Args: Record<PropertyKey, never>
        Returns: boolean
      }
      is_user_admin: {
        Args: { user_id: string }
        Returns: boolean
      }
      link_application_to_user: {
        Args: { p_email: string; p_user_id: string }
        Returns: boolean
      }
      validate_invite_token: {
        Args: { p_token: string; p_email: string }
        Returns: boolean
      }
      generate_invite_token: {
        Args: { p_application_id: string }
        Returns: string
      }
      check_invite_token: {
        Args: { p_token: string; p_email: string }
        Returns: boolean
      }
      mark_invite_token_used: {
        Args: { p_token: string; p_email: string }
        Returns: boolean
      }
    }
    Enums: {
      application_status: "pending" | "accepted" | "rejected" | "waitlisted"
      reflection_type: "personal" | "group" | "prototype"
      task_priority: "low" | "medium" | "high"
      task_status: "pending" | "in_progress" | "completed"
      todo_priority: "low" | "medium" | "high" | "urgent"
      todo_status: "pending" | "in_progress" | "completed" | "cancelled"
      vote_type: "approve" | "reject" | "abstain"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      application_status: ["pending", "accepted", "rejected", "waitlisted"],
      reflection_type: ["personal", "group", "prototype"],
      task_priority: ["low", "medium", "high"],
      task_status: ["pending", "in_progress", "completed"],
      todo_priority: ["low", "medium", "high", "urgent"],
      todo_status: ["pending", "in_progress", "completed", "cancelled"],
      vote_type: ["approve", "reject", "abstain"],
    },
  },
} as const
