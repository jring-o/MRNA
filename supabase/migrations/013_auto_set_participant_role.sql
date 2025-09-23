-- Function to automatically set participant role when user signs up with valid invite token
CREATE OR REPLACE FUNCTION handle_participant_signup()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_has_valid_token BOOLEAN;
BEGIN
    -- Check if user has a valid (used) invite token
    SELECT EXISTS(
        SELECT 1
        FROM public.invite_tokens
        WHERE email = NEW.email
        AND used = TRUE
        AND used_at IS NOT NULL
    ) INTO v_has_valid_token;

    -- If they have a valid token, set their role to participant
    IF v_has_valid_token THEN
        UPDATE auth.users
        SET raw_app_meta_data =
            COALESCE(raw_app_meta_data, '{}'::jsonb) ||
            jsonb_build_object('role', 'participant')
        WHERE id = NEW.id;
    END IF;

    RETURN NEW;
END;
$$;

-- Create trigger to run after user signup
DROP TRIGGER IF EXISTS on_auth_user_created_participant ON auth.users;
CREATE TRIGGER on_auth_user_created_participant
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION handle_participant_signup();

-- Also create a function to manually fix existing users who signed up with tokens
CREATE OR REPLACE FUNCTION fix_participant_roles()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    -- Update all users who have used invite tokens but don't have participant role
    UPDATE auth.users u
    SET raw_app_meta_data =
        COALESCE(raw_app_meta_data, '{}'::jsonb) ||
        jsonb_build_object('role', 'participant')
    WHERE EXISTS (
        SELECT 1
        FROM public.invite_tokens it
        WHERE it.email = u.email
        AND it.used = TRUE
    )
    AND (u.raw_app_meta_data->>'role' IS NULL
         OR u.raw_app_meta_data->>'role' != 'participant');
END;
$$;

-- Run the fix for any existing users
SELECT fix_participant_roles();