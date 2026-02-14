--
-- PostgreSQL database dump
--

\restrict MKYApoYD2MLMqHqnDStBgHa5RQflXYE6DOic0GzDzBJGVYi6BvtDOfY3HER1GED

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: application_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.application_status AS ENUM (
    'pending',
    'accepted',
    'rejected',
    'waitlisted'
);


ALTER TYPE public.application_status OWNER TO postgres;

--
-- Name: reflection_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.reflection_type AS ENUM (
    'personal',
    'group',
    'prototype'
);


ALTER TYPE public.reflection_type OWNER TO postgres;

--
-- Name: task_priority; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.task_priority AS ENUM (
    'low',
    'medium',
    'high'
);


ALTER TYPE public.task_priority OWNER TO postgres;

--
-- Name: task_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.task_status AS ENUM (
    'pending',
    'in_progress',
    'completed'
);


ALTER TYPE public.task_status OWNER TO postgres;

--
-- Name: todo_priority; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.todo_priority AS ENUM (
    'low',
    'medium',
    'high',
    'urgent'
);


ALTER TYPE public.todo_priority OWNER TO postgres;

--
-- Name: todo_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.todo_status AS ENUM (
    'pending',
    'in_progress',
    'completed',
    'cancelled'
);


ALTER TYPE public.todo_status OWNER TO postgres;

--
-- Name: vote_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.vote_type AS ENUM (
    'approve',
    'reject',
    'abstain'
);


ALTER TYPE public.vote_type OWNER TO postgres;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: auth_role(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.auth_role() RETURNS text
    LANGUAGE plpgsql STABLE SECURITY DEFINER
    AS $$
DECLARE
  jwt_claims jsonb;
  role_value text;
BEGIN
  -- Get the full JWT claims
  jwt_claims := auth.jwt();

  -- Return null if no JWT (not authenticated)
  IF jwt_claims IS NULL THEN
    RETURN 'applicant';
  END IF;

  -- Try multiple paths where the role might be stored
  -- Supabase stores custom claims in app_metadata
  role_value := COALESCE(
    jwt_claims->'app_metadata'->>'role',     -- Standard location in Supabase
    jwt_claims->'user_metadata'->>'role',    -- Sometimes in user_metadata
    jwt_claims->>'role',                      -- Direct claim (less common)
    'applicant'                               -- Default fallback
  );

  RETURN role_value;
END;
$$;


ALTER FUNCTION public.auth_role() OWNER TO postgres;

--
-- Name: auto_link_application_on_signup(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.auto_link_application_on_signup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  -- When a new user is created, check if they have an application
  IF NEW.email IS NOT NULL THEN
    -- Link any existing application to this user
    UPDATE public.applications
    SET user_id = NEW.id,
        updated_at = NOW()
    WHERE email = NEW.email
      AND user_id IS NULL;
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.auto_link_application_on_signup() OWNER TO postgres;

--
-- Name: auto_set_participant_role(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.auto_set_participant_role() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
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


ALTER FUNCTION public.auto_set_participant_role() OWNER TO postgres;

--
-- Name: check_auto_application_status(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_auto_application_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  config RECORD;
  approval_ratio DECIMAL(3,2);
  rejection_ratio DECIMAL(3,2);
BEGIN
  -- Get voting configuration
  SELECT * INTO config FROM public.voting_config LIMIT 1;

  -- Check if we have enough votes
  IF NEW.total_votes >= config.min_votes_required THEN
    -- Calculate ratios
    approval_ratio := CASE
      WHEN NEW.total_votes > 0 THEN NEW.approve_votes::DECIMAL / NEW.total_votes
      ELSE 0
    END;

    rejection_ratio := CASE
      WHEN NEW.total_votes > 0 THEN NEW.reject_votes::DECIMAL / NEW.total_votes
      ELSE 0
    END;

    -- Check for auto-approval
    IF config.auto_approve_enabled AND approval_ratio >= config.approval_threshold THEN
      NEW.status := 'accepted';
      NEW.voting_completed := true;
      NEW.voting_completed_at := NOW();
    -- Check for auto-rejection
    ELSIF config.auto_reject_enabled AND rejection_ratio >= config.rejection_threshold THEN
      NEW.status := 'rejected';
      NEW.voting_completed := true;
      NEW.voting_completed_at := NOW();
    END IF;
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_auto_application_status() OWNER TO postgres;

--
-- Name: check_invite_token(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_invite_token(p_token character varying, p_email character varying) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
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


ALTER FUNCTION public.check_invite_token(p_token character varying, p_email character varying) OWNER TO postgres;

--
-- Name: debug_jwt(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.debug_jwt() RETURNS jsonb
    LANGUAGE plpgsql STABLE SECURITY DEFINER
    AS $$
BEGIN
  RETURN jsonb_build_object(
    'jwt', auth.jwt(),
    'uid', auth.uid(),
    'email', auth.jwt()->>'email',
    'role_from_auth_role', public.auth_role(),
    'is_admin', public.is_admin(),
    'app_metadata', auth.jwt()->'app_metadata',
    'user_metadata', auth.jwt()->'user_metadata'
  );
END;
$$;


ALTER FUNCTION public.debug_jwt() OWNER TO postgres;

--
-- Name: generate_invite_token(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_invite_token(p_application_id uuid) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
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


ALTER FUNCTION public.generate_invite_token(p_application_id uuid) OWNER TO postgres;

--
-- Name: get_admin_users(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_admin_users() RETURNS TABLE(id uuid, name text, email text, profile_image_url text, created_at timestamp with time zone)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  -- Only allow admins to call this function
  IF NOT public.is_admin() THEN
    RAISE EXCEPTION 'Access denied. Admin role required.';
  END IF;

  RETURN QUERY
  SELECT
    u.id,
    u.name,
    u.email,
    u.profile_image_url,
    u.created_at
  FROM public.users u
  JOIN auth.users au ON u.id = au.id
  WHERE au.raw_app_meta_data->>'role' = 'admin'
  ORDER BY u.name;
END;
$$;


ALTER FUNCTION public.get_admin_users() OWNER TO postgres;

--
-- Name: get_application_comments(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_application_comments(p_application_id uuid) RETURNS TABLE(id uuid, application_id uuid, author_id uuid, author_name text, content text, parent_id uuid, is_internal boolean, created_at timestamp with time zone, edited_at timestamp with time zone, deleted_at timestamp with time zone, depth integer)
    LANGUAGE sql STABLE
    AS $$
WITH RECURSIVE comment_tree AS (
  -- Base case: top-level comments
  SELECT
    c.id,
    c.application_id,
    c.author_id,
    u.name as author_name,
    c.content,
    c.parent_id,
    c.is_internal,
    c.created_at,
    c.edited_at,
    c.deleted_at,
    0 as depth
  FROM public.application_comments c
  JOIN public.users u ON c.author_id = u.id
  WHERE c.application_id = p_application_id
    AND c.parent_id IS NULL

  UNION ALL

  -- Recursive case: replies
  SELECT
    c.id,
    c.application_id,
    c.author_id,
    u.name as author_name,
    c.content,
    c.parent_id,
    c.is_internal,
    c.created_at,
    c.edited_at,
    c.deleted_at,
    ct.depth + 1
  FROM public.application_comments c
  JOIN public.users u ON c.author_id = u.id
  JOIN comment_tree ct ON c.parent_id = ct.id
  WHERE c.application_id = p_application_id
)
SELECT * FROM comment_tree
ORDER BY created_at, depth;
$$;


ALTER FUNCTION public.get_application_comments(p_application_id uuid) OWNER TO postgres;

--
-- Name: get_voting_statistics(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_voting_statistics() RETURNS TABLE(total_applications integer, pending_votes integer, completed_votes integer, auto_approved integer, auto_rejected integer, average_votes_per_application numeric)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  -- Only allow admins to call this function
  IF NOT public.is_admin() THEN
    RAISE EXCEPTION 'Access denied. Admin role required.';
  END IF;

  RETURN QUERY
  SELECT
    COUNT(*)::INTEGER as total_applications,
    COUNT(*) FILTER (WHERE voting_completed = false)::INTEGER as pending_votes,
    COUNT(*) FILTER (WHERE voting_completed = true)::INTEGER as completed_votes,
    COUNT(*) FILTER (WHERE voting_completed = true AND status = 'accepted')::INTEGER as auto_approved,
    COUNT(*) FILTER (WHERE voting_completed = true AND status = 'rejected')::INTEGER as auto_rejected,
    ROUND(AVG(total_votes), 2) as average_votes_per_application
  FROM public.applications;
END;
$$;


ALTER FUNCTION public.get_voting_statistics() OWNER TO postgres;

--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  -- Create user profile
  INSERT INTO public.users (id, email, name)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1))
  );

  -- Set default role in app_metadata if not already set
  IF NEW.raw_app_meta_data->>'role' IS NULL THEN
    UPDATE auth.users
    SET raw_app_meta_data =
      COALESCE(raw_app_meta_data, '{}'::jsonb) ||
      jsonb_build_object('role', 'applicant')
    WHERE id = NEW.id;
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- Name: handle_todo_completion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_todo_completion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- If status is changing to completed
  IF NEW.status = 'completed' AND OLD.status != 'completed' THEN
    NEW.completed_at = NOW();
    NEW.completed_by = auth.uid();
  -- If status is changing from completed to something else
  ELSIF OLD.status = 'completed' AND NEW.status != 'completed' THEN
    NEW.completed_at = NULL;
    NEW.completed_by = NULL;
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.handle_todo_completion() OWNER TO postgres;

--
-- Name: is_admin(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_admin() RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  SELECT public.auth_role() = 'admin';
$$;


ALTER FUNCTION public.is_admin() OWNER TO postgres;

--
-- Name: is_user_admin(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_user_admin(user_id uuid) RETURNS boolean
    LANGUAGE sql STABLE SECURITY DEFINER
    AS $$
  SELECT (
    SELECT raw_app_meta_data->>'role'
    FROM auth.users
    WHERE id = user_id
  ) = 'admin';
$$;


ALTER FUNCTION public.is_user_admin(user_id uuid) OWNER TO postgres;

--
-- Name: link_application_to_user(text, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.link_application_to_user(p_email text, p_user_id uuid) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  -- Update the application to link it to the user
  UPDATE public.applications
  SET user_id = p_user_id,
      updated_at = NOW()
  WHERE email = p_email
    AND user_id IS NULL;  -- Only link if not already linked

  RETURN FOUND;
END;
$$;


ALTER FUNCTION public.link_application_to_user(p_email text, p_user_id uuid) OWNER TO postgres;

--
-- Name: mark_invite_token_used(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.mark_invite_token_used(p_token character varying, p_email character varying) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
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


ALTER FUNCTION public.mark_invite_token_used(p_token character varying, p_email character varying) OWNER TO postgres;

--
-- Name: set_participant_role(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_participant_role() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
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


ALTER FUNCTION public.set_participant_role() OWNER TO postgres;

--
-- Name: update_application_vote_counts(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_application_vote_counts() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Update vote counts on the applications table
  UPDATE public.applications
  SET
    total_votes = (
      SELECT COUNT(*)
      FROM public.application_votes
      WHERE application_id = COALESCE(NEW.application_id, OLD.application_id)
    ),
    approve_votes = (
      SELECT COUNT(*)
      FROM public.application_votes
      WHERE application_id = COALESCE(NEW.application_id, OLD.application_id)
        AND vote = 'approve'
    ),
    reject_votes = (
      SELECT COUNT(*)
      FROM public.application_votes
      WHERE application_id = COALESCE(NEW.application_id, OLD.application_id)
        AND vote = 'reject'
    ),
    abstain_votes = (
      SELECT COUNT(*)
      FROM public.application_votes
      WHERE application_id = COALESCE(NEW.application_id, OLD.application_id)
        AND vote = 'abstain'
    )
  WHERE id = COALESCE(NEW.application_id, OLD.application_id);

  RETURN COALESCE(NEW, OLD);
END;
$$;


ALTER FUNCTION public.update_application_vote_counts() OWNER TO postgres;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

--
-- Name: validate_invite_token(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validate_invite_token(p_token character varying, p_email character varying) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
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


ALTER FUNCTION public.validate_invite_token(p_token character varying, p_email character varying) OWNER TO postgres;

--
-- Name: validate_work_links(jsonb); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validate_work_links(links jsonb) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
  link JSONB;
BEGIN
  -- Check if it's an array
  IF jsonb_typeof(links) != 'array' THEN
    RETURN FALSE;
  END IF;

  -- Check array length
  IF jsonb_array_length(links) < 1 OR jsonb_array_length(links) > 5 THEN
    RETURN FALSE;
  END IF;

  -- Check each element has required fields: description, role
  -- URL is optional
  FOR link IN SELECT * FROM jsonb_array_elements(links)
  LOOP
    -- Must have description and role
    IF NOT (link ? 'description' AND link ? 'role') THEN
      RETURN FALSE;
    END IF;

    -- Check types are strings
    IF jsonb_typeof(link->'description') != 'string' OR jsonb_typeof(link->'role') != 'string' THEN
      RETURN FALSE;
    END IF;

    -- URL is optional, but if present must be a string
    IF link ? 'url' THEN
      IF jsonb_typeof(link->'url') != 'string' THEN
        RETURN FALSE;
      END IF;
    END IF;

    -- Description must be at least 1 character (not empty)
    IF length(link->>'description') < 1 THEN
      RETURN FALSE;
    END IF;

    -- Role must be at least 1 character (not empty)
    IF length(link->>'role') < 1 THEN
      RETURN FALSE;
    END IF;
  END LOOP;

  RETURN TRUE;
END;
$$;


ALTER FUNCTION public.validate_work_links(links jsonb) OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_
        -- Filter by action early - only get subscriptions interested in this action
        -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
        and (subs.action_filter = '*' or subs.action_filter = action::text);

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: delete_leaf_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$$;


ALTER FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


ALTER FUNCTION storage.get_level(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


ALTER FUNCTION storage.get_prefix(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


ALTER FUNCTION storage.get_prefixes(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: admin_todo_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_todo_comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    todo_id uuid NOT NULL,
    author_id uuid NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    edited_at timestamp with time zone
);


ALTER TABLE public.admin_todo_comments OWNER TO postgres;

--
-- Name: admin_todos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_todos (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    description text,
    status public.todo_status DEFAULT 'pending'::public.todo_status,
    priority public.todo_priority DEFAULT 'medium'::public.todo_priority,
    assigned_to uuid,
    created_by uuid NOT NULL,
    due_date date,
    completed_at timestamp with time zone,
    completed_by uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.admin_todos OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    email text NOT NULL,
    name text NOT NULL,
    organization text,
    profile_image_url text,
    created_at timestamp with time zone DEFAULT now(),
    last_login timestamp with time zone,
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: admin_todos_with_users; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.admin_todos_with_users WITH (security_invoker='true') AS
 SELECT t.id,
    t.title,
    t.description,
    t.status,
    t.priority,
    t.assigned_to,
    t.created_by,
    t.due_date,
    t.completed_at,
    t.completed_by,
    t.created_at,
    t.updated_at,
    creator.name AS creator_name,
    creator.email AS creator_email,
    assignee.name AS assignee_name,
    assignee.email AS assignee_email,
    completer.name AS completer_name,
    ( SELECT count(*) AS count
           FROM public.admin_todo_comments
          WHERE (admin_todo_comments.todo_id = t.id)) AS comment_count
   FROM (((public.admin_todos t
     LEFT JOIN public.users creator ON ((t.created_by = creator.id)))
     LEFT JOIN public.users assignee ON ((t.assigned_to = assignee.id)))
     LEFT JOIN public.users completer ON ((t.completed_by = completer.id)));


ALTER VIEW public.admin_todos_with_users OWNER TO postgres;

--
-- Name: VIEW admin_todos_with_users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.admin_todos_with_users IS 'View for admin todos with user details. Security: Uses SECURITY INVOKER so RLS on admin_todos (admin-only) is enforced. Non-admins will receive zero rows.';


--
-- Name: application_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.application_comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    application_id uuid NOT NULL,
    author_id uuid NOT NULL,
    content text NOT NULL,
    parent_id uuid,
    is_internal boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    edited_at timestamp with time zone,
    deleted_at timestamp with time zone,
    CONSTRAINT valid_parent CHECK ((parent_id <> id))
);


ALTER TABLE public.application_comments OWNER TO postgres;

--
-- Name: application_votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.application_votes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    application_id uuid NOT NULL,
    admin_id uuid NOT NULL,
    vote public.vote_type NOT NULL,
    comment text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.application_votes OWNER TO postgres;

--
-- Name: applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.applications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    status public.application_status DEFAULT 'pending'::public.application_status NOT NULL,
    role text NOT NULL,
    admin_notes text[],
    submitted_at timestamp with time zone DEFAULT now(),
    reviewed_at timestamp with time zone,
    reviewed_by uuid,
    updated_at timestamp with time zone DEFAULT now(),
    email text,
    name text,
    organization text,
    total_votes integer DEFAULT 0,
    approve_votes integer DEFAULT 0,
    reject_votes integer DEFAULT 0,
    abstain_votes integer DEFAULT 0,
    voting_completed boolean DEFAULT false,
    voting_completed_at timestamp with time zone,
    classifications text[] DEFAULT '{}'::text[] NOT NULL,
    classification_other text,
    importance_of_schema text NOT NULL,
    excited_projects text NOT NULL,
    work_links jsonb NOT NULL,
    workshop_contribution text NOT NULL,
    research_elements text NOT NULL,
    researcher_use_case text,
    researcher_future_impact text,
    designer_ux_considerations text,
    engineer_working_on text,
    engineer_schema_considerations text,
    landscape_specialist_current_work text,
    landscape_specialist_see_emerging text,
    CONSTRAINT applications_classification_other_check CHECK ((char_length(classification_other) <= 15)),
    CONSTRAINT check_at_least_one_classification CHECK ((array_length(classifications, 1) >= 1)),
    CONSTRAINT check_classification_other_when_other CHECK (((NOT ('other'::text = ANY (classifications))) OR ((classification_other IS NOT NULL) AND (char_length(classification_other) > 0)))),
    CONSTRAINT check_designer_questions CHECK (((NOT ('designer'::text = ANY (classifications))) OR (designer_ux_considerations IS NOT NULL))),
    CONSTRAINT check_engineer_questions CHECK (((NOT ('engineer'::text = ANY (classifications))) OR ((engineer_working_on IS NOT NULL) AND (engineer_schema_considerations IS NOT NULL)))),
    CONSTRAINT check_landscape_specialist_questions CHECK (((NOT ('landscape_specialist'::text = ANY (classifications))) OR ((landscape_specialist_current_work IS NOT NULL) AND (landscape_specialist_see_emerging IS NOT NULL)))),
    CONSTRAINT check_researcher_questions CHECK (((NOT ('researcher'::text = ANY (classifications))) OR ((researcher_use_case IS NOT NULL) AND (researcher_future_impact IS NOT NULL)))),
    CONSTRAINT check_work_links_structure CHECK (((jsonb_typeof(work_links) = 'array'::text) AND (jsonb_array_length(work_links) >= 1) AND (jsonb_array_length(work_links) <= 5) AND public.validate_work_links(work_links)))
);


ALTER TABLE public.applications OWNER TO postgres;

--
-- Name: COLUMN applications.classifications; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.classifications IS 'Array of selected classifications: researcher, engineer, designer, conceptionalist, other';


--
-- Name: COLUMN applications.classification_other; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.classification_other IS 'Custom classification text if "other" is selected (max 15 chars)';


--
-- Name: COLUMN applications.importance_of_schema; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.importance_of_schema IS 'Why is an interoperable Research attribution Schema important to you? (200 words)';


--
-- Name: COLUMN applications.excited_projects; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.excited_projects IS 'What other science/infrastructure/open science projects are you excited about? (200 words)';


--
-- Name: COLUMN applications.work_links; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.work_links IS 'Array of {description, role, url (optional)} objects for work examples (1-5 items)';


--
-- Name: COLUMN applications.workshop_contribution; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.workshop_contribution IS 'What would you add to this workshop if you came? (200 words)';


--
-- Name: COLUMN applications.research_elements; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.research_elements IS 'What elements or outputs of the research process would you define? (200 words)';


--
-- Name: COLUMN applications.researcher_use_case; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.researcher_use_case IS 'Researcher: Immediate use-case for modular research sharing/attribution (200 words)';


--
-- Name: COLUMN applications.researcher_future_impact; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.researcher_future_impact IS 'Researcher: Future impact of granular research sharing (200 words)';


--
-- Name: COLUMN applications.designer_ux_considerations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.designer_ux_considerations IS 'Designer: Important considerations for UX/design across platforms (200 words)';


--
-- Name: COLUMN applications.engineer_working_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.engineer_working_on IS 'Engineer: What are you working on that would use the schema - How? (200 words)';


--
-- Name: COLUMN applications.engineer_schema_considerations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.engineer_schema_considerations IS 'Engineer: Important considerations for designing shared schema (200 words)';


--
-- Name: COLUMN applications.landscape_specialist_current_work; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.landscape_specialist_current_work IS 'Landscape/Ecosystem Specialist: What research landscape(s) or ecosystem(s) are you currently working in or observing? (200 words)';


--
-- Name: COLUMN applications.landscape_specialist_see_emerging; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.applications.landscape_specialist_see_emerging IS 'Landscape/Ecosystem Specialist: What do you see emerging in research ecosystems that an interoperable attribution schema might support? (200 words)';


--
-- Name: application_voting_summary; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.application_voting_summary WITH (security_invoker='true') AS
 SELECT a.id,
    a.name,
    a.email,
    a.status,
    a.total_votes,
    a.approve_votes,
    a.reject_votes,
    a.abstain_votes,
    a.voting_completed,
        CASE
            WHEN (a.total_votes > 0) THEN round((((a.approve_votes)::numeric / (a.total_votes)::numeric) * (100)::numeric), 1)
            ELSE (0)::numeric
        END AS approval_percentage,
        CASE
            WHEN (a.total_votes > 0) THEN round((((a.reject_votes)::numeric / (a.total_votes)::numeric) * (100)::numeric), 1)
            ELSE (0)::numeric
        END AS rejection_percentage,
    COALESCE(array_agg(jsonb_build_object('admin_id', v.admin_id, 'admin_name', u.name, 'vote', v.vote, 'voted_at', v.created_at) ORDER BY v.created_at) FILTER (WHERE (v.id IS NOT NULL)), ARRAY[]::jsonb[]) AS votes
   FROM ((public.applications a
     LEFT JOIN public.application_votes v ON ((a.id = v.application_id)))
     LEFT JOIN public.users u ON ((v.admin_id = u.id)))
  GROUP BY a.id, a.name, a.email, a.status, a.total_votes, a.approve_votes, a.reject_votes, a.abstain_votes, a.voting_completed;


ALTER VIEW public.application_voting_summary OWNER TO postgres;

--
-- Name: VIEW application_voting_summary; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.application_voting_summary IS 'Voting summary for applications. Security: Uses SECURITY INVOKER so RLS on applications/votes tables is enforced.';


--
-- Name: blog_posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blog_posts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    author_id uuid NOT NULL,
    published boolean DEFAULT false,
    featured boolean DEFAULT false,
    slug text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.blog_posts OWNER TO postgres;

--
-- Name: breakout_rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.breakout_rooms (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text,
    drive_folder_url text,
    whiteboard_url text,
    max_participants integer DEFAULT 6,
    active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.breakout_rooms OWNER TO postgres;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    content text NOT NULL,
    target_type text NOT NULL,
    target_id uuid NOT NULL,
    parent_id uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT comments_target_type_check CHECK ((target_type = ANY (ARRAY['photo'::text, 'reflection'::text, 'task'::text, 'room'::text])))
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- Name: daily_reflections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.daily_reflections (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    workshop_day integer NOT NULL,
    reflection_type public.reflection_type NOT NULL,
    content jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT daily_reflections_workshop_day_check CHECK (((workshop_day >= 1) AND (workshop_day <= 4)))
);


ALTER TABLE public.daily_reflections OWNER TO postgres;

--
-- Name: invite_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invite_tokens (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    application_id uuid,
    used boolean DEFAULT false,
    used_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    expires_at timestamp with time zone DEFAULT (now() + '30 days'::interval)
);


ALTER TABLE public.invite_tokens OWNER TO postgres;

--
-- Name: photo_gallery; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.photo_gallery (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    image_url text NOT NULL,
    caption text,
    room_id uuid,
    tags text[],
    workshop_day integer,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT photo_gallery_workshop_day_check CHECK (((workshop_day >= 1) AND (workshop_day <= 4)))
);


ALTER TABLE public.photo_gallery OWNER TO postgres;

--
-- Name: room_participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room_participants (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    room_id uuid NOT NULL,
    user_id uuid NOT NULL,
    joined_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.room_participants OWNER TO postgres;

--
-- Name: schema_iterations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_iterations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    version text NOT NULL,
    title text NOT NULL,
    description text,
    schema_data jsonb NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    is_current boolean DEFAULT false
);


ALTER TABLE public.schema_iterations OWNER TO postgres;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    description text,
    assignee_id uuid,
    status public.task_status DEFAULT 'pending'::public.task_status NOT NULL,
    priority public.task_priority DEFAULT 'medium'::public.task_priority,
    due_date date,
    created_at timestamp with time zone DEFAULT now(),
    created_by uuid NOT NULL,
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: voting_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.voting_config (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    min_votes_required integer DEFAULT 3,
    approval_threshold numeric(3,2) DEFAULT 0.66,
    auto_approve_enabled boolean DEFAULT false,
    auto_reject_enabled boolean DEFAULT false,
    rejection_threshold numeric(3,2) DEFAULT 0.66,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.voting_config OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_02_02; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_02_02 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_02_02 OWNER TO supabase_admin;

--
-- Name: messages_2026_02_03; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_02_03 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_02_03 OWNER TO supabase_admin;

--
-- Name: messages_2026_02_04; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_02_04 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_02_04 OWNER TO supabase_admin;

--
-- Name: messages_2026_02_05; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_02_05 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_02_05 OWNER TO supabase_admin;

--
-- Name: messages_2026_02_06; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_02_06 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_02_06 OWNER TO supabase_admin;

--
-- Name: messages_2026_02_07; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_02_07 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_02_07 OWNER TO supabase_admin;

--
-- Name: messages_2026_02_08; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_02_08 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_02_08 OWNER TO supabase_admin;

--
-- Name: messages_2026_02_11; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_02_11 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_02_11 OWNER TO supabase_admin;

--
-- Name: messages_2026_02_12; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_02_12 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_02_12 OWNER TO supabase_admin;

--
-- Name: messages_2026_02_13; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_02_13 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_02_13 OWNER TO supabase_admin;

--
-- Name: messages_2026_02_14; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_02_14 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_02_14 OWNER TO supabase_admin;

--
-- Name: messages_2026_02_15; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_02_15 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_02_15 OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- Name: seed_files; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.seed_files (
    path text NOT NULL,
    hash text NOT NULL
);


ALTER TABLE supabase_migrations.seed_files OWNER TO postgres;

--
-- Name: messages_2026_02_02; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_02_02 FOR VALUES FROM ('2026-02-02 00:00:00') TO ('2026-02-03 00:00:00');


--
-- Name: messages_2026_02_03; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_02_03 FOR VALUES FROM ('2026-02-03 00:00:00') TO ('2026-02-04 00:00:00');


--
-- Name: messages_2026_02_04; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_02_04 FOR VALUES FROM ('2026-02-04 00:00:00') TO ('2026-02-05 00:00:00');


--
-- Name: messages_2026_02_05; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_02_05 FOR VALUES FROM ('2026-02-05 00:00:00') TO ('2026-02-06 00:00:00');


--
-- Name: messages_2026_02_06; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_02_06 FOR VALUES FROM ('2026-02-06 00:00:00') TO ('2026-02-07 00:00:00');


--
-- Name: messages_2026_02_07; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_02_07 FOR VALUES FROM ('2026-02-07 00:00:00') TO ('2026-02-08 00:00:00');


--
-- Name: messages_2026_02_08; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_02_08 FOR VALUES FROM ('2026-02-08 00:00:00') TO ('2026-02-09 00:00:00');


--
-- Name: messages_2026_02_11; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_02_11 FOR VALUES FROM ('2026-02-11 00:00:00') TO ('2026-02-12 00:00:00');


--
-- Name: messages_2026_02_12; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_02_12 FOR VALUES FROM ('2026-02-12 00:00:00') TO ('2026-02-13 00:00:00');


--
-- Name: messages_2026_02_13; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_02_13 FOR VALUES FROM ('2026-02-13 00:00:00') TO ('2026-02-14 00:00:00');


--
-- Name: messages_2026_02_14; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_02_14 FOR VALUES FROM ('2026-02-14 00:00:00') TO ('2026-02-15 00:00:00');


--
-- Name: messages_2026_02_15; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_02_15 FOR VALUES FROM ('2026-02-15 00:00:00') TO ('2026-02-16 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	3b80c644-bb71-44c4-bd23-d91afc1e6eec	{"action":"user_signedup","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-23 23:01:42.921121+00	
00000000-0000-0000-0000-000000000000	5db3d88d-d741-4ae1-97a5-647755a5e6aa	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-23 23:01:42.928449+00	
00000000-0000-0000-0000-000000000000	fc4dc5e7-efe2-4b6e-8796-87a1f4c27fb4	{"action":"logout","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account"}	2025-09-23 23:05:09.849525+00	
00000000-0000-0000-0000-000000000000	313bc9e1-2fb1-466f-8596-761987761b0b	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-23 23:05:15.092444+00	
00000000-0000-0000-0000-000000000000	c2083e8e-acc2-4033-8c00-7b144c079f83	{"action":"logout","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account"}	2025-09-23 23:07:20.46174+00	
00000000-0000-0000-0000-000000000000	f14764a9-73a5-48c6-98d2-7a64e8462289	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-23 23:07:25.563085+00	
00000000-0000-0000-0000-000000000000	c8841842-e17b-4694-9a40-771f09dbca76	{"action":"user_signedup","actor_id":"fa9be724-62f7-4aed-82df-1a23413994bc","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-23 23:08:45.002586+00	
00000000-0000-0000-0000-000000000000	a12186ce-a98c-47e6-a900-495a2cb339e4	{"action":"login","actor_id":"fa9be724-62f7-4aed-82df-1a23413994bc","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-23 23:08:45.006754+00	
00000000-0000-0000-0000-000000000000	c5d80b8b-9f40-464f-aaf2-8907fcac4b64	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-24 09:29:34.947623+00	
00000000-0000-0000-0000-000000000000	ce8fa962-0a96-4617-b8cc-b75af6430a5f	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-24 09:29:34.973255+00	
00000000-0000-0000-0000-000000000000	2b6211d8-ce16-4943-9146-0d67fa60da8b	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-24 11:55:31.429318+00	
00000000-0000-0000-0000-000000000000	15aae295-a3ba-406d-a3f4-8f5316824efe	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-24 11:55:31.43832+00	
00000000-0000-0000-0000-000000000000	2ac59aeb-fa83-4148-af38-8f6cf4ba4a44	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-24 11:55:32.653814+00	
00000000-0000-0000-0000-000000000000	4810933e-e0ae-46d0-9d84-09cd052224a7	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"jringo303@gmail.com","user_id":"fa9be724-62f7-4aed-82df-1a23413994bc","user_phone":""}}	2025-09-24 12:02:48.960782+00	
00000000-0000-0000-0000-000000000000	e323ca49-e2fc-4c61-8a59-5f73a928db29	{"action":"user_signedup","actor_id":"1258b596-2973-4ab9-908e-92f27659de19","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-24 12:06:48.362758+00	
00000000-0000-0000-0000-000000000000	1cf06849-69af-44ac-a1c1-20503fbf898e	{"action":"login","actor_id":"1258b596-2973-4ab9-908e-92f27659de19","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-24 12:06:48.370399+00	
00000000-0000-0000-0000-000000000000	9efccc81-0c81-43aa-92fc-bd6c7b5aa678	{"action":"logout","actor_id":"1258b596-2973-4ab9-908e-92f27659de19","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-24 12:07:10.566584+00	
00000000-0000-0000-0000-000000000000	16f4eec2-c308-4432-a85f-eaba1474cd2c	{"action":"login","actor_id":"1258b596-2973-4ab9-908e-92f27659de19","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-24 12:07:16.056323+00	
00000000-0000-0000-0000-000000000000	805438a6-32e9-43e7-b721-9aae442bf22d	{"action":"logout","actor_id":"1258b596-2973-4ab9-908e-92f27659de19","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-24 12:07:20.824483+00	
00000000-0000-0000-0000-000000000000	3458de73-415a-4187-95cf-a8341f73109b	{"action":"login","actor_id":"1258b596-2973-4ab9-908e-92f27659de19","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-24 12:08:22.538873+00	
00000000-0000-0000-0000-000000000000	4fc30bda-e8ce-4d21-8213-542e1c5cee6c	{"action":"user_signedup","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-24 12:17:30.970406+00	
00000000-0000-0000-0000-000000000000	eb758797-dc93-411e-ba4d-9210cf264f3e	{"action":"login","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-24 12:17:30.978559+00	
00000000-0000-0000-0000-000000000000	f0828eff-a70f-4ef6-b827-cef0f8236a50	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-24 21:33:40.672937+00	
00000000-0000-0000-0000-000000000000	55a78669-7594-4040-b9fb-7c60fbab46ba	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-24 21:33:40.699122+00	
00000000-0000-0000-0000-000000000000	db5bcbc3-2978-4b08-994a-551fc86035dc	{"action":"token_refreshed","actor_id":"1258b596-2973-4ab9-908e-92f27659de19","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-24 23:13:01.815674+00	
00000000-0000-0000-0000-000000000000	ecf5d2f8-27bd-4ce5-9d58-1d686b841e1a	{"action":"token_revoked","actor_id":"1258b596-2973-4ab9-908e-92f27659de19","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-24 23:13:01.83265+00	
00000000-0000-0000-0000-000000000000	382a3d80-c11a-423d-ab52-046d17a24e5c	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-25 15:50:51.144867+00	
00000000-0000-0000-0000-000000000000	e2930e6f-448a-457e-8e9e-4c8dea8b692d	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-25 15:50:51.165451+00	
00000000-0000-0000-0000-000000000000	9af3fdd2-5c22-42f4-8664-a7e25078faa8	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-25 18:42:37.706832+00	
00000000-0000-0000-0000-000000000000	aab41199-1f70-4f95-934d-6e2de8237553	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-25 18:42:37.719089+00	
00000000-0000-0000-0000-000000000000	11b68cd4-f9b0-47f9-87c0-ed884765b9df	{"action":"logout","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account"}	2025-09-25 18:43:36.103661+00	
00000000-0000-0000-0000-000000000000	559e9114-164c-4214-aef3-9efa7d5e16cf	{"action":"token_refreshed","actor_id":"1258b596-2973-4ab9-908e-92f27659de19","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-25 18:46:05.036183+00	
00000000-0000-0000-0000-000000000000	e3f83ed1-c22a-4e07-a65e-f63713209745	{"action":"token_revoked","actor_id":"1258b596-2973-4ab9-908e-92f27659de19","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-25 18:46:05.037766+00	
00000000-0000-0000-0000-000000000000	b074c898-a671-4066-bf77-246d567191ab	{"action":"logout","actor_id":"1258b596-2973-4ab9-908e-92f27659de19","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-25 18:46:07.664921+00	
00000000-0000-0000-0000-000000000000	23446646-c1d2-4f9a-9849-9dd2f3107d9b	{"action":"login","actor_id":"1258b596-2973-4ab9-908e-92f27659de19","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-25 18:46:16.08054+00	
00000000-0000-0000-0000-000000000000	40abb28c-be67-4c1e-9082-a11606f47a4a	{"action":"logout","actor_id":"1258b596-2973-4ab9-908e-92f27659de19","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-09-25 18:46:19.537288+00	
00000000-0000-0000-0000-000000000000	e9882f74-9958-4804-bbd5-be8279e93cd6	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"jringo303@gmail.com","user_id":"1258b596-2973-4ab9-908e-92f27659de19","user_phone":""}}	2025-09-25 18:46:28.997102+00	
00000000-0000-0000-0000-000000000000	807fb0ce-958c-4c65-9c26-9ef8821dbbdf	{"action":"login","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-25 18:46:29.901506+00	
00000000-0000-0000-0000-000000000000	52308d89-fa6f-4ffd-a1f1-fbd6711683dc	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-25 18:47:41.254052+00	
00000000-0000-0000-0000-000000000000	03cd8716-e46c-498a-888f-1f513f920dea	{"action":"user_signedup","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-25 18:49:31.720698+00	
00000000-0000-0000-0000-000000000000	b2d26a6e-1136-4704-9a3c-d76567a3d6d0	{"action":"login","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-25 18:49:31.724667+00	
00000000-0000-0000-0000-000000000000	8c341212-66c0-42a4-bd45-5a1fb021e8d7	{"action":"user_signedup","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-25 20:38:49.601921+00	
00000000-0000-0000-0000-000000000000	20179d64-e6d0-420b-a9d3-f6c963f04ab7	{"action":"login","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-25 20:38:49.630468+00	
00000000-0000-0000-0000-000000000000	abfb887a-cf37-4cb0-8d48-9560b25dacb7	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-25 22:28:44.060883+00	
00000000-0000-0000-0000-000000000000	f027f9e5-c9e7-4d11-9563-3049e83dda08	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-25 22:28:44.078938+00	
00000000-0000-0000-0000-000000000000	68d78141-6698-461e-a717-eb189c7e89d2	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-25 23:27:06.71401+00	
00000000-0000-0000-0000-000000000000	d3c7a194-0591-49c7-802d-988d6bb2a0e9	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-25 23:27:06.726136+00	
00000000-0000-0000-0000-000000000000	0dba75d8-be08-4df9-adf2-895eca9608bb	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 00:35:17.413171+00	
00000000-0000-0000-0000-000000000000	092bd3ac-2142-4b05-b8af-8112f5cdf40a	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 00:35:17.429027+00	
00000000-0000-0000-0000-000000000000	5795f379-7645-4000-b4bb-e3f720b0cf9d	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-26 11:54:14.184392+00	
00000000-0000-0000-0000-000000000000	a87099a2-4347-4e5e-b0d9-030ff8801514	{"action":"token_revoked","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-26 11:54:14.216035+00	
00000000-0000-0000-0000-000000000000	c5ffa671-2839-4cad-89e0-b9ec24b937aa	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-26 13:54:58.670371+00	
00000000-0000-0000-0000-000000000000	8f817b52-b8f4-4d9b-8e75-cbea3fb5b98e	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-26 13:54:58.693343+00	
00000000-0000-0000-0000-000000000000	80ee8d07-a1c3-4fbc-8430-f2547041f4b5	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-26 15:52:57.563237+00	
00000000-0000-0000-0000-000000000000	47b68bfb-c77a-4ff8-86c0-9c05b90d054c	{"action":"token_revoked","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-26 15:52:57.574457+00	
00000000-0000-0000-0000-000000000000	a240b2a5-6932-4dab-abf9-12077dad5d26	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-26 15:53:02.614635+00	
00000000-0000-0000-0000-000000000000	c1143b27-b0de-452d-a349-22c4f080fe7a	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 18:15:37.053337+00	
00000000-0000-0000-0000-000000000000	689d24b6-0722-49dd-b8f8-41ef83dfb7ca	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 18:15:37.068013+00	
00000000-0000-0000-0000-000000000000	15d4abf0-4438-4c87-948c-d012f3ce7cea	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 19:13:47.168771+00	
00000000-0000-0000-0000-000000000000	109d872a-0c8c-48cc-832d-35d70e73b0b7	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 19:13:47.181257+00	
00000000-0000-0000-0000-000000000000	717d3501-d8cd-4d7f-8c00-b696ccae7a4d	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 20:12:19.740929+00	
00000000-0000-0000-0000-000000000000	93256d23-70f1-4bb3-8330-085f03367a89	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 20:12:19.760954+00	
00000000-0000-0000-0000-000000000000	1ed0e856-3a44-49d4-ab1b-364188e6cdf3	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 21:10:44.372875+00	
00000000-0000-0000-0000-000000000000	4fff122e-49c2-4470-b01d-5ae0b02cf2ab	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 21:10:44.386215+00	
00000000-0000-0000-0000-000000000000	aca20c16-41b0-4bef-b8f2-2e39994e16ab	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 22:40:07.386944+00	
00000000-0000-0000-0000-000000000000	d1d34ae3-d8fe-4d7c-a2ed-382480349291	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 22:40:07.396112+00	
00000000-0000-0000-0000-000000000000	e5744f23-3a18-4818-8e78-4d901fa6c1a7	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 23:46:16.246794+00	
00000000-0000-0000-0000-000000000000	1497eafa-a0b8-4b8b-af64-48675cd461bc	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-26 23:46:16.259093+00	
00000000-0000-0000-0000-000000000000	5ae3fce7-14ea-4368-9eff-f162a69090ff	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-28 02:23:02.999373+00	
00000000-0000-0000-0000-000000000000	ddf4aa9f-2e18-4cf6-a6fe-e14193bf6bed	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-09-28 02:23:03.030386+00	
00000000-0000-0000-0000-000000000000	d6ec29b6-80bd-4d7d-93c3-f7061fc91f15	{"action":"logout","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"account"}	2025-09-28 02:26:08.742963+00	
00000000-0000-0000-0000-000000000000	c3461baa-9555-4904-b645-690d1be60e27	{"action":"login","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-28 02:27:07.380541+00	
00000000-0000-0000-0000-000000000000	e64371c3-a14e-4b18-ae6a-e572718db01b	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-28 05:19:51.670202+00	
00000000-0000-0000-0000-000000000000	0b94f316-95dc-4d1c-b4cc-740cb4f0afed	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-09-28 05:19:51.679281+00	
00000000-0000-0000-0000-000000000000	b5a487e5-4657-4f34-a596-2be11ba4f9b1	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-28 16:21:37.75437+00	
00000000-0000-0000-0000-000000000000	4d241f6f-5b69-4147-b164-22aa54859748	{"action":"token_revoked","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-28 16:21:37.782693+00	
00000000-0000-0000-0000-000000000000	c9e39370-18c2-40e5-b5f5-3c0677996d1c	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-28 16:21:40.006152+00	
00000000-0000-0000-0000-000000000000	f609eeec-b4c5-41e8-a488-1175a07e2376	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-29 20:38:36.273057+00	
00000000-0000-0000-0000-000000000000	bb72cabb-127a-4345-b594-e8ca2efc1d4c	{"action":"token_revoked","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-29 20:38:36.304662+00	
00000000-0000-0000-0000-000000000000	8ac8c1db-c300-481f-b848-08c2222e800e	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-30 09:19:54.570035+00	
00000000-0000-0000-0000-000000000000	a1808174-6d42-411d-b137-b6a3a006b3c5	{"action":"token_revoked","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-30 09:19:54.57751+00	
00000000-0000-0000-0000-000000000000	1291b771-7e9e-4d39-aafa-0606ca58676e	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-10-02 17:46:10.187319+00	
00000000-0000-0000-0000-000000000000	c6219fb0-823d-4797-8ab5-5f6ec216e7ad	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-10-02 17:46:10.200533+00	
00000000-0000-0000-0000-000000000000	86053589-8629-4ba3-83ce-ee64fcad9e2a	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-10-02 19:57:32.348391+00	
00000000-0000-0000-0000-000000000000	4f5dd89e-855e-4aa8-930c-92d041c66bb4	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-10-02 19:57:32.369783+00	
00000000-0000-0000-0000-000000000000	077d2f59-f9ed-49a5-b9ac-92de6908a43e	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-10-02 21:55:59.318+00	
00000000-0000-0000-0000-000000000000	7d978b4c-67b2-43b7-a5f3-170dc7ba040f	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-10-02 21:55:59.331395+00	
00000000-0000-0000-0000-000000000000	86c436fe-f63f-417f-9fd5-c1a785943132	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-07 13:09:52.499159+00	
00000000-0000-0000-0000-000000000000	446aa804-b614-4e83-8889-b28dca8469c3	{"action":"token_revoked","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-07 13:09:52.522697+00	
00000000-0000-0000-0000-000000000000	1d159923-fb16-4569-8a04-f65d0570ffc7	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-07 13:09:52.600371+00	
00000000-0000-0000-0000-000000000000	f1be4d14-3857-4163-8990-eab8edf443df	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-07 14:19:16.77821+00	
00000000-0000-0000-0000-000000000000	8ab024e1-1b58-4f09-a9e2-ee63affb13a6	{"action":"token_revoked","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-07 14:19:16.804436+00	
00000000-0000-0000-0000-000000000000	58bffbef-8fc4-4507-af19-0a280682cb3a	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-07 14:19:16.871132+00	
00000000-0000-0000-0000-000000000000	08b895e2-63fe-45cb-a280-86db97b34ed3	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-08 13:32:10.117431+00	
00000000-0000-0000-0000-000000000000	cad171ed-fd2f-42b6-88e5-66a22304619d	{"action":"token_revoked","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-08 13:32:10.144228+00	
00000000-0000-0000-0000-000000000000	a69678e4-41aa-420e-b515-0cf8c1f2991d	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 10:59:12.051065+00	
00000000-0000-0000-0000-000000000000	b5c8d0f7-8323-4203-aefb-4e4235233f30	{"action":"token_revoked","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 10:59:12.080817+00	
00000000-0000-0000-0000-000000000000	a8f73156-820f-4248-994b-f936017920b5	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 10:59:12.137629+00	
00000000-0000-0000-0000-000000000000	d4635144-e6d1-4916-a0fd-246b2a045a85	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 10:59:12.163713+00	
00000000-0000-0000-0000-000000000000	49b2e98e-7202-4400-890e-dce2f97d93cd	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 10:59:12.182623+00	
00000000-0000-0000-0000-000000000000	04eb3d31-5b5c-449f-bf2e-fb1f518d1f8f	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 14:47:38.264979+00	
00000000-0000-0000-0000-000000000000	bd246fb3-d61a-451c-a2f6-17e5307c80f5	{"action":"token_revoked","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 14:47:38.287392+00	
00000000-0000-0000-0000-000000000000	166fba73-1d8c-4b12-8b81-1f82af8f684b	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 14:47:38.356932+00	
00000000-0000-0000-0000-000000000000	79ffd557-01f3-49ec-a60c-06112cd87a72	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 14:47:38.375816+00	
00000000-0000-0000-0000-000000000000	cd055468-c366-4bf7-81b9-978dbd7ae527	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-09 14:47:38.392957+00	
00000000-0000-0000-0000-000000000000	e8eebed1-457a-4e94-b978-312ad55f8eeb	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-10-10 07:02:06.918139+00	
00000000-0000-0000-0000-000000000000	d0865869-7fb8-4e7d-85e9-5bfeff433fd0	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-10-10 07:02:06.949256+00	
00000000-0000-0000-0000-000000000000	01fa87ee-05c6-46cb-84db-c5fadd3b5fac	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-10 09:03:00.805571+00	
00000000-0000-0000-0000-000000000000	5fc603f8-6d13-46c4-a20f-843500663839	{"action":"token_revoked","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-10 09:03:00.831381+00	
00000000-0000-0000-0000-000000000000	afe2d45e-aa7c-4b31-9f16-633bb65b41ba	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-10-13 18:12:59.157635+00	
00000000-0000-0000-0000-000000000000	dc60c21c-ddf9-4e75-902d-317d7a83c779	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-10-13 18:12:59.170726+00	
00000000-0000-0000-0000-000000000000	c8af6cfa-a3ea-45ec-817d-b613087472f8	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-13 18:14:39.888629+00	
00000000-0000-0000-0000-000000000000	f18fb95c-551e-4d98-84f2-e3e1bc183bdb	{"action":"token_revoked","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-13 18:14:39.889964+00	
00000000-0000-0000-0000-000000000000	142ae4ca-78d3-415b-8ea4-466e110f3745	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-11-08 18:13:45.135615+00	
00000000-0000-0000-0000-000000000000	93c7a576-8905-4a17-9e37-526aa179642d	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-14 16:50:03.958633+00	
00000000-0000-0000-0000-000000000000	6b8710c1-1b87-44b0-a34c-906fe4382080	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-14 16:50:03.986035+00	
00000000-0000-0000-0000-000000000000	c582fa94-4ee5-432e-902d-693c5b38c741	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-11-15 00:19:24.173896+00	
00000000-0000-0000-0000-000000000000	9d47fa09-d270-451f-9e90-7f0045fd5ad5	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-11-15 00:19:24.194598+00	
00000000-0000-0000-0000-000000000000	894f1f6a-03df-4742-8b5a-0453448e2b4a	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-11-16 01:25:16.434435+00	
00000000-0000-0000-0000-000000000000	f64ac32d-7a97-4187-b67e-5a0b96b7843e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-11-16 01:25:16.463178+00	
00000000-0000-0000-0000-000000000000	69a5408f-f917-41f7-af16-7f1e6aee14f0	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-11-16 01:25:17.388789+00	
00000000-0000-0000-0000-000000000000	c3c1cb8d-3cf5-4244-b35a-8a6a075560a2	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-11-17 00:40:26.538234+00	
00000000-0000-0000-0000-000000000000	81f482b4-bdba-42c4-92fc-43277a64aced	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-11-17 00:40:26.563451+00	
00000000-0000-0000-0000-000000000000	e4aff63e-a7dc-496e-bcc3-8c6690964c61	{"action":"token_refreshed","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-17 17:45:34.298911+00	
00000000-0000-0000-0000-000000000000	f01837f6-cb50-44b5-8ffa-d24a6bbcabd5	{"action":"token_revoked","actor_id":"a15c4057-0295-4815-b537-28a72c79911e","actor_username":"jringo303@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-17 17:45:34.312713+00	
00000000-0000-0000-0000-000000000000	79b1d1c3-efe4-4ab9-a5c0-72a1b0671417	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-17 17:48:52.621515+00	
00000000-0000-0000-0000-000000000000	b5f0aac7-13e7-4d23-bd1e-440b63e94969	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-17 19:32:48.199266+00	
00000000-0000-0000-0000-000000000000	6ee7602a-d8a4-4027-b3c1-8e58bbbdeb71	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-17 19:32:48.229458+00	
00000000-0000-0000-0000-000000000000	784cb39f-5a94-40c1-8c80-b710331c0aad	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-17 19:32:52.306847+00	
00000000-0000-0000-0000-000000000000	5ddf628f-6c7a-4c78-b45f-59af11c229c0	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-17 19:32:52.307848+00	
00000000-0000-0000-0000-000000000000	93961bb7-ad36-4eba-9256-bbccb1df488b	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-11-18 08:38:29.165209+00	
00000000-0000-0000-0000-000000000000	c3f29ff1-9fa2-4c70-be47-096063f08731	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-11-18 08:38:29.193546+00	
00000000-0000-0000-0000-000000000000	740dd84b-c7a2-4193-985c-d62861305aa5	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 09:02:23.146517+00	
00000000-0000-0000-0000-000000000000	2134b982-a9fd-40ea-a756-508c3e2439c9	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 09:02:23.161204+00	
00000000-0000-0000-0000-000000000000	d94ba4b7-f6aa-4b29-ac41-7483cb43eb7f	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 09:02:23.200557+00	
00000000-0000-0000-0000-000000000000	838c351c-6ca0-49e6-afbe-1b17c4cb723d	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 12:55:52.348409+00	
00000000-0000-0000-0000-000000000000	62afa4e0-320c-4779-b6d4-71eb92b336fc	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 12:55:52.372863+00	
00000000-0000-0000-0000-000000000000	7b35af01-9a72-4ba1-bcc1-b156da13fe20	{"action":"logout","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account"}	2025-11-18 12:56:25.5341+00	
00000000-0000-0000-0000-000000000000	57b127fa-b165-4271-8eba-924aba6502f8	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-18 12:59:28.881799+00	
00000000-0000-0000-0000-000000000000	e32d5011-eccf-45eb-aa0b-942a78ae64a0	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 14:01:50.310043+00	
00000000-0000-0000-0000-000000000000	c5d0d00d-319c-4f02-a825-8d3d392153ca	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 14:01:50.337157+00	
00000000-0000-0000-0000-000000000000	9991436b-81f0-43a1-a4b9-561ddb365435	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 15:12:22.556767+00	
00000000-0000-0000-0000-000000000000	bb9c6990-77dd-4da5-bb2c-0ca0a7cb712d	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 15:12:22.58543+00	
00000000-0000-0000-0000-000000000000	0e1ccef1-e2ed-41c7-8a3f-b8105e7195da	{"action":"token_refreshed","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 15:30:01.806598+00	
00000000-0000-0000-0000-000000000000	ea93dbd1-93ba-4ce3-93f5-73de8b347cec	{"action":"token_revoked","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 15:30:01.823592+00	
00000000-0000-0000-0000-000000000000	6acb3cfa-4187-4e4d-b5be-e560a7864b8f	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-18 15:49:51.699417+00	
00000000-0000-0000-0000-000000000000	e2cd252d-3309-45bc-be73-c4ad5063ee7c	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-18 15:50:03.305158+00	
00000000-0000-0000-0000-000000000000	41478b7b-2519-4bd3-a646-d45fb6262b93	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 17:36:47.26264+00	
00000000-0000-0000-0000-000000000000	9f42a4ff-0909-44c7-b740-ea547b29dbc3	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 17:36:47.286201+00	
00000000-0000-0000-0000-000000000000	8bca8d7b-0c69-42a7-8683-167c18e89dd7	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 17:36:47.397069+00	
00000000-0000-0000-0000-000000000000	9d798cad-1de3-4e57-887e-5ff11bb65aa7	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 17:36:47.426198+00	
00000000-0000-0000-0000-000000000000	09354eb6-4e21-4b9e-aa2b-2b73b4f77548	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 17:46:35.246006+00	
00000000-0000-0000-0000-000000000000	53ab37c5-e7e8-42bf-8335-bbe7c08d6c8f	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 17:46:35.251536+00	
00000000-0000-0000-0000-000000000000	c1ebf8fd-143b-453e-ac7a-8f841d8a381e	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 18:36:35.895504+00	
00000000-0000-0000-0000-000000000000	3581ff58-f1c9-487b-8110-34d38b20fa02	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 18:36:35.923436+00	
00000000-0000-0000-0000-000000000000	778bfdc5-28a0-410f-bb61-223232867551	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 18:50:59.693504+00	
00000000-0000-0000-0000-000000000000	f0662d4b-96e4-415e-b9e3-fe35224d057d	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-18 18:50:59.701121+00	
00000000-0000-0000-0000-000000000000	8a8ffbeb-aa88-46a3-9ab2-5e869c9b1785	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-11-18 22:02:54.011714+00	
00000000-0000-0000-0000-000000000000	9508c043-a45b-48b1-b946-8ee7130b76f3	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2025-11-18 22:02:54.036603+00	
00000000-0000-0000-0000-000000000000	af5b3253-4f80-4f17-9fee-563167056151	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-19 09:10:44.958187+00	
00000000-0000-0000-0000-000000000000	ca039284-9243-4302-84fd-9b1f51427be5	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-19 09:10:44.979679+00	
00000000-0000-0000-0000-000000000000	7a4c139d-fa44-4d2a-9d85-4fc615a9e62d	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-19 09:10:47.856396+00	
00000000-0000-0000-0000-000000000000	d8399711-8af5-4745-8de4-374dc2794f98	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-19 10:13:05.293525+00	
00000000-0000-0000-0000-000000000000	76d8b58d-164e-4b1a-9092-2d9898a06af9	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-19 10:13:05.314787+00	
00000000-0000-0000-0000-000000000000	8f6ee8d4-bf45-4511-915e-2d721522c531	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-19 11:32:14.85303+00	
00000000-0000-0000-0000-000000000000	a1d246c7-fff7-4fb5-90bf-30ce91e2c91e	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-19 11:32:14.87267+00	
00000000-0000-0000-0000-000000000000	6c22e77b-60ff-4808-a16e-be1f7fe40e68	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-19 11:32:15.357602+00	
00000000-0000-0000-0000-000000000000	ea00c7e4-486d-4cb4-8ac9-e7bf224432c3	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-19 12:31:09.939385+00	
00000000-0000-0000-0000-000000000000	bf1b3f41-449a-423c-a280-4a50856381a6	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-19 12:31:09.961885+00	
00000000-0000-0000-0000-000000000000	fc4c9b35-8cd1-4641-b08d-e1b30aed3bc4	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-19 13:43:03.18909+00	
00000000-0000-0000-0000-000000000000	c2e0eed9-9239-4800-acbd-2f7a025f8b40	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-19 13:43:03.216091+00	
00000000-0000-0000-0000-000000000000	10639b4c-144c-42e2-891d-dd5d0c362014	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-20 18:00:23.917669+00	
00000000-0000-0000-0000-000000000000	a10e977d-32e0-4f74-b755-743d6c763fb4	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-20 18:00:23.945796+00	
00000000-0000-0000-0000-000000000000	fc0dd2a3-e25e-4441-9567-1e04faeb3239	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-20 19:15:56.706395+00	
00000000-0000-0000-0000-000000000000	69c6a24a-f27b-4bec-9a8d-c9dd80bc635d	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-20 19:15:56.71874+00	
00000000-0000-0000-0000-000000000000	33833dbd-7412-4183-92df-ce938de45e26	{"action":"logout","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account"}	2025-11-20 19:34:12.471283+00	
00000000-0000-0000-0000-000000000000	54ac7220-6d8d-4055-8a62-46b814685ccb	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-20 19:34:33.461883+00	
00000000-0000-0000-0000-000000000000	127e572d-930e-4271-a7a4-3f83fa79f059	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-22 12:02:04.643407+00	
00000000-0000-0000-0000-000000000000	df476136-2a3c-450d-ba90-2400c0a7c9cd	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-22 12:02:04.655603+00	
00000000-0000-0000-0000-000000000000	d4d6eefa-1482-4998-9033-103c8a429b83	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-23 00:00:41.282357+00	
00000000-0000-0000-0000-000000000000	28417311-fb69-4b5b-a996-987ab9658c7f	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-23 00:00:41.306085+00	
00000000-0000-0000-0000-000000000000	5b8ec159-22e6-41c9-afd2-e4179cd405ac	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-24 17:26:36.630406+00	
00000000-0000-0000-0000-000000000000	4b51b414-9667-4be6-9405-f9dc43f802fc	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-26 20:06:57.294213+00	
00000000-0000-0000-0000-000000000000	48eb07dd-cf6d-4aea-9750-6b8aa27bea4f	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-26 20:06:57.320326+00	
00000000-0000-0000-0000-000000000000	356f4909-f4bf-4c96-9126-42195be88b9e	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-29 00:45:39.767183+00	
00000000-0000-0000-0000-000000000000	d8698322-a661-4764-b36c-478f5222d8bb	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-29 00:45:39.791995+00	
00000000-0000-0000-0000-000000000000	abeeffa2-588c-4112-8f26-658843e8f2d9	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-30 21:51:37.312012+00	
00000000-0000-0000-0000-000000000000	42cce25d-6bcc-47d1-983e-99208a69ee76	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-30 23:51:48.070399+00	
00000000-0000-0000-0000-000000000000	3b0754ce-aadc-401c-aa14-44243eebb8eb	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-11-30 23:51:48.090995+00	
00000000-0000-0000-0000-000000000000	165874e4-5573-4ed7-bc92-7769ddb2fb6b	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-01 12:31:17.498818+00	
00000000-0000-0000-0000-000000000000	257bcc06-6170-4346-973b-d24926897996	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-01 12:31:17.522337+00	
00000000-0000-0000-0000-000000000000	31af57a7-dd81-4a60-ad2d-91b2e080442f	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-01 12:31:17.612019+00	
00000000-0000-0000-0000-000000000000	25ce560d-7fc2-476d-bbd3-ca6b8f992767	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-03 03:37:34.733147+00	
00000000-0000-0000-0000-000000000000	094e052f-3e5a-4c11-a7d0-d8e632e1cbe1	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-03 03:37:34.757419+00	
00000000-0000-0000-0000-000000000000	dd7eac86-579c-4334-ba48-3f74a79fb2db	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-03 18:09:35.524977+00	
00000000-0000-0000-0000-000000000000	f5e73545-d651-45cd-a0b4-d60dce7817be	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-03 19:31:10.691454+00	
00000000-0000-0000-0000-000000000000	f9aea1e4-d0f6-40db-837f-9d95f8d1ff4e	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-03 19:31:10.717043+00	
00000000-0000-0000-0000-000000000000	e34223e3-3ab1-4e71-b793-fe8b1a641f20	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-03 19:31:10.796414+00	
00000000-0000-0000-0000-000000000000	84a460e8-63d6-4b43-bec1-d573c669ab30	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-04 04:27:53.499893+00	
00000000-0000-0000-0000-000000000000	c3abf425-4bb8-454b-8adb-c070a7c09044	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-04 04:27:53.524829+00	
00000000-0000-0000-0000-000000000000	93d2792b-5eae-473d-9555-9de24ed1cef4	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-04 16:56:19.382594+00	
00000000-0000-0000-0000-000000000000	97b8a17b-53d6-4779-b671-8d94998e7576	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-04 16:56:19.412569+00	
00000000-0000-0000-0000-000000000000	17bb2a10-54b6-4b29-8c85-f27f7bf9f3aa	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-05 05:44:56.645529+00	
00000000-0000-0000-0000-000000000000	54a83d02-cb00-4fa2-b422-0879eb3ec151	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-05 05:44:56.657718+00	
00000000-0000-0000-0000-000000000000	d22e9a65-4c25-4514-a443-3d96e863f497	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-05 17:10:25.425197+00	
00000000-0000-0000-0000-000000000000	c2802a19-2c39-4b8e-825c-28dcb7974b9e	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-07 03:29:50.504346+00	
00000000-0000-0000-0000-000000000000	17afd5fa-b63a-4215-8982-db3d489dbb04	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-07 03:29:50.530132+00	
00000000-0000-0000-0000-000000000000	20251cf1-fdfc-4098-8d03-ab166fc2cda2	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-08 07:05:00.221456+00	
00000000-0000-0000-0000-000000000000	ba28ba50-cec4-4fb2-8924-20454506ee9c	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-08 07:05:00.248531+00	
00000000-0000-0000-0000-000000000000	84fdcff3-ac4f-4516-9972-6e0afd78a289	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-08 07:05:05.665941+00	
00000000-0000-0000-0000-000000000000	21810cc1-fd0e-4d57-80ca-06bbcba80132	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-08 07:05:05.666623+00	
00000000-0000-0000-0000-000000000000	f7db05c2-470c-4045-8ab1-5c8c52f370b6	{"action":"token_refreshed","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-08 16:39:42.111272+00	
00000000-0000-0000-0000-000000000000	c880636c-0e7a-4305-b0fb-b543c43fb79c	{"action":"token_revoked","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-08 16:39:42.139513+00	
00000000-0000-0000-0000-000000000000	d3f867b3-8e96-46db-8941-9fceadfcd9ea	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-16 02:21:00.055299+00	
00000000-0000-0000-0000-000000000000	e7bb3c73-f775-4b2f-bcb9-81ae148bfe29	{"action":"token_refreshed","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-16 20:24:47.421805+00	
00000000-0000-0000-0000-000000000000	b822a475-76c4-4ffd-add0-b93963c68a60	{"action":"token_revoked","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-16 20:24:47.447326+00	
00000000-0000-0000-0000-000000000000	4e1a7ca0-999d-40ea-94bb-f5e30eb3e1f4	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-27 17:59:50.031472+00	
00000000-0000-0000-0000-000000000000	0f6e4abc-ce7c-4511-847e-ff65a7d369e2	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-27 17:59:50.062704+00	
00000000-0000-0000-0000-000000000000	1f7c08db-95bf-42a4-be71-abe15c5f5501	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-30 21:58:50.997683+00	
00000000-0000-0000-0000-000000000000	a2da25b2-8c69-4ecc-ab48-f9e721f47d5d	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-30 21:58:51.022184+00	
00000000-0000-0000-0000-000000000000	49e57284-dd9c-4526-b32b-68efd6aa56c9	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-31 13:03:21.85221+00	
00000000-0000-0000-0000-000000000000	4d75d8bc-3179-4ea2-bb1a-40aad26ecfd2	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2025-12-31 13:03:21.876639+00	
00000000-0000-0000-0000-000000000000	703f1823-3a35-4a88-a73c-f41450ced73c	{"action":"token_refreshed","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-05 13:21:38.086448+00	
00000000-0000-0000-0000-000000000000	769d4745-ea62-4ec0-b8a9-e2a04898d5f2	{"action":"token_revoked","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-05 13:21:38.116986+00	
00000000-0000-0000-0000-000000000000	a8d8edc7-f9cd-4205-81cd-2609d59d164e	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-05 15:36:35.206199+00	
00000000-0000-0000-0000-000000000000	49b2e794-2e44-4134-824c-94c9899e6911	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-05 21:53:31.59932+00	
00000000-0000-0000-0000-000000000000	d60812b0-2a8f-4a5c-ab54-d665dea1cbc9	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-05 23:50:47.291537+00	
00000000-0000-0000-0000-000000000000	c27b5834-3718-494c-9ed0-d4eb8c3d35cb	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-05 23:50:47.306762+00	
00000000-0000-0000-0000-000000000000	de933d48-2e01-4dbc-998c-1c0515eb6151	{"action":"token_refreshed","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-08 18:22:05.705799+00	
00000000-0000-0000-0000-000000000000	ffd42d81-b5f0-40a0-a5ff-7b0f73f0fa88	{"action":"token_revoked","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-08 18:22:05.731391+00	
00000000-0000-0000-0000-000000000000	bfe2677e-e930-4ade-b167-c2e2d87696cd	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-08 18:55:42.546272+00	
00000000-0000-0000-0000-000000000000	680e1114-4560-48ff-b2a9-fea74f1c6d53	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-08 18:55:42.56487+00	
00000000-0000-0000-0000-000000000000	e39fd3c9-6ac1-405e-86c9-693aaa1c77d9	{"action":"token_refreshed","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-08 19:31:49.555182+00	
00000000-0000-0000-0000-000000000000	dd98d4e4-2228-493e-b41d-a5b7e8c0a006	{"action":"token_revoked","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-08 19:31:49.573991+00	
00000000-0000-0000-0000-000000000000	73af7a42-d364-464c-b559-dea0ae79d815	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-09 12:03:48.189755+00	
00000000-0000-0000-0000-000000000000	0b5467d5-620f-45c7-8ac8-2418ef13e768	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-09 12:03:48.2213+00	
00000000-0000-0000-0000-000000000000	f61e9750-9edf-49f5-bc03-68f53ba1089a	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-13 18:48:58.647346+00	
00000000-0000-0000-0000-000000000000	208aea75-454b-4f84-9309-ed6131cf2e0e	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-13 21:36:52.203792+00	
00000000-0000-0000-0000-000000000000	8d82efca-4635-437c-ba95-d8b544a4dfa5	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-13 21:36:52.214977+00	
00000000-0000-0000-0000-000000000000	0b47f1bc-5242-4390-ad5f-9d386e4e220c	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-23 12:03:22.71467+00	
00000000-0000-0000-0000-000000000000	4e0b612b-0fc8-4903-b3fe-f23b05827e67	{"action":"login","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-23 23:46:38.666535+00	
00000000-0000-0000-0000-000000000000	53ab27cd-59e1-4f47-b52e-da3317fe6f5b	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-24 00:47:29.293728+00	
00000000-0000-0000-0000-000000000000	17e06eb7-c408-4b59-a11a-9a6c2c2c7051	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-24 00:48:53.870777+00	
00000000-0000-0000-0000-000000000000	a91a6bc3-f558-409e-9783-a338e3bfa6c6	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-24 01:46:32.212368+00	
00000000-0000-0000-0000-000000000000	a7dc4c3e-0e75-4a0d-9342-d91f394f3b53	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-24 01:46:32.239013+00	
00000000-0000-0000-0000-000000000000	04a8e523-171b-4813-9832-194ea03a060a	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-24 01:56:49.437955+00	
00000000-0000-0000-0000-000000000000	6af64806-3ec4-4089-a47b-35b5d9eb7645	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-24 01:56:49.44529+00	
00000000-0000-0000-0000-000000000000	f8aeba1f-2e9c-45fd-ab8d-a8dacf96fffa	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-01-24 06:13:16.092497+00	
00000000-0000-0000-0000-000000000000	72143921-6d86-4cb7-bb3d-7bf39bb6654b	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-01-24 06:13:16.117693+00	
00000000-0000-0000-0000-000000000000	87ef753b-f7f5-4be1-90da-e072323d3bb9	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 15:21:53.797864+00	
00000000-0000-0000-0000-000000000000	73516583-e654-4a0b-9f4d-9010a769c924	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 15:21:53.828398+00	
00000000-0000-0000-0000-000000000000	6181ffeb-2885-43af-821c-724b95a8370d	{"action":"token_refreshed","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 15:22:08.092935+00	
00000000-0000-0000-0000-000000000000	cfdd875a-7965-48eb-8ff4-16437a36b08b	{"action":"token_revoked","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 15:22:08.094245+00	
00000000-0000-0000-0000-000000000000	93df1d05-c029-4a68-83e2-4314be2b8946	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 16:21:30.538219+00	
00000000-0000-0000-0000-000000000000	de60ff95-146d-477b-ac07-4a005f729eb9	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 16:21:30.564083+00	
00000000-0000-0000-0000-000000000000	4e65b477-f056-461a-87f1-5e1bc49ab5f4	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"jringo303@gmail.com","user_id":"a15c4057-0295-4815-b537-28a72c79911e","user_phone":""}}	2026-01-26 18:53:45.931501+00	
00000000-0000-0000-0000-000000000000	73432d31-b0c8-42fe-a4be-d7f61cd20bb8	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"joelchan@umd.edu","user_id":"b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c","user_phone":""}}	2026-01-26 18:54:39.73721+00	
00000000-0000-0000-0000-000000000000	144cdaab-5c5c-4960-a480-ada69b9c7174	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"maparent@conversence.com","user_id":"f58c6eb0-ad49-43b6-998b-c5deeac7bf59","user_phone":""}}	2026-01-26 18:56:11.157807+00	
00000000-0000-0000-0000-000000000000	a73f2b23-b314-4de8-b34c-85e7ac2cd973	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"ronen@cosmik.network","user_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","user_phone":""}}	2026-01-26 18:57:01.821319+00	
00000000-0000-0000-0000-000000000000	9b2eed70-56bc-4a39-8d9f-9862352edb05	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 19:02:32.132529+00	
00000000-0000-0000-0000-000000000000	5fb9fb93-e250-4b97-a7d2-01a35b044ef1	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 19:02:32.15078+00	
00000000-0000-0000-0000-000000000000	9b5dc1e4-d0b3-4d2b-a371-a0e10d0a445d	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 20:02:27.174755+00	
00000000-0000-0000-0000-000000000000	e076bab6-a0e5-4afa-ad60-007c7715e6cb	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 20:02:27.194128+00	
00000000-0000-0000-0000-000000000000	a1026fd6-f537-40c9-8d09-eba7b07dcd20	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 21:01:54.506447+00	
00000000-0000-0000-0000-000000000000	fef87810-ec50-4c1d-86ec-6fdc775003fe	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 21:01:54.518941+00	
00000000-0000-0000-0000-000000000000	6b40f8af-a0d6-41dd-a412-6dd0b55d6627	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 22:07:47.810554+00	
00000000-0000-0000-0000-000000000000	6629f032-079c-41d1-9110-c8c4897670d0	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-26 22:07:47.8358+00	
00000000-0000-0000-0000-000000000000	ac12eb14-371e-4777-b728-d1563bbf436a	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-29 13:42:14.006458+00	
00000000-0000-0000-0000-000000000000	a5791c72-fdd0-477c-8450-f317a8af325d	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-29 13:42:14.031025+00	
00000000-0000-0000-0000-000000000000	99c91a93-e6cc-43c3-8b40-e0849c2fd8ac	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-29 13:44:31.883037+00	
00000000-0000-0000-0000-000000000000	6eecff42-bda9-438a-9bd1-1bee9e56d3d7	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-29 13:44:31.89583+00	
00000000-0000-0000-0000-000000000000	43d227c6-92d6-4304-9425-ba6cf49ea10e	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-29 17:35:02.936116+00	
00000000-0000-0000-0000-000000000000	6ea1ed8d-3201-4413-9144-58184ded94d6	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-29 17:35:02.959846+00	
00000000-0000-0000-0000-000000000000	1755d272-e32b-4483-9352-105e31c1715f	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 14:01:38.874888+00	
00000000-0000-0000-0000-000000000000	4b215bdf-7aa1-4ffb-827d-a1acda59731b	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 14:01:38.903999+00	
00000000-0000-0000-0000-000000000000	fbd5810a-c6a0-42cc-98fc-3d29e6666544	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 14:04:19.390987+00	
00000000-0000-0000-0000-000000000000	aacee4bb-73b7-486c-b76e-fc7e2284da21	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 14:04:19.400867+00	
00000000-0000-0000-0000-000000000000	84e1693a-088d-4e06-843b-17e00873e886	{"action":"logout","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account"}	2026-01-30 14:25:46.953425+00	
00000000-0000-0000-0000-000000000000	f1fb5360-1e98-40f9-9cb5-76d5dd8115c9	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-30 14:26:30.888702+00	
00000000-0000-0000-0000-000000000000	949c1110-483a-469f-93aa-079b957822b2	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 16:40:47.975337+00	
00000000-0000-0000-0000-000000000000	10e72195-f5c6-4e06-946e-c1937f20f796	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 16:40:47.997314+00	
00000000-0000-0000-0000-000000000000	367aa678-2885-4e39-b22e-4e5562964f01	{"action":"token_refreshed","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 16:57:02.186704+00	
00000000-0000-0000-0000-000000000000	768b8de1-f077-4bd2-86bd-f46a5cee6f17	{"action":"token_revoked","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 16:57:02.199148+00	
00000000-0000-0000-0000-000000000000	0d94186b-fded-40b4-aafa-74362f85734b	{"action":"token_refreshed","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 17:55:32.596616+00	
00000000-0000-0000-0000-000000000000	b22da703-5887-45ac-80b2-89a4794620f4	{"action":"token_revoked","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 17:55:32.611053+00	
00000000-0000-0000-0000-000000000000	d0b8d7f3-6f4b-4c05-8a5d-d20aa0d0f6ef	{"action":"token_refreshed","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 18:54:07.962588+00	
00000000-0000-0000-0000-000000000000	70cb52aa-168e-4566-89dc-b130c79198de	{"action":"token_revoked","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 18:54:07.975968+00	
00000000-0000-0000-0000-000000000000	e767c79f-6530-4f61-b152-739fef0d099f	{"action":"token_refreshed","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 20:10:06.441911+00	
00000000-0000-0000-0000-000000000000	ed036796-0f7d-467b-8e48-1d1a2423c469	{"action":"token_revoked","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-01-30 20:10:06.462089+00	
00000000-0000-0000-0000-000000000000	72adcb00-5589-4b38-95bd-2bb3776ef07c	{"action":"login","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-01 19:43:25.995487+00	
00000000-0000-0000-0000-000000000000	864d117a-015d-44e3-8381-b53211a4efb4	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-01 20:41:51.363849+00	
00000000-0000-0000-0000-000000000000	b0626e1c-a2e9-4f1b-8d4e-fbc1d2d050bf	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-01 20:41:51.386513+00	
00000000-0000-0000-0000-000000000000	86633b88-6bf0-4a91-beec-6f8f9be5027b	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-01 21:40:10.036774+00	
00000000-0000-0000-0000-000000000000	6442e54d-6778-41a8-83e3-262e63564169	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-01 21:40:10.0526+00	
00000000-0000-0000-0000-000000000000	887b9c0c-523f-4884-8a91-01cfb7e1431c	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-01 22:38:40.266483+00	
00000000-0000-0000-0000-000000000000	f6c664f7-dd72-463e-b162-fe4a98781b60	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-01 22:38:40.288818+00	
00000000-0000-0000-0000-000000000000	63274a71-f109-4ac5-9295-e15a4d915a5a	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-01 23:37:10.179538+00	
00000000-0000-0000-0000-000000000000	072f72aa-ce08-409a-9383-032b77e8e958	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-01 23:37:10.195023+00	
00000000-0000-0000-0000-000000000000	a7d3e2b0-7b9a-478d-9dc7-3729a163b2c7	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-02 00:35:39.904393+00	
00000000-0000-0000-0000-000000000000	cba54d99-76db-43ac-80af-8c1079e70a4e	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-02 00:35:39.925483+00	
00000000-0000-0000-0000-000000000000	34209610-dd19-46a8-b1ed-6823a9939040	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-02 01:33:40.234821+00	
00000000-0000-0000-0000-000000000000	e8da81dc-1b13-42c6-a9d7-b9888ded602d	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-02 01:33:40.254201+00	
00000000-0000-0000-0000-000000000000	b4693741-6b66-4d51-b836-91f0aac34f5b	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-02 02:32:10.107325+00	
00000000-0000-0000-0000-000000000000	f267547a-be43-42bc-abd4-065ed8ce68ee	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-02 02:32:10.121635+00	
00000000-0000-0000-0000-000000000000	8c2ce7ba-f8f4-42d5-8480-7278c17b54ca	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 04:14:35.075435+00	
00000000-0000-0000-0000-000000000000	61c74cf8-4cae-46bc-98e7-a6dcc3645168	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 05:12:53.252168+00	
00000000-0000-0000-0000-000000000000	c593066e-b52c-4294-822e-329a41bf88a6	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 05:12:53.274837+00	
00000000-0000-0000-0000-000000000000	595d69ca-fe4e-40c5-baac-ad9a5760dfcd	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 06:28:05.115182+00	
00000000-0000-0000-0000-000000000000	4895fdc3-3b94-476c-821c-4bac488f6253	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 06:28:05.1298+00	
00000000-0000-0000-0000-000000000000	c7ea161e-e578-4e2b-9e6f-029ae79d191d	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 07:26:17.88754+00	
00000000-0000-0000-0000-000000000000	5f0a0a8f-58a1-4740-a016-bdd9d99c977f	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 07:26:17.900815+00	
00000000-0000-0000-0000-000000000000	89734816-64d2-4371-b273-65b670eae7ab	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-02 11:38:22.481506+00	
00000000-0000-0000-0000-000000000000	6adbfef7-54ef-4853-98e8-2ce27d44cfcc	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-02 11:38:22.506714+00	
00000000-0000-0000-0000-000000000000	74746d5a-1765-4160-a38f-1e99ca97ef83	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 17:54:55.201208+00	
00000000-0000-0000-0000-000000000000	ebf93b31-6b6c-4f2a-a159-56584af73710	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 17:54:55.220603+00	
00000000-0000-0000-0000-000000000000	88c89a4a-f5f1-4df9-b1f7-97cd8ec750b5	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-02 17:59:25.420278+00	
00000000-0000-0000-0000-000000000000	bba2374f-3b84-413d-96fa-49d0f6442102	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 18:53:04.803091+00	
00000000-0000-0000-0000-000000000000	deeb97e5-f47c-4966-a984-b8560500fd28	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 18:53:04.823093+00	
00000000-0000-0000-0000-000000000000	033631d6-014e-4440-b115-9e6f89fd7e74	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 19:51:34.790896+00	
00000000-0000-0000-0000-000000000000	da51231f-8f1c-4c2d-bd0f-92b479762c08	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 19:51:34.806375+00	
00000000-0000-0000-0000-000000000000	504ad237-1ec1-4489-8663-5a5b708c7041	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-02 20:16:47.294178+00	
00000000-0000-0000-0000-000000000000	0d420341-48fe-4ce1-8ed7-6269cf2d117e	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-02 20:16:47.307029+00	
00000000-0000-0000-0000-000000000000	b0e7a590-b9c0-432d-8a55-8aa80ac40918	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 20:50:36.798324+00	
00000000-0000-0000-0000-000000000000	2dc11651-2688-4540-a209-e1a6d71e703c	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-02 20:50:36.818128+00	
00000000-0000-0000-0000-000000000000	58552be7-4dcf-4911-8102-6053d66af75a	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-03 02:15:39.733604+00	
00000000-0000-0000-0000-000000000000	43460910-1bd1-487a-b185-90be1328f7ce	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-03 02:15:39.75962+00	
00000000-0000-0000-0000-000000000000	987e8a55-e9c6-4cde-a24a-7d045f0fa856	{"action":"login","actor_id":"b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c","actor_username":"joelchan@umd.edu","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-03 02:53:29.338692+00	
00000000-0000-0000-0000-000000000000	9323ef7a-ace3-4c02-847f-38a90b03b844	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 03:32:48.249731+00	
00000000-0000-0000-0000-000000000000	c7935de1-c28c-4983-b6fa-fd3b1dc466f9	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 03:32:48.261036+00	
00000000-0000-0000-0000-000000000000	00b5f06b-8f75-4ebc-a4ee-63c3c7f0d70d	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 04:48:28.237338+00	
00000000-0000-0000-0000-000000000000	7740fe06-8bad-4754-acb1-b93205dd77df	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 04:48:28.25776+00	
00000000-0000-0000-0000-000000000000	5023e56b-b1e7-449c-bc7d-b3b5ae82d30a	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 06:04:51.440995+00	
00000000-0000-0000-0000-000000000000	9a5c1060-116e-4dba-9bd9-0c8775c0c342	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 06:04:51.456562+00	
00000000-0000-0000-0000-000000000000	7b99287f-feb9-4752-b6bb-d0cea56601fd	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 08:01:56.45316+00	
00000000-0000-0000-0000-000000000000	482d3e70-3b26-4a34-a808-ad05ac1c7dca	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 08:01:56.473241+00	
00000000-0000-0000-0000-000000000000	4230dfb1-e293-4730-989f-4e20aef01ac9	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 09:10:30.488182+00	
00000000-0000-0000-0000-000000000000	a16595e3-26ae-4c87-81d7-90fff9c77a1b	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 09:10:30.510102+00	
00000000-0000-0000-0000-000000000000	552cbf6c-2be1-4a80-bafd-8fbdeefdd284	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-03 11:50:12.811334+00	
00000000-0000-0000-0000-000000000000	71fd0f04-eb6e-4297-ab18-9edd4e495da4	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-03 11:50:12.842016+00	
00000000-0000-0000-0000-000000000000	55beae60-aa31-4d32-a1aa-f67684660cb2	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-03 17:19:35.146354+00	
00000000-0000-0000-0000-000000000000	cb30d09f-f3fb-4df5-b259-51811f2ef19c	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-03 17:19:35.170455+00	
00000000-0000-0000-0000-000000000000	5424aae9-a1dd-439a-a6e4-4cfd5406b221	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 18:01:11.247347+00	
00000000-0000-0000-0000-000000000000	e1bead49-baaf-472f-a07a-afba11c9e1ef	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 18:01:11.265798+00	
00000000-0000-0000-0000-000000000000	315a1bd1-1da1-466b-a78f-5304db34d91d	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-03 19:24:02.608207+00	
00000000-0000-0000-0000-000000000000	dbcb8188-87b8-4a87-9f25-68f5f0937f14	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-03 19:24:02.626651+00	
00000000-0000-0000-0000-000000000000	cd82d8ee-2b0d-464f-b06e-c0692da06ea0	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 19:43:10.046146+00	
00000000-0000-0000-0000-000000000000	f066419e-55bd-486e-9f01-93627358631b	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 19:43:10.054736+00	
00000000-0000-0000-0000-000000000000	d9e00e8b-3fbf-4393-aa41-f9ed8d63977c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 20:52:30.174339+00	
00000000-0000-0000-0000-000000000000	bb8f6f94-cf4d-4047-a525-2612a12d38ec	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-03 20:52:30.198094+00	
00000000-0000-0000-0000-000000000000	7e66f617-87f9-4767-954f-8b47d3c22b04	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-04 00:17:10.358817+00	
00000000-0000-0000-0000-000000000000	93006063-f8a8-4fc6-bd8e-b3fb9ca7f3a9	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-04 00:17:10.376582+00	
00000000-0000-0000-0000-000000000000	5e2e7560-0d18-40d7-b05d-92e6dd960745	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-04 00:22:25.077127+00	
00000000-0000-0000-0000-000000000000	8379ba95-b0d5-4297-bbe6-232e9a62edbf	{"action":"token_refreshed","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-04 11:44:30.093162+00	
00000000-0000-0000-0000-000000000000	6e1a5214-4839-49ad-847c-f17ccf617d8d	{"action":"token_revoked","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"token"}	2026-02-04 11:44:30.115794+00	
00000000-0000-0000-0000-000000000000	e42d9884-03bb-4257-a3b8-57a036119b5c	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-04 13:51:51.640209+00	
00000000-0000-0000-0000-000000000000	385ae03e-3bf0-43be-b260-c14a3062be36	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-04 13:51:51.648824+00	
00000000-0000-0000-0000-000000000000	e6c19b8d-05bc-4e95-ad14-af603829ba56	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-04 19:32:52.425839+00	
00000000-0000-0000-0000-000000000000	b959fef7-039b-464d-ad27-c9ca484d03fe	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-04 19:32:52.445193+00	
00000000-0000-0000-0000-000000000000	3ece040d-8043-403d-8278-40ea6b9fec7d	{"action":"token_refreshed","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-04 20:00:49.576905+00	
00000000-0000-0000-0000-000000000000	2e5ac7d5-0549-4feb-baf6-0138a1feb075	{"action":"token_revoked","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-04 20:00:49.591248+00	
00000000-0000-0000-0000-000000000000	52e82e36-35bb-4d94-a676-97f4e394017d	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-04 20:07:09.08158+00	
00000000-0000-0000-0000-000000000000	e077ae8d-b6e8-41a1-af56-988387d27e82	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-04 20:07:09.092981+00	
00000000-0000-0000-0000-000000000000	64878f31-b0f3-4275-8620-622419dee892	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-04 20:30:58.316715+00	
00000000-0000-0000-0000-000000000000	512b1cb3-844d-48ec-ae48-c3d2ddd29827	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-04 20:30:58.327539+00	
00000000-0000-0000-0000-000000000000	396e1a6d-f8ad-4c00-a0d3-bf9bd70ccb85	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-04 21:05:32.196726+00	
00000000-0000-0000-0000-000000000000	d053c7f8-49a5-497c-9dbd-cbadd7a7fb1f	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-04 21:05:32.22182+00	
00000000-0000-0000-0000-000000000000	e65ccb6e-f685-43be-ae49-9ffaf6aed62b	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-04 22:04:04.456875+00	
00000000-0000-0000-0000-000000000000	2a9d04ea-157c-498a-b76d-5bec94386b72	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-04 22:04:04.478458+00	
00000000-0000-0000-0000-000000000000	894290ac-acc3-4445-8438-bc3d6961a66f	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-04 22:04:04.916582+00	
00000000-0000-0000-0000-000000000000	222c5e8f-c47a-40af-9c29-6d82461a8dd3	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-04 23:08:33.774718+00	
00000000-0000-0000-0000-000000000000	fbe1be0d-a375-48ff-8292-0897ec5d4946	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-04 23:08:33.792825+00	
00000000-0000-0000-0000-000000000000	5e36562c-494e-44df-933d-6eef53b6bee3	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 00:07:05.928432+00	
00000000-0000-0000-0000-000000000000	19126f21-49cf-4e9d-95b8-b15d1fff1821	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 00:07:05.941981+00	
00000000-0000-0000-0000-000000000000	497d05fb-37fd-4719-85f1-62e49f98cd46	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 01:06:28.282978+00	
00000000-0000-0000-0000-000000000000	b7f8b004-b28b-42b7-85f0-8d0ffb4f2947	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 01:06:28.295578+00	
00000000-0000-0000-0000-000000000000	f0d39dd6-0c1e-433e-ad57-5a42788ea44a	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 02:05:02.289648+00	
00000000-0000-0000-0000-000000000000	28038941-4d98-4eee-9e57-44461e957c8a	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 02:05:02.305562+00	
00000000-0000-0000-0000-000000000000	6a949162-d768-4659-84c8-2cde575c23fd	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 03:53:07.975922+00	
00000000-0000-0000-0000-000000000000	ea06bf1f-f8ad-48e2-9370-b4df91c5669e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 03:53:07.997358+00	
00000000-0000-0000-0000-000000000000	65bcfca8-74c2-4b45-8ebf-887d0317f841	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 04:54:27.459456+00	
00000000-0000-0000-0000-000000000000	b4f15e98-f9b3-48ff-8ae0-673ec34ff58e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 04:54:27.478163+00	
00000000-0000-0000-0000-000000000000	2b05ada1-2b78-4b91-9b24-0259f6d1398c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 06:05:25.560178+00	
00000000-0000-0000-0000-000000000000	02e4b4be-b90a-4046-af6f-5d7ecbb460f4	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 06:05:25.570728+00	
00000000-0000-0000-0000-000000000000	86665ffa-8d7b-4f07-a431-a2ec6a4101c1	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 07:19:45.591651+00	
00000000-0000-0000-0000-000000000000	4e3d3ffc-fc6a-4e51-a33e-d1bb8819de61	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 07:19:45.603775+00	
00000000-0000-0000-0000-000000000000	2d02a3f4-ffbe-44d8-a5e6-7a1c2856233c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 08:20:44.477948+00	
00000000-0000-0000-0000-000000000000	063aa927-3489-4384-b62c-279b6e73c68a	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 08:20:44.494372+00	
00000000-0000-0000-0000-000000000000	16bfdd16-af92-48e1-bac3-436036cd2b67	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 09:20:12.860344+00	
00000000-0000-0000-0000-000000000000	1ac9fac4-a513-4dca-b725-c8d2adfe080a	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 09:20:12.884244+00	
00000000-0000-0000-0000-000000000000	d71ae95b-84d0-47e8-9d80-a43b32143d2a	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 10:25:11.957271+00	
00000000-0000-0000-0000-000000000000	61256ebd-df85-48e5-9681-ab26acd0563e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 10:25:11.979421+00	
00000000-0000-0000-0000-000000000000	927c191d-6aa8-4c30-a178-9d3e47c2e785	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 11:26:05.948708+00	
00000000-0000-0000-0000-000000000000	68912535-1a94-4c05-b0ca-2727beacd333	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 11:26:05.966103+00	
00000000-0000-0000-0000-000000000000	6c998aee-f669-4698-9815-cbfd1486f243	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 12:26:37.027995+00	
00000000-0000-0000-0000-000000000000	b5acd28d-e8ac-457e-8b07-288b411bdce2	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 12:26:37.045433+00	
00000000-0000-0000-0000-000000000000	7918dfda-9146-491b-8905-39400cf8e075	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 12:26:38.422091+00	
00000000-0000-0000-0000-000000000000	2cc6eed2-1920-4fc3-a54e-32548577f751	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 13:30:28.178879+00	
00000000-0000-0000-0000-000000000000	86a2fc12-e2fb-4da9-8b35-03e05022f1f9	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 13:30:28.196562+00	
00000000-0000-0000-0000-000000000000	11d07647-4e13-4bf3-83d6-8ae637cc6e8b	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 14:32:21.247737+00	
00000000-0000-0000-0000-000000000000	b4950421-6137-4630-97ee-47186b0d6c6e	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 15:37:33.746392+00	
00000000-0000-0000-0000-000000000000	588b4039-c02e-452f-abc5-9a9d1aaba12e	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 16:46:00.577198+00	
00000000-0000-0000-0000-000000000000	e90c70f1-ff6a-4fb2-9d5d-52e2dde2d8f6	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 16:46:00.601377+00	
00000000-0000-0000-0000-000000000000	00f002ff-b0b9-4e13-8ede-07cf2c754dc5	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 18:05:08.179965+00	
00000000-0000-0000-0000-000000000000	3da2adb7-2587-4e5f-90cc-324f1b0ebcdd	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 18:05:08.19834+00	
00000000-0000-0000-0000-000000000000	08626f5f-5c42-4254-a015-db32982212bf	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 19:03:52.173647+00	
00000000-0000-0000-0000-000000000000	b167d9e4-a5fb-4956-9518-163b09335c83	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 19:03:52.183008+00	
00000000-0000-0000-0000-000000000000	2ae80ed7-0f50-480b-9eb9-561c77a4b34c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 20:03:21.60582+00	
00000000-0000-0000-0000-000000000000	0fc22433-16ad-40cd-b892-9462b405ac9a	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 20:03:21.619766+00	
00000000-0000-0000-0000-000000000000	386233cb-7b43-49f7-8432-968497063a34	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 20:03:21.890339+00	
00000000-0000-0000-0000-000000000000	fc71aab8-05d5-4a63-9025-8194354e6faf	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 21:02:21.74058+00	
00000000-0000-0000-0000-000000000000	5546510c-f1db-4364-968e-d6a92212e897	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 21:02:21.754086+00	
00000000-0000-0000-0000-000000000000	9b116ee7-749a-4b5c-be05-c020f2e23270	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 22:01:15.906877+00	
00000000-0000-0000-0000-000000000000	8018ede9-5530-4338-98c9-c9e48f0d994e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 22:01:15.919057+00	
00000000-0000-0000-0000-000000000000	2296fcbd-7e15-430d-b981-ece59bf75f06	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 23:12:55.993199+00	
00000000-0000-0000-0000-000000000000	63f1dd34-8b34-47eb-89d5-9217e3fe96b9	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-05 23:12:56.006739+00	
00000000-0000-0000-0000-000000000000	0e30ff0d-58a6-4563-a6b7-a320b8167e0d	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 00:28:57.576389+00	
00000000-0000-0000-0000-000000000000	ec9126d8-3d9b-4492-a81a-14e6fdd6beba	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 00:28:57.586145+00	
00000000-0000-0000-0000-000000000000	4f8ace76-d996-4628-b8e9-4e4edf7ffd9e	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 00:28:57.806655+00	
00000000-0000-0000-0000-000000000000	ab53bdca-0454-44cc-8980-e4275c311168	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 02:26:28.168074+00	
00000000-0000-0000-0000-000000000000	f42e6d95-ed1b-4d2c-9a76-1c987e93ddd4	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 02:26:28.177974+00	
00000000-0000-0000-0000-000000000000	eeb738b0-7884-4dfd-b820-58cec4f5853e	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 02:26:45.696988+00	
00000000-0000-0000-0000-000000000000	23d9f621-40b8-4b58-b4d5-d14baa56bfca	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 03:28:32.950711+00	
00000000-0000-0000-0000-000000000000	b7d036da-224d-454d-a4a9-060a4fc2a31c	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 03:28:32.964976+00	
00000000-0000-0000-0000-000000000000	609a62ef-e056-4a64-a6af-9a8c071cb981	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 04:38:10.269546+00	
00000000-0000-0000-0000-000000000000	056350a3-6f0d-405c-aa00-e11118d44c8f	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 04:38:10.286545+00	
00000000-0000-0000-0000-000000000000	e04c079a-4f0a-4313-9b80-a23bfa16f256	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 05:37:25.767997+00	
00000000-0000-0000-0000-000000000000	5228e403-e4c7-4d84-9705-7168eb5074d0	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 05:37:25.78147+00	
00000000-0000-0000-0000-000000000000	5636bcbe-d842-4b14-9e74-b0f483464fd2	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 06:35:27.391537+00	
00000000-0000-0000-0000-000000000000	d5cdd920-e30d-4457-b094-d16852a98ff5	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 06:35:27.408541+00	
00000000-0000-0000-0000-000000000000	e9ec8e46-f1fd-401a-8516-b6810bb5a487	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 07:34:13.911125+00	
00000000-0000-0000-0000-000000000000	b92c0105-9a72-4d75-adab-0f1293ebd825	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 07:34:13.932908+00	
00000000-0000-0000-0000-000000000000	bcc4379d-8631-413e-b13b-239b467eeb30	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 08:32:14.794545+00	
00000000-0000-0000-0000-000000000000	01492279-c928-4376-a58f-ef26c5388b74	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 08:32:14.812848+00	
00000000-0000-0000-0000-000000000000	314a6d7d-7b32-4bd4-8bad-f96cc630dc3e	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 09:30:59.735168+00	
00000000-0000-0000-0000-000000000000	fb3909d3-d24c-4d97-8f9a-057c89de375e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 09:30:59.755814+00	
00000000-0000-0000-0000-000000000000	99731660-57a8-4d7a-8414-fb8b5584c58d	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 10:29:50.735773+00	
00000000-0000-0000-0000-000000000000	74deecbd-072f-4305-a1de-9e612271e0e4	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 10:29:50.757402+00	
00000000-0000-0000-0000-000000000000	f275092f-ba1b-40e5-a826-2cbaa4990bf4	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-06 10:39:16.378337+00	
00000000-0000-0000-0000-000000000000	a89fbf78-ef12-4d20-bad9-652ede06d6bf	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-06 10:39:16.38614+00	
00000000-0000-0000-0000-000000000000	4ce35069-3d46-4af0-b7e6-9358bf05a914	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 11:28:25.790526+00	
00000000-0000-0000-0000-000000000000	653ab794-9d9a-49f9-89e0-7e7b00c25d1b	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 11:28:25.80365+00	
00000000-0000-0000-0000-000000000000	84d10907-d59d-4b44-b167-543f00df72e2	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 11:28:26.030142+00	
00000000-0000-0000-0000-000000000000	5b5d9f60-aec2-450a-bbbd-1ed745744934	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-06 12:08:03.461848+00	
00000000-0000-0000-0000-000000000000	69c9c1ab-1451-447b-98f6-a81c46cf9098	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 12:27:25.717844+00	
00000000-0000-0000-0000-000000000000	4e25e84c-0e47-4ff2-b6c3-84bbbc3f1b80	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 12:27:25.732529+00	
00000000-0000-0000-0000-000000000000	4b694c34-33d5-4dae-b890-7bcf50387fc5	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-06 12:58:01.494131+00	
00000000-0000-0000-0000-000000000000	22e99e96-ef96-4369-952c-ae43360acdaa	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-06 12:58:01.505232+00	
00000000-0000-0000-0000-000000000000	dc256527-b3ed-4600-8949-e8a5d5466ef2	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 13:26:02.717367+00	
00000000-0000-0000-0000-000000000000	daca2976-73c0-4fe9-a829-e15c1557b50d	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 13:26:02.736033+00	
00000000-0000-0000-0000-000000000000	f66e11f2-fe2c-480c-9521-4916a6e2b4ae	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 14:25:25.756918+00	
00000000-0000-0000-0000-000000000000	86ca0264-1e50-4f9d-b6d2-9c8f92a51d7c	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 14:25:25.769989+00	
00000000-0000-0000-0000-000000000000	aa84bb3d-1917-426b-9784-67824de1f8b1	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-06 14:33:57.882775+00	
00000000-0000-0000-0000-000000000000	e0d73fdb-9f8f-4608-bd3c-7892ec8ac044	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-06 14:33:57.888018+00	
00000000-0000-0000-0000-000000000000	26eb523e-8140-4d99-9887-fff6a8198eb2	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-06 14:33:58.1306+00	
00000000-0000-0000-0000-000000000000	055531d8-644f-49fb-b51e-6d409d470565	{"action":"logout","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account"}	2026-02-06 14:33:59.883678+00	
00000000-0000-0000-0000-000000000000	17f5dcbe-8470-4a3a-90a0-f266a444a391	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-06 14:36:49.031273+00	
00000000-0000-0000-0000-000000000000	7180e49d-8d85-4b06-a3bd-2fa16abfab49	{"action":"user_signedup","actor_id":"36e37288-a28f-45b8-b257-f2beeda6cd92","actor_username":"jon@endowment.dev","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-06 14:56:20.878631+00	
00000000-0000-0000-0000-000000000000	5e098a45-ee7b-49d4-80f2-eb9e62b06141	{"action":"login","actor_id":"36e37288-a28f-45b8-b257-f2beeda6cd92","actor_username":"jon@endowment.dev","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-06 14:56:20.892488+00	
00000000-0000-0000-0000-000000000000	25e7431d-7087-4726-800c-d011cbbf7c44	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"jon@endowment.dev","user_id":"36e37288-a28f-45b8-b257-f2beeda6cd92","user_phone":""}}	2026-02-06 14:58:30.278242+00	
00000000-0000-0000-0000-000000000000	1622259c-cdb9-4b9f-aabd-cc4f0e7cab91	{"action":"user_signedup","actor_id":"cf35aa0e-f188-44cc-8154-6b188110bfd4","actor_username":"jon@endowment.dev","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-06 15:15:44.625062+00	
00000000-0000-0000-0000-000000000000	98c0c6c0-6925-42c8-847a-ce7676adeded	{"action":"login","actor_id":"cf35aa0e-f188-44cc-8154-6b188110bfd4","actor_username":"jon@endowment.dev","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-06 15:15:44.646543+00	
00000000-0000-0000-0000-000000000000	b428e96c-2939-4d99-bf1a-71389c05b62b	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 15:24:25.429582+00	
00000000-0000-0000-0000-000000000000	92b7f4b3-852c-44cc-b9cc-87e73cbe1142	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 15:24:25.432371+00	
00000000-0000-0000-0000-000000000000	72eda4fa-1db9-4ac9-a962-15281e2e6f81	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 16:23:25.986561+00	
00000000-0000-0000-0000-000000000000	016468b0-970a-4f1e-ba75-c46a36ff2011	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 16:23:26.011176+00	
00000000-0000-0000-0000-000000000000	20616cdf-ed6c-495a-8338-b421af3ff961	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 17:22:26.219148+00	
00000000-0000-0000-0000-000000000000	bdd3d4be-4f3f-4137-9294-eaa50c8501bf	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 17:22:26.238709+00	
00000000-0000-0000-0000-000000000000	a9b8c2c5-276d-4416-91a1-e5087d1803f9	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-06 18:08:08.075927+00	
00000000-0000-0000-0000-000000000000	5b5fd7a1-25cf-4bfd-aae1-af8c9aeff0e5	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-06 18:08:08.080296+00	
00000000-0000-0000-0000-000000000000	2a222d2f-7f1e-441c-af48-e17dae30a9fa	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 18:21:25.760436+00	
00000000-0000-0000-0000-000000000000	e9c2abe0-3572-4885-89b9-dedc77d50e47	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 18:21:25.770974+00	
00000000-0000-0000-0000-000000000000	424c5db0-8923-48b8-86cb-7c4bf8e200ee	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 19:19:45.348543+00	
00000000-0000-0000-0000-000000000000	d695a537-ec90-46ef-aebf-ba699d446364	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 19:19:45.37318+00	
00000000-0000-0000-0000-000000000000	d32000eb-0eab-4393-b522-0bde06ed16fd	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 20:18:44.118315+00	
00000000-0000-0000-0000-000000000000	5391d12f-307f-4b03-bd85-0d1a6534b465	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 20:18:44.136834+00	
00000000-0000-0000-0000-000000000000	105657c7-e78b-4137-ae7a-14fd431dcf9e	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 20:18:44.571941+00	
00000000-0000-0000-0000-000000000000	e053175c-d5c1-42c4-a259-020dc56ef129	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-06 20:50:59.676352+00	
00000000-0000-0000-0000-000000000000	de8dbd00-4900-47ab-b7a4-a1dfe8b2e446	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-06 20:50:59.690903+00	
00000000-0000-0000-0000-000000000000	44c0e1a7-6544-4b21-ab36-a2fd71e6bd99	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 21:17:21.580447+00	
00000000-0000-0000-0000-000000000000	d5de8c6a-736d-4a1c-a71e-02f0c3e36dbc	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 21:17:21.598277+00	
00000000-0000-0000-0000-000000000000	c99f00d2-84f3-4aad-b9c8-f9070bdc7b0a	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 21:17:21.813762+00	
00000000-0000-0000-0000-000000000000	6fb91d13-70f4-436c-9a44-e23eb7d3de31	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 22:16:21.452274+00	
00000000-0000-0000-0000-000000000000	f6adcc1e-74fc-4747-ab1f-1ccf27651e5e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 22:16:21.465751+00	
00000000-0000-0000-0000-000000000000	a82a1d7a-2890-44b1-a7be-a23ad8357a84	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-06 22:35:59.27354+00	
00000000-0000-0000-0000-000000000000	d8d96c40-0a87-4a53-a586-1ab019d71e66	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-06 22:35:59.284561+00	
00000000-0000-0000-0000-000000000000	02a535d9-1d47-4940-9a0d-2d0affbba26a	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"jon@endowment.dev","user_id":"cf35aa0e-f188-44cc-8154-6b188110bfd4","user_phone":""}}	2026-02-06 22:36:41.733229+00	
00000000-0000-0000-0000-000000000000	9e215900-234f-427c-83d9-fc3471eab1bc	{"action":"user_signedup","actor_id":"629bfa5c-5449-4583-8358-08335293caba","actor_username":"nokome@stencila.io","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-06 22:40:41.500139+00	
00000000-0000-0000-0000-000000000000	16448ea2-2e97-4b69-b7fb-8ae734f1e02d	{"action":"login","actor_id":"629bfa5c-5449-4583-8358-08335293caba","actor_username":"nokome@stencila.io","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-06 22:40:41.524846+00	
00000000-0000-0000-0000-000000000000	ad9eee87-6a64-422d-8f7c-c0fa20885df3	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 23:15:21.409376+00	
00000000-0000-0000-0000-000000000000	ca5719b6-dfea-4c23-a995-e5b853959a56	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-06 23:15:21.436989+00	
00000000-0000-0000-0000-000000000000	ef0c9209-29a6-40cc-91a2-a2f047b8d544	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 00:13:53.409693+00	
00000000-0000-0000-0000-000000000000	0e13dc2f-7d9e-4e99-90b5-def5cdaa8d61	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 00:13:53.429464+00	
00000000-0000-0000-0000-000000000000	35a69cef-df05-4120-94c4-cdb053326771	{"action":"user_signedup","actor_id":"2333c58f-094b-4dbb-9d56-347d134feda7","actor_username":"wesley@cosmik.network","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-07 00:35:59.063171+00	
00000000-0000-0000-0000-000000000000	61275901-39f0-47c3-ba8b-445f3ae1eec1	{"action":"login","actor_id":"2333c58f-094b-4dbb-9d56-347d134feda7","actor_username":"wesley@cosmik.network","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-07 00:35:59.079756+00	
00000000-0000-0000-0000-000000000000	bb4a11bb-0119-4526-9941-f6ce3bfaa1e1	{"action":"user_signedup","actor_id":"6f6fa59c-20ad-41b9-9f63-421dee593357","actor_username":"a.campbell@digital-science.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-07 00:51:08.02734+00	
00000000-0000-0000-0000-000000000000	71f9d9fc-76ef-4766-ae50-b9c8dd1701ce	{"action":"login","actor_id":"6f6fa59c-20ad-41b9-9f63-421dee593357","actor_username":"a.campbell@digital-science.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-07 00:51:08.041679+00	
00000000-0000-0000-0000-000000000000	cf251561-38f7-49ae-aaa3-6f90f4cbb3a3	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 01:12:35.270134+00	
00000000-0000-0000-0000-000000000000	559d449c-2a5b-4534-aa7b-4e8a89b4b871	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 01:12:35.297565+00	
00000000-0000-0000-0000-000000000000	bd458904-befd-452c-b830-1e31fc70b710	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 02:31:56.625166+00	
00000000-0000-0000-0000-000000000000	12c27eac-15f6-4fd9-bbc3-02c777141e55	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 02:31:56.64349+00	
00000000-0000-0000-0000-000000000000	5368b32b-c65e-4f45-99c0-7d5162590dfd	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 03:35:28.077886+00	
00000000-0000-0000-0000-000000000000	88471f40-f463-4c76-8c99-83a8a707769f	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 03:35:28.090879+00	
00000000-0000-0000-0000-000000000000	d1d20dce-e676-4e47-a94c-e8e9a6915bd3	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 03:35:28.321761+00	
00000000-0000-0000-0000-000000000000	9cb2dc30-d56c-454e-b164-6e39391eb1cb	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 04:33:44.879956+00	
00000000-0000-0000-0000-000000000000	98f34eb3-1cc3-47b9-8bd9-32e823699a1f	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 04:33:44.900863+00	
00000000-0000-0000-0000-000000000000	9594595f-9d52-4e26-b4ff-bdc09d2af76b	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 05:31:56.984794+00	
00000000-0000-0000-0000-000000000000	9a9eed4c-5a1d-4623-8063-025fa0bbf5cd	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 05:31:57.000315+00	
00000000-0000-0000-0000-000000000000	575fad39-0149-4ae6-aee3-eca50c1ca6f7	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 06:30:19.737805+00	
00000000-0000-0000-0000-000000000000	067aaef3-f9b7-49be-a632-54117ef6340b	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 06:30:19.753369+00	
00000000-0000-0000-0000-000000000000	2a398ca3-8e4d-463b-824f-0ac1429a65ba	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 07:29:18.0356+00	
00000000-0000-0000-0000-000000000000	81d02fea-7544-4eb8-9605-4c40152bbff3	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 07:29:18.046101+00	
00000000-0000-0000-0000-000000000000	9df743c3-a45a-4d4b-a0e2-02b4bcddee6f	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 08:28:18.181393+00	
00000000-0000-0000-0000-000000000000	82be597b-ec09-474e-aaa5-c8ef2686918c	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 08:28:18.200911+00	
00000000-0000-0000-0000-000000000000	673e1c3a-e0c3-4fd4-999e-aa4910d298d0	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 09:27:18.389762+00	
00000000-0000-0000-0000-000000000000	eba011ce-af2c-4f14-bb34-edb0784f5923	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 09:27:18.408128+00	
00000000-0000-0000-0000-000000000000	f274533c-a0c2-43cf-80b1-f7af51fe222f	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 10:26:18.357458+00	
00000000-0000-0000-0000-000000000000	5ab66f6f-58cb-4afb-a4ee-a674971c6b05	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 10:26:18.382128+00	
00000000-0000-0000-0000-000000000000	388207ef-c7db-45a4-ba3a-c669f19bae60	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-07 11:12:39.134333+00	
00000000-0000-0000-0000-000000000000	1c63e241-f840-4586-aab5-e92d76f34726	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-07 11:12:39.142143+00	
00000000-0000-0000-0000-000000000000	c736583f-9f63-4e47-a527-fbfbd6a23f07	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 11:25:18.145151+00	
00000000-0000-0000-0000-000000000000	f1a23367-6281-42c9-9b77-e529621355d9	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 11:25:18.168118+00	
00000000-0000-0000-0000-000000000000	524881bf-d74c-4787-9806-71e84c1cf1ad	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 12:24:18.386882+00	
00000000-0000-0000-0000-000000000000	b895c6e4-ec6a-488d-995d-6cb875b7178f	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 12:24:18.4027+00	
00000000-0000-0000-0000-000000000000	7d125aca-cc63-4ad8-9b55-440d0dc68bd9	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 13:23:18.355706+00	
00000000-0000-0000-0000-000000000000	62ffd30b-204d-45f8-8763-014b53b6187c	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 13:23:18.38318+00	
00000000-0000-0000-0000-000000000000	fd68fe45-4506-4cb9-a340-b1b72b37702f	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 14:22:18.325228+00	
00000000-0000-0000-0000-000000000000	7f7a8608-ce76-48b7-afd3-e8c6d667249b	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 14:22:18.345046+00	
00000000-0000-0000-0000-000000000000	6cc1b039-0a67-44ce-b1fb-f4cd4960ac79	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 15:21:18.394589+00	
00000000-0000-0000-0000-000000000000	1a23cc6d-26b3-4cab-8e6f-c45438d76ae2	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 15:21:18.424949+00	
00000000-0000-0000-0000-000000000000	753c2053-4c47-456a-a84c-2614fc40a166	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 16:20:18.311172+00	
00000000-0000-0000-0000-000000000000	c6a520da-ba66-49a4-a0dc-b57649812186	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 16:20:18.322154+00	
00000000-0000-0000-0000-000000000000	4bea9541-379e-42dc-83cb-42d6e0b05217	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 17:19:18.289032+00	
00000000-0000-0000-0000-000000000000	62a63ef0-ed34-4c03-a24b-8f4b17d0b2fe	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 17:19:18.302701+00	
00000000-0000-0000-0000-000000000000	fc5eaf8a-736d-4ac7-962e-ea487de8df61	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 18:18:18.267865+00	
00000000-0000-0000-0000-000000000000	ee1c9d9a-23dc-4d4b-8510-e9647c6c1534	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 18:18:18.281078+00	
00000000-0000-0000-0000-000000000000	699a0538-1ff4-4f20-ba78-589e2bf5faa8	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 19:17:18.284067+00	
00000000-0000-0000-0000-000000000000	00d83ed1-d290-482d-87a1-8af1d8b13036	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 19:17:18.297379+00	
00000000-0000-0000-0000-000000000000	77fdda24-eb3f-445f-9b24-068db2b37477	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 20:16:18.151136+00	
00000000-0000-0000-0000-000000000000	42842a1a-abbf-43c4-a961-35ef67a8ceda	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 20:16:18.169979+00	
00000000-0000-0000-0000-000000000000	ddccf32f-7d8f-4f29-b9f6-b9a65342df50	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 20:16:18.378358+00	
00000000-0000-0000-0000-000000000000	161813ac-e408-4e66-88f0-74ed2ff5f4d0	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 21:15:03.2574+00	
00000000-0000-0000-0000-000000000000	69519ae9-16ce-40dc-8612-15a32ee62389	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 21:15:03.275174+00	
00000000-0000-0000-0000-000000000000	775e36fa-5316-4715-9494-ae092001d096	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 22:13:49.089098+00	
00000000-0000-0000-0000-000000000000	dd3cb875-e887-4b52-9fc9-8b52a4e55d1b	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 22:13:49.102514+00	
00000000-0000-0000-0000-000000000000	21795353-a478-4ded-9e1d-d2d29a9b9331	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 23:12:01.943382+00	
00000000-0000-0000-0000-000000000000	abfd01ac-76b5-43e5-8bf8-9751215cd10b	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-07 23:12:01.958877+00	
00000000-0000-0000-0000-000000000000	1de87fba-ef25-4db2-bc52-d55f572d9a2b	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 00:10:01.999234+00	
00000000-0000-0000-0000-000000000000	4a5747d0-8ef3-4186-bc86-f17cb12d9fb0	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 00:10:02.014968+00	
00000000-0000-0000-0000-000000000000	80b97c28-832f-4235-a8b8-3feddb63e06c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 01:08:31.98184+00	
00000000-0000-0000-0000-000000000000	5ffe7ee5-692d-4048-9d46-e91bad04f852	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 01:08:31.995255+00	
00000000-0000-0000-0000-000000000000	00098b1d-b244-4759-a488-a5e005c68f2a	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 02:17:56.419691+00	
00000000-0000-0000-0000-000000000000	335107b1-1bc8-40f2-a54b-492fd5c681ae	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 02:17:56.430299+00	
00000000-0000-0000-0000-000000000000	46eab2bf-190f-42a7-8d05-794794b69168	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 03:17:15.548264+00	
00000000-0000-0000-0000-000000000000	852b53f4-6600-4bc9-97c5-48728aadb73f	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 03:17:15.559534+00	
00000000-0000-0000-0000-000000000000	d730dfc7-612f-423f-a510-41be6089a26d	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 04:15:48.439514+00	
00000000-0000-0000-0000-000000000000	74d59129-c008-482b-8a46-9726458ee7a9	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 04:15:48.451209+00	
00000000-0000-0000-0000-000000000000	7b1e7511-a717-4bff-a469-fd6e9e69eb81	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 05:17:03.623452+00	
00000000-0000-0000-0000-000000000000	b1c6c61d-e15a-4c75-979e-dd7cef204b8e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 05:17:03.636897+00	
00000000-0000-0000-0000-000000000000	c1a46d5c-e487-4c82-93b5-c23b3808d9a3	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 05:17:03.846715+00	
00000000-0000-0000-0000-000000000000	a6a1f396-2d15-45b2-8ce0-ed6aaf12ee41	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 06:27:16.315205+00	
00000000-0000-0000-0000-000000000000	5c8c7b63-9c2f-4556-af99-1e1b3abb1b0f	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 06:27:16.329984+00	
00000000-0000-0000-0000-000000000000	4af71412-7aa8-4f12-afe7-f409f8bcde9c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 07:26:13.845246+00	
00000000-0000-0000-0000-000000000000	9fdc78f4-1cd9-4db2-aac5-29f9117d179e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 07:26:13.864122+00	
00000000-0000-0000-0000-000000000000	fcce353b-9ac4-4eb9-a9b3-6c7a07eb3626	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 08:34:17.468904+00	
00000000-0000-0000-0000-000000000000	a80c8d93-4397-4d67-a950-b90f45cca660	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 08:34:17.493627+00	
00000000-0000-0000-0000-000000000000	62f4b066-9efd-4494-93ca-578cbf2b32e6	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 09:32:53.281078+00	
00000000-0000-0000-0000-000000000000	fe80081b-dc5c-467d-aed1-8a356b5af717	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 09:32:53.30733+00	
00000000-0000-0000-0000-000000000000	ea87594f-9427-497d-b951-fe51f0f0261b	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 10:34:21.826289+00	
00000000-0000-0000-0000-000000000000	811e91d4-42a0-473a-a615-deb42f986e16	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 10:34:21.856832+00	
00000000-0000-0000-0000-000000000000	8edc2946-23c2-4924-aa28-e67bfef86c2c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 11:33:36.020639+00	
00000000-0000-0000-0000-000000000000	0f50b1c7-c6fd-48c9-adc2-ccab88a824bf	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 11:33:36.033006+00	
00000000-0000-0000-0000-000000000000	5b6d9068-380f-4730-8510-b00cb071cb88	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 12:34:55.440879+00	
00000000-0000-0000-0000-000000000000	a4f65c02-ba79-4f92-9055-67e75bf8d758	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 12:34:55.458947+00	
00000000-0000-0000-0000-000000000000	97ce7e9c-1cc7-4eb6-9228-e376b6717d81	{"action":"login","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-08 13:13:50.742023+00	
00000000-0000-0000-0000-000000000000	ce98af8a-cb1b-4663-95a7-f479ee5b59fb	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 13:34:03.94546+00	
00000000-0000-0000-0000-000000000000	fcf15452-ee66-4c50-b30f-3212227e2b60	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 13:34:03.962453+00	
00000000-0000-0000-0000-000000000000	c0e4aee3-ce90-43f5-ab11-c6dd52c2db7b	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 14:41:42.543042+00	
00000000-0000-0000-0000-000000000000	42e1b736-4e94-4933-b6d0-cf09086efd56	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 14:41:42.555142+00	
00000000-0000-0000-0000-000000000000	6666ac13-6160-4993-890f-fefe2a9459de	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 15:47:49.550624+00	
00000000-0000-0000-0000-000000000000	da82cf16-b1b9-4bf8-ab2c-1c611fd94319	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 15:47:49.577966+00	
00000000-0000-0000-0000-000000000000	bde0f19d-f32d-4724-b1e0-7b9226fd7a8a	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 16:57:23.372491+00	
00000000-0000-0000-0000-000000000000	a434a9e1-1d7d-4624-a588-5c39c62bbcf8	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 16:57:23.390001+00	
00000000-0000-0000-0000-000000000000	f140e2c2-ac79-4e42-a9c4-70e720bf2c5f	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 17:55:55.704984+00	
00000000-0000-0000-0000-000000000000	a4a94e56-2859-476c-83cb-60addbc0c525	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 17:55:55.716971+00	
00000000-0000-0000-0000-000000000000	c7504292-cb8a-4faf-af35-4cb9b40eb4b1	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 17:55:56.204121+00	
00000000-0000-0000-0000-000000000000	8abee703-8967-4215-ad16-ac3243c8cba3	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 18:54:32.903024+00	
00000000-0000-0000-0000-000000000000	7269b276-266c-402b-b909-931d44ad3721	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 18:54:32.915191+00	
00000000-0000-0000-0000-000000000000	d6317ebe-4e75-4e57-bdb9-428ec403d47a	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 19:53:33.012451+00	
00000000-0000-0000-0000-000000000000	5e262063-8615-4342-936c-933c26adf5e1	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 19:53:33.026122+00	
00000000-0000-0000-0000-000000000000	7c1b4d44-89d0-4a74-a20d-016b7a7516f8	{"action":"user_signedup","actor_id":"0d886fc7-1b47-4870-bcb2-eff7cbed5950","actor_username":"ellie.rennie@rmit.edu.au","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-08 20:20:59.460306+00	
00000000-0000-0000-0000-000000000000	b2bac0b7-4a66-4e9f-80bd-aa1b3488313e	{"action":"login","actor_id":"0d886fc7-1b47-4870-bcb2-eff7cbed5950","actor_username":"ellie.rennie@rmit.edu.au","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-08 20:20:59.487825+00	
00000000-0000-0000-0000-000000000000	3fed77e0-5f78-474f-96f9-c10df28b5b8c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 20:52:11.868529+00	
00000000-0000-0000-0000-000000000000	1a351fdb-b607-475f-9853-030484ad5b51	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 20:52:11.889793+00	
00000000-0000-0000-0000-000000000000	1a0e21b0-7a77-4456-bc6f-f813044f161f	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 20:52:12.102409+00	
00000000-0000-0000-0000-000000000000	c219d500-dec5-4b8b-a20b-44e721c5c17c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 21:50:53.957019+00	
00000000-0000-0000-0000-000000000000	9117fe88-6ff7-4422-8f91-9f1d541a315e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 21:50:53.973577+00	
00000000-0000-0000-0000-000000000000	f2cc0b8b-68d6-49fe-9cd4-40656cc8dfa9	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 21:50:54.219559+00	
00000000-0000-0000-0000-000000000000	64ee46eb-c5ca-49ea-a717-5acf67e4a9ed	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 22:49:54.046645+00	
00000000-0000-0000-0000-000000000000	a3add1fd-e415-47a9-aec5-d5fcc9524443	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 22:49:54.066837+00	
00000000-0000-0000-0000-000000000000	6aac2a29-6da4-48f9-9911-68d552dd1ece	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 23:47:55.516849+00	
00000000-0000-0000-0000-000000000000	428b7976-bc71-4d41-9a09-8b2f3f9dc1d7	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-08 23:47:55.53539+00	
00000000-0000-0000-0000-000000000000	2d61375c-c0fe-4ae8-8613-14c004f64b38	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 02:10:10.62818+00	
00000000-0000-0000-0000-000000000000	a96bc02d-84f2-49af-8cdd-eae9e2705016	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 02:10:10.638048+00	
00000000-0000-0000-0000-000000000000	6e923faa-a036-4c39-9774-9dfe9d739196	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 02:10:10.899923+00	
00000000-0000-0000-0000-000000000000	6b474c04-792f-4ec7-9a18-fa201b94f503	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 03:11:26.188679+00	
00000000-0000-0000-0000-000000000000	4f863933-e363-4d14-b492-7d7476f435aa	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 03:11:26.206034+00	
00000000-0000-0000-0000-000000000000	382339f9-f3b1-4ad7-a3c6-9836e898543f	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 03:11:26.782564+00	
00000000-0000-0000-0000-000000000000	749de5b7-5a0a-4d20-b252-f26d69f6c2a8	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 04:10:00.092021+00	
00000000-0000-0000-0000-000000000000	7d5c80e9-c35b-4c96-ac3b-6af067728f16	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 04:10:00.107587+00	
00000000-0000-0000-0000-000000000000	c9e5d1d0-9012-49e3-bb59-3d7c74d0f31c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 05:12:54.064605+00	
00000000-0000-0000-0000-000000000000	20d6c425-a6ec-4e7a-890e-4b4485bdd819	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 05:12:54.070238+00	
00000000-0000-0000-0000-000000000000	803dfaed-8579-4df3-b689-47b087fe2523	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 06:13:34.459078+00	
00000000-0000-0000-0000-000000000000	d342b51d-b63e-405b-b208-2c3c86243a33	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 06:13:34.474791+00	
00000000-0000-0000-0000-000000000000	6dede837-5ae7-44f7-9cc6-f6b9c21bc8a7	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 07:14:46.730103+00	
00000000-0000-0000-0000-000000000000	53cd9b93-2b1b-418f-af58-5df7bc7edb31	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 07:14:46.753962+00	
00000000-0000-0000-0000-000000000000	60bddf97-ce0a-49a8-99d9-11b6696773f7	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 08:13:24.657635+00	
00000000-0000-0000-0000-000000000000	1f8031d0-364c-4dba-b03c-908bcc760bf6	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 08:13:24.679728+00	
00000000-0000-0000-0000-000000000000	53c16ab0-dde5-4586-a8f1-a3fdc908fa76	{"action":"user_signedup","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 08:36:17.721692+00	
00000000-0000-0000-0000-000000000000	5ce214b9-dbf5-41f9-9dee-a9790a29ae43	{"action":"login","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 08:36:17.747038+00	
00000000-0000-0000-0000-000000000000	617d1bd2-e4be-487a-a3b7-81bb745a94b9	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 09:12:24.787794+00	
00000000-0000-0000-0000-000000000000	a2a2ff9d-f57e-4f0d-a185-60cd097cc28d	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 09:12:24.810095+00	
00000000-0000-0000-0000-000000000000	ec87bc3e-0e3f-4236-80d8-45deeb07c42a	{"action":"token_refreshed","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 09:34:41.675154+00	
00000000-0000-0000-0000-000000000000	d9c228c0-0545-4e4e-891d-7d850a921f91	{"action":"token_revoked","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 09:34:41.687328+00	
00000000-0000-0000-0000-000000000000	6e8ca85f-0fcf-4955-a75f-f77f11d9e083	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 10:23:26.327012+00	
00000000-0000-0000-0000-000000000000	47a49412-2463-483d-b1bd-c50ba223a84c	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 10:23:26.348724+00	
00000000-0000-0000-0000-000000000000	07b81629-f631-466f-bc4a-3372b392cb85	{"action":"token_refreshed","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 10:32:42.272951+00	
00000000-0000-0000-0000-000000000000	f5fcde95-ce5b-431e-a7ba-d388ef35e55a	{"action":"token_revoked","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 10:32:42.275717+00	
00000000-0000-0000-0000-000000000000	c42ac07c-380b-4ab1-b2a5-6e719d8c11c4	{"action":"token_refreshed","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 11:30:43.588832+00	
00000000-0000-0000-0000-000000000000	40c1526e-e980-4a3a-a643-a027a2c40ead	{"action":"token_revoked","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 11:30:43.605101+00	
00000000-0000-0000-0000-000000000000	047ca932-5b1e-4899-be1f-604efb99668d	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 11:31:10.348535+00	
00000000-0000-0000-0000-000000000000	700cfa9b-fd93-44e1-a3ff-1c6281a2025c	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 11:31:10.350009+00	
00000000-0000-0000-0000-000000000000	5d68edf9-eed8-4686-88d7-082f73339b7a	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-09 11:56:27.422399+00	
00000000-0000-0000-0000-000000000000	675012a4-a1e8-49d5-b66f-5f793f770295	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-09 11:56:27.427893+00	
00000000-0000-0000-0000-000000000000	ef8dba6b-e8c0-49e3-b812-9cc07b13c936	{"action":"token_refreshed","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 12:29:12.505094+00	
00000000-0000-0000-0000-000000000000	33f50452-c3e3-487f-b366-989b7d71320c	{"action":"token_revoked","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 12:29:12.523647+00	
00000000-0000-0000-0000-000000000000	ee3cf571-55d1-42c8-a541-3ff8831410ce	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 12:39:54.943981+00	
00000000-0000-0000-0000-000000000000	e31a60ac-90f6-4c8d-b5cd-47d9f83c2fcc	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 12:39:54.949826+00	
00000000-0000-0000-0000-000000000000	c86480ec-5ccf-4bf8-b16a-97750e0f4827	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-09 13:24:07.926439+00	
00000000-0000-0000-0000-000000000000	2a52b391-1e94-4f05-85ed-a0e98c243b24	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-09 13:24:07.942304+00	
00000000-0000-0000-0000-000000000000	a90bbd05-b7fb-425f-8803-dd4c31619778	{"action":"token_refreshed","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 13:30:52.649148+00	
00000000-0000-0000-0000-000000000000	985f4c4d-32a2-425f-8c95-13cc99dd674b	{"action":"token_revoked","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 13:30:52.654016+00	
00000000-0000-0000-0000-000000000000	cc599d4e-fe5e-4b9f-a2cf-dcc3c0d78824	{"action":"user_signedup","actor_id":"a07197c2-3744-40a0-b6d8-252769eae979","actor_username":"shaobsh@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 13:47:00.671225+00	
00000000-0000-0000-0000-000000000000	c4fd3398-2760-46ae-a1a6-48c5b96759eb	{"action":"login","actor_id":"a07197c2-3744-40a0-b6d8-252769eae979","actor_username":"shaobsh@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 13:47:00.687268+00	
00000000-0000-0000-0000-000000000000	2fa7277b-5339-464c-b09a-a4e52a79acba	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 13:48:18.673691+00	
00000000-0000-0000-0000-000000000000	e805b615-c8c0-4be3-ab38-e3bbdbf6c045	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 13:48:18.675385+00	
00000000-0000-0000-0000-000000000000	28a05732-e6c7-4c5f-b7cb-162b865af5d9	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 14:59:39.984312+00	
00000000-0000-0000-0000-000000000000	af2b56c3-f73b-4688-9d82-7f589e2415c0	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 14:59:40.007379+00	
00000000-0000-0000-0000-000000000000	bdf141ec-aca0-494c-ae29-e2a964657e3a	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-09 15:38:35.641191+00	
00000000-0000-0000-0000-000000000000	a4180adb-eee7-48a8-a85d-a1f2c90a4146	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-09 15:38:35.65576+00	
00000000-0000-0000-0000-000000000000	1114041d-69a2-4561-b044-ebf2c497cb7d	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 15:58:30.453871+00	
00000000-0000-0000-0000-000000000000	fce316e2-fc2a-4b8f-b427-d64f2d5c3e30	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 15:58:30.471123+00	
00000000-0000-0000-0000-000000000000	7cda52e5-ed6c-40db-a00a-d4e010df8bdd	{"action":"user_repeated_signup","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-02-09 16:17:24.812004+00	
00000000-0000-0000-0000-000000000000	2df47813-a11f-4223-85b0-d94ee05fb43b	{"action":"login","actor_id":"66586d4d-ad06-48ca-b937-c2bbde17f36a","actor_username":"ronen@cosmik.network","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 16:18:50.759705+00	
00000000-0000-0000-0000-000000000000	d2856906-e4ca-44f3-8450-01fecf06fd7e	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 16:59:34.50755+00	
00000000-0000-0000-0000-000000000000	15bf176b-7f95-432e-b3af-cde529bf5eb4	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 16:59:34.524807+00	
00000000-0000-0000-0000-000000000000	8a8a06ae-ad2d-48c8-8ae9-6dad2bb0e272	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 17:58:39.972807+00	
00000000-0000-0000-0000-000000000000	5ed52112-c408-4e6d-ac80-d4278a1b0efc	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 17:58:39.988163+00	
00000000-0000-0000-0000-000000000000	17320a95-5ab1-45c9-b794-3984e0154f19	{"action":"user_signedup","actor_id":"0c1a8cff-b719-4e94-966d-22e8fce601ed","actor_username":"luke@block.science","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-09 18:33:59.348536+00	
00000000-0000-0000-0000-000000000000	bfa5d91a-75b4-4c72-9b5d-38d1539f65d4	{"action":"login","actor_id":"0c1a8cff-b719-4e94-966d-22e8fce601ed","actor_username":"luke@block.science","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-09 18:33:59.367347+00	
00000000-0000-0000-0000-000000000000	01b6e914-ba3b-40fe-ad10-16ce1e62f3aa	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 18:57:46.592916+00	
00000000-0000-0000-0000-000000000000	d83d9c9a-492c-418c-9540-8e861ca8c1ac	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 18:57:46.615167+00	
00000000-0000-0000-0000-000000000000	7cd7d43d-f430-4455-be57-be87828d3ca4	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 18:57:46.847034+00	
00000000-0000-0000-0000-000000000000	8af06beb-62c2-4f32-9313-dfb71f056da0	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 19:56:46.570381+00	
00000000-0000-0000-0000-000000000000	ccfb95cf-90a7-4dac-85aa-59e5cb3394e3	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 19:56:46.580009+00	
00000000-0000-0000-0000-000000000000	2b22273b-10d9-44dd-a269-e1c4abf7ba2d	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 20:55:05.007698+00	
00000000-0000-0000-0000-000000000000	ef9e6a31-364e-4ad4-b649-67148006102a	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 20:55:05.014171+00	
00000000-0000-0000-0000-000000000000	f3a69d7e-8d7c-4f6e-8007-7859c038d65f	{"action":"token_refreshed","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 21:26:28.116122+00	
00000000-0000-0000-0000-000000000000	bb2d4dab-ca22-4f2b-9e87-506417b3a84e	{"action":"token_revoked","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 21:26:28.125198+00	
00000000-0000-0000-0000-000000000000	52acc0ca-bf9a-43c9-82cb-4c27c17d8ee5	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 21:53:28.060999+00	
00000000-0000-0000-0000-000000000000	92d216cc-5a61-477b-9e61-5a5e7409dfae	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 21:53:28.074674+00	
00000000-0000-0000-0000-000000000000	a5b99419-2954-42af-9970-6184428a6fc3	{"action":"token_refreshed","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 22:40:56.130256+00	
00000000-0000-0000-0000-000000000000	8aca3375-499a-4aea-8569-8855f2c55f50	{"action":"token_revoked","actor_id":"6a20c1a0-ee08-4708-84a7-2c7ad61b3041","actor_username":"m@jmartink.org","actor_via_sso":false,"log_type":"token"}	2026-02-09 22:40:56.147088+00	
00000000-0000-0000-0000-000000000000	0bee9f02-0983-4b02-98df-a050539d6401	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 23:05:53.507366+00	
00000000-0000-0000-0000-000000000000	5209d8a7-7291-4792-a797-e0382e2a2218	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 23:05:53.537037+00	
00000000-0000-0000-0000-000000000000	cbc2aa66-e067-4f91-8025-f75dc5e492df	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-09 23:13:49.904739+00	
00000000-0000-0000-0000-000000000000	4633dc0a-7069-42a9-b2db-865cf2719868	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 00:12:50.654298+00	
00000000-0000-0000-0000-000000000000	fa0de2e4-8f16-49dc-b982-80a418b5a7a3	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 00:12:50.666309+00	
00000000-0000-0000-0000-000000000000	a272429b-bb75-403e-899c-c075c755b765	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 02:23:55.804845+00	
00000000-0000-0000-0000-000000000000	364d3896-2c3e-4bc6-928d-64698d0755cc	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 02:23:55.823144+00	
00000000-0000-0000-0000-000000000000	193b81aa-346a-4a7e-8252-5e45de73a5db	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 02:23:59.442474+00	
00000000-0000-0000-0000-000000000000	c8b4663b-f2dc-4e03-a39c-6a9cb7273c42	{"action":"user_signedup","actor_id":"03583b49-b454-4903-9ec9-180a20a40946","actor_username":"rodrigo.miguelesramirez@mail.mcgill.ca","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 03:30:14.108509+00	
00000000-0000-0000-0000-000000000000	2ffdfb8a-ff50-412f-8397-a860ddc929e3	{"action":"login","actor_id":"03583b49-b454-4903-9ec9-180a20a40946","actor_username":"rodrigo.miguelesramirez@mail.mcgill.ca","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 03:30:14.130726+00	
00000000-0000-0000-0000-000000000000	21c510ca-7185-436a-bf65-ab9b23a1e0bc	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 03:39:32.30729+00	
00000000-0000-0000-0000-000000000000	b78ae417-d532-4171-a497-0d739458eb6b	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 03:39:32.311816+00	
00000000-0000-0000-0000-000000000000	a8db8618-91c1-4211-bed0-fd0694cef6ea	{"action":"token_refreshed","actor_id":"0d886fc7-1b47-4870-bcb2-eff7cbed5950","actor_username":"ellie.rennie@rmit.edu.au","actor_via_sso":false,"log_type":"token"}	2026-02-10 04:10:18.159277+00	
00000000-0000-0000-0000-000000000000	8e23395a-3583-4624-8faa-7e1632d70def	{"action":"token_revoked","actor_id":"0d886fc7-1b47-4870-bcb2-eff7cbed5950","actor_username":"ellie.rennie@rmit.edu.au","actor_via_sso":false,"log_type":"token"}	2026-02-10 04:10:18.17965+00	
00000000-0000-0000-0000-000000000000	8438be6a-41e6-453b-8d96-2b3aacb2d94b	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 04:40:31.851686+00	
00000000-0000-0000-0000-000000000000	988ca630-ed8d-4451-a997-839139fd37f6	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 04:40:31.861668+00	
00000000-0000-0000-0000-000000000000	9be72cb7-0dfc-4b8f-872d-0d800e6a0f5b	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 05:39:14.867582+00	
00000000-0000-0000-0000-000000000000	0fe505fe-a6cb-497e-9881-1bc0a8fb24c4	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 05:39:14.882949+00	
00000000-0000-0000-0000-000000000000	fb2b1bb7-5a76-4a14-b17b-29c5bdfc64e9	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 06:42:48.604885+00	
00000000-0000-0000-0000-000000000000	613c92bc-c2f7-483e-a6f7-37b7e7c8cf18	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 06:42:48.615848+00	
00000000-0000-0000-0000-000000000000	e3866d7e-8329-4d83-9a20-88175b6f9c24	{"action":"user_signedup","actor_id":"5bda8e48-63ad-424b-ba4c-b6dc8d90d467","actor_username":"frida.arreytakubetang@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 07:34:57.784469+00	
00000000-0000-0000-0000-000000000000	56162768-1e4a-4803-842f-c9fc0948a224	{"action":"login","actor_id":"5bda8e48-63ad-424b-ba4c-b6dc8d90d467","actor_username":"frida.arreytakubetang@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 07:34:57.811888+00	
00000000-0000-0000-0000-000000000000	ebf53cae-9012-482e-8bab-b8194eb9f914	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 07:41:34.206562+00	
00000000-0000-0000-0000-000000000000	3e0dd4b4-96ce-481c-9187-afbbc9a93585	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 07:41:34.220728+00	
00000000-0000-0000-0000-000000000000	1e57ea49-05f5-4846-8307-c6aaf97550f1	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 08:40:18.364036+00	
00000000-0000-0000-0000-000000000000	5dab906d-2570-4eea-a0e0-8bd3eb2d246e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 08:40:18.376284+00	
00000000-0000-0000-0000-000000000000	cb429e5c-dc89-4b9c-b0b8-da41d081e134	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 08:40:18.604278+00	
00000000-0000-0000-0000-000000000000	1deadb7c-cf4e-43ca-9361-bd9e8bae2c32	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 09:50:38.535961+00	
00000000-0000-0000-0000-000000000000	0a8bf239-e6fa-40ec-96c3-27fb646e9b47	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 09:50:38.541635+00	
00000000-0000-0000-0000-000000000000	15dba590-6b62-4088-bf72-e2a026cb75ea	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 11:18:06.765053+00	
00000000-0000-0000-0000-000000000000	496bf68d-0ab7-43cb-9155-f8fe91546b42	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 11:18:06.791379+00	
00000000-0000-0000-0000-000000000000	ad2c20fa-7efa-481f-ab54-1ac4bee5afde	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 12:26:56.058468+00	
00000000-0000-0000-0000-000000000000	69127231-fded-4464-bccd-fb18b8525bb2	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 12:26:56.069481+00	
00000000-0000-0000-0000-000000000000	aaea4026-2a0b-4c34-b4b6-c43ee3cf02cc	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-10 13:47:16.794912+00	
00000000-0000-0000-0000-000000000000	d79c277e-3eb5-4e3c-b178-6cde157d1128	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-10 13:47:16.806728+00	
00000000-0000-0000-0000-000000000000	3cc1eadd-e249-46c0-8433-567daa745b73	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 13:51:47.22164+00	
00000000-0000-0000-0000-000000000000	a4701a2f-0deb-4dfa-a303-80166bfe68da	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 13:51:47.223253+00	
00000000-0000-0000-0000-000000000000	37bb644c-1a1f-4de5-bb9e-83a50a37f857	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 15:14:26.505741+00	
00000000-0000-0000-0000-000000000000	972c4f4d-40c3-473a-b410-7a064a680332	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 15:14:26.517629+00	
00000000-0000-0000-0000-000000000000	91fbbe2f-9805-4ce4-9b34-c3195f07b7be	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 16:15:24.04129+00	
00000000-0000-0000-0000-000000000000	44ae88e7-2cff-4ef9-9636-1383cc9f7e44	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 16:15:24.052236+00	
00000000-0000-0000-0000-000000000000	3d1dbee0-1c71-4704-94cb-397a7b73c4be	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 17:15:38.944426+00	
00000000-0000-0000-0000-000000000000	073f7890-7763-401b-a4b8-3ad08a1f6c43	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 17:15:38.956077+00	
00000000-0000-0000-0000-000000000000	13043a64-44b4-4840-a7dd-d4618fab1820	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 18:14:24.228196+00	
00000000-0000-0000-0000-000000000000	55215e58-1563-4155-b4c2-dbae793e1753	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 18:14:24.244659+00	
00000000-0000-0000-0000-000000000000	2843c669-5827-4f99-b1b0-0180996fff85	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 18:14:24.485845+00	
00000000-0000-0000-0000-000000000000	e55d90c2-be42-4e02-a120-2a0d9feffb6d	{"action":"token_refreshed","actor_id":"0d886fc7-1b47-4870-bcb2-eff7cbed5950","actor_username":"ellie.rennie@rmit.edu.au","actor_via_sso":false,"log_type":"token"}	2026-02-10 19:10:51.016152+00	
00000000-0000-0000-0000-000000000000	7c26b22a-fb1b-4ed6-ab67-70f5f74baab3	{"action":"token_revoked","actor_id":"0d886fc7-1b47-4870-bcb2-eff7cbed5950","actor_username":"ellie.rennie@rmit.edu.au","actor_via_sso":false,"log_type":"token"}	2026-02-10 19:10:51.029967+00	
00000000-0000-0000-0000-000000000000	d5e52b03-b7b7-48e3-9a18-bdfd4b70b6b4	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 19:13:23.872837+00	
00000000-0000-0000-0000-000000000000	581ae1b1-7f73-4c98-a6e6-fb7322e57728	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 19:13:23.883049+00	
00000000-0000-0000-0000-000000000000	9ebaad9a-ade3-482e-bba1-842dca8afe1c	{"action":"user_signedup","actor_id":"96f9bcb8-0ef8-465a-90d1-dc056c1f9554","actor_username":"monica@creativecommons.org","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-10 20:07:17.297463+00	
00000000-0000-0000-0000-000000000000	75909790-2b7f-4846-95ad-f9b27344a8f4	{"action":"login","actor_id":"96f9bcb8-0ef8-465a-90d1-dc056c1f9554","actor_username":"monica@creativecommons.org","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 20:07:17.312643+00	
00000000-0000-0000-0000-000000000000	00f648a2-325f-4d46-93ff-ca01d32be202	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 20:12:24.054487+00	
00000000-0000-0000-0000-000000000000	0b609812-4e27-4cbe-b08d-f71d93b151d7	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 20:12:24.066885+00	
00000000-0000-0000-0000-000000000000	7d3b14ca-373b-4d1a-8c2a-d9c5dc1af404	{"action":"token_refreshed","actor_id":"0d886fc7-1b47-4870-bcb2-eff7cbed5950","actor_username":"ellie.rennie@rmit.edu.au","actor_via_sso":false,"log_type":"token"}	2026-02-10 20:55:16.065968+00	
00000000-0000-0000-0000-000000000000	788af75a-2fc5-45af-92f6-48124565ac3f	{"action":"token_revoked","actor_id":"0d886fc7-1b47-4870-bcb2-eff7cbed5950","actor_username":"ellie.rennie@rmit.edu.au","actor_via_sso":false,"log_type":"token"}	2026-02-10 20:55:16.087155+00	
00000000-0000-0000-0000-000000000000	adce2004-3c9f-43e7-b405-46f590067d97	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 21:11:35.836841+00	
00000000-0000-0000-0000-000000000000	50070ec8-c918-43e2-9568-a8e97e845e16	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 21:11:35.848995+00	
00000000-0000-0000-0000-000000000000	e9622122-d80f-4c87-b879-ee4756bb35f7	{"action":"token_refreshed","actor_id":"0d886fc7-1b47-4870-bcb2-eff7cbed5950","actor_username":"ellie.rennie@rmit.edu.au","actor_via_sso":false,"log_type":"token"}	2026-02-10 22:00:11.69467+00	
00000000-0000-0000-0000-000000000000	de05f262-bffa-4e22-aedd-b24e7c065696	{"action":"token_revoked","actor_id":"0d886fc7-1b47-4870-bcb2-eff7cbed5950","actor_username":"ellie.rennie@rmit.edu.au","actor_via_sso":false,"log_type":"token"}	2026-02-10 22:00:11.70881+00	
00000000-0000-0000-0000-000000000000	8431b919-6c68-4c9d-bb59-a2fc3029118b	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 22:10:48.738274+00	
00000000-0000-0000-0000-000000000000	9471c2d1-4e5e-44af-8577-931ec84f313d	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 22:10:48.75697+00	
00000000-0000-0000-0000-000000000000	ec91a502-0878-4914-8224-76446c4bd8fd	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 23:09:43.131318+00	
00000000-0000-0000-0000-000000000000	22c3cfb8-5ff5-4a2d-a0a1-8195f33cb1a9	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-10 23:09:43.147539+00	
00000000-0000-0000-0000-000000000000	4f164400-fc29-4ef4-a751-5e24fb53b7c0	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 00:09:08.005578+00	
00000000-0000-0000-0000-000000000000	5a7b45b1-b003-411b-bb61-fdbe2dd0d6f7	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 00:09:08.015867+00	
00000000-0000-0000-0000-000000000000	8396c1cd-8229-419e-babc-3e0d43d8fccc	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 01:07:28.507604+00	
00000000-0000-0000-0000-000000000000	29c2e925-b160-4461-b2c2-c518917f3c40	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 01:07:28.521916+00	
00000000-0000-0000-0000-000000000000	19fdd9c0-abbe-49dc-9008-a70965883bb7	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 03:02:26.276301+00	
00000000-0000-0000-0000-000000000000	1936aa86-5b49-42e1-87ec-f3d377505568	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 03:02:26.292089+00	
00000000-0000-0000-0000-000000000000	8aeb0bef-b07f-4d50-bbdc-01015ab57b85	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 03:02:28.975592+00	
00000000-0000-0000-0000-000000000000	5db59873-357e-4901-9f88-006275d50c41	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 04:05:33.307339+00	
00000000-0000-0000-0000-000000000000	9ee53492-e441-48ac-b842-4f71b22c7962	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 04:05:33.31943+00	
00000000-0000-0000-0000-000000000000	78773da9-9b48-4762-9038-20b727fa2d79	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 05:04:04.86082+00	
00000000-0000-0000-0000-000000000000	0227d5c7-a49b-4ef5-934c-b9977dc6e34f	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 05:04:04.873048+00	
00000000-0000-0000-0000-000000000000	0957964c-68e2-402a-87bd-44fb0bee8cea	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 06:03:03.529262+00	
00000000-0000-0000-0000-000000000000	9b4213ac-4753-4045-a353-d5ce62d0358a	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 06:03:03.543803+00	
00000000-0000-0000-0000-000000000000	cb05ab3a-f845-4225-9bb4-a5704505ac35	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 06:03:03.785733+00	
00000000-0000-0000-0000-000000000000	7133a6de-4e21-405f-8e72-2c8751e7770c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 07:09:31.925067+00	
00000000-0000-0000-0000-000000000000	e14a30c5-4cd8-4696-a05a-21b8206b69b2	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 07:09:31.943686+00	
00000000-0000-0000-0000-000000000000	1fbb2aaf-d6fa-4511-be0a-83a852f3c155	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 08:07:35.977394+00	
00000000-0000-0000-0000-000000000000	fa3e7d63-7af6-4760-a442-cb7808ed705d	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 08:07:35.985832+00	
00000000-0000-0000-0000-000000000000	57b92b7b-62f0-4502-b127-32b75fc98ea0	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 09:19:39.662793+00	
00000000-0000-0000-0000-000000000000	91b3601a-ab57-440f-ae10-cb4e82130afc	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 09:19:39.675504+00	
00000000-0000-0000-0000-000000000000	d1f8b6b8-404e-4335-b43a-39cb48302897	{"action":"user_signedup","actor_id":"7de965d1-329b-4ee3-8814-7cfbb8291325","actor_username":"sekhar.ramakrishnan@astera.org","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-11 09:42:38.330032+00	
00000000-0000-0000-0000-000000000000	47bf96a4-0319-4b61-9bfe-628f38b9ffda	{"action":"login","actor_id":"7de965d1-329b-4ee3-8814-7cfbb8291325","actor_username":"sekhar.ramakrishnan@astera.org","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-11 09:42:38.352484+00	
00000000-0000-0000-0000-000000000000	debe4a3d-a2b7-4847-a9bf-0949b74fc3a4	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 10:18:21.552674+00	
00000000-0000-0000-0000-000000000000	b3ccb4ab-8f88-4f37-a481-c7cbb78eb078	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 10:18:21.576139+00	
00000000-0000-0000-0000-000000000000	67a89887-40ca-41b2-a461-195ef8d964ed	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 11:16:55.547913+00	
00000000-0000-0000-0000-000000000000	1629a95d-d68c-49fa-9baa-cc96215fc061	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 11:16:55.568478+00	
00000000-0000-0000-0000-000000000000	dfc9280d-4e9c-4d2b-a966-b152d90403fb	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 12:31:20.265013+00	
00000000-0000-0000-0000-000000000000	a6e4fb10-9535-4757-a763-aecc85b21183	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 12:31:20.280605+00	
00000000-0000-0000-0000-000000000000	46d80310-b810-43af-a942-99cc1bc0b013	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 13:38:45.234987+00	
00000000-0000-0000-0000-000000000000	e327483d-9dcd-4a88-a1a5-c476221b5b43	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 13:38:45.246519+00	
00000000-0000-0000-0000-000000000000	03b07395-253a-4e5f-a1e7-4fa884f27b16	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 13:38:45.463317+00	
00000000-0000-0000-0000-000000000000	53cfc75b-6f4e-400d-a334-2378ea26dbb4	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 14:37:58.25791+00	
00000000-0000-0000-0000-000000000000	49345a47-1960-4c06-8ccb-904e30954a31	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 14:37:58.273064+00	
00000000-0000-0000-0000-000000000000	8c3654e5-9ac8-417b-9c55-19e0bd4886a6	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 15:51:20.226804+00	
00000000-0000-0000-0000-000000000000	a7662ad8-e20a-49e1-adac-cdf33b212a99	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 15:51:20.236604+00	
00000000-0000-0000-0000-000000000000	632f9398-a59a-4fa8-8dcb-4d75546b397c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 16:50:34.544771+00	
00000000-0000-0000-0000-000000000000	e8cc83c6-3a37-4d3e-9472-acb4efa2d6bd	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 16:50:34.564755+00	
00000000-0000-0000-0000-000000000000	9f56d3ec-15e2-4bb0-a882-1fca99288b1c	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-11 17:33:48.29412+00	
00000000-0000-0000-0000-000000000000	e8892b0b-9557-42c3-9727-a1ba6fff14fe	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-11 17:33:48.311636+00	
00000000-0000-0000-0000-000000000000	af25af5b-57a1-4495-acfb-def84a53c232	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 19:58:27.845899+00	
00000000-0000-0000-0000-000000000000	3a3a8d2c-9c37-4559-9404-98c36dc9ae48	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 19:58:27.863514+00	
00000000-0000-0000-0000-000000000000	d9367fed-483b-4db4-b894-71d83316e6a0	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 19:58:39.863711+00	
00000000-0000-0000-0000-000000000000	1064bb35-b1ec-430c-a071-ec60432facf6	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 20:57:07.578546+00	
00000000-0000-0000-0000-000000000000	708df737-efc4-465a-9365-16929a562c3d	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 20:57:07.594569+00	
00000000-0000-0000-0000-000000000000	190ff8e6-2001-4227-9215-d8d35cbdf632	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 21:56:11.994168+00	
00000000-0000-0000-0000-000000000000	c48fb794-c67a-408e-b527-4236cf6d392e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 21:56:12.014602+00	
00000000-0000-0000-0000-000000000000	f23e1516-0ca7-4ba8-ba83-ee9bc410a6fa	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 22:59:49.287531+00	
00000000-0000-0000-0000-000000000000	82ea0036-c831-4c16-b5c3-b5a52e731758	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 22:59:49.305576+00	
00000000-0000-0000-0000-000000000000	27df8c32-b419-4b12-9577-ce3e9b533c99	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 23:58:16.445521+00	
00000000-0000-0000-0000-000000000000	3b40b8e4-5f49-4af7-9510-ad2982d52e10	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-11 23:58:16.460335+00	
00000000-0000-0000-0000-000000000000	e73c4909-4ca9-4940-8741-17dac3175045	{"action":"user_signedup","actor_id":"6f1ae888-314a-46df-9c74-05456d4c517d","actor_username":"morgan@quantumbiology.org","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-12 00:26:29.371121+00	
00000000-0000-0000-0000-000000000000	957c8f15-d900-48dc-9e47-a56aa9024fc3	{"action":"login","actor_id":"6f1ae888-314a-46df-9c74-05456d4c517d","actor_username":"morgan@quantumbiology.org","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-12 00:26:29.389819+00	
00000000-0000-0000-0000-000000000000	c7f27b81-6cca-4ffb-8b14-df2e36d4540c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 00:56:45.144102+00	
00000000-0000-0000-0000-000000000000	63c85070-e23d-4918-bc0a-efff1ec6ad24	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 00:56:45.164174+00	
00000000-0000-0000-0000-000000000000	d2c7aa9b-f14e-4257-9284-4cb8f3369adf	{"action":"user_signedup","actor_id":"e798443f-c72a-40aa-b351-84d285cb8dfc","actor_username":"antonmolina@bnext.bio","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-12 04:11:25.55704+00	
00000000-0000-0000-0000-000000000000	398f30c6-81f5-4b89-9f4c-054be5abbf84	{"action":"login","actor_id":"e798443f-c72a-40aa-b351-84d285cb8dfc","actor_username":"antonmolina@bnext.bio","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-12 04:11:25.58579+00	
00000000-0000-0000-0000-000000000000	9d2a99f0-a5ad-4763-8c9c-67c5b5b75a67	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 05:28:06.190305+00	
00000000-0000-0000-0000-000000000000	fab310cb-c33d-4fa2-abd0-124fa2a1417e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 05:28:06.214793+00	
00000000-0000-0000-0000-000000000000	46fa6e78-b0cc-4a3e-8938-73bee988a50b	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 06:26:36.32689+00	
00000000-0000-0000-0000-000000000000	c6e5c86a-4b99-482b-8122-d9aee3bfe617	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 06:26:36.347696+00	
00000000-0000-0000-0000-000000000000	b5987291-d2e6-4bb8-acd3-bfb93c9ea9ba	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 07:24:53.713797+00	
00000000-0000-0000-0000-000000000000	cb5d11a1-a712-4c36-a2f3-1e04c71ee5a2	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 07:24:53.725118+00	
00000000-0000-0000-0000-000000000000	7dff6212-f482-48ea-900d-5ad2a4bd6919	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 08:23:23.634322+00	
00000000-0000-0000-0000-000000000000	f3bf3d87-56e2-4537-aeae-d51d2eefd68e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 08:23:23.652382+00	
00000000-0000-0000-0000-000000000000	24b52731-f806-4302-848f-0abcf95423f8	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 09:21:32.873632+00	
00000000-0000-0000-0000-000000000000	5f2fdb11-8a70-4f57-9f47-3df1e1f72921	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 09:21:32.88599+00	
00000000-0000-0000-0000-000000000000	709b20bd-1f4b-4352-bb3b-fe669bc7054f	{"action":"token_refreshed","actor_id":"7de965d1-329b-4ee3-8814-7cfbb8291325","actor_username":"sekhar.ramakrishnan@astera.org","actor_via_sso":false,"log_type":"token"}	2026-02-12 14:54:43.742713+00	
00000000-0000-0000-0000-000000000000	ab6830d9-93b4-4a1b-bf5e-77db2f1b5580	{"action":"token_revoked","actor_id":"7de965d1-329b-4ee3-8814-7cfbb8291325","actor_username":"sekhar.ramakrishnan@astera.org","actor_via_sso":false,"log_type":"token"}	2026-02-12 14:54:43.768055+00	
00000000-0000-0000-0000-000000000000	c02422f8-3ca8-44fb-8649-992f9d164963	{"action":"token_refreshed","actor_id":"7de965d1-329b-4ee3-8814-7cfbb8291325","actor_username":"sekhar.ramakrishnan@astera.org","actor_via_sso":false,"log_type":"token"}	2026-02-12 15:53:11.498049+00	
00000000-0000-0000-0000-000000000000	3bbb3935-6ae8-4cab-8fae-8ff30a743e62	{"action":"token_revoked","actor_id":"7de965d1-329b-4ee3-8814-7cfbb8291325","actor_username":"sekhar.ramakrishnan@astera.org","actor_via_sso":false,"log_type":"token"}	2026-02-12 15:53:11.515658+00	
00000000-0000-0000-0000-000000000000	f3797a2d-a826-4a41-afd0-6b852bd0a2de	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 17:20:41.035173+00	
00000000-0000-0000-0000-000000000000	67e92c05-1519-45b8-8663-b2a6c13364b1	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 17:20:41.060318+00	
00000000-0000-0000-0000-000000000000	902060be-246a-44d7-ab3e-9ec62f9fad83	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 18:18:43.369815+00	
00000000-0000-0000-0000-000000000000	8b7b24fb-59cd-4e94-b929-eadc5fb28a85	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 18:18:43.385936+00	
00000000-0000-0000-0000-000000000000	15fa60ff-86bb-4ea5-a3cc-5c8723fae568	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-12 18:41:16.844412+00	
00000000-0000-0000-0000-000000000000	1907b632-8feb-4abe-83c8-bbcc67494392	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-12 18:41:16.862627+00	
00000000-0000-0000-0000-000000000000	830d9c6a-8883-4cad-9859-a63405fc4fff	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 19:23:59.234544+00	
00000000-0000-0000-0000-000000000000	b2eeb9cd-bf39-4fd7-bfb2-f9828af9620f	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 19:23:59.256422+00	
00000000-0000-0000-0000-000000000000	701d26ff-13ac-4354-8549-3ab5812128f0	{"action":"token_refreshed","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-12 19:36:16.750681+00	
00000000-0000-0000-0000-000000000000	3d43c6f1-df16-49bb-bee4-cc72ef454707	{"action":"token_revoked","actor_id":"562212e3-819d-4d8f-b03b-57a8c9427f72","actor_username":"ellie@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-12 19:36:16.762579+00	
00000000-0000-0000-0000-000000000000	d33ffefd-75c3-42a9-8429-026116740441	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-12 19:55:26.194612+00	
00000000-0000-0000-0000-000000000000	cad2d567-b4a6-453e-a208-498b1e91d6f3	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-12 19:55:26.21866+00	
00000000-0000-0000-0000-000000000000	48e77115-875c-4b65-81da-9da434d09830	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 20:46:07.068093+00	
00000000-0000-0000-0000-000000000000	fc448f40-ccf7-4655-9292-d8c69a5f3ab9	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-12 20:46:07.088489+00	
00000000-0000-0000-0000-000000000000	bcf65781-c10a-4846-971a-9a11b1f96719	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 05:26:59.528788+00	
00000000-0000-0000-0000-000000000000	13b85af2-89ad-4014-b013-38212ec13f00	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 05:26:59.549528+00	
00000000-0000-0000-0000-000000000000	3de6777d-f4dd-4105-961a-c49dfa0fa64d	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 07:35:10.003112+00	
00000000-0000-0000-0000-000000000000	762a7967-71c5-47e6-8aa0-2c0ea099d449	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 07:35:10.021343+00	
00000000-0000-0000-0000-000000000000	06be84ff-0092-43d9-8565-8e704fa8d624	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 17:57:42.357674+00	
00000000-0000-0000-0000-000000000000	35164d90-f85b-4c75-9197-c8a814a67264	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 17:57:42.38158+00	
00000000-0000-0000-0000-000000000000	11a1bbd7-a515-4a2d-b4c0-2682d631adaa	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 18:56:09.769682+00	
00000000-0000-0000-0000-000000000000	77dae058-2af9-4278-b223-a05b53a4ca29	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 18:56:09.780426+00	
00000000-0000-0000-0000-000000000000	edfb3332-d84e-435d-acbf-ac38e9b57f14	{"action":"token_refreshed","actor_id":"7de965d1-329b-4ee3-8814-7cfbb8291325","actor_username":"sekhar.ramakrishnan@astera.org","actor_via_sso":false,"log_type":"token"}	2026-02-13 19:02:15.596905+00	
00000000-0000-0000-0000-000000000000	1d432587-5217-45fb-9c35-49333c2fa762	{"action":"token_revoked","actor_id":"7de965d1-329b-4ee3-8814-7cfbb8291325","actor_username":"sekhar.ramakrishnan@astera.org","actor_via_sso":false,"log_type":"token"}	2026-02-13 19:02:15.600002+00	
00000000-0000-0000-0000-000000000000	3774c2f9-15ab-434e-9398-c7b095ce7b75	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 19:54:39.933741+00	
00000000-0000-0000-0000-000000000000	8ade6d88-5f80-47ee-ac20-96ed0e33af27	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 19:54:39.952024+00	
00000000-0000-0000-0000-000000000000	d23702a2-5308-4c30-8709-a3a06cb74ba2	{"action":"token_refreshed","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-13 20:47:05.707799+00	
00000000-0000-0000-0000-000000000000	dde408f4-e6aa-4743-a87a-85541b5d3d46	{"action":"token_revoked","actor_id":"cdd7c3e5-6e9e-4974-8f69-63e8608d19a9","actor_username":"jon@scios.tech","actor_via_sso":false,"log_type":"token"}	2026-02-13 20:47:05.717602+00	
00000000-0000-0000-0000-000000000000	98766945-bf06-4b18-a276-55d3345a3261	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 20:53:09.854329+00	
00000000-0000-0000-0000-000000000000	6d950e81-db95-49fd-8860-c0407c2d0952	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 20:53:09.864784+00	
00000000-0000-0000-0000-000000000000	f7e7d7ba-1e70-4cc1-9021-319296cdf6b8	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 21:51:38.365648+00	
00000000-0000-0000-0000-000000000000	c3032ead-2e7d-4ea9-a5ff-e95cd34b40e6	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-13 21:51:38.386712+00	
00000000-0000-0000-0000-000000000000	dfd3b98b-6281-40ca-8cf9-5e25842e2307	{"action":"user_signedup","actor_id":"10569c05-bf71-4e59-ac71-cdb731877e55","actor_username":"sean.moore3@mail.mcgill.ca","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-13 23:52:07.337985+00	
00000000-0000-0000-0000-000000000000	c5608ad6-3b70-497b-84b4-d9f6a214db78	{"action":"login","actor_id":"10569c05-bf71-4e59-ac71-cdb731877e55","actor_username":"sean.moore3@mail.mcgill.ca","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-13 23:52:07.354866+00	
00000000-0000-0000-0000-000000000000	1b7901b1-d457-4e08-aa94-2af1a6cb468c	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 00:39:12.044204+00	
00000000-0000-0000-0000-000000000000	0d12e4a8-44b0-4749-9106-651cfb47f426	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 00:39:12.075558+00	
00000000-0000-0000-0000-000000000000	2ece92b8-c9e4-4ac4-a825-f4fac3c77180	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 01:37:33.122056+00	
00000000-0000-0000-0000-000000000000	75c41e58-57e9-44ff-800b-6107102c61ff	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 01:37:33.137752+00	
00000000-0000-0000-0000-000000000000	c0301eb9-bad0-49a7-9a45-7d0a2e6c07d1	{"action":"user_signedup","actor_id":"9744a793-abb5-43a7-a8d6-2ed6b59c2ef9","actor_username":"hyunokate.lee@utoronto.ca","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-14 02:37:11.687826+00	
00000000-0000-0000-0000-000000000000	a9385989-ba34-4c47-84de-c266e80027b6	{"action":"login","actor_id":"9744a793-abb5-43a7-a8d6-2ed6b59c2ef9","actor_username":"hyunokate.lee@utoronto.ca","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-14 02:37:11.713161+00	
00000000-0000-0000-0000-000000000000	26a545d6-b35f-40bb-b639-39e5106aae1e	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 03:03:58.866386+00	
00000000-0000-0000-0000-000000000000	a2d9b209-d596-4da6-aea3-be9cc5e19144	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 03:03:58.892082+00	
00000000-0000-0000-0000-000000000000	1849d4d1-03dd-46d1-a6b8-bd2f660928e9	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 04:17:13.779893+00	
00000000-0000-0000-0000-000000000000	bb012009-4ba2-44c6-8f88-ed4edd93997e	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 04:17:13.797192+00	
00000000-0000-0000-0000-000000000000	792842fa-ff66-47de-a282-85537cb828e1	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 05:15:34.439293+00	
00000000-0000-0000-0000-000000000000	34cb6c43-c3db-4106-90bd-d6e23fdc2475	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 05:15:34.451671+00	
00000000-0000-0000-0000-000000000000	8d2940bc-7884-4a03-a047-589ae84f7ce9	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 06:13:54.12047+00	
00000000-0000-0000-0000-000000000000	f14aabe4-9669-4166-98c1-36239d7bfaa6	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 06:13:54.137773+00	
00000000-0000-0000-0000-000000000000	137bd107-9b7d-422b-aa49-2084c04e3a8e	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 07:21:58.729899+00	
00000000-0000-0000-0000-000000000000	1421ab26-d2af-4247-8596-1e2922b192c6	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 07:21:58.742994+00	
00000000-0000-0000-0000-000000000000	8f36b2a4-3c02-46af-a171-4b76b5f8124a	{"action":"token_refreshed","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 08:20:25.847319+00	
00000000-0000-0000-0000-000000000000	0d5a1a56-a3ed-4af7-9f55-71e52b232da2	{"action":"token_revoked","actor_id":"04807d9a-3e96-4a9e-a55d-b6e4ed75b50c","actor_username":"akamatsm@uw.edu","actor_via_sso":false,"log_type":"token"}	2026-02-14 08:20:25.862735+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	{"sub": "cdd7c3e5-6e9e-4974-8f69-63e8608d19a9", "name": "Jonathan Starr", "role": "participant", "email": "jon@scios.tech", "organization": "SciOS", "email_verified": false, "phone_verified": false}	email	2025-09-23 23:01:42.9148+00	2025-09-23 23:01:42.914862+00	2025-09-23 23:01:42.914862+00	34a6d7af-5f97-4465-af18-3b89cca74c96
562212e3-819d-4d8f-b03b-57a8c9427f72	562212e3-819d-4d8f-b03b-57a8c9427f72	{"sub": "562212e3-819d-4d8f-b03b-57a8c9427f72", "name": "Ellie DeSota", "role": "participant", "email": "ellie@scios.tech", "organization": "SciOS", "email_verified": false, "phone_verified": false}	email	2025-09-24 12:17:30.966342+00	2025-09-24 12:17:30.966393+00	2025-09-24 12:17:30.966393+00	cef1501c-8a5f-4926-9a95-529aca67ab3e
04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	{"sub": "04807d9a-3e96-4a9e-a55d-b6e4ed75b50c", "name": "Matt Akamatsu", "role": "participant", "email": "akamatsm@uw.edu", "organization": "Discourse Graphs project", "email_verified": false, "phone_verified": false}	email	2025-09-25 20:38:49.583673+00	2025-09-25 20:38:49.583727+00	2025-09-25 20:38:49.583727+00	e07b3f5f-a0cd-4b3b-861a-e9492872baf5
b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	{"sub": "b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c", "email": "joelchan@umd.edu", "email_verified": false, "phone_verified": false}	email	2026-01-26 18:54:39.731154+00	2026-01-26 18:54:39.732419+00	2026-01-26 18:54:39.732419+00	db92f766-acaf-4a19-90b1-9d5acf00f7ee
f58c6eb0-ad49-43b6-998b-c5deeac7bf59	f58c6eb0-ad49-43b6-998b-c5deeac7bf59	{"sub": "f58c6eb0-ad49-43b6-998b-c5deeac7bf59", "email": "maparent@conversence.com", "email_verified": false, "phone_verified": false}	email	2026-01-26 18:56:11.154388+00	2026-01-26 18:56:11.15444+00	2026-01-26 18:56:11.15444+00	9bf923f6-02ed-4a83-b572-64ba758b5a91
66586d4d-ad06-48ca-b937-c2bbde17f36a	66586d4d-ad06-48ca-b937-c2bbde17f36a	{"sub": "66586d4d-ad06-48ca-b937-c2bbde17f36a", "email": "ronen@cosmik.network", "email_verified": false, "phone_verified": false}	email	2026-01-26 18:57:01.819729+00	2026-01-26 18:57:01.820418+00	2026-01-26 18:57:01.820418+00	263b4d33-b527-42eb-a8b3-cf5f3e4f032a
629bfa5c-5449-4583-8358-08335293caba	629bfa5c-5449-4583-8358-08335293caba	{"sub": "629bfa5c-5449-4583-8358-08335293caba", "name": "Nokome Bentley", "role": "participant", "email": "nokome@stencila.io", "organization": "Stencila", "email_verified": false, "phone_verified": false}	email	2026-02-06 22:40:41.481104+00	2026-02-06 22:40:41.482411+00	2026-02-06 22:40:41.482411+00	0309962d-6650-4118-b4cb-b67843950561
2333c58f-094b-4dbb-9d56-347d134feda7	2333c58f-094b-4dbb-9d56-347d134feda7	{"sub": "2333c58f-094b-4dbb-9d56-347d134feda7", "name": "Wesley Finck", "role": "participant", "email": "wesley@cosmik.network", "organization": "Cosmik Network", "email_verified": false, "phone_verified": false}	email	2026-02-07 00:35:59.052475+00	2026-02-07 00:35:59.052526+00	2026-02-07 00:35:59.052526+00	004fe58c-ffeb-4c82-9a9e-28aade713e93
6f6fa59c-20ad-41b9-9f63-421dee593357	6f6fa59c-20ad-41b9-9f63-421dee593357	{"sub": "6f6fa59c-20ad-41b9-9f63-421dee593357", "name": "Ann Campbell", "role": "participant", "email": "a.campbell@digital-science.com", "organization": "Digital Science", "email_verified": false, "phone_verified": false}	email	2026-02-07 00:51:08.02317+00	2026-02-07 00:51:08.023217+00	2026-02-07 00:51:08.023217+00	c6ef18ca-fdbd-40d4-835b-0f151aff5405
0d886fc7-1b47-4870-bcb2-eff7cbed5950	0d886fc7-1b47-4870-bcb2-eff7cbed5950	{"sub": "0d886fc7-1b47-4870-bcb2-eff7cbed5950", "name": "Ellie Rennie", "role": "participant", "email": "ellie.rennie@rmit.edu.au", "organization": "RMIT University and Metagov", "email_verified": false, "phone_verified": false}	email	2026-02-08 20:20:59.449001+00	2026-02-08 20:20:59.449055+00	2026-02-08 20:20:59.449055+00	4ef9d0ab-79f7-47e7-bf38-6119cca65b89
6a20c1a0-ee08-4708-84a7-2c7ad61b3041	6a20c1a0-ee08-4708-84a7-2c7ad61b3041	{"sub": "6a20c1a0-ee08-4708-84a7-2c7ad61b3041", "name": "Martin Karlsson", "role": "participant", "email": "m@jmartink.org", "organization": "coordination.network", "email_verified": false, "phone_verified": false}	email	2026-02-09 08:36:17.704277+00	2026-02-09 08:36:17.704343+00	2026-02-09 08:36:17.704343+00	693fbbc9-ebf6-4f64-9f43-639a38a99d5b
a07197c2-3744-40a0-b6d8-252769eae979	a07197c2-3744-40a0-b6d8-252769eae979	{"sub": "a07197c2-3744-40a0-b6d8-252769eae979", "name": "Saif Haobsh", "role": "participant", "email": "shaobsh@gmail.com", "organization": "Fylo", "email_verified": false, "phone_verified": false}	email	2026-02-09 13:47:00.663279+00	2026-02-09 13:47:00.663331+00	2026-02-09 13:47:00.663331+00	37f55c6d-0c79-47bc-9209-81d5a451231c
0c1a8cff-b719-4e94-966d-22e8fce601ed	0c1a8cff-b719-4e94-966d-22e8fce601ed	{"sub": "0c1a8cff-b719-4e94-966d-22e8fce601ed", "name": "Luke Miller", "role": "participant", "email": "luke@block.science", "organization": "BlockScience, Metagov", "email_verified": false, "phone_verified": false}	email	2026-02-09 18:33:59.337244+00	2026-02-09 18:33:59.337293+00	2026-02-09 18:33:59.337293+00	d64984b7-e462-44e5-8b04-36bdbf0232db
03583b49-b454-4903-9ec9-180a20a40946	03583b49-b454-4903-9ec9-180a20a40946	{"sub": "03583b49-b454-4903-9ec9-180a20a40946", "name": "Rodrigo Migueles Ramirez", "role": "participant", "email": "rodrigo.miguelesramirez@mail.mcgill.ca", "organization": "McGill University", "email_verified": false, "phone_verified": false}	email	2026-02-10 03:30:14.095974+00	2026-02-10 03:30:14.096547+00	2026-02-10 03:30:14.096547+00	82fd1aea-d103-4dcb-b796-3f49604af098
5bda8e48-63ad-424b-ba4c-b6dc8d90d467	5bda8e48-63ad-424b-ba4c-b6dc8d90d467	{"sub": "5bda8e48-63ad-424b-ba4c-b6dc8d90d467", "name": "Frida Arrey Takubetang", "role": "participant", "email": "frida.arreytakubetang@gmail.com", "organization": "ReO:SciCDA", "email_verified": false, "phone_verified": false}	email	2026-02-10 07:34:57.770711+00	2026-02-10 07:34:57.770768+00	2026-02-10 07:34:57.770768+00	f1b20ea6-ff02-48fa-9f52-04cbc357e38d
96f9bcb8-0ef8-465a-90d1-dc056c1f9554	96f9bcb8-0ef8-465a-90d1-dc056c1f9554	{"sub": "96f9bcb8-0ef8-465a-90d1-dc056c1f9554", "name": "Monica Granados", "role": "participant", "email": "monica@creativecommons.org", "organization": "Creative Commons", "email_verified": false, "phone_verified": false}	email	2026-02-10 20:07:17.287188+00	2026-02-10 20:07:17.287237+00	2026-02-10 20:07:17.287237+00	a1fb7ca9-5082-4e80-9e3d-9f2af9adbad3
7de965d1-329b-4ee3-8814-7cfbb8291325	7de965d1-329b-4ee3-8814-7cfbb8291325	{"sub": "7de965d1-329b-4ee3-8814-7cfbb8291325", "name": "Chandrasekhar Ramakrishnan", "role": "participant", "email": "sekhar.ramakrishnan@astera.org", "organization": "Astera Institute", "email_verified": false, "phone_verified": false}	email	2026-02-11 09:42:38.322012+00	2026-02-11 09:42:38.322058+00	2026-02-11 09:42:38.322058+00	9043cd39-d711-4a96-864a-786b8e9c2063
6f1ae888-314a-46df-9c74-05456d4c517d	6f1ae888-314a-46df-9c74-05456d4c517d	{"sub": "6f1ae888-314a-46df-9c74-05456d4c517d", "name": "Morgan Sosa", "role": "participant", "email": "morgan@quantumbiology.org", "organization": "Quantum Biology Institute", "email_verified": false, "phone_verified": false}	email	2026-02-12 00:26:29.362149+00	2026-02-12 00:26:29.362199+00	2026-02-12 00:26:29.362199+00	7e1e61a4-2508-43b4-b919-0fb6ea71731d
e798443f-c72a-40aa-b351-84d285cb8dfc	e798443f-c72a-40aa-b351-84d285cb8dfc	{"sub": "e798443f-c72a-40aa-b351-84d285cb8dfc", "name": "Anton Molina", "role": "participant", "email": "antonmolina@bnext.bio", "organization": "b.next", "email_verified": false, "phone_verified": false}	email	2026-02-12 04:11:25.5479+00	2026-02-12 04:11:25.54795+00	2026-02-12 04:11:25.54795+00	20c081cc-09df-4a84-8ad3-47550979fb76
10569c05-bf71-4e59-ac71-cdb731877e55	10569c05-bf71-4e59-ac71-cdb731877e55	{"sub": "10569c05-bf71-4e59-ac71-cdb731877e55", "name": "Sean Moore", "role": "participant", "email": "sean.moore3@mail.mcgill.ca", "organization": "McGill", "email_verified": false, "phone_verified": false}	email	2026-02-13 23:52:07.326832+00	2026-02-13 23:52:07.326894+00	2026-02-13 23:52:07.326894+00	46b2ad60-14e7-4666-80f2-e2115771af05
9744a793-abb5-43a7-a8d6-2ed6b59c2ef9	9744a793-abb5-43a7-a8d6-2ed6b59c2ef9	{"sub": "9744a793-abb5-43a7-a8d6-2ed6b59c2ef9", "name": "Kate Lee", "role": "participant", "email": "hyunokate.lee@utoronto.ca", "organization": "U Toronto", "email_verified": false, "phone_verified": false}	email	2026-02-14 02:37:11.673663+00	2026-02-14 02:37:11.674282+00	2026-02-14 02:37:11.674282+00	dac1c65d-dd38-409d-86ce-2a90e5c0c555
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
564cfdd7-c0a7-4a81-9f33-4d6138a4bb18	2025-09-24 12:17:30.989891+00	2025-09-24 12:17:30.989891+00	password	401ba421-7c52-43a4-bfd1-edfe51f5b809
2d5f927a-d7d1-4d65-8475-896840b64ad7	2025-09-25 18:46:29.904237+00	2025-09-25 18:46:29.904237+00	password	026c961d-5342-4233-aa72-6a98479be2e4
66fa874d-067d-488c-8920-dc82cdf71148	2025-09-28 02:27:07.388692+00	2025-09-28 02:27:07.388692+00	password	9d4851a4-4941-4854-be60-881000440a60
76f651a3-b5db-477d-86e9-8d294743d603	2026-01-23 23:46:38.772132+00	2026-01-23 23:46:38.772132+00	password	511dbb28-1f3f-48ed-a498-3c7725d1bcc0
3ccf2776-a35b-49ea-8d96-d1e3856cb18b	2026-02-01 19:43:26.111426+00	2026-02-01 19:43:26.111426+00	password	838b6749-04f8-4295-90b5-b6551a3bdec5
6e414cc9-5d3e-4f10-99f0-fd27985c6946	2026-02-03 02:53:29.450364+00	2026-02-03 02:53:29.450364+00	password	6a23a6f5-9b13-468c-9757-11a31524ad4e
63069be8-d38d-49ed-97dc-fee50538a904	2026-02-06 14:36:49.046094+00	2026-02-06 14:36:49.046094+00	password	3f827666-0a34-4d17-b147-f64d47587fae
81c6cf9e-4d7d-4507-9cc1-24f886508399	2026-02-06 22:40:41.563699+00	2026-02-06 22:40:41.563699+00	password	06f863d6-250b-4cfe-960e-ce65b8c013aa
ea2ae44f-5f0c-4ba9-b12d-0fcbabb545ea	2026-02-07 00:35:59.10315+00	2026-02-07 00:35:59.10315+00	password	1eeaf0d2-38f6-4129-bbda-895859d86574
791b35d8-2260-481a-abb2-3c7fddcc7b66	2026-02-07 00:51:08.061871+00	2026-02-07 00:51:08.061871+00	password	703c46e6-3bad-413e-8253-df75b56785ac
b6df9d0f-d003-418b-b98d-eb0e5c9d50e0	2026-02-08 13:13:50.820256+00	2026-02-08 13:13:50.820256+00	password	f063fda4-f0ac-4a08-bb9c-8aaed22f19bf
d0796b3c-39ec-4227-84f7-23d8d454f019	2026-02-08 20:20:59.543176+00	2026-02-08 20:20:59.543176+00	password	559ea610-565b-4339-82d1-f99b03bf4878
4972410f-b644-40c4-ac8a-63255406b9f3	2026-02-09 08:36:17.770808+00	2026-02-09 08:36:17.770808+00	password	751325c0-76d9-4b08-a44a-f0b7b101bcda
ec011e00-3fb9-41c0-88b9-ecb453fd31fe	2026-02-09 13:47:00.728374+00	2026-02-09 13:47:00.728374+00	password	30452c65-4025-4853-9905-0a2eaa09cfe2
db42f3b0-0dee-43d1-bd4f-13c034cabda8	2026-02-09 16:18:50.807833+00	2026-02-09 16:18:50.807833+00	password	af02fefa-039a-4a3a-9baa-f68acb6a7a6a
74ff3cb0-eef3-47ad-b81d-858a6c7512b4	2026-02-09 18:33:59.409803+00	2026-02-09 18:33:59.409803+00	password	2f1da112-d148-4653-92f3-4063b031d9a2
7dfa4138-122f-42a1-88a8-205a85290624	2026-02-10 03:30:14.162884+00	2026-02-10 03:30:14.162884+00	password	8b553721-0dc8-4b41-b597-fe47a23981aa
a5e601d0-4af7-4311-898a-5ecf44820be4	2026-02-10 07:34:57.86511+00	2026-02-10 07:34:57.86511+00	password	5ab709db-b1ac-469f-8b42-97763aac4948
7a3a0917-a094-45bf-ab04-ce826c0efa57	2026-02-10 20:07:17.348413+00	2026-02-10 20:07:17.348413+00	password	977cc48b-ee9e-48c9-8270-e1324a76d326
4826e81c-61b7-49eb-8119-8b45d349e8cf	2026-02-11 09:42:38.406106+00	2026-02-11 09:42:38.406106+00	password	2366f841-2188-46ff-9601-4803ee1745a6
1686402a-05ca-41d7-9095-f384c435c645	2026-02-12 00:26:29.434297+00	2026-02-12 00:26:29.434297+00	password	c2e79add-aed9-485b-8d50-5502254abcba
9ea0f433-0606-49fa-9dda-560603218aae	2026-02-12 04:11:25.638454+00	2026-02-12 04:11:25.638454+00	password	535537c7-77e8-4f66-94e0-5c3d49c569e2
949f8cc6-84f1-419e-a2b9-46e54e3bc31d	2026-02-13 23:52:07.408458+00	2026-02-13 23:52:07.408458+00	password	2e2c51a0-f122-4f0f-8f82-7cb346b7bae0
08e0af12-fdbc-4a65-8103-b59ff2f93bb5	2026-02-14 02:37:11.751595+00	2026-02-14 02:37:11.751595+00	password	1f1b0ba9-5623-4799-bc18-ca3aed8389e6
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	217	iovjchyn2bk4	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 03:28:32.977437+00	2026-02-06 04:38:10.287202+00	xddjixzpgp4a	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	151	s4vidcdarl2i	562212e3-819d-4d8f-b03b-57a8c9427f72	t	2026-01-30 17:55:32.623394+00	2026-01-30 18:54:07.976543+00	r7yvqykkqej4	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	287	okzm7pxbtayp	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 11:33:36.048136+00	2026-02-08 12:34:55.461008+00	u2hz75l55bj7	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	189	tc3jhq6ncidf	562212e3-819d-4d8f-b03b-57a8c9427f72	t	2026-02-04 20:00:49.602059+00	2026-02-12 19:36:16.765804+00	uvk4tabt74vj	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	155	5dgdahppc2sl	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-01 20:41:51.413935+00	2026-02-01 21:40:10.05453+00	vki72fkexs6x	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	291	h7hydthzje7s	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 14:41:42.568198+00	2026-02-08 15:47:49.581276+00	wevyl46yjhgn	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	157	zh5nawaqqik5	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-01 22:38:40.313627+00	2026-02-01 23:37:10.196953+00	y33jeizzycbn	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	61	mbapsklwtnb6	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2025-10-02 21:55:59.347618+00	2025-10-10 07:02:06.951199+00	pbmvhhgrdy5w	66fa874d-067d-488c-8920-dc82cdf71148
00000000-0000-0000-0000-000000000000	159	paactzt5s5yr	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-02 00:35:39.941328+00	2026-02-02 01:33:40.263422+00	4spueekq6h6p	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	30	to3fiqkb2qjn	562212e3-819d-4d8f-b03b-57a8c9427f72	f	2025-09-24 12:17:30.983608+00	2025-09-24 12:17:30.983608+00	\N	564cfdd7-c0a7-4a81-9f33-4d6138a4bb18
00000000-0000-0000-0000-000000000000	294	wwmifqigs7k6	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 17:55:55.727844+00	2026-02-08 18:54:32.91716+00	lnjtfkrgwsva	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	163	u6afbb5u5m5r	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-02 06:28:05.142393+00	2026-02-02 07:26:17.902765+00	tubxnetlpb42	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	161	wsfp6mfzw7tn	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-02 02:32:10.138013+00	2026-02-02 11:38:22.508162+00	ukit4fpp2m7n	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	297	3avpx7ez3qrj	0d886fc7-1b47-4870-bcb2-eff7cbed5950	t	2026-02-08 20:20:59.51753+00	2026-02-10 04:10:18.182082+00	\N	d0796b3c-39ec-4227-84f7-23d8d454f019
00000000-0000-0000-0000-000000000000	67	pxx3rssjwssh	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2025-10-10 07:02:06.978937+00	2025-11-15 00:19:24.195828+00	mbapsklwtnb6	66fa874d-067d-488c-8920-dc82cdf71148
00000000-0000-0000-0000-000000000000	165	hl3qezi2dvgh	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-02 11:38:22.538592+00	2026-02-02 20:16:47.307692+00	wsfp6mfzw7tn	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	72	4tb65o5pb5j6	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2025-11-15 00:19:24.21725+00	2025-11-16 01:25:16.463832+00	pxx3rssjwssh	66fa874d-067d-488c-8920-dc82cdf71148
00000000-0000-0000-0000-000000000000	169	ttf6qgkxqvhm	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-02 19:51:34.823316+00	2026-02-02 20:50:36.8188+00	isiog3yrznep	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	73	azjl7qjzjhcw	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2025-11-16 01:25:16.495339+00	2025-11-17 00:40:26.564713+00	4tb65o5pb5j6	66fa874d-067d-488c-8920-dc82cdf71148
00000000-0000-0000-0000-000000000000	173	3zyppjfn3eeg	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	f	2026-02-03 02:53:29.40449+00	2026-02-03 02:53:29.40449+00	\N	6e414cc9-5d3e-4f10-99f0-fd27985c6946
00000000-0000-0000-0000-000000000000	171	rb64r4jrgec5	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-02 20:50:36.841631+00	2026-02-03 03:32:48.261731+00	ttf6qgkxqvhm	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	175	heqbceqzybbu	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-03 04:48:28.27639+00	2026-02-03 06:04:51.460282+00	lckvc2sic4yn	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	177	dgcbaycnjzxg	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-03 08:01:56.488373+00	2026-02-03 09:10:30.512815+00	xnjdaxtos45v	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	179	35z34nvtd2y3	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-03 11:50:12.866161+00	2026-02-03 17:19:35.173675+00	gjurc6gvxnf4	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	74	c74iqzuetgdt	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2025-11-17 00:40:26.595676+00	2025-11-18 08:38:29.194875+00	azjl7qjzjhcw	66fa874d-067d-488c-8920-dc82cdf71148
00000000-0000-0000-0000-000000000000	181	5drwrgvzdbfm	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-03 18:01:11.286563+00	2026-02-03 19:43:10.055442+00	tsvf4gqmbqog	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	183	v2fatvi4ujc3	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-03 19:43:10.059387+00	2026-02-03 20:52:30.199979+00	5drwrgvzdbfm	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	185	s7yusnph2dmh	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-04 00:17:10.387886+00	2026-02-04 11:44:30.119009+00	2d7jcb4xlvyr	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	153	uvk4tabt74vj	562212e3-819d-4d8f-b03b-57a8c9427f72	t	2026-01-30 20:10:06.485761+00	2026-02-04 20:00:49.591936+00	zlc3zf6z7b55	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	85	aucc4wrbfs6m	562212e3-819d-4d8f-b03b-57a8c9427f72	t	2025-11-18 15:30:01.841832+00	2025-12-08 16:39:42.143354+00	q3qvfmcb6lkg	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	37	q3qvfmcb6lkg	562212e3-819d-4d8f-b03b-57a8c9427f72	t	2025-09-25 18:46:29.903024+00	2025-11-18 15:30:01.824608+00	\N	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	116	da6bjtsu7aw4	562212e3-819d-4d8f-b03b-57a8c9427f72	t	2025-12-08 16:39:42.168849+00	2025-12-16 20:24:47.450491+00	aucc4wrbfs6m	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	193	xico5pwxvhla	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-04 22:04:04.501316+00	2026-02-04 23:08:33.798397+00	pkoao55pau3w	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	195	ywqfre7fohza	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 00:07:05.945567+00	2026-02-05 01:06:28.29854+00	pqcnm6wdrcwz	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	197	trlzeryktbdx	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 02:05:02.319915+00	2026-02-05 03:53:07.998621+00	u4ngdkwvj3yp	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	199	6xvblcwmskqw	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 04:54:27.493088+00	2026-02-05 06:05:25.57309+00	puaxkymvz4en	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	201	m7td6n7xtukn	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 07:19:45.615262+00	2026-02-05 08:20:44.496971+00	hu6kebw7xtiy	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	117	comhtr6aolg2	562212e3-819d-4d8f-b03b-57a8c9427f72	t	2025-12-16 20:24:47.473615+00	2026-01-05 13:21:38.117798+00	da6bjtsu7aw4	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	203	72kc63aqquhw	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 09:20:12.906529+00	2026-02-05 10:25:11.980734+00	q3sgznbjto7s	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	205	ck2f4kihjovv	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 11:26:05.989155+00	2026-02-05 12:26:37.046758+00	sgkee63mwrd4	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	54	7fzmxit43mbn	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2025-09-28 02:27:07.385576+00	2025-10-02 19:57:32.374864+00	\N	66fa874d-067d-488c-8920-dc82cdf71148
00000000-0000-0000-0000-000000000000	60	pbmvhhgrdy5w	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2025-10-02 19:57:32.394429+00	2025-10-02 21:55:59.333401+00	7fzmxit43mbn	66fa874d-067d-488c-8920-dc82cdf71148
00000000-0000-0000-0000-000000000000	121	sxduh345qui5	562212e3-819d-4d8f-b03b-57a8c9427f72	t	2026-01-05 13:21:38.144867+00	2026-01-08 18:22:05.732883+00	comhtr6aolg2	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	207	tdxfwygdq2ge	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 13:30:28.211121+00	2026-02-05 16:46:00.602711+00	tv26ktl2yzod	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	79	vq5uxka3ad2u	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2025-11-18 08:38:29.219725+00	2025-11-18 22:02:54.04134+00	c74iqzuetgdt	66fa874d-067d-488c-8920-dc82cdf71148
00000000-0000-0000-0000-000000000000	92	azwyguft7knp	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	f	2025-11-18 22:02:54.069684+00	2025-11-18 22:02:54.069684+00	vq5uxka3ad2u	66fa874d-067d-488c-8920-dc82cdf71148
00000000-0000-0000-0000-000000000000	209	dmil4zgtxtjj	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 18:05:08.218443+00	2026-02-05 19:03:52.18488+00	azwzuql4wg67	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	211	jctyy7tlfjm3	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 20:03:21.630198+00	2026-02-05 21:02:21.756012+00	jfnupencx4sc	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	213	zzdgp24p2col	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 22:01:15.930756+00	2026-02-05 23:12:56.007457+00	oc65wp7rchh4	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	215	sace5z3jukxr	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 00:28:57.604406+00	2026-02-06 02:26:28.180067+00	3df4jsfe5vzm	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	137	rzga2q6ufxcm	562212e3-819d-4d8f-b03b-57a8c9427f72	t	2026-01-26 15:22:08.096514+00	2026-01-30 16:57:02.199825+00	3bzcwkofsxyz	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	124	n2r7me6vna62	562212e3-819d-4d8f-b03b-57a8c9427f72	t	2026-01-08 18:22:05.76155+00	2026-01-08 19:31:49.575331+00	sxduh345qui5	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	288	acn5fzhcdnko	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 12:34:55.473132+00	2026-02-08 13:34:03.964436+00	okzm7pxbtayp	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	150	r7yvqykkqej4	562212e3-819d-4d8f-b03b-57a8c9427f72	t	2026-01-30 16:57:02.217808+00	2026-01-30 17:55:32.611723+00	rzga2q6ufxcm	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	218	xiqo6szlaiwt	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 04:38:10.301015+00	2026-02-06 05:37:25.782824+00	iovjchyn2bk4	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	152	zlc3zf6z7b55	562212e3-819d-4d8f-b03b-57a8c9427f72	t	2026-01-30 18:54:07.987478+00	2026-01-30 20:10:06.46343+00	s4vidcdarl2i	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	154	vki72fkexs6x	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-01 19:43:26.067884+00	2026-02-01 20:41:51.39585+00	\N	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	219	puyjjzj3uhxb	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 05:37:25.791014+00	2026-02-06 06:35:27.409555+00	xiqo6szlaiwt	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	156	y33jeizzycbn	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-01 21:40:10.069485+00	2026-02-01 22:38:40.291416+00	5dgdahppc2sl	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	292	w67rsc3imltg	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 15:47:49.601179+00	2026-02-08 16:57:23.390745+00	h7hydthzje7s	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	158	4spueekq6h6p	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-01 23:37:10.217091+00	2026-02-02 00:35:39.92683+00	zh5nawaqqik5	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	220	pgyudxopjrx5	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 06:35:27.420284+00	2026-02-06 07:34:13.935635+00	puyjjzj3uhxb	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	160	ukit4fpp2m7n	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-02 01:33:40.274123+00	2026-02-02 02:32:10.123627+00	paactzt5s5yr	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	135	ilm7bz2lrixa	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-01-24 06:13:16.142151+00	2026-02-02 05:12:53.276622+00	gouctj7e53qf	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	130	gouctj7e53qf	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-01-23 23:46:38.739568+00	2026-01-24 06:13:16.120144+00	\N	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	221	olmq623hbdxe	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 07:34:13.955671+00	2026-02-06 08:32:14.814168+00	pgyudxopjrx5	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	162	tubxnetlpb42	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-02 05:12:53.298151+00	2026-02-02 06:28:05.133028+00	ilm7bz2lrixa	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	126	3bzcwkofsxyz	562212e3-819d-4d8f-b03b-57a8c9427f72	t	2026-01-08 19:31:49.591379+00	2026-01-26 15:22:08.095548+00	n2r7me6vna62	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	295	amx2kjutpceq	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 18:54:32.92451+00	2026-02-08 19:53:33.026901+00	wwmifqigs7k6	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	222	d7tkdlioxmnm	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 08:32:14.831116+00	2026-02-06 09:30:59.757233+00	olmq623hbdxe	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	164	sqf4b5js6glp	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-02 07:26:17.916704+00	2026-02-02 17:54:55.223729+00	u6afbb5u5m5r	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	166	gdiwzwyv6qc6	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-02 17:54:55.238865+00	2026-02-02 18:53:04.823789+00	sqf4b5js6glp	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	223	hx6pl3ijtxie	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 09:30:59.776188+00	2026-02-06 10:29:50.75858+00	d7tkdlioxmnm	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	168	isiog3yrznep	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-02 18:53:04.837754+00	2026-02-02 19:51:34.808834+00	gdiwzwyv6qc6	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	298	hsebb37teegi	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 20:52:11.90679+00	2026-02-08 21:50:53.974829+00	doaoosfpnqgw	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	170	vv2nra5fxlzh	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-02 20:16:47.315333+00	2026-02-03 02:15:39.771017+00	hl3qezi2dvgh	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	224	6trcknzsokhs	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 10:29:50.774591+00	2026-02-06 11:28:25.806049+00	hx6pl3ijtxie	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	174	lckvc2sic4yn	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-03 03:32:48.274987+00	2026-02-03 04:48:28.259008+00	rb64r4jrgec5	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	300	goxfj6i7uv2f	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 22:49:54.082935+00	2026-02-08 23:47:55.536712+00	paoy6ioh6ajv	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	176	xnjdaxtos45v	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-03 06:04:51.465748+00	2026-02-03 08:01:56.475805+00	heqbceqzybbu	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	172	gjurc6gvxnf4	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-03 02:15:39.788937+00	2026-02-03 11:50:12.84338+00	vv2nra5fxlzh	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	226	kapsabed7jfm	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 11:28:25.817615+00	2026-02-06 12:27:25.734948+00	6trcknzsokhs	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	178	tsvf4gqmbqog	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-03 09:10:30.53346+00	2026-02-03 18:01:11.267225+00	dgcbaycnjzxg	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	180	2d7jcb4xlvyr	66586d4d-ad06-48ca-b937-c2bbde17f36a	t	2026-02-03 17:19:35.194813+00	2026-02-04 00:17:10.379216+00	35z34nvtd2y3	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	186	j4btsjdmlbyz	66586d4d-ad06-48ca-b937-c2bbde17f36a	f	2026-02-04 11:44:30.138539+00	2026-02-04 11:44:30.138539+00	s7yusnph2dmh	3ccf2776-a35b-49ea-8d96-d1e3856cb18b
00000000-0000-0000-0000-000000000000	184	6uh5zyittgil	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-03 20:52:30.21677+00	2026-02-04 20:07:09.095053+00	v2fatvi4ujc3	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	190	zqzy52oxtwqa	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-04 20:07:09.101878+00	2026-02-04 21:05:32.224935+00	6uh5zyittgil	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	192	pkoao55pau3w	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-04 21:05:32.246765+00	2026-02-04 22:04:04.482837+00	zqzy52oxtwqa	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	194	pqcnm6wdrcwz	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-04 23:08:33.811789+00	2026-02-05 00:07:05.943202+00	xico5pwxvhla	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	196	u4ngdkwvj3yp	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 01:06:28.30697+00	2026-02-05 02:05:02.309656+00	ywqfre7fohza	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	198	puaxkymvz4en	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 03:53:08.015888+00	2026-02-05 04:54:27.482388+00	trlzeryktbdx	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	200	hu6kebw7xtiy	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 06:05:25.57814+00	2026-02-05 07:19:45.605596+00	6xvblcwmskqw	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	202	q3sgznbjto7s	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 08:20:44.512327+00	2026-02-05 09:20:12.885171+00	m7td6n7xtukn	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	204	sgkee63mwrd4	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 10:25:11.999012+00	2026-02-05 11:26:05.969622+00	72kc63aqquhw	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	206	tv26ktl2yzod	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 12:26:37.062699+00	2026-02-05 13:30:28.199353+00	ck2f4kihjovv	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	208	azwzuql4wg67	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 16:46:00.62199+00	2026-02-05 18:05:08.207558+00	tdxfwygdq2ge	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	210	jfnupencx4sc	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 19:03:52.197588+00	2026-02-05 20:03:21.620495+00	dmil4zgtxtjj	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	212	oc65wp7rchh4	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 21:02:21.7703+00	2026-02-05 22:01:15.919774+00	jctyy7tlfjm3	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	214	3df4jsfe5vzm	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-05 23:12:56.020206+00	2026-02-06 00:28:57.58985+00	zzdgp24p2col	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	216	xddjixzpgp4a	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 02:26:28.188611+00	2026-02-06 03:28:32.966246+00	sace5z3jukxr	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	397	qmdczwsbwuxm	7de965d1-329b-4ee3-8814-7cfbb8291325	t	2026-02-12 14:54:43.792635+00	2026-02-12 15:53:11.517874+00	e4yqijtzf77m	4826e81c-61b7-49eb-8119-8b45d349e8cf
00000000-0000-0000-0000-000000000000	289	t7nr4cgiwa76	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	t	2026-02-08 13:13:50.799125+00	2026-02-11 17:33:48.312324+00	\N	b6df9d0f-d003-418b-b98d-eb0e5c9d50e0
00000000-0000-0000-0000-000000000000	228	6pqpkofzwy3w	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 12:27:25.751228+00	2026-02-06 13:26:02.737318+00	kapsabed7jfm	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	230	pizz6mw7vet7	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 13:26:02.744267+00	2026-02-06 14:25:25.77183+00	6pqpkofzwy3w	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	231	if7rqt4mihyl	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 14:25:25.782612+00	2026-02-06 15:24:25.433039+00	pizz6mw7vet7	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	236	dtvuqnyku6qd	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 15:24:25.436792+00	2026-02-06 16:23:26.011888+00	if7rqt4mihyl	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	237	4avvvs2xahia	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 16:23:26.03469+00	2026-02-06 17:22:26.241232+00	dtvuqnyku6qd	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	233	6t6yg7q6y2pt	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	t	2026-02-06 14:36:49.043799+00	2026-02-06 18:08:08.082739+00	\N	63069be8-d38d-49ed-97dc-fee50538a904
00000000-0000-0000-0000-000000000000	238	nczf3l4bhb6s	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 17:22:26.262356+00	2026-02-06 18:21:25.777057+00	4avvvs2xahia	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	240	wmmkn2pb7gkp	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 18:21:25.783079+00	2026-02-06 19:19:45.376167+00	nczf3l4bhb6s	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	241	xlrbvjba6hr6	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 19:19:45.398553+00	2026-02-06 20:18:44.138993+00	wmmkn2pb7gkp	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	239	rvkzc4mihojy	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	t	2026-02-06 18:08:08.089825+00	2026-02-06 20:50:59.691567+00	6t6yg7q6y2pt	63069be8-d38d-49ed-97dc-fee50538a904
00000000-0000-0000-0000-000000000000	242	2gowmzqukihg	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 20:18:44.160752+00	2026-02-06 21:17:21.59961+00	xlrbvjba6hr6	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	244	226bw72o4kjx	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 21:17:21.609996+00	2026-02-06 22:16:21.468103+00	2gowmzqukihg	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	243	5jkcxxtjsyha	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	t	2026-02-06 20:50:59.707705+00	2026-02-06 22:35:59.285187+00	rvkzc4mihojy	63069be8-d38d-49ed-97dc-fee50538a904
00000000-0000-0000-0000-000000000000	247	qdr5p4fpdsne	629bfa5c-5449-4583-8358-08335293caba	f	2026-02-06 22:40:41.550002+00	2026-02-06 22:40:41.550002+00	\N	81c6cf9e-4d7d-4507-9cc1-24f886508399
00000000-0000-0000-0000-000000000000	245	vjypnjvfzee2	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 22:16:21.478475+00	2026-02-06 23:15:21.438414+00	226bw72o4kjx	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	248	ajgskpq6mbvm	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-06 23:15:21.461922+00	2026-02-07 00:13:53.431271+00	vjypnjvfzee2	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	250	rvjw7etprakt	2333c58f-094b-4dbb-9d56-347d134feda7	f	2026-02-07 00:35:59.097255+00	2026-02-07 00:35:59.097255+00	\N	ea2ae44f-5f0c-4ba9-b12d-0fcbabb545ea
00000000-0000-0000-0000-000000000000	251	nnz4c6kifukm	6f6fa59c-20ad-41b9-9f63-421dee593357	f	2026-02-07 00:51:08.051894+00	2026-02-07 00:51:08.051894+00	\N	791b35d8-2260-481a-abb2-3c7fddcc7b66
00000000-0000-0000-0000-000000000000	249	w5atylgrx2hm	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 00:13:53.441877+00	2026-02-07 01:12:35.302774+00	ajgskpq6mbvm	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	252	7rogar5d42hz	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 01:12:35.326656+00	2026-02-07 02:31:56.647682+00	w5atylgrx2hm	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	253	r272cvswzaae	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 02:31:56.658934+00	2026-02-07 03:35:28.093287+00	7rogar5d42hz	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	254	jdtlzhc35vyu	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 03:35:28.101351+00	2026-02-07 04:33:44.90332+00	r272cvswzaae	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	255	srt4uagr3h46	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 04:33:44.915584+00	2026-02-07 05:31:57.00111+00	jdtlzhc35vyu	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	256	ztsjlqoczhpn	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 05:31:57.007605+00	2026-02-07 06:30:19.754219+00	srt4uagr3h46	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	257	y6oh5svhopxz	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 06:30:19.76331+00	2026-02-07 07:29:18.047385+00	ztsjlqoczhpn	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	258	jtokmgkc2tiw	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 07:29:18.059414+00	2026-02-07 08:28:18.203312+00	y6oh5svhopxz	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	259	6da3aufincez	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 08:28:18.2239+00	2026-02-07 09:27:18.41002+00	jtokmgkc2tiw	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	260	6j57qu45awrw	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 09:27:18.430437+00	2026-02-07 10:26:18.38463+00	6da3aufincez	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	246	tyndhdvr5my3	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	t	2026-02-06 22:35:59.294145+00	2026-02-07 11:12:39.146943+00	5jkcxxtjsyha	63069be8-d38d-49ed-97dc-fee50538a904
00000000-0000-0000-0000-000000000000	261	cuomyurp7grk	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 10:26:18.405152+00	2026-02-07 11:25:18.172173+00	6j57qu45awrw	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	263	yticocph44gv	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 11:25:18.18872+00	2026-02-07 12:24:18.405984+00	cuomyurp7grk	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	264	knrae3uigpbu	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 12:24:18.420197+00	2026-02-07 13:23:18.385044+00	yticocph44gv	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	265	52lpxv4ajcn7	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 13:23:18.402169+00	2026-02-07 14:22:18.345784+00	knrae3uigpbu	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	266	vte7l2yy3pub	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 14:22:18.357194+00	2026-02-07 15:21:18.428904+00	52lpxv4ajcn7	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	267	brnhrh545wi4	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 15:21:18.454174+00	2026-02-07 16:20:18.32458+00	vte7l2yy3pub	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	268	cpas6zyyzet2	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 16:20:18.333232+00	2026-02-07 17:19:18.304513+00	brnhrh545wi4	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	269	eazjf4tmvqcj	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 17:19:18.315211+00	2026-02-07 18:18:18.28289+00	cpas6zyyzet2	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	270	d757rgsdewev	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 18:18:18.294524+00	2026-02-07 19:17:18.298609+00	eazjf4tmvqcj	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	271	m7farub7jwnh	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 19:17:18.30988+00	2026-02-07 20:16:18.170697+00	d757rgsdewev	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	272	i7w2iexfbr6f	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 20:16:18.178037+00	2026-02-07 21:15:03.276463+00	m7farub7jwnh	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	273	azly3qx7m45c	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 21:15:03.282842+00	2026-02-07 22:13:49.105547+00	i7w2iexfbr6f	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	274	kyirui7ibssa	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 22:13:49.113831+00	2026-02-07 23:12:01.959664+00	azly3qx7m45c	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	275	u3y37eq6y6d3	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-07 23:12:01.966349+00	2026-02-08 00:10:02.016822+00	kyirui7ibssa	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	276	4islguhhvg7f	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 00:10:02.027992+00	2026-02-08 01:08:31.996026+00	u3y37eq6y6d3	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	277	saqsrysmj2kl	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 01:08:32.003888+00	2026-02-08 02:17:56.432642+00	4islguhhvg7f	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	278	vmjpdeualzoi	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 02:17:56.440126+00	2026-02-08 03:17:15.563731+00	saqsrysmj2kl	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	279	wkrxei3x6j2q	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 03:17:15.569676+00	2026-02-08 04:15:48.451934+00	vmjpdeualzoi	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	280	w44jonrai4vg	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 04:15:48.456772+00	2026-02-08 05:17:03.639849+00	wkrxei3x6j2q	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	281	ovl5jbkqasgn	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 05:17:03.647867+00	2026-02-08 06:27:16.330667+00	w44jonrai4vg	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	286	u2hz75l55bj7	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 10:34:21.876038+00	2026-02-08 11:33:36.035523+00	pccajdb4qcyw	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	282	c3sfj7zzz2hg	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 06:27:16.33485+00	2026-02-08 07:26:13.867489+00	ovl5jbkqasgn	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	283	mnxrupjfafey	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 07:26:13.87954+00	2026-02-08 08:34:17.496493+00	c3sfj7zzz2hg	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	290	wevyl46yjhgn	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 13:34:03.983996+00	2026-02-08 14:41:42.558252+00	acn5fzhcdnko	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	284	kaxz3ztfuyo2	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 08:34:17.511216+00	2026-02-08 09:32:53.310372+00	mnxrupjfafey	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	285	pccajdb4qcyw	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 09:32:53.331074+00	2026-02-08 10:34:21.85887+00	kaxz3ztfuyo2	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	293	lnjtfkrgwsva	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 16:57:23.396394+00	2026-02-08 17:55:55.720594+00	w67rsc3imltg	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	296	doaoosfpnqgw	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 19:53:33.034665+00	2026-02-08 20:52:11.890494+00	amx2kjutpceq	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	299	paoy6ioh6ajv	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 21:50:53.986302+00	2026-02-08 22:49:54.068147+00	hsebb37teegi	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	301	qqj2np3fe4st	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-08 23:47:55.55142+00	2026-02-09 02:10:10.640818+00	goxfj6i7uv2f	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	302	hn6pi4krqmoy	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 02:10:10.647439+00	2026-02-09 03:11:26.21284+00	qqj2np3fe4st	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	303	gcys6g6e7o2f	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 03:11:26.221236+00	2026-02-09 04:10:00.108944+00	hn6pi4krqmoy	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	304	mlhbtrcwparu	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 04:10:00.117878+00	2026-02-09 05:12:54.072638+00	gcys6g6e7o2f	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	305	thffydb47kbs	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 05:12:54.080682+00	2026-02-09 06:13:34.475643+00	mlhbtrcwparu	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	306	4ycwwlzcmsry	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 06:13:34.489807+00	2026-02-09 07:14:46.754656+00	thffydb47kbs	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	307	as5f3gcvufrb	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 07:14:46.768052+00	2026-02-09 08:13:24.681663+00	4ycwwlzcmsry	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	308	j4e4gow72air	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 08:13:24.697849+00	2026-02-09 09:12:24.813352+00	as5f3gcvufrb	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	309	ddizce5esthy	6a20c1a0-ee08-4708-84a7-2c7ad61b3041	t	2026-02-09 08:36:17.764949+00	2026-02-09 09:34:41.68965+00	\N	4972410f-b644-40c4-ac8a-63255406b9f3
00000000-0000-0000-0000-000000000000	310	jihh4gg4mwsv	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 09:12:24.830702+00	2026-02-09 10:23:26.350697+00	j4e4gow72air	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	311	pbbrasmhu3er	6a20c1a0-ee08-4708-84a7-2c7ad61b3041	t	2026-02-09 09:34:41.702445+00	2026-02-09 10:32:42.278896+00	ddizce5esthy	4972410f-b644-40c4-ac8a-63255406b9f3
00000000-0000-0000-0000-000000000000	313	dy7z3y26u22k	6a20c1a0-ee08-4708-84a7-2c7ad61b3041	t	2026-02-09 10:32:42.281428+00	2026-02-09 11:30:43.60714+00	pbbrasmhu3er	4972410f-b644-40c4-ac8a-63255406b9f3
00000000-0000-0000-0000-000000000000	312	gllo3cgeksvt	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 10:23:26.370087+00	2026-02-09 11:31:10.351369+00	jihh4gg4mwsv	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	262	52m5s63zgnhf	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	t	2026-02-07 11:12:39.151113+00	2026-02-09 11:56:27.428505+00	tyndhdvr5my3	63069be8-d38d-49ed-97dc-fee50538a904
00000000-0000-0000-0000-000000000000	314	cx6373saep34	6a20c1a0-ee08-4708-84a7-2c7ad61b3041	t	2026-02-09 11:30:43.617808+00	2026-02-09 12:29:12.526573+00	dy7z3y26u22k	4972410f-b644-40c4-ac8a-63255406b9f3
00000000-0000-0000-0000-000000000000	315	oi4gf4qz4ar7	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 11:31:10.351721+00	2026-02-09 12:39:54.951904+00	gllo3cgeksvt	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	316	f555bmbveu3v	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	t	2026-02-09 11:56:27.434511+00	2026-02-09 13:24:07.945899+00	52m5s63zgnhf	63069be8-d38d-49ed-97dc-fee50538a904
00000000-0000-0000-0000-000000000000	317	lmmgyeicph6h	6a20c1a0-ee08-4708-84a7-2c7ad61b3041	t	2026-02-09 12:29:12.54402+00	2026-02-09 13:30:52.655422+00	cx6373saep34	4972410f-b644-40c4-ac8a-63255406b9f3
00000000-0000-0000-0000-000000000000	321	r2tc52gix6ut	a07197c2-3744-40a0-b6d8-252769eae979	f	2026-02-09 13:47:00.707902+00	2026-02-09 13:47:00.707902+00	\N	ec011e00-3fb9-41c0-88b9-ecb453fd31fe
00000000-0000-0000-0000-000000000000	318	z7dldw7ht6os	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 12:39:54.957233+00	2026-02-09 13:48:18.676742+00	oi4gf4qz4ar7	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	322	vxbhu4c5mww2	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 13:48:18.678719+00	2026-02-09 14:59:40.011191+00	z7dldw7ht6os	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	319	hban2nx2qjr6	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	t	2026-02-09 13:24:07.956503+00	2026-02-09 15:38:35.65702+00	f555bmbveu3v	63069be8-d38d-49ed-97dc-fee50538a904
00000000-0000-0000-0000-000000000000	323	66s455ytp5by	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 14:59:40.034459+00	2026-02-09 15:58:30.472492+00	vxbhu4c5mww2	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	326	kupvpht5icjc	66586d4d-ad06-48ca-b937-c2bbde17f36a	f	2026-02-09 16:18:50.791693+00	2026-02-09 16:18:50.791693+00	\N	db42f3b0-0dee-43d1-bd4f-13c034cabda8
00000000-0000-0000-0000-000000000000	325	4qyek3xahrlm	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 15:58:30.484397+00	2026-02-09 16:59:34.526122+00	66s455ytp5by	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	327	k4a6q27yjymc	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 16:59:34.539582+00	2026-02-09 17:58:39.990538+00	4qyek3xahrlm	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	329	ejkbabtiah3n	0c1a8cff-b719-4e94-966d-22e8fce601ed	f	2026-02-09 18:33:59.391628+00	2026-02-09 18:33:59.391628+00	\N	74ff3cb0-eef3-47ad-b81d-858a6c7512b4
00000000-0000-0000-0000-000000000000	328	7zhpati3qe5y	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 17:58:39.999436+00	2026-02-09 18:57:46.618897+00	k4a6q27yjymc	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	330	iktypxehx65k	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 18:57:46.639433+00	2026-02-09 19:56:46.585906+00	7zhpati3qe5y	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	331	272s654fekio	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 19:56:46.602292+00	2026-02-09 20:55:05.015937+00	iktypxehx65k	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	320	ophdlmwk42vn	6a20c1a0-ee08-4708-84a7-2c7ad61b3041	t	2026-02-09 13:30:52.656161+00	2026-02-09 21:26:28.127075+00	lmmgyeicph6h	4972410f-b644-40c4-ac8a-63255406b9f3
00000000-0000-0000-0000-000000000000	332	qgbvgieggp7y	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 20:55:05.026117+00	2026-02-09 21:53:28.076004+00	272s654fekio	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	333	euqghlnrscfw	6a20c1a0-ee08-4708-84a7-2c7ad61b3041	t	2026-02-09 21:26:28.133372+00	2026-02-09 22:40:56.150313+00	ophdlmwk42vn	4972410f-b644-40c4-ac8a-63255406b9f3
00000000-0000-0000-0000-000000000000	335	ewkyan46i3p2	6a20c1a0-ee08-4708-84a7-2c7ad61b3041	f	2026-02-09 22:40:56.167086+00	2026-02-09 22:40:56.167086+00	euqghlnrscfw	4972410f-b644-40c4-ac8a-63255406b9f3
00000000-0000-0000-0000-000000000000	334	57pyufrwqdn2	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 21:53:28.08502+00	2026-02-09 23:05:53.54084+00	qgbvgieggp7y	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	336	noo47h56e4ta	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-09 23:05:53.556415+00	2026-02-10 00:12:50.668909+00	57pyufrwqdn2	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	337	5ovw7mbzuz4p	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 00:12:50.679275+00	2026-02-10 02:23:55.825735+00	noo47h56e4ta	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	339	pausckaiiutq	03583b49-b454-4903-9ec9-180a20a40946	f	2026-02-10 03:30:14.147345+00	2026-02-10 03:30:14.147345+00	\N	7dfa4138-122f-42a1-88a8-205a85290624
00000000-0000-0000-0000-000000000000	338	btdrmsyh65fp	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 02:23:55.839269+00	2026-02-10 03:39:32.313008+00	5ovw7mbzuz4p	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	340	gufqxy3qc3j3	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 03:39:32.319182+00	2026-02-10 04:40:31.865308+00	btdrmsyh65fp	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	324	b5zkeiffxb7o	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	t	2026-02-09 15:38:35.674308+00	2026-02-10 13:47:16.808674+00	hban2nx2qjr6	63069be8-d38d-49ed-97dc-fee50538a904
00000000-0000-0000-0000-000000000000	375	e4yqijtzf77m	7de965d1-329b-4ee3-8814-7cfbb8291325	t	2026-02-11 09:42:38.383433+00	2026-02-12 14:54:43.771368+00	\N	4826e81c-61b7-49eb-8119-8b45d349e8cf
00000000-0000-0000-0000-000000000000	383	d7riz6pyzfpc	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	t	2026-02-11 17:33:48.319537+00	2026-02-12 18:41:16.864558+00	t7nr4cgiwa76	b6df9d0f-d003-418b-b98d-eb0e5c9d50e0
00000000-0000-0000-0000-000000000000	342	dj27eyiinvqi	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 04:40:31.873109+00	2026-02-10 05:39:14.885441+00	gufqxy3qc3j3	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	343	gipt72vannbb	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 05:39:14.900783+00	2026-02-10 06:42:48.617175+00	dj27eyiinvqi	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	345	ueesfiegojc2	5bda8e48-63ad-424b-ba4c-b6dc8d90d467	f	2026-02-10 07:34:57.841185+00	2026-02-10 07:34:57.841185+00	\N	a5e601d0-4af7-4311-898a-5ecf44820be4
00000000-0000-0000-0000-000000000000	344	ilxswvozchzk	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 06:42:48.623185+00	2026-02-10 07:41:34.223948+00	gipt72vannbb	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	346	r73w27oxs23f	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 07:41:34.233121+00	2026-02-10 08:40:18.377592+00	ilxswvozchzk	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	347	gev4qjuinaj7	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 08:40:18.390047+00	2026-02-10 09:50:38.542799+00	r73w27oxs23f	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	348	kl5dnpojyljt	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 09:50:38.549122+00	2026-02-10 11:18:06.792669+00	gev4qjuinaj7	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	349	wpvp6dxeen5z	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 11:18:06.815326+00	2026-02-10 12:26:56.070818+00	kl5dnpojyljt	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	351	j5gzn36ztgip	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	f	2026-02-10 13:47:16.814024+00	2026-02-10 13:47:16.814024+00	b5zkeiffxb7o	63069be8-d38d-49ed-97dc-fee50538a904
00000000-0000-0000-0000-000000000000	350	uhvfh2dcac65	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 12:26:56.077367+00	2026-02-10 13:51:47.223921+00	wpvp6dxeen5z	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	352	4f2zordc2urv	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 13:51:47.224658+00	2026-02-10 15:14:26.520154+00	uhvfh2dcac65	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	353	iqjflbjddo7t	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 15:14:26.534506+00	2026-02-10 16:15:24.054797+00	4f2zordc2urv	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	354	4hzsq5fa5kxl	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 16:15:24.065273+00	2026-02-10 17:15:38.957998+00	iqjflbjddo7t	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	355	f5jmok65v66l	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 17:15:38.965257+00	2026-02-10 18:14:24.247233+00	4hzsq5fa5kxl	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	341	azxmircu3q53	0d886fc7-1b47-4870-bcb2-eff7cbed5950	t	2026-02-10 04:10:18.203564+00	2026-02-10 19:10:51.033449+00	3avpx7ez3qrj	d0796b3c-39ec-4227-84f7-23d8d454f019
00000000-0000-0000-0000-000000000000	356	fbl6ropvfrzn	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 18:14:24.25848+00	2026-02-10 19:13:23.884915+00	f5jmok65v66l	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	359	n6mlamt4nyw2	96f9bcb8-0ef8-465a-90d1-dc056c1f9554	f	2026-02-10 20:07:17.336302+00	2026-02-10 20:07:17.336302+00	\N	7a3a0917-a094-45bf-ab04-ce826c0efa57
00000000-0000-0000-0000-000000000000	358	ha63uj4mg4j5	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 19:13:23.897115+00	2026-02-10 20:12:24.06756+00	fbl6ropvfrzn	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	357	kotqjxh46dhn	0d886fc7-1b47-4870-bcb2-eff7cbed5950	t	2026-02-10 19:10:51.046367+00	2026-02-10 20:55:16.08908+00	azxmircu3q53	d0796b3c-39ec-4227-84f7-23d8d454f019
00000000-0000-0000-0000-000000000000	360	szmemicepxak	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 20:12:24.075959+00	2026-02-10 21:11:35.849704+00	ha63uj4mg4j5	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	361	wczwlmeazj4e	0d886fc7-1b47-4870-bcb2-eff7cbed5950	t	2026-02-10 20:55:16.108025+00	2026-02-10 22:00:11.710749+00	kotqjxh46dhn	d0796b3c-39ec-4227-84f7-23d8d454f019
00000000-0000-0000-0000-000000000000	363	lct2nk3npt6x	0d886fc7-1b47-4870-bcb2-eff7cbed5950	f	2026-02-10 22:00:11.721174+00	2026-02-10 22:00:11.721174+00	wczwlmeazj4e	d0796b3c-39ec-4227-84f7-23d8d454f019
00000000-0000-0000-0000-000000000000	362	rnae2ajniie2	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 21:11:35.853344+00	2026-02-10 22:10:48.757722+00	szmemicepxak	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	364	f3b4a7fjueqc	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 22:10:48.766787+00	2026-02-10 23:09:43.148797+00	rnae2ajniie2	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	365	fn2db2myxoti	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-10 23:09:43.160794+00	2026-02-11 00:09:08.017807+00	f3b4a7fjueqc	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	366	g3dx3yqyi4wd	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 00:09:08.025801+00	2026-02-11 01:07:28.527105+00	fn2db2myxoti	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	367	f7qgorjidap7	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 01:07:28.537339+00	2026-02-11 03:02:26.29565+00	g3dx3yqyi4wd	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	368	mwmpaum5txeu	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 03:02:26.308364+00	2026-02-11 04:05:33.320238+00	f7qgorjidap7	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	369	zbjcs7t6iji4	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 04:05:33.337402+00	2026-02-11 05:04:04.87688+00	mwmpaum5txeu	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	370	medyvwla5sqy	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 05:04:04.887354+00	2026-02-11 06:03:03.545669+00	zbjcs7t6iji4	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	371	xud4okb6icnf	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 06:03:03.554527+00	2026-02-11 07:09:31.944485+00	medyvwla5sqy	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	372	cfwkpm2ezhog	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 07:09:31.957977+00	2026-02-11 08:07:35.987707+00	xud4okb6icnf	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	373	nrpyylmalyqw	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 08:07:35.994632+00	2026-02-11 09:19:39.678735+00	cfwkpm2ezhog	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	374	fpz67clsgoom	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 09:19:39.685451+00	2026-02-11 10:18:21.577476+00	nrpyylmalyqw	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	376	qv5pflcsya4i	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 10:18:21.593817+00	2026-02-11 11:16:55.570502+00	fpz67clsgoom	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	377	xu43rb2dnjh3	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 11:16:55.57876+00	2026-02-11 12:31:20.282076+00	qv5pflcsya4i	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	378	veoj5liji7ip	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 12:31:20.293565+00	2026-02-11 13:38:45.248378+00	xu43rb2dnjh3	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	379	qv6olmdml3vf	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 13:38:45.255409+00	2026-02-11 14:37:58.275095+00	veoj5liji7ip	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	380	vdnf6a3x5w6p	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 14:37:58.296277+00	2026-02-11 15:51:20.237798+00	qv6olmdml3vf	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	381	l5pa27xgtucf	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 15:51:20.243148+00	2026-02-11 16:50:34.566808+00	vdnf6a3x5w6p	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	382	yhn6mrlnnm57	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 16:50:34.576917+00	2026-02-11 19:58:27.86554+00	l5pa27xgtucf	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	384	rnk5xhwkamxo	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 19:58:27.874152+00	2026-02-11 20:57:07.595908+00	yhn6mrlnnm57	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	385	crufaedsbbej	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 20:57:07.605756+00	2026-02-11 21:56:12.016488+00	rnk5xhwkamxo	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	386	qfyqoo7ajgre	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 21:56:12.030536+00	2026-02-11 22:59:49.30695+00	crufaedsbbej	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	387	duojyjpmllnt	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 22:59:49.319844+00	2026-02-11 23:58:16.463493+00	qfyqoo7ajgre	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	389	vhqczgst5zbo	6f1ae888-314a-46df-9c74-05456d4c517d	f	2026-02-12 00:26:29.414198+00	2026-02-12 00:26:29.414198+00	\N	1686402a-05ca-41d7-9095-f384c435c645
00000000-0000-0000-0000-000000000000	388	ztaitljn3wcr	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-11 23:58:16.470793+00	2026-02-12 00:56:45.167468+00	duojyjpmllnt	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	390	r64zi4zc3myu	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-12 00:56:45.178654+00	2026-02-12 05:28:06.218765+00	ztaitljn3wcr	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	391	fx72g5zkmson	e798443f-c72a-40aa-b351-84d285cb8dfc	f	2026-02-12 04:11:25.608217+00	2026-02-12 04:11:25.608217+00	\N	9ea0f433-0606-49fa-9dda-560603218aae
00000000-0000-0000-0000-000000000000	395	pteh77o45uxz	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-12 08:23:23.662632+00	2026-02-12 09:21:32.887947+00	epb3rrietwpp	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	392	b675o3zs6yye	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-12 05:28:06.236043+00	2026-02-12 06:26:36.350303+00	r64zi4zc3myu	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	396	l6rq3qigckou	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-12 09:21:32.897125+00	2026-02-12 17:20:41.063397+00	pteh77o45uxz	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	393	kh2owbwralvx	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-12 06:26:36.368039+00	2026-02-12 07:24:53.727683+00	b675o3zs6yye	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	394	epb3rrietwpp	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-12 07:24:53.735185+00	2026-02-12 08:23:23.654847+00	kh2owbwralvx	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	399	km7v575zgqx2	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-12 17:20:41.080961+00	2026-02-12 18:18:43.387294+00	l6rq3qigckou	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	400	qraw6hjla734	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-12 18:18:43.398285+00	2026-02-12 19:23:59.260607+00	km7v575zgqx2	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	403	7kcc2xg6xqbv	562212e3-819d-4d8f-b03b-57a8c9427f72	f	2026-02-12 19:36:16.775213+00	2026-02-12 19:36:16.775213+00	tc3jhq6ncidf	2d5f927a-d7d1-4d65-8475-896840b64ad7
00000000-0000-0000-0000-000000000000	401	3nnbl6jycocy	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	t	2026-02-12 18:41:16.874835+00	2026-02-12 19:55:26.219322+00	d7riz6pyzfpc	b6df9d0f-d003-418b-b98d-eb0e5c9d50e0
00000000-0000-0000-0000-000000000000	402	gbnizbuw6mjg	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-12 19:23:59.282658+00	2026-02-12 20:46:07.089989+00	qraw6hjla734	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	405	ynxskvxuaoeo	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-12 20:46:07.108154+00	2026-02-13 05:26:59.552678+00	gbnizbuw6mjg	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	406	rsychnitwvsn	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-13 05:26:59.564498+00	2026-02-13 07:35:10.023949+00	ynxskvxuaoeo	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	407	5clirt35dlne	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-13 07:35:10.03607+00	2026-02-13 17:57:42.384753+00	rsychnitwvsn	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	408	vm5x5z6w6u6d	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-13 17:57:42.407927+00	2026-02-13 18:56:09.782883+00	5clirt35dlne	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	398	pun6rxi3a6jw	7de965d1-329b-4ee3-8814-7cfbb8291325	t	2026-02-12 15:53:11.537461+00	2026-02-13 19:02:15.600883+00	qmdczwsbwuxm	4826e81c-61b7-49eb-8119-8b45d349e8cf
00000000-0000-0000-0000-000000000000	410	5ukxbtluaycf	7de965d1-329b-4ee3-8814-7cfbb8291325	f	2026-02-13 19:02:15.601613+00	2026-02-13 19:02:15.601613+00	pun6rxi3a6jw	4826e81c-61b7-49eb-8119-8b45d349e8cf
00000000-0000-0000-0000-000000000000	409	4jbuhnlbz7ph	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-13 18:56:09.792441+00	2026-02-13 19:54:39.955125+00	vm5x5z6w6u6d	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	404	uyk3e6ir6sgb	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	t	2026-02-12 19:55:26.241061+00	2026-02-13 20:47:05.719352+00	3nnbl6jycocy	b6df9d0f-d003-418b-b98d-eb0e5c9d50e0
00000000-0000-0000-0000-000000000000	412	b3i34pxpruim	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	f	2026-02-13 20:47:05.726162+00	2026-02-13 20:47:05.726162+00	uyk3e6ir6sgb	b6df9d0f-d003-418b-b98d-eb0e5c9d50e0
00000000-0000-0000-0000-000000000000	411	x744k57kjhbx	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-13 19:54:39.966922+00	2026-02-13 20:53:09.866161+00	4jbuhnlbz7ph	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	413	z2mxz5mwet77	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-13 20:53:09.872729+00	2026-02-13 21:51:38.389123+00	x744k57kjhbx	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	415	xuk7lp4hjxua	10569c05-bf71-4e59-ac71-cdb731877e55	f	2026-02-13 23:52:07.378727+00	2026-02-13 23:52:07.378727+00	\N	949f8cc6-84f1-419e-a2b9-46e54e3bc31d
00000000-0000-0000-0000-000000000000	414	63nmnxa6wkgu	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-13 21:51:38.409967+00	2026-02-14 00:39:12.080396+00	z2mxz5mwet77	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	416	pte6pgta6tgq	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-14 00:39:12.09923+00	2026-02-14 01:37:33.139758+00	63nmnxa6wkgu	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	418	lutbjgmeuxf5	9744a793-abb5-43a7-a8d6-2ed6b59c2ef9	f	2026-02-14 02:37:11.735727+00	2026-02-14 02:37:11.735727+00	\N	08e0af12-fdbc-4a65-8103-b59ff2f93bb5
00000000-0000-0000-0000-000000000000	417	jt3zaddabfdz	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-14 01:37:33.152689+00	2026-02-14 03:03:58.894289+00	pte6pgta6tgq	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	419	7azixofrw334	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-14 03:03:58.919001+00	2026-02-14 04:17:13.799216+00	jt3zaddabfdz	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	420	uz4lxepsg5pe	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-14 04:17:13.817919+00	2026-02-14 05:15:34.455338+00	7azixofrw334	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	421	wdjuknecrcgb	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-14 05:15:34.466892+00	2026-02-14 06:13:54.1405+00	uz4lxepsg5pe	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	422	aztrhtsxeiuh	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-14 06:13:54.155782+00	2026-02-14 07:21:58.743623+00	wdjuknecrcgb	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	423	qe3veuxac3bd	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	t	2026-02-14 07:21:58.756288+00	2026-02-14 08:20:25.865333+00	aztrhtsxeiuh	76f651a3-b5db-477d-86e9-8d294743d603
00000000-0000-0000-0000-000000000000	424	t4hs6v63gjkh	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	f	2026-02-14 08:20:25.875844+00	2026-02-14 08:20:25.875844+00	qe3veuxac3bd	76f651a3-b5db-477d-86e9-8d294743d603
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
b6df9d0f-d003-418b-b98d-eb0e5c9d50e0	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-08 13:13:50.772474+00	2026-02-13 20:47:05.742665+00	\N	aal1	\N	2026-02-13 20:47:05.741934	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	185.199.102.194	\N	\N	\N	\N	\N
3ccf2776-a35b-49ea-8d96-d1e3856cb18b	66586d4d-ad06-48ca-b937-c2bbde17f36a	2026-02-01 19:43:26.020643+00	2026-02-04 11:44:30.167995+00	\N	aal1	\N	2026-02-04 11:44:30.165537	Vercel Edge Functions	44.200.101.20	\N	\N	\N	\N	\N
7dfa4138-122f-42a1-88a8-205a85290624	03583b49-b454-4903-9ec9-180a20a40946	2026-02-10 03:30:14.132143+00	2026-02-10 03:30:14.132143+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	173.178.211.238	\N	\N	\N	\N	\N
949f8cc6-84f1-419e-a2b9-46e54e3bc31d	10569c05-bf71-4e59-ac71-cdb731877e55	2026-02-13 23:52:07.357184+00	2026-02-13 23:52:07.357184+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Safari/605.1.15	65.94.211.22	\N	\N	\N	\N	\N
564cfdd7-c0a7-4a81-9f33-4d6138a4bb18	562212e3-819d-4d8f-b03b-57a8c9427f72	2025-09-24 12:17:30.98002+00	2025-09-24 12:17:30.98002+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	24.38.253.177	\N	\N	\N	\N	\N
ec011e00-3fb9-41c0-88b9-ecb453fd31fe	a07197c2-3744-40a0-b6d8-252769eae979	2026-02-09 13:47:00.688935+00	2026-02-09 13:47:00.688935+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/144.0.7559.95 Mobile/15E148 Safari/604.1	195.86.56.21	\N	\N	\N	\N	\N
66fa874d-067d-488c-8920-dc82cdf71148	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	2025-09-28 02:27:07.382336+00	2025-11-18 22:02:54.099117+00	\N	aal1	\N	2025-11-18 22:02:54.099022	Vercel Edge Functions	54.67.62.139	\N	\N	\N	\N	\N
2d5f927a-d7d1-4d65-8475-896840b64ad7	562212e3-819d-4d8f-b03b-57a8c9427f72	2025-09-25 18:46:29.902284+00	2026-02-12 19:36:16.788607+00	\N	aal1	\N	2026-02-12 19:36:16.787367	Vercel Edge Functions	13.222.250.5	\N	\N	\N	\N	\N
db42f3b0-0dee-43d1-bd4f-13c034cabda8	66586d4d-ad06-48ca-b937-c2bbde17f36a	2026-02-09 16:18:50.766365+00	2026-02-09 16:18:50.766365+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	76.119.233.110	\N	\N	\N	\N	\N
7a3a0917-a094-45bf-ab04-ce826c0efa57	96f9bcb8-0ef8-465a-90d1-dc056c1f9554	2026-02-10 20:07:17.315666+00	2026-02-10 20:07:17.315666+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Safari/605.1.15	142.113.227.106	\N	\N	\N	\N	\N
1686402a-05ca-41d7-9095-f384c435c645	6f1ae888-314a-46df-9c74-05456d4c517d	2026-02-12 00:26:29.393526+00	2026-02-12 00:26:29.393526+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	24.16.172.34	\N	\N	\N	\N	\N
74ff3cb0-eef3-47ad-b81d-858a6c7512b4	0c1a8cff-b719-4e94-966d-22e8fce601ed	2026-02-09 18:33:59.370635+00	2026-02-09 18:33:59.370635+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0	208.59.113.219	\N	\N	\N	\N	\N
6e414cc9-5d3e-4f10-99f0-fd27985c6946	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	2026-02-03 02:53:29.366183+00	2026-02-03 02:53:29.366183+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	173.66.240.109	\N	\N	\N	\N	\N
a5e601d0-4af7-4311-898a-5ecf44820be4	5bda8e48-63ad-424b-ba4c-b6dc8d90d467	2026-02-10 07:34:57.817416+00	2026-02-10 07:34:57.817416+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	79.252.120.40	\N	\N	\N	\N	\N
9ea0f433-0606-49fa-9dda-560603218aae	e798443f-c72a-40aa-b351-84d285cb8dfc	2026-02-12 04:11:25.592342+00	2026-02-12 04:11:25.592342+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	162.217.75.208	\N	\N	\N	\N	\N
81c6cf9e-4d7d-4507-9cc1-24f886508399	629bfa5c-5449-4583-8358-08335293caba	2026-02-06 22:40:41.528304+00	2026-02-06 22:40:41.528304+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Mobile/15E148 Safari/604.1	118.149.79.225	\N	\N	\N	\N	\N
d0796b3c-39ec-4227-84f7-23d8d454f019	0d886fc7-1b47-4870-bcb2-eff7cbed5950	2026-02-08 20:20:59.489612+00	2026-02-10 22:00:11.739429+00	\N	aal1	\N	2026-02-10 22:00:11.738594	Vercel Edge Functions	13.239.234.241	\N	\N	\N	\N	\N
ea2ae44f-5f0c-4ba9-b12d-0fcbabb545ea	2333c58f-094b-4dbb-9d56-347d134feda7	2026-02-07 00:35:59.082068+00	2026-02-07 00:35:59.082068+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:147.0) Gecko/20100101 Firefox/147.0	205.250.24.46	\N	\N	\N	\N	\N
08e0af12-fdbc-4a65-8103-b59ff2f93bb5	9744a793-abb5-43a7-a8d6-2ed6b59c2ef9	2026-02-14 02:37:11.717379+00	2026-02-14 02:37:11.717379+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	142.189.252.197	\N	\N	\N	\N	\N
791b35d8-2260-481a-abb2-3c7fddcc7b66	6f6fa59c-20ad-41b9-9f63-421dee593357	2026-02-07 00:51:08.044253+00	2026-02-07 00:51:08.044253+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	109.146.111.63	\N	\N	\N	\N	\N
4972410f-b644-40c4-ac8a-63255406b9f3	6a20c1a0-ee08-4708-84a7-2c7ad61b3041	2026-02-09 08:36:17.749863+00	2026-02-09 22:40:56.182262+00	\N	aal1	\N	2026-02-09 22:40:56.182166	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:147.0) Gecko/20100101 Firefox/147.0	95.90.243.39	\N	\N	\N	\N	\N
63069be8-d38d-49ed-97dc-fee50538a904	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-06 14:36:49.032446+00	2026-02-10 13:47:16.827079+00	\N	aal1	\N	2026-02-10 13:47:16.826945	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	89.187.178.13	\N	\N	\N	\N	\N
76f651a3-b5db-477d-86e9-8d294743d603	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	2026-01-23 23:46:38.699983+00	2026-02-14 08:20:25.89328+00	\N	aal1	\N	2026-02-14 08:20:25.892572	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	97.126.185.23	\N	\N	\N	\N	\N
4826e81c-61b7-49eb-8119-8b45d349e8cf	7de965d1-329b-4ee3-8814-7cfbb8291325	2026-02-11 09:42:38.355718+00	2026-02-13 19:02:15.604303+00	\N	aal1	\N	2026-02-13 19:02:15.604217	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Safari/605.1.15	85.4.115.22	\N	\N	\N	\N	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	authenticated	authenticated	jon@scios.tech	$2a$10$D6sbuJc1.0Rwicm176DwoO6OXBKNYFx3r5YFZa.fK0IsOpx9WX8j.	2025-09-23 23:01:42.923943+00	\N		\N		\N			\N	2026-02-08 13:13:50.772373+00	{"role": "admin", "provider": "email", "providers": ["email"]}	{"sub": "cdd7c3e5-6e9e-4974-8f69-63e8608d19a9", "name": "Jonathan Starr", "role": "participant", "email": "jon@scios.tech", "organization": "SciOS", "email_verified": true, "phone_verified": false}	\N	2025-09-23 23:01:42.884023+00	2026-02-13 20:47:05.730592+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	authenticated	authenticated	akamatsm@uw.edu	$2a$10$tiRsi5iG/qZcynjU3h7ANOriiViZJwsoB0duUo1NVcM.DY2l.GbCi	2025-09-25 20:38:49.612503+00	\N		\N		\N			\N	2026-01-23 23:46:38.698587+00	{"role": "admin", "provider": "email", "providers": ["email"]}	{"sub": "04807d9a-3e96-4a9e-a55d-b6e4ed75b50c", "name": "Matt Akamatsu", "role": "participant", "email": "akamatsm@uw.edu", "organization": "Discourse Graphs project", "email_verified": true, "phone_verified": false}	\N	2025-09-25 20:38:49.498468+00	2026-02-14 08:20:25.881818+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f58c6eb0-ad49-43b6-998b-c5deeac7bf59	authenticated	authenticated	maparent@conversence.com	$2a$10$Lwa0ln5dE3b5J/YlWLK91eQ7/50bTGgBhLVtj6ElJrlNgdfj.mCl2	2026-01-26 18:56:11.161153+00	\N		\N		\N			\N	\N	{"role": "admin", "provider": "email", "providers": ["email"]}	{"name": "Marc-Antoine Parent", "email_verified": true}	\N	2026-01-26 18:56:11.145242+00	2026-01-26 18:56:11.163284+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	629bfa5c-5449-4583-8358-08335293caba	authenticated	authenticated	nokome@stencila.io	$2a$10$iL0g3.xtrdlZGWbJcn2qcuHm61q4CT2a9i74galan4NRPELfjSYDm	2026-02-06 22:40:41.510026+00	\N		\N		\N			\N	2026-02-06 22:40:41.527529+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "629bfa5c-5449-4583-8358-08335293caba", "name": "Nokome Bentley", "role": "participant", "email": "nokome@stencila.io", "organization": "Stencila", "email_verified": true, "phone_verified": false}	\N	2026-02-06 22:40:41.397894+00	2026-02-06 22:40:41.563161+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6f6fa59c-20ad-41b9-9f63-421dee593357	authenticated	authenticated	a.campbell@digital-science.com	$2a$10$f5qXcSGGEi3hi3fpf9a2Ju0leFnIuAT4hibx2fji7hbvBUtu5.OzG	2026-02-07 00:51:08.034916+00	\N		\N		\N			\N	2026-02-07 00:51:08.044159+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "6f6fa59c-20ad-41b9-9f63-421dee593357", "name": "Ann Campbell", "role": "participant", "email": "a.campbell@digital-science.com", "organization": "Digital Science", "email_verified": true, "phone_verified": false}	\N	2026-02-07 00:51:07.96927+00	2026-02-07 00:51:08.061332+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	authenticated	authenticated	joelchan@umd.edu	$2a$10$wjyS7Y4InZ6ibnX/OLQKYuXAAHqHfyZa7IHw6GXUfdmZEoYxmlbl.	2026-01-26 18:54:39.74473+00	\N		\N		\N			\N	2026-02-03 02:53:29.364569+00	{"role": "admin", "provider": "email", "providers": ["email"]}	{"name": "Joel Chan", "email_verified": true}	\N	2026-01-26 18:54:39.712046+00	2026-02-03 02:53:29.441039+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	66586d4d-ad06-48ca-b937-c2bbde17f36a	authenticated	authenticated	ronen@cosmik.network	$2a$10$2pRg/7apm5.PNnodgBIyCOKy8qv/yy3Ga72UZ9hgC6h7y.6ZYBPQG	2026-01-26 18:57:01.824184+00	\N		\N		\N			\N	2026-02-09 16:18:50.76563+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"name": "Ronen Tamari", "email_verified": true}	\N	2026-01-26 18:57:01.808982+00	2026-02-09 16:18:50.807168+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	0d886fc7-1b47-4870-bcb2-eff7cbed5950	authenticated	authenticated	ellie.rennie@rmit.edu.au	$2a$10$A8.Cwl4K.ctKZ7JUeVDh7.mnNsoECugdMGxSTJW./7OhMp1hv2YQm	2026-02-08 20:20:59.473659+00	\N		\N		\N			\N	2026-02-08 20:20:59.489508+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "0d886fc7-1b47-4870-bcb2-eff7cbed5950", "name": "Ellie Rennie", "role": "participant", "email": "ellie.rennie@rmit.edu.au", "organization": "RMIT University and Metagov", "email_verified": true, "phone_verified": false}	\N	2026-02-08 20:20:59.363766+00	2026-02-10 22:00:11.729188+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	562212e3-819d-4d8f-b03b-57a8c9427f72	authenticated	authenticated	ellie@scios.tech	$2a$10$Eo1IcoQCyutdGch2rxom5OKDiD4P3ZqxcjSSb6K/tRxNTx7ZJPr5.	2025-09-24 12:17:30.973295+00	\N		\N		\N			\N	2025-09-25 18:46:29.902208+00	{"role": "admin", "provider": "email", "providers": ["email"]}	{"sub": "562212e3-819d-4d8f-b03b-57a8c9427f72", "name": "Ellie DeSota", "role": "participant", "email": "ellie@scios.tech", "organization": "SciOS", "email_verified": true, "phone_verified": false}	\N	2025-09-24 12:17:30.944572+00	2026-02-12 19:36:16.781884+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	2333c58f-094b-4dbb-9d56-347d134feda7	authenticated	authenticated	wesley@cosmik.network	$2a$10$ytBLwhhAWonNvzjYT/YcReZspwZB68MPpygAlO6QgkNq/CKcvMze.	2026-02-07 00:35:59.067873+00	\N		\N		\N			\N	2026-02-07 00:35:59.081366+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "2333c58f-094b-4dbb-9d56-347d134feda7", "name": "Wesley Finck", "role": "participant", "email": "wesley@cosmik.network", "organization": "Cosmik Network", "email_verified": true, "phone_verified": false}	\N	2026-02-07 00:35:58.983594+00	2026-02-07 00:35:59.102599+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	5bda8e48-63ad-424b-ba4c-b6dc8d90d467	authenticated	authenticated	frida.arreytakubetang@gmail.com	$2a$10$hv868NgpsYq0o/nrhba/9eBIJ/tRmyrAA6ADXuSSveYdY7JdOXLei	2026-02-10 07:34:57.796842+00	\N		\N		\N			\N	2026-02-10 07:34:57.81553+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "5bda8e48-63ad-424b-ba4c-b6dc8d90d467", "name": "Frida Arrey Takubetang", "role": "participant", "email": "frida.arreytakubetang@gmail.com", "organization": "ReO:SciCDA", "email_verified": true, "phone_verified": false}	\N	2026-02-10 07:34:57.696213+00	2026-02-10 07:34:57.863269+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	03583b49-b454-4903-9ec9-180a20a40946	authenticated	authenticated	rodrigo.miguelesramirez@mail.mcgill.ca	$2a$10$gaBpxsk.LCCo78emtE3K6eDMft1xWlOEi9u0oESP0Qfg8hp.AkBfS	2026-02-10 03:30:14.114927+00	\N		\N		\N			\N	2026-02-10 03:30:14.131387+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "03583b49-b454-4903-9ec9-180a20a40946", "name": "Rodrigo Migueles Ramirez", "role": "participant", "email": "rodrigo.miguelesramirez@mail.mcgill.ca", "organization": "McGill University", "email_verified": true, "phone_verified": false}	\N	2026-02-10 03:30:14.026629+00	2026-02-10 03:30:14.161101+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	0c1a8cff-b719-4e94-966d-22e8fce601ed	authenticated	authenticated	luke@block.science	$2a$10$0wovXJWImZH7AihqRDdPjOUuI2xgNRwgxCk6GyHOeB3LO0/aGs6fy	2026-02-09 18:33:59.356751+00	\N		\N		\N			\N	2026-02-09 18:33:59.369989+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "0c1a8cff-b719-4e94-966d-22e8fce601ed", "name": "Luke Miller", "role": "participant", "email": "luke@block.science", "organization": "BlockScience, Metagov", "email_verified": true, "phone_verified": false}	\N	2026-02-09 18:33:59.252645+00	2026-02-09 18:33:59.409236+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	96f9bcb8-0ef8-465a-90d1-dc056c1f9554	authenticated	authenticated	monica@creativecommons.org	$2a$10$T8i.s9M5hDgD3rY3XSJF5O17ipR/1qZGB/sF0QL6p1b.i027MtpbO	2026-02-10 20:07:17.303494+00	\N		\N		\N			\N	2026-02-10 20:07:17.315563+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "96f9bcb8-0ef8-465a-90d1-dc056c1f9554", "name": "Monica Granados", "role": "participant", "email": "monica@creativecommons.org", "organization": "Creative Commons", "email_verified": true, "phone_verified": false}	\N	2026-02-10 20:07:17.218796+00	2026-02-10 20:07:17.347873+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6a20c1a0-ee08-4708-84a7-2c7ad61b3041	authenticated	authenticated	m@jmartink.org	$2a$10$ftb332Kiwo8AgDDmWwO0teBw1/s2j2g6Mp/BUfF8k36jQ7QfiBlEm	2026-02-09 08:36:17.726737+00	\N		\N		\N			\N	2026-02-09 08:36:17.74914+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "6a20c1a0-ee08-4708-84a7-2c7ad61b3041", "name": "Martin Karlsson", "role": "participant", "email": "m@jmartink.org", "organization": "coordination.network", "email_verified": true, "phone_verified": false}	\N	2026-02-09 08:36:17.619748+00	2026-02-09 22:40:56.174006+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a07197c2-3744-40a0-b6d8-252769eae979	authenticated	authenticated	shaobsh@gmail.com	$2a$10$Syd0RZDz7h4os20P/sMyJu1tAxy5whtF0qb7l/PedoBm4gj4CwmLe	2026-02-09 13:47:00.675545+00	\N		\N		\N			\N	2026-02-09 13:47:00.688823+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "a07197c2-3744-40a0-b6d8-252769eae979", "name": "Saif Haobsh", "role": "participant", "email": "shaobsh@gmail.com", "organization": "Fylo", "email_verified": true, "phone_verified": false}	\N	2026-02-09 13:47:00.588398+00	2026-02-09 13:47:00.727133+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	9744a793-abb5-43a7-a8d6-2ed6b59c2ef9	authenticated	authenticated	hyunokate.lee@utoronto.ca	$2a$10$Xew7otQHAYbBWEJCtDENtOH8UdZbXL5jp8veAG6tLhkROTWe/heL.	2026-02-14 02:37:11.697674+00	\N		\N		\N			\N	2026-02-14 02:37:11.716654+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "9744a793-abb5-43a7-a8d6-2ed6b59c2ef9", "name": "Kate Lee", "role": "participant", "email": "hyunokate.lee@utoronto.ca", "organization": "U Toronto", "email_verified": true, "phone_verified": false}	\N	2026-02-14 02:37:11.578645+00	2026-02-14 02:37:11.750437+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	10569c05-bf71-4e59-ac71-cdb731877e55	authenticated	authenticated	sean.moore3@mail.mcgill.ca	$2a$10$Fv60OcMW1oMEpQStsvaB3OqQmW8dR38K/EjT19FvMKnbHMZYdvYpy	2026-02-13 23:52:07.348342+00	\N		\N		\N			\N	2026-02-13 23:52:07.356462+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "10569c05-bf71-4e59-ac71-cdb731877e55", "name": "Sean Moore", "role": "participant", "email": "sean.moore3@mail.mcgill.ca", "organization": "McGill", "email_verified": true, "phone_verified": false}	\N	2026-02-13 23:52:07.248742+00	2026-02-13 23:52:07.407216+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e798443f-c72a-40aa-b351-84d285cb8dfc	authenticated	authenticated	antonmolina@bnext.bio	$2a$10$gWTvCyAQOIioqoGYf0cx6eB/KmhKxBkxBuJ9bixZYmuWpHBDdtauW	2026-02-12 04:11:25.561269+00	\N		\N		\N			\N	2026-02-12 04:11:25.591572+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "e798443f-c72a-40aa-b351-84d285cb8dfc", "name": "Anton Molina", "role": "participant", "email": "antonmolina@bnext.bio", "organization": "b.next", "email_verified": true, "phone_verified": false}	\N	2026-02-12 04:11:25.476013+00	2026-02-12 04:11:25.635511+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	7de965d1-329b-4ee3-8814-7cfbb8291325	authenticated	authenticated	sekhar.ramakrishnan@astera.org	$2a$10$ij1y0Ez0dTm8U2UiSdfOl.dl.uG7B8D.C8E3.GDJPcPV5gaxoEi0C	2026-02-11 09:42:38.341815+00	\N		\N		\N			\N	2026-02-11 09:42:38.355625+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "7de965d1-329b-4ee3-8814-7cfbb8291325", "name": "Chandrasekhar Ramakrishnan", "role": "participant", "email": "sekhar.ramakrishnan@astera.org", "organization": "Astera Institute", "email_verified": true, "phone_verified": false}	\N	2026-02-11 09:42:38.248505+00	2026-02-13 19:02:15.602735+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6f1ae888-314a-46df-9c74-05456d4c517d	authenticated	authenticated	morgan@quantumbiology.org	$2a$10$GXqK6Ct9DH7Om47Fw9yGueJE6aRYeUkNRfdnCvgYxrp1mNxxhi0hK	2026-02-12 00:26:29.377799+00	\N		\N		\N			\N	2026-02-12 00:26:29.392724+00	{"role": "participant", "provider": "email", "providers": ["email"]}	{"sub": "6f1ae888-314a-46df-9c74-05456d4c517d", "name": "Morgan Sosa", "role": "participant", "email": "morgan@quantumbiology.org", "organization": "Quantum Biology Institute", "email_verified": true, "phone_verified": false}	\N	2026-02-12 00:26:29.283512+00	2026-02-12 00:26:29.433781+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: admin_todo_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_todo_comments (id, todo_id, author_id, content, created_at, edited_at) FROM stdin;
\.


--
-- Data for Name: admin_todos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_todos (id, title, description, status, priority, assigned_to, created_by, due_date, completed_at, completed_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: application_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.application_comments (id, application_id, author_id, content, parent_id, is_internal, created_at, edited_at, deleted_at) FROM stdin;
82a97f6a-3230-4933-a6f5-723d86ccc059	973536bb-1e83-48e9-951e-3855aaaa384d	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	Rodrigo checks the boxes of both (recently graduated) hands-on user and also had the same idea about modular research thru Obsidian, concurrently through discourse graphs. So his insights as researcher will be really helpful	\N	t	2026-01-23 23:48:30.480728+00	\N	\N
80dd74f8-c915-4aa2-8d53-785b0d99273d	164f9842-9aa7-46a6-9ae6-0375328e4845	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	Kind of a dream applicant: one who also has hands on knowledge to this problem (happens to be blockchain based 🤷🏼‍♂️) and whose platform should interop with our emerging schema. And who (to my knowledge) applied outside of a direct invitation	\N	t	2026-01-23 23:52:41.038233+00	\N	\N
f53fe875-9a9d-4a2b-88b4-3c1ebe2f084a	0861ae21-35e2-43c9-8d32-43d3a4331898	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	Came highly recommended by Prachee -- we should strongly consider	\N	t	2026-01-23 23:56:35.284746+00	\N	\N
33a9e96a-87f9-44de-90f6-f93a300594e3	206addc7-2b74-4411-bde8-6260b6195d9b	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	Is now running our fiscal sponsor, Homeworld Collective. Lots of adjacent projects that we want to explore together. Some are outside the scope of MIRA, such as: Homeworld operating as an umbrella fiscal sponsor for a network of discourse graphy organizations via https://cairos.network/.  Some are close to MIRA, such as Homeworld's "problem statement repository" --  a clear use case we want to support. i.e proposed study/experiment as an entity to track, cf https://docs.google.com/document/d/1MYGb022jkhUJ2wDW40EKxZojs29cDyvMoAn-1KdCIKU/edit?tab=t.0#bookmark=id.qgxnedjkrsh7	\N	t	2026-01-24 00:03:41.377075+00	\N	\N
b3237406-f58e-4386-ae8e-c4aeb5c39407	4da0807b-f867-419c-95cf-a7936de2ca0c	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	Wow... lots of extremely relevant prior work on PIDs as well as tracing impact and contributions -- the ideal outcome for MIRA (an alternative to impact/contribution assessment for funders and prospective employers)	\N	t	2026-01-24 00:08:55.023294+00	\N	\N
3264dec5-903f-4d0b-a663-223f3e94439d	49f87371-d757-4e94-8e00-a2d2ff490365	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	I'd also consider Paul to be a designer! "I've been creating small, loveable and complete web apps that gain feedback from real users quickly using generative AI coupled with my experience in building quality-driven software with XP. I can facilitate groups to get this fast feedback on new concepts, and prove the use of larger scale platforms or standards" I saw this in action during the last CSF workshop: they built a "spotify for science" in two days through a wonderful "ensemble coding" approach that we would benefit from	\N	t	2026-01-24 00:23:50.138274+00	\N	\N
05441e6f-7af4-4370-bb22-bdf4310c5c81	852c373a-34cc-4bdd-af4b-17ee974beff6	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	Personally know Edvard. Very familiar with PID systems and has built a relevant backend (CODEX). Builder.	\N	t	2026-01-30 14:08:36.972884+00	\N	\N
484ed832-b4aa-41a1-ae13-1e0e464bc753	4da0807b-f867-419c-95cf-a7936de2ca0c	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	Very very relevant work from a very relevant organization.	\N	t	2026-01-30 14:09:46.937732+00	\N	\N
67ead9ab-2692-4a4b-b501-39f14be6e050	0861ae21-35e2-43c9-8d32-43d3a4331898	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	Seems incredibly relevant. Builder.	\N	t	2026-01-30 14:11:30.090238+00	\N	\N
5237ccd8-acd5-483d-9423-aec7f95af9be	49f87371-d757-4e94-8e00-a2d2ff490365	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	Highly relevant. Builder.	\N	t	2026-01-30 14:13:40.797096+00	\N	\N
55fa7126-f72f-4199-8a6c-914561443476	973536bb-1e83-48e9-951e-3855aaaa384d	562212e3-819d-4d8f-b03b-57a8c9427f72	Thoughts - \n- Lots of different connections across many different orgs. I've been super interested in chatting with PKP + Juan Pablo more as well. Also the connection to many different publishers could be a super cool way to connect to diverse language groups + start exploring what this looks like at a more ecosystem level. \n- Seemingly very entreprenuerial and directed. \n- Feels a bit more like an ecosystem person than a technical person... but I'm not actually sure about that.	\N	t	2026-01-30 17:04:04.861416+00	\N	\N
37c8ab77-9072-4c20-be65-47d751e04e3b	164f9842-9aa7-46a6-9ae6-0375328e4845	562212e3-819d-4d8f-b03b-57a8c9427f72	Vibes based - seems SUPER pragmatic which I'm pretty into tbh. \n\nMore practical - I appreciate the clarity with which she's coming to this - spoke of her direct schema which woudl inform how she's coming in and so has a use case. Also has a platform that would likely be a bit more complicated, but a useful 'test' of the schema bc it's working across many different parts of the research process. I could see it being really useful to include bc it will lead to challenges specifically	\N	t	2026-01-30 17:13:41.641214+00	\N	\N
4f48bdeb-ff16-4dc7-a5f9-c90c652b5087	586a6447-edcc-471a-9d75-3cfb17d6a129	562212e3-819d-4d8f-b03b-57a8c9427f72	Thoughts - \n- More focused on his own research as far as I can tell + not sure if he'd bring a lab/collaborative process with him (although he mentions collaborative research, he only discusses breaking down his own research). \n- Code is important - but not knowing if it quite fits as the first focus for MIRA/if we'll be able to expand to include that section given the current orientation around written micropublications - would be cool tho.	\N	t	2026-01-30 17:20:35.467606+00	\N	\N
60882a68-9e33-41b9-b148-39d7f1b88414	852c373a-34cc-4bdd-af4b-17ee974beff6	562212e3-819d-4d8f-b03b-57a8c9427f72	Same - caveat to add is by June edvard will no longer be with DeSci labs. Will say that I'm biased in thinking he's super valuable + would bring a lot of experience, but the platform itself is likely not gonna be something he can bring	\N	t	2026-01-30 17:22:46.620684+00	\N	\N
902b300d-a6ac-4c1b-aea5-048ebb6c6bec	0861ae21-35e2-43c9-8d32-43d3a4331898	562212e3-819d-4d8f-b03b-57a8c9427f72	Could see - a bit more in a figuring it out phase on their end as far as I can tell. Says they want to include things for code, etc, but doesn't seem to have that finalized so I could see it being hard to actually integrate. \n\nTbd	\N	t	2026-01-30 17:55:18.618879+00	\N	\N
1a583041-b0f7-4449-a06c-24b1f66bc702	206addc7-2b74-4411-bde8-6260b6195d9b	562212e3-819d-4d8f-b03b-57a8c9427f72	I like the idea of including as a method of getting high quality input from someone who is good at coordinating ecosystems + who seems to have understanding of money and how to support infra. \n\nGenerally - ideal ecosystem person - practical and tapped in to many communities. \n\nAt the same time - I also see that we can likely bring in this expertise anyway + if we're trying to go for ppl outside the network to expand a bit could see that angle.	\N	t	2026-01-30 18:08:10.852872+00	\N	\N
6b45da4c-029d-42d2-8811-31512b3b7d55	4da0807b-f867-419c-95cf-a7936de2ca0c	562212e3-819d-4d8f-b03b-57a8c9427f72	Would prioritize - we don't have many funders + her connection to that ecosystem is something that feels important for eventually finding a way to connect this work into a set of people who are willing to pay for the service of knowing/having this much richer layer information.	\N	t	2026-01-30 18:32:32.478538+00	\N	\N
2ab9e95d-1d43-4a40-a609-6615946a494e	663c7b79-2b7b-4ecc-9278-044433c972c6	562212e3-819d-4d8f-b03b-57a8c9427f72	Seems more theorhetical and mentioned that several of the questions didn't really apply to him.	\N	t	2026-01-30 18:34:22.844121+00	\N	\N
ef7837be-6a05-476f-b088-60284f4aef1d	08babdf4-7fc8-41e3-9b98-06fdfd368b56	562212e3-819d-4d8f-b03b-57a8c9427f72	Personally know Cornelius and know he's super solid at bringing a group to a clear technical direction. \n\nAt the same time - his project seems similar to Ronen's so not sure if it's going to push in a particular direction/support broadening in a specific way.	\N	t	2026-01-30 18:38:47.294295+00	\N	\N
850ac7c2-0779-480b-b331-dd1d4ce6872f	d4cfa576-d8e8-4770-9d74-32c9a648b107	562212e3-819d-4d8f-b03b-57a8c9427f72	I like this - I was previously a bit eh on the coding use cases bc the people in the application didn't seem to have a clear idea of how they would operationalize that. However with this platform it seems like he's worked this out and I think this would be a really cool angle of expansion for the schema.	\N	t	2026-01-30 18:48:16.906586+00	\N	\N
66a4575b-ec48-4b1f-a42b-80277bc5dedf	49f87371-d757-4e94-8e00-a2d2ff490365	562212e3-819d-4d8f-b03b-57a8c9427f72	Positive - seems like he would also bring a builder/test it orientation.	\N	t	2026-01-30 19:03:02.02221+00	\N	\N
7d6e281f-5e39-4312-9f38-fafa172ff9bb	a5b8a482-b38e-44fc-af10-bf8b5baad8fe	562212e3-819d-4d8f-b03b-57a8c9427f72	I keep being on a tack of thinking of use cases that expand and I think the AI one is another 'direction' that would expand. He's also got a clear vision of what to add with the schema.	\N	t	2026-01-30 19:06:48.106674+00	\N	\N
956bdd7b-de60-4074-b872-29a9348c232d	109d1ee4-fe2b-46be-a4fc-bf043b0dc4a5	562212e3-819d-4d8f-b03b-57a8c9427f72	I like Ellie so may need to abstain. But my thoughts is she has a lot of experience actually dealing with micropublishing through ethnography and would have a good undersatnding of what the use looks like from the research perspective.	\N	t	2026-01-30 19:10:13.757023+00	\N	\N
f4ed76e0-907d-4456-8d95-5f5ebd1ded13	663c7b79-2b7b-4ecc-9278-044433c972c6	66586d4d-ad06-48ca-b937-c2bbde17f36a	Agree with Ellie - seems to be more theoretical, unclear how the MIRA tools would apply to their work. (also their career timing may not be a fit with MIRA  - mentioned "I am trying to be "orthodox" in my early career and just get good single-author papers into good journals")	\N	t	2026-02-01 19:52:24.443289+00	\N	\N
2891b42c-f4d7-4745-8957-4a98169584ee	49f87371-d757-4e94-8e00-a2d2ff490365	66586d4d-ad06-48ca-b937-c2bbde17f36a	Highly relevant - already concretely exploring collab with a lot of the projects in this space (CSF, DGs, Semble), lots of relevant prior experience through eLife/Sciety and music streaming background	\N	t	2026-02-01 19:55:14.054028+00	\N	\N
04c381ee-ef3e-445c-8eb6-9545a85327ca	109d1ee4-fe2b-46be-a4fc-bf043b0dc4a5	66586d4d-ad06-48ca-b937-c2bbde17f36a	I think Ellie brings a unique and relevant perspective in digital ethnography and contribution systems. Good follow up potential through KOI involvement	\N	t	2026-02-01 20:57:11.347042+00	\N	\N
aae2a30d-ac5c-4ae3-8ac5-f69ef3461e03	973536bb-1e83-48e9-951e-3855aaaa384d	66586d4d-ad06-48ca-b937-c2bbde17f36a	Agree with other comments- looks like Rodrigo can contribute in a lot of different ways, combining both relevant entreprenuerial and research experience. Already uses PKMs like Obsidian - another big plus (wasn't something that I saw with some of the other applicants). The program he is involved in (Circé Network) in Quebec also seems quite relevant	\N	t	2026-02-01 21:04:14.617093+00	\N	\N
faecdabc-d0ae-43e1-ad89-d6d62e0506d0	d4cfa576-d8e8-4770-9d74-32c9a648b107	04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	We could really use Nokome as one representative -- and now the primary engineer -- for OXA as our manuscript authoring standard.  OXA is basically him, Rowan (who can't come) and Carlos from Quarto (who didn't apply).  Talking through the "panel" (now called evidence bundle) concept during the continuous science foundation workshop made a light bulb go on for him about how to represent the same data object in multiple locations	\N	t	2026-02-02 04:19:55.99643+00	\N	\N
f48b554e-ba84-4869-b7be-1cc40499fed9	08babdf4-7fc8-41e3-9b98-06fdfd368b56	66586d4d-ad06-48ca-b937-c2bbde17f36a	re Ellie's comment - I see some similarities but also a lot of differences, for example seems more focused on technical aspects of publication and less on social sensemaking aspects. Prior research on incentive systems could also be a plus and relatively unique contribution	\N	t	2026-02-03 02:23:06.045208+00	\N	\N
f7806d78-aace-49a5-8baa-f676f507764d	d4cfa576-d8e8-4770-9d74-32c9a648b107	66586d4d-ad06-48ca-b937-c2bbde17f36a	I also see strong engineering contribution potential esp given the close work with Rowan on OXA	\N	t	2026-02-03 02:24:47.608467+00	\N	\N
bfb89e37-c34c-451d-a406-3da6f8757c57	164f9842-9aa7-46a6-9ae6-0375328e4845	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	Yeah, love that she's coming in from ~15+ years of direct experience as a scientist. Blockchain in this case seems good actually (not financialized, using its actual properties for immutability as a way to solve the verification problem). We don't have that in our direct orbit yet, so would be complementary. My only concern is she's not a *designer* per se, but more of a product level insight: the insight about needing to integrate into workflows is not wrong, but kind of surface level. So I'd almost place more in the research/ecosystem persona, rather than designer per se, but could serve as designer in a pinch.	\N	t	2026-02-03 03:05:34.236887+00	\N	\N
645a928a-d02a-4a11-b849-36f4d1c8c09f	fe8aec23-f059-4cc2-83b7-7e570d7e14b4	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	Hmm why is Luke still pending??? Super important engineering/ecosystem perspective, I suppose could inform UX drawing from his direct experience building with/for concrete use cases with KOI/DeSci, but not sure I'd label him as a designer/UX person.	\N	t	2026-02-03 03:09:02.392335+00	\N	\N
ef103895-69e1-4331-ad83-bb363cb18324	49f87371-d757-4e94-8e00-a2d2ff490365	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	Definitely need Paul here! Connection to Sciety and preprints and publishing platforms (laudatory) that are actually open to innovating is critical to add to our mix.	\N	t	2026-02-03 03:11:09.428124+00	\N	\N
532c0796-602d-49ca-b111-0514bf41254f	d4cfa576-d8e8-4770-9d74-32c9a648b107	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	Support Nokome joining for sure. Connection to OXA is important, but also re: complementarity to our technical perspectives, I'd highlight that Nokome has strong connections to existing standards like schema.org, as well as CRDTs (important for the more peer to peer collaboration layer that probably will overlap nicely with KOI).	\N	t	2026-02-03 03:15:04.273395+00	\N	\N
37e51801-6f50-4339-bbbb-8ab9b529b65d	0861ae21-35e2-43c9-8d32-43d3a4331898	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	Support! Similar rationale to Paul Shannon, Chandrasekhar gives us a bridge to the top-level publication layer that is already modular *and* in active use (the Stacks). I've noodled on ripe opportunities for connecting the Stacks to the ATMosphere for more open commenting (they already link to X) and possible structured review via Semble. The background experience connecting to standards for data and code are a big plus too.	\N	t	2026-02-03 03:18:50.231783+00	\N	\N
0ff3c2f1-6f72-4569-a3bb-51e6bdfdb03e	852c373a-34cc-4bdd-af4b-17ee974beff6	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	I'm cautiously supportive. Ellie, we should chat more about this, but I see Edvard as filling a similar niche as Frida re: connection to blockchain. DeSci Nodes also to me supports open hosting/archiving of other research assets. Depending on how much Frida's platform is in actual use vs. Desci for attribution problems specifically, we might want to choose one or the other?	\N	t	2026-02-03 03:21:49.579278+00	\N	\N
ecd95f0b-5f9e-41ef-9835-5a72bdcdf704	586a6447-edcc-471a-9d75-3cfb17d6a129	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	points in favor: direct involvement with JOSS (a pretty successful diamond open access community run journal that operates on github: would be neat to see how modular attribution might work there, but seems like he's not the best positioned to do this as a builder: the direct building he's doing is for his domain data science work in rshiny apps, rather than specifically for JOSS). reflections on his own researcher use cases for modular attribution seem less well connected to concerns about not just data/code, but also more conceptual elements like claims and evidence.	\N	t	2026-02-03 03:32:16.783792+00	\N	\N
524ad230-b9f5-4972-93a5-574a452e363e	586a6447-edcc-471a-9d75-3cfb17d6a129	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	direct involvement with JOSS is a plus (a pretty successful diamond open access community run journal that operates on github: would be neat to see how modular attribution might work there, but seems like he's not the best positioned to do this as a builder: the direct building he's doing is for his domain data science work in rshiny apps, rather than specifically for JOSS). reflections on his own researcher use cases for modular attribution seem less well connected to concerns about not just data/code, but also more conceptual elements like claims and evidence.\n\nwould say waitlist at best.	\N	t	2026-02-03 03:33:18.971038+00	\N	\N
\.


--
-- Data for Name: application_votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.application_votes (id, application_id, admin_id, vote, comment, created_at, updated_at) FROM stdin;
f4f11f95-9539-4dbd-a054-a08f5bfe8161	663c7b79-2b7b-4ecc-9278-044433c972c6	562212e3-819d-4d8f-b03b-57a8c9427f72	reject	\N	2026-01-30 18:33:50.411518+00	2026-01-30 18:33:50.411518+00
58dce494-10e0-4380-b9b4-cce932bd7b36	164f9842-9aa7-46a6-9ae6-0375328e4845	562212e3-819d-4d8f-b03b-57a8c9427f72	approve	\N	2026-01-30 19:07:08.962699+00	2026-01-30 19:07:08.962699+00
d6c39f2d-43d4-47aa-947e-e65382a11f4d	4da0807b-f867-419c-95cf-a7936de2ca0c	562212e3-819d-4d8f-b03b-57a8c9427f72	approve	\N	2026-01-30 19:07:43.735891+00	2026-01-30 19:07:43.735891+00
172a3483-33af-4a43-9ab9-f8a8589297ff	49f87371-d757-4e94-8e00-a2d2ff490365	562212e3-819d-4d8f-b03b-57a8c9427f72	approve	\N	2026-01-30 19:08:04.257266+00	2026-01-30 19:08:04.257266+00
cdd35f5d-5dcb-451f-afb6-1b3671f0f545	d4cfa576-d8e8-4770-9d74-32c9a648b107	562212e3-819d-4d8f-b03b-57a8c9427f72	approve	\N	2026-01-30 19:10:30.217178+00	2026-01-30 19:10:30.217178+00
7151145b-a648-479b-be99-e4278ce6d908	109d1ee4-fe2b-46be-a4fc-bf043b0dc4a5	562212e3-819d-4d8f-b03b-57a8c9427f72	approve	\N	2026-01-30 19:11:21.015478+00	2026-01-30 19:11:21.015478+00
53e6d73e-be72-4ccd-ae32-69fb9ce34fce	973536bb-1e83-48e9-951e-3855aaaa384d	562212e3-819d-4d8f-b03b-57a8c9427f72	approve	\N	2026-01-30 19:11:35.011517+00	2026-01-30 19:11:35.011517+00
b3f7e04d-616d-4826-849a-7ff6fc7bed79	663c7b79-2b7b-4ecc-9278-044433c972c6	66586d4d-ad06-48ca-b937-c2bbde17f36a	reject	\N	2026-02-01 19:51:06.515013+00	2026-02-01 19:51:06.515013+00
f7e2e826-8316-40a0-a797-830ccea445b7	49f87371-d757-4e94-8e00-a2d2ff490365	66586d4d-ad06-48ca-b937-c2bbde17f36a	approve	\N	2026-02-01 19:53:47.878051+00	2026-02-01 19:53:47.878051+00
0e2b1e5c-702d-4152-9dbb-e2de08029fc6	109d1ee4-fe2b-46be-a4fc-bf043b0dc4a5	66586d4d-ad06-48ca-b937-c2bbde17f36a	approve	\N	2026-02-01 20:55:32.72015+00	2026-02-01 20:55:32.72015+00
7b417c17-b9a1-4f25-9e06-efbcc81db1bf	973536bb-1e83-48e9-951e-3855aaaa384d	66586d4d-ad06-48ca-b937-c2bbde17f36a	approve	\N	2026-02-01 21:00:42.341818+00	2026-02-01 21:00:42.341818+00
ed1e1f0f-09c6-4227-9d4a-90ffec99b4e3	d4cfa576-d8e8-4770-9d74-32c9a648b107	66586d4d-ad06-48ca-b937-c2bbde17f36a	approve	\N	2026-02-03 02:24:51.534842+00	2026-02-03 02:24:51.534842+00
a2b27084-3231-4cd3-92c2-db2523098482	164f9842-9aa7-46a6-9ae6-0375328e4845	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	approve	\N	2026-02-03 03:05:59.478236+00	2026-02-03 03:05:59.478236+00
e21c83f0-6472-4c6d-ae5f-47b89272ae35	fe8aec23-f059-4cc2-83b7-7e570d7e14b4	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	approve	\N	2026-02-03 03:09:05.140735+00	2026-02-03 03:09:05.140735+00
f8e56adc-cdc2-4ba1-8e0d-7e1649f6b4e4	49f87371-d757-4e94-8e00-a2d2ff490365	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	approve	\N	2026-02-03 03:11:13.777393+00	2026-02-03 03:11:13.777393+00
b640041f-74d9-4a7d-be49-33377421cbe9	d4cfa576-d8e8-4770-9d74-32c9a648b107	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	approve	\N	2026-02-03 03:15:08.779764+00	2026-02-03 03:15:08.779764+00
d46ea619-ea0c-484b-8a6b-e7b2cb1b2263	0861ae21-35e2-43c9-8d32-43d3a4331898	b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	approve	\N	2026-02-03 03:18:54.008089+00	2026-02-03 03:18:54.008089+00
\.


--
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applications (id, user_id, status, role, admin_notes, submitted_at, reviewed_at, reviewed_by, updated_at, email, name, organization, total_votes, approve_votes, reject_votes, abstain_votes, voting_completed, voting_completed_at, classifications, classification_other, importance_of_schema, excited_projects, work_links, workshop_contribution, research_elements, researcher_use_case, researcher_future_impact, designer_ux_considerations, engineer_working_on, engineer_schema_considerations, landscape_specialist_current_work, landscape_specialist_see_emerging) FROM stdin;
973536bb-1e83-48e9-951e-3855aaaa384d	03583b49-b454-4903-9ec9-180a20a40946	accepted	Interdisciplinary Postdoctoral Research	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: Allergic to figs."}	2026-01-23 23:22:51.064908+00	2026-02-04 20:54:55.715+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-10 03:30:14.02449+00	rodrigo.miguelesramirez@mail.mcgill.ca	Rodrigo Migueles Ramirez	McGill University	2	2	0	0	t	2026-02-04 20:54:55.715+00	{researcher}	\N	I strongly believe that a profound transformation in the way we think of, produce, communicate and value science is direly needed. In that context, I believe that a composable, modular and interoperable research schema lies at the core of the paradigm shift required for this transformation. I envision this as the beginning of a system that increases the visibility and discoverability of research findings, facilitate sense making within, across and beyond research teams, and encourages reuse over duplication, collaboration over competition and leads to a more constructive, fair, synergistic, diverse, and open research ecosystem.	Interoperable modular models (Discourse Graphs and ZyenX). Alternative publication models (Arcadia Science, micro publications). Open databases (Open Alex). Preprint servers and open peer review projects (PREreview, ASAPbio). Platforms (Public Knowledge Project (PKP), Open Journals Systems (OJS), Érudit, OpenEditions, Janeway). AI tools (PleIAs, Connected Papers, Research Rabbit, Sourcely). DORA, CoARA.	[{"url": "", "role": "Inventor, team lead.", "description": "ZyenX. Since my PhD graduation, I am working through diverse channels to continue advancing a project I started in 2023 called ZyenX. ZyenX (pronounced similar to science but spelled differently in any possible way) is about re-imagining scientific publication for a more accessible, transparent, efficient, and fair research environment (science, differently). ZyenX provides a framework to structure scientific findings atomically to improve their findability and sense making for individuals and teams. Last year I met the team behind Discourse Graphs and we realized how these two are an example of convergent evolution: they have many features and properties in common, yet they differ in ways that I believe can be mutually complementary. ZyenX is still a bud compared to Discourse Graphs, but I hope that this space (MIRA) can be one in which the two may complement each other and grow together synergistically. ZyenX is at the heart of my work at Circe, B21, L2M and SCL."}, {"url": "https://reseaucirce.org/en/mission/", "role": "Interdisciplinary Postdoctoral Researcher", "description": "Circe Network. Thanks to conversations around the ZyenX project, I currently work with Prof. Vincent Lariviere as part of the team behind chairs for Open Science (UNESCO), research and discoverability (Quebec) in Montreal. More precisely, I work at the Circe Network, which supports 122 Quebec journals publishing mostly in French, aiming to facilitate the adoption of the diamond publishing model and to increase the discoverability of scientific contents across languages. To do so, we are working in collaboration with the governments of Quebec and France, to create an infrastructure that can help us measure and track the openness and discoverability of scientific contents in French. I have the wonderful mandate of helping these journals and researchers make their discoveries more visible and more easily findable, regardless of their language of publication or the language of the user, for which a multilingual, cross-discipline, modular research scheme will be instrumental."}, {"url": "https://www.building21.ca/apply", "role": "Fellow entrepreneur", "description": "Building21 (B21) & Lab2Market (L2M). ZyenX was created in Building 21, McGill's interdisciplinary ideation lab. I am currently a fellow in the AI-themed BLUE (Beautiful, Limitless, Unconstrained Exploration) fellowship program at B21, exploring the intersection of AI, collective human knowledge generation, and experiential learning in education as part of the ZyenX project. \\nAlthough BLUE is rigorous, the fellowship is also very explorative. To confront the framework to the constraints of the real world and create a strategic plan for its sustainable implementation, I am part of the Winter 2026 cohort of the Lab2Market Validate program (https://www.lab2market.ca/validate), which helps scholars test their entrepreneurial ideas in the real world through training and mentoring. The program is very structured and includes conducting interviews and working groups to understand the needs and pain points of the community, much like what the Continuous Science Foundation (CSF) is doing now with working groups on the technical, licensing and modular peer review aspects of innovative publication models. I am grateful to participate in two of these CSF working groups. "}, {"url": "http://scholcommlab.ca/", "role": "Doctoral intern", "description": "Scholarly Communications Lab (SCL). During the Fall 2025 and under the direction of Prof. Juan Pablo Alperin, I conducted an internship at the SCL Vancouver working on a project that aims to study the differences between preprints and versions of record, looking for changes in the conclusions, samples, authorship, etc. in the titles and abstracts using Natural Language Processing (NLP). This experience helped me familiarize myself with the methodological process of querying Crossref, DataCite and OpenAlex using APIs and then using NLP to compare text using diverse metrics and methods. The collaboration is still ongoing, and beyond understanding what happens with preprints after they are posted, this project will be instrumental in understanding the methodological details of how a new publishing system could function."}, {"url": "https://www.mcgill.ca/mypath/", "role": "PhD researcher, facilitator, UI/UX designer, software developer.", "description": "Zorion & myPath WebApp. Throughout my PhD, I worked on different aspects of collective behavior (agent based modelling), complex systems and network science, topics I am passionate about. In order to study and analyze these systems, I created some interactive tools. In particular, I created Zorion, an interactive MATLAB-based suite of tools for image analysis and data exploration to study collective behavior and information propagation in live cell microscopy data using Spatio Temporal Image Correlation Spectroscopy (STICS). The creation of a Graphical User Interface (GUI) gave me some useful skills on UI/UX design. Taking this experience further, I later started working on the design and construction of a web app using Figma as part of my work as a workshop facilitator at myPath. This tool is aimed to help students work on their personal and professional development, providing them with interactive exercises to identify goals and create a strategic plan to achieve them. These experiences have sensibilized me to understanding the user, which is a key consideration for the adoption of online, interactive platforms. I am also an avid user of PKM tools like Notion and Obsidian."}]	Systems thinking. Background in Molecular Biology, Quantitative Life Sciences: interconnectedness of signalling pathways, and information propagation across biological systems (cell migration). Ideation of the ZyenX framework, a modular research project supported by McGill's Building 21. Vision beyond in-lab use towards a sustainable scientific publication alternative to re-imagine the way we measure and incentivize scientific production. Working with the Scholarly Communications Lab, Canadian publishers associations (Circe, multilinguisme) and the UNESCO Open Science Chair.	In the ZyenX framework, we define multiple node and edge types across a multidimensional network. Nodes include statements, evidence entries, and datasets. Statements can be conclusions, hypotheses, or observations, and are supported by either evidence entries, by other statements (claims), or left unsupported (orphans). Evidence entries combine both objective data description and subjective interpretation, and can link to multiple statements, and datasets, and vice versa. Edges capture contradictions, agreements, and knowledge gaps.	First, to make my PhD research outputs available as living projects so that they can be used and improved by others, even if some are not yet published. Second, in-lab organization and sense making for collaborative cell migration and image analysis projects to ensure sustainability beyond student graduation turnover. Third, building a collective knowledge management system beyond my research team that can be used as a form of collegial communication.	This would make research faster, more efficient, transparent for scrutiny, reusable and reliable. Collaborative projects would advance faster, making asynchronous work much more efficient and traceable. We could share our findings faster and benefit from open peer review at a granular level. I can't wait to see where these initiatives will take us and I'm very excited to contribute to them in whatever way I can help!	\N	\N	\N	\N	\N
28cc3c9c-ca86-4301-83ca-3a27788a3b9c	\N	accepted	Direct Invite	\N	2026-01-26 20:54:32.653+00	2026-01-26 20:54:32.653+00	\N	2026-02-09 11:55:03.554378+00	akamatsm@uw.edu	Matt Akamatsu	\N	0	0	0	0	t	2026-01-26 20:54:32.653+00	{researcher}	\N	Direct invite - no application submitted	Direct invite - no application submitted	[{"url": "", "role": "Invitee", "description": "Direct invite"}]	Direct invite - no application submitted	Direct invite - no application submitted	Direct invite	Direct invite	\N	\N	\N	\N	\N
96c84e72-5f0e-4a2d-9bd5-b4e24fe95d60	\N	accepted	Direct Invite	\N	2026-01-26 20:54:32.152+00	2026-01-26 20:54:32.152+00	\N	2026-02-09 11:57:19.144326+00	teal@openrxiv.org	Tracy Teal	OpenRxiv	0	0	0	0	t	2026-01-26 20:54:32.152+00	{landscape_specialist}	\N	Direct invite - no application submitted	Direct invite - no application submitted	[{"url": "", "role": "Invitee", "description": "Direct invite"}]	Direct invite - no application submitted	Direct invite - no application submitted	\N	\N	\N	\N	\N	Direct invite	Direct invite
48905c53-784d-4945-be58-4e3982ada28d	10569c05-bf71-4e59-ac71-cdb731877e55	accepted	Direct Invite	\N	2026-01-26 20:54:32.815+00	2026-01-26 20:54:32.815+00	\N	2026-02-13 23:52:07.247778+00	sean.moore3@mail.mcgill.ca	Sean Moore	McGill	0	0	0	0	t	2026-01-26 20:54:32.815+00	{researcher}	\N	Direct invite - no application submitted	Direct invite - no application submitted	[{"url": "", "role": "Invitee", "description": "Direct invite"}]	Direct invite - no application submitted	Direct invite - no application submitted	Direct invite	Direct invite	\N	\N	\N	\N	\N
c416ce9b-80b5-4c63-9d83-d617237707cc	9744a793-abb5-43a7-a8d6-2ed6b59c2ef9	accepted	Direct Invite	\N	2026-01-26 20:54:31.995+00	2026-01-26 20:54:31.995+00	\N	2026-02-14 02:37:11.569549+00	hyunokate.lee@utoronto.ca	Kate Lee	U Toronto	0	0	0	0	t	2026-01-26 20:54:31.995+00	{researcher}	\N	Direct invite - no application submitted	Direct invite - no application submitted	[{"url": "", "role": "Invitee", "description": "Direct invite"}]	Direct invite - no application submitted	Direct invite - no application submitted	Direct invite	Direct invite	\N	\N	\N	\N	\N
f20eaf9f-af0f-48a3-85e9-39c867832e3b	96f9bcb8-0ef8-465a-90d1-dc056c1f9554	accepted	Director of Open Science	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: no seafood (but it's a preference not an alergy) "}	2026-01-05 17:42:31.012418+00	2026-01-29 14:00:12.588+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-10 20:07:17.217838+00	monica@creativecommons.org	Monica Granados	Creative Commons	0	0	0	0	t	2026-01-29 14:00:12.588+00	{landscape_specialist}	\N	As we move away from copyright driving norms of sharing, attribution could become critical to growing the commons and tacking misinformation. But their needs to be a little friction as possible for researchers to adopt good attribution practices. An interoperable research attribution schema is a necessary condition to build frictionless tools for attribution, particularly in new type of research outputs. 	I'm excited about the new phase OpenRxiv is entering. Having critical and popular infrastructure led by scientists allows experimentation with new ways of making sharing knowledge better and faster. I am also interested in the work at Arcadia Science who are pushing the boundaries of what research outputs can be. 	[{"url": "https://creativecommons.org/about/open-science/", "role": "Director of Open Science", "description": "I lead the open science work at Creative Commons where we have been focusing on increasing the adoption of our CC BY license and the development and integration of a preference signals framework for science. "}, {"url": "https://prereview.org", "role": "Co-founder", "description": "I co-founded PREreview an organization dedicated to bringing more equity to peer-review through our platform and training that enables preprint review. "}]	I have been working in the open science space for over a decade creating, incentivizing and driving researchers to adopt open practices. I have years of data and anecdotes on what works well in this ecosystem and what doesn't. In my current role at Creative Commons, where our most popular license requires attribution, I am particularly interested in how we can leverage attribution to encourage sharing. 	I look forward to building out the draft research process nomenclature expanded from the Akamatsu lab at the  San Diego Standard Workshop meeting: https://docs.google.com/presentation/d/1-KWPDFKCkl6EuFQbAzWb8MlEfmTwAaXtHTYQIxbl9GY/edit?slide=id.g3518a059c00_0_175#slide=id.g3518a059c00_0_175	\N	\N	\N	\N	\N	This would facilitate the application of the CC BY license and preference signals that require attribution in these emerging research outputs. 	I'm excited at the possibility of automating attribution and making attribution machine readable. The schema is fundamental in enabling more automation and reducing the friction for researchers to consistently attribution and get credit for their work. 
109d1ee4-fe2b-46be-a4fc-bf043b0dc4a5	0d886fc7-1b47-4870-bcb2-eff7cbed5950	accepted	Professor	{"Availability Confirmed: Yes","Travel Requirements: I do need to get approval from my university to attend this if I am accepted. As teaching for semester 1 has not been allocated, I will need to wait until at least second half of January before requesting absence from campus. ","Dietary Restrictions: Vegetarian"}	2025-12-17 20:26:58.401267+00	2026-02-04 20:54:51.479+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-08 20:20:59.362776+00	ellie.rennie@rmit.edu.au	Ellie Rennie	RMIT University and Metagov	2	2	0	0	t	2026-02-04 20:54:51.479+00	{researcher}	\N	I have been developing systems for qualitative research through my work on Telescope (Metagov) and through my collaborations with BlockScience and Metagov using Knowledge Organisation Infrastructure (KOI) to connect researcher obsidian vaults. I have also written extensively on contribution systems, including ethnographic work on how these systems are developing and where they are still incomplete/inadequate. My primary motivations are: 1) Ethnographic work needs to evolve to provide more ongoing feedback and participation as opposed to a single inscription; 2) contributions to joint work should be known and machine-readable; 3) we can enhance research integrity in the process.	I am interested in attestation systems and contribution systems (not necessarily research-specific, but can be used for that). I am involved with KOI because it provides a bottom-up approach to networking knowledge and does not require that all groups subscribe to the same computing ontologies. 	[{"url": "", "role": "Lead designer/researcher of the Obsidian vault and worked with developer Luke Miller on the plugin requirements", "description": "KOI-Telescope Obsidian plugin. A way to connect researcher Obsidian vaults using KOI nodes so that permissions/sharing can be controlled and objects can be referenced to upload/update/forget. See https://medium.com/block-science/building-the-loop-the-role-of-ethnography-in-artificial-organisational-intelligence-4c055fdf0c0c\\nand \\nhttps://medium.com/block-science/building-the-loop-the-role-of-ethnography-in-artificial-organisational-intelligence-4c055fdf0c0c"}, {"url": "https://github.com/metagov/slack-telescope", "role": "Lead researcher (developer = Luke Miller)", "description": "Telescope: A bot for ensuring participant consent inside chat forums Discord and Slack. If a comment is tagged with the Telescope emoji, the bot sends a message to the author asking for their consent and informing them of the research. This also collects data and updates datasets if people withdraw consent. "}]	I bring experience in ethnographic methods and have developed tools for ethical data collection and analysis, which are participatory and can be adapted to the field sites being studied. 	How hypothesis, claim etc can work with ethnographic data, where the hypotheses are surfaced from the field site itself. 	For ethnographic feedback loops that can lead to artificial organisational intelligence, where people are able to provide specific permissions/controls/governance over how data is used, including by machines. 	I hope that we can come to interdisciplinary schemas for research that combine ethnographic data with other data types. I'd also like to explore the epistemologies that this produces. 	\N	\N	\N	\N	\N
fe8aec23-f059-4cc2-83b7-7e570d7e14b4	0c1a8cff-b719-4e94-966d-22e8fce601ed	accepted	Research Engineer	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: None"}	2025-12-16 18:43:12.963159+00	2026-02-04 20:05:57.836+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-09 18:33:59.2517+00	luke@block.science	Luke Miller	BlockScience, Metagov	1	1	0	0	t	2026-02-04 20:05:57.836+00	{engineer,designer}	\N	I have been working on interoperable knowledge processing and communication standards for over two years now, and to me, research attribution is an important practical application of this work. Under the current system, journals and institutions have an outsized influence over the research process, and their centralized power leads to gatekeeping, unfair attribution, and unequal access to publications. Open, interoperable technologies provide us the opportunity to reverse theses power structures, reclaiming ownership over both our individual work, and the larger research ecosystem. 	DeSci Nodes, Discourse Graphs	[{"url": "https://github.com/BlockScience/koi-net", "role": "Systems Architect, Lead Developer", "description": "KOI-net (Knowledge Organization Infrastructure Networks) is a communication protocol for coordinating autonomous, heterogeneous networks for knowledge processing and transport. KOI-net is the third iteration of over two years of research into knowledge management systems in collaboration with BlockScience, Metagov, and the Royal Melbourne Institute of Technology. I serve as the systems architect and lead developer, responsible for the design of the protocol, reference implementation, core libraries, and and network and prototype implementations."}, {"url": "https://journals.sagepub.com/doi/full/10.1177/10778004221097056", "role": "Lead Developer", "description": "In collaboration with Ellie Rennie I developed Telescope, an interactive consent based data collection tool for use in ethnographic research. Telescope is used within online communities on Slack and Discord, providing an automated work flow to request, process, and release participants' comments for publication. In the past year, it has been upgraded to run on the KOI-net protocol, allowing changes in the consent status (e.g. retraction, anonymization) to propagate through other services, deleting or updating existing records to comply with the new status."}, {"url": "", "role": "Systems Designer", "description": "I designed and proposed a systems specification for the Quantum Biology Institute's research laboratory to enable synchronization, storage, and publishing of data and findings across their ongoing projects. The design was an automated pipeline hosting an electronic lab notebook website and publishing to DeSci Nodes."}]	As the architect behind KOI-net, I've spent a lot of time thinking about standards and interoperability. My work has touched everything from the philosophy of identity and heterogeneous computing, to the development of protocols, infrastructure, and applications (e.g. research tooling, search systems). I bring this experience, with my perspective from working in both the abstract and concrete, to contribute to the development of interoperable research attribution standards at the workshop.	Basic elements would include questions, claims, prior work, evidence, results, artifacts, and people. It is also important to define the relationships between these elements, and how they are represented. For example, "who is claiming what", or "what does this evidence support." Breaking down the research process into well defined elements and relationships allows for fine grained control over access and publishing. It also enables higher transparency by following the paths formed by relationships within research.	\N	\N	The most important factor in achieving adoption is lowering the barriers to entry. No one wants to sign up for another platform to let them transfer data between the multitude of platforms they already use. I've found it's usually best to meet people where they are (e.g. Obsidian, Slack, etc.), building up strong integrations with tools that researchers already feel confident using.	My previous work on data publishing with the Quantum Biology Institute, Telescope project with RMIT, and internal KOI network applications at BlockScience would all benefit from an interoperable research attribution schema. Using KOI, we have already prototyped knowledge exchange of ethnographic research data between RMIT, Metagov, and BlockScience. A more broadly adopted schema would allow easier collaboration with more organizations through automated knowledge pipelines, regardless of their specific use case. 	Similar to designing for researchers, lowering barriers of entry is also vital for implementing successful schemas and standards. This means building out adapters to existing platforms and tools, rather than expecting them to natively support the standard. Furthermore, an open software ecosystem allows members of the community to build integrations with the platforms they use, giving other users an easy path to entry without needlessly centralizing development.	\N	\N
a5880d57-c18a-4193-8c1a-a72c8c09ae41	\N	accepted	Direct Invite	\N	2026-01-26 21:19:19.465+00	2026-01-26 21:19:19.465+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-01-26 21:19:18.607269+00	jon@scios.tech	Jonathan Starr	\N	0	0	0	0	t	2026-01-26 21:19:19.465+00	{other}	Direct Invite	Direct invite - no application submitted	Direct invite - no application submitted	[{"url": "", "role": "Invitee", "description": "Direct invite"}]	Direct invite - no application submitted	Direct invite - no application submitted	\N	\N	\N	\N	\N	\N	\N
831f70ed-ca0f-4055-9f3f-0ff5dba402dc	\N	accepted	Direct Invite	\N	2026-01-26 21:19:58.797+00	2026-01-26 21:19:58.797+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-06 22:54:25.489927+00	Ellie@scios.tech	Ellie DeSota	\N	0	0	0	0	t	2026-01-26 21:19:58.797+00	{other}	Direct Invite	Direct invite - no application submitted	Direct invite - no application submitted	[{"url": "", "role": "Invitee", "description": "Direct invite"}]	Direct invite - no application submitted	Direct invite - no application submitted	\N	\N	\N	\N	\N	\N	\N
04b17351-a69c-4b62-b514-082533d470fc	6f1ae888-314a-46df-9c74-05456d4c517d	accepted	Scientific Data Systems Developer	{"Availability Confirmed: Yes","Travel Requirements: I'd appreciate a shower chair/seat in the bathroom if possible.","Dietary Restrictions: No onions or tomatoes please!"}	2026-01-13 18:51:02.767291+00	2026-01-29 14:00:27.495+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-12 00:26:29.281907+00	morgan@quantumbiology.org	Morgan Sosa	Quantum Biology Institute	0	0	0	0	t	2026-01-29 14:00:27.495+00	{researcher,engineer}	\N	I have a highly multidisciplinary background (BS in Biophysics and Chemistry, PhD in Computational Physical Chemistry) and I've seen firsthand how siloed research can be. Different fields describe the same phenomena with different terminology, making cross-disciplinary discovery hard. I also think the "messy middle" of research, such as failed experiments, methodology iterations, intermediate datasets, deserves attribution, not just final publications.	DeSci Nodes, discourse graphs, FAIR principles broadly. Anything that makes the process visible, not just the results.	[{"url": "", "role": "Lead Systems Developer", "description": "Over the course of a 3-month contract, I designed and implemented a publishing pipeline for the Quantum Biology Institute, who are making all of their lab notebooks available online. This was done by designing a system that doesn't require any extra work from the scientists, and instead building a system around their existing workflows. All the scientists have to do is record their science in their electronic lab notebooks, which are saved on a server on-site. The server backs up their work automatically every 6 hours to an affordable cloud backup (BackBlaze), and automatically publishes and hosts the lab notebook websites. Their work is also uploaded to DeSci Nodes, ensuring permanent archival storage for years to come. Their stance is that their research should be radically open and accessible, and I believe that can be facilitated by using boring, google-able tech."}]	I build infrastructure for actual humans. My approach is "boring and google-able" - simple, maintainable systems designed around existing workflows rather than forcing researchers to learn new tools. I imagine my grandmother trying to use systems I design, and if it's too complicated for her, I change it. I also have the perspective of someone who's been locked out of academia by cost and access barriers, so openness isn't abstract to me.	Lab notebook entries, methodology iterations, negative results, instrument configurations, datasets (raw and processed), analysis code, and design decisions. Basically the stuff that usually disappears between "doing the science" and "publishing the paper."	I'm building publishing infrastructure for a quantum biology lab that shares their lab notebooks publicly as they work. They're a new field without traditional peers, so radical openness helps them find collaborators across disciplines. We need a way to attribute not just the final results, but the intermediate work, the instrument builds, the failed calibrations, the methodology pivots.	Granular attribution would let us credit work that currently goes unrecognized, such as building instruments, creating data pipelines, and maintaining infrastructure. At QBI, I'm building systems where scientists save files and everything else happens automatically. Better attribution means the person who built the system gets credit alongside the person who published the paper. It enables collaboration across labs without contributions disappearing into "et al.	\N	I'm building QBI's research infrastructure, a pipeline from Obsidian lab notebooks to Jupyter Books to DeSci Nodes for permanent archival. Currently there's no clean way to attribute 'I built this instrument' or 'I created this dataset' distinct from traditional authorship. An interoperable schema would let these artifacts be citable and connected across platforms without requiring scientists to learn git.	Minimizing cognitive load is essential. If the system requires scientists to change how they work, they won't use it. The schema needs to be invisible, working in the background while people do their normal tasks. Sustainability matters too: boring, google-able tech that any future developer can maintain. Elegant systems that suck to use don't get used. Meeting people where they are beats theoretical elegance every time.	\N	\N
206addc7-2b74-4411-bde8-6260b6195d9b	\N	waitlisted	Executive Director	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: vegan (pasture-raised eggs ok)"}	2026-01-19 18:25:33.333274+00	2026-02-06 12:08:41.353+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-06 12:08:40.529118+00	paul@homeworld.bio	Paul Reginato	Homeworld Collective	0	0	0	0	f	\N	{landscape_specialist}	\N	Homeworld is a 501(c)(3) empowering the climate biotech research community. We advance research and nucleate new communities in interdisciplinary emerging technology spaces that often lack “full experts,” and which researchers are seeking to transition into, like atmospheric methane removal. Core focuses:\n \n-building community around emerging technologies\n-collaborative problem identification, producing concise “problem statements”\n-funding research.\n\nModular research framework with attribution could facilitate discourse/collaboration in new communities. This could enable research where no lab has all necessary expertise, and rigorous exploration of novel ideas, before publication – crucial for us. \n\nFurther, I believe these benefits generalize, and would improve all research.	Homeworld fiscally sponsors Discourse Graphs and Cosmik. I love both organizations’ ideas, but admittedly haven’t used their platforms.\n\nI like Experiment for open science crowdfunding.\n\nRather than trying to sound knowledgeable, I’ll be transparent that I’m generally not well-versed in open science infrastructure and modular research, despite working adjacently.\n	[{"url": "https://www.homeworld.bio/research/problem-statement-repository/", "role": "Ideated and designed the project, and led the writing for every problem statement currently in the repository.", "description": "The Homeworld Problem Statement Repository is where Homeworld shares our problem statements. Problem statements are concise descriptions of actionable open problems, which Homeworld coauthors with the research community.\\n"}, {"url": "https://homeworld.pubpub.org/pub/optical-biosensors-lipidomics-for-pmmo", "role": "I drafted the problem statement based on the coauthors’ outlines. I had help from a contractor, but confidentially I had to redraft the whole thing, so what you’re seeing is words I wrote and then edited based on coauthor feedback.", "description": "This is an example of one of Homeworld’s problem statements, which resulted from a workshop we hosted that convened international experts on atmospheric methane removal. At the workshop, most of the listed coauthors went through an exercise of identifying the outstanding bottlenecks limiting progress on specific technologies and then outlined problem statements. After the workshop, Homeworld drafted the problem statements and with feedback and revisions from the coauthors. We have drafted 39 such problem statements, with 22 coming from the workshop.\\n\\nThis particular problem statement attracted interest from a researcher, who was later funded through Homeworld Garden Grants.\\n"}, {"url": "https://docs.google.com/document/d/14mOLbetW4wGXwwL5b7wENQqw0YUcRMph7T1BWvkZy4g/edit?tab=t.0#heading=h.vxv806nhsu0s", "role": "I drafted the invitation, designed the workshop, led the workshop, and led the outputs from the workshop. The problem statement given in Example 2 was one of the workshop outputs, alongside 21 other problem statements.", "description": "This is the invitation 1-pager for a workshop that Homeworld led on biological approaches to atmospheric methane removal. It gives a high-level description of how we structure our workshop and the kind of work we get done there. It also shows how we engage with the community to do collective work with actionable outputs. The kind of modular outputs with attribution that the MIRA workshop discusses could provide a useful tool for using at these workshops, where ideas from individuals could be more readily emphasized."}, {"url": "https://homeworld.pubpub.org/pub/aqueous-solvents AND https://homeworld.pubpub.org/pub/exec-summary-part-1", "role": "I researched and wrote the report entirely myself, with advice from coauthor Colin McCormick, except for a short supplementary section written by coauthor Judy Savitskaya.", "description": "~18,000-word report, and corresponding executive summary, that roadmaps research opportunities for advancing the use of biocatalysts in carbon dioxide removal technologies. This longer-form kind of roadmapping is what I/Homeworld did before we started using problem statements. The report highlights actionable research opportunities, but is way less digestible than the problem statements. The difficulty we observed in translating the report to actual research is what prompted us to start developing problem statements. The first problem statements we produced were adapted from this report."}, {"url": "https://experiment.com/programs/garden-grants-ghgr", "role": "I played a supporting role in designing how this landing page would look, and the framework of using public problem statements with confidential solution statements. The work was led by my cofounder Dan. As Homeworld’s Executive Director, I oversee the continued use of this format in our grantmaking. I also led review for all the listed projects.", "description": "Landing page for sharing the proposals to Homeworld’s most recent round of Garden Grants. Each proposal has two sections: a public Problem Statement, and a confidential Solution Statement. This landing page links to the public problem statements for each proposal, except a few declined proposals who decided to have their problem statements taken down. The projects at the top are the ones we funded.\\n\\nWe make the Problem Statements public so that the broader community can see what problems the applicants are interested in. We’ve seen numerous instances of applicants receiving inbound inquiries about their work due to the public problem statements.\\n\\nWe use the open science platform Experiment.com to host this landing page.\\n"}]	Experience clarifying research discourse, technical roadmapping, understanding researchers’ capabilities/incentives, facilitating collaboration, identifying research opportunities, grantmaking. \n\nExperience conducting research.\n\n2023-present (Homeworld):\n-nucleated research communities/collaborations\n-facilitated/synthesized discourse into problem statements (PSs)\n-funded emerging technology research\n-designed PS framework and PS repository\n-drafted our 39 PSs\n-recruited proposals addressing PSs, provided funding\n-led grantmaking review\n\n2020-present: Climate biotech community steward/”superconnector” \n\n2022-2023: Lead author, 18000-word research roadmap for biocatalysts in carbon dioxide removal\n\n2014-2021: PhD, developed first-of-kind genomics technology.	big-picture motivation, specific goal, hypothesis, conjecture, question\n\nexperiment, object of study (e.g. specific microbial strain or protein variant), protocol, dataset, analysis, interpretation\n\ngap (open need for any of above)\n\nconflicts/disagreements/misalignments amongst any of above\n\nsome word to describe a line of discourse that conflicts with another line of discourse in a way that is “bigger” than an immediate conflict or misalignment\n\ncomment or review of any of above\n\nfunding for any of above	\N	\N	\N	\N	\N	Climate biotech is emerging and multidisciplinary. With a modular research platform with interoperable attribution, we could:\n\n-systematically identify problems and closely-related researchers\n-use granular problem statements to solicit/fund small-scope but important contributions\n-coordinate collaborations, especially involving small but essential contributions\n-incentivize contributions from researchers seeking transition into climate biotech who aren’t ready to take on large projects\n- incentivize/credit discourse integrating viewpoints on topics lacking experts\n-illustrate Homeworld’s contributions	Could enable:\n-researchers seeking transition into climate biotech to contribute in small steps, helping secure future full projects\n-collaboration where no single lab has all necessary expertise (common)\n-rigorous discourse in emerging topics lacking experts (common). Enzyme engineering for catalyzed direct air capture is example for first three points.\n-integrating distributed datasets to support general framework. Could be immediately useful for general theories of methane uptake in soil/forests\n
08babdf4-7fc8-41e3-9b98-06fdfd368b56	\N	waitlisted	PhD Candidate	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: None"}	2026-01-18 13:24:38.406496+00	2026-02-06 12:08:46.062+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-06 12:08:45.247269+00	ihle.cornelius@gmail.com	Cornelius	GippLab	0	0	0	0	f	\N	{researcher}	\N	Research success is about doing the right thing.\nTo compare who does the right thing, we need to measure the right things. \nIf the metrics fit, we can allocate research funds fair and be more efficient in our research. \n\n	Micro and nano contributions. LOCKSS. Open Access Publishing.	[{"url": "", "role": "Researcher, Developer, Project Manager", "description": "Academic Storage Cluster"}, {"url": "https://github.com/ihlec/d-social-app", "role": "Project Lead, Developer, Researcher", "description": "dSocialApp\\n\\nI work on a decentralized app where data ownership is fully in the hands of the users. I intent to use this for micro blogging and sharing research outputs: https://ipfs.io/ipfs/bafybeiaashw34t6uogjoxvv5jrq2fdgwx7upukhfrjckp6w3dowl7kjtjm/#/post/bafkreihfy4zmgb4nfab2gewin36i6i6n66jwd3uwlsp5c7q2kag4cvktge"}]	I do academic storage clusters. 	Shareable meta data of micro and nano contributions. \nI'am working on decentralized networks to share research output right now. Sharing is not enough. It must also be find-able and retrievable. 	An Academic Storage Cluster spanning connecting university libraries.  	We should ask: \n"Was there something we were proud of doing last year, that is not covered by any of our performance metrics?"\n\nAnswering this question and suiting our metrics for attribution to these answers will make research more fair end efficient. 	\N	\N	\N	\N	\N
0861ae21-35e2-43c9-8d32-43d3a4331898	7de965d1-329b-4ee3-8814-7cfbb8291325	accepted	Tech Lead	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: Vegetarian (eggs & dairy OK)"}	2026-01-19 19:57:31.18666+00	2026-02-04 20:30:40.9+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-11 09:42:38.248163+00	sekhar.ramakrishnan@astera.org	Chandrasekhar Ramakrishnan	Astera Institute	1	1	0	0	t	2026-02-04 20:30:40.9+00	{engineer}	\N	With The Stacks, we are developing a publication platform that looks beyond the existing journal and preprint server infrastructure. We want to support alternative structures for publishing research and alternative tools for capturing and quantifying impact. We see interoperable research attribution schema as one promising approach to explore.\n	The Stacks and Renku (of course -- I work on both), the Dataverse, DataCite, Quarto, Octopus	[{"url": "https://openbis.ch", "role": "Developer and Team Lead", "description": "openBIS is a platform supporting data management following FAIR principles. It offers flexible definition of metadata, is intended to work as an ELN as well as a BIS, and integrates with systems like CKAN."}, {"url": "https://renkulab.io", "role": "Developer", "description": "Renku connects data, code, and compute resources to make collaborative data science projects easier to manage and make outputs reproducible.  See https://papers.neurips.cc/paper_files/paper/2023/file/838694e9ab6b0a193b84daaafcac0eed-Paper-Datasets_and_Benchmarks.pdf"}]	Over the last 15 years, I have been involved in developing software to support data management and reproducibility and have some experience applying semantic-web technologies to build knowledge graphs and generally support open science. Through this, I have seen both strengths and weakness of technologies like RDF and SPARQL and have some insight which could be helpful for guiding the outcomes of this workshop.	Interested in all, but especially Evidence and Dataset and Code (which I have not yet seen), and how they relate to one another.	\N	\N	\N	In The Stacks, a publication platform, we want to allow publication of smaller sized units, provide better metadata for narrative publications, and build better metrics to assess the impact of research. The schema could help with all of these goals.\n\nIn Renku, this schema could be used to describe the purpose and links between code and data in projects. 	On a technical level, ensuring that the semantics are well-defined and understood by all involved. \nNot a technical issue, but equally, if not more, important: the success of the project depends on having communication channels that allow constructive exchange between participants. 	\N	\N
852c373a-34cc-4bdd-af4b-17ee974beff6	\N	waitlisted	Protocol Architect	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: Can't eat lentils, beans, or legumes."}	2026-01-21 11:21:24.096295+00	2026-02-06 12:08:39.066+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-06 12:08:38.250208+00	edvard@desci.com	Edvard Hübinette	DeSci Labs	0	0	0	0	f	\N	{engineer,landscape_specialist}	\N	Enabling navigation between different representations of research outputs, creating clear provenance between hopefully persistent information.	Codex network, hash-based PID's, FAIR research, reproducible builds and execution environments like Nix, compute over data	[{"url": "https://desci.com", "role": "Protocol Architect", "description": "Designing protocols and services at DeSci Labs / DeSci Foundation"}, {"url": "", "role": "Software Engineer", "description": "Backend, infrastructure and web3 systems at an EV battery analytics SaaS"}, {"url": "https://makerdao.com", "role": "Software Engineer", "description": "Deep technical work on VulcanizeDB, an Ethereum data indexing system"}]	Long and hard thinking about decentralised information storage and resolution, linked content versioning, hash based addressing, on/off chain data storage, web3 knowledge.	Articles, distilled claims, attestations, datasets, code, reproducible execution environments, links and references, PIDs, version histories, etc	\N	\N	\N	Codex Network, DeSci Publish, and dPID would all benefit from larger interoperability between different knowledge bases.	Interoperable data formats over open infrastructure, relying on machine readability over trying to design a schema that can represent everything. 	Open publishing infrastructure has trouble creating traversable edges between different datasets, causing a lack of provenance that should be theoretically possible to achieve.	Generation of claim graphs or content validation spanning different sources, all discoverable from one another. I envision a massive linked graph of different content representations, where provenance can be followed back to the initial source. Additionally, being able to track contributions to scientific gardening that isn't just scoped to original publications.
ec38e5d5-6e2d-4399-bf30-a8174c111954	a07197c2-3744-40a0-b6d8-252769eae979	accepted	Direct Invite	\N	2026-01-26 20:54:30.352+00	2026-01-26 20:54:30.353+00	\N	2026-02-09 13:47:00.587431+00	shaobsh@gmail.com	Saif Haobsh	Fylo	0	0	0	0	t	2026-01-26 20:54:30.353+00	{designer,engineer}	\N	Direct invite - no application submitted	Direct invite - no application submitted	[{"url": "", "role": "Invitee", "description": "Direct invite"}]	Direct invite - no application submitted	Direct invite - no application submitted	\N	\N	Direct invite	Direct invite	Direct invite	\N	\N
688dc81f-43bc-4736-b485-209aeaa97697	\N	accepted	Direct Invite	\N	2026-01-26 20:54:30.64+00	2026-01-26 20:54:30.64+00	\N	2026-02-06 23:00:05.037258+00	joelchan@umd.edu	Joel Chan	Discourse Graphs	0	0	0	0	t	2026-01-26 20:54:30.64+00	{landscape_specialist,researcher}	\N	Direct invite - no application submitted	Direct invite - no application submitted	[{"url": "", "role": "Invitee", "description": "Direct invite"}]	Direct invite - no application submitted	Direct invite - no application submitted	Direct invite	Direct invite	\N	\N	\N	Direct invite	Direct invite
8a3e0b92-8112-4c78-8798-3d0f2f6a0086	\N	accepted	Direct Invite	\N	2026-01-26 20:54:31.003+00	2026-01-26 20:54:31.003+00	\N	2026-02-06 23:00:07.391541+00	maparent@conversence.com	Marc-Antoine	Discourse Graphs	0	0	0	0	t	2026-01-26 20:54:31.003+00	{engineer}	\N	Direct invite - no application submitted	Direct invite - no application submitted	[{"url": "", "role": "Invitee", "description": "Direct invite"}]	Direct invite - no application submitted	Direct invite - no application submitted	\N	\N	\N	Direct invite	Direct invite	\N	\N
299dc155-be75-4e0b-a02e-bda8f25ae814	e798443f-c72a-40aa-b351-84d285cb8dfc	accepted	Direct Invite	\N	2026-01-26 20:54:30.822+00	2026-01-26 20:54:30.822+00	\N	2026-02-12 04:11:25.474341+00	antonmolina@bnext.bio	Anton Molina	bNext	0	0	0	0	t	2026-01-26 20:54:30.822+00	{researcher}	\N	Direct invite - no application submitted	Direct invite - no application submitted	[{"url": "", "role": "Invitee", "description": "Direct invite"}]	Direct invite - no application submitted	Direct invite - no application submitted	Direct invite	Direct invite	\N	\N	\N	\N	\N
82df79b3-c926-499e-924a-cc3dc5a8695b	66586d4d-ad06-48ca-b937-c2bbde17f36a	accepted	Co-founder	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: Vegetarian"}	2026-01-06 16:18:53.657496+00	2026-01-29 14:00:02.611+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-06 22:54:42.566442+00	ronen@cosmik.network	Ronen Tamari	Cosmik	0	0	0	0	t	2026-01-29 14:00:02.611+00	{landscape_specialist,engineer,researcher}	\N	At Cosmik we’re part of a network building a new kind of modular research commons, connecting AI, social media and next-generation collaborative research tools. We’re building Semble, a social micro-knowledge network for researchers on ATproto. We’re working towards unpacking the research process into smaller, composable and connected units that enable large-scale open collaboration. These include hypotheses, observations, connections, and reviews that all merit recognition. Like open source software that thrives on modular contributions, we're creating infrastructure where every insight, from any contributor, can find its place in the collective knowledge graph.	Discourse Graphs\n\nNanopublications\n\nIOSP\n\nPREreview\n\nSciety\n\nContinuous Science Foundation	[{"url": "https://cosmik.network/", "role": "CEO", "description": "Cosmik network co-founder. Building Semble, a live platform currently in early alpha with ~130 users on ATproto"}, {"url": "https://cosmik.network/hyperfeed", "role": "Entrepreneur in Residence at Astera", "description": "Astera Open Science fellow. 1 yr program with $500k grant to innovate on open science publishing and communication infrastructure. Built HyperFeed (predecessor to Cosmik), an AI enhanced social media feed aggregator "}, {"url": "https://cairos.network/", "role": "Co-founder", "description": "CAIROS co-founder - cooperative federation of open science projects working towards collectively stewarded research commons."}, {"url": "https://atproto.science/", "role": "Co-founder", "description": "ATproto Science co-founder - initiative aimed at building the ATProto/Bluesky research ecosystem"}]	Hands-on experience building Semble, live platform for researchers on ATproto that operationalizes modular research concepts\n\nMetascience entrepreneurship - Cosmik co-founder, Astera Open Science Fellowship (2024)\n\nEcosystem building experience - a wide network of collaborations and connections to research communities, open science projects and funders	With Semble's design, we prioritize:\n- Curated collections of research\n- Annotations: commentary and context about research\n- Reading paths: Sequential paths demonstrating learning trajectories\n- Micro reviews: open assessments and evaluation\n- Connections: Explicit relationships between resources showing how ideas build on each other, including discourse graph modules (claims/questions/hypotheses)	I am an active participant on science social media, engaging with my research communities by sharing recommendations, curating content, raising questions, synthesizing knowledge - I would love if more of the activities were recognized as research	It would make me much more likely to engage in collaborative knowledge sharing, and it would help me learn more effectively from others	\N	at Semble and ATProto Science we’re developing various data schema for research on ATproto that would benefit from standardization	Taking a lot of inspiration from similar efforts on atproto - https://standard.site/\n\n- Making life easier for developers - by requiring them to support standard schemas and not needing ad hoc integrations\n- Making life easier for users -data portability\n- Community ownership - Maintained by the builders/community. No single entity controls the standard.\n- Minimize governance overhead	- Network effects, easier interop across projects\n- Improving incentives for researchers to share knowledge due to improved attribution	- New discovery tools (esp AI and data hungry methods) that would benefit from diverse yet structured and well curated data.\n- New funding and impact evaluation mechanisms\n- New data intermediaries to protect the data rights of contributing researchers
e90799e1-1c1e-4cb8-8ff7-54b6289200c6	6a20c1a0-ee08-4708-84a7-2c7ad61b3041	accepted	co-initiator	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: None"}	2026-01-14 16:47:33.346063+00	2026-01-29 14:01:16.818+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-09 08:36:17.618236+00	m@jmartink.org	Martin Karlsson	coordination.network	0	0	0	0	t	2026-01-29 14:01:16.818+00	{landscape_specialist,other}	Coordinator	As I think it can unlock new mechanisms for collaboration and funding that are better for both the individual scientist and societal needs, by disintermediating gate keepers and legacy infrastructure prone to misalignment. As a whole the knock on effects can broaden access, participation and accelerate the path to societally beneficial outcomes.	https://atproto.science/	[{"url": "https://www.coordination.network/", "role": "co-initiator", "description": "A community of practice focused on solving complex problems leveraging LLM-powered workflows, collaborative data structures, programmatic incentives and local-first principles."}, {"url": "https://www.lateral.io/", "role": "co-founder / CEO", "description": "A company that applied machine learning techniques to assist with knowledge retrieval prior to the large language model era, culminating in the lateral app which assisted thousands of researchers with literature reviews."}]	I've been working in the space of applying machine learning to assist with knowledge work in complex organizations for over a decade. I bring a pragmatic perspective on how to make concrete progress towards principled outcomes. 	To provide a meta answer, I would focus on the opportunity to create infrastructure that allows for a diverse set of schemas to be harmonised. That's not to say we need complete flexibility, but rather facilitate that groups can operate with schemas that work for them and have harmonization layers between them. This opens up for tracking when it becomes necessary to consolidate, but doesn't get in the way of making progress. 	\N	\N	\N	\N	\N	It would provide an ideal standard for two initiatives. One is mapping individual research to ecosystem defined research roadmaps. The other is providing an output target for a lab glasses project which as a starting point will automate bench write ups based on video captured from smart glasses worn during the experiment. An interoperable attribution framework could help streamline adoption and technical development.  	Real time micro publication, shared open challenges / replication notice boards, programmatic funding
b1446c78-4c49-404b-909d-ce8beeb5a994	2333c58f-094b-4dbb-9d56-347d134feda7	accepted	CTO/Technical Co-Founder	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: None"}	2026-01-07 18:56:56.767215+00	2026-01-29 13:59:59.835+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-07 00:35:58.982612+00	wesley@cosmik.network	Wesley Finck	Cosmik Network	0	0	0	0	t	2026-01-29 13:59:59.835+00	{engineer}	\N	At Cosmik Network we are on a mission to support the stewardship of continuous and interconnected units of knowledge and research observations. We are building explicitly on the Authenticated Transfer Protocol (ATProto) because of its ability to support new kinds of interoperability across social networking and knowledge creation contexts. An interoperable research attribution schema would help us in making sure that the valuable contributions users within the Cosmik Network make can be recognized and utilized outside of our family of products. It also will support our goal of legitimizing micro-knowledge as useful and recognizable contributions to the scientific record.	ATProto Science (community exploring ideas around shared infrastructure to researcher specific moderation)\nLea (bluesky client for researchers)\nDiscourse Graphs\nNanopublications (have worked with them before)\nHypGen Infinity (hypothesis generation on ATProto)\nContinuous Science Foundation\nPREreview\nAlphaxiv	[{"url": "", "role": "Distributed Social Network Engineer Contractor", "description": "Contracted with various projects building community-oriented configurable, and interoperable online social spaces. A particular focus on mechanisms to enable and recognize small contributions within communities and between them."}, {"url": "https://cosmik.network/hyperfeed", "role": "Software Engineer", "description": "Contract software engineer for Hyperfeeds (precursor to Semble and Cosmik Network. Designed and wrote software for a cross-platform social media feed reader for researchers."}, {"url": "https://semble.so/", "role": "CTO/Technical Co-Founder", "description": "Building and designing the infrastructure for our flagship product, Semble, a social knowledge network for researchers, built on ATProto and in coordination with the emerging ATProto Science community."}]	I am the principal engineer designing and building Semble's infrastructure. I have direct experience building functional software systems and also have deep and extensive experience with ATProto. These will ensure I bring a pragmatic and protocol-oriented perspective into conversations about operationalizing modular research ideas into product features and well as the underlying mechanisms to ensure they are interoperable.	in our initial product in the Cosmik Network, Semble, we prioritize:\n- Curated collections of research\n- Annotations: commentary and context about research\n- Reading paths: Sequential paths demonstrating learning trajectories\n- Micro reviews: open assessments and evaluation\n- Connections: Explicit relationships between resources showing how\nideas build on each other, including discourse graph modules\n(claims/questions/hypotheses) and connecting supplementary material (connecting the codebase or dataset directly to the final paper)	\N	\N	\N	- science curation: semble enables curation of research "playlists"\n- research reactions / ratings: semble will enable users to rate / react to research artifacts along various dimensions\n- discourse graph connections: semble will enable labelled connections between research artifacts	to recognize and understand the trade-offs that come up between all participants. It is critical that the shared schema address real needs of each of the projects. As well as to understand that the schema itself is not the whole picture. Interoperability also requires coordinating infrastructure, building and designing APIs, and understanding the real use-cases of each participating product.	\N	\N
d4cfa576-d8e8-4770-9d74-32c9a648b107	629bfa5c-5449-4583-8358-08335293caba	accepted	CEO	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: None"}	2026-01-17 23:28:53.096605+00	2026-02-04 20:32:29.371+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-06 22:40:41.391108+00	nokome@stencila.io	Nokome Bentley	Stencila	3	3	0	0	t	2026-02-04 20:32:29.371+00	{engineer}	\N	A schema for interoperable research attribution would break down silos between systems, so contributions can be tracked and reused reliably, regardless of scientists preferred formats or platforms.\n\nBy allowing scientists to work with the tools they are most familiar with, schemas for interoperability improve collaboration, ensure fair recognition of work, and help us collectively build better infrastructure for scientific communication.	I'm excited about OXA as a community driven schema for interoperability between platforms and formats for scientific communication.	[{"url": "https://github.com/stencila/stencila", "role": "Lead Developer", "description": "I have lead the design of Stencila Schema as a data model for scientific documents and communications. Our focus initially was on representation of executable code elements (e.g. CodeChunk, CodeExpression) but has expanded to include a variety of types scientific works including Figure, Table, Datatable, Parameter and generative AI Instruction types."}, {"url": "https://oxa.dev/", "role": "Contributor", "description": "I am a core contributor to OXA, the Open Exchange Architecture,  a specification for representing scientific documents and their components as structured JSON objects. I have been involved in establishing the technical foundations for the project and initial RFCs."}]	Over the past decade I have been developing the Stencila Schema as data model for representing scientific documents and research outputs. This schema has been iterated on and tested extensively against real world scientific document in a variety of formats. I can bring my experience in balancing the various tradeoffs between specificity, flexibility, and interoperability. 	For the Stencila Schema I have defined several relevant types including Claim, Datatable, Figure, Table, and SoftwareApplication. These are all based on existing https://schema.org definitions (extending them where necessary). A full list of creative work types which I think could be defined, informed also by DataCite's list of resource types, is at https://github.com/stencila/stencila/blob/main/docs/reference/schema/works/creative-work-type.md.\n\nStencila Schema also includes types related to attribution and provenance including AuthorRole, Citation, CitationIntent, and Reference.	\N	\N	\N	Stencila is developing support for bidirectional interoperability with OXA schema. This will allow conversion between OXA and other formats that Stencila currently supports including Markdown flavors (e.g. Quarto, MyST), Microsoft Word, and Google Docs. If OXA includes a research attribution schema then we would be able to encode it in these formats and display in our user interfaces.	I think there is a balance to be struck between flexibility and strictness. Schemas that are too lenient and flexible (e.g. JATS) suffer from having too many forms of usage, and so interoperability is harder to implement. Schemas that are too strict and inflexible suffer from adoption because they fail to meet all use cases.	\N	\N
49f87371-d757-4e94-8e00-a2d2ff490365	\N	waitlisted	Head of Technology and Innovation	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: Lactose intolerant"}	2025-12-19 15:32:18.756684+00	2026-02-06 12:08:48.181+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-06 12:08:47.364046+00	p.shannon@elifesciences.org	Paul Shannon	eLife Sciences Publications Limited	3	3	0	0	t	2026-02-03 03:11:13.777393+00	{engineer,landscape_specialist}	\N	I work in the innovation of communicating scholarly outputs, in open source, with several non-profits and science organisations, but it's the researchers that are at the centre of the whole ecosystem, and they need to have clear provenance and trustworthy information about who, how and why the research was made and shared. This needs to be at any stage of the process too as waiting for publication means we have are limited in how we can innovate. Interoperability means we can independently create systems that ultimately work together and rise the tide for all efforts across the ecosystem.	OXA allowing the intersection of Stencila's LLM-assisted-but-with-provenance with Curvenote's interactivity and segmentation feels like new experiences could be more easily composed. Semble.co and sensemaking networks, Bonfire networks and social discourse around science might finally have their time to shine, and someone should make an alphaRxiv for all disciplines.	[{"url": "https://sciety.org", "role": "Founder / Head of Techology and Innovation", "description": "Sciety is an online platform for the discovery, evaluation, and curation of scientific preprints. It aggregates preprint evaluation for 25 groups that conduct this activity across multiple scientific disciplines. It provides curation tools for groups and individuals allowing them to organise preprints and evaluations into lists with annotations and descriptions. I was Sciety's founder, ran the team that designed, built and researched it and continue to advocate for further funding and opportunities for its expansion."}, {"url": "https://elifesciences.org/reviewed-preprints", "role": "Head of Technology", "description": "The Enhanced Preprint Platform revolutionised how the eLife journal and others wanting to adopt the Publish-Review-Curate model of publishing could display the granular stages of a preprint as it went through rounds of review and revision, resulting in what is perceived to be the equivalent of a version of record. While these publishing world concepts might hold back innovation in science communication this platform is proof that a bridge between the two worlds can be built, showcasing the evolution of a paper with a good UX while meeting the requirements of publishers. It is also available for use by others and in use by Biophysics Colab currently."}, {"url": "https://kotahi.community", "role": "Major contributor, advisor, user and steward", "description": "Kotahi is a peer review management, production, typesetting and publishing platform built with open source components and design to allow permissible rather than prescriptive approaches to workflow design for any scholarly activity. It is used by everything from micropublications to large scale publishing."}, {"url": "https://docmaps.knowledgefutures.org/", "role": "Lead on Implementation Working Group", "description": "DocMaps is a nascent protocol and community-endorsed standard for capturing and sharing machine-readable data about the editorial processes a research document goes through. It's used for share evaluation and curation steps between aggregation, hosting and review platforms but have many other use cases. This could be used as data exchange format for any type of scholarly object, showing through its directed graph all the contributions or process that have happened to that object."}]	I've been creating small, loveable and complete web apps that gain feedback from real users quickly using generative AI coupled with my experience in building quality-driven software with XP. I can facilitate groups to get this fast feedback on new concepts, and prove the use of larger scale platforms or standards. I'm also steward of Sciety, Enhanced Preprint Platform and Kotahi, with involvement in PubPub, Stencila and OKMaps so can share some lessons learned.	As a former software engineer using lean and XP I always think in terms of regular, small, deliverable and demonstrable value. The level of granularity that is useful to someone else might not be easy to see so a system that allow regular delivery of value without necessarily naming or compartmentalizing the outputs would be interesting to explore, allowing people to compose objects and share them with a more shared nomenclature like claim, dataset etc.	\N	\N	\N	DocMaps could help with this as its directed graph constructs a machine readable timeline of actions and assertions made about a research object, so could show the changes to attribution or related metadata on top of simply recording it. The schema is a good example of how to utilise existing ontologies and re-uses concepts as much as possible.	Many people misundstand that this is really a people problem and think it's a technical or documentation problem. Having regular meetings, touch points and updates - perhaps organised and maintained by a single organisation or person - that allows everyone to grow and gain a shared understanding of the goals as much as the implementation.	It would add a missing layer of trust to things like Sciety, EPP and Kotahi which would in turn bring more researchers to add to the value.	I  envisage smaller applications that are more researcher-centric and consider the people first - rather than paper or output or some arcane metric like impact factor, first. Building experiences more like modern applications that people use (Tik Tok, Netflix, Spotfiy) are going to be easier if we can interoperate between smaller systems and show true attribution for more granular parts of the research ecosystem that can be more readily shared.
164f9842-9aa7-46a6-9ae6-0375328e4845	5bda8e48-63ad-424b-ba4c-b6dc8d90d467	accepted	CEO/co-Founder	{"Availability Confirmed: Yes","Travel Requirements: Letter for the UK to get a visa for attendance in Ireland","Dietary Restrictions: None"}	2026-01-23 11:39:24.891663+00	2026-02-04 20:24:50.836+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-10 07:34:57.692838+00	frida.arreytakubetang@gmail.com	Frida Arrey Takubetang	ReO:SciCDA	2	2	0	0	t	2026-02-04 20:24:50.836+00	{designer,other}	Researcher	As CEO of ReO:SciCDA, I'm building blockchain-based infrastructure ensuring research integrity through immutable attribution and verification. Current attribution systems fail catastrophically: Stanford's president resigned over falsified data, Duke wasted $10M on fabricated cancer studies, fraudulent Alzheimer's research cost a decade. Science runs on trust, not verification—but it shouldn't. An interoperable attribution schema is foundational to our platform's mission: making retroactive falsification cryptographically impossible while ensuring every contribution—from hypothesis pre-registration to data collection to analysis—receives permanent, auditable attribution. Solving attribution isn't academic; it's essential infrastructure preventing fraud, accelerating discovery, and restoring public trust in science.\n	Protocols.io (open protocols), OSF (research lifecycle management), ORCID (persistent IDs), CRediT taxonomy (contributor roles), RoRID (resource identifiers), DataCite/Zenodo (DOI infrastructure), Protocol Labs/IPFS (decentralized storage), Ceramic Network (decentralized identity), Ocean Protocol (data marketplaces), VitaDAO (decentralized science funding), and Molecule.xyz (IP-NFTs for research attribution).\n	[{"url": "https://www.reoscicda.com/", "role": " CEO & Co-Founder - Product vision, strategic partnerships, institutional adoption strategy, fundraising, team leadership", "description": "ReO:SciCDA - Blockchain-Based Scientific Collaboration and Attribution Platform: We arebuilding decentralized research infrastructure on Solana blockchain ensuring research integrity through immutable attribution and verification. Platform provides: (1) Hierarchical identity verification creating \\"web of trust\\" between researchers, (2) Pre-registration of hypotheses preventing data manipulation, (3) Smart Electronic Lab Notebook (sELN) with real-time experimental logging, (4) Encrypted Information Management System keeping data private while recording cryptographic hashes on-chain, (5) Smart contract-based project management tracking milestones and contributions. Targeting Max Planck Society (86 institutes, 6,000 scientists), MDC Berlin (1,600 researchers), Charité (20,000 employees), and major research funders (DFG, ERC, Horizon Europe). SaaS model: €299/month per lab, €2,500-10,000/month institutional tier, plus verification certificates for journals/funders.  "}, {"url": "https://www.linkedin.com/in/frida-arrey-msph-phd/", "role": " Head of Business Development & Product Management - Portfolio strategy, product development lifecycle, regulatory strategy, cross-functional leadership, stakeholder management, fundraising support", "description": "Product Development & Strategic Portfolio Management - Building Usable Systems:  Head of Business Development & Product Management at midge medical, managing medical diagnostics development from concept through regulatory approval (CE/ISO) to commercial launch. Led portfolio strategy, cross-functional teams (R&D, regulatory, clinical, commercial), and achieved 20% time-to-market reduction while maintaining quality. Contributed to €20M fundraising. This experience taught me critical lessons for ReO:SciCDA: (1) Systems must integrate seamlessly with existing workflows or researchers won't adopt them, (2) Regulatory compliance (like our CE/ISO work) parallels verification requirements for research integrity, (3) Attribution must happen in real-time during work, not retroactively, (4) Business models must align stakeholder incentives (researchers, institutions, funders, journals)."}, {"url": "https://www.linkedin.com/in/frida-arrey-msph-phd/", "role": "PhD Researcher (Max Planck), Research Assistant (Rockefeller) - Experimental design, preclinical studies, model development, data analysis, publication, international collaboration", "description": " Tuberculosis & HIV Vaccine Research - Experiencing Attribution Gaps: 15+ years drug and vaccine development research at Max Planck Institute (TB) and Rockefeller University (HIV). Pioneered dendritic cell-targeted HIV vaccines and developed humanized mouse models for HIV, EBV, HCV now used globally. Published peer-reviewed research informing international research priorities. This work taught me attribution system failures firsthand: (1) Reagents/models I created enable others' breakthroughs but attribution fades, (2) Negative results never published waste others' time repeating failed approaches, (3) Collaborative contributions get compressed into author lists obscuring who did what, (4) Moving from academia to industry meant losing visibility despite continued contributions. These experiences directly motivated ReO:SciCDA's comprehensive attribution approach."}]	I'm actively building the infrastructure MIRA envisions. ReO:SciCDA uses Solana blockchain to create immutable research attribution—we're solving technical challenges of real-time logging, cryptographic verification, and API integration with existing lab systems. I bring: 20+ years research experience understanding what researchers actually need, product development expertise building usable systems, blockchain implementation knowledge, pilot partnerships with Berlin institutes and pragmatic understanding of institutional adoption challenges. I'm not theorizing about attribution schemas—I'm deploying one serving €2B+ research infrastructure.\n	Our platform attributes: Pre-registered hypotheses (timestamped predictions preventing HARKing), Raw data (immutable lab notebook entries), Methods (experimental protocols), Analytical code (computational workflows), Negative results (failed experiments), Materials (reagents, cell lines), Equipment usage (timestamped instrument logs), Collaborative contributions (who did what, when), Data provenance (complete audit trails), Verification certificates (cryptographic proof of integrity), Project milestones (smart contract-tracked progress), and Peer review contributions (editorial work, manuscript reviews).\n	\N	\N	The critical considerations are: (1) Seamless integration with researchers' existing tools rather than replacing them, (2) Granular privacy controls allowing selective sharing from private to public, (3) Zero blockchain knowledge required, (4) Clear incentives for all stakeholders (faster publication, grant compliance, fraud protection), and (5) Easy legacy data migration. Researchers won't adopt platforms that add friction—cross-platform access only works if it's easier than current solutions like email and spreadsheets.	\N	\N	\N	\N
586a6447-edcc-471a-9d75-3cfb17d6a129	\N	waitlisted	Postdoctoral Researcher	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: None"}	2026-01-22 22:59:23.647216+00	2026-02-06 12:08:25.928+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-06 12:08:25.108697+00	wbgearty@syr.edu	William Gearty	Syracuse University Open Source Program Office	0	0	0	0	f	\N	{researcher,engineer}	\N	As a scientist who conducts research, collects data and assembles them into datasets, and writes a LOT of code (some of which is bundled as software), it's becoming increasingly apparent to me that the existing model of publishing papers is archaic and no longer fits with the modular and highly collaborative way we now do science. We need a better way for scientists to give credit to all of the people that are involved in conducting research and the tools (software/data) that they use to conduct that research.	Journal of Open Source Software: research software engineers getting credit for their software contributions\nOpen Palaeontology: accepting a wide range of publication and media types (https://www.openpalaeo.org/publication-types)\nOpen Science Framework (OSF): promotes open research projects that evolve over time and have discrete components	[{"url": "https://williamgearty.com/deeptime/", "role": "Maintainer", "description": "deeptime extends the functionality of other plotting packages (notably ggplot2) to help facilitate the plotting of data over long time intervals, including, but not limited to, geological, evolutionary, and ecological data. The primary goal of deeptime is to enable users to add highly customizable timescales to their visualizations. Other functions are also included to assist with other areas of deep time visualization. It has been downloaded over 40,000 times."}, {"url": "https://palaeoverse.palaeoverse.org/", "role": "Co-Lead Developer", "description": "The aim of palaeoverse is to generate a community-driven software package of generic functions for the palaeobiological community. The package does not provide implementations of statistical analyses, rather it provides auxiliary functions to help streamline analyses and improve code readability and reproducibility. It has been downloaded over 16,000 times."}, {"url": "https://onlinelibrary.wiley.com/doi/10.1111/pala.70028", "role": "Researcher", "description": "Here, we outline ten rules that aim to aid the process of cleaning fossil occurrence data for downstream analysis. These rules cover the major steps involved in processing data prior to analysis, including project setup, data exploration and cleaning, and finalizing and reporting work."}, {"url": "https://williamgearty.com/paleopal/", "role": "Lead Developer", "description": "Paleopal is a proof-of-concept Shiny app that provides a user-friendly interface to build fully reproducible paleontological data science workflows without any programming knowledge. More details can be seen in a poster I gave at USRSE'25: https://zenodo.org/records/17260013."}]	I would be able to bring several different perspectives to the workshop: 1) a researcher who conducts highly interdisciplinary and computational research; 2) a research software engineer who develops software packages that are used by other researchers; 3) an editor at the Journal of Open Source Software, where I oversee the review of research software publications; and 4) an academic OSPO worker who interacts with a wide range of researchers across Syracuse University.	Dataset: data (experimental or observational) that have been collected for the purposes of answering one or more research questions\nProtocol: a list of steps that were followed by a researcher to acquire and/or analyze data\nSoftware: programming instructions written to perform analyses, create visualizations, or otherwise interact with data\nHypothesis: a proposed, testable explanation for some observation\nResult: the output of some kind of analysis of data, often as a way to test a hypothesis	I would break down my research into modules so that all contributors can get the proper attribution and credit that they deserve (e.g., the software developers would publish the software, the students and other research assistants would publish the data, etc).	More granular research sharing and attribution would encourage us to publish smaller components of our research projects at a faster pace. I imagine this would lead to more and stronger research collaborations.	\N	I'm currently developing a Shiny app that provides a user-friendly interface to build fully reproducible paleontological data science workflows without any programming knowledge. I envision that the app could use the schema to produce a comprehensive reference list that covers all of the data and software that were incorporated into both the software itself and the workflow that the user developed.	Language-agnostic: it would be fine to have language-specific wrappers, but anyone should be able to query the schema/API from any programming language\nGood documentation: it can be very common for these kinds of integration tools to become bulky and unwieldy; user-friendly documentation is paramount to ensuring users can still understand how to interact with it\nExpandability: make it easy to expand the functionality	\N	\N
663c7b79-2b7b-4ecc-9278-044433c972c6	\N	waitlisted	Research Software Engineer	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: None"}	2026-01-18 18:52:03.973158+00	2026-02-06 12:08:43.369+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-06 12:08:42.556832+00	owen@topos.institute	Owen Lynch	Topos Institute	2	0	2	0	f	\N	{researcher}	\N	To me, a computational answer to a scientific problem involves three parts:\n\n1. Concept identification\n2. Clever manipulation of concepts (in *declarative* form) to derive a procedure\n3. Execution of that procedure.\n\nBroadly, I'm interested in moving "software for science" from just being about #3 to being about #2 and #3, and to be tightly integrated with documentation for #1. I want this because I want the assumptions that a scientist makes to be more transparent. I would like to work with other people on this vision, and that is why I'm interested in MIRA.	I'm excited about developing more expressive languages for non-parametric statistics (such as LazyPPL), because my hope is that this will allow scientists to more effectively use "model ensembles"; e.g. have the combinatorial structure of the model itself be a space that is searched over computationally.	[{"url": "https://github.com/AlgebraicJulia", "role": "Research Software Engineer", "description": "A suite of libraries for applying category theory to scientific modeling in Julia"}, {"url": "https://github.com/ToposInstitute/systems-theories/tree/main/crates/rsm", "role": "Research Software Engineer", "description": "A domain-specific language for resource sharing machines"}, {"url": "https://catcolab.org", "role": "Research Software Engineer", "description": "A collaborative notebook for domain-specific declarative languages. I built the type theory that allows for composing multiple notebooks into a single model."}]	I have a background in:\n\n1. Compositional approaches to classical physics (the subject of my master's thesis)\n2. Type theory (my current area of study)\n3. General math (algebra, analysis, logic, etc.)\n4. Category theory (which I try to avoid inflicting on other people, but inevitably guides much of my work)	I think that it is philosophically quite dangerous in many areas of science to "prematurely formalize." Therefore, I'm interested in starting in relatively less shaky territory, like applications of classical physics for engineering, where there is a large body of work formalizing declarative models (e.g. Modelica). In this territory, I'm mainly interested in defining *models.*	I think "Researcher" may have been meant to capture more application-driven people. My concrete technical projects are concerned with type theory at the moment, with aspiration applications to science, so I don't have an immediate use-case for something that is science-focused.	Again, not sure if this is very applicable to me? Perhaps it would speed up my collaborations, but I am trying to be "orthodox" in my early career and just get good single-author papers into good journals so while in the future I can imagine a less traditional approach, currently I have my head down a bit.	\N	\N	\N	\N	\N
4da0807b-f867-419c-95cf-a7936de2ca0c	6f6fa59c-20ad-41b9-9f63-421dee593357	accepted	Director Research Impact and Compartive Analytics	{"Availability Confirmed: Yes","Travel Requirements: None","Dietary Restrictions: None"}	2026-01-19 10:14:10.461291+00	2026-02-04 20:24:55.121+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-07 00:51:07.968257+00	a.campbell@digital-science.com	Ann Campbell	Digital Science	1	1	0	0	t	2026-02-04 20:24:55.121+00	{landscape_specialist}	\N	Interoperable research attribution matters to me because it underpins our ability to understand and evidence the real impact of funded research in a highly siloed ecosystem. Current attribution models prioritise publications and authorship, fragmenting how value is created and obscuring contributions such as data, software, policy influence, industry collaboration, and team-based work. I work with funders, academic institutions, and evaluators under pressure to demonstrate return on public investment, yet lacking infrastructure to trace impact across systems. Without interoperable attribution, evaluation continues to reward proxies rather than outcomes, reinforcing misaligned incentives across research.	Initiatives focused on interoperable, sustainable research infrastructure - Invest in Open Infrastructure, Australian Research Data Commons, National Open Research Forum etc. Also modular, discourse-level approaches, discourse graphs and platforms like Semble, and how they connect to PID infrastructures (ORCID, ROR, RAiD, Crossref, DataCite) supporting attribution across funding, outputs, and impact.	[{"url": "https://digitalscience.figshare.com/articles/report/Australian_National_Persistent_Identifier_PID_Benchmarking_Toolkit_Consultation_Draft_June_2025_/29281667?file=58577053", "role": "Research Assistant", "description": "PID Benchmarking & Adoption Diagnostics\\nContributed to national PID benchmarking work analysing adoption, coverage, and linkage of identifiers across people, organisations, funding, and research outputs. This work surfaced where attribution infrastructure breaks down in practice, how uneven PID adoption limits interoperability, and how incentives tied to funding and reporting influence uptake. The findings provide empirical evidence to inform realistic, adoption-aware attribution design."}, {"url": "", "role": "Lead Analyst", "description": "Impact Pathway Modelling\\nDesigned relational data models linking funded research to diverse outputs and downstream reuse, including publications, datasets, policy documents, clinical guidance, and patents. This work enables attribution of impact beyond publications and supports funder accountability and evaluation. It also highlights opportunities to connect fine-grained research contributions (e.g. claims, evidence, methods) captured in modular or discourse-based systems to funding, attribution, and real-world impact pathways.\\nThese are individual institutional approachs that I can demo if required"}, {"url": "", "role": "Lead Author / Analyst", "description": "Authorship, Contribution & Collaboration Pattern Analysis (APAC Region)\\nConducted large-scale analyses of authorship and collaboration patterns, including lead authorship trends, team size growth, sectoral collaboration, and gender and geographic effects. This work demonstrates how traditional authorship models obscure contribution in team-based research and misalign incentives, reinforcing the need for more granular, interoperable attribution that reflects how research is actually produced.\\nWhite paper in progress. More than happy to demo or talk through work to date. "}]	I bring a systems and data-model perspective grounded in working with large-scale, linked research data across funding, publications, datasets, policy, and patents. My approach focuses on how attribution is operationalised in real infrastructures, using persistent identifiers, relational data models, and impact linkages to trace research pathways. I am interested in connecting fine-grained research contributions to funding, institutional context, and downstream impact so interoperable attribution can support funder reporting, evaluation frameworks, and impact assessment.\n	I would define modular elements across the research lifecycle, not just final publications. These include funded projects and investigator roles; research questions, claims and study designs; datasets, software, and protocols; publications and preprints; and evidence of downstream reuse such as policy influence, clinical guidelines, patents, and industry uptake. Treating these as attributable objects allows impact pathways to be traced from funding through to application, rather than inferred indirectly through publication-centric proxies.	\N	\N	\N	\N	\N	An interoperable attribution schema would allow my work to move from inferred to explicit impact pathways. It would enable consistent linking of funding, contributors, research outputs, and downstream reuse across systems, supporting more accurate analysis of contribution, collaboration, and impact. This would reduce reliance on publication-centric proxies and allow evaluation, benchmarking, and policy analysis to reflect how research is actually produced and used.	A shared attribution schema could unlock ecosystem-wide projects that trace research contributions from funding through to societal, economic, and policy impact; support fair recognition of team-based and non-traditional contributions; and enable interoperable evaluation across funders, institutions, and platforms. It would also enable new forms of benchmarking, impact forecasting, and mission-driven analysis, helping align incentives with openness, collaboration, and real-world outcomes rather than publication-centric proxies.
a5b8a482-b38e-44fc-af10-bf8b5baad8fe	\N	waitlisted	AI Specialist	{"Availability Confirmed: Yes","Travel Requirements: I am willing to travel for the workshop and participate in all required in-person sessions and activities.","Dietary Restrictions: None"}	2025-12-05 17:05:05.835463+00	2026-02-06 12:08:51.372+00	cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	2026-02-06 12:08:50.567453+00	pnara@internet2.edu	Pavan Subhash Chandrabose Nara	Internet2	0	0	0	0	f	\N	{researcher}	\N	An interoperable attribution schema is essential for enabling transparent, reproducible, and modular research especially for communities onboarding to modern AI and cyberinfrastructure platforms. In my work with HBCUs and TCUs, researchers often generate valuable intermediate results that never get captured, shared, or credited because attribution systems are in pieces across tools, clouds and workflows. A single schema would allow every research object to be properly versioned, cited, and reused. Also this will accelerate real-tome science, support FAIR practices, and help emerging research communities participate in national scientific efforts.	I'm really excited about NAIRR Pilot, ST4SD, Hugging Face models/datasets, GitHub's provenance and other emerging FAIR/CARE standards. I'm really inspired by modular workflows, reproducible pipelines, and research infrastructure that enables real-time collaboration.	[{"url": "https://github.com/ms-cc-org/ai-research-starter-kit", "role": "Lead Designer & Technical Specialist", "description": "The AI Research Starter Kit is an emerging framework I'm designing to help faculty and researcher especially at HBCUs, and TCUs, translate scientific questions into reproducible, modular AI workflows. Although early in development, it already serves as a scaffold for real-time science: it breaks down the research process into discrete, attributable components such as dataset preparation, modeling steps, parameter choices, evaluations and narrative interpretations. \\nThe kit provides hands-on Jupyter workflows, templates and an interoperable structure that promotes consistency across diverse research domains. It is intentionally modular: audience can swap datasets, models, and analysis steps based on their goal while maintaining traceability, and provenance. A long-term goal is to integrate attribution schemas directly into each notebook cell or component enabling automatic generation of structured research objects that can be shared, cited, and reused across platforms like NAIRR, ACCESS, and institutional repos.\\nTo summarize, our starter kit aims to lower the barrier to AI-enabled research, improving reproducibility, and creating a shared language for documenting and attributing scientific work, an effort closely aligned with emerging open science and modular research initiatives."}]	I bring hands-on experience helping researchers translate scientific questions into reproducible AI workflows across NAIRR, ACCESS, JetStream2, and other cloud platforms. I work closely with HBCUs, TCUs, giving me an insight into challenges faced by under-resourced institutions. My approach emphasizes modularity, transparency, workflows, and practical implementation. I can connect standard development with real researcher needs and help prototype schemas that integrate naturally into AI, Jupyter, and Cloud based research environments.	I would define modular, machine-readable units such as datasets, model checkpoints, preprocessing, code cells, prompts, evaluation metrics, visualizations, and intermediate results. Each of it should include authorship, computational context, provenance, validation status and dependencies. Capturing these components makes reproducibility, reusability and attribution across various platforms and accelerates scientific workflows.	My immediate use-case is integrating modular attribution into the AI research starter kit and NAIRR-enabled workflows so each research step such as data cleaning, modeling, evaluation, and interpretation, which becomes a citable, and reusable unit. This would allow me to support researchers with traceable, standards-aligned AI workflows and enable more transparent consulting, reproducibility reviews and cross-institution collaboration across HBCUs and TCUs.	Granular sharing and attribution would allow my collaboration to move from static, publication focused output to dynamic, real time research ecosystems. Modular attribution would enable researchers to reuse intermediate results, build on each other's workflows, accelerate proposal development and create transparent provenance chains. It would also strengthen multi-national AI research allowing us to co-develop interoperable components that plug into cloud platforms like NAIRR and ACCESS.	\N	\N	\N	\N	\N
\.


--
-- Data for Name: blog_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blog_posts (id, title, content, author_id, published, featured, slug, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: breakout_rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.breakout_rooms (id, name, description, drive_folder_url, whiteboard_url, max_participants, active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, user_id, content, target_type, target_id, parent_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: daily_reflections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.daily_reflections (id, user_id, workshop_day, reflection_type, content, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: invite_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invite_tokens (id, email, token, application_id, used, used_at, created_at, expires_at) FROM stdin;
2455d723-0a04-4537-adea-a1feb4632397	frida.arreytakubetang@gmail.com	02340f4f-c2de-437f-a771-da28ae619c48	164f9842-9aa7-46a6-9ae6-0375328e4845	t	2026-02-10 07:34:57.033872+00	2026-02-06 22:54:29.473748+00	2026-02-13 22:54:29.298+00
dd3cd677-932f-49ef-9d58-00f93e802257	monica@creativecommons.org	f47cce99-e231-4e20-afcc-d88626116617	f20eaf9f-af0f-48a3-85e9-39c867832e3b	t	2026-02-10 20:07:16.774875+00	2026-02-06 22:54:37.409079+00	2026-02-13 22:54:37.243+00
0f156285-845f-4a4f-a2c1-6cbd2881c44c	nokome@stencila.io	363d8086-607b-4162-8d6c-9e5e30b815a8	d4cfa576-d8e8-4770-9d74-32c9a648b107	t	2026-02-06 22:40:40.44518+00	2026-02-06 22:38:50.508579+00	2026-02-13 22:38:50.459+00
d2360ad6-0a74-4ef1-85d4-f3a1e8e8932c	wesley@cosmik.network	1a359365-5a1f-4f92-ba51-06d847de2ff3	b1446c78-4c49-404b-909d-ce8beeb5a994	t	2026-02-07 00:35:58.549837+00	2026-02-06 22:54:45.45983+00	2026-02-13 22:54:45.252+00
0f4e5ecc-4ca9-46c3-81c6-2ee3a3f13c95	a.campbell@digital-science.com	a45a4e69-aa44-4160-be07-267449dd5401	4da0807b-f867-419c-95cf-a7936de2ca0c	t	2026-02-07 00:51:07.528022+00	2026-02-06 22:54:19.92038+00	2026-02-13 22:54:19.51+00
83e9e675-572c-45a9-aca0-36b4cd5252c9	ellie.rennie@rmit.edu.au	11f8c84a-8d84-4341-9e81-5e6fe924d7da	109d1ee4-fe2b-46be-a4fc-bf043b0dc4a5	t	2026-02-08 20:20:58.669034+00	2026-02-06 22:54:27.395802+00	2026-02-13 22:54:27.259+00
3a7d3bf8-f0a2-4650-95d6-332f328a5197	m@jmartink.org	4fbc4aad-1b61-4d45-87ce-d51b22b6305f	e90799e1-1c1e-4cb8-8ff7-54b6289200c6	t	2026-02-09 08:36:17.13627+00	2026-02-06 22:54:35.395871+00	2026-02-13 22:54:35.237+00
fee2409a-c3a3-4a62-b1fb-567fd4cbec46	teal@openrxiv.org	62b1124c-f4e5-47ce-97fd-abf23ffc0cb0	96c84e72-5f0e-4a2d-9bd5-b4e24fe95d60	f	\N	2026-02-09 11:57:19.103414+00	2026-02-16 11:57:18.99+00
5f4b8252-2c18-4725-a590-5682a32e968a	shaobsh@gmail.com	ad8bf229-a690-4972-aa00-568bdfb509ab	ec38e5d5-6e2d-4399-bf30-a8174c111954	t	2026-02-09 13:47:00.195824+00	2026-02-09 11:57:15.157547+00	2026-02-16 11:57:14.96+00
8f272cbf-d25c-49ce-82dd-7085a91393b1	ronen@cosmik.network	a0b7b3da-0102-491a-83e0-e2ab090fb725	82df79b3-c926-499e-924a-cc3dc5a8695b	t	2026-02-09 16:17:24.402937+00	2026-02-06 22:54:42.449643+00	2026-02-13 22:54:42.272+00
229e64e3-7ef8-4f71-b487-e3a1b4a42a3d	luke@block.science	bd7610d3-93bf-4b0f-9fe5-4b9aa49e0ebd	fe8aec23-f059-4cc2-83b7-7e570d7e14b4	t	2026-02-09 18:33:58.833969+00	2026-02-06 22:54:33.359812+00	2026-02-13 22:54:33.034+00
b6dfab47-7f72-4308-81e4-7f484ba31f39	rodrigo.miguelesramirez@mail.mcgill.ca	836cb909-7d91-432f-8e2e-82b89fcd5d67	973536bb-1e83-48e9-951e-3855aaaa384d	t	2026-02-10 03:30:13.610467+00	2026-02-06 22:38:50.453987+00	2026-02-13 22:38:50.322+00
a3118baa-3d05-42e1-a008-4efa5e10ac98	sekhar.ramakrishnan@astera.org	6b17094d-5189-4bcb-9d33-25b393c0e1b2	0861ae21-35e2-43c9-8d32-43d3a4331898	t	2026-02-11 09:42:37.745657+00	2026-02-06 22:54:22.502538+00	2026-02-13 22:54:22.315+00
bfebaa40-b340-45e1-b44f-3dd89f1c8212	morgan@quantumbiology.org	3617c7db-6e83-48d9-ae74-8f0d3d466538	04b17351-a69c-4b62-b514-082533d470fc	t	2026-02-12 00:26:28.807711+00	2026-02-06 22:54:39.41038+00	2026-02-13 22:54:39.263+00
2253bf63-f3ee-418b-b501-2bebbfdfb736	antonmolina@bnext.bio	4006fce5-28ed-4bba-a3f7-7b30a256b5e5	299dc155-be75-4e0b-a02e-bda8f25ae814	t	2026-02-12 04:11:24.747313+00	2026-02-09 11:57:11.065046+00	2026-02-16 11:57:10.593+00
298a6528-5865-4e95-b1bf-fa56f11e95f5	maparent@conversence.com	af630512-58cf-4cd7-a18f-8968d0414fda	8a3e0b92-8112-4c78-8798-3d0f2f6a0086	f	\N	2026-02-06 23:00:07.295957+00	2026-02-17 23:00:06.908+00
51671cb7-1ef9-460e-9e70-f1766d6cd3d8	Ellie@scios.tech	6fc46421-e5a5-4d9c-b815-0fd96f95d121	831f70ed-ca0f-4055-9f3f-0ff5dba402dc	f	\N	2026-02-06 22:54:25.412264+00	2026-02-17 22:54:25.267+00
793cdb6e-b4a6-4c53-9f25-e0bb91a870ab	akamatsm@uw.edu	919a13f9-dc2e-4bc6-b704-659901384ad4	28cc3c9c-ca86-4301-83ca-3a27788a3b9c	f	\N	2026-02-06 22:38:50.464869+00	2026-02-17 22:38:50.395+00
cc73a254-542b-4651-a92f-81f18a6a2628	akamatsm@uw.edu	73e03b8d-6b77-4609-b385-5ab36457d4da	28cc3c9c-ca86-4301-83ca-3a27788a3b9c	f	\N	2026-02-06 15:21:16.362711+00	2026-02-17 15:21:16.317+00
e62e1cec-e15d-4ced-be4f-6cfa9e3c1f84	joelchan@umd.edu	8cf4da3d-0a1d-4e89-8330-e0b21514cc92	688dc81f-43bc-4736-b485-209aeaa97697	f	\N	2026-02-06 23:00:04.952039+00	2026-02-17 23:00:04.601+00
d09c0154-3d44-4f5a-99bc-acaec8dd6c03	sean.moore3@mail.mcgill.ca	039843ca-f85e-4b1c-9ce3-cac155f4ccbb	48905c53-784d-4945-be58-4e3982ada28d	t	2026-02-13 23:52:06.727368+00	2026-02-09 11:57:17.136619+00	2026-02-16 11:57:16.978+00
a8a12603-e940-4eb2-a9c6-37a0f9f5c834	hyunokate.lee@utoronto.ca	bfedf322-a7b8-44e0-a672-71e9986aeef3	c416ce9b-80b5-4c63-9d83-d617237707cc	t	2026-02-14 02:37:12.01376+00	2026-02-09 11:57:13.127163+00	2026-02-16 11:57:12.976+00
\.


--
-- Data for Name: photo_gallery; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photo_gallery (id, user_id, image_url, caption, room_id, tags, workshop_day, created_at) FROM stdin;
\.


--
-- Data for Name: room_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room_participants (id, room_id, user_id, joined_at) FROM stdin;
\.


--
-- Data for Name: schema_iterations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_iterations (id, version, title, description, schema_data, created_by, created_at, is_current) FROM stdin;
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, title, description, assignee_id, status, priority, due_date, created_at, created_by, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, name, organization, profile_image_url, created_at, last_login, updated_at) FROM stdin;
cdd7c3e5-6e9e-4974-8f69-63e8608d19a9	jon@scios.tech	Jonathan Starr	\N	\N	2025-09-23 23:01:42.883646+00	\N	2025-09-23 23:01:42.883646+00
562212e3-819d-4d8f-b03b-57a8c9427f72	ellie@scios.tech	Ellie DeSota	\N	\N	2025-09-24 12:17:30.943584+00	\N	2025-09-24 12:17:30.943584+00
04807d9a-3e96-4a9e-a55d-b6e4ed75b50c	akamatsm@uw.edu	Matt Akamatsu	\N	\N	2025-09-25 20:38:49.497512+00	\N	2025-09-25 20:38:49.497512+00
b8231bc8-cf4d-440c-a8cf-0b0a4fcdda4c	joelchan@umd.edu	Joel Chan	\N	\N	2026-01-26 18:54:39.710493+00	\N	2026-01-26 19:14:30.326315+00
f58c6eb0-ad49-43b6-998b-c5deeac7bf59	maparent@conversence.com	Marc-Antoine Parent	\N	\N	2026-01-26 18:56:11.144273+00	\N	2026-01-26 19:14:30.326315+00
66586d4d-ad06-48ca-b937-c2bbde17f36a	ronen@cosmik.network	Ronen Tamari	\N	\N	2026-01-26 18:57:01.808614+00	\N	2026-01-26 19:14:30.326315+00
629bfa5c-5449-4583-8358-08335293caba	nokome@stencila.io	Nokome Bentley	\N	\N	2026-02-06 22:40:41.391108+00	\N	2026-02-06 22:40:41.391108+00
2333c58f-094b-4dbb-9d56-347d134feda7	wesley@cosmik.network	Wesley Finck	\N	\N	2026-02-07 00:35:58.982612+00	\N	2026-02-07 00:35:58.982612+00
6f6fa59c-20ad-41b9-9f63-421dee593357	a.campbell@digital-science.com	Ann Campbell	\N	\N	2026-02-07 00:51:07.968257+00	\N	2026-02-07 00:51:07.968257+00
0d886fc7-1b47-4870-bcb2-eff7cbed5950	ellie.rennie@rmit.edu.au	Ellie Rennie	\N	\N	2026-02-08 20:20:59.362776+00	\N	2026-02-08 20:20:59.362776+00
6a20c1a0-ee08-4708-84a7-2c7ad61b3041	m@jmartink.org	Martin Karlsson	\N	\N	2026-02-09 08:36:17.618236+00	\N	2026-02-09 08:36:17.618236+00
a07197c2-3744-40a0-b6d8-252769eae979	shaobsh@gmail.com	Saif Haobsh	\N	\N	2026-02-09 13:47:00.587431+00	\N	2026-02-09 13:47:00.587431+00
0c1a8cff-b719-4e94-966d-22e8fce601ed	luke@block.science	Luke Miller	\N	\N	2026-02-09 18:33:59.2517+00	\N	2026-02-09 18:33:59.2517+00
03583b49-b454-4903-9ec9-180a20a40946	rodrigo.miguelesramirez@mail.mcgill.ca	Rodrigo Migueles Ramirez	\N	\N	2026-02-10 03:30:14.02449+00	\N	2026-02-10 03:30:14.02449+00
5bda8e48-63ad-424b-ba4c-b6dc8d90d467	frida.arreytakubetang@gmail.com	Frida Arrey Takubetang	\N	\N	2026-02-10 07:34:57.692838+00	\N	2026-02-10 07:34:57.692838+00
96f9bcb8-0ef8-465a-90d1-dc056c1f9554	monica@creativecommons.org	Monica Granados	\N	\N	2026-02-10 20:07:17.217838+00	\N	2026-02-10 20:07:17.217838+00
7de965d1-329b-4ee3-8814-7cfbb8291325	sekhar.ramakrishnan@astera.org	Chandrasekhar Ramakrishnan	\N	\N	2026-02-11 09:42:38.248163+00	\N	2026-02-11 09:42:38.248163+00
6f1ae888-314a-46df-9c74-05456d4c517d	morgan@quantumbiology.org	Morgan Sosa	\N	\N	2026-02-12 00:26:29.281907+00	\N	2026-02-12 00:26:29.281907+00
e798443f-c72a-40aa-b351-84d285cb8dfc	antonmolina@bnext.bio	Anton Molina	\N	\N	2026-02-12 04:11:25.474341+00	\N	2026-02-12 04:11:25.474341+00
10569c05-bf71-4e59-ac71-cdb731877e55	sean.moore3@mail.mcgill.ca	Sean Moore	\N	\N	2026-02-13 23:52:07.247778+00	\N	2026-02-13 23:52:07.247778+00
9744a793-abb5-43a7-a8d6-2ed6b59c2ef9	hyunokate.lee@utoronto.ca	Kate Lee	\N	\N	2026-02-14 02:37:11.569549+00	\N	2026-02-14 02:37:11.569549+00
\.


--
-- Data for Name: voting_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.voting_config (id, min_votes_required, approval_threshold, auto_approve_enabled, auto_reject_enabled, rejection_threshold, created_at, updated_at) FROM stdin;
2a309f58-0977-4c3b-9e57-586b774631c1	3	0.66	t	t	0.66	2025-09-23 22:56:09.623828+00	2026-01-24 01:44:44.710406+00
\.


--
-- Data for Name: messages_2026_02_02; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_02_02 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_02_03; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_02_03 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_02_04; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_02_04 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_02_05; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_02_05 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_02_06; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_02_06 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_02_07; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_02_07 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_02_08; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_02_08 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_02_11; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_02_11 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_02_12; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_02_12 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_02_13; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_02_13 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_02_14; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_02_14 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_02_15; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_02_15 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-09-22 19:58:16
20211116045059	2025-09-22 19:58:19
20211116050929	2025-09-22 19:58:21
20211116051442	2025-09-22 19:58:23
20211116212300	2025-09-22 19:58:26
20211116213355	2025-09-22 19:58:28
20211116213934	2025-09-22 19:58:30
20211116214523	2025-09-22 19:58:32
20211122062447	2025-09-22 19:58:34
20211124070109	2025-09-22 19:58:36
20211202204204	2025-09-22 19:58:38
20211202204605	2025-09-22 19:58:40
20211210212804	2025-09-22 19:58:47
20211228014915	2025-09-22 19:58:49
20220107221237	2025-09-22 19:58:51
20220228202821	2025-09-22 19:58:53
20220312004840	2025-09-22 19:58:55
20220603231003	2025-09-22 19:58:58
20220603232444	2025-09-22 19:59:00
20220615214548	2025-09-22 19:59:03
20220712093339	2025-09-22 19:59:05
20220908172859	2025-09-22 19:59:07
20220916233421	2025-09-22 19:59:09
20230119133233	2025-09-22 19:59:11
20230128025114	2025-09-22 19:59:13
20230128025212	2025-09-22 19:59:15
20230227211149	2025-09-22 19:59:17
20230228184745	2025-09-22 19:59:19
20230308225145	2025-09-22 19:59:21
20230328144023	2025-09-22 19:59:23
20231018144023	2025-09-22 19:59:26
20231204144023	2025-09-22 19:59:29
20231204144024	2025-09-22 19:59:31
20231204144025	2025-09-22 19:59:33
20240108234812	2025-09-22 19:59:35
20240109165339	2025-09-22 19:59:37
20240227174441	2025-09-22 19:59:41
20240311171622	2025-09-22 19:59:43
20240321100241	2025-09-22 19:59:48
20240401105812	2025-09-22 19:59:53
20240418121054	2025-09-22 19:59:56
20240523004032	2025-09-22 20:00:03
20240618124746	2025-09-22 20:00:05
20240801235015	2025-09-22 20:00:07
20240805133720	2025-09-22 20:00:09
20240827160934	2025-09-22 20:00:11
20240919163303	2025-09-22 20:00:14
20240919163305	2025-09-22 20:00:16
20241019105805	2025-09-22 20:00:18
20241030150047	2025-09-22 20:00:26
20241108114728	2025-09-22 20:00:29
20241121104152	2025-09-22 20:00:31
20241130184212	2025-09-22 20:00:33
20241220035512	2025-09-22 20:00:35
20241220123912	2025-09-22 20:00:37
20241224161212	2025-09-22 20:00:39
20250107150512	2025-09-22 20:00:41
20250110162412	2025-09-22 20:00:43
20250123174212	2025-09-22 20:00:45
20250128220012	2025-09-22 20:00:47
20250506224012	2025-09-22 20:00:49
20250523164012	2025-09-22 20:00:51
20250714121412	2025-09-22 20:00:53
20250905041441	2025-09-24 11:56:04
20251103001201	2025-11-17 17:26:45
20251120212548	2026-02-04 20:02:53
20251120215549	2026-02-04 20:02:53
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-09-22 19:58:12.758523
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-09-22 19:58:12.764474
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-09-22 19:58:12.796925
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-09-22 19:58:12.862246
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-09-22 19:58:12.865961
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-09-22 19:58:12.874571
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-09-22 19:58:12.8812
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-09-22 19:58:12.894464
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-09-22 19:58:12.90343
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-09-22 19:58:12.907067
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-09-22 19:58:12.910636
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-09-22 19:58:12.938538
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-09-22 19:58:12.943566
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-09-22 19:58:12.947254
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-09-22 19:58:12.951292
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-09-22 19:58:12.961951
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-09-22 19:58:12.96662
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-09-22 19:58:12.973821
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-09-22 19:58:12.995526
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-09-22 19:58:13.00769
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-09-22 19:58:13.011189
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-09-22 19:58:13.01483
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-10-15 08:17:15.494213
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2025-11-17 17:26:46.9623
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2025-11-17 17:26:46.976109
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2025-11-17 17:26:47.077644
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2025-11-17 17:26:47.082957
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-01-09 12:19:40.81358
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2025-09-22 19:58:12.76787
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2025-09-22 19:58:12.871269
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2025-09-22 19:58:12.884823
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2025-09-22 19:58:12.889764
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2025-10-15 08:17:15.297411
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2025-10-15 08:17:15.420513
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2025-10-15 08:17:15.429638
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2025-10-15 08:17:15.440972
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2025-10-15 08:17:15.44991
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2025-10-15 08:17:15.457056
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2025-10-15 08:17:15.463414
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2025-10-15 08:17:15.472274
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2025-10-15 08:17:15.473766
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2025-10-15 08:17:15.479925
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2025-10-15 08:17:15.482441
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2025-10-15 08:17:15.498092
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2025-10-15 08:17:15.523957
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2025-10-15 08:17:15.528839
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2025-10-15 08:17:15.540614
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2025-10-15 08:17:15.544737
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2025-10-15 08:17:15.549633
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2025-11-17 17:26:47.086058
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-02-13 23:15:13.702833
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-02-13 23:15:13.749886
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-02-13 23:15:13.751044
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-02-13 23:15:13.919913
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-02-13 23:15:13.921888
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-02-13 23:15:13.923027
56	fix-optimized-search-function	cb58526ebc23048049fd5bf2fd148d18b04a2073	2026-02-13 23:15:13.934665
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version, statements, name) FROM stdin;
001	{"-- Enable necessary extensions (Supabase already has uuid extension enabled)\n\n-- Create custom types\nCREATE TYPE application_status AS ENUM ('pending', 'accepted', 'rejected', 'waitlisted')","CREATE TYPE task_status AS ENUM ('pending', 'in_progress', 'completed')","CREATE TYPE task_priority AS ENUM ('low', 'medium', 'high')","CREATE TYPE reflection_type AS ENUM ('personal', 'group', 'prototype')","-- Create users profile table (extends Supabase auth.users)\n-- Role is stored in auth.users.raw_app_meta_data.role\nCREATE TABLE public.users (\n  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,\n  email TEXT UNIQUE NOT NULL,\n  name TEXT NOT NULL,\n  organization TEXT,\n  profile_image_url TEXT,\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  last_login TIMESTAMPTZ,\n  updated_at TIMESTAMPTZ DEFAULT NOW()\n)","-- Create applications table\nCREATE TABLE public.applications (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,\n  status application_status NOT NULL DEFAULT 'pending',\n  role TEXT NOT NULL,\n  reason_for_applying TEXT NOT NULL,\n  requirements_for_protocol TEXT,\n  relevant_experience TEXT,\n  admin_notes TEXT[],\n  submitted_at TIMESTAMPTZ DEFAULT NOW(),\n  reviewed_at TIMESTAMPTZ,\n  reviewed_by UUID REFERENCES public.users(id),\n  updated_at TIMESTAMPTZ DEFAULT NOW()\n)","-- Create blog_posts table\nCREATE TABLE public.blog_posts (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  title TEXT NOT NULL,\n  content TEXT NOT NULL,\n  author_id UUID NOT NULL REFERENCES public.users(id),\n  published BOOLEAN DEFAULT FALSE,\n  featured BOOLEAN DEFAULT FALSE,\n  slug TEXT UNIQUE NOT NULL,\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  updated_at TIMESTAMPTZ DEFAULT NOW()\n)","-- Create tasks table\nCREATE TABLE public.tasks (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  title TEXT NOT NULL,\n  description TEXT,\n  assignee_id UUID REFERENCES public.users(id),\n  status task_status NOT NULL DEFAULT 'pending',\n  priority task_priority DEFAULT 'medium',\n  due_date DATE,\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  created_by UUID NOT NULL REFERENCES public.users(id),\n  updated_at TIMESTAMPTZ DEFAULT NOW()\n)","-- Create breakout_rooms table\nCREATE TABLE public.breakout_rooms (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  name TEXT NOT NULL,\n  description TEXT,\n  drive_folder_url TEXT,\n  whiteboard_url TEXT,\n  max_participants INTEGER DEFAULT 6,\n  active BOOLEAN DEFAULT TRUE,\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  updated_at TIMESTAMPTZ DEFAULT NOW()\n)","-- Create room_participants table\nCREATE TABLE public.room_participants (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  room_id UUID NOT NULL REFERENCES public.breakout_rooms(id) ON DELETE CASCADE,\n  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,\n  joined_at TIMESTAMPTZ DEFAULT NOW(),\n  UNIQUE(room_id, user_id)\n)","-- Create daily_reflections table\nCREATE TABLE public.daily_reflections (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,\n  workshop_day INTEGER NOT NULL CHECK (workshop_day BETWEEN 1 AND 4),\n  reflection_type reflection_type NOT NULL,\n  content JSONB NOT NULL,\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  updated_at TIMESTAMPTZ DEFAULT NOW(),\n  UNIQUE(user_id, workshop_day, reflection_type)\n)","-- Create photo_gallery table\nCREATE TABLE public.photo_gallery (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  user_id UUID NOT NULL REFERENCES public.users(id),\n  image_url TEXT NOT NULL,\n  caption TEXT,\n  room_id UUID REFERENCES public.breakout_rooms(id),\n  tags TEXT[],\n  workshop_day INTEGER CHECK (workshop_day BETWEEN 1 AND 4),\n  created_at TIMESTAMPTZ DEFAULT NOW()\n)","-- Create comments table\nCREATE TABLE public.comments (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  user_id UUID NOT NULL REFERENCES public.users(id),\n  content TEXT NOT NULL,\n  target_type TEXT NOT NULL CHECK (target_type IN ('photo', 'reflection', 'task', 'room')),\n  target_id UUID NOT NULL,\n  parent_id UUID REFERENCES public.comments(id),\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  updated_at TIMESTAMPTZ DEFAULT NOW()\n)","-- Create schema_iterations table\nCREATE TABLE public.schema_iterations (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  version TEXT NOT NULL,\n  title TEXT NOT NULL,\n  description TEXT,\n  schema_data JSONB NOT NULL,\n  created_by UUID NOT NULL REFERENCES public.users(id),\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  is_current BOOLEAN DEFAULT FALSE\n)","-- Create performance indexes for RLS policies\nCREATE INDEX idx_applications_user_id ON public.applications(user_id)","CREATE INDEX idx_applications_status ON public.applications(status)","CREATE INDEX idx_blog_posts_author_id ON public.blog_posts(author_id)","CREATE INDEX idx_blog_posts_published ON public.blog_posts(published)","CREATE INDEX idx_blog_posts_slug ON public.blog_posts(slug)","CREATE INDEX idx_tasks_assignee_id ON public.tasks(assignee_id)","CREATE INDEX idx_tasks_created_by ON public.tasks(created_by)","CREATE INDEX idx_room_participants_user_room ON public.room_participants(user_id, room_id)","CREATE INDEX idx_daily_reflections_user_id ON public.daily_reflections(user_id)","CREATE INDEX idx_photo_gallery_user_id ON public.photo_gallery(user_id)","CREATE INDEX idx_comments_user_id ON public.comments(user_id)","CREATE INDEX idx_comments_target ON public.comments(target_type, target_id)","-- Create updated_at trigger function\nCREATE OR REPLACE FUNCTION update_updated_at_column()\nRETURNS TRIGGER AS $$\nBEGIN\n  NEW.updated_at = NOW();\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql","-- Apply updated_at triggers\nCREATE TRIGGER update_users_updated_at BEFORE UPDATE ON public.users\n  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column()","CREATE TRIGGER update_applications_updated_at BEFORE UPDATE ON public.applications\n  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column()","CREATE TRIGGER update_blog_posts_updated_at BEFORE UPDATE ON public.blog_posts\n  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column()","CREATE TRIGGER update_tasks_updated_at BEFORE UPDATE ON public.tasks\n  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column()","CREATE TRIGGER update_breakout_rooms_updated_at BEFORE UPDATE ON public.breakout_rooms\n  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column()","CREATE TRIGGER update_daily_reflections_updated_at BEFORE UPDATE ON public.daily_reflections\n  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column()","CREATE TRIGGER update_comments_updated_at BEFORE UPDATE ON public.comments\n  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column()","-- Create function to handle new user registration\nCREATE OR REPLACE FUNCTION public.handle_new_user()\nRETURNS TRIGGER AS $$\nBEGIN\n  -- Create user profile\n  INSERT INTO public.users (id, email, name)\n  VALUES (\n    NEW.id,\n    NEW.email,\n    COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1))\n  );\n\n  -- Set default role in app_metadata if not already set\n  IF NEW.raw_app_meta_data->>'role' IS NULL THEN\n    UPDATE auth.users\n    SET raw_app_meta_data =\n      COALESCE(raw_app_meta_data, '{}'::jsonb) ||\n      jsonb_build_object('role', 'applicant')\n    WHERE id = NEW.id;\n  END IF;\n\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql SECURITY DEFINER","-- Trigger to create user profile on signup\nCREATE TRIGGER on_auth_user_created\n  AFTER INSERT ON auth.users\n  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user()","-- Helper function to get user role from JWT\nCREATE OR REPLACE FUNCTION public.auth_role()\nRETURNS TEXT AS $$\n  SELECT COALESCE(\n    auth.jwt()->>'role',\n    (auth.jwt()->'app_metadata'->>'role'),\n    'applicant'\n  );\n$$ LANGUAGE sql STABLE","-- Helper function to check if current user is admin\nCREATE OR REPLACE FUNCTION public.is_admin()\nRETURNS BOOLEAN AS $$\n  SELECT public.auth_role() = 'admin';\n$$ LANGUAGE sql STABLE","-- Helper function to check if specific user is admin\nCREATE OR REPLACE FUNCTION public.is_user_admin(user_id UUID)\nRETURNS BOOLEAN AS $$\n  SELECT (\n    SELECT raw_app_meta_data->>'role'\n    FROM auth.users\n    WHERE id = user_id\n  ) = 'admin';\n$$ LANGUAGE sql STABLE SECURITY DEFINER"}	initial_schema
002	{"-- Enable RLS on all tables\nALTER TABLE public.users ENABLE ROW LEVEL SECURITY","ALTER TABLE public.applications ENABLE ROW LEVEL SECURITY","ALTER TABLE public.blog_posts ENABLE ROW LEVEL SECURITY","ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY","ALTER TABLE public.breakout_rooms ENABLE ROW LEVEL SECURITY","ALTER TABLE public.room_participants ENABLE ROW LEVEL SECURITY","ALTER TABLE public.daily_reflections ENABLE ROW LEVEL SECURITY","ALTER TABLE public.photo_gallery ENABLE ROW LEVEL SECURITY","ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY","ALTER TABLE public.schema_iterations ENABLE ROW LEVEL SECURITY","-- ==========================================\n-- USERS TABLE POLICIES\n-- ==========================================\n\n-- Users can view their own profile\nCREATE POLICY \\"Users can view own profile\\" ON public.users\n  FOR SELECT USING ((SELECT auth.uid()) = id)","-- Users can view all participants (for directory)\nCREATE POLICY \\"Users can view participants\\" ON public.users\n  FOR SELECT TO authenticated\n  USING (\n    id IN (\n      SELECT au.id FROM auth.users au\n      WHERE au.raw_app_meta_data->>'role' = 'participant'\n    )\n  )","-- Admins can view all users\nCREATE POLICY \\"Admins can view all users\\" ON public.users\n  FOR SELECT TO authenticated\n  USING (public.is_admin())","-- Users can update their own profile\nCREATE POLICY \\"Users can update own profile\\" ON public.users\n  FOR UPDATE USING ((SELECT auth.uid()) = id)\n  WITH CHECK ((SELECT auth.uid()) = id)","-- ==========================================\n-- APPLICATIONS TABLE POLICIES\n-- ==========================================\n\n-- Users can view their own applications\nCREATE POLICY \\"Users can view own applications\\" ON public.applications\n  FOR SELECT TO authenticated\n  USING (user_id = (SELECT auth.uid()))","-- Admins can view all applications\nCREATE POLICY \\"Admins can view all applications\\" ON public.applications\n  FOR SELECT TO authenticated\n  USING (public.is_admin())","-- Users can insert their own applications\nCREATE POLICY \\"Users can create applications\\" ON public.applications\n  FOR INSERT TO authenticated\n  WITH CHECK (user_id = (SELECT auth.uid()))","-- Users can update their own pending applications\nCREATE POLICY \\"Users can update own pending applications\\" ON public.applications\n  FOR UPDATE TO authenticated\n  USING (user_id = (SELECT auth.uid()) AND status = 'pending')\n  WITH CHECK (user_id = (SELECT auth.uid()))","-- Admins can update any application\nCREATE POLICY \\"Admins can update applications\\" ON public.applications\n  FOR UPDATE TO authenticated\n  USING (public.is_admin())\n  WITH CHECK (public.is_admin())","-- ==========================================\n-- BLOG POSTS TABLE POLICIES\n-- ==========================================\n\n-- Anyone can view published blog posts\nCREATE POLICY \\"Anyone can view published posts\\" ON public.blog_posts\n  FOR SELECT\n  USING (published = true)","-- Authors can view their own unpublished posts\nCREATE POLICY \\"Authors can view own posts\\" ON public.blog_posts\n  FOR SELECT TO authenticated\n  USING (author_id = (SELECT auth.uid()))","-- Admins can view all posts\nCREATE POLICY \\"Admins can view all posts\\" ON public.blog_posts\n  FOR SELECT TO authenticated\n  USING (public.is_admin())","-- Admins can create posts\nCREATE POLICY \\"Admins can create posts\\" ON public.blog_posts\n  FOR INSERT TO authenticated\n  WITH CHECK (public.is_admin())","-- Authors and admins can update posts\nCREATE POLICY \\"Authors and admins can update posts\\" ON public.blog_posts\n  FOR UPDATE TO authenticated\n  USING (author_id = (SELECT auth.uid()) OR public.is_admin())\n  WITH CHECK (author_id = (SELECT auth.uid()) OR public.is_admin())","-- ==========================================\n-- TASKS TABLE POLICIES\n-- ==========================================\n\n-- Users can view tasks assigned to them\nCREATE POLICY \\"Users can view assigned tasks\\" ON public.tasks\n  FOR SELECT TO authenticated\n  USING (assignee_id = (SELECT auth.uid()) OR created_by = (SELECT auth.uid()))","-- Admins can view all tasks\nCREATE POLICY \\"Admins can view all tasks\\" ON public.tasks\n  FOR SELECT TO authenticated\n  USING (public.is_admin())","-- Admins can create tasks\nCREATE POLICY \\"Admins can create tasks\\" ON public.tasks\n  FOR INSERT TO authenticated\n  WITH CHECK (public.is_admin())","-- Admins and assignees can update tasks\nCREATE POLICY \\"Admins and assignees can update tasks\\" ON public.tasks\n  FOR UPDATE TO authenticated\n  USING (assignee_id = (SELECT auth.uid()) OR public.is_admin())\n  WITH CHECK (assignee_id = (SELECT auth.uid()) OR public.is_admin())","-- ==========================================\n-- BREAKOUT ROOMS TABLE POLICIES\n-- ==========================================\n\n-- Participants can view active breakout rooms they're assigned to\nCREATE POLICY \\"Participants can view assigned rooms\\" ON public.breakout_rooms\n  FOR SELECT TO authenticated\n  USING (\n    active = true AND (\n      id IN (\n        SELECT room_id FROM public.room_participants\n        WHERE user_id = (SELECT auth.uid())\n      ) OR\n      public.is_admin()\n    )\n  )","-- Admins can manage all rooms\nCREATE POLICY \\"Admins can manage rooms\\" ON public.breakout_rooms\n  FOR ALL TO authenticated\n  USING (public.is_admin())\n  WITH CHECK (public.is_admin())","-- ==========================================\n-- ROOM PARTICIPANTS TABLE POLICIES\n-- ==========================================\n\n-- Users can view participants in their rooms\nCREATE POLICY \\"Users can view room participants\\" ON public.room_participants\n  FOR SELECT TO authenticated\n  USING (\n    room_id IN (\n      SELECT room_id FROM public.room_participants\n      WHERE user_id = (SELECT auth.uid())\n    ) OR\n    public.is_admin()\n  )","-- Admins can manage room participants\nCREATE POLICY \\"Admins can manage room participants\\" ON public.room_participants\n  FOR ALL TO authenticated\n  USING (public.is_admin())\n  WITH CHECK (public.is_admin())","-- ==========================================\n-- DAILY REFLECTIONS TABLE POLICIES\n-- ==========================================\n\n-- Users can view their own reflections\nCREATE POLICY \\"Users can view own reflections\\" ON public.daily_reflections\n  FOR SELECT TO authenticated\n  USING (user_id = (SELECT auth.uid()))","-- Participants can view shared reflections\nCREATE POLICY \\"Participants can view shared reflections\\" ON public.daily_reflections\n  FOR SELECT TO authenticated\n  USING (\n    public.auth_role() IN ('participant', 'admin')\n  )","-- Users can create their own reflections (if participant or admin)\nCREATE POLICY \\"Users can create own reflections\\" ON public.daily_reflections\n  FOR INSERT TO authenticated\n  WITH CHECK (\n    user_id = (SELECT auth.uid()) AND\n    public.auth_role() IN ('participant', 'admin')\n  )","-- Users can update their own reflections\nCREATE POLICY \\"Users can update own reflections\\" ON public.daily_reflections\n  FOR UPDATE TO authenticated\n  USING (user_id = (SELECT auth.uid()))\n  WITH CHECK (user_id = (SELECT auth.uid()))","-- ==========================================\n-- PHOTO GALLERY TABLE POLICIES\n-- ==========================================\n\n-- Participants can view all photos\nCREATE POLICY \\"Participants can view photos\\" ON public.photo_gallery\n  FOR SELECT TO authenticated\n  USING (\n    public.auth_role() IN ('participant', 'admin')\n  )","-- Users can upload their own photos (if participant or admin)\nCREATE POLICY \\"Users can upload photos\\" ON public.photo_gallery\n  FOR INSERT TO authenticated\n  WITH CHECK (\n    user_id = (SELECT auth.uid()) AND\n    public.auth_role() IN ('participant', 'admin')\n  )","-- Users can update their own photos\nCREATE POLICY \\"Users can update own photos\\" ON public.photo_gallery\n  FOR UPDATE TO authenticated\n  USING (user_id = (SELECT auth.uid()))\n  WITH CHECK (user_id = (SELECT auth.uid()))","-- Users can delete their own photos (or admins can delete any)\nCREATE POLICY \\"Users can delete own photos\\" ON public.photo_gallery\n  FOR DELETE TO authenticated\n  USING (user_id = (SELECT auth.uid()) OR public.is_admin())","-- ==========================================\n-- COMMENTS TABLE POLICIES\n-- ==========================================\n\n-- Authenticated users can view comments\nCREATE POLICY \\"Authenticated can view comments\\" ON public.comments\n  FOR SELECT TO authenticated\n  USING (true)","-- Authenticated users can create comments\nCREATE POLICY \\"Authenticated can create comments\\" ON public.comments\n  FOR INSERT TO authenticated\n  WITH CHECK (user_id = (SELECT auth.uid()))","-- Users can update their own comments\nCREATE POLICY \\"Users can update own comments\\" ON public.comments\n  FOR UPDATE TO authenticated\n  USING (user_id = (SELECT auth.uid()))\n  WITH CHECK (user_id = (SELECT auth.uid()))","-- Users can delete their own comments (admins can delete any)\nCREATE POLICY \\"Users can delete own comments\\" ON public.comments\n  FOR DELETE TO authenticated\n  USING (user_id = (SELECT auth.uid()) OR public.is_admin())","-- ==========================================\n-- SCHEMA ITERATIONS TABLE POLICIES\n-- ==========================================\n\n-- Participants can view schema iterations\nCREATE POLICY \\"Participants can view schemas\\" ON public.schema_iterations\n  FOR SELECT TO authenticated\n  USING (\n    public.auth_role() IN ('participant', 'admin')\n  )","-- Participants can create schema iterations\nCREATE POLICY \\"Participants can create schemas\\" ON public.schema_iterations\n  FOR INSERT TO authenticated\n  WITH CHECK (\n    created_by = (SELECT auth.uid()) AND\n    public.auth_role() IN ('participant', 'admin')\n  )","-- Creators and admins can update schemas\nCREATE POLICY \\"Creators and admins can update schemas\\" ON public.schema_iterations\n  FOR UPDATE TO authenticated\n  USING (created_by = (SELECT auth.uid()) OR public.is_admin())\n  WITH CHECK (created_by = (SELECT auth.uid()) OR public.is_admin())","-- Grant necessary permissions\nGRANT USAGE ON SCHEMA public TO anon, authenticated","GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated","GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated","GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO anon, authenticated"}	rls_policies
003	{"-- Make a user an admin\n-- Replace 'jon@scios.tech' with your actual email\n\nUPDATE auth.users\nSET raw_app_meta_data =\n  COALESCE(raw_app_meta_data, '{}'::jsonb) ||\n  jsonb_build_object('role', 'admin')\nWHERE email = 'jon@scios.tech'","-- Note: After running this, the user needs to log out and log back in\n-- for the new role to take effect in their JWT token"}	make_admin
004	{"-- ==========================================\n-- Modify applications table for email-only submissions\n-- ==========================================\n\n-- Add email, name, organization columns to applications table\nALTER TABLE public.applications\nADD COLUMN IF NOT EXISTS email TEXT,\nADD COLUMN IF NOT EXISTS name TEXT,\nADD COLUMN IF NOT EXISTS organization TEXT","-- Make user_id nullable (allow applications without accounts)\nALTER TABLE public.applications\nALTER COLUMN user_id DROP NOT NULL","-- Add unique constraint on email to prevent duplicate applications\nALTER TABLE public.applications\nADD CONSTRAINT unique_application_email UNIQUE (email)","-- Create index on email for faster lookups\nCREATE INDEX IF NOT EXISTS idx_applications_email ON public.applications(email)","-- ==========================================\n-- Update RLS policies for public application submission\n-- ==========================================\n\n-- Drop existing application policies that we need to modify\nDROP POLICY IF EXISTS \\"Users can create applications\\" ON public.applications","DROP POLICY IF EXISTS \\"Users can view own applications\\" ON public.applications","DROP POLICY IF EXISTS \\"Users can update own pending applications\\" ON public.applications","-- Allow anyone to create applications (no auth required)\nCREATE POLICY \\"Anyone can create applications\\" ON public.applications\n  FOR INSERT\n  WITH CHECK (\n    -- Ensure email is provided\n    email IS NOT NULL AND\n    -- Either user_id is null (anonymous) or matches the authenticated user\n    (user_id IS NULL OR user_id = (SELECT auth.uid()))\n  )","-- Users can view applications by email OR user_id\nCREATE POLICY \\"Users can view own applications by email or user_id\\" ON public.applications\n  FOR SELECT\n  USING (\n    -- Admins can see all\n    public.is_admin() OR\n    -- Authenticated users can see their own by user_id\n    (user_id IS NOT NULL AND user_id = (SELECT auth.uid())) OR\n    -- Anyone can look up by email (for status checking)\n    -- Note: In production, you might want to add rate limiting here\n    email IS NOT NULL\n  )","-- Users can update their own pending applications\nCREATE POLICY \\"Users can update own pending applications by email or user_id\\" ON public.applications\n  FOR UPDATE\n  USING (\n    -- Must be pending status\n    status = 'pending' AND (\n      -- Authenticated users can update by user_id\n      (user_id IS NOT NULL AND user_id = (SELECT auth.uid())) OR\n      -- Admins can update any\n      public.is_admin()\n    )\n  )\n  WITH CHECK (\n    -- Same conditions for the update\n    status = 'pending' AND (\n      (user_id IS NOT NULL AND user_id = (SELECT auth.uid())) OR\n      public.is_admin()\n    )\n  )","-- ==========================================\n-- Helper function to link application to user account\n-- ==========================================\n\nCREATE OR REPLACE FUNCTION public.link_application_to_user(\n  p_email TEXT,\n  p_user_id UUID\n)\nRETURNS BOOLEAN\nLANGUAGE plpgsql\nSECURITY DEFINER\nAS $$\nBEGIN\n  -- Update the application to link it to the user\n  UPDATE public.applications\n  SET user_id = p_user_id,\n      updated_at = NOW()\n  WHERE email = p_email\n    AND user_id IS NULL;  -- Only link if not already linked\n\n  RETURN FOUND;\nEND;\n$$","-- Grant execute permission to authenticated users\nGRANT EXECUTE ON FUNCTION public.link_application_to_user TO authenticated","-- ==========================================\n-- Trigger to auto-link applications when user signs up\n-- ==========================================\n\nCREATE OR REPLACE FUNCTION public.auto_link_application_on_signup()\nRETURNS TRIGGER\nLANGUAGE plpgsql\nSECURITY DEFINER\nAS $$\nBEGIN\n  -- When a new user is created, check if they have an application\n  IF NEW.email IS NOT NULL THEN\n    -- Link any existing application to this user\n    UPDATE public.applications\n    SET user_id = NEW.id,\n        updated_at = NOW()\n    WHERE email = NEW.email\n      AND user_id IS NULL;\n  END IF;\n\n  RETURN NEW;\nEND;\n$$","-- Create trigger on users table\nDROP TRIGGER IF EXISTS auto_link_application ON public.users","CREATE TRIGGER auto_link_application\n  AFTER INSERT ON public.users\n  FOR EACH ROW\n  EXECUTE FUNCTION public.auto_link_application_on_signup()","-- ==========================================\n-- Update existing data (if any)\n-- ==========================================\n\n-- Populate email field for existing applications that have user_id\nUPDATE public.applications a\nSET email = u.email,\n    name = u.name,\n    organization = u.organization\nFROM public.users u\nWHERE a.user_id = u.id\n  AND a.email IS NULL"}	applications_email_only
005	{"-- ==========================================\n-- Multi-Admin Voting System\n-- ==========================================\n\n-- Create vote types enum\nCREATE TYPE vote_type AS ENUM ('approve', 'reject', 'abstain')","-- Create application_votes table\nCREATE TABLE public.application_votes (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  application_id UUID NOT NULL REFERENCES public.applications(id) ON DELETE CASCADE,\n  admin_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,\n  vote vote_type NOT NULL,\n  comment TEXT,\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  updated_at TIMESTAMPTZ DEFAULT NOW(),\n  UNIQUE(application_id, admin_id)\n)","-- Create indexes for performance\nCREATE INDEX idx_application_votes_application_id ON public.application_votes(application_id)","CREATE INDEX idx_application_votes_admin_id ON public.application_votes(admin_id)","CREATE INDEX idx_application_votes_vote ON public.application_votes(vote)","-- ==========================================\n-- Enhanced Comment System\n-- ==========================================\n\n-- Create application_comments table\nCREATE TABLE public.application_comments (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  application_id UUID NOT NULL REFERENCES public.applications(id) ON DELETE CASCADE,\n  author_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,\n  content TEXT NOT NULL,\n  parent_id UUID REFERENCES public.application_comments(id) ON DELETE CASCADE,\n  is_internal BOOLEAN DEFAULT true,\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  edited_at TIMESTAMPTZ,\n  deleted_at TIMESTAMPTZ, -- Soft delete for audit trail\n  CONSTRAINT valid_parent CHECK (parent_id != id)\n)","-- Create indexes for performance\nCREATE INDEX idx_application_comments_application_id ON public.application_comments(application_id)","CREATE INDEX idx_application_comments_author_id ON public.application_comments(author_id)","CREATE INDEX idx_application_comments_parent_id ON public.application_comments(parent_id)","CREATE INDEX idx_application_comments_created_at ON public.application_comments(created_at DESC)","-- ==========================================\n-- Voting Configuration Table\n-- ==========================================\n\nCREATE TABLE public.voting_config (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  min_votes_required INTEGER DEFAULT 3,\n  approval_threshold DECIMAL(3,2) DEFAULT 0.66, -- 66% approval needed\n  auto_approve_enabled BOOLEAN DEFAULT false,\n  auto_reject_enabled BOOLEAN DEFAULT false,\n  rejection_threshold DECIMAL(3,2) DEFAULT 0.66, -- 66% rejection needed\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  updated_at TIMESTAMPTZ DEFAULT NOW()\n)","-- Insert default configuration\nINSERT INTO public.voting_config (\n  min_votes_required,\n  approval_threshold,\n  auto_approve_enabled,\n  auto_reject_enabled,\n  rejection_threshold\n) VALUES (3, 0.66, false, false, 0.66)","-- ==========================================\n-- Add voting summary fields to applications\n-- ==========================================\n\nALTER TABLE public.applications\nADD COLUMN IF NOT EXISTS total_votes INTEGER DEFAULT 0,\nADD COLUMN IF NOT EXISTS approve_votes INTEGER DEFAULT 0,\nADD COLUMN IF NOT EXISTS reject_votes INTEGER DEFAULT 0,\nADD COLUMN IF NOT EXISTS abstain_votes INTEGER DEFAULT 0,\nADD COLUMN IF NOT EXISTS voting_completed BOOLEAN DEFAULT false,\nADD COLUMN IF NOT EXISTS voting_completed_at TIMESTAMPTZ","-- ==========================================\n-- Update triggers\n-- ==========================================\n\n-- Trigger for updated_at on votes\nCREATE TRIGGER update_application_votes_updated_at\n  BEFORE UPDATE ON public.application_votes\n  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column()","-- Trigger for updated_at on comments\nCREATE TRIGGER update_application_comments_updated_at\n  BEFORE UPDATE ON public.application_comments\n  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column()","-- Trigger for updated_at on voting_config\nCREATE TRIGGER update_voting_config_updated_at\n  BEFORE UPDATE ON public.voting_config\n  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column()","-- ==========================================\n-- Function to update vote counts\n-- ==========================================\n\nCREATE OR REPLACE FUNCTION public.update_application_vote_counts()\nRETURNS TRIGGER AS $$\nBEGIN\n  -- Update vote counts on the applications table\n  UPDATE public.applications\n  SET\n    total_votes = (\n      SELECT COUNT(*)\n      FROM public.application_votes\n      WHERE application_id = COALESCE(NEW.application_id, OLD.application_id)\n    ),\n    approve_votes = (\n      SELECT COUNT(*)\n      FROM public.application_votes\n      WHERE application_id = COALESCE(NEW.application_id, OLD.application_id)\n        AND vote = 'approve'\n    ),\n    reject_votes = (\n      SELECT COUNT(*)\n      FROM public.application_votes\n      WHERE application_id = COALESCE(NEW.application_id, OLD.application_id)\n        AND vote = 'reject'\n    ),\n    abstain_votes = (\n      SELECT COUNT(*)\n      FROM public.application_votes\n      WHERE application_id = COALESCE(NEW.application_id, OLD.application_id)\n        AND vote = 'abstain'\n    )\n  WHERE id = COALESCE(NEW.application_id, OLD.application_id);\n\n  RETURN COALESCE(NEW, OLD);\nEND;\n$$ LANGUAGE plpgsql","-- Create triggers for vote count updates\nCREATE TRIGGER update_vote_counts_on_insert\n  AFTER INSERT ON public.application_votes\n  FOR EACH ROW EXECUTE FUNCTION public.update_application_vote_counts()","CREATE TRIGGER update_vote_counts_on_update\n  AFTER UPDATE ON public.application_votes\n  FOR EACH ROW EXECUTE FUNCTION public.update_application_vote_counts()","CREATE TRIGGER update_vote_counts_on_delete\n  AFTER DELETE ON public.application_votes\n  FOR EACH ROW EXECUTE FUNCTION public.update_application_vote_counts()","-- ==========================================\n-- Function to check and auto-process applications\n-- ==========================================\n\nCREATE OR REPLACE FUNCTION public.check_auto_application_status()\nRETURNS TRIGGER AS $$\nDECLARE\n  config RECORD;\n  approval_ratio DECIMAL(3,2);\n  rejection_ratio DECIMAL(3,2);\nBEGIN\n  -- Get voting configuration\n  SELECT * INTO config FROM public.voting_config LIMIT 1;\n\n  -- Check if we have enough votes\n  IF NEW.total_votes >= config.min_votes_required THEN\n    -- Calculate ratios\n    approval_ratio := CASE\n      WHEN NEW.total_votes > 0 THEN NEW.approve_votes::DECIMAL / NEW.total_votes\n      ELSE 0\n    END;\n\n    rejection_ratio := CASE\n      WHEN NEW.total_votes > 0 THEN NEW.reject_votes::DECIMAL / NEW.total_votes\n      ELSE 0\n    END;\n\n    -- Check for auto-approval\n    IF config.auto_approve_enabled AND approval_ratio >= config.approval_threshold THEN\n      NEW.status := 'accepted';\n      NEW.voting_completed := true;\n      NEW.voting_completed_at := NOW();\n    -- Check for auto-rejection\n    ELSIF config.auto_reject_enabled AND rejection_ratio >= config.rejection_threshold THEN\n      NEW.status := 'rejected';\n      NEW.voting_completed := true;\n      NEW.voting_completed_at := NOW();\n    END IF;\n  END IF;\n\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql","-- Create trigger for auto status updates\nCREATE TRIGGER check_auto_status\n  BEFORE UPDATE OF total_votes, approve_votes, reject_votes ON public.applications\n  FOR EACH ROW EXECUTE FUNCTION public.check_auto_application_status()","-- ==========================================\n-- RLS Policies for Votes\n-- ==========================================\n\n-- Enable RLS\nALTER TABLE public.application_votes ENABLE ROW LEVEL SECURITY","-- Admins can view all votes\nCREATE POLICY \\"Admins can view all votes\\" ON public.application_votes\n  FOR SELECT\n  USING (public.is_admin())","-- Admins can create votes\nCREATE POLICY \\"Admins can create votes\\" ON public.application_votes\n  FOR INSERT\n  WITH CHECK (\n    public.is_admin() AND\n    admin_id = (SELECT auth.uid())\n  )","-- Admins can update their own votes\nCREATE POLICY \\"Admins can update own votes\\" ON public.application_votes\n  FOR UPDATE\n  USING (\n    public.is_admin() AND\n    admin_id = (SELECT auth.uid())\n  )\n  WITH CHECK (\n    public.is_admin() AND\n    admin_id = (SELECT auth.uid())\n  )","-- Admins can delete their own votes\nCREATE POLICY \\"Admins can delete own votes\\" ON public.application_votes\n  FOR DELETE\n  USING (\n    public.is_admin() AND\n    admin_id = (SELECT auth.uid())\n  )","-- ==========================================\n-- RLS Policies for Comments\n-- ==========================================\n\n-- Enable RLS\nALTER TABLE public.application_comments ENABLE ROW LEVEL SECURITY","-- Admins can view all internal comments\nCREATE POLICY \\"Admins can view comments\\" ON public.application_comments\n  FOR SELECT\n  USING (\n    public.is_admin() OR\n    (NOT is_internal AND EXISTS (\n      SELECT 1 FROM public.applications\n      WHERE id = application_id\n      AND (user_id = (SELECT auth.uid()) OR email = (SELECT auth.jwt()->>'email'))\n    ))\n  )","-- Admins can create comments\nCREATE POLICY \\"Admins can create comments\\" ON public.application_comments\n  FOR INSERT\n  WITH CHECK (\n    public.is_admin() AND\n    author_id = (SELECT auth.uid())\n  )","-- Authors can update their own comments within 15 minutes\nCREATE POLICY \\"Authors can update own recent comments\\" ON public.application_comments\n  FOR UPDATE\n  USING (\n    author_id = (SELECT auth.uid()) AND\n    created_at > NOW() - INTERVAL '15 minutes' AND\n    deleted_at IS NULL\n  )\n  WITH CHECK (\n    author_id = (SELECT auth.uid()) AND\n    created_at > NOW() - INTERVAL '15 minutes' AND\n    deleted_at IS NULL\n  )","-- Authors can soft-delete their own comments\nCREATE POLICY \\"Authors can soft-delete own comments\\" ON public.application_comments\n  FOR UPDATE\n  USING (\n    author_id = (SELECT auth.uid()) AND\n    deleted_at IS NULL\n  )\n  WITH CHECK (\n    author_id = (SELECT auth.uid())\n  )","-- ==========================================\n-- RLS Policies for Voting Config (admin only)\n-- ==========================================\n\nALTER TABLE public.voting_config ENABLE ROW LEVEL SECURITY","CREATE POLICY \\"Admins can view voting config\\" ON public.voting_config\n  FOR SELECT\n  USING (public.is_admin())","CREATE POLICY \\"Admins can update voting config\\" ON public.voting_config\n  FOR UPDATE\n  USING (public.is_admin())\n  WITH CHECK (public.is_admin())","-- ==========================================\n-- Helper Views\n-- ==========================================\n\n-- View for application voting summary\nCREATE OR REPLACE VIEW public.application_voting_summary AS\nSELECT\n  a.id,\n  a.name,\n  a.email,\n  a.status,\n  a.total_votes,\n  a.approve_votes,\n  a.reject_votes,\n  a.abstain_votes,\n  a.voting_completed,\n  CASE\n    WHEN a.total_votes > 0 THEN ROUND((a.approve_votes::DECIMAL / a.total_votes) * 100, 1)\n    ELSE 0\n  END as approval_percentage,\n  CASE\n    WHEN a.total_votes > 0 THEN ROUND((a.reject_votes::DECIMAL / a.total_votes) * 100, 1)\n    ELSE 0\n  END as rejection_percentage,\n  COALESCE(\n    array_agg(\n      jsonb_build_object(\n        'admin_id', v.admin_id,\n        'admin_name', u.name,\n        'vote', v.vote,\n        'voted_at', v.created_at\n      ) ORDER BY v.created_at\n    ) FILTER (WHERE v.id IS NOT NULL),\n    ARRAY[]::jsonb[]\n  ) as votes\nFROM public.applications a\nLEFT JOIN public.application_votes v ON a.id = v.application_id\nLEFT JOIN public.users u ON v.admin_id = u.id\nGROUP BY\n  a.id, a.name, a.email, a.status, a.total_votes,\n  a.approve_votes, a.reject_votes, a.abstain_votes, a.voting_completed","-- Grant access to the view\nGRANT SELECT ON public.application_voting_summary TO authenticated","-- ==========================================\n-- Function to get comment threads\n-- ==========================================\n\nCREATE OR REPLACE FUNCTION public.get_application_comments(p_application_id UUID)\nRETURNS TABLE (\n  id UUID,\n  application_id UUID,\n  author_id UUID,\n  author_name TEXT,\n  content TEXT,\n  parent_id UUID,\n  is_internal BOOLEAN,\n  created_at TIMESTAMPTZ,\n  edited_at TIMESTAMPTZ,\n  deleted_at TIMESTAMPTZ,\n  depth INTEGER\n) AS $$\nWITH RECURSIVE comment_tree AS (\n  -- Base case: top-level comments\n  SELECT\n    c.id,\n    c.application_id,\n    c.author_id,\n    u.name as author_name,\n    c.content,\n    c.parent_id,\n    c.is_internal,\n    c.created_at,\n    c.edited_at,\n    c.deleted_at,\n    0 as depth\n  FROM public.application_comments c\n  JOIN public.users u ON c.author_id = u.id\n  WHERE c.application_id = p_application_id\n    AND c.parent_id IS NULL\n\n  UNION ALL\n\n  -- Recursive case: replies\n  SELECT\n    c.id,\n    c.application_id,\n    c.author_id,\n    u.name as author_name,\n    c.content,\n    c.parent_id,\n    c.is_internal,\n    c.created_at,\n    c.edited_at,\n    c.deleted_at,\n    ct.depth + 1\n  FROM public.application_comments c\n  JOIN public.users u ON c.author_id = u.id\n  JOIN comment_tree ct ON c.parent_id = ct.id\n  WHERE c.application_id = p_application_id\n)\nSELECT * FROM comment_tree\nORDER BY created_at, depth;\n$$ LANGUAGE sql STABLE","-- Grant execute permission\nGRANT EXECUTE ON FUNCTION public.get_application_comments TO authenticated"}	voting_and_comments
006	{"-- ==========================================\n-- RPC function to get all admin users\n-- ==========================================\n\nCREATE OR REPLACE FUNCTION public.get_admin_users()\nRETURNS TABLE (\n  id UUID,\n  name TEXT,\n  email TEXT,\n  profile_image_url TEXT,\n  created_at TIMESTAMPTZ\n)\nLANGUAGE plpgsql\nSECURITY DEFINER\nAS $$\nBEGIN\n  -- Only allow admins to call this function\n  IF NOT public.is_admin() THEN\n    RAISE EXCEPTION 'Access denied. Admin role required.';\n  END IF;\n\n  RETURN QUERY\n  SELECT\n    u.id,\n    u.name,\n    u.email,\n    u.profile_image_url,\n    u.created_at\n  FROM public.users u\n  JOIN auth.users au ON u.id = au.id\n  WHERE au.raw_app_meta_data->>'role' = 'admin'\n  ORDER BY u.name;\nEND;\n$$","-- Grant execute permission to authenticated users (RLS will handle access control)\nGRANT EXECUTE ON FUNCTION public.get_admin_users TO authenticated","-- ==========================================\n-- Function to get voting statistics\n-- ==========================================\n\nCREATE OR REPLACE FUNCTION public.get_voting_statistics()\nRETURNS TABLE (\n  total_applications INTEGER,\n  pending_votes INTEGER,\n  completed_votes INTEGER,\n  auto_approved INTEGER,\n  auto_rejected INTEGER,\n  average_votes_per_application NUMERIC\n)\nLANGUAGE plpgsql\nSECURITY DEFINER\nAS $$\nBEGIN\n  -- Only allow admins to call this function\n  IF NOT public.is_admin() THEN\n    RAISE EXCEPTION 'Access denied. Admin role required.';\n  END IF;\n\n  RETURN QUERY\n  SELECT\n    COUNT(*)::INTEGER as total_applications,\n    COUNT(*) FILTER (WHERE voting_completed = false)::INTEGER as pending_votes,\n    COUNT(*) FILTER (WHERE voting_completed = true)::INTEGER as completed_votes,\n    COUNT(*) FILTER (WHERE voting_completed = true AND status = 'accepted')::INTEGER as auto_approved,\n    COUNT(*) FILTER (WHERE voting_completed = true AND status = 'rejected')::INTEGER as auto_rejected,\n    ROUND(AVG(total_votes), 2) as average_votes_per_application\n  FROM public.applications;\nEND;\n$$","-- Grant execute permission\nGRANT EXECUTE ON FUNCTION public.get_voting_statistics TO authenticated"}	admin_functions
007	{"-- ==========================================\n-- Fix admin visibility of users for comments system\n-- ==========================================\n--\n-- Problem: When admins view application comments, the query joins with the users table\n-- to get author information (name, email, profile_image_url). The current RLS policies\n-- are too restrictive and don't allow admins to view other users' information.\n--\n-- Solution: Since only admins can view/create comments anyway, we need to ensure\n-- admins can view ALL users in the system (including other admins).\n-- ==========================================\n\n-- The existing policy \\"Admins can view all users\\" should already handle this,\n-- but let's make sure it exists and is correct\nDROP POLICY IF EXISTS \\"Admins can view all users\\" ON public.users","-- Admins should be able to view ALL users (including other admins)\n-- This is needed for the comments system where we join application_comments with users\nCREATE POLICY \\"Admins can view all users\\" ON public.users\n  FOR SELECT\n  TO authenticated\n  USING (public.is_admin())","-- Also ensure the application_comments policies are correctly set for admin-only access\n-- (These should already exist from migration 005, but let's ensure they're correct)\n\n-- Verify that only admins can view comments\nDROP POLICY IF EXISTS \\"Admins can view comments\\" ON public.application_comments","CREATE POLICY \\"Admins can view all comments\\" ON public.application_comments\n  FOR SELECT\n  TO authenticated\n  USING (public.is_admin())","-- Verify that only admins can create comments\nDROP POLICY IF EXISTS \\"Admins can create comments\\" ON public.application_comments","CREATE POLICY \\"Admins can create comments\\" ON public.application_comments\n  FOR INSERT\n  TO authenticated\n  WITH CHECK (\n    public.is_admin() AND\n    author_id = (SELECT auth.uid())\n  )","-- Keep the existing update/delete policies as they are\n-- (Authors can update their own recent comments, soft-delete their own comments)"}	fix_admin_users_visibility
008	{"-- ==========================================\n-- Fix auth_role() function to properly check JWT structure\n-- ==========================================\n--\n-- Problem: The auth_role() function is not correctly extracting the role\n-- from the JWT token's app_metadata structure.\n--\n-- Solution: Update the function to properly check the JWT structure\n-- that Supabase provides, which stores custom claims in app_metadata.\n-- ==========================================\n\n-- Drop and recreate the auth_role function with better JWT parsing\nCREATE OR REPLACE FUNCTION public.auth_role()\nRETURNS TEXT AS $$\nDECLARE\n  jwt_claims jsonb;\n  role_value text;\nBEGIN\n  -- Get the full JWT claims\n  jwt_claims := auth.jwt();\n\n  -- Return null if no JWT (not authenticated)\n  IF jwt_claims IS NULL THEN\n    RETURN 'applicant';\n  END IF;\n\n  -- Try multiple paths where the role might be stored\n  -- Supabase stores custom claims in app_metadata\n  role_value := COALESCE(\n    jwt_claims->'app_metadata'->>'role',     -- Standard location in Supabase\n    jwt_claims->'user_metadata'->>'role',    -- Sometimes in user_metadata\n    jwt_claims->>'role',                      -- Direct claim (less common)\n    'applicant'                               -- Default fallback\n  );\n\n  RETURN role_value;\nEND;\n$$ LANGUAGE plpgsql STABLE SECURITY DEFINER","-- Also create a debug function to help diagnose JWT issues\nCREATE OR REPLACE FUNCTION public.debug_jwt()\nRETURNS jsonb AS $$\nBEGIN\n  RETURN jsonb_build_object(\n    'jwt', auth.jwt(),\n    'uid', auth.uid(),\n    'email', auth.jwt()->>'email',\n    'role_from_auth_role', public.auth_role(),\n    'is_admin', public.is_admin(),\n    'app_metadata', auth.jwt()->'app_metadata',\n    'user_metadata', auth.jwt()->'user_metadata'\n  );\nEND;\n$$ LANGUAGE plpgsql STABLE SECURITY DEFINER","-- Grant execute permissions\nGRANT EXECUTE ON FUNCTION public.auth_role() TO authenticated","GRANT EXECUTE ON FUNCTION public.debug_jwt() TO authenticated"}	fix_auth_role_function
009	{"-- ==========================================\n-- Force fix RLS policies for users table\n-- ==========================================\n--\n-- The is_admin() function is working (returns true), but the RLS policies\n-- on the users table are still blocking access. Let's completely rebuild them.\n-- ==========================================\n\n-- First, drop ALL existing policies on users table to start fresh\nDO $$\nDECLARE\n    pol record;\nBEGIN\n    FOR pol IN SELECT policyname FROM pg_policies WHERE tablename = 'users' AND schemaname = 'public'\n    LOOP\n        EXECUTE format('DROP POLICY IF EXISTS %I ON public.users', pol.policyname);\n    END LOOP;\nEND $$","-- Ensure RLS is enabled\nALTER TABLE public.users ENABLE ROW LEVEL SECURITY","-- Create a single, simple policy: Admins can do everything with users table\nCREATE POLICY \\"admins_all_access\\" ON public.users\n  FOR ALL\n  TO authenticated\n  USING (public.is_admin())\n  WITH CHECK (public.is_admin())","-- Users can view their own profile\nCREATE POLICY \\"users_view_own\\" ON public.users\n  FOR SELECT\n  TO authenticated\n  USING (auth.uid() = id)","-- Users can update their own profile\nCREATE POLICY \\"users_update_own\\" ON public.users\n  FOR UPDATE\n  TO authenticated\n  USING (auth.uid() = id)\n  WITH CHECK (auth.uid() = id)","-- Also ensure application_comments policies are correct\nDROP POLICY IF EXISTS \\"Admins can view all comments\\" ON public.application_comments","DROP POLICY IF EXISTS \\"Admins can view comments\\" ON public.application_comments","-- Simplified policy: if you're admin, you can see all comments\nCREATE POLICY \\"admin_view_comments\\" ON public.application_comments\n  FOR SELECT\n  TO authenticated\n  USING (public.is_admin())","-- Keep other comment policies as they were\n-- (create, update, etc.)"}	force_fix_users_rls
010	{"-- ==========================================\n-- Admin Todo System\n-- ==========================================\n-- A comprehensive todo system for admins to track tasks,\n-- assign work, set priorities, and collaborate through comments.\n-- Only admins can view or interact with these todos.\n-- ==========================================\n\n-- Create priority enum\nCREATE TYPE todo_priority AS ENUM ('low', 'medium', 'high', 'urgent')","-- Create status enum\nCREATE TYPE todo_status AS ENUM ('pending', 'in_progress', 'completed', 'cancelled')","-- ==========================================\n-- Admin todos table\n-- ==========================================\nCREATE TABLE public.admin_todos (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  title TEXT NOT NULL,\n  description TEXT,\n  status todo_status DEFAULT 'pending',\n  priority todo_priority DEFAULT 'medium',\n  assigned_to UUID REFERENCES public.users(id) ON DELETE SET NULL,\n  created_by UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,\n  due_date DATE,\n  completed_at TIMESTAMPTZ,\n  completed_by UUID REFERENCES public.users(id) ON DELETE SET NULL,\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  updated_at TIMESTAMPTZ DEFAULT NOW()\n)","-- Create indexes for performance\nCREATE INDEX idx_admin_todos_status ON public.admin_todos(status)","CREATE INDEX idx_admin_todos_priority ON public.admin_todos(priority)","CREATE INDEX idx_admin_todos_assigned_to ON public.admin_todos(assigned_to)","CREATE INDEX idx_admin_todos_created_by ON public.admin_todos(created_by)","CREATE INDEX idx_admin_todos_due_date ON public.admin_todos(due_date)","-- ==========================================\n-- Admin todo comments table\n-- ==========================================\nCREATE TABLE public.admin_todo_comments (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  todo_id UUID NOT NULL REFERENCES public.admin_todos(id) ON DELETE CASCADE,\n  author_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,\n  content TEXT NOT NULL,\n  created_at TIMESTAMPTZ DEFAULT NOW(),\n  edited_at TIMESTAMPTZ\n)","-- Create indexes for performance\nCREATE INDEX idx_admin_todo_comments_todo_id ON public.admin_todo_comments(todo_id)","CREATE INDEX idx_admin_todo_comments_author_id ON public.admin_todo_comments(author_id)","CREATE INDEX idx_admin_todo_comments_created_at ON public.admin_todo_comments(created_at DESC)","-- ==========================================\n-- Update triggers\n-- ==========================================\n\n-- Trigger for updated_at on todos\nCREATE TRIGGER update_admin_todos_updated_at\n  BEFORE UPDATE ON public.admin_todos\n  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column()","-- ==========================================\n-- RLS Policies for Admin Todos\n-- ==========================================\n\n-- Enable RLS\nALTER TABLE public.admin_todos ENABLE ROW LEVEL SECURITY","-- Only admins can view todos\nCREATE POLICY \\"Admins can view all todos\\" ON public.admin_todos\n  FOR SELECT\n  TO authenticated\n  USING (public.is_admin())","-- Only admins can create todos\nCREATE POLICY \\"Admins can create todos\\" ON public.admin_todos\n  FOR INSERT\n  TO authenticated\n  WITH CHECK (\n    public.is_admin() AND\n    created_by = (SELECT auth.uid())\n  )","-- Admins can update todos\nCREATE POLICY \\"Admins can update todos\\" ON public.admin_todos\n  FOR UPDATE\n  TO authenticated\n  USING (public.is_admin())\n  WITH CHECK (public.is_admin())","-- Admins can delete todos (soft delete by setting status to cancelled)\nCREATE POLICY \\"Admins can delete todos\\" ON public.admin_todos\n  FOR DELETE\n  TO authenticated\n  USING (public.is_admin())","-- ==========================================\n-- RLS Policies for Admin Todo Comments\n-- ==========================================\n\n-- Enable RLS\nALTER TABLE public.admin_todo_comments ENABLE ROW LEVEL SECURITY","-- Only admins can view comments\nCREATE POLICY \\"Admins can view todo comments\\" ON public.admin_todo_comments\n  FOR SELECT\n  TO authenticated\n  USING (public.is_admin())","-- Only admins can create comments\nCREATE POLICY \\"Admins can create todo comments\\" ON public.admin_todo_comments\n  FOR INSERT\n  TO authenticated\n  WITH CHECK (\n    public.is_admin() AND\n    author_id = (SELECT auth.uid())\n  )","-- Authors can update their own comments within 15 minutes\nCREATE POLICY \\"Authors can update own recent todo comments\\" ON public.admin_todo_comments\n  FOR UPDATE\n  TO authenticated\n  USING (\n    public.is_admin() AND\n    author_id = (SELECT auth.uid()) AND\n    created_at > NOW() - INTERVAL '15 minutes'\n  )\n  WITH CHECK (\n    public.is_admin() AND\n    author_id = (SELECT auth.uid())\n  )","-- Authors can delete their own comments\nCREATE POLICY \\"Authors can delete own todo comments\\" ON public.admin_todo_comments\n  FOR DELETE\n  TO authenticated\n  USING (\n    public.is_admin() AND\n    author_id = (SELECT auth.uid())\n  )","-- ==========================================\n-- Helper function to auto-set completed_at and completed_by\n-- ==========================================\n\nCREATE OR REPLACE FUNCTION public.handle_todo_completion()\nRETURNS TRIGGER AS $$\nBEGIN\n  -- If status is changing to completed\n  IF NEW.status = 'completed' AND OLD.status != 'completed' THEN\n    NEW.completed_at = NOW();\n    NEW.completed_by = auth.uid();\n  -- If status is changing from completed to something else\n  ELSIF OLD.status = 'completed' AND NEW.status != 'completed' THEN\n    NEW.completed_at = NULL;\n    NEW.completed_by = NULL;\n  END IF;\n\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql","-- Create trigger for auto-completion handling\nCREATE TRIGGER handle_todo_completion\n  BEFORE UPDATE ON public.admin_todos\n  FOR EACH ROW\n  WHEN (OLD.status IS DISTINCT FROM NEW.status)\n  EXECUTE FUNCTION public.handle_todo_completion()","-- ==========================================\n-- View for todos with assignee and creator info\n-- ==========================================\n\nCREATE OR REPLACE VIEW public.admin_todos_with_users AS\nSELECT\n  t.*,\n  creator.name as creator_name,\n  creator.email as creator_email,\n  assignee.name as assignee_name,\n  assignee.email as assignee_email,\n  completer.name as completer_name,\n  (\n    SELECT COUNT(*)\n    FROM public.admin_todo_comments\n    WHERE todo_id = t.id\n  ) as comment_count\nFROM public.admin_todos t\nLEFT JOIN public.users creator ON t.created_by = creator.id\nLEFT JOIN public.users assignee ON t.assigned_to = assignee.id\nLEFT JOIN public.users completer ON t.completed_by = completer.id","-- Grant access to the view\nGRANT SELECT ON public.admin_todos_with_users TO authenticated"}	admin_todos
018	{"-- Enable automatic status change when voting threshold is met\r\nUPDATE public.voting_config\r\nSET\r\n  auto_approve_enabled = true,\r\n  auto_reject_enabled = true,\r\n  updated_at = NOW()"}	enable_auto_voting
011	{"-- Create invite_tokens table for managing participant invitations\nCREATE TABLE IF NOT EXISTS public.invite_tokens (\n    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,\n    email VARCHAR(255) NOT NULL,\n    token VARCHAR(255) NOT NULL UNIQUE,\n    application_id UUID REFERENCES public.applications(id) ON DELETE CASCADE,\n    used BOOLEAN DEFAULT FALSE,\n    used_at TIMESTAMP WITH TIME ZONE,\n    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\n    expires_at TIMESTAMP WITH TIME ZONE DEFAULT (NOW() + INTERVAL '30 days')\n)","-- Add indexes\nCREATE INDEX idx_invite_tokens_token ON public.invite_tokens(token)","CREATE INDEX idx_invite_tokens_email ON public.invite_tokens(email)","CREATE INDEX idx_invite_tokens_application_id ON public.invite_tokens(application_id)","-- Enable RLS\nALTER TABLE public.invite_tokens ENABLE ROW LEVEL SECURITY","-- RLS Policies\n-- Only admins can view invite tokens\nCREATE POLICY \\"Admins can view all invite tokens\\"\nON public.invite_tokens FOR SELECT\nTO authenticated\nUSING (is_admin())","-- Only admins can create invite tokens\nCREATE POLICY \\"Admins can create invite tokens\\"\nON public.invite_tokens FOR INSERT\nTO authenticated\nWITH CHECK (is_admin())","-- Only admins can update invite tokens\nCREATE POLICY \\"Admins can update invite tokens\\"\nON public.invite_tokens FOR UPDATE\nTO authenticated\nUSING (is_admin())\nWITH CHECK (is_admin())","-- Public can check if a token exists (for signup validation)\nCREATE POLICY \\"Public can validate tokens\\"\nON public.invite_tokens FOR SELECT\nTO anon\nUSING (\n    NOT used\n    AND expires_at > NOW()\n)","-- Function to validate and use an invite token\nCREATE OR REPLACE FUNCTION validate_invite_token(\n    p_token VARCHAR,\n    p_email VARCHAR\n)\nRETURNS BOOLEAN\nLANGUAGE plpgsql\nSECURITY DEFINER\nAS $$\nDECLARE\n    v_valid BOOLEAN;\nBEGIN\n    -- Check if token exists, matches email, is not used, and not expired\n    SELECT EXISTS(\n        SELECT 1\n        FROM public.invite_tokens\n        WHERE token = p_token\n        AND email = p_email\n        AND NOT used\n        AND expires_at > NOW()\n    ) INTO v_valid;\n\n    -- If valid, mark as used\n    IF v_valid THEN\n        UPDATE public.invite_tokens\n        SET used = TRUE,\n            used_at = NOW()\n        WHERE token = p_token;\n    END IF;\n\n    RETURN v_valid;\nEND;\n$$","-- Function to generate invite token for accepted applicant\nCREATE OR REPLACE FUNCTION generate_invite_token(\n    p_application_id UUID\n)\nRETURNS VARCHAR\nLANGUAGE plpgsql\nSECURITY DEFINER\nAS $$\nDECLARE\n    v_email VARCHAR;\n    v_token VARCHAR;\n    v_status VARCHAR;\nBEGIN\n    -- Get application details\n    SELECT email, status\n    INTO v_email, v_status\n    FROM public.applications\n    WHERE id = p_application_id;\n\n    -- Check if application exists and is accepted\n    IF v_email IS NULL THEN\n        RAISE EXCEPTION 'Application not found';\n    END IF;\n\n    IF v_status != 'accepted' THEN\n        RAISE EXCEPTION 'Application must be accepted to generate invite token';\n    END IF;\n\n    -- Check if token already exists for this application\n    SELECT token INTO v_token\n    FROM public.invite_tokens\n    WHERE application_id = p_application_id\n    AND NOT used;\n\n    -- If no unused token exists, create new one\n    IF v_token IS NULL THEN\n        -- Generate random token\n        v_token := encode(gen_random_bytes(32), 'hex');\n\n        -- Insert token\n        INSERT INTO public.invite_tokens (\n            email,\n            token,\n            application_id\n        ) VALUES (\n            v_email,\n            v_token,\n            p_application_id\n        );\n    END IF;\n\n    RETURN v_token;\nEND;\n$$","-- Add function to automatically set user role to participant on signup with valid token\nCREATE OR REPLACE FUNCTION set_participant_role()\nRETURNS TRIGGER\nLANGUAGE plpgsql\nSECURITY DEFINER\nAS $$\nBEGIN\n    -- Update the user's app_metadata to set role as participant\n    UPDATE auth.users\n    SET raw_app_meta_data = jsonb_set(\n        COALESCE(raw_app_meta_data, '{}'::jsonb),\n        '{role}',\n        '\\"participant\\"'\n    )\n    WHERE id = NEW.id;\n\n    RETURN NEW;\nEND;\n$$","-- Create trigger to set participant role when user signs up with valid invite\n-- We'll handle this in the signup logic instead to ensure token validation"}	invite_tokens
012	{"-- Update validate_invite_token to set participant role in app_metadata\nCREATE OR REPLACE FUNCTION validate_invite_token(\n    p_token VARCHAR,\n    p_email VARCHAR\n)\nRETURNS BOOLEAN\nLANGUAGE plpgsql\nSECURITY DEFINER\nAS $$\nDECLARE\n    v_valid BOOLEAN;\nBEGIN\n    -- Check if token exists, matches email, is not used, and not expired\n    SELECT EXISTS(\n        SELECT 1\n        FROM public.invite_tokens\n        WHERE token = p_token\n        AND email = p_email\n        AND NOT used\n        AND expires_at > NOW()\n    ) INTO v_valid;\n\n    -- If valid, mark as used\n    IF v_valid THEN\n        UPDATE public.invite_tokens\n        SET used = TRUE,\n            used_at = NOW()\n        WHERE token = p_token;\n\n        -- Set participant role for any user with this email\n        UPDATE auth.users\n        SET raw_app_meta_data = jsonb_set(\n            COALESCE(raw_app_meta_data, '{}'),\n            '{role}',\n            '\\"participant\\"'\n        )\n        WHERE email = p_email;\n    END IF;\n\n    RETURN v_valid;\nEND;\n$$","-- Also create a trigger to automatically set participant role when user signs up\nCREATE OR REPLACE FUNCTION auto_set_participant_role()\nRETURNS TRIGGER\nLANGUAGE plpgsql\nSECURITY DEFINER\nAS $$\nBEGIN\n    -- Check if user has a used invite token\n    IF EXISTS (\n        SELECT 1\n        FROM public.invite_tokens\n        WHERE email = NEW.email\n        AND used = TRUE\n    ) THEN\n        -- Set participant role in app_metadata\n        UPDATE auth.users\n        SET raw_app_meta_data = jsonb_set(\n            COALESCE(raw_app_meta_data, '{}'),\n            '{role}',\n            '\\"participant\\"'\n        )\n        WHERE id = NEW.id;\n    END IF;\n\n    RETURN NEW;\nEND;\n$$","-- Create trigger to run after user creation\nDROP TRIGGER IF EXISTS set_participant_role_on_signup ON auth.users","CREATE TRIGGER set_participant_role_on_signup\n    AFTER INSERT ON auth.users\n    FOR EACH ROW\n    EXECUTE FUNCTION auto_set_participant_role()"}	fix_participant_role_on_signup
013	{"-- ==========================================\n-- Restructure applications table for classification-based questionnaire\n-- ==========================================\n\n-- Clear any existing applications FIRST (before adding constraints)\nTRUNCATE TABLE public.application_votes CASCADE","TRUNCATE TABLE public.application_comments CASCADE","TRUNCATE TABLE public.invite_tokens CASCADE","TRUNCATE TABLE public.applications CASCADE","-- Drop old application question columns\nALTER TABLE public.applications\nDROP COLUMN IF EXISTS reason_for_applying,\nDROP COLUMN IF EXISTS requirements_for_protocol,\nDROP COLUMN IF EXISTS relevant_experience","-- Add classification fields\nALTER TABLE public.applications\nADD COLUMN classifications TEXT[] NOT NULL DEFAULT '{}',\nADD COLUMN classification_other TEXT CHECK (char_length(classification_other) <= 15)","-- Add universal question fields (required for all applicants)\nALTER TABLE public.applications\nADD COLUMN importance_of_schema TEXT NOT NULL DEFAULT '',\nADD COLUMN excited_projects TEXT NOT NULL DEFAULT '',\nADD COLUMN work_links JSONB NOT NULL DEFAULT '[{\\"url\\": \\"\\", \\"role\\": \\"\\"}]'::jsonb,\nADD COLUMN workshop_contribution TEXT NOT NULL DEFAULT '',\nADD COLUMN research_elements TEXT NOT NULL DEFAULT ''","-- Add role-specific question fields (nullable - only required if that role is selected)\nALTER TABLE public.applications\nADD COLUMN researcher_use_case TEXT,\nADD COLUMN researcher_future_impact TEXT,\nADD COLUMN designer_ux_considerations TEXT,\nADD COLUMN engineer_working_on TEXT,\nADD COLUMN engineer_schema_considerations TEXT,\nADD COLUMN conceptionalist_unlock TEXT,\nADD COLUMN conceptionalist_enable TEXT","-- Create index on classifications array for faster filtering\nCREATE INDEX IF NOT EXISTS idx_applications_classifications ON public.applications USING GIN (classifications)","-- Add check constraint to ensure at least one classification\nALTER TABLE public.applications\nADD CONSTRAINT check_at_least_one_classification CHECK (array_length(classifications, 1) >= 1)","-- Add check constraint for classification_other (required if 'other' in classifications)\nALTER TABLE public.applications\nADD CONSTRAINT check_classification_other_when_other CHECK (\n  (NOT 'other' = ANY(classifications)) OR\n  (classification_other IS NOT NULL AND char_length(classification_other) > 0)\n)","-- Add check constraint for work_links structure (must be array of objects with url and role)\nALTER TABLE public.applications\nADD CONSTRAINT check_work_links_structure CHECK (\n  jsonb_typeof(work_links) = 'array' AND\n  jsonb_array_length(work_links) >= 1 AND\n  jsonb_array_length(work_links) <= 5\n)","-- Add check constraints for role-specific questions based on classifications\n-- Researcher questions required if 'researcher' in classifications\nALTER TABLE public.applications\nADD CONSTRAINT check_researcher_questions CHECK (\n  (NOT 'researcher' = ANY(classifications)) OR\n  (researcher_use_case IS NOT NULL AND researcher_future_impact IS NOT NULL)\n)","-- Designer questions required if 'designer' in classifications\nALTER TABLE public.applications\nADD CONSTRAINT check_designer_questions CHECK (\n  (NOT 'designer' = ANY(classifications)) OR\n  (designer_ux_considerations IS NOT NULL)\n)","-- Engineer questions required if 'engineer' in classifications\nALTER TABLE public.applications\nADD CONSTRAINT check_engineer_questions CHECK (\n  (NOT 'engineer' = ANY(classifications)) OR\n  (engineer_working_on IS NOT NULL AND engineer_schema_considerations IS NOT NULL)\n)","-- Conceptionalist questions required if 'conceptionalist' in classifications\nALTER TABLE public.applications\nADD CONSTRAINT check_conceptionalist_questions CHECK (\n  (NOT 'conceptionalist' = ANY(classifications)) OR\n  (conceptionalist_unlock IS NOT NULL AND conceptionalist_enable IS NOT NULL)\n)","-- Remove default constraints after adding them (they were just for migration)\nALTER TABLE public.applications\nALTER COLUMN importance_of_schema DROP DEFAULT,\nALTER COLUMN excited_projects DROP DEFAULT,\nALTER COLUMN work_links DROP DEFAULT,\nALTER COLUMN workshop_contribution DROP DEFAULT,\nALTER COLUMN research_elements DROP DEFAULT","-- ==========================================\n-- Helper function to validate work_links structure\n-- ==========================================\n\nCREATE OR REPLACE FUNCTION public.validate_work_links(links JSONB)\nRETURNS BOOLEAN AS $$\nDECLARE\n  link JSONB;\nBEGIN\n  -- Check if it's an array\n  IF jsonb_typeof(links) != 'array' THEN\n    RETURN FALSE;\n  END IF;\n\n  -- Check array length\n  IF jsonb_array_length(links) < 1 OR jsonb_array_length(links) > 5 THEN\n    RETURN FALSE;\n  END IF;\n\n  -- Check each element has url and role\n  FOR link IN SELECT * FROM jsonb_array_elements(links)\n  LOOP\n    IF NOT (link ? 'url' AND link ? 'role') THEN\n      RETURN FALSE;\n    END IF;\n\n    IF jsonb_typeof(link->'url') != 'string' OR jsonb_typeof(link->'role') != 'string' THEN\n      RETURN FALSE;\n    END IF;\n  END LOOP;\n\n  RETURN TRUE;\nEND;\n$$ LANGUAGE plpgsql IMMUTABLE","-- Grant execute permission\nGRANT EXECUTE ON FUNCTION public.validate_work_links TO authenticated","GRANT EXECUTE ON FUNCTION public.validate_work_links TO anon","-- ==========================================\n-- Comment on new columns for documentation\n-- ==========================================\n\nCOMMENT ON COLUMN public.applications.classifications IS 'Array of selected classifications: researcher, engineer, designer, conceptionalist, other'","COMMENT ON COLUMN public.applications.classification_other IS 'Custom classification text if \\"other\\" is selected (max 15 chars)'","COMMENT ON COLUMN public.applications.importance_of_schema IS 'Why is an interoperable Research attribution Schema important to you? (200 words)'","COMMENT ON COLUMN public.applications.excited_projects IS 'What other science/infrastructure/open science projects are you excited about? (200 words)'","COMMENT ON COLUMN public.applications.work_links IS 'Array of {url, role} objects for links to applicant work (1-5 links)'","COMMENT ON COLUMN public.applications.workshop_contribution IS 'What would you add to this workshop if you came? (200 words)'","COMMENT ON COLUMN public.applications.research_elements IS 'What elements or outputs of the research process would you define? (200 words)'","COMMENT ON COLUMN public.applications.researcher_use_case IS 'Researcher: Immediate use-case for modular research sharing/attribution (200 words)'","COMMENT ON COLUMN public.applications.researcher_future_impact IS 'Researcher: Future impact of granular research sharing (200 words)'","COMMENT ON COLUMN public.applications.designer_ux_considerations IS 'Designer: Important considerations for UX/design across platforms (200 words)'","COMMENT ON COLUMN public.applications.engineer_working_on IS 'Engineer: What are you working on that would use the schema - How? (200 words)'","COMMENT ON COLUMN public.applications.engineer_schema_considerations IS 'Engineer: Important considerations for designing shared schema (200 words)'","COMMENT ON COLUMN public.applications.conceptionalist_unlock IS 'Conceptionalist: What would schema unlock for existing projects? (200 words)'","COMMENT ON COLUMN public.applications.conceptionalist_enable IS 'Conceptionalist: What new projects might schema enable? (200 words)'"}	restructure_applications
014	{"-- ==========================================\n-- Update work_links structure to support description-first work items\n-- Structure changes from {url, role} to {description, role, url (optional)}\n-- ==========================================\n\n-- Clear existing applications to avoid migration issues\nTRUNCATE TABLE public.application_votes CASCADE","TRUNCATE TABLE public.application_comments CASCADE","TRUNCATE TABLE public.invite_tokens CASCADE","TRUNCATE TABLE public.applications CASCADE","-- Drop old validation function\nDROP FUNCTION IF EXISTS public.validate_work_links(JSONB)","-- Drop old check constraint\nALTER TABLE public.applications\nDROP CONSTRAINT IF EXISTS check_work_links_structure","-- Update work_links column comment to reflect new structure\nCOMMENT ON COLUMN public.applications.work_links IS 'Array of {description, role, url (optional)} objects for work examples (1-5 items)'","-- Create new validation function for work_links with description-first structure\nCREATE OR REPLACE FUNCTION public.validate_work_links(links JSONB)\nRETURNS BOOLEAN AS $$\nDECLARE\n  link JSONB;\nBEGIN\n  -- Check if it's an array\n  IF jsonb_typeof(links) != 'array' THEN\n    RETURN FALSE;\n  END IF;\n\n  -- Check array length\n  IF jsonb_array_length(links) < 1 OR jsonb_array_length(links) > 5 THEN\n    RETURN FALSE;\n  END IF;\n\n  -- Check each element has required fields: description, role\n  -- URL is optional\n  FOR link IN SELECT * FROM jsonb_array_elements(links)\n  LOOP\n    -- Must have description and role\n    IF NOT (link ? 'description' AND link ? 'role') THEN\n      RETURN FALSE;\n    END IF;\n\n    -- Check types are strings\n    IF jsonb_typeof(link->'description') != 'string' OR jsonb_typeof(link->'role') != 'string' THEN\n      RETURN FALSE;\n    END IF;\n\n    -- URL is optional, but if present must be a string\n    IF link ? 'url' THEN\n      IF jsonb_typeof(link->'url') != 'string' THEN\n        RETURN FALSE;\n      END IF;\n    END IF;\n\n    -- Description must be at least 10 characters\n    IF length(link->>'description') < 10 THEN\n      RETURN FALSE;\n    END IF;\n\n    -- Role must be at least 2 characters\n    IF length(link->>'role') < 2 THEN\n      RETURN FALSE;\n    END IF;\n  END LOOP;\n\n  RETURN TRUE;\nEND;\n$$ LANGUAGE plpgsql IMMUTABLE","-- Add new check constraint for work_links structure with description required\nALTER TABLE public.applications\nADD CONSTRAINT check_work_links_structure CHECK (\n  jsonb_typeof(work_links) = 'array' AND\n  jsonb_array_length(work_links) >= 1 AND\n  jsonb_array_length(work_links) <= 5 AND\n  validate_work_links(work_links)\n)","-- Grant execute permission\nGRANT EXECUTE ON FUNCTION public.validate_work_links TO authenticated","GRANT EXECUTE ON FUNCTION public.validate_work_links TO anon","-- ==========================================\n-- Migration Note:\n-- Existing applications will need to be manually updated if any exist\n-- New structure: [{description: string, role: string, url?: string}]\n-- Old structure: [{url: string, role: string}]\n-- =========================================="}	update_work_links_structure
015	{"-- ==========================================\n-- Rename \\"Conceptionalist\\" classification to \\"Landscape/Ecosystem Specialist\\"\n-- ==========================================\n\n-- Clear existing applications to avoid migration issues\nTRUNCATE TABLE public.application_votes CASCADE","TRUNCATE TABLE public.application_comments CASCADE","TRUNCATE TABLE public.invite_tokens CASCADE","TRUNCATE TABLE public.applications CASCADE","-- Drop old check constraint for conceptionalist\nALTER TABLE public.applications\nDROP CONSTRAINT IF EXISTS check_conceptionalist_questions","-- Rename columns from conceptionalist_* to landscape_specialist_*\nALTER TABLE public.applications\nRENAME COLUMN conceptionalist_unlock TO landscape_specialist_current_work","ALTER TABLE public.applications\nRENAME COLUMN conceptionalist_enable TO landscape_specialist_see_emerging","-- Add new check constraint for landscape_specialist questions\nALTER TABLE public.applications\nADD CONSTRAINT check_landscape_specialist_questions CHECK (\n  (NOT 'landscape_specialist' = ANY(classifications)) OR\n  (landscape_specialist_current_work IS NOT NULL AND landscape_specialist_see_emerging IS NOT NULL)\n)","-- Update column comments\nCOMMENT ON COLUMN public.applications.landscape_specialist_current_work IS 'Landscape/Ecosystem Specialist: What research landscape(s) or ecosystem(s) are you currently working in or observing? (200 words)'","COMMENT ON COLUMN public.applications.landscape_specialist_see_emerging IS 'Landscape/Ecosystem Specialist: What do you see emerging in research ecosystems that an interoperable attribution schema might support? (200 words)'","-- ==========================================\n-- Migration Note:\n-- This migration renames the \\"Conceptionalist\\" classification to \\"Landscape/Ecosystem Specialist\\"\n-- Field mappings:\n-- - conceptionalist_unlock -> landscape_specialist_current_work\n-- - conceptionalist_enable -> landscape_specialist_see_emerging\n-- =========================================="}	rename_conceptionalist_to_landscape_specialist
016	{"-- ==========================================\n-- Relax validation constraints for work_items\n-- Change minimum length from 10 to 1 for description, and 2 to 1 for role\n-- ==========================================\n\n-- Drop constraint first (depends on the function)\nALTER TABLE public.applications\nDROP CONSTRAINT IF EXISTS check_work_links_structure","-- Drop old validation function\nDROP FUNCTION IF EXISTS public.validate_work_links(JSONB)","-- Create updated validation function with relaxed constraints\nCREATE OR REPLACE FUNCTION public.validate_work_links(links JSONB)\nRETURNS BOOLEAN AS $$\nDECLARE\n  link JSONB;\nBEGIN\n  -- Check if it's an array\n  IF jsonb_typeof(links) != 'array' THEN\n    RETURN FALSE;\n  END IF;\n\n  -- Check array length\n  IF jsonb_array_length(links) < 1 OR jsonb_array_length(links) > 5 THEN\n    RETURN FALSE;\n  END IF;\n\n  -- Check each element has required fields: description, role\n  -- URL is optional\n  FOR link IN SELECT * FROM jsonb_array_elements(links)\n  LOOP\n    -- Must have description and role\n    IF NOT (link ? 'description' AND link ? 'role') THEN\n      RETURN FALSE;\n    END IF;\n\n    -- Check types are strings\n    IF jsonb_typeof(link->'description') != 'string' OR jsonb_typeof(link->'role') != 'string' THEN\n      RETURN FALSE;\n    END IF;\n\n    -- URL is optional, but if present must be a string\n    IF link ? 'url' THEN\n      IF jsonb_typeof(link->'url') != 'string' THEN\n        RETURN FALSE;\n      END IF;\n    END IF;\n\n    -- Description must be at least 1 character (not empty)\n    IF length(link->>'description') < 1 THEN\n      RETURN FALSE;\n    END IF;\n\n    -- Role must be at least 1 character (not empty)\n    IF length(link->>'role') < 1 THEN\n      RETURN FALSE;\n    END IF;\n  END LOOP;\n\n  RETURN TRUE;\nEND;\n$$ LANGUAGE plpgsql IMMUTABLE","-- Re-add the constraint with the new validation function\nALTER TABLE public.applications\nADD CONSTRAINT check_work_links_structure CHECK (\n  jsonb_typeof(work_links) = 'array' AND\n  jsonb_array_length(work_links) >= 1 AND\n  jsonb_array_length(work_links) <= 5 AND\n  validate_work_links(work_links)\n)","-- Grant execute permission\nGRANT EXECUTE ON FUNCTION public.validate_work_links TO authenticated","GRANT EXECUTE ON FUNCTION public.validate_work_links TO anon","-- ==========================================\n-- Migration Note:\n-- This relaxes the validation to match the front-end form validation\n-- Description: min 1 character (was 10)\n-- Role: min 1 character (was 2)\n-- =========================================="}	relax_work_items_validation
017	{"-- ==========================================\n-- Security Hardening for Admin Views\n-- ==========================================\n-- This migration explicitly sets SECURITY INVOKER on views and\n-- ensures proper ownership to prevent RLS bypass issues.\n-- ==========================================\n\n-- Recreate the admin_todos_with_users view with explicit SECURITY INVOKER\n-- This ensures RLS policies on underlying tables are always enforced\nDROP VIEW IF EXISTS public.admin_todos_with_users","CREATE VIEW public.admin_todos_with_users\nWITH (security_invoker = true)\nAS\nSELECT\n  t.*,\n  creator.name as creator_name,\n  creator.email as creator_email,\n  assignee.name as assignee_name,\n  assignee.email as assignee_email,\n  completer.name as completer_name,\n  (\n    SELECT COUNT(*)\n    FROM public.admin_todo_comments\n    WHERE todo_id = t.id\n  ) as comment_count\nFROM public.admin_todos t\nLEFT JOIN public.users creator ON t.created_by = creator.id\nLEFT JOIN public.users assignee ON t.assigned_to = assignee.id\nLEFT JOIN public.users completer ON t.completed_by = completer.id","-- Secure the grants: only authenticated users can query\n-- (RLS on admin_todos will filter to admins only)\nREVOKE ALL ON public.admin_todos_with_users FROM PUBLIC","GRANT SELECT ON public.admin_todos_with_users TO authenticated","-- Add a comment documenting the security model\nCOMMENT ON VIEW public.admin_todos_with_users IS\n'View for admin todos with user details. Security: Uses SECURITY INVOKER so RLS on admin_todos (admin-only) is enforced. Non-admins will receive zero rows.'","-- ==========================================\n-- Also secure application_voting_summary view\n-- ==========================================\nDROP VIEW IF EXISTS public.application_voting_summary","CREATE VIEW public.application_voting_summary\nWITH (security_invoker = true)\nAS\nSELECT\n  a.id,\n  a.name,\n  a.email,\n  a.status,\n  a.total_votes,\n  a.approve_votes,\n  a.reject_votes,\n  a.abstain_votes,\n  a.voting_completed,\n  CASE\n    WHEN a.total_votes > 0 THEN ROUND((a.approve_votes::DECIMAL / a.total_votes) * 100, 1)\n    ELSE 0\n  END as approval_percentage,\n  CASE\n    WHEN a.total_votes > 0 THEN ROUND((a.reject_votes::DECIMAL / a.total_votes) * 100, 1)\n    ELSE 0\n  END as rejection_percentage,\n  COALESCE(\n    array_agg(\n      jsonb_build_object(\n        'admin_id', v.admin_id,\n        'admin_name', u.name,\n        'vote', v.vote,\n        'voted_at', v.created_at\n      ) ORDER BY v.created_at\n    ) FILTER (WHERE v.id IS NOT NULL),\n    ARRAY[]::jsonb[]\n  ) as votes\nFROM public.applications a\nLEFT JOIN public.application_votes v ON a.id = v.application_id\nLEFT JOIN public.users u ON v.admin_id = u.id\nGROUP BY\n  a.id, a.name, a.email, a.status, a.total_votes,\n  a.approve_votes, a.reject_votes, a.abstain_votes, a.voting_completed","REVOKE ALL ON public.application_voting_summary FROM PUBLIC","GRANT SELECT ON public.application_voting_summary TO authenticated","COMMENT ON VIEW public.application_voting_summary IS\n'Voting summary for applications. Security: Uses SECURITY INVOKER so RLS on applications/votes tables is enforced.'"}	secure_admin_views
\.


--
-- Data for Name: seed_files; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.seed_files (path, hash) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 424, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: admin_todo_comments admin_todo_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_todo_comments
    ADD CONSTRAINT admin_todo_comments_pkey PRIMARY KEY (id);


--
-- Name: admin_todos admin_todos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_todos
    ADD CONSTRAINT admin_todos_pkey PRIMARY KEY (id);


--
-- Name: application_comments application_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_comments
    ADD CONSTRAINT application_comments_pkey PRIMARY KEY (id);


--
-- Name: application_votes application_votes_application_id_admin_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_votes
    ADD CONSTRAINT application_votes_application_id_admin_id_key UNIQUE (application_id, admin_id);


--
-- Name: application_votes application_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_votes
    ADD CONSTRAINT application_votes_pkey PRIMARY KEY (id);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: blog_posts blog_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_pkey PRIMARY KEY (id);


--
-- Name: blog_posts blog_posts_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_slug_key UNIQUE (slug);


--
-- Name: breakout_rooms breakout_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.breakout_rooms
    ADD CONSTRAINT breakout_rooms_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: daily_reflections daily_reflections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_reflections
    ADD CONSTRAINT daily_reflections_pkey PRIMARY KEY (id);


--
-- Name: daily_reflections daily_reflections_user_id_workshop_day_reflection_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_reflections
    ADD CONSTRAINT daily_reflections_user_id_workshop_day_reflection_type_key UNIQUE (user_id, workshop_day, reflection_type);


--
-- Name: invite_tokens invite_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invite_tokens
    ADD CONSTRAINT invite_tokens_pkey PRIMARY KEY (id);


--
-- Name: invite_tokens invite_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invite_tokens
    ADD CONSTRAINT invite_tokens_token_key UNIQUE (token);


--
-- Name: photo_gallery photo_gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo_gallery
    ADD CONSTRAINT photo_gallery_pkey PRIMARY KEY (id);


--
-- Name: room_participants room_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_participants
    ADD CONSTRAINT room_participants_pkey PRIMARY KEY (id);


--
-- Name: room_participants room_participants_room_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_participants
    ADD CONSTRAINT room_participants_room_id_user_id_key UNIQUE (room_id, user_id);


--
-- Name: schema_iterations schema_iterations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_iterations
    ADD CONSTRAINT schema_iterations_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: applications unique_application_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT unique_application_email UNIQUE (email);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: voting_config voting_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voting_config
    ADD CONSTRAINT voting_config_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_02_02 messages_2026_02_02_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_02_02
    ADD CONSTRAINT messages_2026_02_02_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_02_03 messages_2026_02_03_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_02_03
    ADD CONSTRAINT messages_2026_02_03_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_02_04 messages_2026_02_04_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_02_04
    ADD CONSTRAINT messages_2026_02_04_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_02_05 messages_2026_02_05_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_02_05
    ADD CONSTRAINT messages_2026_02_05_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_02_06 messages_2026_02_06_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_02_06
    ADD CONSTRAINT messages_2026_02_06_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_02_07 messages_2026_02_07_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_02_07
    ADD CONSTRAINT messages_2026_02_07_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_02_08 messages_2026_02_08_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_02_08
    ADD CONSTRAINT messages_2026_02_08_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_02_11 messages_2026_02_11_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_02_11
    ADD CONSTRAINT messages_2026_02_11_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_02_12 messages_2026_02_12_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_02_12
    ADD CONSTRAINT messages_2026_02_12_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_02_13 messages_2026_02_13_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_02_13
    ADD CONSTRAINT messages_2026_02_13_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_02_14 messages_2026_02_14_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_02_14
    ADD CONSTRAINT messages_2026_02_14_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_02_15 messages_2026_02_15_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_02_15
    ADD CONSTRAINT messages_2026_02_15_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: seed_files seed_files_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.seed_files
    ADD CONSTRAINT seed_files_pkey PRIMARY KEY (path);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: idx_admin_todo_comments_author_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_todo_comments_author_id ON public.admin_todo_comments USING btree (author_id);


--
-- Name: idx_admin_todo_comments_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_todo_comments_created_at ON public.admin_todo_comments USING btree (created_at DESC);


--
-- Name: idx_admin_todo_comments_todo_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_todo_comments_todo_id ON public.admin_todo_comments USING btree (todo_id);


--
-- Name: idx_admin_todos_assigned_to; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_todos_assigned_to ON public.admin_todos USING btree (assigned_to);


--
-- Name: idx_admin_todos_created_by; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_todos_created_by ON public.admin_todos USING btree (created_by);


--
-- Name: idx_admin_todos_due_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_todos_due_date ON public.admin_todos USING btree (due_date);


--
-- Name: idx_admin_todos_priority; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_todos_priority ON public.admin_todos USING btree (priority);


--
-- Name: idx_admin_todos_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_todos_status ON public.admin_todos USING btree (status);


--
-- Name: idx_application_comments_application_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_application_comments_application_id ON public.application_comments USING btree (application_id);


--
-- Name: idx_application_comments_author_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_application_comments_author_id ON public.application_comments USING btree (author_id);


--
-- Name: idx_application_comments_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_application_comments_created_at ON public.application_comments USING btree (created_at DESC);


--
-- Name: idx_application_comments_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_application_comments_parent_id ON public.application_comments USING btree (parent_id);


--
-- Name: idx_application_votes_admin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_application_votes_admin_id ON public.application_votes USING btree (admin_id);


--
-- Name: idx_application_votes_application_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_application_votes_application_id ON public.application_votes USING btree (application_id);


--
-- Name: idx_application_votes_vote; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_application_votes_vote ON public.application_votes USING btree (vote);


--
-- Name: idx_applications_classifications; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_applications_classifications ON public.applications USING gin (classifications);


--
-- Name: idx_applications_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_applications_email ON public.applications USING btree (email);


--
-- Name: idx_applications_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_applications_status ON public.applications USING btree (status);


--
-- Name: idx_applications_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_applications_user_id ON public.applications USING btree (user_id);


--
-- Name: idx_blog_posts_author_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_blog_posts_author_id ON public.blog_posts USING btree (author_id);


--
-- Name: idx_blog_posts_published; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_blog_posts_published ON public.blog_posts USING btree (published);


--
-- Name: idx_blog_posts_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_blog_posts_slug ON public.blog_posts USING btree (slug);


--
-- Name: idx_comments_target; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_comments_target ON public.comments USING btree (target_type, target_id);


--
-- Name: idx_comments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_comments_user_id ON public.comments USING btree (user_id);


--
-- Name: idx_daily_reflections_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_daily_reflections_user_id ON public.daily_reflections USING btree (user_id);


--
-- Name: idx_invite_tokens_application_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invite_tokens_application_id ON public.invite_tokens USING btree (application_id);


--
-- Name: idx_invite_tokens_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invite_tokens_email ON public.invite_tokens USING btree (email);


--
-- Name: idx_invite_tokens_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invite_tokens_token ON public.invite_tokens USING btree (token);


--
-- Name: idx_photo_gallery_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_photo_gallery_user_id ON public.photo_gallery USING btree (user_id);


--
-- Name: idx_room_participants_user_room; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_room_participants_user_room ON public.room_participants USING btree (user_id, room_id);


--
-- Name: idx_tasks_assignee_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tasks_assignee_id ON public.tasks USING btree (assignee_id);


--
-- Name: idx_tasks_created_by; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tasks_created_by ON public.tasks USING btree (created_by);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_02_02_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_02_02_inserted_at_topic_idx ON realtime.messages_2026_02_02 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_02_03_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_02_03_inserted_at_topic_idx ON realtime.messages_2026_02_03 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_02_04_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_02_04_inserted_at_topic_idx ON realtime.messages_2026_02_04 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_02_05_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_02_05_inserted_at_topic_idx ON realtime.messages_2026_02_05 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_02_06_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_02_06_inserted_at_topic_idx ON realtime.messages_2026_02_06 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_02_07_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_02_07_inserted_at_topic_idx ON realtime.messages_2026_02_07 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_02_08_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_02_08_inserted_at_topic_idx ON realtime.messages_2026_02_08 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_02_11_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_02_11_inserted_at_topic_idx ON realtime.messages_2026_02_11 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_02_12_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_02_12_inserted_at_topic_idx ON realtime.messages_2026_02_12 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_02_13_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_02_13_inserted_at_topic_idx ON realtime.messages_2026_02_13 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_02_14_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_02_14_inserted_at_topic_idx ON realtime.messages_2026_02_14 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_02_15_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_02_15_inserted_at_topic_idx ON realtime.messages_2026_02_15 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_key ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: messages_2026_02_02_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_02_02_inserted_at_topic_idx;


--
-- Name: messages_2026_02_02_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_02_02_pkey;


--
-- Name: messages_2026_02_03_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_02_03_inserted_at_topic_idx;


--
-- Name: messages_2026_02_03_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_02_03_pkey;


--
-- Name: messages_2026_02_04_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_02_04_inserted_at_topic_idx;


--
-- Name: messages_2026_02_04_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_02_04_pkey;


--
-- Name: messages_2026_02_05_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_02_05_inserted_at_topic_idx;


--
-- Name: messages_2026_02_05_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_02_05_pkey;


--
-- Name: messages_2026_02_06_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_02_06_inserted_at_topic_idx;


--
-- Name: messages_2026_02_06_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_02_06_pkey;


--
-- Name: messages_2026_02_07_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_02_07_inserted_at_topic_idx;


--
-- Name: messages_2026_02_07_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_02_07_pkey;


--
-- Name: messages_2026_02_08_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_02_08_inserted_at_topic_idx;


--
-- Name: messages_2026_02_08_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_02_08_pkey;


--
-- Name: messages_2026_02_11_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_02_11_inserted_at_topic_idx;


--
-- Name: messages_2026_02_11_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_02_11_pkey;


--
-- Name: messages_2026_02_12_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_02_12_inserted_at_topic_idx;


--
-- Name: messages_2026_02_12_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_02_12_pkey;


--
-- Name: messages_2026_02_13_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_02_13_inserted_at_topic_idx;


--
-- Name: messages_2026_02_13_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_02_13_pkey;


--
-- Name: messages_2026_02_14_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_02_14_inserted_at_topic_idx;


--
-- Name: messages_2026_02_14_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_02_14_pkey;


--
-- Name: messages_2026_02_15_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_02_15_inserted_at_topic_idx;


--
-- Name: messages_2026_02_15_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_02_15_pkey;


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Name: users set_participant_role_on_signup; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER set_participant_role_on_signup AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.auto_set_participant_role();


--
-- Name: users auto_link_application; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_link_application AFTER INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.auto_link_application_on_signup();


--
-- Name: applications check_auto_status; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER check_auto_status BEFORE UPDATE OF total_votes, approve_votes, reject_votes ON public.applications FOR EACH ROW EXECUTE FUNCTION public.check_auto_application_status();


--
-- Name: admin_todos handle_todo_completion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER handle_todo_completion BEFORE UPDATE ON public.admin_todos FOR EACH ROW WHEN ((old.status IS DISTINCT FROM new.status)) EXECUTE FUNCTION public.handle_todo_completion();


--
-- Name: admin_todos update_admin_todos_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_admin_todos_updated_at BEFORE UPDATE ON public.admin_todos FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: application_comments update_application_comments_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_application_comments_updated_at BEFORE UPDATE ON public.application_comments FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: application_votes update_application_votes_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_application_votes_updated_at BEFORE UPDATE ON public.application_votes FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: applications update_applications_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_applications_updated_at BEFORE UPDATE ON public.applications FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: blog_posts update_blog_posts_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_blog_posts_updated_at BEFORE UPDATE ON public.blog_posts FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: breakout_rooms update_breakout_rooms_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_breakout_rooms_updated_at BEFORE UPDATE ON public.breakout_rooms FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: comments update_comments_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_comments_updated_at BEFORE UPDATE ON public.comments FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: daily_reflections update_daily_reflections_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_daily_reflections_updated_at BEFORE UPDATE ON public.daily_reflections FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: tasks update_tasks_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_tasks_updated_at BEFORE UPDATE ON public.tasks FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: users update_users_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: application_votes update_vote_counts_on_delete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_vote_counts_on_delete AFTER DELETE ON public.application_votes FOR EACH ROW EXECUTE FUNCTION public.update_application_vote_counts();


--
-- Name: application_votes update_vote_counts_on_insert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_vote_counts_on_insert AFTER INSERT ON public.application_votes FOR EACH ROW EXECUTE FUNCTION public.update_application_vote_counts();


--
-- Name: application_votes update_vote_counts_on_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_vote_counts_on_update AFTER UPDATE ON public.application_votes FOR EACH ROW EXECUTE FUNCTION public.update_application_vote_counts();


--
-- Name: voting_config update_voting_config_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_voting_config_updated_at BEFORE UPDATE ON public.voting_config FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: admin_todo_comments admin_todo_comments_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_todo_comments
    ADD CONSTRAINT admin_todo_comments_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: admin_todo_comments admin_todo_comments_todo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_todo_comments
    ADD CONSTRAINT admin_todo_comments_todo_id_fkey FOREIGN KEY (todo_id) REFERENCES public.admin_todos(id) ON DELETE CASCADE;


--
-- Name: admin_todos admin_todos_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_todos
    ADD CONSTRAINT admin_todos_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: admin_todos admin_todos_completed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_todos
    ADD CONSTRAINT admin_todos_completed_by_fkey FOREIGN KEY (completed_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: admin_todos admin_todos_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_todos
    ADD CONSTRAINT admin_todos_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: application_comments application_comments_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_comments
    ADD CONSTRAINT application_comments_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.applications(id) ON DELETE CASCADE;


--
-- Name: application_comments application_comments_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_comments
    ADD CONSTRAINT application_comments_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: application_comments application_comments_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_comments
    ADD CONSTRAINT application_comments_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.application_comments(id) ON DELETE CASCADE;


--
-- Name: application_votes application_votes_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_votes
    ADD CONSTRAINT application_votes_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: application_votes application_votes_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_votes
    ADD CONSTRAINT application_votes_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.applications(id) ON DELETE CASCADE;


--
-- Name: applications applications_reviewed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_reviewed_by_fkey FOREIGN KEY (reviewed_by) REFERENCES public.users(id);


--
-- Name: applications applications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: blog_posts blog_posts_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: comments comments_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.comments(id);


--
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: daily_reflections daily_reflections_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_reflections
    ADD CONSTRAINT daily_reflections_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: invite_tokens invite_tokens_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invite_tokens
    ADD CONSTRAINT invite_tokens_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.applications(id) ON DELETE CASCADE;


--
-- Name: photo_gallery photo_gallery_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo_gallery
    ADD CONSTRAINT photo_gallery_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.breakout_rooms(id);


--
-- Name: photo_gallery photo_gallery_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo_gallery
    ADD CONSTRAINT photo_gallery_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: room_participants room_participants_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_participants
    ADD CONSTRAINT room_participants_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.breakout_rooms(id) ON DELETE CASCADE;


--
-- Name: room_participants room_participants_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_participants
    ADD CONSTRAINT room_participants_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: schema_iterations schema_iterations_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_iterations
    ADD CONSTRAINT schema_iterations_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: tasks tasks_assignee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_assignee_id_fkey FOREIGN KEY (assignee_id) REFERENCES public.users(id);


--
-- Name: tasks tasks_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: users users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: tasks Admins and assignees can update tasks; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins and assignees can update tasks" ON public.tasks FOR UPDATE TO authenticated USING (((assignee_id = ( SELECT auth.uid() AS uid)) OR public.is_admin())) WITH CHECK (((assignee_id = ( SELECT auth.uid() AS uid)) OR public.is_admin()));


--
-- Name: application_comments Admins can create comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can create comments" ON public.application_comments FOR INSERT TO authenticated WITH CHECK ((public.is_admin() AND (author_id = ( SELECT auth.uid() AS uid))));


--
-- Name: invite_tokens Admins can create invite tokens; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can create invite tokens" ON public.invite_tokens FOR INSERT TO authenticated WITH CHECK (public.is_admin());


--
-- Name: blog_posts Admins can create posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can create posts" ON public.blog_posts FOR INSERT TO authenticated WITH CHECK (public.is_admin());


--
-- Name: tasks Admins can create tasks; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can create tasks" ON public.tasks FOR INSERT TO authenticated WITH CHECK (public.is_admin());


--
-- Name: admin_todo_comments Admins can create todo comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can create todo comments" ON public.admin_todo_comments FOR INSERT TO authenticated WITH CHECK ((public.is_admin() AND (author_id = ( SELECT auth.uid() AS uid))));


--
-- Name: admin_todos Admins can create todos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can create todos" ON public.admin_todos FOR INSERT TO authenticated WITH CHECK ((public.is_admin() AND (created_by = ( SELECT auth.uid() AS uid))));


--
-- Name: application_votes Admins can create votes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can create votes" ON public.application_votes FOR INSERT WITH CHECK ((public.is_admin() AND (admin_id = ( SELECT auth.uid() AS uid))));


--
-- Name: applications Admins can delete applications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete applications" ON public.applications FOR DELETE TO authenticated USING (public.is_admin());


--
-- Name: application_votes Admins can delete own votes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete own votes" ON public.application_votes FOR DELETE USING ((public.is_admin() AND (admin_id = ( SELECT auth.uid() AS uid))));


--
-- Name: admin_todos Admins can delete todos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete todos" ON public.admin_todos FOR DELETE TO authenticated USING (public.is_admin());


--
-- Name: room_participants Admins can manage room participants; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage room participants" ON public.room_participants TO authenticated USING (public.is_admin()) WITH CHECK (public.is_admin());


--
-- Name: breakout_rooms Admins can manage rooms; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage rooms" ON public.breakout_rooms TO authenticated USING (public.is_admin()) WITH CHECK (public.is_admin());


--
-- Name: applications Admins can update applications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update applications" ON public.applications FOR UPDATE TO authenticated USING (public.is_admin()) WITH CHECK (public.is_admin());


--
-- Name: invite_tokens Admins can update invite tokens; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update invite tokens" ON public.invite_tokens FOR UPDATE TO authenticated USING (public.is_admin()) WITH CHECK (public.is_admin());


--
-- Name: application_votes Admins can update own votes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update own votes" ON public.application_votes FOR UPDATE USING ((public.is_admin() AND (admin_id = ( SELECT auth.uid() AS uid)))) WITH CHECK ((public.is_admin() AND (admin_id = ( SELECT auth.uid() AS uid))));


--
-- Name: admin_todos Admins can update todos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update todos" ON public.admin_todos FOR UPDATE TO authenticated USING (public.is_admin()) WITH CHECK (public.is_admin());


--
-- Name: voting_config Admins can update voting config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update voting config" ON public.voting_config FOR UPDATE USING (public.is_admin()) WITH CHECK (public.is_admin());


--
-- Name: applications Admins can view all applications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all applications" ON public.applications FOR SELECT TO authenticated USING (public.is_admin());


--
-- Name: invite_tokens Admins can view all invite tokens; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all invite tokens" ON public.invite_tokens FOR SELECT TO authenticated USING (public.is_admin());


--
-- Name: blog_posts Admins can view all posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all posts" ON public.blog_posts FOR SELECT TO authenticated USING (public.is_admin());


--
-- Name: tasks Admins can view all tasks; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all tasks" ON public.tasks FOR SELECT TO authenticated USING (public.is_admin());


--
-- Name: admin_todos Admins can view all todos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all todos" ON public.admin_todos FOR SELECT TO authenticated USING (public.is_admin());


--
-- Name: application_votes Admins can view all votes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all votes" ON public.application_votes FOR SELECT USING (public.is_admin());


--
-- Name: admin_todo_comments Admins can view todo comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view todo comments" ON public.admin_todo_comments FOR SELECT TO authenticated USING (public.is_admin());


--
-- Name: voting_config Admins can view voting config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view voting config" ON public.voting_config FOR SELECT USING (public.is_admin());


--
-- Name: applications Anyone can create applications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can create applications" ON public.applications FOR INSERT WITH CHECK (((email IS NOT NULL) AND ((user_id IS NULL) OR (user_id = ( SELECT auth.uid() AS uid)))));


--
-- Name: blog_posts Anyone can view published posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can view published posts" ON public.blog_posts FOR SELECT USING ((published = true));


--
-- Name: comments Authenticated can create comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated can create comments" ON public.comments FOR INSERT TO authenticated WITH CHECK ((user_id = ( SELECT auth.uid() AS uid)));


--
-- Name: comments Authenticated can view comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated can view comments" ON public.comments FOR SELECT TO authenticated USING (true);


--
-- Name: blog_posts Authors and admins can update posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authors and admins can update posts" ON public.blog_posts FOR UPDATE TO authenticated USING (((author_id = ( SELECT auth.uid() AS uid)) OR public.is_admin())) WITH CHECK (((author_id = ( SELECT auth.uid() AS uid)) OR public.is_admin()));


--
-- Name: admin_todo_comments Authors can delete own todo comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authors can delete own todo comments" ON public.admin_todo_comments FOR DELETE TO authenticated USING ((public.is_admin() AND (author_id = ( SELECT auth.uid() AS uid))));


--
-- Name: application_comments Authors can soft-delete own comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authors can soft-delete own comments" ON public.application_comments FOR UPDATE USING (((author_id = ( SELECT auth.uid() AS uid)) AND (deleted_at IS NULL))) WITH CHECK ((author_id = ( SELECT auth.uid() AS uid)));


--
-- Name: application_comments Authors can update own recent comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authors can update own recent comments" ON public.application_comments FOR UPDATE USING (((author_id = ( SELECT auth.uid() AS uid)) AND (created_at > (now() - '00:15:00'::interval)) AND (deleted_at IS NULL))) WITH CHECK (((author_id = ( SELECT auth.uid() AS uid)) AND (created_at > (now() - '00:15:00'::interval)) AND (deleted_at IS NULL)));


--
-- Name: admin_todo_comments Authors can update own recent todo comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authors can update own recent todo comments" ON public.admin_todo_comments FOR UPDATE TO authenticated USING ((public.is_admin() AND (author_id = ( SELECT auth.uid() AS uid)) AND (created_at > (now() - '00:15:00'::interval)))) WITH CHECK ((public.is_admin() AND (author_id = ( SELECT auth.uid() AS uid))));


--
-- Name: blog_posts Authors can view own posts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authors can view own posts" ON public.blog_posts FOR SELECT TO authenticated USING ((author_id = ( SELECT auth.uid() AS uid)));


--
-- Name: schema_iterations Creators and admins can update schemas; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Creators and admins can update schemas" ON public.schema_iterations FOR UPDATE TO authenticated USING (((created_by = ( SELECT auth.uid() AS uid)) OR public.is_admin())) WITH CHECK (((created_by = ( SELECT auth.uid() AS uid)) OR public.is_admin()));


--
-- Name: schema_iterations Participants can create schemas; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Participants can create schemas" ON public.schema_iterations FOR INSERT TO authenticated WITH CHECK (((created_by = ( SELECT auth.uid() AS uid)) AND (public.auth_role() = ANY (ARRAY['participant'::text, 'admin'::text]))));


--
-- Name: breakout_rooms Participants can view assigned rooms; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Participants can view assigned rooms" ON public.breakout_rooms FOR SELECT TO authenticated USING (((active = true) AND ((id IN ( SELECT room_participants.room_id
   FROM public.room_participants
  WHERE (room_participants.user_id = ( SELECT auth.uid() AS uid)))) OR public.is_admin())));


--
-- Name: photo_gallery Participants can view photos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Participants can view photos" ON public.photo_gallery FOR SELECT TO authenticated USING ((public.auth_role() = ANY (ARRAY['participant'::text, 'admin'::text])));


--
-- Name: schema_iterations Participants can view schemas; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Participants can view schemas" ON public.schema_iterations FOR SELECT TO authenticated USING ((public.auth_role() = ANY (ARRAY['participant'::text, 'admin'::text])));


--
-- Name: daily_reflections Participants can view shared reflections; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Participants can view shared reflections" ON public.daily_reflections FOR SELECT TO authenticated USING ((public.auth_role() = ANY (ARRAY['participant'::text, 'admin'::text])));


--
-- Name: invite_tokens Public can validate tokens; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Public can validate tokens" ON public.invite_tokens FOR SELECT TO anon USING (((NOT used) AND (expires_at > now())));


--
-- Name: daily_reflections Users can create own reflections; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create own reflections" ON public.daily_reflections FOR INSERT TO authenticated WITH CHECK (((user_id = ( SELECT auth.uid() AS uid)) AND (public.auth_role() = ANY (ARRAY['participant'::text, 'admin'::text]))));


--
-- Name: comments Users can delete own comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete own comments" ON public.comments FOR DELETE TO authenticated USING (((user_id = ( SELECT auth.uid() AS uid)) OR public.is_admin()));


--
-- Name: photo_gallery Users can delete own photos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete own photos" ON public.photo_gallery FOR DELETE TO authenticated USING (((user_id = ( SELECT auth.uid() AS uid)) OR public.is_admin()));


--
-- Name: comments Users can update own comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own comments" ON public.comments FOR UPDATE TO authenticated USING ((user_id = ( SELECT auth.uid() AS uid))) WITH CHECK ((user_id = ( SELECT auth.uid() AS uid)));


--
-- Name: applications Users can update own pending applications by email or user_id; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own pending applications by email or user_id" ON public.applications FOR UPDATE USING (((status = 'pending'::public.application_status) AND (((user_id IS NOT NULL) AND (user_id = ( SELECT auth.uid() AS uid))) OR public.is_admin()))) WITH CHECK (((status = 'pending'::public.application_status) AND (((user_id IS NOT NULL) AND (user_id = ( SELECT auth.uid() AS uid))) OR public.is_admin())));


--
-- Name: photo_gallery Users can update own photos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own photos" ON public.photo_gallery FOR UPDATE TO authenticated USING ((user_id = ( SELECT auth.uid() AS uid))) WITH CHECK ((user_id = ( SELECT auth.uid() AS uid)));


--
-- Name: daily_reflections Users can update own reflections; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own reflections" ON public.daily_reflections FOR UPDATE TO authenticated USING ((user_id = ( SELECT auth.uid() AS uid))) WITH CHECK ((user_id = ( SELECT auth.uid() AS uid)));


--
-- Name: photo_gallery Users can upload photos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can upload photos" ON public.photo_gallery FOR INSERT TO authenticated WITH CHECK (((user_id = ( SELECT auth.uid() AS uid)) AND (public.auth_role() = ANY (ARRAY['participant'::text, 'admin'::text]))));


--
-- Name: tasks Users can view assigned tasks; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view assigned tasks" ON public.tasks FOR SELECT TO authenticated USING (((assignee_id = ( SELECT auth.uid() AS uid)) OR (created_by = ( SELECT auth.uid() AS uid))));


--
-- Name: applications Users can view own applications by email or user_id; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own applications by email or user_id" ON public.applications FOR SELECT USING ((public.is_admin() OR ((user_id IS NOT NULL) AND (user_id = ( SELECT auth.uid() AS uid))) OR (email IS NOT NULL)));


--
-- Name: daily_reflections Users can view own reflections; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own reflections" ON public.daily_reflections FOR SELECT TO authenticated USING ((user_id = ( SELECT auth.uid() AS uid)));


--
-- Name: room_participants Users can view room participants; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view room participants" ON public.room_participants FOR SELECT TO authenticated USING (((room_id IN ( SELECT room_participants_1.room_id
   FROM public.room_participants room_participants_1
  WHERE (room_participants_1.user_id = ( SELECT auth.uid() AS uid)))) OR public.is_admin()));


--
-- Name: admin_todo_comments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.admin_todo_comments ENABLE ROW LEVEL SECURITY;

--
-- Name: admin_todos; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.admin_todos ENABLE ROW LEVEL SECURITY;

--
-- Name: application_comments admin_view_comments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admin_view_comments ON public.application_comments FOR SELECT TO authenticated USING (public.is_admin());


--
-- Name: users admins_all_access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admins_all_access ON public.users TO authenticated USING (public.is_admin()) WITH CHECK (public.is_admin());


--
-- Name: application_comments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.application_comments ENABLE ROW LEVEL SECURITY;

--
-- Name: application_votes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.application_votes ENABLE ROW LEVEL SECURITY;

--
-- Name: applications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.applications ENABLE ROW LEVEL SECURITY;

--
-- Name: blog_posts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.blog_posts ENABLE ROW LEVEL SECURITY;

--
-- Name: breakout_rooms; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.breakout_rooms ENABLE ROW LEVEL SECURITY;

--
-- Name: comments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY;

--
-- Name: daily_reflections; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.daily_reflections ENABLE ROW LEVEL SECURITY;

--
-- Name: invite_tokens; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.invite_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: photo_gallery; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.photo_gallery ENABLE ROW LEVEL SECURITY;

--
-- Name: room_participants; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.room_participants ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_iterations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.schema_iterations ENABLE ROW LEVEL SECURITY;

--
-- Name: tasks; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

--
-- Name: users users_update_own; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY users_update_own ON public.users FOR UPDATE TO authenticated USING ((auth.uid() = id)) WITH CHECK ((auth.uid() = id));


--
-- Name: users users_view_own; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY users_view_own ON public.users FOR SELECT TO authenticated USING ((auth.uid() = id));


--
-- Name: voting_config; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.voting_config ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: supabase_realtime_messages_publication; Type: PUBLICATION; Schema: -; Owner: supabase_admin
--

CREATE PUBLICATION supabase_realtime_messages_publication WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime_messages_publication OWNER TO supabase_admin;

--
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;


--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION auth_role(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.auth_role() TO anon;
GRANT ALL ON FUNCTION public.auth_role() TO authenticated;
GRANT ALL ON FUNCTION public.auth_role() TO service_role;


--
-- Name: FUNCTION auto_link_application_on_signup(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.auto_link_application_on_signup() TO anon;
GRANT ALL ON FUNCTION public.auto_link_application_on_signup() TO authenticated;
GRANT ALL ON FUNCTION public.auto_link_application_on_signup() TO service_role;


--
-- Name: FUNCTION auto_set_participant_role(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.auto_set_participant_role() TO anon;
GRANT ALL ON FUNCTION public.auto_set_participant_role() TO authenticated;
GRANT ALL ON FUNCTION public.auto_set_participant_role() TO service_role;


--
-- Name: FUNCTION check_auto_application_status(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.check_auto_application_status() TO anon;
GRANT ALL ON FUNCTION public.check_auto_application_status() TO authenticated;
GRANT ALL ON FUNCTION public.check_auto_application_status() TO service_role;


--
-- Name: FUNCTION check_invite_token(p_token character varying, p_email character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.check_invite_token(p_token character varying, p_email character varying) TO anon;
GRANT ALL ON FUNCTION public.check_invite_token(p_token character varying, p_email character varying) TO authenticated;
GRANT ALL ON FUNCTION public.check_invite_token(p_token character varying, p_email character varying) TO service_role;


--
-- Name: FUNCTION debug_jwt(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.debug_jwt() TO anon;
GRANT ALL ON FUNCTION public.debug_jwt() TO authenticated;
GRANT ALL ON FUNCTION public.debug_jwt() TO service_role;


--
-- Name: FUNCTION generate_invite_token(p_application_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.generate_invite_token(p_application_id uuid) TO anon;
GRANT ALL ON FUNCTION public.generate_invite_token(p_application_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.generate_invite_token(p_application_id uuid) TO service_role;


--
-- Name: FUNCTION get_admin_users(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_admin_users() TO anon;
GRANT ALL ON FUNCTION public.get_admin_users() TO authenticated;
GRANT ALL ON FUNCTION public.get_admin_users() TO service_role;


--
-- Name: FUNCTION get_application_comments(p_application_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_application_comments(p_application_id uuid) TO anon;
GRANT ALL ON FUNCTION public.get_application_comments(p_application_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.get_application_comments(p_application_id uuid) TO service_role;


--
-- Name: FUNCTION get_voting_statistics(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_voting_statistics() TO anon;
GRANT ALL ON FUNCTION public.get_voting_statistics() TO authenticated;
GRANT ALL ON FUNCTION public.get_voting_statistics() TO service_role;


--
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- Name: FUNCTION handle_todo_completion(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_todo_completion() TO anon;
GRANT ALL ON FUNCTION public.handle_todo_completion() TO authenticated;
GRANT ALL ON FUNCTION public.handle_todo_completion() TO service_role;


--
-- Name: FUNCTION is_admin(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.is_admin() TO anon;
GRANT ALL ON FUNCTION public.is_admin() TO authenticated;
GRANT ALL ON FUNCTION public.is_admin() TO service_role;


--
-- Name: FUNCTION is_user_admin(user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.is_user_admin(user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.is_user_admin(user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.is_user_admin(user_id uuid) TO service_role;


--
-- Name: FUNCTION link_application_to_user(p_email text, p_user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.link_application_to_user(p_email text, p_user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.link_application_to_user(p_email text, p_user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.link_application_to_user(p_email text, p_user_id uuid) TO service_role;


--
-- Name: FUNCTION mark_invite_token_used(p_token character varying, p_email character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.mark_invite_token_used(p_token character varying, p_email character varying) TO anon;
GRANT ALL ON FUNCTION public.mark_invite_token_used(p_token character varying, p_email character varying) TO authenticated;
GRANT ALL ON FUNCTION public.mark_invite_token_used(p_token character varying, p_email character varying) TO service_role;


--
-- Name: FUNCTION set_participant_role(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.set_participant_role() TO anon;
GRANT ALL ON FUNCTION public.set_participant_role() TO authenticated;
GRANT ALL ON FUNCTION public.set_participant_role() TO service_role;


--
-- Name: FUNCTION update_application_vote_counts(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_application_vote_counts() TO anon;
GRANT ALL ON FUNCTION public.update_application_vote_counts() TO authenticated;
GRANT ALL ON FUNCTION public.update_application_vote_counts() TO service_role;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_updated_at_column() TO anon;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO service_role;


--
-- Name: FUNCTION validate_invite_token(p_token character varying, p_email character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.validate_invite_token(p_token character varying, p_email character varying) TO anon;
GRANT ALL ON FUNCTION public.validate_invite_token(p_token character varying, p_email character varying) TO authenticated;
GRANT ALL ON FUNCTION public.validate_invite_token(p_token character varying, p_email character varying) TO service_role;


--
-- Name: FUNCTION validate_work_links(links jsonb); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.validate_work_links(links jsonb) TO anon;
GRANT ALL ON FUNCTION public.validate_work_links(links jsonb) TO authenticated;
GRANT ALL ON FUNCTION public.validate_work_links(links jsonb) TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE admin_todo_comments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.admin_todo_comments TO anon;
GRANT ALL ON TABLE public.admin_todo_comments TO authenticated;
GRANT ALL ON TABLE public.admin_todo_comments TO service_role;


--
-- Name: TABLE admin_todos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.admin_todos TO anon;
GRANT ALL ON TABLE public.admin_todos TO authenticated;
GRANT ALL ON TABLE public.admin_todos TO service_role;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO anon;
GRANT ALL ON TABLE public.users TO authenticated;
GRANT ALL ON TABLE public.users TO service_role;


--
-- Name: TABLE admin_todos_with_users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.admin_todos_with_users TO anon;
GRANT ALL ON TABLE public.admin_todos_with_users TO authenticated;
GRANT ALL ON TABLE public.admin_todos_with_users TO service_role;


--
-- Name: TABLE application_comments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.application_comments TO anon;
GRANT ALL ON TABLE public.application_comments TO authenticated;
GRANT ALL ON TABLE public.application_comments TO service_role;


--
-- Name: TABLE application_votes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.application_votes TO anon;
GRANT ALL ON TABLE public.application_votes TO authenticated;
GRANT ALL ON TABLE public.application_votes TO service_role;


--
-- Name: TABLE applications; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.applications TO anon;
GRANT ALL ON TABLE public.applications TO authenticated;
GRANT ALL ON TABLE public.applications TO service_role;


--
-- Name: TABLE application_voting_summary; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.application_voting_summary TO anon;
GRANT ALL ON TABLE public.application_voting_summary TO authenticated;
GRANT ALL ON TABLE public.application_voting_summary TO service_role;


--
-- Name: TABLE blog_posts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.blog_posts TO anon;
GRANT ALL ON TABLE public.blog_posts TO authenticated;
GRANT ALL ON TABLE public.blog_posts TO service_role;


--
-- Name: TABLE breakout_rooms; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.breakout_rooms TO anon;
GRANT ALL ON TABLE public.breakout_rooms TO authenticated;
GRANT ALL ON TABLE public.breakout_rooms TO service_role;


--
-- Name: TABLE comments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.comments TO anon;
GRANT ALL ON TABLE public.comments TO authenticated;
GRANT ALL ON TABLE public.comments TO service_role;


--
-- Name: TABLE daily_reflections; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.daily_reflections TO anon;
GRANT ALL ON TABLE public.daily_reflections TO authenticated;
GRANT ALL ON TABLE public.daily_reflections TO service_role;


--
-- Name: TABLE invite_tokens; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.invite_tokens TO anon;
GRANT ALL ON TABLE public.invite_tokens TO authenticated;
GRANT ALL ON TABLE public.invite_tokens TO service_role;


--
-- Name: TABLE photo_gallery; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.photo_gallery TO anon;
GRANT ALL ON TABLE public.photo_gallery TO authenticated;
GRANT ALL ON TABLE public.photo_gallery TO service_role;


--
-- Name: TABLE room_participants; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.room_participants TO anon;
GRANT ALL ON TABLE public.room_participants TO authenticated;
GRANT ALL ON TABLE public.room_participants TO service_role;


--
-- Name: TABLE schema_iterations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.schema_iterations TO anon;
GRANT ALL ON TABLE public.schema_iterations TO authenticated;
GRANT ALL ON TABLE public.schema_iterations TO service_role;


--
-- Name: TABLE tasks; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tasks TO anon;
GRANT ALL ON TABLE public.tasks TO authenticated;
GRANT ALL ON TABLE public.tasks TO service_role;


--
-- Name: TABLE voting_config; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.voting_config TO anon;
GRANT ALL ON TABLE public.voting_config TO authenticated;
GRANT ALL ON TABLE public.voting_config TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE messages_2026_02_02; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_02_02 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_02_02 TO dashboard_user;


--
-- Name: TABLE messages_2026_02_03; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_02_03 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_02_03 TO dashboard_user;


--
-- Name: TABLE messages_2026_02_04; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_02_04 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_02_04 TO dashboard_user;


--
-- Name: TABLE messages_2026_02_05; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_02_05 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_02_05 TO dashboard_user;


--
-- Name: TABLE messages_2026_02_06; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_02_06 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_02_06 TO dashboard_user;


--
-- Name: TABLE messages_2026_02_07; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_02_07 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_02_07 TO dashboard_user;


--
-- Name: TABLE messages_2026_02_08; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_02_08 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_02_08 TO dashboard_user;


--
-- Name: TABLE messages_2026_02_11; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_02_11 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_02_11 TO dashboard_user;


--
-- Name: TABLE messages_2026_02_12; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_02_12 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_02_12 TO dashboard_user;


--
-- Name: TABLE messages_2026_02_13; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_02_13 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_02_13 TO dashboard_user;


--
-- Name: TABLE messages_2026_02_14; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_02_14 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_02_14 TO dashboard_user;


--
-- Name: TABLE messages_2026_02_15; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_02_15 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_02_15 TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.buckets FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.buckets TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.objects FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.objects TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict MKYApoYD2MLMqHqnDStBgHa5RQflXYE6DOic0GzDzBJGVYi6BvtDOfY3HER1GED

