Step 1: Create an invite token for yourself

  Run this in your Supabase Dashboard SQL Editor:
--

  INSERT INTO public.invite_tokens (
    email,
    token,
    expires_at,
    used,
    created_at
  )
  VALUES (
    'akamatsm@uw.edu',        -- CHANGE THIS: Use the new admin's email
    'ADMIN-SETUP-3',           -- CHANGE THIS: Use a unique token (e.g., ADMIN-SETUP-2, ADMIN-SETUP-3)
    now() + interval '48 hours',  -- Token expires in 48 hours (adjust as needed)
    false,
    now()
  );
  
--
  Then go to: https://mrna-nine.vercel.app/signup?token=ADMIN-SETUP-3&email=akamatsm@uw.edu
  -- CHANGE THE URL: Update both 'token=' and 'email=' parameters to match the values above
--

  Step 2: After you create your account, make yourself admin

  Run this in your Supabase Dashboard SQL Editor:

--
  -- Update your user role in the auth metadata
  UPDATE auth.users
  SET raw_app_meta_data = jsonb_set(
    COALESCE(raw_app_meta_data, '{}'),
    '{role}',
    '"admin"'
  )
  WHERE email = 'akamatsm@uw.edu';  -- CHANGE THIS: Use the same email from Step 1

  Step 3: Log out and log back in
--
  IMPORTANT: After running the SQL above, you must log out and log back in
  for the admin role to take effect (refreshes your JWT token).