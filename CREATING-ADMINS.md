Step 1: Create an invite token for yourself

  INSERT INTO public.invite_tokens (
    email,
    token,
    expires_at,
    used,
    created_at
  )
  VALUES (
    'jon@scios.tech',
    'ADMIN-SETUP',
    now() + interval '1 hour',
    false,
    now()
  );

  Then go to: http://localhost:3000/signup?token=ADMIN-SETUP&email=jon@scios.tech

  Step 2: After you create your account, make yourself admin

  -- Update your user role in the auth metadata
  UPDATE auth.users
  SET raw_app_meta_data = jsonb_set(
    COALESCE(raw_app_meta_data, '{}'),
    '{role}',
    '"admin"'
  )
  WHERE email = 'jon@scios.tech';