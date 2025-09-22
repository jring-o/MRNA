# Supabase Database Setup

## Migration Files

Run these files in order in your Supabase SQL Editor:
1. `001_initial_schema.sql` - Creates all tables
2. `002_rls_policies.sql` - Sets up RLS policies
3. `003_make_admin.sql` - Makes you an admin (after signup)

## How Roles Work

In this setup, user roles (`admin`, `participant`, `applicant`) are stored in `auth.users.raw_app_meta_data.role` instead of a separate column. This is more secure because:

1. Users cannot modify their own `app_metadata`
2. The role is included in the JWT token automatically
3. RLS policies can check roles efficiently using `auth.jwt()`

## Setup Instructions

1. Go to your [Supabase SQL Editor](https://supabase.com/dashboard/project/mjvqmvugakhyxyviefrg/sql/new)
2. Run each migration file in order
3. Sign up for an account on your website
4. Run `003_seed_admin_fixed.sql` with your email to become admin
5. Log out and log back in to refresh your JWT token with the new role

## Key Functions

The migrations create these helper functions:

- `public.auth_role()` - Returns current user's role from JWT
- `public.is_admin()` - Checks if current user is admin
- `public.is_user_admin(user_id)` - Checks if specific user is admin

## Testing

After running migrations, test that:
1. Tables are created: Check the Table Editor
2. RLS is enabled: Try to query without auth (should fail)
3. Admin role works: After setting your role, check if you can access admin-only data