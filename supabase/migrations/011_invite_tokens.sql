-- Create invite_tokens table for managing participant invitations
CREATE TABLE IF NOT EXISTS public.invite_tokens (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    application_id UUID REFERENCES public.applications(id) ON DELETE CASCADE,
    used BOOLEAN DEFAULT FALSE,
    used_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    expires_at TIMESTAMP WITH TIME ZONE DEFAULT (NOW() + INTERVAL '30 days')
);

-- Add indexes
CREATE INDEX idx_invite_tokens_token ON public.invite_tokens(token);
CREATE INDEX idx_invite_tokens_email ON public.invite_tokens(email);
CREATE INDEX idx_invite_tokens_application_id ON public.invite_tokens(application_id);

-- Enable RLS
ALTER TABLE public.invite_tokens ENABLE ROW LEVEL SECURITY;

-- RLS Policies
-- Only admins can view invite tokens
CREATE POLICY "Admins can view all invite tokens"
ON public.invite_tokens FOR SELECT
TO authenticated
USING (is_admin());

-- Only admins can create invite tokens
CREATE POLICY "Admins can create invite tokens"
ON public.invite_tokens FOR INSERT
TO authenticated
WITH CHECK (is_admin());

-- Only admins can update invite tokens
CREATE POLICY "Admins can update invite tokens"
ON public.invite_tokens FOR UPDATE
TO authenticated
USING (is_admin())
WITH CHECK (is_admin());

-- Public can check if a token exists (for signup validation)
CREATE POLICY "Public can validate tokens"
ON public.invite_tokens FOR SELECT
TO anon
USING (
    NOT used
    AND expires_at > NOW()
);

-- Function to validate and use an invite token
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
    END IF;

    RETURN v_valid;
END;
$$;

-- Function to generate invite token for accepted applicant
CREATE OR REPLACE FUNCTION generate_invite_token(
    p_application_id UUID
)
RETURNS VARCHAR
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_email VARCHAR;
    v_token VARCHAR;
    v_status VARCHAR;
BEGIN
    -- Get application details
    SELECT email, status
    INTO v_email, v_status
    FROM public.applications
    WHERE id = p_application_id;

    -- Check if application exists and is accepted
    IF v_email IS NULL THEN
        RAISE EXCEPTION 'Application not found';
    END IF;

    IF v_status != 'accepted' THEN
        RAISE EXCEPTION 'Application must be accepted to generate invite token';
    END IF;

    -- Check if token already exists for this application
    SELECT token INTO v_token
    FROM public.invite_tokens
    WHERE application_id = p_application_id
    AND NOT used;

    -- If no unused token exists, create new one
    IF v_token IS NULL THEN
        -- Generate random token
        v_token := encode(gen_random_bytes(32), 'hex');

        -- Insert token
        INSERT INTO public.invite_tokens (
            email,
            token,
            application_id
        ) VALUES (
            v_email,
            v_token,
            p_application_id
        );
    END IF;

    RETURN v_token;
END;
$$;

-- Add function to automatically set user role to participant on signup with valid token
CREATE OR REPLACE FUNCTION set_participant_role()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    -- Update the user's app_metadata to set role as participant
    UPDATE auth.users
    SET raw_app_meta_data = jsonb_set(
        COALESCE(raw_app_meta_data, '{}'::jsonb),
        '{role}',
        '"participant"'
    )
    WHERE id = NEW.id;

    RETURN NEW;
END;
$$;

-- Create trigger to set participant role when user signs up with valid invite
-- We'll handle this in the signup logic instead to ensure token validation