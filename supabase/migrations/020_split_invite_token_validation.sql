-- Read-only check: does not mark token as used
CREATE OR REPLACE FUNCTION check_invite_token(
    p_token VARCHAR,
    p_email VARCHAR
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    RETURN EXISTS(
        SELECT 1
        FROM public.invite_tokens
        WHERE token = p_token
        AND email = p_email
        AND NOT used
        AND expires_at > NOW()
    );
END;
$$;

-- Mark token as used (call only after signup succeeds)
CREATE OR REPLACE FUNCTION mark_invite_token_used(
    p_token VARCHAR,
    p_email VARCHAR
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_found BOOLEAN;
BEGIN
    UPDATE public.invite_tokens
    SET used = TRUE,
        used_at = NOW()
    WHERE token = p_token
    AND email = p_email
    AND NOT used
    AND expires_at > NOW();

    v_found := FOUND;

    IF v_found THEN
        UPDATE auth.users
        SET raw_app_meta_data = jsonb_set(
            COALESCE(raw_app_meta_data, '{}'),
            '{role}',
            '"participant"'
        )
        WHERE email = p_email;
    END IF;

    RETURN v_found;
END;
$$;