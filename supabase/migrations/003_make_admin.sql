-- Make a user an admin
-- Replace 'jon@scios.tech' with your actual email

UPDATE auth.users
SET raw_app_meta_data =
  COALESCE(raw_app_meta_data, '{}'::jsonb) ||
  jsonb_build_object('role', 'admin')
WHERE email = 'jon@scios.tech';

-- Note: After running this, the user needs to log out and log back in
-- for the new role to take effect in their JWT token