-- Update validate_invite_token to set participant role in app_metadata
CREATE OR REPLACE FUNCTION validate_invite_token(
    p_token VARCHAR,
    p_email VARCHAR
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_valid BOOLEAN;
BEGIN
    -- Check if token exists, matches email, is not used, and not expired
    SELECT EXISTS(
        SELECT 1
        FROM public.invite_tokens
        WHERE token = p_token
        AND email = p_email
        AND NOT used
        AND expires_at > NOW()
    ) INTO v_valid;

    -- If valid, mark as used
    IF v_valid THEN
        UPDATE public.invite_tokens
        SET used = TRUE,
            used_at = NOW()
        WHERE token = p_token;

        -- Set participant role for any user with this email
        UPDATE auth.users
        SET raw_app_meta_data = jsonb_set(
            COALESCE(raw_app_meta_data, '{}'),
            '{role}',
            '"participant"'
        )
        WHERE email = p_email;
    END IF;

    RETURN v_valid;
END;
$$;

-- Also create a trigger to automatically set participant role when user signs up
CREATE OR REPLACE FUNCTION auto_set_participant_role()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    -- Check if user has a used invite token
    IF EXISTS (
        SELECT 1
        FROM public.invite_tokens
        WHERE email = NEW.email
        AND used = TRUE
    ) THEN
        -- Set participant role in app_metadata
        UPDATE auth.users
        SET raw_app_meta_data = jsonb_set(
            COALESCE(raw_app_meta_data, '{}'),
            '{role}',
            '"participant"'
        )
        WHERE id = NEW.id;
    END IF;

    RETURN NEW;
END;
$$;

-- Create trigger to run after user creation
DROP TRIGGER IF EXISTS set_participant_role_on_signup ON auth.users;
CREATE TRIGGER set_participant_role_on_signup
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION auto_set_participant_role();