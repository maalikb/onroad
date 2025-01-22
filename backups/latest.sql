--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE admin;
ALTER ROLE admin WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:0BFJqvr+pcHSADz1mft8hw==$8AZQvAxPcwo8LhVQxFoesA+l0mDdm4mNzDbHTIxBIKQ=:zfr2a30HI7AX4NBZ1RPxhIxSyCWVPJuVQ1PFZ8T45r4=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg110+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg110+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- Database "onroad" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg110+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg110+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: onroad; Type: DATABASE; Schema: -; Owner: admin
--

CREATE DATABASE onroad WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE onroad OWNER TO admin;

\connect onroad

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: onroad; Type: DATABASE PROPERTIES; Schema: -; Owner: admin
--

ALTER DATABASE onroad SET search_path TO '$user', 'public', 'topology', 'tiger';


\connect onroad

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: hdb_catalog; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA hdb_catalog;


ALTER SCHEMA hdb_catalog OWNER TO admin;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO admin;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO admin;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO admin;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: admin
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- Name: gen_hasura_uuid(); Type: FUNCTION; Schema: hdb_catalog; Owner: admin
--

CREATE FUNCTION hdb_catalog.gen_hasura_uuid() RETURNS uuid
    LANGUAGE sql
    AS $$select gen_random_uuid()$$;


ALTER FUNCTION hdb_catalog.gen_hasura_uuid() OWNER TO admin;

--
-- Name: generate_slug(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.generate_slug() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
-- Generate the kebab case slug from the name field
NEW.slug := lower(regexp_replace(NEW.name, '[^\w\s]', '', 'g'));
NEW.slug := regexp_replace(NEW.slug, '\s+', '-', 'g');
-- Append a 10-character hex for uniqueness
NEW.slug := NEW.slug || '-' || substring(md5(random()::text), 1, 10);
RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_slug() OWNER TO admin;

--
-- Name: update_contribution_total(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.update_contribution_total() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Update the total and set status to 'pending' for the affected contribution
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        UPDATE contributions
        SET total = COALESCE(
            (SELECT SUM(CASE WHEN p.type = 'DB' THEN cpi.value ELSE -cpi.value END)
             FROM contribution_price_items cpi
             JOIN price_items p ON cpi.price_item_id = p.id
             WHERE cpi.contribution_id = NEW.contribution_id),
            0),
            status = 'PD'  -- Set status as pending
        WHERE id = NEW.contribution_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE contributions
        SET total = COALESCE(
            (SELECT SUM(CASE WHEN p.type = 'DB' THEN cpi.value ELSE -cpi.value END)
             FROM contribution_price_items cpi
             JOIN price_items p ON cpi.price_item_id = p.id
             WHERE cpi.contribution_id = OLD.contribution_id),
            0),
            status = 'PD'  -- Set status as pending
        WHERE id = OLD.contribution_id;
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.update_contribution_total() OWNER TO admin;

--
-- Name: update_contribution_votes(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.update_contribution_votes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE contributions
        SET upvotes = upvotes + CASE WHEN NEW.type = 'UP' THEN 1 ELSE 0 END,
            downvotes = downvotes + CASE WHEN NEW.type = 'DN' THEN 1 ELSE 0 END
        WHERE id = NEW.contribution_id;
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE contributions
        SET upvotes = upvotes + CASE WHEN NEW.type = 'UP' THEN 1 ELSE 0 END - CASE WHEN OLD.type = 'UP' THEN 1 ELSE 0 END,
            downvotes = downvotes + CASE WHEN NEW.type = 'DN' THEN 1 ELSE 0 END - CASE WHEN OLD.type = 'DN' THEN 1 ELSE 0 END
        WHERE id = NEW.contribution_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE contributions
        SET upvotes = upvotes - CASE WHEN OLD.type = 'UP' THEN 1 ELSE 0 END,
            downvotes = downvotes - CASE WHEN OLD.type = 'DN' THEN 1 ELSE 0 END
        WHERE id = OLD.contribution_id;
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.update_contribution_votes() OWNER TO admin;

--
-- Name: update_make_code(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.update_make_code() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if the code is already provided by the user
    IF NEW.code IS NULL THEN
        -- If not, generate the code from the first three characters of the capitalized name
        NEW.code = UPPER(SUBSTRING(NEW.name FROM 1 FOR 3));
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_make_code() OWNER TO admin;

--
-- Name: update_user_contributions(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.update_user_contributions() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if the user has any contributions after INSERT or UPDATE
    IF TG_OP = 'DELETE' THEN
        UPDATE users
        SET has_contributed = EXISTS (SELECT 1 FROM contributions WHERE user_id = OLD.user_id)
        WHERE id = OLD.user_id;
    ELSE
        UPDATE users
        SET has_contributed = EXISTS (SELECT 1 FROM contributions WHERE user_id = NEW.user_id)
        WHERE id = NEW.user_id;
    END IF;

    RETURN NULL;
END;
$$;


ALTER FUNCTION public.update_user_contributions() OWNER TO admin;

--
-- Name: update_vehicle_code(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.update_vehicle_code() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if the code is already provided by the user
    IF NEW.code IS NULL THEN
        -- If not, generate the code from the first three characters of the capitalized name
        NEW.code = UPPER(SUBSTRING(NEW.name FROM 1 FOR 3));
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_vehicle_code() OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: hdb_action_log; Type: TABLE; Schema: hdb_catalog; Owner: admin
--

CREATE TABLE hdb_catalog.hdb_action_log (
    id uuid DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    action_name text,
    input_payload jsonb NOT NULL,
    request_headers jsonb NOT NULL,
    session_variables jsonb NOT NULL,
    response_payload jsonb,
    errors jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    response_received_at timestamp with time zone,
    status text NOT NULL,
    CONSTRAINT hdb_action_log_status_check CHECK ((status = ANY (ARRAY['created'::text, 'processing'::text, 'completed'::text, 'error'::text])))
);


ALTER TABLE hdb_catalog.hdb_action_log OWNER TO admin;

--
-- Name: hdb_cron_event_invocation_logs; Type: TABLE; Schema: hdb_catalog; Owner: admin
--

CREATE TABLE hdb_catalog.hdb_cron_event_invocation_logs (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    event_id text,
    status integer,
    request json,
    response json,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE hdb_catalog.hdb_cron_event_invocation_logs OWNER TO admin;

--
-- Name: hdb_cron_events; Type: TABLE; Schema: hdb_catalog; Owner: admin
--

CREATE TABLE hdb_catalog.hdb_cron_events (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    trigger_name text NOT NULL,
    scheduled_time timestamp with time zone NOT NULL,
    status text DEFAULT 'scheduled'::text NOT NULL,
    tries integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    next_retry_at timestamp with time zone,
    CONSTRAINT valid_status CHECK ((status = ANY (ARRAY['scheduled'::text, 'locked'::text, 'delivered'::text, 'error'::text, 'dead'::text])))
);


ALTER TABLE hdb_catalog.hdb_cron_events OWNER TO admin;

--
-- Name: hdb_metadata; Type: TABLE; Schema: hdb_catalog; Owner: admin
--

CREATE TABLE hdb_catalog.hdb_metadata (
    id integer NOT NULL,
    metadata json NOT NULL,
    resource_version integer DEFAULT 1 NOT NULL
);


ALTER TABLE hdb_catalog.hdb_metadata OWNER TO admin;

--
-- Name: hdb_scheduled_event_invocation_logs; Type: TABLE; Schema: hdb_catalog; Owner: admin
--

CREATE TABLE hdb_catalog.hdb_scheduled_event_invocation_logs (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    event_id text,
    status integer,
    request json,
    response json,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE hdb_catalog.hdb_scheduled_event_invocation_logs OWNER TO admin;

--
-- Name: hdb_scheduled_events; Type: TABLE; Schema: hdb_catalog; Owner: admin
--

CREATE TABLE hdb_catalog.hdb_scheduled_events (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    webhook_conf json NOT NULL,
    scheduled_time timestamp with time zone NOT NULL,
    retry_conf json,
    payload json,
    header_conf json,
    status text DEFAULT 'scheduled'::text NOT NULL,
    tries integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    next_retry_at timestamp with time zone,
    comment text,
    CONSTRAINT valid_status CHECK ((status = ANY (ARRAY['scheduled'::text, 'locked'::text, 'delivered'::text, 'error'::text, 'dead'::text])))
);


ALTER TABLE hdb_catalog.hdb_scheduled_events OWNER TO admin;

--
-- Name: hdb_schema_notifications; Type: TABLE; Schema: hdb_catalog; Owner: admin
--

CREATE TABLE hdb_catalog.hdb_schema_notifications (
    id integer NOT NULL,
    notification json NOT NULL,
    resource_version integer DEFAULT 1 NOT NULL,
    instance_id uuid NOT NULL,
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT hdb_schema_notifications_id_check CHECK ((id = 1))
);


ALTER TABLE hdb_catalog.hdb_schema_notifications OWNER TO admin;

--
-- Name: hdb_version; Type: TABLE; Schema: hdb_catalog; Owner: admin
--

CREATE TABLE hdb_catalog.hdb_version (
    hasura_uuid uuid DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    version text NOT NULL,
    upgraded_on timestamp with time zone NOT NULL,
    cli_state jsonb DEFAULT '{}'::jsonb NOT NULL,
    console_state jsonb DEFAULT '{}'::jsonb NOT NULL,
    ee_client_id text,
    ee_client_secret text
);


ALTER TABLE hdb_catalog.hdb_version OWNER TO admin;

--
-- Name: attachments; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.attachments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    url character varying(200) NOT NULL,
    mime_type character varying(50) NOT NULL,
    size integer,
    created_by_id uuid NOT NULL,
    etag character varying(255),
    key character varying(255),
    created_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    updated_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    CONSTRAINT attachments_size_check CHECK ((size >= 0))
);


ALTER TABLE public.attachments OWNER TO admin;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO admin;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO admin;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO admin;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cities; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.cities (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(15),
    state_id uuid NOT NULL
);


ALTER TABLE public.cities OWNER TO admin;

--
-- Name: contribution_price_items; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.contribution_price_items (
    created_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    updated_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    serial_no smallint DEFAULT 1 NOT NULL,
    value numeric(10,2) NOT NULL,
    contribution_id uuid NOT NULL,
    price_item_id uuid NOT NULL,
    CONSTRAINT contribution_price_items_serial_no_check CHECK ((serial_no >= 0)),
    CONSTRAINT contribution_value_non_negative CHECK ((value >= (0)::numeric))
);


ALTER TABLE public.contribution_price_items OWNER TO admin;

--
-- Name: contributions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.contributions (
    created_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    updated_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    status character varying(2) DEFAULT 'PD'::character varying NOT NULL,
    quoted_on date NOT NULL,
    dealership_name character varying(255) NOT NULL,
    total numeric(10,2) DEFAULT 0 NOT NULL,
    upvotes integer DEFAULT 0 NOT NULL,
    downvotes integer DEFAULT 0 NOT NULL,
    remark text,
    city_id uuid NOT NULL,
    user_id uuid NOT NULL,
    variant_id uuid NOT NULL,
    color_id uuid
);


ALTER TABLE public.contributions OWNER TO admin;

--
-- Name: contributions_attachments; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.contributions_attachments (
    id bigint NOT NULL,
    contribution_id uuid NOT NULL,
    attachment_id uuid NOT NULL
);


ALTER TABLE public.contributions_attachments OWNER TO admin;

--
-- Name: contributions_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.contributions_attachments ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.contributions_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: countries; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.countries (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(15)
);


ALTER TABLE public.countries OWNER TO admin;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id uuid NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO admin;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO admin;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_dramatiq_task; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.django_dramatiq_task (
    id uuid NOT NULL,
    status character varying(8) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    message_data bytea NOT NULL,
    actor_name character varying(300),
    queue_name character varying(100)
);


ALTER TABLE public.django_dramatiq_task OWNER TO admin;

--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO admin;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO admin;

--
-- Name: makes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.makes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    estb_year smallint,
    code character varying(3) NOT NULL
);


ALTER TABLE public.makes OWNER TO admin;

--
-- Name: price_items; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.price_items (
    created_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    updated_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    category character varying(3) NOT NULL,
    type character varying(2) NOT NULL,
    serial_no smallint DEFAULT 1 NOT NULL,
    CONSTRAINT price_items_serial_no_check CHECK ((serial_no >= 0))
);


ALTER TABLE public.price_items OWNER TO admin;

--
-- Name: states; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.states (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(15),
    country_id uuid NOT NULL
);


ALTER TABLE public.states OWNER TO admin;

--
-- Name: user_passkeys; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_passkeys (
    created_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    updated_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    public_key bytea NOT NULL,
    credential_id bytea NOT NULL,
    description text,
    user_id uuid NOT NULL,
    name character varying(64)
);


ALTER TABLE public.user_passkeys OWNER TO admin;

--
-- Name: user_tokens; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_tokens (
    created_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    updated_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    token character varying(255) DEFAULT gen_random_uuid() NOT NULL,
    used boolean NOT NULL,
    expires_at timestamp with time zone,
    type character varying(2) DEFAULT 'VC'::character varying NOT NULL,
    user_id uuid NOT NULL,
    client character varying(255) DEFAULT 'web'::character varying NOT NULL,
    description text
);


ALTER TABLE public.user_tokens OWNER TO admin;

--
-- Name: users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users (
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(255) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    updated_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    avatar character varying(100),
    google_id character varying(255),
    apple_id character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    email character varying(254) NOT NULL,
    email_verified boolean NOT NULL,
    has_contributed boolean NOT NULL,
    city_id uuid
);


ALTER TABLE public.users OWNER TO admin;

--
-- Name: users_groups; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users_groups (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.users_groups OWNER TO admin;

--
-- Name: users_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.users_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_user_permissions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users_user_permissions (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.users_user_permissions OWNER TO admin;

--
-- Name: users_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.users_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: variant_colors; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.variant_colors (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    hex_code character varying(7),
    variant_id uuid NOT NULL
);


ALTER TABLE public.variant_colors OWNER TO admin;

--
-- Name: variant_colors_attachments; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.variant_colors_attachments (
    id bigint NOT NULL,
    variantcolor_id uuid NOT NULL,
    attachment_id uuid NOT NULL
);


ALTER TABLE public.variant_colors_attachments OWNER TO admin;

--
-- Name: variant_colors_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.variant_colors_attachments ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.variant_colors_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: variants; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.variants (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    launch_date date NOT NULL,
    name character varying(255) NOT NULL,
    fuel_type character varying(2) NOT NULL,
    transmission character varying(6) DEFAULT 'MT'::character varying NOT NULL,
    description text NOT NULL,
    specifications jsonb DEFAULT '"{}"'::jsonb,
    manufacturer_link character varying(255),
    vehicle_id uuid NOT NULL,
    short_description text,
    slug character varying(255) NOT NULL
);


ALTER TABLE public.variants OWNER TO admin;

--
-- Name: variants_attachments; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.variants_attachments (
    id bigint NOT NULL,
    variant_id uuid NOT NULL,
    attachment_id uuid NOT NULL
);


ALTER TABLE public.variants_attachments OWNER TO admin;

--
-- Name: variants_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.variants_attachments ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.variants_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: vehicle_types; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.vehicle_types (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    category character varying(3) NOT NULL,
    code character varying(3) NOT NULL
);


ALTER TABLE public.vehicle_types OWNER TO admin;

--
-- Name: vehicles; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.vehicles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    make_id uuid NOT NULL,
    vehicle_type_id uuid NOT NULL
);


ALTER TABLE public.vehicles OWNER TO admin;

--
-- Name: votes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.votes (
    created_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    updated_at timestamp with time zone DEFAULT statement_timestamp() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    type character varying(2) NOT NULL,
    contribution_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.votes OWNER TO admin;

--
-- Data for Name: hdb_action_log; Type: TABLE DATA; Schema: hdb_catalog; Owner: admin
--

COPY hdb_catalog.hdb_action_log (id, action_name, input_payload, request_headers, session_variables, response_payload, errors, created_at, response_received_at, status) FROM stdin;
\.


--
-- Data for Name: hdb_cron_event_invocation_logs; Type: TABLE DATA; Schema: hdb_catalog; Owner: admin
--

COPY hdb_catalog.hdb_cron_event_invocation_logs (id, event_id, status, request, response, created_at) FROM stdin;
\.


--
-- Data for Name: hdb_cron_events; Type: TABLE DATA; Schema: hdb_catalog; Owner: admin
--

COPY hdb_catalog.hdb_cron_events (id, trigger_name, scheduled_time, status, tries, created_at, next_retry_at) FROM stdin;
\.


--
-- Data for Name: hdb_metadata; Type: TABLE DATA; Schema: hdb_catalog; Owner: admin
--

COPY hdb_catalog.hdb_metadata (id, metadata, resource_version) FROM stdin;
1	{"remote_schemas":[{"comment":"The graphene-django API Server for AUTH and Custom Logic","definition":{"customization":{},"forward_client_headers":true,"timeout_seconds":60,"url":"{{API_HOST}}/api/graphql/"},"name":"DjangoGraphqlAPI"}],"sources":[{"configuration":{"connection_info":{"database_url":{"from_env":"HASURA_GRAPHQL_DATABASE_URL"},"isolation_level":"read-committed","pool_settings":{"connection_lifetime":600,"idle_timeout":180,"max_connections":50,"retries":1},"use_prepared_statements":true}},"kind":"postgres","name":"default","tables":[{"delete_permissions":[{"comment":"","permission":{"filter":{"created_by_id":{"_eq":"X-Hasura-User-Id"}}},"role":"contributor"},{"comment":"","permission":{"filter":{"created_by_id":{"_eq":"X-Hasura-User-Id"}}},"role":"user"}],"select_permissions":[{"comment":"","permission":{"columns":["url","id","mime_type","size"],"filter":{}},"role":"contributor"},{"comment":"","permission":{"columns":["url","id","mime_type","size"],"filter":{"created_by_id":{"_eq":"X-Hasura-User-Id"}}},"role":"user"}],"table":{"name":"attachments","schema":"public"}},{"table":{"name":"auth_group","schema":"public"}},{"table":{"name":"auth_group_permissions","schema":"public"}},{"table":{"name":"auth_permission","schema":"public"}},{"array_relationships":[{"name":"contributions","using":{"foreign_key_constraint_on":{"column":"city_id","table":{"name":"contributions","schema":"public"}}}}],"object_relationships":[{"name":"state","using":{"foreign_key_constraint_on":"state_id"}}],"select_permissions":[{"comment":"","permission":{"columns":["code","name","id","state_id"],"filter":{}},"role":"anonymous"},{"comment":"","permission":{"columns":["code","name","id","state_id"],"filter":{}},"role":"contributor"},{"comment":"","permission":{"columns":["code","name","id","state_id"],"filter":{}},"role":"user"}],"table":{"name":"cities","schema":"public"}},{"delete_permissions":[{"comment":"","permission":{"filter":{"contribution":{"user_id":{"_eq":"X-Hasura-User-Id"}}}},"role":"contributor"},{"comment":"","permission":{"filter":{"contribution":{"user_id":{"_eq":"X-Hasura-User-Id"}}}},"role":"user"}],"insert_permissions":[{"comment":"","permission":{"check":{"contribution":{"user_id":{"_eq":"X-Hasura-User-Id"}}},"columns":["contribution_id","id","price_item_id","serial_no","value"]},"role":"contributor"},{"comment":"","permission":{"check":{"contribution":{"user_id":{"_eq":"X-Hasura-User-Id"}}},"columns":["contribution_id","id","price_item_id","serial_no","value"]},"role":"user"}],"object_relationships":[{"name":"contribution","using":{"foreign_key_constraint_on":"contribution_id"}},{"name":"price_item","using":{"foreign_key_constraint_on":"price_item_id"}}],"select_permissions":[{"comment":"","permission":{"columns":["contribution_id","created_at","id","price_item_id","serial_no","updated_at","value"],"filter":{"_or":[{"contribution":{"user_id":{"_eq":"X-Hasura-User-Id"}}},{"contribution":{"status":{"_eq":"AC"}}}]}},"role":"contributor"},{"comment":"","permission":{"allow_aggregations":true,"columns":["value","serial_no","created_at","updated_at","contribution_id","id","price_item_id"],"filter":{"contribution":{"user_id":{"_eq":"X-Hasura-User-Id"}}}},"role":"user"}],"table":{"name":"contribution_price_items","schema":"public"},"update_permissions":[{"comment":"","permission":{"check":null,"columns":["price_item_id","serial_no","value"],"filter":{"contribution":{"user_id":{"_eq":"X-Hasura-User-Id"}}}},"role":"contributor"},{"comment":"","permission":{"check":null,"columns":["price_item_id","serial_no","value"],"filter":{"contribution":{"user_id":{"_eq":"X-Hasura-User-Id"}}}},"role":"user"}]},{"array_relationships":[{"name":"attachments","using":{"foreign_key_constraint_on":{"column":"contribution_id","table":{"name":"contributions_attachments","schema":"public"}}}},{"name":"items","using":{"foreign_key_constraint_on":{"column":"contribution_id","table":{"name":"contribution_price_items","schema":"public"}}}}],"delete_permissions":[{"comment":"","permission":{"filter":{"user_id":{"_eq":"X-Hasura-User-Id"}}},"role":"contributor"},{"comment":"","permission":{"filter":{"user_id":{"_eq":"X-Hasura-User-Id"}}},"role":"user"}],"insert_permissions":[{"comment":"","permission":{"check":{},"columns":["city_id","color_id","dealership_name","id","quoted_on","remark","variant_id"],"set":{"user_id":"x-hasura-User-Id"}},"role":"contributor"},{"comment":"","permission":{"check":{"user_id":{"_eq":"X-Hasura-User-Id"}},"columns":["city_id","color_id","dealership_name","id","quoted_on","remark","variant_id"],"set":{"user_id":"x-hasura-User-Id"}},"role":"user"}],"object_relationships":[{"name":"city","using":{"foreign_key_constraint_on":"city_id"}},{"name":"user","using":{"foreign_key_constraint_on":"user_id"}},{"name":"variant","using":{"foreign_key_constraint_on":"variant_id"}},{"name":"variant_color","using":{"foreign_key_constraint_on":"color_id"}}],"select_permissions":[{"comment":"","permission":{"allow_aggregations":true,"columns":["city_id","color_id","created_at","dealership_name","downvotes","id","quoted_on","remark","status","total","updated_at","upvotes","variant_id"],"filter":{"_or":[{"user_id":{"_eq":"X-Hasura-User-Id"}},{"status":{"_eq":"AC"}}]}},"role":"contributor"},{"comment":"","permission":{"allow_aggregations":true,"columns":["city_id","color_id","created_at","dealership_name","downvotes","id","quoted_on","remark","status","total","updated_at","upvotes","variant_id"],"filter":{"_or":[{"user_id":{"_eq":"X-Hasura-User-Id"}},{"status":{"_eq":"AC"}}]}},"role":"user"}],"table":{"name":"contributions","schema":"public"},"update_permissions":[{"comment":"","permission":{"check":{"user_id":{"_eq":"X-Hasura-User-Id"}},"columns":["city_id","color_id","dealership_name","quoted_on","remark","variant_id"],"filter":{"user_id":{"_eq":"X-Hasura-User-Id"}},"set":{"updated_at":"NOW()"}},"role":"contributor"},{"comment":"","permission":{"check":null,"columns":["city_id","color_id","dealership_name","quoted_on","remark","variant_id"],"filter":{"user_id":{"_eq":"X-Hasura-User-Id"}},"set":{"updated_at":"NOW()"}},"role":"user"}]},{"delete_permissions":[{"comment":"","permission":{"filter":{"contribution":{"user_id":{"_eq":"X-Hasura-User-Id"}}}},"role":"contributor"},{"comment":"","permission":{"filter":{"contribution":{"user_id":{"_eq":"X-Hasura-User-Id"}}}},"role":"user"}],"insert_permissions":[{"comment":"","permission":{"check":{},"columns":[]},"role":"contributor"},{"comment":"","permission":{"check":{},"columns":[]},"role":"user"}],"object_relationships":[{"name":"attachment","using":{"foreign_key_constraint_on":"attachment_id"}},{"name":"contribution","using":{"foreign_key_constraint_on":"contribution_id"}}],"select_permissions":[{"comment":"","permission":{"columns":["id","contribution_id","attachment_id"],"filter":{}},"role":"contributor"},{"comment":"","permission":{"columns":["id","attachment_id","contribution_id"],"filter":{"contribution":{"user_id":{"_eq":"X-Hasura-User-Id"}}}},"role":"user"}],"table":{"name":"contributions_attachments","schema":"public"},"update_permissions":[{"comment":"","permission":{"check":null,"columns":["attachment_id"],"filter":{"contribution":{"user_id":{"_eq":"X-Hasura-User-Id"}}}},"role":"contributor"},{"comment":"","permission":{"check":{},"columns":["attachment_id"],"filter":{"contribution":{"user_id":{"_eq":"X-Hasura-User-Id"}}}},"role":"user"}]},{"array_relationships":[{"name":"states","using":{"foreign_key_constraint_on":{"column":"country_id","table":{"name":"states","schema":"public"}}}}],"select_permissions":[{"comment":"","permission":{"columns":["code","name","id"],"filter":{}},"role":"anonymous"},{"comment":"","permission":{"columns":["code","name","id"],"filter":{}},"role":"contributor"},{"comment":"","permission":{"columns":["code","name","id"],"filter":{}},"role":"user"}],"table":{"name":"countries","schema":"public"}},{"array_relationships":[{"name":"vehicles","using":{"foreign_key_constraint_on":{"column":"make_id","table":{"name":"vehicles","schema":"public"}}}}],"select_permissions":[{"comment":"","permission":{"columns":["code","estb_year","id","name"],"filter":{}},"role":"contributor"},{"comment":"","permission":{"columns":["code","estb_year","id","name"],"filter":{}},"role":"user"}],"table":{"name":"makes","schema":"public"}},{"select_permissions":[{"comment":"","permission":{"columns":["category","created_at","description","id","name","serial_no","type","updated_at"],"filter":{}},"role":"contributor"},{"comment":"","permission":{"columns":["category","created_at","description","id","name","serial_no","type","updated_at"],"filter":{}},"role":"user"}],"table":{"name":"price_items","schema":"public"}},{"array_relationships":[{"name":"cities","using":{"foreign_key_constraint_on":{"column":"state_id","table":{"name":"cities","schema":"public"}}}}],"object_relationships":[{"name":"country","using":{"foreign_key_constraint_on":"country_id"}}],"select_permissions":[{"comment":"","permission":{"columns":["code","name","country_id","id"],"filter":{}},"role":"anonymous"},{"comment":"","permission":{"columns":["code","name","country_id","id"],"filter":{}},"role":"contributor"},{"comment":"","permission":{"columns":["code","name","country_id","id"],"filter":{}},"role":"user"}],"table":{"name":"states","schema":"public"}},{"delete_permissions":[{"comment":"","permission":{"filter":{"user_id":{"_eq":"X-Hasura-User-Id"}}},"role":"contributor"},{"comment":"","permission":{"filter":{"user_id":{"_eq":"X-Hasura-User-Id"}}},"role":"user"}],"select_permissions":[{"comment":"","permission":{"columns":["created_at","credential_id","description","id","updated_at","user_id"],"filter":{"user_id":{"_eq":"X-Hasura-User-Id"}}},"role":"contributor"},{"comment":"","permission":{"columns":["created_at","credential_id","description","id","updated_at","user_id"],"filter":{"user_id":{"_eq":"X-Hasura-User-Id"}}},"role":"user"}],"table":{"name":"user_passkeys","schema":"public"}},{"delete_permissions":[{"comment":"","permission":{"filter":{"_and":[{"user_id":{"_eq":"X-Hasura-User-Id"}},{"type":{"_eq":"RF"}},{"expires_at":{"_gte":"NOW()"}}]}},"role":"contributor"},{"comment":"","permission":{"filter":{"_and":[{"user_id":{"_eq":"X-Hasura-User-Id"}},{"type":{"_eq":"RF"}},{"expires_at":{"_gte":"NOW()"}}]}},"role":"user"}],"object_relationships":[{"name":"user","using":{"foreign_key_constraint_on":"user_id"}}],"select_permissions":[{"comment":"","permission":{"columns":["client","created_at","description","expires_at","id","token","type","updated_at","used","user_id"],"filter":{"_and":[{"user_id":{"_eq":"X-Hasura-User-Id"}},{"type":{"_eq":"RF"}},{"expires_at":{"_gte":"NOW()"}}]}},"role":"contributor"},{"comment":"","permission":{"columns":["used","client","token","type","description","created_at","expires_at","updated_at","id","user_id"],"filter":{"_and":[{"user_id":{"_eq":"X-Hasura-User-Id"}},{"type":{"_eq":"RF"}},{"expires_at":{"_gte":"NOW()"}}]}},"role":"user"}],"table":{"name":"user_tokens","schema":"public"}},{"array_relationships":[{"name":"contributions","using":{"foreign_key_constraint_on":{"column":"user_id","table":{"name":"contributions","schema":"public"}}}},{"name":"groups","using":{"foreign_key_constraint_on":{"column":"user_id","table":{"name":"users_groups","schema":"public"}}}},{"name":"passkeys","using":{"foreign_key_constraint_on":{"column":"user_id","table":{"name":"user_passkeys","schema":"public"}}}},{"name":"permissions","using":{"foreign_key_constraint_on":{"column":"user_id","table":{"name":"users_user_permissions","schema":"public"}}}},{"name":"tokens","using":{"foreign_key_constraint_on":{"column":"user_id","table":{"name":"user_tokens","schema":"public"}}}},{"name":"votes","using":{"foreign_key_constraint_on":{"column":"user_id","table":{"name":"votes","schema":"public"}}}}],"object_relationships":[{"name":"city","using":{"foreign_key_constraint_on":"city_id"}}],"select_permissions":[{"comment":"","permission":{"columns":["avatar","city_id","created_at","email","email_verified","first_name","google_id","has_contributed","id","last_name","updated_at","username"],"filter":{"id":{"_eq":"X-Hasura-User-Id"}}},"role":"contributor"},{"comment":"","permission":{"columns":["avatar","city_id","created_at","email","email_verified","first_name","google_id","has_contributed","id","last_name","updated_at","username"],"filter":{"id":{"_eq":"X-Hasura-User-Id"}}},"role":"user"}],"table":{"name":"users","schema":"public"},"update_permissions":[{"comment":"","permission":{"check":null,"columns":["avatar","city_id","email","first_name","last_name","username"],"filter":{"id":{"_eq":"X-Hasura-User-Id"}},"set":{"updated_at":"NOW()"}},"role":"contributor"},{"comment":"","permission":{"check":null,"columns":["avatar","city_id","email","first_name","last_name","username"],"filter":{"id":{"_eq":"X-Hasura-User-Id"}},"set":{"updated_at":"NOW()"}},"role":"user"}]},{"table":{"name":"users_groups","schema":"public"}},{"table":{"name":"users_user_permissions","schema":"public"}},{"array_relationships":[{"name":"attachments","using":{"foreign_key_constraint_on":{"column":"variantcolor_id","table":{"name":"variant_colors_attachments","schema":"public"}}}},{"name":"contributions","using":{"foreign_key_constraint_on":{"column":"color_id","table":{"name":"contributions","schema":"public"}}}}],"object_relationships":[{"name":"variant","using":{"foreign_key_constraint_on":"variant_id"}}],"select_permissions":[{"comment":"","permission":{"columns":["hex_code","name","id","variant_id"],"filter":{}},"role":"contributor"},{"comment":"","permission":{"columns":["hex_code","name","id","variant_id"],"filter":{}},"role":"user"}],"table":{"name":"variant_colors","schema":"public"}},{"object_relationships":[{"name":"attachment","using":{"foreign_key_constraint_on":"attachment_id"}},{"name":"color","using":{"foreign_key_constraint_on":"variantcolor_id"}}],"select_permissions":[{"comment":"","permission":{"columns":["id","attachment_id","variantcolor_id"],"filter":{}},"role":"contributor"},{"comment":"","permission":{"columns":["id","attachment_id","variantcolor_id"],"filter":{}},"role":"user"}],"table":{"name":"variant_colors_attachments","schema":"public"}},{"array_relationships":[{"name":"attachments","using":{"foreign_key_constraint_on":{"column":"variant_id","table":{"name":"variants_attachments","schema":"public"}}}},{"name":"colors","using":{"foreign_key_constraint_on":{"column":"variant_id","table":{"name":"variant_colors","schema":"public"}}}},{"name":"contributions","using":{"foreign_key_constraint_on":{"column":"variant_id","table":{"name":"contributions","schema":"public"}}}}],"object_relationships":[{"name":"vehicle","using":{"foreign_key_constraint_on":"vehicle_id"}}],"select_permissions":[{"comment":"","permission":{"allow_aggregations":true,"columns":["description","fuel_type","id","launch_date","manufacturer_link","name","short_description","slug","specifications","transmission","vehicle_id"],"filter":{}},"role":"contributor"},{"comment":"","permission":{"allow_aggregations":true,"columns":["description","fuel_type","id","launch_date","manufacturer_link","name","short_description","slug","specifications","transmission","vehicle_id"],"filter":{}},"role":"user"}],"table":{"name":"variants","schema":"public"}},{"object_relationships":[{"name":"attachment","using":{"foreign_key_constraint_on":"attachment_id"}},{"name":"variant","using":{"foreign_key_constraint_on":"variant_id"}}],"select_permissions":[{"comment":"","permission":{"columns":["id","attachment_id","variant_id"],"filter":{}},"role":"contributor"},{"comment":"","permission":{"columns":["id","attachment_id","variant_id"],"filter":{}},"role":"user"}],"table":{"name":"variants_attachments","schema":"public"}},{"array_relationships":[{"name":"vehicles","using":{"foreign_key_constraint_on":{"column":"vehicle_type_id","table":{"name":"vehicles","schema":"public"}}}}],"select_permissions":[{"comment":"","permission":{"columns":["category","code","id","name"],"filter":{}},"role":"contributor"},{"comment":"","permission":{"columns":["category","code","id","name"],"filter":{}},"role":"user"}],"table":{"name":"vehicle_types","schema":"public"}},{"array_relationships":[{"name":"variants","using":{"foreign_key_constraint_on":{"column":"vehicle_id","table":{"name":"variants","schema":"public"}}}}],"object_relationships":[{"name":"make","using":{"foreign_key_constraint_on":"make_id"}},{"name":"type","using":{"foreign_key_constraint_on":"vehicle_type_id"}}],"select_permissions":[{"comment":"","permission":{"columns":["name","id","make_id","vehicle_type_id"],"filter":{}},"role":"contributor"},{"comment":"","permission":{"columns":["name","id","make_id","vehicle_type_id"],"filter":{}},"role":"user"}],"table":{"name":"vehicles","schema":"public"}},{"delete_permissions":[{"comment":"","permission":{"filter":{"user_id":{"_eq":"X-Hasura-User-Id"}}},"role":"contributor"},{"comment":"","permission":{"filter":{"user_id":{"_eq":"X-Hasura-User-Id"}}},"role":"user"}],"insert_permissions":[{"comment":"","permission":{"check":{"user_id":{"_eq":"X-Hasura-User-Id"}},"columns":["contribution_id","type"],"set":{"user_id":"x-hasura-User-Id"}},"role":"contributor"},{"comment":"","permission":{"check":{"user_id":{"_eq":"X-Hasura-User-Id"}},"columns":["contribution_id","type"],"set":{"user_id":"x-hasura-User-Id"}},"role":"user"}],"object_relationships":[{"name":"contribution","using":{"foreign_key_constraint_on":"contribution_id"}},{"name":"user","using":{"foreign_key_constraint_on":"user_id"}}],"select_permissions":[{"comment":"","permission":{"columns":["type","created_at","updated_at","contribution_id","id","user_id"],"filter":{"user_id":{"_eq":"X-Hasura-User-Id"}}},"role":"contributor"},{"comment":"","permission":{"allow_aggregations":true,"columns":["type","created_at","updated_at","contribution_id","id","user_id"],"filter":{"user_id":{"_eq":"X-Hasura-User-Id"}},"limit":300},"role":"user"}],"table":{"name":"votes","schema":"public"},"update_permissions":[{"comment":"","permission":{"check":null,"columns":["type"],"filter":{"user_id":{"_eq":"X-Hasura-User-Id"}}},"role":"contributor"},{"comment":"","permission":{"check":{"user_id":{"_eq":"X-Hasura-User-Id"}},"columns":["type"],"filter":{},"set":{"updated_at":"NOW()"}},"role":"user"}]}]}],"version":3}	162
\.


--
-- Data for Name: hdb_scheduled_event_invocation_logs; Type: TABLE DATA; Schema: hdb_catalog; Owner: admin
--

COPY hdb_catalog.hdb_scheduled_event_invocation_logs (id, event_id, status, request, response, created_at) FROM stdin;
\.


--
-- Data for Name: hdb_scheduled_events; Type: TABLE DATA; Schema: hdb_catalog; Owner: admin
--

COPY hdb_catalog.hdb_scheduled_events (id, webhook_conf, scheduled_time, retry_conf, payload, header_conf, status, tries, created_at, next_retry_at, comment) FROM stdin;
\.


--
-- Data for Name: hdb_schema_notifications; Type: TABLE DATA; Schema: hdb_catalog; Owner: admin
--

COPY hdb_catalog.hdb_schema_notifications (id, notification, resource_version, instance_id, updated_at) FROM stdin;
1	{"metadata":true,"remote_schemas":["DjangoGraphqlAPI"],"sources":["default"],"data_connectors":[]}	162	50b64a26-dafa-4b27-a2dc-6887144e62aa	2024-01-29 17:44:24.736256+00
\.


--
-- Data for Name: hdb_version; Type: TABLE DATA; Schema: hdb_catalog; Owner: admin
--

COPY hdb_catalog.hdb_version (hasura_uuid, version, upgraded_on, cli_state, console_state, ee_client_id, ee_client_secret) FROM stdin;
f6e02a2d-3aaf-4e85-ab13-94016936a997	48	2024-01-29 17:44:22.472145+00	{"settings": {"migration_mode": "true"}, "migrations": {"default": {"1705727625774": false, "1705728087255": false, "1705730008798": false, "1706896529967": false, "1706899015375": false, "1706899213995": false, "1710055887529": false}}, "isStateCopyCompleted": true}	{}	\N	\N
\.


--
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.attachments (id, url, mime_type, size, created_by_id, etag, key, created_at, updated_at) FROM stdin;
b93323c0-3c7e-453f-8e28-8705108b1448	https://onroadcdn.blr1.digitaloceanspaces.com/p/b93323c0-3c7e-453f-8e28-8705108b1448.jpg	image/jpeg	92600	0bb5a044-bff7-40a1-9d67-73fa28050c26	6ff697bf532be4e0fc839b304027f34b	p/b93323c0-3c7e-453f-8e28-8705108b1448.jpg	2024-01-29 18:26:49.058047+00	2024-01-29 18:26:49.058074+00
cb9e45ba-6de8-40e9-afc3-bb03504fd06f	https://s3.ap-south-1.amazonaws.com/onroad.one/p/cb9e45ba-6de8-40e9-afc3-bb03504fd06f.jpg	image/jpeg	10057641	0bb5a044-bff7-40a1-9d67-73fa28050c26	"050c1dcce93b58bbea2de599abd39929"	p/cb9e45ba-6de8-40e9-afc3-bb03504fd06f.jpg	2024-02-11 08:28:58.120708+00	2024-02-11 08:28:58.120734+00
70a0aa0d-18a1-40fe-a24e-b117d6f17a2e	https://s3.ap-south-1.amazonaws.com/onroad.one/p/70a0aa0d-18a1-40fe-a24e-b117d6f17a2e.jpg	image/jpeg	10057641	0bb5a044-bff7-40a1-9d67-73fa28050c26	"050c1dcce93b58bbea2de599abd39929"	p/70a0aa0d-18a1-40fe-a24e-b117d6f17a2e.jpg	2024-02-11 08:37:15.977869+00	2024-02-11 08:37:15.977892+00
95056f20-c721-4cea-a38b-290b02163be2	https://s3.ap-south-1.amazonaws.com/onroad.one/p/95056f20-c721-4cea-a38b-290b02163be2.webp	image/webp	1279636	0bb5a044-bff7-40a1-9d67-73fa28050c26	0a74a0abfae09a62ae4908a9f5fbe242	p/95056f20-c721-4cea-a38b-290b02163be2.webp	2024-02-11 08:52:33.362549+00	2024-02-11 08:52:33.362574+00
93c27b32-6e16-4d12-8c27-c8065aa48c02	https://s3.ap-south-1.amazonaws.com/onroad.one/p/93c27b32-6e16-4d12-8c27-c8065aa48c02.webp	image/webp	453328	0bb5a044-bff7-40a1-9d67-73fa28050c26	4df06de6634d5f30eb5b62e773ac19ff	p/93c27b32-6e16-4d12-8c27-c8065aa48c02.webp	2024-02-17 10:14:50.450174+00	2024-02-17 10:14:50.4502+00
eee85ab4-29b9-4622-b669-3731193735ca	https://s3.ap-south-1.amazonaws.com/onroad.one/p/eee85ab4-29b9-4622-b669-3731193735ca.webp	image/webp	65380	0bb5a044-bff7-40a1-9d67-73fa28050c26	0cc58fdb77c155e9a1a03d911aac5f0b	p/eee85ab4-29b9-4622-b669-3731193735ca.webp	2024-02-17 10:17:40.021522+00	2024-02-17 10:17:40.021542+00
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.auth_group (id, name) FROM stdin;
1	user
2	contributor
3	admin
4	staff
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add task	6	add_task
22	Can change task	6	change_task
23	Can delete task	6	delete_task
24	Can view task	6	view_task
25	Can add city	7	add_city
26	Can change city	7	change_city
27	Can delete city	7	delete_city
28	Can view city	7	view_city
29	Can add country	8	add_country
30	Can change country	8	change_country
31	Can delete country	8	delete_country
32	Can view country	8	view_country
33	Can add make	9	add_make
34	Can change make	9	change_make
35	Can delete make	9	delete_make
36	Can view make	9	view_make
37	Can add price item	10	add_priceitem
38	Can change price item	10	change_priceitem
39	Can delete price item	10	delete_priceitem
40	Can view price item	10	view_priceitem
41	Can add vehicle type	11	add_vehicletype
42	Can change vehicle type	11	change_vehicletype
43	Can delete vehicle type	11	delete_vehicletype
44	Can view vehicle type	11	view_vehicletype
45	Can add user	12	add_user
46	Can change user	12	change_user
47	Can delete user	12	delete_user
48	Can view user	12	view_user
49	Can add attachment	13	add_attachment
50	Can change attachment	13	change_attachment
51	Can delete attachment	13	delete_attachment
52	Can view attachment	13	view_attachment
53	Can add contribution	14	add_contribution
54	Can change contribution	14	change_contribution
55	Can delete contribution	14	delete_contribution
56	Can view contribution	14	view_contribution
57	Can add contribution price item	15	add_contributionpriceitem
58	Can change contribution price item	15	change_contributionpriceitem
59	Can delete contribution price item	15	delete_contributionpriceitem
60	Can view contribution price item	15	view_contributionpriceitem
61	Can add refresh token	16	add_refreshtoken
62	Can change refresh token	16	change_refreshtoken
63	Can delete refresh token	16	delete_refreshtoken
64	Can view refresh token	16	view_refreshtoken
65	Can add state	17	add_state
66	Can change state	17	change_state
67	Can delete state	17	delete_state
68	Can view state	17	view_state
69	Can add variant	18	add_variant
70	Can change variant	18	change_variant
71	Can delete variant	18	delete_variant
72	Can view variant	18	view_variant
73	Can add variant color	19	add_variantcolor
74	Can change variant color	19	change_variantcolor
75	Can delete variant color	19	delete_variantcolor
76	Can view variant color	19	view_variantcolor
77	Can add vehicle	20	add_vehicle
78	Can change vehicle	20	change_vehicle
79	Can delete vehicle	20	delete_vehicle
80	Can view vehicle	20	view_vehicle
81	Can add vote	21	add_vote
82	Can change vote	21	change_vote
83	Can delete vote	21	delete_vote
84	Can view vote	21	view_vote
85	Can add otp	22	add_otp
86	Can change otp	22	change_otp
87	Can delete otp	22	delete_otp
88	Can view otp	22	view_otp
89	Can add password change request	23	add_passwordchangerequest
90	Can change password change request	23	change_passwordchangerequest
91	Can delete password change request	23	delete_passwordchangerequest
92	Can view password change request	23	view_passwordchangerequest
93	Can add user token	24	add_usertoken
94	Can change user token	24	change_usertoken
95	Can delete user token	24	delete_usertoken
96	Can view user token	24	view_usertoken
97	Can add user pass keys	25	add_userpasskeys
98	Can change user pass keys	25	change_userpasskeys
99	Can delete user pass keys	25	delete_userpasskeys
100	Can view user pass keys	25	view_userpasskeys
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.cities (id, name, code, state_id) FROM stdin;
8be181da-5344-4156-9d06-5fa4e98aec2d	Mumbai		afa1a4c7-c742-4deb-ba10-79d131bf2a10
f85c1f60-5eee-47d6-b118-9647168922ef	Delhi		d6b39040-4721-4313-aa69-733bf78b0214
cb79bbc9-9e08-4311-87da-08cabd8e505f	Bengaluru		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
e59526bf-8532-44ac-a53a-742081b5b851	Ahmedabad		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
c57aed39-e0b5-4a39-b5db-17304e813ad6	Hyderabad		b65398bc-aa42-475d-bc07-a6730719da86
b0991d77-29a7-4855-ac08-30a2ed98a7cc	Chennai		99c94553-c81e-4dfb-98b1-377247c307bb
b201deee-22a3-4508-9d64-8844a9c5668d	Kolkata		4d66d7f3-42f7-4fb7-945b-5093e9902b93
2701d525-dab6-4c5c-b9a0-0433a5737a69	Pune		afa1a4c7-c742-4deb-ba10-79d131bf2a10
4c01ecb3-6f26-4a99-b9e3-98169c09ad14	Jaipur		7b0ea670-6161-44cf-85e4-98e2d2f37975
ad73e7bd-d66c-42ca-9c69-91f4a3581296	Surat		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
bf5e4432-bf0c-4043-8e47-36cf147fe059	Lucknow		d72eae33-d05a-4350-aebf-08cef4fbf34d
f3205394-9028-4a52-b8b6-668d8048b1ce	Kanpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
1d628516-1bf0-4dc0-b3f1-f022e44d7b10	Nagpur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
23912b31-cb98-4f80-9cbf-bae82bda3d41	Patna		aaeb6b5f-0633-47b5-9100-e9024700ece0
5e29e621-75af-45a1-a4a3-c29ecb73b757	Indore		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
29e45189-0bce-4837-9c56-3a801b773eb5	Thane		afa1a4c7-c742-4deb-ba10-79d131bf2a10
8d82eb13-8ca8-42cf-84db-be33b9ceae80	Bhopal		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
a36fedc9-8a9d-496b-9eae-e33830571c8d	Visakhapatnam		d0a039df-6e75-4597-9f80-fa3a055b0bee
af8a3aa3-2ca3-4b04-b21d-bd95c4dca797	Vadodara		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
3963fea1-04d8-49dd-84ff-f84edc84a577	Firozabad		d72eae33-d05a-4350-aebf-08cef4fbf34d
98ef9442-8a69-42f7-b1f6-b0a3215bbaac	Ludhiana		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
3e825dab-8877-48ed-9e8a-1b616826d3e7	Rajkot		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
0b65c5fa-43d1-4584-9138-ffa98a45bbdd	Agra		d72eae33-d05a-4350-aebf-08cef4fbf34d
1e3feaf0-95d0-470d-9092-82671b06e095	Siliguri		4d66d7f3-42f7-4fb7-945b-5093e9902b93
713b7600-4c05-48fc-86d1-31974c747ce3	Nashik		afa1a4c7-c742-4deb-ba10-79d131bf2a10
74330a66-938c-46c5-8653-0e9e3cc32297	Faridabad		1cb5bf87-e09b-4605-86bb-f11df93794b6
e0c2f215-8cce-40ad-a800-b1019b867ec4	Patiala		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
7c0878f4-dee6-4b2f-adb2-ead6140b40f3	Meerut		d72eae33-d05a-4350-aebf-08cef4fbf34d
d9721bf4-2212-47cb-a211-4ee954a890cd	Kalyan-Dombivali		afa1a4c7-c742-4deb-ba10-79d131bf2a10
a3292462-0fe5-45ad-993a-a18474e7fd36	Vasai-Virar		afa1a4c7-c742-4deb-ba10-79d131bf2a10
be03cc13-0c56-44e5-ae58-ca0846a0d498	Varanasi		d72eae33-d05a-4350-aebf-08cef4fbf34d
c766c40e-b70f-4ddd-90f2-cbc457d3f43d	Srinagar		8889d547-3ba6-469e-bcf6-4329aede50b1
c9ff5e5b-94c5-49d5-8c4b-881462276b44	Dhanbad		6c763981-576b-450b-8db6-778b1c243803
0544429b-181b-4fb5-943a-45781fe02921	Jodhpur		7b0ea670-6161-44cf-85e4-98e2d2f37975
e0b3fc3b-db53-450c-9060-ed4c03898e01	Amritsar		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
a8f854d2-479b-442a-bf95-b1d39f0457fe	Raipur		ea160870-ab8b-4cae-a772-0a80b566470f
07db3472-4976-4778-80ca-2b03f485e622	Allahabad		d72eae33-d05a-4350-aebf-08cef4fbf34d
45ec0575-d25c-465d-b7a8-7faa7bbe10f0	Coimbatore		99c94553-c81e-4dfb-98b1-377247c307bb
b5719c3d-cf13-4e1b-a77f-7b2b906e238b	Jabalpur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
6be27f61-2d87-4221-bb9e-fb3d5290b658	Gwalior		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
09ac481e-cd1c-4393-8540-2ae8b86211ec	Vijayawada		d0a039df-6e75-4597-9f80-fa3a055b0bee
dc8282d3-18b0-477d-b0e5-ef9e5b60e5f1	Madurai		99c94553-c81e-4dfb-98b1-377247c307bb
102b8276-f71a-4d95-9453-c60e301e7146	Guwahati		694a90d0-c9a5-4835-95df-e9498c78c360
6862e69d-af00-42ca-9257-e9c4aecc6acd	Chandigarh		d306bac9-5e52-4af9-9c71-dec993c2baba
b77381e9-890f-4032-bbb2-385f2d29e1ed	Hubli-Dharwad		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
810c66a0-ea57-4713-9114-a15536949149	Amroha		d72eae33-d05a-4350-aebf-08cef4fbf34d
3efc33b0-8cbc-457e-96da-04264bf77238	Moradabad		d72eae33-d05a-4350-aebf-08cef4fbf34d
66439239-d621-4c2b-a011-a7b176576aa0	Gurgaon		1cb5bf87-e09b-4605-86bb-f11df93794b6
1010a4c2-097f-4061-b053-8416430f5d35	Aligarh		d72eae33-d05a-4350-aebf-08cef4fbf34d
1876d2d5-0627-48a2-b0e9-8c7e28472f85	Solapur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
6d93f42e-68dc-4669-be94-0d6dc690ad75	Ranchi		6c763981-576b-450b-8db6-778b1c243803
a732abbf-23fa-49cf-b269-50e6427975da	Jalandhar		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
7ac3d988-cb5f-4cdf-a8dc-db4d8396fd46	Tiruchirappalli		99c94553-c81e-4dfb-98b1-377247c307bb
3e6cea30-f45c-4be4-8004-0927c2129e8f	Bhubaneswar		57eb2330-c405-46f3-a60a-0622d0086b77
e8857049-b8ac-4b3a-815c-1beedde82643	Salem		99c94553-c81e-4dfb-98b1-377247c307bb
fba64b4f-3460-438f-a94c-42a167e601ff	Warangal		b65398bc-aa42-475d-bc07-a6730719da86
9ced17a6-fee1-4b0f-b037-d74bc5df7851	Mira-Bhayandar		afa1a4c7-c742-4deb-ba10-79d131bf2a10
2b97a4dc-be57-4842-85e7-257e698a0b25	Thiruvananthapuram		f8911f17-19b1-46d9-b708-a727912638c8
d814976d-448d-4dca-b13e-e104dcf66482	Bhiwandi		afa1a4c7-c742-4deb-ba10-79d131bf2a10
b7c35b9e-0e81-4e42-be35-cf96ff6ff7c2	Saharanpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
999886b7-77eb-4c3d-a6cd-2c6ad5d5fbae	Guntur		d0a039df-6e75-4597-9f80-fa3a055b0bee
9ae27c2f-288b-4995-8a2f-7254b40501a9	Amravati		afa1a4c7-c742-4deb-ba10-79d131bf2a10
159f8051-d2b6-4a8a-99f4-7ee08ddbfc33	Bikaner		7b0ea670-6161-44cf-85e4-98e2d2f37975
f44375fd-7fe7-4965-b356-f03e5c120130	Noida		d72eae33-d05a-4350-aebf-08cef4fbf34d
e7990db7-ad01-4bd3-9f26-43169b67bef6	Jamshedpur		6c763981-576b-450b-8db6-778b1c243803
cb9b876e-22af-4074-abed-408f694b4ce0	Bhilai Nagar		ea160870-ab8b-4cae-a772-0a80b566470f
3a996df2-1435-48a4-9e12-d4d88af9e378	Cuttack		57eb2330-c405-46f3-a60a-0622d0086b77
2e36e2de-9327-4125-b4b8-1587c83a7940	Kochi		f8911f17-19b1-46d9-b708-a727912638c8
6522e56a-074f-4945-9fa7-729446544ed5	Udaipur		7b0ea670-6161-44cf-85e4-98e2d2f37975
95c58af8-3e48-4e39-a53b-b2f181c69a2f	Bhavnagar		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
faf119d1-254f-4a18-a85c-c8b91594f14b	Dehradun		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
331de0aa-62c4-4780-9334-032b0686861f	Asansol		4d66d7f3-42f7-4fb7-945b-5093e9902b93
7a2e50f1-bc99-49b6-a1a4-3f98da794c69	Nanded-Waghala		afa1a4c7-c742-4deb-ba10-79d131bf2a10
062c9fa3-5e43-4802-8dd0-86331f9e75c9	Ajmer		7b0ea670-6161-44cf-85e4-98e2d2f37975
0daee39d-9e7c-493b-a5dc-7db6259ad930	Jamnagar		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
69c0e34b-37e6-474b-aa71-c82931490bb9	Ujjain		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
9b0c8627-ddb2-4e89-9292-0445d011fa66	Sangli		afa1a4c7-c742-4deb-ba10-79d131bf2a10
d5c6b7ad-c2bc-429d-a952-95bb780ea7ba	Loni		d72eae33-d05a-4350-aebf-08cef4fbf34d
90bfc952-8c04-4af7-ad85-56b970d70857	Jhansi		d72eae33-d05a-4350-aebf-08cef4fbf34d
05823720-4b45-4bee-a502-2d1a6c7500ad	Pondicherry		fdc8eeae-14e2-45bb-b91c-88f586bde4eb
2f6ab001-124e-45f5-ad6d-72469358533f	Nellore		d0a039df-6e75-4597-9f80-fa3a055b0bee
df94c9ae-010d-417c-bbb4-9c3fcfd30046	Jammu		8889d547-3ba6-469e-bcf6-4329aede50b1
eaa3c74d-3c1e-4080-8d50-cf7c1d7f4ccb	Belagavi		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
43f83ea5-cc81-4c00-ba27-80e68de6a978	Raurkela		57eb2330-c405-46f3-a60a-0622d0086b77
fe0b1676-6ded-4eac-9348-4419e118a718	Mangaluru		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
d79e88d3-c2cf-47cf-9ef4-ed01c25811d3	Tirunelveli		99c94553-c81e-4dfb-98b1-377247c307bb
ace5f288-f7c7-46fb-9a47-2c8db2145a3e	Malegaon		afa1a4c7-c742-4deb-ba10-79d131bf2a10
8cb0c0e0-d3a2-466c-91c3-f9c3b67da499	Gaya		aaeb6b5f-0633-47b5-9100-e9024700ece0
38f97c94-ec8c-432e-9197-79566c62a08f	Tiruppur		99c94553-c81e-4dfb-98b1-377247c307bb
aecc5261-3a6f-4cff-8859-e9d0632c29b4	Davanagere		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
26687752-f8f4-48a9-acdd-703ada69ffaf	Kozhikode		f8911f17-19b1-46d9-b708-a727912638c8
52a12a52-aaf6-4dd3-a809-f086ebb79a4d	Akola		afa1a4c7-c742-4deb-ba10-79d131bf2a10
2187e3d5-fc4f-4469-ae2e-ef829e0f3e22	Kurnool		d0a039df-6e75-4597-9f80-fa3a055b0bee
d35e2295-4050-490d-a25f-c86e632caa04	Bokaro Steel City		6c763981-576b-450b-8db6-778b1c243803
882e8cc1-514c-4741-9ff6-dd8f46966c5b	Rajahmundry		d0a039df-6e75-4597-9f80-fa3a055b0bee
ab19278f-c503-4ae5-8016-03c2e034cf19	Ballari		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
b7801fd5-14f0-48c3-afee-0b6e559c7b26	Agartala		1d8e1820-480f-4c27-a44f-198d7063010f
e93a4c61-c5d4-431a-ad38-d8bf189c6fd0	Bhagalpur		aaeb6b5f-0633-47b5-9100-e9024700ece0
e8803199-eaaf-4ae6-b1e5-380cce5cc7eb	Latur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
acecc5fb-3e40-426f-abcf-e3dceb10703c	Dhule		afa1a4c7-c742-4deb-ba10-79d131bf2a10
a73a52ba-c58e-4b89-ae65-0c7a5a8bf556	Korba		ea160870-ab8b-4cae-a772-0a80b566470f
2a4712c9-09d3-4d32-9cf6-8963a155bc59	Bhilwara		7b0ea670-6161-44cf-85e4-98e2d2f37975
e32fa089-a388-46b0-acf1-2d04d21a7505	Brahmapur		57eb2330-c405-46f3-a60a-0622d0086b77
b09556e7-5f16-4513-b16b-4a46a39da767	Mysore		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
a6520fe0-153c-4dba-9c5c-12dba689eb0e	Muzaffarpur		aaeb6b5f-0633-47b5-9100-e9024700ece0
264bb770-aa40-4a29-9223-dc1d001f5a7b	Ahmednagar		afa1a4c7-c742-4deb-ba10-79d131bf2a10
170fd6fa-1b70-470f-859a-d0f845ef04da	Kollam		f8911f17-19b1-46d9-b708-a727912638c8
4a0a915c-a747-47da-b21e-1c0f5fa1d542	Raghunathganj		4d66d7f3-42f7-4fb7-945b-5093e9902b93
11cdfb17-cd55-4e7f-97a3-afe02a70e86c	Bilaspur		ea160870-ab8b-4cae-a772-0a80b566470f
f7b52e93-ef98-4ae0-9164-c89057ceee61	Shahjahanpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
49f10009-96e7-4fc7-b272-b2557ccecca6	Thrissur		f8911f17-19b1-46d9-b708-a727912638c8
ba8619f1-2ca1-42f9-9d4a-44b4d61c5754	Alwar		7b0ea670-6161-44cf-85e4-98e2d2f37975
68fa2028-0805-4dac-a4cc-78c319c48d86	Kakinada		d0a039df-6e75-4597-9f80-fa3a055b0bee
647c4c05-b735-4ae6-843c-0eb0ea1f14f3	Nizamabad		b65398bc-aa42-475d-bc07-a6730719da86
086fc0a1-b293-4e3e-8630-e8849b92c676	Sagar		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
9478a939-76ea-44b1-9183-d4527e50ae35	Tumkur		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
10d966ca-dfa6-44b1-9edc-b5ec8535786e	Hisar		1cb5bf87-e09b-4605-86bb-f11df93794b6
94f276d7-4163-4f69-b2af-441efd835015	Rohtak		1cb5bf87-e09b-4605-86bb-f11df93794b6
eaf3595e-54fa-411b-9cee-ad7da1f04633	Panipat		1cb5bf87-e09b-4605-86bb-f11df93794b6
e272249a-8a23-4ab1-a272-0ab6677d4d68	Darbhanga		aaeb6b5f-0633-47b5-9100-e9024700ece0
013c5bc3-11a3-42b0-943a-075845cd455c	Kharagpur		4d66d7f3-42f7-4fb7-945b-5093e9902b93
faf3826d-4113-474c-be76-904e311b50f0	Aizawl		d0a2b263-0189-4e7b-9422-74d3e3915294
e2a6714a-ab2d-4710-9ecf-6a7911ac988a	Ichalkaranji		afa1a4c7-c742-4deb-ba10-79d131bf2a10
fefbe4c0-cb54-42f6-9dd8-858db280f2a6	Tirupati		d0a039df-6e75-4597-9f80-fa3a055b0bee
7ecb6e04-0ef4-4179-8337-6aca2dbc6cf8	Karnal		1cb5bf87-e09b-4605-86bb-f11df93794b6
2c7cf19b-cb42-4160-a4c2-3c7461eb699e	Bathinda		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
67e75f95-51a6-4d33-96ad-d50c0176c55d	Rampur		d72eae33-d05a-4350-aebf-08cef4fbf34d
c67ffbb3-814f-4f9f-b99e-dae556c12cb1	Shivamogga		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
8d9b7beb-f36f-4482-9ab1-146849e2296a	Ratlam		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
4c933c2a-9110-45a3-936e-217e5462a41b	Modinagar		d72eae33-d05a-4350-aebf-08cef4fbf34d
a9638da5-7793-42bb-9f36-a63d049e2e0e	Durg		ea160870-ab8b-4cae-a772-0a80b566470f
c75dbf29-ba38-488b-aa4d-43156ad54a0f	Shillong		e0173d54-80cd-48c0-9c92-61853ebef7b9
ad63dbaa-0a7f-4d56-9ac0-b5065a6bdd31	Imphal		d7c7eee9-db08-4e00-a306-55790fbb52b5
a83efebe-ea23-41bf-ae3c-ab1f95237021	Hapur		d72eae33-d05a-4350-aebf-08cef4fbf34d
0537fd18-a5ea-45a8-a3ac-41b8d5c15a1d	Ranipet		99c94553-c81e-4dfb-98b1-377247c307bb
7b446eec-5da6-460f-8d30-5ab73d623504	Anantapur		d0a039df-6e75-4597-9f80-fa3a055b0bee
22530d8f-0874-4971-b288-53cb1c85a173	Arrah		aaeb6b5f-0633-47b5-9100-e9024700ece0
48df0320-ede7-4331-90a7-e5729189e264	Karimnagar		b65398bc-aa42-475d-bc07-a6730719da86
ce8c8a06-bdb4-4f4a-94e3-d80583cb094e	Parbhani		afa1a4c7-c742-4deb-ba10-79d131bf2a10
b4b1ae04-ab0b-4239-8f7d-cf9051ee6972	Etawah		d72eae33-d05a-4350-aebf-08cef4fbf34d
9dae48b0-20af-478e-8d21-4d74e809ed66	Bharatpur		7b0ea670-6161-44cf-85e4-98e2d2f37975
d7accaa6-03e8-4deb-b3a7-96b5d651b389	Begusarai		aaeb6b5f-0633-47b5-9100-e9024700ece0
05ce9b8c-14b9-4662-9e43-88059d2735e1	New Delhi		d6b39040-4721-4313-aa69-733bf78b0214
3c73ad00-9150-4a45-810c-6ea7a4febb7b	Chhapra		aaeb6b5f-0633-47b5-9100-e9024700ece0
553777c2-b94e-4237-9025-bb3c13d87f5f	Kadapa		d0a039df-6e75-4597-9f80-fa3a055b0bee
a0eb4b07-f865-4279-acf6-cf00bd3215e7	Ramagundam		b65398bc-aa42-475d-bc07-a6730719da86
78d2c4cf-c700-4505-be41-892691ca9be2	Pali		7b0ea670-6161-44cf-85e4-98e2d2f37975
d5097d11-3fe0-425f-898a-2648c1d71ca6	Satna		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
188814db-3a66-42fc-90d5-923758b4c3f8	Vizianagaram		d0a039df-6e75-4597-9f80-fa3a055b0bee
fd6ed58e-885b-4728-956e-e0c1c6ccf432	Katihar		aaeb6b5f-0633-47b5-9100-e9024700ece0
ba954f90-9e0b-4423-8ff2-65294db0a3d1	Hardwar		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
89fafc21-7cef-49ef-a257-78e1b8825cf9	Sonipat		1cb5bf87-e09b-4605-86bb-f11df93794b6
63e428fb-264a-4919-b537-58f44a0e5e8e	Nagercoil		99c94553-c81e-4dfb-98b1-377247c307bb
02c8d8cd-3b91-4049-ae43-fcb977abe015	Thanjavur		99c94553-c81e-4dfb-98b1-377247c307bb
c792dc62-eb97-4ee9-9884-17d5582176a6	Murwara (Katni)		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
6bfbf162-1440-46ba-a72b-202770169954	Naihati		4d66d7f3-42f7-4fb7-945b-5093e9902b93
91118c6c-0aa4-43d5-8683-0dd37829d74c	Sambhal		d72eae33-d05a-4350-aebf-08cef4fbf34d
b69e068a-9e6e-4862-8b0c-c3e3a2530fa5	Nadiad		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
87ed8305-4dff-4eec-9fcd-805b110ef706	Yamunanagar		1cb5bf87-e09b-4605-86bb-f11df93794b6
da1d6f81-8ab0-42d6-9a6f-70a8250d0bd3	English Bazar		4d66d7f3-42f7-4fb7-945b-5093e9902b93
fe0564f5-ed00-4c84-aada-4e695c2b1845	Eluru		d0a039df-6e75-4597-9f80-fa3a055b0bee
27f46edf-ff29-4fab-92e7-f7b36d71fb5b	Munger		aaeb6b5f-0633-47b5-9100-e9024700ece0
c01ea7d7-e749-44d8-aad1-51fe7b2bdbd3	Panchkula		1cb5bf87-e09b-4605-86bb-f11df93794b6
96ab52c9-7224-4e54-a885-6f33c48792a8	Raayachuru		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
7458c2ab-a5fc-44b2-a970-19d47c8e07b9	Panvel		afa1a4c7-c742-4deb-ba10-79d131bf2a10
bdba39e3-fcde-4cf2-8e4c-c803b319d58f	Deoghar		6c763981-576b-450b-8db6-778b1c243803
5611448a-3530-4030-8029-84652d328b31	Ongole		d0a039df-6e75-4597-9f80-fa3a055b0bee
24e69c56-1961-46df-9f68-6b6dcbf0296a	Nandyal		d0a039df-6e75-4597-9f80-fa3a055b0bee
d932c2fe-7eaa-49da-9661-9cb11d7617e0	Morena		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
32b3a8dd-fd9b-4713-b3a1-3884db683c71	Bhiwani		1cb5bf87-e09b-4605-86bb-f11df93794b6
0f08e079-c5f7-4adf-b885-1b3e2e5edcbe	Porbandar		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
c95b4131-3f40-4cf8-a19a-6ab2ef4bc0eb	Palakkad		f8911f17-19b1-46d9-b708-a727912638c8
9cd72236-cb78-4fac-9d98-38478e89b873	Anand		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
38e9b8c6-4110-485e-99af-d2ecff5553fb	Purnia		aaeb6b5f-0633-47b5-9100-e9024700ece0
c830ca91-760a-4951-9893-cdf522cff6a6	Baharampur		4d66d7f3-42f7-4fb7-945b-5093e9902b93
15064ca6-cfca-4af8-af07-7eb09f9c8107	Barmer		7b0ea670-6161-44cf-85e4-98e2d2f37975
e5bcc89e-a789-4441-af0a-4763f46a164b	Morvi		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
fd0739bc-6fab-4f48-94f6-13823dcc5085	Orai		d72eae33-d05a-4350-aebf-08cef4fbf34d
54b44988-c5be-4cca-83ac-31b59d68613c	Bahraich		d72eae33-d05a-4350-aebf-08cef4fbf34d
fa7590d3-e847-4675-9a8b-851f34806707	Sikar		7b0ea670-6161-44cf-85e4-98e2d2f37975
69b42843-8906-4bbf-911a-a2d6ac093d1b	Vellore		99c94553-c81e-4dfb-98b1-377247c307bb
7a1b69ba-c4e3-4062-bc3c-761c29323d38	Singrauli		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
83672991-67b7-442c-b24a-389728385268	Khammam		b65398bc-aa42-475d-bc07-a6730719da86
8ff20ae9-b9f3-4582-a942-16b750340efc	Mahesana		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
00d4a587-dede-41db-84ba-a7c6df0be4d7	Silchar		694a90d0-c9a5-4835-95df-e9498c78c360
d0839487-e321-4e04-a87b-16e2b9ba633e	Sambalpur		57eb2330-c405-46f3-a60a-0622d0086b77
550d7321-9ee1-41d4-96e5-f4804a28025c	Rewa		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
fb76f1a4-6f6e-4780-9740-5d1c82fc7c6b	Unnao		d72eae33-d05a-4350-aebf-08cef4fbf34d
63dc6663-2ee4-49c9-8b00-a0797e463817	Hugli-Chinsurah		4d66d7f3-42f7-4fb7-945b-5093e9902b93
a355249c-5d21-40f6-9bd6-507b00f1a21f	Raiganj		4d66d7f3-42f7-4fb7-945b-5093e9902b93
6722e0bc-c03f-496b-ac53-a6b682ad0ced	Phusro		6c763981-576b-450b-8db6-778b1c243803
9354cf12-da4d-43cf-8cd8-9a480bb3a3a7	Adityapur		6c763981-576b-450b-8db6-778b1c243803
a1c553e1-96b4-4fc7-b395-f94333161d60	Alappuzha		f8911f17-19b1-46d9-b708-a727912638c8
e9001702-acfb-4f61-b706-45c7edda56cc	Bahadurgarh		1cb5bf87-e09b-4605-86bb-f11df93794b6
04f3d4d6-f3fb-4cc3-a302-7f664421462d	Machilipatnam		d0a039df-6e75-4597-9f80-fa3a055b0bee
201c2df3-d18e-415c-aa5d-2af2b39b659f	Rae Bareli		d72eae33-d05a-4350-aebf-08cef4fbf34d
201937c8-cb6b-44f9-b4c7-f2f1006997d0	Jalpaiguri		4d66d7f3-42f7-4fb7-945b-5093e9902b93
d1f9fc42-80d3-43c9-b8f2-b14c88cbd563	Bharuch		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
d7cc5f3c-c45d-4475-844a-e9d7060d878d	Pathankot		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
c53c4c0f-1f59-4166-b5f0-3c532c3e7322	Hoshiarpur		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
a174c6ff-5375-42ca-a98b-22d665efc483	Baramula		8889d547-3ba6-469e-bcf6-4329aede50b1
ceea6758-1a9f-42bd-8a73-81296c86cbf7	Adoni		d0a039df-6e75-4597-9f80-fa3a055b0bee
222f44ee-58a1-462f-aaea-9b24d7506d4b	Jind		1cb5bf87-e09b-4605-86bb-f11df93794b6
ab336076-7113-4043-8c6f-81471f30f0b0	Tonk		7b0ea670-6161-44cf-85e4-98e2d2f37975
1f4915f6-052a-4d38-a49d-7a343edbd119	Tenali		d0a039df-6e75-4597-9f80-fa3a055b0bee
bf81a8a9-4e55-4a01-a3c8-240eb9ced02e	Kancheepuram		99c94553-c81e-4dfb-98b1-377247c307bb
0233c8ab-2831-4a25-810b-5e2c499e5ec6	Vapi		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
6954274d-3535-41ae-baa0-4786feeaa3d2	Sirsa		1cb5bf87-e09b-4605-86bb-f11df93794b6
65b44bb2-def3-492f-a967-c4a16f0cbbe2	Navsari		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
ec40182e-e4fc-42b0-b069-c7411b4eb300	Mahbubnagar		b65398bc-aa42-475d-bc07-a6730719da86
6cc5fea2-f652-481d-ae3d-d200dba62ff8	Puri		57eb2330-c405-46f3-a60a-0622d0086b77
1d28b0fb-8089-4604-be6d-12b4fe1c72be	Robertson Pet		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
55ef2092-38b3-4ec7-95ca-c7d4cbeab537	Erode		99c94553-c81e-4dfb-98b1-377247c307bb
030fad79-8b58-4883-b066-13cd90caa1d5	Batala		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
c451e5b6-5d82-4159-8794-fe4b920aa261	Haldwani-cum-Kathgodam		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
0a894dbc-6a06-48c9-8f68-2e73cc0220ec	Vidisha		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
17c98fb6-a474-4d68-8801-c0d7e35f771b	Saharsa		aaeb6b5f-0633-47b5-9100-e9024700ece0
ee4f27ab-bd03-449c-ba18-b42c1797db0d	Thanesar		1cb5bf87-e09b-4605-86bb-f11df93794b6
bf7b8749-0631-426b-8b7d-0dac7d4c3db8	Chittoor		d0a039df-6e75-4597-9f80-fa3a055b0bee
9471d5ac-c994-492c-9b03-17b84739afb3	Veraval		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
d6b13d2a-0847-4364-8e30-b397d0ffb09f	Lakhimpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
e6f39854-c5a2-4a48-ab8b-4d5b98e8f714	Sitapur		d72eae33-d05a-4350-aebf-08cef4fbf34d
a1fa23ed-7565-4469-ac3d-e8f1f55f8369	Hindupur		d0a039df-6e75-4597-9f80-fa3a055b0bee
d3ffa6b9-2787-4bbf-b447-c4160073c535	Santipur		4d66d7f3-42f7-4fb7-945b-5093e9902b93
e5ace960-0097-4fd7-a104-59f0151b1720	Balurghat		4d66d7f3-42f7-4fb7-945b-5093e9902b93
09b61eea-e4b9-4c61-ab2e-61c28a7fac91	Ganjbasoda		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
cf5eda5b-ff11-4ac6-a2a7-bb53aacfd159	Moga		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
027afd0a-2bcc-43c4-9c93-9e52cb2096b6	Proddatur		d0a039df-6e75-4597-9f80-fa3a055b0bee
cb68423b-210e-4e04-9127-afa2f43e27c0	Srinagar		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
4360f0f0-6bda-4733-8c17-dad06ecf544c	Medinipur		4d66d7f3-42f7-4fb7-945b-5093e9902b93
6e30aafa-5e32-423e-b26e-10956241942d	Habra		4d66d7f3-42f7-4fb7-945b-5093e9902b93
b2a6a375-d616-4684-9e34-49fcbce41990	Sasaram		aaeb6b5f-0633-47b5-9100-e9024700ece0
16ea02e2-3e2c-4236-9839-737951799bf7	Hajipur		aaeb6b5f-0633-47b5-9100-e9024700ece0
18acb331-5fd1-42ca-87b8-09aacf83fe98	Bhuj		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
bb1aedf7-927c-49d5-bc15-2aa75149f49e	Shivpuri		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
5ec69d9c-9d1b-449b-a4dd-be982f77001b	Ranaghat		4d66d7f3-42f7-4fb7-945b-5093e9902b93
72c4609e-f513-4581-b86c-d61eb1f6e6bb	Shimla		616becf7-866b-4cb6-aa57-0afa29cac4f4
7f0a392c-a2f3-47e3-93ab-cfef07f519e2	Tiruvannamalai		99c94553-c81e-4dfb-98b1-377247c307bb
f42dafb7-ae59-4f02-aa77-9111dbc3f7df	Kaithal		1cb5bf87-e09b-4605-86bb-f11df93794b6
cd0bf674-bb84-441d-af3e-92b36cd113a4	Rajnandgaon		ea160870-ab8b-4cae-a772-0a80b566470f
90d8c011-2b96-4317-bc98-e92b99d4d7e8	Godhra		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
863c8822-28e6-45bc-bdc0-c9fcfb69de4c	Hazaribag		6c763981-576b-450b-8db6-778b1c243803
38c44048-fc16-4a5e-963c-adca1c771e61	Bhimavaram		d0a039df-6e75-4597-9f80-fa3a055b0bee
c9ba5ab2-d840-4a03-8963-1564067553a3	Mandsaur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
222c0c47-2644-40b3-a23e-d748c64948d2	Dibrugarh		694a90d0-c9a5-4835-95df-e9498c78c360
b4f19a6e-2a25-437c-98c3-2f93f39a632d	Kolar		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
c30bfc39-43a1-4ca4-9e65-a4103ac600ec	Bankura		4d66d7f3-42f7-4fb7-945b-5093e9902b93
895ca2aa-b06e-45e9-bb28-a6694bb5a320	Mandya		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
2e3cc39b-a962-4c04-a1c9-2c75d0290e52	Dehri-on-Sone		aaeb6b5f-0633-47b5-9100-e9024700ece0
15448a7e-3b1b-4838-a34e-6c99c8a33921	Madanapalle		d0a039df-6e75-4597-9f80-fa3a055b0bee
95361a28-df98-475b-8af7-6a72744d91ed	Malerkotla		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
5ea45454-f773-4e71-bb63-f7791bb75470	Lalitpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
4074ddbc-487b-473d-ae52-0c1abe49c544	Bettiah		aaeb6b5f-0633-47b5-9100-e9024700ece0
ad7deb9f-a1fc-4b9c-b64f-70a60b2f68f6	Pollachi		99c94553-c81e-4dfb-98b1-377247c307bb
261ae7d8-4383-4dbc-8846-72c09bca901e	Khanna		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
99e73490-3e54-414f-be3a-951f31e20f15	Neemuch		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
d8935cec-0027-4999-89c7-4c21435dccb9	Palwal		1cb5bf87-e09b-4605-86bb-f11df93794b6
d5a040f9-5153-4f6f-8df2-4115b3dcc270	Palanpur		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
16cb332c-e48f-45ef-b780-d6c8bcd84f0f	Guntakal		d0a039df-6e75-4597-9f80-fa3a055b0bee
f44c6da3-b7a4-4cdc-86e2-b6f9bad5d72d	Nabadwip		4d66d7f3-42f7-4fb7-945b-5093e9902b93
fe2dfa4e-0f13-4124-926e-23a22dd5bdc6	Udupi		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
c6b70021-a74f-4db7-b704-ceda5b69a980	Jagdalpur		ea160870-ab8b-4cae-a772-0a80b566470f
898bf280-9d8c-466b-9721-1d58ba8ec346	Motihari		aaeb6b5f-0633-47b5-9100-e9024700ece0
de2a427c-0cd1-40be-a219-dc0906505b6a	Pilibhit		d72eae33-d05a-4350-aebf-08cef4fbf34d
dc6912ad-8bfc-447a-b68f-7ed2ebc4542b	Dimapur		1e973ad2-b99d-4bc8-b688-8e9c8d84acdf
f75c75b5-a041-4494-9db9-18a9ad7ef62d	Mohali		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
cf82ccb1-d90a-4943-8524-8168851662d5	Sadulpur		7b0ea670-6161-44cf-85e4-98e2d2f37975
19ed2ce4-b908-4129-963b-3401411c9fb6	Rajapalayam		99c94553-c81e-4dfb-98b1-377247c307bb
dfa61182-6f3c-4a77-9974-cc51b03506bb	Dharmavaram		d0a039df-6e75-4597-9f80-fa3a055b0bee
c42f03e9-acce-4f62-b2bf-48ea66c9104d	Kashipur		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
eecb5bf4-c390-47e5-9027-f43ba3cdf536	Sivakasi		99c94553-c81e-4dfb-98b1-377247c307bb
774ea389-dd10-4055-aad2-b45b214b4a32	Darjiling		4d66d7f3-42f7-4fb7-945b-5093e9902b93
385ab40a-1bfc-433b-bc2b-d7eab46d4311	Chikkamagaluru		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
7459843a-71ac-4859-820c-b3d14e8aac16	Gudivada		d0a039df-6e75-4597-9f80-fa3a055b0bee
ead6a692-b4bb-429a-bf04-e655ae552187	Baleshwar Town		57eb2330-c405-46f3-a60a-0622d0086b77
8b56f3e8-b932-4f9f-8ff6-e0282a78339a	Mancherial		b65398bc-aa42-475d-bc07-a6730719da86
7bd03c70-69d1-4093-a5f3-d1dc3a2f9287	Srikakulam		d0a039df-6e75-4597-9f80-fa3a055b0bee
f3d439ce-fc18-4684-8980-4369ce32cd93	Adilabad		b65398bc-aa42-475d-bc07-a6730719da86
43b966e6-e213-4426-9246-748b50cee576	Yavatmal		afa1a4c7-c742-4deb-ba10-79d131bf2a10
e3d1a0b0-0eef-4575-a483-3436c31731d0	Barnala		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
7b2c7dc5-c5cf-4b10-9e96-bc3c33f79a93	Nagaon		694a90d0-c9a5-4835-95df-e9498c78c360
910384e4-3a7d-47f1-af98-0bd489001841	Narasaraopet		d0a039df-6e75-4597-9f80-fa3a055b0bee
70158b8c-ef73-4393-be24-bb47f2271de1	Raigarh		ea160870-ab8b-4cae-a772-0a80b566470f
2c693963-3b7a-43ad-9b0c-8e041985778d	Roorkee		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
17e88a5f-d8a1-492c-a52f-f1e2774b6f19	Valsad		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
f0d1903a-164e-48b9-8548-44a495c5ab8d	Ambikapur		ea160870-ab8b-4cae-a772-0a80b566470f
6e2d7c8b-c551-4dbc-828a-b099d6404e1b	Giridih		6c763981-576b-450b-8db6-778b1c243803
d61d6b93-bb38-4def-b6fc-3a499f39c359	Chandausi		d72eae33-d05a-4350-aebf-08cef4fbf34d
fbc0be63-505a-4abe-925a-35289b923595	Purulia		4d66d7f3-42f7-4fb7-945b-5093e9902b93
efbedad8-eb2b-43c0-9b98-c4c5ceebd960	Patan		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
17b43dc4-3719-43ad-adda-1a581767a320	Bagaha		aaeb6b5f-0633-47b5-9100-e9024700ece0
16b403fd-b9c3-4e00-a8c3-a2b056312589	Hardoi 		d72eae33-d05a-4350-aebf-08cef4fbf34d
c979cc31-2fb3-4a3b-873f-4a8749622179	Achalpur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
6fc221e9-77f0-4b08-83b6-7457e6c68e1f	Osmanabad		afa1a4c7-c742-4deb-ba10-79d131bf2a10
4bfbd0ee-aa7b-439e-9395-92d6febbc3ca	Deesa		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
4957729b-59fa-44d4-a243-11cca262b88d	Nandurbar		afa1a4c7-c742-4deb-ba10-79d131bf2a10
33a6759b-f2f9-4774-952c-c5c31e7beb32	Azamgarh		d72eae33-d05a-4350-aebf-08cef4fbf34d
deffafcc-c241-4665-832e-8e08c0a4ad16	Ramgarh		6c763981-576b-450b-8db6-778b1c243803
be3c98c4-9c46-48e2-a23e-e8c7ace18357	Firozpur		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
f1f20da8-3368-4746-84d9-46cbab3577f3	Baripada Town		57eb2330-c405-46f3-a60a-0622d0086b77
09781210-555b-44db-969e-db443d2c5d37	Karwar		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
4eef26ff-474d-4f87-803f-75b77b75a2d1	Siwan		aaeb6b5f-0633-47b5-9100-e9024700ece0
76bdb029-0fc8-4790-a1f2-ee215be07d5a	Rajampet		d0a039df-6e75-4597-9f80-fa3a055b0bee
015e8e75-e539-4723-9c24-0eec5dde2701	Pudukkottai		99c94553-c81e-4dfb-98b1-377247c307bb
ebe8c8a0-2b64-4657-b444-17d1d9e89678	Anantnag		8889d547-3ba6-469e-bcf6-4329aede50b1
51ba3499-19ac-4a0f-94a2-e60a3c12cde9	Tadpatri		d0a039df-6e75-4597-9f80-fa3a055b0bee
092f288f-8103-47c4-88b8-e7b681f60da0	Satara		afa1a4c7-c742-4deb-ba10-79d131bf2a10
be9b24fc-23ab-4dcd-8205-3d60ec062aaa	Bhadrak		57eb2330-c405-46f3-a60a-0622d0086b77
9e2b8e09-e5b3-4a0e-b824-42cb469968f8	Kishanganj		aaeb6b5f-0633-47b5-9100-e9024700ece0
0fcddbc2-40e2-46ac-90a9-49cd6dd22049	Suryapet		b65398bc-aa42-475d-bc07-a6730719da86
771f6d37-ec30-44f9-89d6-503a0298b349	Wardha		afa1a4c7-c742-4deb-ba10-79d131bf2a10
957c6041-14a6-4943-aadd-243b36ef9781	Ranebennuru		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
634ded4d-7740-4de1-ab68-f292bda05628	Amreli		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
f8e82e48-0ea6-4f4b-8bb8-100eec40a80f	Neyveli (TS)		99c94553-c81e-4dfb-98b1-377247c307bb
a3778bd2-4381-4b57-bfae-380754763390	Jamalpur		aaeb6b5f-0633-47b5-9100-e9024700ece0
3e5964d8-dadc-4b46-80f7-1e6aafe11654	Marmagao		3f7d7055-8b25-4f89-9765-0cd37dd0a99c
48d888c0-c214-42ef-978a-805d4d056ded	Udgir		afa1a4c7-c742-4deb-ba10-79d131bf2a10
61256612-bac9-4cf9-a777-a4fe02a2df70	Tadepalligudem		d0a039df-6e75-4597-9f80-fa3a055b0bee
70c381d6-58d1-41ed-92fc-55e0b9b2b55f	Nagapattinam		99c94553-c81e-4dfb-98b1-377247c307bb
f18a4278-b6ab-4618-aea7-644a71194926	Buxar		aaeb6b5f-0633-47b5-9100-e9024700ece0
504dcf33-992e-4b47-ac63-f2c15345c8e4	Aurangabad		afa1a4c7-c742-4deb-ba10-79d131bf2a10
b1f26f86-83f3-4b54-a9c2-59240e945001	Jehanabad		aaeb6b5f-0633-47b5-9100-e9024700ece0
f4c73c0f-8ab2-403d-879d-841c74687868	Phagwara		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
de2045be-6d92-4e07-846a-080c86a45dd9	Khair		d72eae33-d05a-4350-aebf-08cef4fbf34d
e7787a8b-a420-4b9d-9a1d-cfd4376bf01f	Sawai Madhopur		7b0ea670-6161-44cf-85e4-98e2d2f37975
371e1b66-7fae-4b2c-95d9-0381495ebe4a	Kapurthala		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
b867fda9-b2db-4535-b176-67cee5436ca2	Chilakaluripet		d0a039df-6e75-4597-9f80-fa3a055b0bee
fcd23faf-90e5-4c9d-a4b1-f90b3c5027f5	Aurangabad		aaeb6b5f-0633-47b5-9100-e9024700ece0
aa1a6227-8785-4b17-b2ab-b5a843487b81	Malappuram		f8911f17-19b1-46d9-b708-a727912638c8
4ab51f23-1ba9-4974-b171-90e9a5908b2c	Rewari		1cb5bf87-e09b-4605-86bb-f11df93794b6
bd657ead-4110-426f-a95d-9c82f54b2e8c	Nagaur		7b0ea670-6161-44cf-85e4-98e2d2f37975
24fa45ec-523c-425e-a20a-ee4c9843f424	Sultanpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
ea37c23d-ccc2-4ca9-bdbd-c39428c6c039	Nagda		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
9eaf98a9-949a-46b8-a87e-43ff24db5874	Port Blair		9d282558-9e18-4c41-a0a7-08116e012a81
17fba0f2-054c-4b05-8f0d-5795f0115fec	Lakhisarai		aaeb6b5f-0633-47b5-9100-e9024700ece0
7fb410ec-b0ca-4df9-9f97-6a9b35460225	Panaji		3f7d7055-8b25-4f89-9765-0cd37dd0a99c
d2120bbe-c2d9-4db2-974d-a8cefe2040b7	Tinsukia		694a90d0-c9a5-4835-95df-e9498c78c360
b9bfbefe-53df-493a-8647-4e63d318aa10	Itarsi		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
64aba091-dac7-4e80-a3bf-7189f26d571a	Kohima		1e973ad2-b99d-4bc8-b688-8e9c8d84acdf
c677ce1c-2461-477b-aeb6-0518cad0ba63	Balangir		57eb2330-c405-46f3-a60a-0622d0086b77
9f116da8-53d0-48d3-b82d-d90d4c56833b	Nawada		aaeb6b5f-0633-47b5-9100-e9024700ece0
98446b7a-4474-426b-a100-c2ac6f625a59	Jharsuguda		57eb2330-c405-46f3-a60a-0622d0086b77
bd6015fa-e4a4-4bfb-9023-dea0170c8fdd	Jagtial		b65398bc-aa42-475d-bc07-a6730719da86
9066c16f-2e05-4496-bf08-329b2a154ade	Viluppuram		99c94553-c81e-4dfb-98b1-377247c307bb
97c812f2-1bf2-4195-a6a1-4720d2a5e299	Amalner		afa1a4c7-c742-4deb-ba10-79d131bf2a10
993d159d-2b6d-42c2-a735-90f595c53351	Zirakpur		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
4e72c301-0a5c-49ee-9838-9ed14cdaa9a3	Tanda		d72eae33-d05a-4350-aebf-08cef4fbf34d
49c7b652-4dd4-4afb-8e1e-5cd289a9c1b0	Tiruchengode		99c94553-c81e-4dfb-98b1-377247c307bb
249df524-4fc0-442a-805a-d5cb9522a972	Nagina		d72eae33-d05a-4350-aebf-08cef4fbf34d
5e6d5776-0425-4deb-b74b-e91dba206fcb	Yemmiganur		d0a039df-6e75-4597-9f80-fa3a055b0bee
317fefdd-d431-476a-a9ac-f8f6691a2d6c	Vaniyambadi		99c94553-c81e-4dfb-98b1-377247c307bb
202b6b92-84e8-43d0-935a-0185d9b7d7a0	Sarni		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
80adffdb-974a-4217-9476-8708e9a5b306	Theni Allinagaram		99c94553-c81e-4dfb-98b1-377247c307bb
f8b08eba-35d7-4059-a90b-8f1a8b6dbe15	Margao		3f7d7055-8b25-4f89-9765-0cd37dd0a99c
aa8f4ebd-91b0-4ce2-b7d7-9feec73ee96f	Akot		afa1a4c7-c742-4deb-ba10-79d131bf2a10
4273be61-deb0-46f1-abf2-d9b38de7d74f	Sehore		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
0ee69ef1-b4b4-45ff-be0a-93a5102b25fd	Mhow Cantonment		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
64df9278-5d4e-487f-82d1-dd5e2083b446	Kot Kapura		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
f997d29f-71a0-48e9-bd0f-dc9e124be5e5	Makrana		7b0ea670-6161-44cf-85e4-98e2d2f37975
746f793a-b0b6-4325-9474-452dd51bce7f	Pandharpur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
dad6fefc-e31f-4052-826e-77ba6b083939	Miryalaguda		b65398bc-aa42-475d-bc07-a6730719da86
0a69e8f2-fb8b-405c-a00a-8136c885f6de	Shamli		d72eae33-d05a-4350-aebf-08cef4fbf34d
ad034ddf-73a0-4c33-94c1-5f911a77f953	Seoni		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
21b562d6-6ee1-4c8b-9d91-41a95f0788c4	Ranibennur		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
92fda418-3ef6-4f27-a49c-eb2ceddc4dc6	Kadiri		d0a039df-6e75-4597-9f80-fa3a055b0bee
97664b37-2b56-44c5-bc5a-2aab347ed11f	Shrirampur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
7f272934-7372-496a-b9ff-4907653cf601	Rudrapur		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
b03278ae-8fc4-475e-ad19-be0c9f1f4198	Parli		afa1a4c7-c742-4deb-ba10-79d131bf2a10
a8e49992-a9fd-4729-8abb-9ff19a0efdda	Najibabad		d72eae33-d05a-4350-aebf-08cef4fbf34d
ef456785-7e46-4899-8dd2-8aca450e4c1a	Nirmal		b65398bc-aa42-475d-bc07-a6730719da86
fa9fe0bb-eb0e-455b-a74f-dc431a458e6b	Udhagamandalam		99c94553-c81e-4dfb-98b1-377247c307bb
37d1d67d-af9d-48e2-9d33-7983c8f73174	Shikohabad		d72eae33-d05a-4350-aebf-08cef4fbf34d
55f14af3-cb8e-4660-98ff-6bbc0d63b3ff	Jhumri Tilaiya		6c763981-576b-450b-8db6-778b1c243803
1bf96c1d-94c4-407f-98dd-0c30bd18f154	Aruppukkottai		99c94553-c81e-4dfb-98b1-377247c307bb
50e4887f-8fb4-47d6-9033-eafa4dc2230a	Ponnani		f8911f17-19b1-46d9-b708-a727912638c8
01e53237-b476-48af-bdd3-fd1df2a3fe81	Jamui		aaeb6b5f-0633-47b5-9100-e9024700ece0
f2590902-c20d-4da8-9cca-622539001528	Sitamarhi		aaeb6b5f-0633-47b5-9100-e9024700ece0
43b19c8b-f39e-43bb-9f32-36cc2f1e6c12	Chirala		d0a039df-6e75-4597-9f80-fa3a055b0bee
5ea81c6a-1a14-4213-8949-08a773917a4b	Anjar		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
15cf4c87-6c91-4228-9f78-aa46683c781b	Karaikal		fdc8eeae-14e2-45bb-b91c-88f586bde4eb
e61980ae-6161-464d-bdfc-6f1a40b57859	Hansi		1cb5bf87-e09b-4605-86bb-f11df93794b6
3d0141fc-e4eb-4f58-92a7-1ff36088f076	Anakapalle		d0a039df-6e75-4597-9f80-fa3a055b0bee
55454677-2b54-4974-a8ea-90c2cf347782	Mahasamund		ea160870-ab8b-4cae-a772-0a80b566470f
c9b1500e-af87-4b5d-84a9-c22abd4acc53	Faridkot		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
ccf231b3-4104-4680-aecb-ef6857ede4d7	Saunda		6c763981-576b-450b-8db6-778b1c243803
d8ec89c4-871a-49fd-813e-77481327410b	Dhoraji		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
89eaee0b-717f-4d25-92ce-094a2e8a055a	Paramakudi		99c94553-c81e-4dfb-98b1-377247c307bb
c2b84ed0-00ca-4587-b8f7-2888699fe454	Balaghat		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
ca6e1fe8-6bc8-42c9-9563-772ff85a6ddd	Sujangarh		7b0ea670-6161-44cf-85e4-98e2d2f37975
988be6b0-66c3-4af2-ad98-5641b0589d8e	Khambhat		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
cdb9948c-3f7b-4ba6-8cc4-d28fc42f53f7	Muktsar		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
02ecac2e-f315-4905-9e14-9b02ad816be4	Rajpura		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
2925a7e4-f8c7-4490-b337-e8cff4c24f97	Kavali		d0a039df-6e75-4597-9f80-fa3a055b0bee
817dd9fe-e1bc-4a24-a460-95767369871f	Dhamtari		ea160870-ab8b-4cae-a772-0a80b566470f
a97fbb19-6622-4948-9380-e56b3b8327fd	Ashok Nagar		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
2586616e-66aa-47b4-a06a-c01cd1f1298c	Sardarshahar		7b0ea670-6161-44cf-85e4-98e2d2f37975
2df58c83-4b79-4c6e-9957-da6b7d6fc9bd	Mahuva		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
16b633e0-712f-4b55-8e43-10600c19adbd	Bargarh		57eb2330-c405-46f3-a60a-0622d0086b77
fc6b9f77-b9e3-4c80-8b79-484148315064	Kamareddy		b65398bc-aa42-475d-bc07-a6730719da86
46e04b8f-9ba7-4688-8745-8458ed6b57d3	Sahibganj		6c763981-576b-450b-8db6-778b1c243803
3299e8db-13d1-4569-9147-136a611ab1b4	Kothagudem		b65398bc-aa42-475d-bc07-a6730719da86
12104716-8324-4a4c-9b00-ce0767c7ab3a	Ramanagaram		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
29d63511-056d-41a0-b324-0773bce9f65c	Gokak		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
1cc7b360-7459-4f70-a7e2-09969248ff96	Tikamgarh		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
e57f1154-7d42-4961-b6a9-9cefb819f8fb	Araria		aaeb6b5f-0633-47b5-9100-e9024700ece0
a9055f74-1f0d-465b-8863-b1b593d6ad5d	Rishikesh		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
6eb1c7a5-7b0f-41d4-b46e-29de228449eb	Shahdol		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
970b09d3-3881-4a5b-8487-19d4d1312ed9	Medininagar (Daltonganj)		6c763981-576b-450b-8db6-778b1c243803
405b426e-2745-4734-8e32-67da138336dc	Arakkonam		99c94553-c81e-4dfb-98b1-377247c307bb
cab08206-5998-4db0-a0f9-28144c14c8e3	Washim		afa1a4c7-c742-4deb-ba10-79d131bf2a10
f3feed00-1302-4ff8-9083-a13d3c696952	Sangrur		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
e1111e56-0ca6-4930-b39a-e2a1d7958d59	Bodhan		b65398bc-aa42-475d-bc07-a6730719da86
82e37e8e-0cd9-4aa4-a9b1-8d62393ed2a8	Fazilka		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
500a486d-0370-4178-82f2-02c64674c0ce	Palacole		d0a039df-6e75-4597-9f80-fa3a055b0bee
90642d39-d03d-49b6-88ec-200c2e0b748d	Keshod		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
acbc8c58-5fe9-4eff-b702-74a5a04f0908	Sullurpeta		d0a039df-6e75-4597-9f80-fa3a055b0bee
0695511e-94e6-4a73-9001-9821e1e1a147	Wadhwan		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
d30d6bbf-f95a-456f-953e-4ba74b1696ee	Gurdaspur		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
938b5104-aa15-4b20-aca7-ebe9ceb4faf9	Vatakara		f8911f17-19b1-46d9-b708-a727912638c8
feba19f3-6b5a-4859-aca7-78198f0c4586	Tura		e0173d54-80cd-48c0-9c92-61853ebef7b9
24694d5f-b02d-4c43-8908-dc1920a1d947	Narnaul		1cb5bf87-e09b-4605-86bb-f11df93794b6
fb4b49f1-c45f-4999-9d1b-edf724613c0b	Kharar		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
02a5d56c-7e71-4809-ab02-4149892095ea	Yadgir		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
1b434f53-dc30-4f09-a7cd-afbe0060d884	Ambejogai		afa1a4c7-c742-4deb-ba10-79d131bf2a10
04231bf4-85e0-416f-99ea-ae7c66fe6562	Ankleshwar		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
08900c52-613d-4150-b992-7a375a50d4a5	Savarkundla		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
adef693e-eadc-4bc0-adc0-50b7413465d9	Paradip		57eb2330-c405-46f3-a60a-0622d0086b77
c385896e-38a5-4fd8-9e68-0cd63b3d0b1e	Virudhachalam		99c94553-c81e-4dfb-98b1-377247c307bb
0215cb35-3d42-4f8c-9e09-99660b29f7d9	Kanhangad		f8911f17-19b1-46d9-b708-a727912638c8
092e20de-e4bf-4cd4-9615-1eea66039de6	Kadi		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
1b0bc1f5-1e62-42ed-b359-e2a6a5a57f59	Srivilliputhur		99c94553-c81e-4dfb-98b1-377247c307bb
0708009b-40e3-4b3c-b7c1-5943504e7152	Gobindgarh		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
3d281e55-e233-4fa5-83a3-61850be81fea	Tindivanam		99c94553-c81e-4dfb-98b1-377247c307bb
f23f83f1-b38b-409e-ab71-9dfbe6fc28c5	Mansa		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
4519a113-e602-43f4-9c97-548606680bf7	Taliparamba		f8911f17-19b1-46d9-b708-a727912638c8
74134cd9-628a-4bb1-a09e-a3b6333efd5a	Manmad		afa1a4c7-c742-4deb-ba10-79d131bf2a10
20e72f38-afcb-4dc5-b395-84ddae017aba	Tanuku		d0a039df-6e75-4597-9f80-fa3a055b0bee
327432b6-7ab1-442f-aacb-32cf222efe48	Rayachoti		d0a039df-6e75-4597-9f80-fa3a055b0bee
c73ea825-8ea6-4c6d-98ca-864723285d57	Virudhunagar		99c94553-c81e-4dfb-98b1-377247c307bb
f145b787-5a03-4977-8842-0e924db6119f	Koyilandy		f8911f17-19b1-46d9-b708-a727912638c8
af655351-ada5-4299-b4f7-ad4c49dd8a4c	Jorhat		694a90d0-c9a5-4835-95df-e9498c78c360
9626145b-0bc8-4c6e-907d-b7985573253f	Karur		99c94553-c81e-4dfb-98b1-377247c307bb
66e60dca-3ca8-4489-8728-1428e5cc2cdd	Valparai		99c94553-c81e-4dfb-98b1-377247c307bb
ac62b086-417d-46e6-8244-6bffaf828a73	Srikalahasti		d0a039df-6e75-4597-9f80-fa3a055b0bee
4eff4941-26c5-4cab-9953-c2334acdab2d	Neyyattinkara		f8911f17-19b1-46d9-b708-a727912638c8
cdd3c188-cb99-4ac9-8b46-2cc6610448f7	Bapatla		d0a039df-6e75-4597-9f80-fa3a055b0bee
5934a2e0-7e35-4308-8fd0-8a3fc5353b02	Fatehabad		1cb5bf87-e09b-4605-86bb-f11df93794b6
da5c89fa-38dd-4ff2-9e0b-efcd61f0930d	Malout		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
0278b07d-3128-4890-a4a7-5825f1929f2c	Sankarankovil		99c94553-c81e-4dfb-98b1-377247c307bb
3f6bc379-4a4c-4fc4-b81e-846ee3f07308	Tenkasi		99c94553-c81e-4dfb-98b1-377247c307bb
251f09c1-7828-47b3-8e09-4dfcc80325c0	Ratnagiri		afa1a4c7-c742-4deb-ba10-79d131bf2a10
8a00d3e3-70e5-402a-9f98-9986bfb8eab6	Rabkavi Banhatti		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
79afcf6f-ef14-4128-8c4e-0d5803578ccf	Sikandrabad		d72eae33-d05a-4350-aebf-08cef4fbf34d
c37d0960-60ef-4820-830e-d62a5a9693aa	Chaibasa		6c763981-576b-450b-8db6-778b1c243803
eddedefc-b217-4fb3-9fc7-8d7b91952b42	Chirmiri		ea160870-ab8b-4cae-a772-0a80b566470f
ede60c76-644f-4026-87dc-c45d958366d2	Palwancha		b65398bc-aa42-475d-bc07-a6730719da86
8ebfe7d7-ac40-49c5-904a-012158d9c741	Bhawanipatna		57eb2330-c405-46f3-a60a-0622d0086b77
0309e28f-5838-4bec-9522-98adccb71a27	Kayamkulam		f8911f17-19b1-46d9-b708-a727912638c8
d940ddfa-cf85-4033-af51-32c4fa89904a	Pithampur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
40a08208-a24c-4d04-bf8d-bd9b1bd39787	Nabha		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
d205eb8b-cce7-4e48-94d9-670309071b32	Shahabad, Hardoi		d72eae33-d05a-4350-aebf-08cef4fbf34d
5806a662-3be8-400a-8128-75d5a40154a8	Dhenkanal		57eb2330-c405-46f3-a60a-0622d0086b77
cbbf7cca-d439-49e3-8e3f-eaad9d48687e	Uran Islampur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
eba82569-3938-4d40-9f1b-073562939d9d	Gopalganj		aaeb6b5f-0633-47b5-9100-e9024700ece0
10e7bda5-ddb7-46bb-b2f3-b60e25d6e1ab	Bongaigaon City		694a90d0-c9a5-4835-95df-e9498c78c360
867bd9d2-6dd9-42bb-aa6f-b1631d873c94	Palani		99c94553-c81e-4dfb-98b1-377247c307bb
322dfac1-e1d8-4c1f-a473-7907ef28e811	Pusad		afa1a4c7-c742-4deb-ba10-79d131bf2a10
886e339b-8e97-4b55-9127-c8b4c75b7f27	Sopore		8889d547-3ba6-469e-bcf6-4329aede50b1
8ba9a86c-9c85-4a4d-9b8e-a4fd78f99a99	Pilkhuwa		d72eae33-d05a-4350-aebf-08cef4fbf34d
ea1826dd-1e4f-4ef7-ae92-4462ea1fb6ed	Tarn Taran		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
3ac59625-4119-45ea-87cd-793ef5152429	Renukoot		d72eae33-d05a-4350-aebf-08cef4fbf34d
95e7c323-af8e-4305-a376-21e73e536d75	Mandamarri		b65398bc-aa42-475d-bc07-a6730719da86
f96947c9-4d73-4ac5-a208-44cb7a3d3f17	Shahabad		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
76c3a0c4-bf97-497d-b41d-4c82a6877bff	Barbil		57eb2330-c405-46f3-a60a-0622d0086b77
bed86933-520f-4c55-a334-7e84b90243f3	Koratla		b65398bc-aa42-475d-bc07-a6730719da86
e9ef0c68-d94d-4298-aef2-3f9b7ea8b6b5	Madhubani		aaeb6b5f-0633-47b5-9100-e9024700ece0
9bf6d70e-2dc9-43eb-b5d3-e7fd52b52ce6	Arambagh		4d66d7f3-42f7-4fb7-945b-5093e9902b93
63f03ffd-14e6-40aa-beb4-0af6ed5994bc	Gohana		1cb5bf87-e09b-4605-86bb-f11df93794b6
9155f40d-8302-4e3c-8f64-7cc2ecc3e343	Ladnu		7b0ea670-6161-44cf-85e4-98e2d2f37975
a3d2c0d6-413f-4597-8608-0d9ffe25282c	Pattukkottai		99c94553-c81e-4dfb-98b1-377247c307bb
9560f1b4-c55e-4ff6-9041-3b3303783634	Sirsi		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
a186d51d-0788-4340-9682-2f9949b66388	Sircilla		b65398bc-aa42-475d-bc07-a6730719da86
bdbf322f-ef49-4e48-bdcf-900df6cc9af1	Tamluk		4d66d7f3-42f7-4fb7-945b-5093e9902b93
9898d470-1425-4448-bc16-517063d6ad91	Jagraon		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
58833e01-7dcc-490c-b609-e73d31ade0a9	AlipurdUrban Agglomerationr		4d66d7f3-42f7-4fb7-945b-5093e9902b93
07920fed-7c2a-4b19-90cb-212641182c6e	Alirajpur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
561f9e7a-42c1-4bfc-b47d-9ce7f7d52811	Tandur		b65398bc-aa42-475d-bc07-a6730719da86
129f9042-e098-49d2-897e-77c6e94d2251	Naidupet		d0a039df-6e75-4597-9f80-fa3a055b0bee
fe5e86da-8ace-49dc-8638-e4962ddf9197	Tirupathur		99c94553-c81e-4dfb-98b1-377247c307bb
e881014a-a041-40fc-81ee-a98763f42468	Tohana		1cb5bf87-e09b-4605-86bb-f11df93794b6
6ce90910-4238-4641-87a8-041bd38372cb	Ratangarh		7b0ea670-6161-44cf-85e4-98e2d2f37975
44db0add-50f7-45dc-86f8-d4b0cd4274ef	Dhubri		694a90d0-c9a5-4835-95df-e9498c78c360
ffb0e1ba-9b88-4438-9217-e007d8d470d5	Masaurhi		aaeb6b5f-0633-47b5-9100-e9024700ece0
ef390d41-b220-4e96-b427-6f1bdebbeb25	Visnagar		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
28f8581b-0857-4735-a684-6e0818bdf0ac	Vrindavan		d72eae33-d05a-4350-aebf-08cef4fbf34d
e050dd9a-d9a1-4ed0-a218-506c7e962a18	Nokha		7b0ea670-6161-44cf-85e4-98e2d2f37975
ff27e8bf-c153-4cae-a8a5-4cd47026aa39	Nagari		d0a039df-6e75-4597-9f80-fa3a055b0bee
fd2cc21b-6412-4c73-a6ba-d007e8bc7419	Narwana		1cb5bf87-e09b-4605-86bb-f11df93794b6
85e50951-86fc-4bfa-a752-b8e48d5f2dea	Ramanathapuram		99c94553-c81e-4dfb-98b1-377247c307bb
8c73d051-1368-4e5f-902e-db06ccf76c07	Ujhani		d72eae33-d05a-4350-aebf-08cef4fbf34d
bd52e54f-60fa-42a7-940b-9ccb1d93baee	Samastipur		aaeb6b5f-0633-47b5-9100-e9024700ece0
b9f053a3-91ca-47ae-b636-c08fc7155ba4	Laharpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
f0c99fbe-3e1d-497d-ba53-a9b40eb41aee	Sangamner		afa1a4c7-c742-4deb-ba10-79d131bf2a10
2c388922-353e-46be-9b30-b0e05e83003c	Nimbahera		7b0ea670-6161-44cf-85e4-98e2d2f37975
d1b8d32b-0e76-43e2-8dde-4db941a06863	Siddipet		b65398bc-aa42-475d-bc07-a6730719da86
b829cfa6-94d5-4964-a158-61bb5a4fcc1a	Suri		4d66d7f3-42f7-4fb7-945b-5093e9902b93
9a1966d1-d4f3-46f6-bc22-05d91ed372f1	Diphu		694a90d0-c9a5-4835-95df-e9498c78c360
7b69cb73-864a-47d5-a4df-b115039cbc62	Jhargram		4d66d7f3-42f7-4fb7-945b-5093e9902b93
1a5e1714-ed64-4c96-8f93-04cb411ba4b5	Shirpur-Warwade		afa1a4c7-c742-4deb-ba10-79d131bf2a10
992b51db-2c8e-4190-8c57-1257ff40c198	Tilhar		d72eae33-d05a-4350-aebf-08cef4fbf34d
6e59317a-d7cf-49d0-9274-f30c883157a9	Sindhnur		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
9fd34ff1-eef9-46dc-b8ff-e045e09a9e8e	Udumalaipettai		99c94553-c81e-4dfb-98b1-377247c307bb
7c50377e-7c87-4062-8453-69f38e5b574f	Malkapur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
df08ebb2-9c90-4eb1-809a-9a0263e98cc1	Wanaparthy		b65398bc-aa42-475d-bc07-a6730719da86
b17bb48d-0ff3-410c-bcef-0c43ec96ec39	Gudur		d0a039df-6e75-4597-9f80-fa3a055b0bee
53c1583f-c138-4a72-8f45-89ba7ff6e9a0	Kendujhar		57eb2330-c405-46f3-a60a-0622d0086b77
b9ac6de8-8613-44a6-b97e-43d774f2e15e	Mandla		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
8c0ff690-9b01-42f4-92c7-7814638f82ac	Mandi		616becf7-866b-4cb6-aa57-0afa29cac4f4
7f378b42-6205-422f-a814-158ea8221c1d	Nedumangad		f8911f17-19b1-46d9-b708-a727912638c8
ead07dd9-3c0f-480f-849b-e76532d6fc75	North Lakhimpur		694a90d0-c9a5-4835-95df-e9498c78c360
2da4835e-d561-4808-8043-5d1dcebe4d95	Vinukonda		d0a039df-6e75-4597-9f80-fa3a055b0bee
5bc428cd-9883-4b6c-8595-cfd03d68e924	Tiptur		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
c14b3c61-7b0d-42a1-ad13-fbf0739a3b99	Gobichettipalayam		99c94553-c81e-4dfb-98b1-377247c307bb
9d23ec46-da08-4afc-a693-dc2e4a542a54	Sunabeda		57eb2330-c405-46f3-a60a-0622d0086b77
14441085-57e3-4414-ba78-3571f8aeb3ed	Wani		afa1a4c7-c742-4deb-ba10-79d131bf2a10
0214f50c-abc5-4e9d-b43e-8d2e992a913b	Upleta		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
ee1f8966-a458-4b2a-b11c-ec5cd7f3c44c	Narasapuram		d0a039df-6e75-4597-9f80-fa3a055b0bee
626f2aa3-327c-41bb-9bfc-37b52a2c15d7	Nuzvid		d0a039df-6e75-4597-9f80-fa3a055b0bee
1a97a461-9ddb-4eea-9f53-4394cab73e86	Tezpur		694a90d0-c9a5-4835-95df-e9498c78c360
2327bb75-d7b9-49d2-945b-5f3451e64d5c	Una		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
7c503d6f-5d94-4088-87f1-a5385d1e0a8c	Markapur		d0a039df-6e75-4597-9f80-fa3a055b0bee
9e574d01-7b1a-4e67-a608-9f6d1e45f6d0	Sheopur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
7786b4c6-eb7c-47cd-8130-fb65b8011de7	Thiruvarur		99c94553-c81e-4dfb-98b1-377247c307bb
aeccbba9-743b-4210-b99e-4fac7c7d9894	Sidhpur		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
f04e0ccf-9a2f-4d2a-a74e-7059877ded37	Sahaswan		d72eae33-d05a-4350-aebf-08cef4fbf34d
1b9d7262-a595-4424-812d-3e909761b715	Suratgarh		7b0ea670-6161-44cf-85e4-98e2d2f37975
fc0e2573-e355-43ae-94ae-d0e746bcda37	Shajapur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
5d47ca5a-3e7f-4622-b61c-8f39a4e354f2	Rayagada		57eb2330-c405-46f3-a60a-0622d0086b77
0bbf3d09-2ed0-4b4f-958c-fd12a1c6e1e5	Lonavla		afa1a4c7-c742-4deb-ba10-79d131bf2a10
4e87c3fe-6791-4d28-a1af-7effa3f90869	Ponnur		d0a039df-6e75-4597-9f80-fa3a055b0bee
cab2ee4c-cd16-4970-a242-133a060ab09f	Kagaznagar		b65398bc-aa42-475d-bc07-a6730719da86
08ad3c82-db6f-49d7-839e-9d53b205c283	Gadwal		b65398bc-aa42-475d-bc07-a6730719da86
f8f5ee22-aff0-45f9-ac42-6043f20acb52	Bhatapara		ea160870-ab8b-4cae-a772-0a80b566470f
e2486511-7ff8-46b5-8827-bbad79bc399d	Kandukur		d0a039df-6e75-4597-9f80-fa3a055b0bee
e9dc6574-fa26-4736-9b9b-b0e2625125ce	Sangareddy		b65398bc-aa42-475d-bc07-a6730719da86
8b4ece2d-c3d2-4fc7-b1f2-4328e71f406b	Unjha		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
1301f653-9b1e-4fd5-b35e-68c3c13eefbf	Lunglei		d0a2b263-0189-4e7b-9422-74d3e3915294
f0d6f92a-999b-4ade-84a0-8030e80949b8	Karimganj		694a90d0-c9a5-4835-95df-e9498c78c360
0c81ed80-fba9-49f6-8527-335212599019	Kannur		f8911f17-19b1-46d9-b708-a727912638c8
e2b4d6c1-38b9-4c93-a5d1-8992f69fddd4	Bobbili		d0a039df-6e75-4597-9f80-fa3a055b0bee
68b4cc27-c529-4411-8ee9-a6b590a176ce	Mokameh		aaeb6b5f-0633-47b5-9100-e9024700ece0
c830f115-d374-4221-afda-708756194db5	Talegaon Dabhade		afa1a4c7-c742-4deb-ba10-79d131bf2a10
b464436a-3d75-48cd-9641-22deb0f29b1c	Anjangaon		afa1a4c7-c742-4deb-ba10-79d131bf2a10
b320fc64-7062-4ab6-a76f-67d4a88eb738	Mangrol		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
bd3bba64-4a6a-410f-a671-cc782e3467d3	Sunam		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
540000ab-9040-4b35-9ac8-5c9b8e1e4ee2	Gangarampur		4d66d7f3-42f7-4fb7-945b-5093e9902b93
53af93dc-74f9-4526-bcae-367603731b9b	Thiruvallur		99c94553-c81e-4dfb-98b1-377247c307bb
04355d26-479b-47ed-a87a-fbc511d5f5e3	Tirur		f8911f17-19b1-46d9-b708-a727912638c8
6ecedb57-e313-4f96-b275-e707b1324607	Rath		d72eae33-d05a-4350-aebf-08cef4fbf34d
5291598e-d992-4bc1-8105-03942b0759e4	Jatani		57eb2330-c405-46f3-a60a-0622d0086b77
72cce41f-e74b-4852-b135-2d12d675e8af	Viramgam		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
185e2a12-0883-42e9-adb0-86fe6b4f8771	Rajsamand		7b0ea670-6161-44cf-85e4-98e2d2f37975
9cdd9c35-8bb6-4ac0-bd7a-2432c5dafbc4	Yanam		fdc8eeae-14e2-45bb-b91c-88f586bde4eb
cb98a120-8b2b-49d5-b3ef-ee71326ea9fc	Kottayam		f8911f17-19b1-46d9-b708-a727912638c8
4cde02b5-99db-4416-874d-56c8da6f5504	Panruti		99c94553-c81e-4dfb-98b1-377247c307bb
b4b53e47-6e30-466c-8948-b10d79bdd1d8	Dhuri		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
6b66acdf-caab-448b-9369-6ad87cd8ba47	Namakkal		99c94553-c81e-4dfb-98b1-377247c307bb
32713061-6f3f-480b-a3e5-c78732e62b7b	Kasaragod		f8911f17-19b1-46d9-b708-a727912638c8
73c984cc-453f-40e2-8aeb-4d55bd1f9c7d	Modasa		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
9f6975db-40ab-40e9-990a-be04551afd12	Rayadurg		d0a039df-6e75-4597-9f80-fa3a055b0bee
0a242074-8c46-49ba-9235-11cdc0d49f54	Supaul		aaeb6b5f-0633-47b5-9100-e9024700ece0
db45c021-db11-4a7b-bfc1-9be9e06746fe	Kunnamkulam		f8911f17-19b1-46d9-b708-a727912638c8
ae2c7fa3-826e-44e3-8613-bb25989bb1c5	Umred		afa1a4c7-c742-4deb-ba10-79d131bf2a10
014d4fbd-739d-4b41-bbcd-bf7d33682af5	Bellampalle		b65398bc-aa42-475d-bc07-a6730719da86
6e0e6811-9409-4032-95ee-b5479cb8ca21	Sibsagar		694a90d0-c9a5-4835-95df-e9498c78c360
467d8265-4727-4e67-842d-d4d47704a8dc	Mandi Dabwali		1cb5bf87-e09b-4605-86bb-f11df93794b6
23e68bc0-b075-429e-9af5-593b131f7651	Ottappalam		f8911f17-19b1-46d9-b708-a727912638c8
25e9a099-2420-47dd-8d3e-ca46b7618d6b	Dumraon		aaeb6b5f-0633-47b5-9100-e9024700ece0
a5459813-efaf-4b4f-a20e-2e0801f61b9c	Samalkot		d0a039df-6e75-4597-9f80-fa3a055b0bee
f18810e0-b5f9-4e8f-828e-2ec0ba6341da	Jaggaiahpet		d0a039df-6e75-4597-9f80-fa3a055b0bee
b83e7eb4-f3f1-43dd-8261-059e11a0cbfc	Goalpara		694a90d0-c9a5-4835-95df-e9498c78c360
21170946-e355-4134-838b-ca954b12e6dd	Tuni		d0a039df-6e75-4597-9f80-fa3a055b0bee
af2a77ec-a763-488a-843c-9727492fb0da	Lachhmangarh		7b0ea670-6161-44cf-85e4-98e2d2f37975
58cbdb4c-a923-417b-aa8c-416ec6166367	Bhongir		b65398bc-aa42-475d-bc07-a6730719da86
3eeba380-cf7a-4f66-8892-48eb3a19959c	Amalapuram		d0a039df-6e75-4597-9f80-fa3a055b0bee
db74a83c-7ee1-4f82-a721-06663b1a585a	Firozpur Cantt.		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
c4cf1cc4-a287-4349-aac4-4583c1541a05	Vikarabad		b65398bc-aa42-475d-bc07-a6730719da86
421363da-1934-4a48-b342-57008e01910a	Thiruvalla		f8911f17-19b1-46d9-b708-a727912638c8
cac0a716-6d41-4d2b-9227-80bc8bff15fe	Sherkot		d72eae33-d05a-4350-aebf-08cef4fbf34d
a7f2e8a2-24f3-46f7-95c1-cc26cf550500	Palghar		afa1a4c7-c742-4deb-ba10-79d131bf2a10
6337ca4c-c9dc-4b3f-8c24-6619460101e6	Shegaon		afa1a4c7-c742-4deb-ba10-79d131bf2a10
daa96f7b-bc83-4ece-a40c-838410df9b50	Jangaon		b65398bc-aa42-475d-bc07-a6730719da86
3ed087e1-2625-41c9-bdcb-024fda6621aa	Bheemunipatnam		d0a039df-6e75-4597-9f80-fa3a055b0bee
e2279c52-e947-4793-b33f-0dc168594bb3	Panna		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
6d7ec447-83dc-4dee-9bdf-b3b74743739d	Thodupuzha		f8911f17-19b1-46d9-b708-a727912638c8
86632a4a-19dd-4e2d-9291-a51156b3112c	KathUrban Agglomeration		8889d547-3ba6-469e-bcf6-4329aede50b1
29d59d87-c0ea-4ff6-b999-c5947186736d	Palitana		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
969dd049-9035-4e82-96fe-0a180800fb1f	Arwal		aaeb6b5f-0633-47b5-9100-e9024700ece0
15d5a011-cc59-445e-ba60-81aacb943588	Venkatagiri		d0a039df-6e75-4597-9f80-fa3a055b0bee
af9fd755-5e9a-4521-83c9-b30f585ac04a	Kalpi		d72eae33-d05a-4350-aebf-08cef4fbf34d
3f3d56ff-e4a9-4ee9-af00-f181e48f6911	Rajgarh (Churu)		7b0ea670-6161-44cf-85e4-98e2d2f37975
3e2cc84d-5857-4e9c-81c7-a41c556656b4	Sattenapalle		d0a039df-6e75-4597-9f80-fa3a055b0bee
f25d266d-9cb0-4fee-b8d2-0c1c3ce0de13	Arsikere		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
09152594-9d36-4f66-aa78-e0ac89f93faf	Ozar		afa1a4c7-c742-4deb-ba10-79d131bf2a10
537a9a2d-ca36-412b-b227-fff4c365c5e5	Thirumangalam		99c94553-c81e-4dfb-98b1-377247c307bb
ccfb721a-abf7-417a-9174-b6345ffc1026	Petlad		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
c0bec3ea-613e-4fc5-945c-6b3c5f235d23	Nasirabad		7b0ea670-6161-44cf-85e4-98e2d2f37975
0f728df4-09d9-44fd-932a-60b025ccafd4	Phaltan		afa1a4c7-c742-4deb-ba10-79d131bf2a10
446e4111-1934-480c-91cd-af3d8977ed3a	Rampurhat		4d66d7f3-42f7-4fb7-945b-5093e9902b93
1542369f-993f-4a60-86f9-ad800573119f	Nanjangud		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
e16b1ace-9942-4e15-82f2-67c3c3760110	Forbesganj		aaeb6b5f-0633-47b5-9100-e9024700ece0
b265f796-f38c-48a1-a450-6c6636b9e363	Tundla		d72eae33-d05a-4350-aebf-08cef4fbf34d
5fb0e04f-df76-4081-b78b-832d8339f690	BhabUrban Agglomeration		aaeb6b5f-0633-47b5-9100-e9024700ece0
1c2b8f85-c752-4a02-af43-4c86c8118687	Sagara		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
9003d090-9310-4e3a-8718-fad34e3e1fa7	Pithapuram		d0a039df-6e75-4597-9f80-fa3a055b0bee
4ce6b97f-e666-442f-8ca5-834253d50bb8	Sira		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
3cd3d26a-355a-4377-aa09-f2bf0ee20ec2	Bhadrachalam		b65398bc-aa42-475d-bc07-a6730719da86
7910a779-c829-41e7-91e2-a8a712c15d62	Charkhi Dadri		1cb5bf87-e09b-4605-86bb-f11df93794b6
3ee04a4a-5363-4489-926e-80e4cf4d3764	Chatra		6c763981-576b-450b-8db6-778b1c243803
b901d1bb-54af-4ad5-b30d-4dd149c3bfab	Palasa Kasibugga		d0a039df-6e75-4597-9f80-fa3a055b0bee
e10760d9-dda0-487c-9f75-a4626e37624d	Nohar		7b0ea670-6161-44cf-85e4-98e2d2f37975
010aa65e-74fd-41fc-b695-e8ce2f56455d	Yevla		afa1a4c7-c742-4deb-ba10-79d131bf2a10
75f3ce6f-ea7b-4c99-aa6d-4f92b9e1d579	Sirhind Fatehgarh Sahib		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
f17b856e-8019-4e47-a3f9-6e4a843d7bdb	Bhainsa		b65398bc-aa42-475d-bc07-a6730719da86
364f88fd-3fc3-498a-9239-4a3804685b41	Parvathipuram		d0a039df-6e75-4597-9f80-fa3a055b0bee
67945286-b8ef-416f-acbd-1aada8c87bf2	Shahade		afa1a4c7-c742-4deb-ba10-79d131bf2a10
a6cb45e8-1b3d-47ac-a5f3-799823d77ac5	Chalakudy		f8911f17-19b1-46d9-b708-a727912638c8
9cb71190-c01c-46b9-8ef2-8e2cdb2adb1f	Narkatiaganj		aaeb6b5f-0633-47b5-9100-e9024700ece0
73d30171-8451-4964-96d4-62e429d4ede2	Kapadvanj		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
7326a29b-a25f-4c6f-be66-c279f8c55c0b	Macherla		d0a039df-6e75-4597-9f80-fa3a055b0bee
b1ec57de-6773-4df5-b69d-85896ac611f8	Raghogarh-Vijaypur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
843a2b28-c042-4e1a-91a6-95a6e087c1bb	Rupnagar		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
d525ab00-dceb-40f0-9d38-0c2de2b5abc6	Naugachhia		aaeb6b5f-0633-47b5-9100-e9024700ece0
896a0264-9fec-4a9b-a9d7-95073a4df74f	Sendhwa		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
6628e40c-cebf-487e-b3aa-8c189f778383	Byasanagar		57eb2330-c405-46f3-a60a-0622d0086b77
4cf010b0-1150-45f3-8982-124b16c3d26b	Sandila		d72eae33-d05a-4350-aebf-08cef4fbf34d
7345d520-55d2-401e-b272-4e81a7053806	Gooty		d0a039df-6e75-4597-9f80-fa3a055b0bee
490810cf-853c-4593-9450-8fbcaef35908	Salur		d0a039df-6e75-4597-9f80-fa3a055b0bee
412c335e-5274-4731-a6a1-8487292aaf36	Nanpara		d72eae33-d05a-4350-aebf-08cef4fbf34d
3c0111a4-cc6c-409c-bc96-ac26778564a4	Sardhana		d72eae33-d05a-4350-aebf-08cef4fbf34d
72ed8f7a-71ac-461d-b6b3-12216d70e26f	Vita		afa1a4c7-c742-4deb-ba10-79d131bf2a10
202c3b89-d64c-4f83-afe9-71db69e5e828	Gumia		6c763981-576b-450b-8db6-778b1c243803
9e9e970f-66cc-42b2-aa5d-784cea46a31f	Puttur		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
f26dc32b-1f0a-42c0-9b88-19f05dd45fbf	Jalandhar Cantt.		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
8763e5e5-4d88-486a-a6d3-9ac4c1c98158	Nehtaur		d72eae33-d05a-4350-aebf-08cef4fbf34d
989e8bb2-cc2c-4a4c-8e9c-27582b5f83e4	Changanassery		f8911f17-19b1-46d9-b708-a727912638c8
110a4ec5-bf85-45f5-b732-8393ead6b0f9	Mandapeta		d0a039df-6e75-4597-9f80-fa3a055b0bee
c6b272f0-b705-4ae2-8469-b2cb159b5a73	Dumka		6c763981-576b-450b-8db6-778b1c243803
8583641d-01e4-4704-8426-e6e534378a3a	Seohara		d72eae33-d05a-4350-aebf-08cef4fbf34d
1a831e0b-087b-43ec-9020-93e79c425311	Umarkhed		afa1a4c7-c742-4deb-ba10-79d131bf2a10
69f4c418-98c6-4afc-b750-2b58f34ce2f2	Madhupur		6c763981-576b-450b-8db6-778b1c243803
6ebf58cd-e862-45f1-a5c3-d2a516b5f3b4	Vikramasingapuram		99c94553-c81e-4dfb-98b1-377247c307bb
912749de-0cda-4a7a-a9ff-afe009c43a34	Punalur		f8911f17-19b1-46d9-b708-a727912638c8
06d360dd-eda2-423b-9a54-b418840294e8	Kendrapara		57eb2330-c405-46f3-a60a-0622d0086b77
1ebfcff5-82f6-4056-ac83-915f8887b79f	Sihor		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
f8e05f1a-129f-4cc1-95f9-bf2101bd866e	Nellikuppam		99c94553-c81e-4dfb-98b1-377247c307bb
dccf016b-c462-4b1c-a300-7b5dc55d3288	Samana		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
7665b457-fe85-41ba-8a49-7de5035bead2	Warora		afa1a4c7-c742-4deb-ba10-79d131bf2a10
cb868633-d74b-4de2-9814-a97b4dcac21f	Nilambur		f8911f17-19b1-46d9-b708-a727912638c8
440f2748-1f81-4f58-b159-4f5f11f31cd4	Rasipuram		99c94553-c81e-4dfb-98b1-377247c307bb
50472e9d-8675-4cdf-b0ea-8f643b5e640b	Ramnagar		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
3a45a0f7-a5c8-495f-a2ca-6f5b8bff6108	Jammalamadugu		d0a039df-6e75-4597-9f80-fa3a055b0bee
7f0eb0e5-c00b-48cf-bc11-345a77a85f8e	Nawanshahr		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
21a2f488-b808-42d6-9615-cb654f2a7380	Thoubal		d7c7eee9-db08-4e00-a306-55790fbb52b5
87023e76-5fe8-4931-91a6-5c7e12e7620b	Athni		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
6d7188aa-6ca7-4ef6-8791-e711886ea7ce	Cherthala		f8911f17-19b1-46d9-b708-a727912638c8
365cf80f-d357-43da-9850-793f0b1f7cd7	Sidhi		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
3f253264-2530-4234-a11c-9073a2292e42	Farooqnagar		b65398bc-aa42-475d-bc07-a6730719da86
6da0d91f-e65d-4858-805c-97e6c7977330	Peddapuram		d0a039df-6e75-4597-9f80-fa3a055b0bee
7f81c095-9629-4758-aa29-e879225754ce	Chirkunda		6c763981-576b-450b-8db6-778b1c243803
8d958994-4537-4af9-86b1-c770e2b9a146	Pachora		afa1a4c7-c742-4deb-ba10-79d131bf2a10
c5a4ea61-db1f-413a-9d9a-e30d938252d3	Madhepura		aaeb6b5f-0633-47b5-9100-e9024700ece0
fb447d9a-aa80-4dd7-bc24-c89a9f741e6b	Pithoragarh		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
2eb0d8c8-25ff-434c-b765-36fe325d8943	Tumsar		afa1a4c7-c742-4deb-ba10-79d131bf2a10
64514fa3-a7b4-4311-8622-b88136f5e321	Phalodi		7b0ea670-6161-44cf-85e4-98e2d2f37975
747b8c45-3811-4051-8c3d-43dd8b038772	Tiruttani		99c94553-c81e-4dfb-98b1-377247c307bb
45672189-3011-4111-bb72-c6a8ce3cfac4	Rampura Phul		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
f2409343-81fb-4300-b94f-b86578f8df57	Perinthalmanna		f8911f17-19b1-46d9-b708-a727912638c8
bf9fa454-33fd-4e01-9768-7cef62774beb	Padrauna		d72eae33-d05a-4350-aebf-08cef4fbf34d
12af7dbe-8db3-445a-9174-475c759f05a6	Pipariya		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
d6a38466-f0d0-4f9e-ba60-6c60998817bb	Dalli-Rajhara		ea160870-ab8b-4cae-a772-0a80b566470f
0421c881-a93c-40df-9793-b2b8c7cd89b4	Punganur		d0a039df-6e75-4597-9f80-fa3a055b0bee
9cc9b367-61b4-4f63-8553-d26253227805	Mattannur		f8911f17-19b1-46d9-b708-a727912638c8
dbb484c6-bc98-4e2e-be66-f282cc769566	Mathura		d72eae33-d05a-4350-aebf-08cef4fbf34d
193da6e2-269e-48ef-9289-a706efaa7bf7	Thakurdwara		d72eae33-d05a-4350-aebf-08cef4fbf34d
7f1d7f4b-92ef-4d31-a39d-53b10f9c0300	Nandivaram-Guduvancheri		99c94553-c81e-4dfb-98b1-377247c307bb
6a04d2e1-11f5-40ea-b0bb-4d229a75451a	Mulbagal		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
dc33e44d-3849-47d5-a96c-10bfb9f5734d	Manjlegaon		afa1a4c7-c742-4deb-ba10-79d131bf2a10
cf109707-121a-4814-af3a-a9d5e52efd6c	Wankaner		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
8bf696d0-ff38-4e4c-875b-f5c613694f01	Sillod		afa1a4c7-c742-4deb-ba10-79d131bf2a10
bbb349a5-a5de-4727-b2e2-113663e05d63	Nidadavole		d0a039df-6e75-4597-9f80-fa3a055b0bee
50e7e235-9b7e-4d19-ac7a-0dfd1699bb83	Surapura		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
113d3c43-2bd2-4d8e-9cac-af4fb45feaae	Rajagangapur		57eb2330-c405-46f3-a60a-0622d0086b77
e2e023d0-8f31-4225-9f18-8833ea977b4f	Sheikhpura		aaeb6b5f-0633-47b5-9100-e9024700ece0
3c227844-37bd-478c-befd-3e94fc18cb0d	Parlakhemundi		57eb2330-c405-46f3-a60a-0622d0086b77
507ee772-e66a-4235-a82d-668445bd787d	Kalimpong		4d66d7f3-42f7-4fb7-945b-5093e9902b93
8273e9ad-a8ce-4768-8563-600a7c9917b4	Siruguppa		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
d50a0e0e-4ec6-41f9-ac56-eb68c400d125	Arvi		afa1a4c7-c742-4deb-ba10-79d131bf2a10
ed0868fa-5912-484b-bf95-e367912e12a8	Limbdi		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
6d379b24-8fb3-4697-8e9a-f592277121a8	Barpeta		694a90d0-c9a5-4835-95df-e9498c78c360
a27b069d-641a-4f79-ba55-c1d1d30a5756	Manglaur		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
348c997d-9ec0-44d7-af80-b8e32b50c416	Repalle		d0a039df-6e75-4597-9f80-fa3a055b0bee
69f72c32-29cf-436b-a145-82316dc44dbf	Mudhol		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
44858d35-2eb2-4dde-a1aa-a6db2ebffaa5	Shujalpur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
c4427b6d-7440-4b24-877d-0cf35187c3be	Mandvi		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
0194e3bd-dec7-472d-935f-e0009b9cc91f	Thangadh		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
cef66ef4-24ad-483f-a5ff-4ab68cbf6c56	Sironj		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
2529a59a-6764-488c-9cc7-c5bae036c3b3	Nandura		afa1a4c7-c742-4deb-ba10-79d131bf2a10
9e068faa-adab-43f7-9f5d-2dfcaf340702	Shoranur		f8911f17-19b1-46d9-b708-a727912638c8
43909c96-b726-47d6-8c1f-3e6234b86341	Nathdwara		7b0ea670-6161-44cf-85e4-98e2d2f37975
367abb42-a5b8-4bcf-9896-28aefed9dab6	Periyakulam		99c94553-c81e-4dfb-98b1-377247c307bb
fb805bf6-a897-4b82-9853-0a76de15371a	Sultanganj		aaeb6b5f-0633-47b5-9100-e9024700ece0
e03a0140-77f7-443c-baca-cc6ce0de6dd6	Medak		b65398bc-aa42-475d-bc07-a6730719da86
f7a46bbf-3612-4968-9fd5-8f423923b3d4	Narayanpet		b65398bc-aa42-475d-bc07-a6730719da86
de2c427f-21c5-499c-9b59-e7c0bffc28cd	Raxaul Bazar		aaeb6b5f-0633-47b5-9100-e9024700ece0
81c2d1b5-bab7-47db-b664-eefcf4d9a1a8	Rajauri		8889d547-3ba6-469e-bcf6-4329aede50b1
85f96032-77b4-48d7-a44f-fa64e6a656de	Pernampattu		99c94553-c81e-4dfb-98b1-377247c307bb
2ff89756-6334-4be3-9886-e730a464bccd	Nainital		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
d9f6663b-e2ac-448c-90b0-f5f203aec83e	Ramachandrapuram		d0a039df-6e75-4597-9f80-fa3a055b0bee
d21aab96-5794-4d2b-b7dc-87985ea82fbb	Vaijapur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
28713e6c-c6d5-4965-828d-cea49166a76d	Nangal		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
34d0e87d-d484-40e1-b5bc-e155e6a2dba1	Sidlaghatta		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
1df78a72-0f33-48c8-8dd3-439cfdd4a16a	Punch		8889d547-3ba6-469e-bcf6-4329aede50b1
2602a76a-d03e-4ed5-a636-a8c4d85d32f9	Pandhurna		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
2eab5d0c-ced0-460e-8af6-f1691a4f03b9	Wadgaon Road		afa1a4c7-c742-4deb-ba10-79d131bf2a10
91a57d02-8717-4e8a-823a-9383ff6b8e77	Talcher		57eb2330-c405-46f3-a60a-0622d0086b77
bcea995e-2ed2-4071-9fc8-448f6a966efe	Varkala		f8911f17-19b1-46d9-b708-a727912638c8
c5949cca-14a3-44e1-a00f-eb311bccf27a	Pilani		7b0ea670-6161-44cf-85e4-98e2d2f37975
8d60b1fd-6deb-42fc-9b89-f839e8911c4e	Nowgong		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
aa82b33c-4dbd-47da-9dd3-b8b4db094003	Naila Janjgir		ea160870-ab8b-4cae-a772-0a80b566470f
2255cb3f-6954-429c-beba-50f4f113dfea	Mapusa		3f7d7055-8b25-4f89-9765-0cd37dd0a99c
daf32e61-8f6f-4d3d-8f92-58d256112228	Vellakoil		99c94553-c81e-4dfb-98b1-377247c307bb
54eb4db3-1fe8-47d9-9abf-2748c478608d	Merta City		7b0ea670-6161-44cf-85e4-98e2d2f37975
543d2aa9-7405-4182-b603-372d6912bfe4	Sivaganga		99c94553-c81e-4dfb-98b1-377247c307bb
a0cb9750-aefd-45f5-9927-aec71646a2bd	Mandideep		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
1b6d61e5-6ddf-4faa-bcbb-9507d8529d77	Sailu		afa1a4c7-c742-4deb-ba10-79d131bf2a10
b8b5a871-076b-46ae-8ee2-f008e4ef5252	Vyara		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
b51873ca-f439-422a-aed8-d335558289ab	Kovvur		d0a039df-6e75-4597-9f80-fa3a055b0bee
6ee27409-ba35-4653-83e1-0a346403d7e8	Vadalur		99c94553-c81e-4dfb-98b1-377247c307bb
2641350f-f840-42e7-8a65-b2a784bb2a8e	Nawabganj		d72eae33-d05a-4350-aebf-08cef4fbf34d
f615bae0-e9e9-40fa-bc23-84c66a70e6a1	Padra		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
ef647cf7-08b3-4fdd-8959-ae96f6843b61	Sainthia		4d66d7f3-42f7-4fb7-945b-5093e9902b93
4ebb42d4-0797-4db0-8945-44649f763ad1	Siana		d72eae33-d05a-4350-aebf-08cef4fbf34d
b281a120-0a94-496b-8191-2896efa0719e	Shahpur		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
493faa4d-ba05-4757-8eca-fe39cffa2570	Sojat		7b0ea670-6161-44cf-85e4-98e2d2f37975
31852ae5-0096-42d4-b994-784a8115c3fe	Noorpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
361e7073-072e-4efb-a6d0-309d2d6ade4f	Paravoor		f8911f17-19b1-46d9-b708-a727912638c8
ec3a7793-410e-41de-80e9-ab1e7fc08eac	Murtijapur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
c4e6702b-0e70-449f-b4d9-0773201412ce	Ramnagar		aaeb6b5f-0633-47b5-9100-e9024700ece0
fd3e5569-dc6d-4856-a6f8-e5428f45d866	Sundargarh		57eb2330-c405-46f3-a60a-0622d0086b77
cc412575-df21-4935-8e6f-c42c1bf75983	Taki		4d66d7f3-42f7-4fb7-945b-5093e9902b93
2de81c4e-f9bd-4513-a1ce-ac68c4cc91d9	Saundatti-Yellamma		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
ce19d028-8928-4804-983e-667f54bfbd08	Pathanamthitta		f8911f17-19b1-46d9-b708-a727912638c8
d7bb42ed-8712-470f-b678-8fe1247b58ef	Wadi		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
e5a849c9-4bda-4513-bdf9-e8a39cd83046	Rameshwaram		99c94553-c81e-4dfb-98b1-377247c307bb
8f6d1e43-5a5b-4781-8993-60b4bd27f7ec	Tasgaon		afa1a4c7-c742-4deb-ba10-79d131bf2a10
ed0f6630-72a2-4a90-b884-665b73a55876	Sikandra Rao		d72eae33-d05a-4350-aebf-08cef4fbf34d
3b49e96a-262c-4cb3-be52-878b9d14c3f4	Sihora		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
958c6c99-f1d3-40b5-b570-a3460af6637a	Tiruvethipuram		99c94553-c81e-4dfb-98b1-377247c307bb
b68553f7-a200-4d6d-8666-e4f1c6acae1f	Tiruvuru		d0a039df-6e75-4597-9f80-fa3a055b0bee
0bc01e7e-75db-40a8-ab2c-183c0ae8ac3e	Mehkar		afa1a4c7-c742-4deb-ba10-79d131bf2a10
38709fd9-d0c9-4a49-acb6-782a23864860	Peringathur		f8911f17-19b1-46d9-b708-a727912638c8
48a92428-0fed-464c-b7e4-78d7a1486afb	Perambalur		99c94553-c81e-4dfb-98b1-377247c307bb
c131d2b8-6adb-4fe4-86e7-61b56c41da57	Manvi		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
2658c343-76a5-49e4-b43b-afe28ce24885	Zunheboto		1e973ad2-b99d-4bc8-b688-8e9c8d84acdf
a007dbff-a7f0-4f06-8e74-479993a21fdd	Mahnar Bazar		aaeb6b5f-0633-47b5-9100-e9024700ece0
80c6b981-29f0-479a-b196-0d851cf48757	Attingal		f8911f17-19b1-46d9-b708-a727912638c8
5fcc60bb-97cf-4c05-8f43-bd3858ac8920	Shahbad		1cb5bf87-e09b-4605-86bb-f11df93794b6
98acdf91-4c69-4758-af45-e1f59a187afc	Puranpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
200d1277-3d46-47f1-8d98-bf237869b1b9	Nelamangala		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
b9bdc729-e2a0-4513-bf0a-f6b875c6e7f8	Nakodar		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
c6d16bff-d5ca-492a-bd6b-0e24b0be212c	Lunawada		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
9dfe7122-c033-40a6-87ba-06adff8a8da1	Murshidabad		4d66d7f3-42f7-4fb7-945b-5093e9902b93
73437d4d-08d2-48c4-85c3-bcbd508649b1	Mahe		fdc8eeae-14e2-45bb-b91c-88f586bde4eb
1a0034d7-5d1a-43ae-bc36-c7c336ae887b	Lanka		694a90d0-c9a5-4835-95df-e9498c78c360
8d1815ab-0cb9-45ad-bfc6-2d171d7606b2	Rudauli		d72eae33-d05a-4350-aebf-08cef4fbf34d
a9b8ebfe-48df-4edb-89a1-46c28b2bd3c0	Tuensang		1e973ad2-b99d-4bc8-b688-8e9c8d84acdf
7a4fa9f6-e450-4474-b998-5b4a33e2c813	Lakshmeshwar		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
5460e1f8-5304-49d8-b92b-b652c9c50d37	Zira		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
d470f16f-8e99-4172-b76a-c7881ddf6cce	Yawal		afa1a4c7-c742-4deb-ba10-79d131bf2a10
0f0a58f4-5ce2-4938-ab95-fc65023cca50	Thana Bhawan		d72eae33-d05a-4350-aebf-08cef4fbf34d
57c4c2cc-0e21-41d2-84a3-d026fe7a215c	Ramdurg		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
ed3518a6-5cdf-407b-83bf-7f144d0da63b	Pulgaon		afa1a4c7-c742-4deb-ba10-79d131bf2a10
b481c7e6-66c6-4223-9b0f-2398ae0d391e	Sadasivpet		b65398bc-aa42-475d-bc07-a6730719da86
e6205dd6-240f-4132-aa2e-7c9c533dafac	Nargund		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
894c1706-f739-4959-b3ef-e3cede45e497	Neem-Ka-Thana		7b0ea670-6161-44cf-85e4-98e2d2f37975
83c3068c-ac00-444f-aa57-6a8b846dfcfd	Memari		4d66d7f3-42f7-4fb7-945b-5093e9902b93
626ca68a-c222-4ffa-a8bb-6b95f693b8b1	Nilanga		afa1a4c7-c742-4deb-ba10-79d131bf2a10
f14a9a38-458d-4c40-9dcf-60a4b66aac66	Naharlagun		2edcbd08-3238-4873-9bbd-55c79cdc71f3
9d040749-f209-4f3f-9a48-6148a12ec470	Pakaur		6c763981-576b-450b-8db6-778b1c243803
f7d27a21-7419-4c64-87ea-ec0e3b45f321	Wai		afa1a4c7-c742-4deb-ba10-79d131bf2a10
e32c56ee-fe30-47f6-ad7f-089f5f7c6fb4	Tarikere		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
5024f31a-a879-427b-84d9-515a5c344fe6	Malavalli		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
999c7c6b-998e-479e-9640-6a307d5ac73d	Raisen		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
e037dd00-2f15-443a-b225-5238a60030d6	Lahar		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
dd83b5a2-d7b2-4465-946b-2e4d2ea9625f	Uravakonda		d0a039df-6e75-4597-9f80-fa3a055b0bee
7a5fc872-249c-417b-be1c-01ef46c7e189	Savanur		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
73fc46e4-7f91-4ad9-b510-1af08438b153	Sirohi		7b0ea670-6161-44cf-85e4-98e2d2f37975
a7309064-4e7a-4541-a7a1-b9224f05ae17	Udhampur		8889d547-3ba6-469e-bcf6-4329aede50b1
28172c1f-6db4-4953-816c-3b376778d751	Umarga		afa1a4c7-c742-4deb-ba10-79d131bf2a10
4d53064a-17f4-4d98-9730-52cc1370a5ac	Pratapgarh		7b0ea670-6161-44cf-85e4-98e2d2f37975
a1cdfb4a-7e15-4dac-b910-5e12c500e26f	Lingsugur		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
2634bad1-0965-4f50-8fa5-f7de9cd5ee88	Usilampatti		99c94553-c81e-4dfb-98b1-377247c307bb
372eee69-6d35-4ea6-928d-66de625d1c13	Palia Kalan		d72eae33-d05a-4350-aebf-08cef4fbf34d
9d45d581-1904-486b-bf66-92e1f098dbd5	Wokha		1e973ad2-b99d-4bc8-b688-8e9c8d84acdf
159c5aa4-24cd-4bdc-bca1-3ab1958b5cbd	Rajpipla		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
01422457-7441-45c0-933b-b20eb3ef710d	Vijayapura		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
e8c68f24-5a54-4128-9a32-7af786cdc1dd	Rawatbhata		7b0ea670-6161-44cf-85e4-98e2d2f37975
dbcd1b5d-00d7-4f28-a9af-e5fc9c0cd776	Sangaria		7b0ea670-6161-44cf-85e4-98e2d2f37975
de529ea4-dac0-44db-b7d2-a59ba45673d4	Paithan		afa1a4c7-c742-4deb-ba10-79d131bf2a10
b0c1e2ee-b107-4e7b-a570-9c68a8af7654	Rahuri		afa1a4c7-c742-4deb-ba10-79d131bf2a10
1acbac07-93b9-457f-b833-22c9264f32af	Patti		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
1a486ff8-b441-4c67-ac22-5f83a8149b31	Zaidpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
3049fc21-cc97-415d-b502-7234186391b5	Lalsot		7b0ea670-6161-44cf-85e4-98e2d2f37975
c19f852c-ee6b-49f6-96ac-f23b91f6d256	Maihar		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
a7d4f187-b46c-446d-90d6-c2076677e5fe	Vedaranyam		99c94553-c81e-4dfb-98b1-377247c307bb
65928cc9-fbe4-49b2-a4aa-1e37cd1074b5	Nawapur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
ddfc70d6-f2c3-4492-b92f-33e9d59eed9d	Solan		616becf7-866b-4cb6-aa57-0afa29cac4f4
ca30f474-2eef-4bac-a84f-e728fddbe002	Vapi		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
3c2eac6d-460b-4a24-8ee2-f3ea54c4af1d	Sanawad		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
d20d5ab0-8ca6-44c2-ba57-0867ce9b24ef	Warisaliganj		aaeb6b5f-0633-47b5-9100-e9024700ece0
a73d4444-1e1a-441c-adcc-e41dec73cf41	Revelganj		aaeb6b5f-0633-47b5-9100-e9024700ece0
98b5a93a-1453-439c-a907-8430543effbe	Sabalgarh		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
eda70c91-691a-4326-a698-7e94972a9a35	Tuljapur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
d9ede26f-5279-4ac7-a9e5-0e88303c5937	Simdega		6c763981-576b-450b-8db6-778b1c243803
079c9971-7f4d-4578-a009-503cd37ac6a4	Musabani		6c763981-576b-450b-8db6-778b1c243803
865f7ac8-8231-4f27-9078-82fb85d6c594	Kodungallur		f8911f17-19b1-46d9-b708-a727912638c8
6a80c282-0899-4e7b-b320-6a117ec81f22	Phulabani		57eb2330-c405-46f3-a60a-0622d0086b77
0c408b17-1d4f-4810-98e5-95522465070f	Umreth		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
14bbacd4-37d0-4b04-996f-bc8245b2f21c	Narsipatnam		d0a039df-6e75-4597-9f80-fa3a055b0bee
3d2c8f05-4c0f-40a4-8cf7-c61ac2563ca1	Nautanwa		d72eae33-d05a-4350-aebf-08cef4fbf34d
742d5afe-5e75-47db-b001-02b15ade6661	Rajgir		aaeb6b5f-0633-47b5-9100-e9024700ece0
2805c125-d745-4efe-a991-33eae3cb12ec	Yellandu		b65398bc-aa42-475d-bc07-a6730719da86
dcfd9998-be98-42ae-9e3e-7c52680e00d5	Sathyamangalam		99c94553-c81e-4dfb-98b1-377247c307bb
f15cc2c6-85d1-425c-8062-26ef695eafdd	Pilibanga		7b0ea670-6161-44cf-85e4-98e2d2f37975
7cf27dd3-e9d7-4115-91b8-dfde08d8f7e0	Morshi		afa1a4c7-c742-4deb-ba10-79d131bf2a10
fb6295fa-8345-47e2-91ae-c7def073b655	Pehowa		1cb5bf87-e09b-4605-86bb-f11df93794b6
5188a5fa-d1b3-4a13-86c6-93a733aee940	Sonepur		aaeb6b5f-0633-47b5-9100-e9024700ece0
ef2067b8-b134-4e96-9890-922c09348e64	Pappinisseri		f8911f17-19b1-46d9-b708-a727912638c8
4e044f10-548c-4163-878f-1a7e3da99ae5	Zamania		d72eae33-d05a-4350-aebf-08cef4fbf34d
abfc6c21-3046-4116-ad10-4d393a915a52	Mihijam		6c763981-576b-450b-8db6-778b1c243803
8f99732e-ef00-47ec-86b0-ddf00325f850	Purna		afa1a4c7-c742-4deb-ba10-79d131bf2a10
cb51a825-9589-43a9-8e2f-8f93de0bde58	Puliyankudi		99c94553-c81e-4dfb-98b1-377247c307bb
a42e88d2-7a3f-42c3-84bd-dde28158a228	Shikarpur, Bulandshahr		d72eae33-d05a-4350-aebf-08cef4fbf34d
ae9e305e-d652-437c-9b9e-cbbe4c18f468	Umaria		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
cbc69c44-8c88-455f-91de-ee83a6d214ad	Porsa		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
71803913-9f90-45b8-841a-45d2f292c784	Naugawan Sadat		d72eae33-d05a-4350-aebf-08cef4fbf34d
dc9eb3d9-b5aa-4db2-b788-7a4c2ebc8848	Fatehpur Sikri		d72eae33-d05a-4350-aebf-08cef4fbf34d
7d250ee2-0943-4e48-a7cb-2bbc6a4490dd	Manuguru		b65398bc-aa42-475d-bc07-a6730719da86
1af7bc5f-5f76-4ed9-88f3-b21a9a2c7214	Udaipur		1d8e1820-480f-4c27-a44f-198d7063010f
f5638cc0-ef3f-4513-9d08-a6285b4b947d	Pipar City		7b0ea670-6161-44cf-85e4-98e2d2f37975
69315a9d-dbcc-4303-bb71-f09019dbb5b3	Pattamundai		57eb2330-c405-46f3-a60a-0622d0086b77
be38ff41-29d4-4dfb-8764-e8136591a438	Nanjikottai		99c94553-c81e-4dfb-98b1-377247c307bb
6fa82ca3-94cf-4921-bb36-f631ad89f7b1	Taranagar		7b0ea670-6161-44cf-85e4-98e2d2f37975
11f579c7-2120-4647-a01b-0cdb11a2eb4c	Yerraguntla		d0a039df-6e75-4597-9f80-fa3a055b0bee
4425ddf6-5d9f-4357-8982-8c82671b84d0	Satana		afa1a4c7-c742-4deb-ba10-79d131bf2a10
cc13eaa8-17ed-48ce-8eee-62b56e3afda6	Sherghati		aaeb6b5f-0633-47b5-9100-e9024700ece0
e766ec30-23fb-4ce4-9cba-a30c3d88b288	Sankeshwara		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
e916987c-8ee9-494c-b489-92e868cab85a	Madikeri		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
03e56b25-cf6f-4354-afe3-d2b96057e5f8	Thuraiyur		99c94553-c81e-4dfb-98b1-377247c307bb
30622e64-4208-4839-a76e-00c8fd43ff93	Sanand		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
ee7c966b-cceb-46bf-b41e-1588376c0cd7	Rajula		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
a9b337a8-6d62-42c3-852c-9cf484ec1e49	Kyathampalle		b65398bc-aa42-475d-bc07-a6730719da86
aa4983fa-74c4-435e-8b5e-dba4360a867f	Shahabad, Rampur		d72eae33-d05a-4350-aebf-08cef4fbf34d
72500e15-9c60-4cb9-a827-734e5aeb0490	Tilda Newra		ea160870-ab8b-4cae-a772-0a80b566470f
c6f4214c-ebda-4c75-b661-f55db8170862	Narsinghgarh		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
24fd5f9e-bc82-4074-b943-9462a466e1d8	Chittur-Thathamangalam		f8911f17-19b1-46d9-b708-a727912638c8
f4b572b1-4550-4108-abfa-4cffa65e96fa	Malaj Khand		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
84e9b214-8741-4a3e-ac3c-aa84161c40ef	Sarangpur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
e3030283-e3ec-443b-8f9f-b9a40dba136b	Robertsganj		d72eae33-d05a-4350-aebf-08cef4fbf34d
31389205-be50-42c1-a3be-7aa8725fe121	Sirkali		99c94553-c81e-4dfb-98b1-377247c307bb
d2b39dd0-a849-43dd-86c5-2f96398dd084	Radhanpur		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
c10a4d46-1755-4add-8724-a5084a2d5d71	Tiruchendur		99c94553-c81e-4dfb-98b1-377247c307bb
a352c0d9-9811-4ebb-8d96-54e1ba1a3d59	Utraula		d72eae33-d05a-4350-aebf-08cef4fbf34d
38456a8d-5e4c-4e91-87f9-0bdabbfae2b9	Patratu		6c763981-576b-450b-8db6-778b1c243803
7e1fac33-e95c-4ed4-bf59-19bf4fdbe2a6	Vijainagar, Ajmer		7b0ea670-6161-44cf-85e4-98e2d2f37975
574f90cf-02a6-4023-a8ac-cb759bdb9008	Periyasemur		99c94553-c81e-4dfb-98b1-377247c307bb
11baca6f-3bdb-476d-bd90-60b76375ef4a	Pathri		afa1a4c7-c742-4deb-ba10-79d131bf2a10
805dd2e9-5bdc-49bc-a20f-c716a771aa75	Sadabad		d72eae33-d05a-4350-aebf-08cef4fbf34d
f2dd61e3-a2c6-422f-877c-6af4a48ae985	Talikota		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
d500dcbe-ce1f-4eed-8b8b-e184d7a84522	Sinnar		afa1a4c7-c742-4deb-ba10-79d131bf2a10
2b3a58a2-410f-4305-83d3-1c38a52af53b	Mungeli		ea160870-ab8b-4cae-a772-0a80b566470f
c2df91d9-59e2-4419-80f1-1b6d7ad7762a	Sedam		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
e31a21e3-a5bb-4c7f-87b8-db0d0e8b25a9	Shikaripur		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
9eb5862f-d83d-407d-8f95-2db454696c15	Sumerpur		7b0ea670-6161-44cf-85e4-98e2d2f37975
8c502f73-0ea7-44ff-85ae-b4ed113858fc	Sattur		99c94553-c81e-4dfb-98b1-377247c307bb
76e00a84-dfcc-4e02-8cae-149c540ebb91	Sugauli		aaeb6b5f-0633-47b5-9100-e9024700ece0
40fff66f-0bb1-469a-9f1b-b3711fc08f1d	Lumding		694a90d0-c9a5-4835-95df-e9498c78c360
db620db5-a82c-47e1-ae37-f1792d0c3424	Vandavasi		99c94553-c81e-4dfb-98b1-377247c307bb
3f3d537f-4e9e-4c0f-b479-f46c590ae24f	Titlagarh		57eb2330-c405-46f3-a60a-0622d0086b77
2d47c16d-80f5-47f8-8c0e-e72795f3491b	Uchgaon		afa1a4c7-c742-4deb-ba10-79d131bf2a10
722aab25-fe3b-48dc-b889-d6e16072c30d	Mokokchung		1e973ad2-b99d-4bc8-b688-8e9c8d84acdf
f4bb1b7b-0c4b-4461-8670-ccd0fe4b5c7e	Paschim Punropara		4d66d7f3-42f7-4fb7-945b-5093e9902b93
7ee32ad7-e425-4758-9877-e413587b3075	Sagwara		7b0ea670-6161-44cf-85e4-98e2d2f37975
98afdd51-30e0-4007-8569-e61d0653cda2	Ramganj Mandi		7b0ea670-6161-44cf-85e4-98e2d2f37975
25dd612d-1190-4d6f-8f16-c63695c7f2f2	Tarakeswar		4d66d7f3-42f7-4fb7-945b-5093e9902b93
f6816b10-9c15-43ae-ad07-9c1b22747a12	Mahalingapura		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
f64b7427-ba19-430b-b36b-87480c29669c	Dharmanagar		1d8e1820-480f-4c27-a44f-198d7063010f
8864af09-cf7c-4600-a3dd-b068f3ac30eb	Mahemdabad		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
6f111eb7-8d25-403d-8911-a48ff8011c0e	Manendragarh		ea160870-ab8b-4cae-a772-0a80b566470f
298823b6-037a-4057-a23d-f0f68aea5e6f	Uran		afa1a4c7-c742-4deb-ba10-79d131bf2a10
da922cbe-01b1-4bf9-843d-1e43397bdafb	Tharamangalam		99c94553-c81e-4dfb-98b1-377247c307bb
e416cfe6-4cd2-4552-b14d-d34820b53dbf	Tirukkoyilur		99c94553-c81e-4dfb-98b1-377247c307bb
3cd89194-5300-41dd-9bd8-ec147563dc9e	Pen		afa1a4c7-c742-4deb-ba10-79d131bf2a10
97e4cdec-db29-482c-8f38-575da2a852a9	Makhdumpur		aaeb6b5f-0633-47b5-9100-e9024700ece0
edfd47f9-9296-4e12-a896-3011731beefd	Maner		aaeb6b5f-0633-47b5-9100-e9024700ece0
965e4a0b-a947-4d46-8b6e-b40fde0025c9	Oddanchatram		99c94553-c81e-4dfb-98b1-377247c307bb
aab46712-dfee-4845-83d9-17aafad98302	Palladam		99c94553-c81e-4dfb-98b1-377247c307bb
52f253de-221f-42bb-8905-716a49ac50db	Mundi		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
5a766b2e-65a1-4456-95c5-8d188e87bf81	Nabarangapur		57eb2330-c405-46f3-a60a-0622d0086b77
e1af9e07-7ed0-4828-9bc2-f46d517cbda4	Mudalagi		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
45f2388e-d22f-4b8f-9d35-fe388d31b119	Samalkha		1cb5bf87-e09b-4605-86bb-f11df93794b6
530446f9-c5df-484c-b050-445b7c5d2c12	Nepanagar		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
23b0d33b-ea72-4669-8978-4370c4770a3a	Karjat		afa1a4c7-c742-4deb-ba10-79d131bf2a10
4799f516-2b23-4f8b-b19e-1230c2d5a6ff	Ranavav		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
c4bad651-19d0-4d36-89d4-18b3800a7945	Pedana		d0a039df-6e75-4597-9f80-fa3a055b0bee
8103d05e-6293-436e-a2c3-0dd8377611a4	Pinjore		1cb5bf87-e09b-4605-86bb-f11df93794b6
71a6b422-47da-4269-81fb-28ef5ce9bcb1	Lakheri		7b0ea670-6161-44cf-85e4-98e2d2f37975
cebd6dc8-9c91-4286-8b7f-b1aa5c051e34	Pasan		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
02c4f953-9168-4fbd-8b97-9bfdf5ed37fa	Puttur		d0a039df-6e75-4597-9f80-fa3a055b0bee
3804df94-f5f9-4d44-9d23-17c138a1b064	Vadakkuvalliyur		99c94553-c81e-4dfb-98b1-377247c307bb
01bfc0d6-0fa6-4e16-8514-c2dfefabfc7a	Tirukalukundram		99c94553-c81e-4dfb-98b1-377247c307bb
fe6eecaa-1f4f-4376-91bc-a4bc8ae2bcc4	Mahidpur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
49aa2895-9601-44fb-be8f-d6729ca034ae	Mussoorie		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
2d5feb95-1000-4924-8d9e-2e722692fdf5	Muvattupuzha		f8911f17-19b1-46d9-b708-a727912638c8
25c08be8-9f7c-4636-86ec-b6afae3519d8	Rasra		d72eae33-d05a-4350-aebf-08cef4fbf34d
2098d538-f434-4444-82c2-961cfe865180	Udaipurwati		7b0ea670-6161-44cf-85e4-98e2d2f37975
f3db4447-a869-4bb5-b1b4-c4b101e07589	Manwath		afa1a4c7-c742-4deb-ba10-79d131bf2a10
21c42594-a4fc-4246-9693-b9f0ff95f6b5	Adoor		f8911f17-19b1-46d9-b708-a727912638c8
6208b82c-713f-4702-98d7-89c6872255ce	Uthamapalayam		99c94553-c81e-4dfb-98b1-377247c307bb
6fda7f31-224a-46f6-b5c5-70f003fde40d	Partur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
568e1a7f-3b09-4124-b504-9f6b2c8a60b2	Nahan		616becf7-866b-4cb6-aa57-0afa29cac4f4
dccb4958-03a8-4639-b243-cdc2733b52de	Ladwa		1cb5bf87-e09b-4605-86bb-f11df93794b6
31eb25e7-c89a-4b96-a69e-d8afaa222292	Mankachar		694a90d0-c9a5-4835-95df-e9498c78c360
fba1b904-b59f-489e-83b2-d9ccece585a4	Nongstoin		e0173d54-80cd-48c0-9c92-61853ebef7b9
a01e089b-4f42-4558-8f07-2cd00a03c740	Losal		7b0ea670-6161-44cf-85e4-98e2d2f37975
286fa2a0-d279-45a3-be08-03efbde44ee3	Sri Madhopur		7b0ea670-6161-44cf-85e4-98e2d2f37975
72ee95c9-978e-42f8-b2b2-4f8d69a2d3c7	Ramngarh		7b0ea670-6161-44cf-85e4-98e2d2f37975
2c1ba05b-afa8-4807-bbba-5c5b16e6741b	Mavelikkara		f8911f17-19b1-46d9-b708-a727912638c8
185ee3b6-65bf-4188-ba36-21fbe497c330	Rawatsar		7b0ea670-6161-44cf-85e4-98e2d2f37975
615e9470-1948-4e49-8d52-0e49dd10a284	Rajakhera		7b0ea670-6161-44cf-85e4-98e2d2f37975
10018096-76f1-4943-89db-f489ff994eb5	Lar		d72eae33-d05a-4350-aebf-08cef4fbf34d
41751576-864f-424e-bb11-6b6a41ce71f1	Lal Gopalganj Nindaura		d72eae33-d05a-4350-aebf-08cef4fbf34d
129dc204-a5df-4bbe-bb6b-3ae53ff44043	Muddebihal		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
b6213faa-5710-4099-b284-81d68b62cf56	Sirsaganj		d72eae33-d05a-4350-aebf-08cef4fbf34d
11ad753d-0b95-45bc-bcb2-bf9e9d185c47	Shahpura		7b0ea670-6161-44cf-85e4-98e2d2f37975
765a030c-37b0-4645-afe1-aea1be7717bf	Surandai		99c94553-c81e-4dfb-98b1-377247c307bb
1b4a3b7d-bfd2-4fc6-bfb3-03a5b9940037	Sangole		afa1a4c7-c742-4deb-ba10-79d131bf2a10
e093c4b2-0970-4092-8d59-a0deb5e0b02c	Pavagada		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
6b3402bc-6e98-43f5-b282-1aa0e6dd2278	Tharad		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
99e75e08-4828-4963-a880-27abba3a2e02	Mansa		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
e3d583fd-622d-415d-b5ef-8536b8a4f615	Umbergaon		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
8c2df9b3-2798-4a72-a88e-56a2a7d9be2a	Mavoor		f8911f17-19b1-46d9-b708-a727912638c8
1e9bce21-070f-4987-942c-9d05c0e15ff5	Nalbari		694a90d0-c9a5-4835-95df-e9498c78c360
3c33cc2f-bb3a-4c12-a4ee-0e5d5c89a49e	Talaja		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
17411594-a233-48d1-bf58-bba193fe8af2	Malur		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
f6b14840-064f-43d5-bad0-08505536cfd6	Mangrulpir		afa1a4c7-c742-4deb-ba10-79d131bf2a10
8ecbdaf9-7294-41be-a580-88bbf61791dc	Soro		57eb2330-c405-46f3-a60a-0622d0086b77
3747f61d-e688-4f85-9f5f-d5a087f72e64	Shahpura		7b0ea670-6161-44cf-85e4-98e2d2f37975
2f787c9a-19d0-4cc5-a595-ceb2adea300c	Vadnagar		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
cdaaa704-e996-4671-ba80-d0456e97cec1	Raisinghnagar		7b0ea670-6161-44cf-85e4-98e2d2f37975
59ee3c71-20ba-429f-b095-547e21d81178	Sindhagi		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
56e89000-763a-4a98-8d9f-dcce35adb604	Sanduru		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
635adfb5-f7e8-4c09-beb5-e4590062219e	Sohna		1cb5bf87-e09b-4605-86bb-f11df93794b6
01b5aa02-5ecf-42d9-a3ea-c24b03d6df2f	Manavadar		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
1ab2dba2-a1b6-4e44-9a76-e1fb65ea015f	Pihani		d72eae33-d05a-4350-aebf-08cef4fbf34d
0fdb1a64-05e1-4059-aaa0-1fa740c23b76	Safidon		1cb5bf87-e09b-4605-86bb-f11df93794b6
229d8669-fc81-41b7-b2af-b205e58ffc52	Risod		afa1a4c7-c742-4deb-ba10-79d131bf2a10
35b2ec4f-314c-4cc5-9c74-f07e252053e3	Rosera		aaeb6b5f-0633-47b5-9100-e9024700ece0
968ba55f-0832-49ee-8b4e-01590a48b1c1	Sankari		99c94553-c81e-4dfb-98b1-377247c307bb
63384efc-43bb-405a-8cbc-f902d4a4eb7f	Malpura		7b0ea670-6161-44cf-85e4-98e2d2f37975
eea004bb-109c-48c1-bdca-5e362b28b645	Sonamukhi		4d66d7f3-42f7-4fb7-945b-5093e9902b93
a7c34e94-a3d2-4ca6-b7cb-4aa2f6c39ef4	Shamsabad, Agra		d72eae33-d05a-4350-aebf-08cef4fbf34d
d6a5bc52-fc09-4c18-b576-da57707000ad	Nokha		aaeb6b5f-0633-47b5-9100-e9024700ece0
5b5859f6-0552-465c-adea-c6b4372069dc	PandUrban Agglomeration		4d66d7f3-42f7-4fb7-945b-5093e9902b93
c9207f01-328d-492a-9ccc-3b10d81a640b	Mainaguri		4d66d7f3-42f7-4fb7-945b-5093e9902b93
2a2829ff-6a90-49c0-b062-fb268e09658b	Afzalpur		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
60c46a6c-63ee-4de1-90f5-073218bc5287	Shirur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
ae738b8e-e40a-4e1a-80b2-5e1359d622d1	Salaya		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
40412e16-c042-46b0-bb4c-aed8df0e1c60	Shenkottai		99c94553-c81e-4dfb-98b1-377247c307bb
1ce2b499-c965-4dc5-bf96-93a47d4fabf8	Pratapgarh		1d8e1820-480f-4c27-a44f-198d7063010f
07fbcc07-65cd-4b81-9c73-04cd10f4c895	Vadipatti		99c94553-c81e-4dfb-98b1-377247c307bb
22fcaf17-703e-4033-860e-d7c64f44a4ee	Nagarkurnool		b65398bc-aa42-475d-bc07-a6730719da86
65787524-541d-4288-994b-9877fbf6ce56	Savner		afa1a4c7-c742-4deb-ba10-79d131bf2a10
d4b2bd75-824d-4b67-beda-8bac444f3e7a	Sasvad		afa1a4c7-c742-4deb-ba10-79d131bf2a10
bfc71a31-639f-4f63-a3b1-b3b2d1db9e2c	Rudrapur		d72eae33-d05a-4350-aebf-08cef4fbf34d
8d398d35-471b-46b1-b915-5607dfb0df5b	Soron		d72eae33-d05a-4350-aebf-08cef4fbf34d
f0ae1dac-64b1-422e-8a75-9aae35c252a7	Sholingur		99c94553-c81e-4dfb-98b1-377247c307bb
b2fa9d58-b79a-4a05-a8c5-36816b0fdf75	Pandharkaoda		afa1a4c7-c742-4deb-ba10-79d131bf2a10
6150e8b8-ed96-4b7a-bc1f-2d3764f12d88	Perumbavoor		f8911f17-19b1-46d9-b708-a727912638c8
e9bc3651-7b12-4f56-b005-7b83df7a0c36	Maddur		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
ff3919bc-fb2e-4681-beb1-481e5486fe89	Nadbai		7b0ea670-6161-44cf-85e4-98e2d2f37975
dc67f1ba-78b5-4d67-a5cf-e1b4292eb041	Talode		afa1a4c7-c742-4deb-ba10-79d131bf2a10
c63e2fa8-7997-44c2-b46a-cde8433f4446	Shrigonda		afa1a4c7-c742-4deb-ba10-79d131bf2a10
3ab480c5-6200-434a-a01c-4eaa09c3eb8f	Madhugiri		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
50bd9dfe-e2a5-4602-8eba-28c13e13f859	Tekkalakote		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
5a9a87da-a985-47f2-a9a6-d352f809e176	Seoni-Malwa		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
f52c20c0-debd-41ef-9b7f-5ec358f5bb40	Shirdi		afa1a4c7-c742-4deb-ba10-79d131bf2a10
ae4c9af0-be2b-4f18-8ab6-604ce064308a	SUrban Agglomerationr		d72eae33-d05a-4350-aebf-08cef4fbf34d
4d04e0b3-1a9c-4517-a44f-95cedd8c9884	Terdal		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
e5369d33-26dd-4adc-a73b-ee028920bbc3	Raver		afa1a4c7-c742-4deb-ba10-79d131bf2a10
1cecebfe-a72d-4f36-988b-5ff7c8060cc2	Tirupathur		99c94553-c81e-4dfb-98b1-377247c307bb
7963944f-2ec2-4f85-be0f-4116a7d7d4e4	Taraori		1cb5bf87-e09b-4605-86bb-f11df93794b6
80105a03-c852-4821-a4db-59591178c77a	Mukhed		afa1a4c7-c742-4deb-ba10-79d131bf2a10
171e0e70-f38b-40bc-b31a-891d1611d3df	Manachanallur		99c94553-c81e-4dfb-98b1-377247c307bb
043646df-e478-46c1-9132-bff2a4ca6430	Rehli		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
2ed29e7a-3ea9-4608-a64e-77f79dd9556b	Sanchore		7b0ea670-6161-44cf-85e4-98e2d2f37975
80cdea10-a549-483b-94b2-0980e27ff0c4	Rajura		afa1a4c7-c742-4deb-ba10-79d131bf2a10
edb9a2d5-0a34-45bb-95ee-03aae92fce5b	Piro		aaeb6b5f-0633-47b5-9100-e9024700ece0
5a90f407-60c9-4ff3-8b95-f47326c66f4a	Mudabidri		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
7adb733c-e615-4442-96f5-aefcbbf9857f	Vadgaon Kasba		afa1a4c7-c742-4deb-ba10-79d131bf2a10
068bb837-b837-4414-b958-955b086b110a	Nagar		7b0ea670-6161-44cf-85e4-98e2d2f37975
e87a699d-5c0c-4229-adbe-b3ea4e707194	Vijapur		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
44132cd6-c9a6-4a12-bbd3-23ae8b9910cb	Viswanatham		99c94553-c81e-4dfb-98b1-377247c307bb
289eff08-09c1-4485-9457-1fc7607898fd	Polur		99c94553-c81e-4dfb-98b1-377247c307bb
f581ef5d-a964-4808-ac68-6d7eadd96fe4	Panagudi		99c94553-c81e-4dfb-98b1-377247c307bb
fe977d5d-1bdc-4aed-8ce5-dae2b924659b	Manawar		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
302217b2-fb64-4b9b-84ee-308c91e02611	Tehri		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
5449af22-52a8-4b62-ada5-ae44a3acfee8	Samdhan		d72eae33-d05a-4350-aebf-08cef4fbf34d
e2c8e40e-7a7c-49cc-a9b4-4bc712f2edc5	Pardi		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
2dd9bc25-63ba-408f-a90b-7a855e9df7d3	Rahatgarh		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
e31cdbb1-8acc-4ade-8be5-975491b1da05	Panagar		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
4fa02a4a-22c4-46c5-88c7-936875756217	Uthiramerur		99c94553-c81e-4dfb-98b1-377247c307bb
0bb9d437-d17d-4176-abf3-65d1f0a495d4	Tirora		afa1a4c7-c742-4deb-ba10-79d131bf2a10
29475c12-c976-43ce-933e-e5dfa083c749	Rangia		694a90d0-c9a5-4835-95df-e9498c78c360
688afc1c-7226-4a25-a5dc-33cced4a5ffa	Sahjanwa		d72eae33-d05a-4350-aebf-08cef4fbf34d
0be0e66e-92b8-4318-8e22-fb7df79d2b01	Wara Seoni		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
3963788e-0a5a-46e0-884f-404d0d1d75d1	Magadi		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
c3a374f9-1905-4949-a6e2-6f954a355dac	Rajgarh (Alwar)		7b0ea670-6161-44cf-85e4-98e2d2f37975
c0ba0f3b-af13-4659-8d24-fb70f761dc04	Rafiganj		aaeb6b5f-0633-47b5-9100-e9024700ece0
5ac6a80b-08c0-4a81-8ec0-883294266ade	Tarana		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
8d50f64f-2b38-4233-b026-dd288897bf79	Rampur Maniharan		d72eae33-d05a-4350-aebf-08cef4fbf34d
1a4d22b7-2538-4885-b553-ca08631a900e	Sheoganj		7b0ea670-6161-44cf-85e4-98e2d2f37975
bbcb750c-7755-4371-aac2-2f83fba5d62e	Raikot		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
b61d2c92-fabb-40b5-ab2b-10b3a4efd7d0	Pauri		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
012b020d-dfbf-42d4-9ec9-ac8c485f5050	Sumerpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
55cab62d-b0c8-48cb-8557-f5a8fb090a71	Navalgund		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
d21c0d09-bab1-44a0-ba70-6e0de3f6fc09	Shahganj		d72eae33-d05a-4350-aebf-08cef4fbf34d
bd75bb89-03ec-46b4-8976-0785b45dfdda	Marhaura		aaeb6b5f-0633-47b5-9100-e9024700ece0
108258c2-bccb-485a-ae68-5158481575c6	Tulsipur		d72eae33-d05a-4350-aebf-08cef4fbf34d
683e9243-ae0f-45b0-b70e-bda139da7901	Sadri		7b0ea670-6161-44cf-85e4-98e2d2f37975
861d5411-855d-4b86-8c9f-6d5c4e3bc2e1	Thiruthuraipoondi		99c94553-c81e-4dfb-98b1-377247c307bb
54305b95-0625-48bc-8594-74cf8d0901ef	Shiggaon		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
6656a10c-7dcd-434c-84db-5c42e67e9f6f	Pallapatti		99c94553-c81e-4dfb-98b1-377247c307bb
c439752e-dbef-4567-9300-14364eeb48c4	Mahendragarh		1cb5bf87-e09b-4605-86bb-f11df93794b6
ca7b0a9d-33a3-40a4-ac4c-72f5f8d4d9ef	Sausar		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
a0f924d3-2b63-4d24-9996-070e51a6357a	Ponneri		99c94553-c81e-4dfb-98b1-377247c307bb
50ba8a30-1259-4cc3-91d2-3bb1493befa0	Mahad		afa1a4c7-c742-4deb-ba10-79d131bf2a10
ff1b0aa1-085f-44cb-8ae7-2f408f1cd7ac	Lohardaga		6c763981-576b-450b-8db6-778b1c243803
f6ee1ba3-01ca-4735-abbc-671d16eea963	Tirwaganj		d72eae33-d05a-4350-aebf-08cef4fbf34d
9977576a-1f5b-41f5-865c-15733e63172c	Margherita		694a90d0-c9a5-4835-95df-e9498c78c360
488b421f-5c7a-48eb-8132-ecd0a4c89e6e	Sundarnagar		616becf7-866b-4cb6-aa57-0afa29cac4f4
833b197f-3bbb-4c2c-bf18-8dd813985416	Rajgarh		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
58d5d6ee-c7e2-40cc-8027-7949149eaa5f	Mangaldoi		694a90d0-c9a5-4835-95df-e9498c78c360
cfe202c6-93d5-45e5-ba26-98fd5a7d40fc	Renigunta		d0a039df-6e75-4597-9f80-fa3a055b0bee
5d363c58-4438-462c-91c8-6d381cbc39c6	Longowal		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
a5267334-c9f0-44b5-9724-0675871f072f	Ratia		1cb5bf87-e09b-4605-86bb-f11df93794b6
97f962b0-3e7e-4f1d-a8d4-679b89a7744c	Lalgudi		99c94553-c81e-4dfb-98b1-377247c307bb
1878b9a5-855a-4b9b-a9c5-96afab9abf82	Shrirangapattana		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
3034b4cf-d753-4805-8b79-4046491e3d97	Niwari		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
ae12b77a-aa85-4e36-8ca0-38264a4b2df9	Natham		99c94553-c81e-4dfb-98b1-377247c307bb
b66c833f-1e89-4701-98a2-7fb85dc7b175	Unnamalaikadai		99c94553-c81e-4dfb-98b1-377247c307bb
820c2bea-2da3-44c0-bd40-b9516dafc5e4	PurqUrban Agglomerationzi		d72eae33-d05a-4350-aebf-08cef4fbf34d
13e153f6-20ed-4026-b91a-c883fa8acf17	Shamsabad, Farrukhabad		d72eae33-d05a-4350-aebf-08cef4fbf34d
f1433078-7f36-4420-8740-b698c5497e32	Mirganj		aaeb6b5f-0633-47b5-9100-e9024700ece0
011b1d97-c236-4657-b297-ddc4ffd3150c	Todaraisingh		7b0ea670-6161-44cf-85e4-98e2d2f37975
de707ba0-8c39-4f92-ab83-9abd949fd519	Warhapur		d72eae33-d05a-4350-aebf-08cef4fbf34d
88fcab61-b255-4679-99fb-a59ed9d20552	Rajam		d0a039df-6e75-4597-9f80-fa3a055b0bee
d26e45ef-0272-450d-84ab-4b8755da8dfd	Urmar Tanda		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
2b7192e4-7c79-4985-bc9d-5d1c3689ed82	Lonar		afa1a4c7-c742-4deb-ba10-79d131bf2a10
1769e994-8c84-49c5-85f3-1ebfa3030e0d	Powayan		d72eae33-d05a-4350-aebf-08cef4fbf34d
e7861da8-a1e2-406a-b962-db2bae034759	P.N.Patti		99c94553-c81e-4dfb-98b1-377247c307bb
20752937-834f-4d2a-9c0b-50c50a06691f	Palampur		616becf7-866b-4cb6-aa57-0afa29cac4f4
976cba52-f1a6-4ecd-b372-a33519951d19	Srisailam Project (Right Flank Colony) Township		d0a039df-6e75-4597-9f80-fa3a055b0bee
2e4d1cd2-fb8f-474e-8aeb-6b0dc4e48985	Sindagi		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
f82f1022-18e7-4e67-ba49-814aaf212fb9	Sandi		d72eae33-d05a-4350-aebf-08cef4fbf34d
22ee692b-086f-43dc-b9fc-3e7a0b32e3f0	Vaikom		f8911f17-19b1-46d9-b708-a727912638c8
2108ebe5-c100-4fda-b522-ee4a361434b3	Malda		4d66d7f3-42f7-4fb7-945b-5093e9902b93
0ce76aa2-d422-4b41-9952-ab0f882b17ac	Tharangambadi		99c94553-c81e-4dfb-98b1-377247c307bb
d8ce50e1-f076-4f11-8cfc-6ec85d8f333f	Sakaleshapura		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
daacc96f-0d9d-47d4-9cd8-4e4b03066b17	Lalganj		aaeb6b5f-0633-47b5-9100-e9024700ece0
ebb53afc-a242-44f5-8021-568845221d45	Malkangiri		57eb2330-c405-46f3-a60a-0622d0086b77
cd04fd57-9753-45cc-830b-2f88ae058425	Rapar		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
ca059268-fbbb-4dfa-9411-74c627a189d4	Mauganj		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
628ab7fe-f8f7-4d53-ad3c-0a3d483f34a8	Todabhim		7b0ea670-6161-44cf-85e4-98e2d2f37975
5c61e917-9d3c-4ce6-b1d5-bc3892553887	Srinivaspur		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
f17c87ff-0827-470c-adf1-e730fb744c31	Murliganj		aaeb6b5f-0633-47b5-9100-e9024700ece0
5d5534e7-363f-4048-a194-4fc281d2d73f	Reengus		7b0ea670-6161-44cf-85e4-98e2d2f37975
db8f4075-4a3f-40b0-8500-becf63b0eb13	Sawantwadi		afa1a4c7-c742-4deb-ba10-79d131bf2a10
4016d4e5-cafd-4e58-9ace-cf10d91cad16	Tittakudi		99c94553-c81e-4dfb-98b1-377247c307bb
cddb1260-4f74-4634-90ef-0870bf9f61db	Lilong		d7c7eee9-db08-4e00-a306-55790fbb52b5
ad188f15-3622-437c-ad1f-e9b585137c1e	Rajaldesar		7b0ea670-6161-44cf-85e4-98e2d2f37975
4c8ecfdd-ae59-40da-a578-399953e5c6d2	Pathardi		afa1a4c7-c742-4deb-ba10-79d131bf2a10
0ab86b0e-ae6f-406b-be2f-f7dc023d16f9	Achhnera		d72eae33-d05a-4350-aebf-08cef4fbf34d
70ecae35-eedd-43de-b39c-33041d0c8df5	Pacode		99c94553-c81e-4dfb-98b1-377247c307bb
897f23f1-d68d-469a-b994-cc8c4ee5ac34	Naraura		d72eae33-d05a-4350-aebf-08cef4fbf34d
b2d6d19c-4302-497d-908b-597f6a1d38a0	Nakur		d72eae33-d05a-4350-aebf-08cef4fbf34d
18c4b8c4-1ca9-43cc-82a4-9729286ad283	Palai		f8911f17-19b1-46d9-b708-a727912638c8
e7a8ba70-5680-46d4-a604-4010982bf518	Niwai		d72eae33-d05a-4350-aebf-08cef4fbf34d
3d4a4010-636c-46cd-9d28-3d5fee507072	Morinda, India		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
182090e1-6e66-4ed4-b489-c60c83e389c6	Manasa		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
b9f32b5d-81f1-4acb-a736-3bf81c3ee98f	Nainpur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
cf29daaa-264c-4ad3-93fa-b904fa7a4c5f	Sahaspur		d72eae33-d05a-4350-aebf-08cef4fbf34d
073e6abd-144d-4e9b-acf1-fdc9a3787caf	Pauni		afa1a4c7-c742-4deb-ba10-79d131bf2a10
d1079d28-75f4-4512-a540-b7fd0990849b	Prithvipur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
3ca6f1f5-f7b7-4a8b-bca4-56563082844a	Ramtek		afa1a4c7-c742-4deb-ba10-79d131bf2a10
5eeb0b80-e1d9-4a95-93ea-48e7147f8368	Silapathar		694a90d0-c9a5-4835-95df-e9498c78c360
627e266d-b1af-4468-92bb-ec536515e0c7	Songadh		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
29664793-9ec2-4094-ad1a-33aed9b61451	Safipur		d72eae33-d05a-4350-aebf-08cef4fbf34d
f69b0163-4ba9-4766-93c1-ca8deab45add	Sohagpur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
382c8852-ebf2-4ce8-9540-c86b0a3e2174	Mul		afa1a4c7-c742-4deb-ba10-79d131bf2a10
0248846c-be67-4ae2-a43d-031b154c0056	Sadulshahar		7b0ea670-6161-44cf-85e4-98e2d2f37975
782edf1e-2c4a-4658-ba24-6d406dd03348	Phillaur		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
1915985c-fdb6-4c7e-a437-ee4f8a5fe1d4	Sambhar		7b0ea670-6161-44cf-85e4-98e2d2f37975
a0b7c80e-4795-4cd6-8dd0-d79e9830f8eb	Prantij		7b0ea670-6161-44cf-85e4-98e2d2f37975
e7e2cba6-9a8d-4df5-943f-6595d6aae9b8	Nagla		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
c3342632-ba50-4b72-b19c-bcd9b68f1d07	Pattran		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
36e2f2e7-4830-4616-979f-e25237b63868	Mount Abu		7b0ea670-6161-44cf-85e4-98e2d2f37975
fc5c4759-067c-4405-ad67-d42eddbd17a6	Reoti		d72eae33-d05a-4350-aebf-08cef4fbf34d
8282c280-9201-4735-8bf7-0879b44eb6ed	Tenu dam-cum-Kathhara		6c763981-576b-450b-8db6-778b1c243803
fa9993b9-8e5e-4d02-8c9a-4edb2a6078c2	Panchla		4d66d7f3-42f7-4fb7-945b-5093e9902b93
07cfb6dd-38f1-4804-b37f-435a9eb307ed	Sitarganj		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
14890d2a-50c4-4308-a070-c733645afd5e	Pasighat		2edcbd08-3238-4873-9bbd-55c79cdc71f3
10f6ab6e-634e-4648-9d68-3c1936d66db1	Motipur		aaeb6b5f-0633-47b5-9100-e9024700ece0
c56e832c-cb7a-40fd-988a-743c4ad69fbd	O' Valley		99c94553-c81e-4dfb-98b1-377247c307bb
5b48b0e2-7802-4746-b0c4-100aca629247	Raghunathpur		4d66d7f3-42f7-4fb7-945b-5093e9902b93
86d2e2c9-a034-4fb7-8654-264f672adaf7	Suriyampalayam		99c94553-c81e-4dfb-98b1-377247c307bb
1d51f3bf-881c-4fed-9a5a-d0a7110ad506	Qadian		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
89e26f78-372d-48b2-9dd9-3d8dd901dd96	Rairangpur		57eb2330-c405-46f3-a60a-0622d0086b77
365cd91f-9bcc-464e-a582-154943b98d11	Silvassa		ddcae2d2-c10e-451a-a418-744c4f447653
c590b0f8-bc7b-4712-9fde-9eb0408dbdb8	Nowrozabad (Khodargama)		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
ac4922d1-a4f7-4504-a580-fdd1d54fa95e	Mangrol		7b0ea670-6161-44cf-85e4-98e2d2f37975
21a6a641-f036-4a2b-aed9-3219498840d3	Soyagaon		afa1a4c7-c742-4deb-ba10-79d131bf2a10
b9a6cd53-a51f-4553-9115-acfba113cbfa	Sujanpur		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
43c4bf6b-8c52-4bc4-87fc-f8293f5d78bf	Manihari		aaeb6b5f-0633-47b5-9100-e9024700ece0
89dc5ef6-bb95-4649-8424-b079a16bb41a	Sikanderpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
9da746fd-0d1a-4370-b2cf-72a50c620020	Mangalvedhe		afa1a4c7-c742-4deb-ba10-79d131bf2a10
1109bbbe-bd63-4b0e-9e16-53e2199b2e8c	Phulera		7b0ea670-6161-44cf-85e4-98e2d2f37975
46787e86-1245-4864-a145-e2d31f49e125	Ron		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
10475ba4-d973-44f4-a510-5b2796cc4568	Sholavandan		99c94553-c81e-4dfb-98b1-377247c307bb
8583483c-9334-4b90-9768-9fa5c1a8d841	Saidpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
78f55203-411b-475c-a21d-2037a04178dd	Shamgarh		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
ffdbe078-9b5f-40e4-8c46-ad393817208c	Thammampatti		99c94553-c81e-4dfb-98b1-377247c307bb
69f7b463-360f-4a2e-82a7-f2429a7b7cb5	Maharajpur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
d0d51f0c-5603-4304-b151-9115631f1358	Multai		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
c0c9017b-c043-4b39-acc5-5f28d0e0ee8a	Mukerian		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
ffaeed7e-ea05-412d-9360-2bb3df03de29	Sirsi		d72eae33-d05a-4350-aebf-08cef4fbf34d
93860a98-6d1d-4df5-88ce-18d1ade66af3	Purwa		d72eae33-d05a-4350-aebf-08cef4fbf34d
326065be-0124-4fc3-82df-18054ca1f14f	Sheohar		aaeb6b5f-0633-47b5-9100-e9024700ece0
1a9458af-aa60-4f0d-b97d-1029fe662402	Namagiripettai		99c94553-c81e-4dfb-98b1-377247c307bb
45a82421-ec1c-477b-9d8e-243d584363b8	Parasi		d72eae33-d05a-4350-aebf-08cef4fbf34d
fcb29570-2fda-4d04-bfe9-738bc7fcd869	Lathi		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
ff8384f2-a339-4281-856c-047f7a3fed6d	Lalganj		d72eae33-d05a-4350-aebf-08cef4fbf34d
a8f4888f-b5e0-467d-9e15-2adcbe670b5e	Narkhed		afa1a4c7-c742-4deb-ba10-79d131bf2a10
4ab97992-9d0f-43ca-8659-ed6649d7d034	Mathabhanga		4d66d7f3-42f7-4fb7-945b-5093e9902b93
8b577496-8a70-4a38-9d1e-133ca0887c89	Shendurjana		afa1a4c7-c742-4deb-ba10-79d131bf2a10
6c845ae2-3612-4bbc-8af6-57037fa476f0	Peravurani		99c94553-c81e-4dfb-98b1-377247c307bb
6493c21e-174d-40be-89b6-a7ca9c250d26	Mariani		694a90d0-c9a5-4835-95df-e9498c78c360
0545103a-9d38-4f20-92df-d35b9eb08988	Phulpur		d72eae33-d05a-4350-aebf-08cef4fbf34d
f1add273-a844-4ea6-8b8f-7a58d8985998	Rania		1cb5bf87-e09b-4605-86bb-f11df93794b6
fa6f0146-3474-4523-aae1-94a38fa82b50	Pali		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
82c2fa6f-9672-40a3-874c-adfb54af5d7c	Pachore		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
128f95c9-a284-4b28-8574-215d5b71582f	Parangipettai		99c94553-c81e-4dfb-98b1-377247c307bb
300f905f-8ff7-47e7-beb5-4c5d82208eb7	Pudupattinam		99c94553-c81e-4dfb-98b1-377247c307bb
30f6752a-e6af-406b-880f-47c4bd5b56d2	Panniyannur		f8911f17-19b1-46d9-b708-a727912638c8
05480a4a-a163-4b1e-93d0-0ae325b9e373	Maharajganj		aaeb6b5f-0633-47b5-9100-e9024700ece0
c9bd1e28-ca94-4485-a30d-c2c2a94b42ad	Rau		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
d382a140-a742-4c0a-b1b0-2066450dfd92	Monoharpur		4d66d7f3-42f7-4fb7-945b-5093e9902b93
8f6dc3ec-80d4-462e-893a-926216717752	Mandawa		7b0ea670-6161-44cf-85e4-98e2d2f37975
49dac826-6424-4a6b-928f-d4b200a32022	Marigaon		694a90d0-c9a5-4835-95df-e9498c78c360
a3c00c18-188b-4612-bef9-c07bca475f1a	Pallikonda		99c94553-c81e-4dfb-98b1-377247c307bb
32fdf7c9-1d98-49ee-a7ee-588f3e2a6378	Pindwara		7b0ea670-6161-44cf-85e4-98e2d2f37975
01ca3652-dacd-46db-b49d-c89f3923bfe6	Shishgarh		d72eae33-d05a-4350-aebf-08cef4fbf34d
0736cde1-73d2-4a56-831c-bfb27d6bf2b2	Patur		afa1a4c7-c742-4deb-ba10-79d131bf2a10
e0137f9a-b9fc-46c0-b078-3202452fd72d	Mayang Imphal		d7c7eee9-db08-4e00-a306-55790fbb52b5
5a9f86c8-e131-4bec-8627-697906888b87	Mhowgaon		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
6eaad186-2131-4ad5-936d-60239faeb197	Guruvayoor		f8911f17-19b1-46d9-b708-a727912638c8
7f7cd983-a3b9-4b86-b71c-d821c743b695	Mhaswad		afa1a4c7-c742-4deb-ba10-79d131bf2a10
8e89e607-db18-4f5e-bcb2-95fd5509a41d	Sahawar		d72eae33-d05a-4350-aebf-08cef4fbf34d
94506bff-8c46-4386-8a52-14be7a81b98f	Sivagiri		99c94553-c81e-4dfb-98b1-377247c307bb
897d14fa-1c08-4476-8150-15db8ba82a60	Mundargi		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
f63c3c61-b635-48d3-be8e-ea424d9d5674	Punjaipugalur		99c94553-c81e-4dfb-98b1-377247c307bb
760e7e14-e3dc-473b-bf6a-79d3c76a0e17	Kailasahar		1d8e1820-480f-4c27-a44f-198d7063010f
48022047-4fe9-4c6c-a600-e3bfa904dc60	Samthar		d72eae33-d05a-4350-aebf-08cef4fbf34d
71e32a79-73dd-4ee3-9845-3e23ab6edf3d	Sakti		ea160870-ab8b-4cae-a772-0a80b566470f
efb2d973-0031-45e2-8ead-75ac1b8c2394	Sadalagi		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
05e9690e-b9a0-4231-970c-cab42b07b5bd	Silao		aaeb6b5f-0633-47b5-9100-e9024700ece0
74e4809f-a6ab-4ad4-8767-879b3f91fa31	Mandalgarh		7b0ea670-6161-44cf-85e4-98e2d2f37975
8d1ea5c0-4af3-4aa0-a5c1-0c8f1c2be979	Loha		afa1a4c7-c742-4deb-ba10-79d131bf2a10
ecc4391d-6371-4432-9a2c-a7d3b0646722	Pukhrayan		d72eae33-d05a-4350-aebf-08cef4fbf34d
b76da029-f8d0-4f6d-9c6b-c39ffef8444e	Padmanabhapuram		99c94553-c81e-4dfb-98b1-377247c307bb
2daeb7e8-248e-49be-9254-90564cc338ba	Belonia		1d8e1820-480f-4c27-a44f-198d7063010f
145b4ec6-1326-4c96-b2d5-71489d0b34b4	Saiha		d0a2b263-0189-4e7b-9422-74d3e3915294
e4b10ed9-d68b-4ff9-9eb9-112c11c960b2	Srirampore		4d66d7f3-42f7-4fb7-945b-5093e9902b93
86a34403-3589-48fa-99b2-9eb150d5957f	Talwara		82ebab7f-eeaf-4a1d-9d1d-31780a997ced
5cedd1a6-5f6f-4592-b085-16195b5c3ac7	Puthuppally		f8911f17-19b1-46d9-b708-a727912638c8
18be37cc-1f2e-4381-b8df-0e1a8425bff7	Khowai		1d8e1820-480f-4c27-a44f-198d7063010f
7824a9d4-6527-43fd-a3e8-ec85e1c1b6ca	Vijaypur		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
63ab86b8-0277-415b-b1d2-d60fec4fdf5e	Takhatgarh		7b0ea670-6161-44cf-85e4-98e2d2f37975
5d3d37ae-75ec-4058-b650-977d7dca4ecb	Thirupuvanam		99c94553-c81e-4dfb-98b1-377247c307bb
c8ab1652-5394-4021-896a-9f77b6bb797d	Adra		4d66d7f3-42f7-4fb7-945b-5093e9902b93
6815c962-8b85-4300-8227-d941eab7d32b	Piriyapatna		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
4d86acea-dcd0-4060-9ab6-8620eb6dc81b	Obra		d72eae33-d05a-4350-aebf-08cef4fbf34d
b0cd7e0f-2b19-462e-a640-ce312bb12af8	Adalaj		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
ce44bf5e-4767-4e40-abf7-865fd0ccf158	Nandgaon		afa1a4c7-c742-4deb-ba10-79d131bf2a10
82dcd1e1-6b39-4f22-9c44-dbee5e032264	Barh		aaeb6b5f-0633-47b5-9100-e9024700ece0
84db3c4d-b9f7-4446-aa3c-ddf0410c9006	Chhapra		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
da18e18e-e4ae-4992-94e3-d90d17a216b0	Panamattom		f8911f17-19b1-46d9-b708-a727912638c8
b9e89173-ef8b-4b5d-9a75-401f6f05af31	Bageshwar		ee5968f1-81d8-40b2-982e-4b4c5d5205bc
50a53b63-feef-4776-b816-3141e3aecd70	Tarbha		57eb2330-c405-46f3-a60a-0622d0086b77
93eb1c9a-7af6-4cba-922d-d31cd0e2f810	Adyar		cccb653d-fb71-4cc1-bfd3-f0737de22ae3
be15f137-b75a-4210-96cf-84c52f044c40	Narsinghgarh		7b7382f9-b9dc-42b4-8a2d-264a731fe7cb
c6ff83de-1923-496b-b46c-9b2328580d22	Warud		afa1a4c7-c742-4deb-ba10-79d131bf2a10
70cc0ae0-8742-481f-a950-adc03f3f377b	Asarganj		aaeb6b5f-0633-47b5-9100-e9024700ece0
6ccaf4d3-d5e8-4947-b4e4-3675e35435cb	Sarsod		1cb5bf87-e09b-4605-86bb-f11df93794b6
e1542bda-1f86-4398-9332-61a1635ef18a	Gandhinagar		e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6
8c9de4aa-6d9c-4ffe-835c-b51ffe3a529f	Kullu		616becf7-866b-4cb6-aa57-0afa29cac4f4
7bf1efc6-e8e3-4dee-8e03-11ee8fbb2a9e	Manali		616becf7-866b-4cb6-aa57-0afa29cac4f4
4488a188-f0bb-48f0-95c5-3c446f050b03	Mirzapur		d72eae33-d05a-4350-aebf-08cef4fbf34d
41fb4de5-0a01-4d8f-9535-d00845b8a4ee	Kota		7b0ea670-6161-44cf-85e4-98e2d2f37975
335577cc-48a3-49ab-801a-2e4eb58c33b7	Dispur		694a90d0-c9a5-4835-95df-e9498c78c360
\.


--
-- Data for Name: contribution_price_items; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.contribution_price_items (created_at, updated_at, id, serial_no, value, contribution_id, price_item_id) FROM stdin;
2024-01-30 05:17:43.587788+00	2024-01-30 05:17:43.587788+00	c74a67c5-f09c-4b99-9ba9-a14152da0af6	1	919000.00	4885ef82-f64e-40ca-bb2a-6e0d4d56ff08	d4b67ec9-c2c9-4f6b-964e-f03e389c8c2f
2024-01-30 05:17:43.587788+00	2024-01-30 05:17:43.587788+00	ed6f396f-1652-4f29-bb40-75cc8b363e4d	3	37631.00	4885ef82-f64e-40ca-bb2a-6e0d4d56ff08	9edf5329-d563-49ae-b1b7-f18e6bfbc15d
2024-01-30 05:17:43.587788+00	2024-01-30 05:17:43.587788+00	70a068e0-fa3d-4585-951f-610cef663073	4	101090.00	4885ef82-f64e-40ca-bb2a-6e0d4d56ff08	60ea232c-467d-451c-ba35-c7b5b4e438da
2024-01-30 05:17:43.587788+00	2024-01-30 05:17:43.587788+00	33fb09c4-4268-4633-9884-39050ad305fd	6	19771.00	4885ef82-f64e-40ca-bb2a-6e0d4d56ff08	7a6e79cf-563c-4808-bd21-c13ce2e82827
2024-01-30 05:17:43.587788+00	2024-01-30 05:17:43.587788+00	c5bb7759-c8e3-4954-9471-8dd39a2c8874	7	500.00	4885ef82-f64e-40ca-bb2a-6e0d4d56ff08	e9e36ee7-c32b-481a-8cd3-c248a57cc3bd
2024-01-30 05:17:43.587788+00	2024-01-30 05:17:43.587788+00	65fa0825-07a9-4c42-b148-b49c0655e114	8	20094.00	4885ef82-f64e-40ca-bb2a-6e0d4d56ff08	640df0bf-f2d5-4c37-b464-7aab07382f53
2024-01-30 05:17:43.587788+00	2024-01-30 05:17:43.587788+00	b95d102a-f58e-44d9-b006-dde07598b885	9	4572.00	4885ef82-f64e-40ca-bb2a-6e0d4d56ff08	0081a02a-0a43-49c1-9ed2-8ac55c25f1fc
2024-02-17 08:02:47.108426+00	2024-02-17 08:02:47.108426+00	93e1c71e-5f08-472e-9aab-48974a9034d5	1	108344.00	f1e4c888-d13c-4924-8c6c-92ea3b790cf0	d4b67ec9-c2c9-4f6b-964e-f03e389c8c2f
2024-02-17 08:02:47.108426+00	2024-02-17 08:02:47.108426+00	659d08b3-fc97-4c58-bb86-e4abfcb2b9fa	2	2500.00	f1e4c888-d13c-4924-8c6c-92ea3b790cf0	9edf5329-d563-49ae-b1b7-f18e6bfbc15d
2024-02-17 08:02:47.108426+00	2024-02-17 08:02:47.108426+00	47142c7a-647e-4728-9ca6-59db178a5b9a	3	1500.00	f1e4c888-d13c-4924-8c6c-92ea3b790cf0	60ea232c-467d-451c-ba35-c7b5b4e438da
2024-02-17 08:02:47.108426+00	2024-02-17 08:02:47.108426+00	b725a92c-bd2c-4018-8bfa-4766808654fa	4	4000.00	f1e4c888-d13c-4924-8c6c-92ea3b790cf0	8ae525cc-9b34-42a5-b33b-c8cd2caba1f1
2024-02-17 08:02:47.108426+00	2024-02-17 08:02:47.108426+00	c9f739f7-d935-43cf-b909-a660ff7c02a0	5	9000.00	f1e4c888-d13c-4924-8c6c-92ea3b790cf0	60aabb24-f95d-47eb-9b5b-fa53794415ab
2024-02-17 08:02:47.108426+00	2024-02-17 08:02:47.108426+00	b7258c10-4f35-43ec-b87a-711b44325987	6	28500.00	f1e4c888-d13c-4924-8c6c-92ea3b790cf0	a94cde51-511e-414b-8c2b-afb4e1cc9a40
2024-02-17 08:02:47.108426+00	2024-02-17 08:02:47.108426+00	d37ad16b-fc26-461c-8beb-b632f0bc2990	7	2000.00	f1e4c888-d13c-4924-8c6c-92ea3b790cf0	a832dd83-3ec5-47ed-946a-06d7905a07cd
2024-02-18 05:07:16.761073+00	2024-02-18 05:07:16.761073+00	1e672511-8567-4f81-9407-a07c65fef37e	1	108900.00	13cc3e04-a5a9-4de8-8304-866fecd4d1b9	d4b67ec9-c2c9-4f6b-964e-f03e389c8c2f
2024-02-18 05:07:16.761073+00	2024-02-18 05:07:16.761073+00	fe85023f-b167-4fca-bd68-85fbd056857b	3	2500.00	13cc3e04-a5a9-4de8-8304-866fecd4d1b9	9edf5329-d563-49ae-b1b7-f18e6bfbc15d
2024-02-18 05:07:16.761073+00	2024-02-18 05:07:16.761073+00	9716bcb4-7f89-4c6c-bed1-440e5819ee60	4	1500.00	13cc3e04-a5a9-4de8-8304-866fecd4d1b9	60ea232c-467d-451c-ba35-c7b5b4e438da
2024-02-18 05:07:16.761073+00	2024-02-18 05:07:16.761073+00	590448a3-63f5-4e38-865f-9589c3461bfc	5	4000.00	13cc3e04-a5a9-4de8-8304-866fecd4d1b9	8ae525cc-9b34-42a5-b33b-c8cd2caba1f1
2024-02-18 05:07:16.761073+00	2024-02-18 05:07:16.761073+00	f291eaf4-898f-410c-a54d-cfc67918866a	6	6000.00	13cc3e04-a5a9-4de8-8304-866fecd4d1b9	60aabb24-f95d-47eb-9b5b-fa53794415ab
2024-02-18 05:07:16.761073+00	2024-02-18 05:07:16.761073+00	40b17c92-e94d-42d3-9114-7431301342ed	7	28500.00	13cc3e04-a5a9-4de8-8304-866fecd4d1b9	a94cde51-511e-414b-8c2b-afb4e1cc9a40
2024-02-23 05:14:49.794076+00	2024-02-23 05:14:49.794076+00	37027077-15a4-4dd1-956c-e068d2f40fd3	1	119000.00	1e4136f3-b950-4ffb-bd18-ca3e2e5c2989	d4b67ec9-c2c9-4f6b-964e-f03e389c8c2f
2024-02-24 18:07:35.378619+00	2024-02-24 18:07:35.378619+00	5fb56c6b-3182-4b0e-9557-60a1bf8355b3	1	2400000.00	fff9645f-8f21-4031-b179-9ff46f2e03fb	d4b67ec9-c2c9-4f6b-964e-f03e389c8c2f
2024-02-24 18:07:35.378619+00	2024-02-24 18:07:35.378619+00	110876c1-ca18-48ab-9621-c7e2393e1e9e	2	250000.00	fff9645f-8f21-4031-b179-9ff46f2e03fb	bee9b5c2-6e97-494d-9cd9-140380c78c16
2024-02-24 18:07:35.378619+00	2024-02-24 18:07:35.378619+00	aa17095f-a7a2-4caf-9a5e-0567408c4e81	3	40000.00	fff9645f-8f21-4031-b179-9ff46f2e03fb	9edf5329-d563-49ae-b1b7-f18e6bfbc15d
2024-02-24 18:07:35.378619+00	2024-02-24 18:07:35.378619+00	1e2a5963-3e3b-4262-a827-2303c8160072	4	50000.00	fff9645f-8f21-4031-b179-9ff46f2e03fb	60ea232c-467d-451c-ba35-c7b5b4e438da
2024-02-24 18:21:48.876192+00	2024-02-24 18:21:48.876192+00	622a1c9f-3d7a-4429-b57a-b5b2c57eb66f	1	2400000.00	a38f17ad-d441-4b32-87be-b3dace80ff8b	d4b67ec9-c2c9-4f6b-964e-f03e389c8c2f
2024-03-07 13:34:20.753572+00	2024-03-07 13:34:20.753572+00	39fb5efe-3932-48f3-8442-d31929d7d997	1	98000.00	786a731d-8adb-4430-92d1-73f9491a3e03	d4b67ec9-c2c9-4f6b-964e-f03e389c8c2f
2024-03-10 10:05:12.373621+00	2024-03-10 10:05:12.373621+00	65efb6df-37f4-4cef-bb13-04cf9d5845a2	1	119000.00	89591836-2323-461e-92be-d265d5598469	d4b67ec9-c2c9-4f6b-964e-f03e389c8c2f
2024-03-10 10:05:12.373621+00	2024-03-10 10:05:12.373621+00	4dd0807f-1ae7-4aaf-9ca3-37d83751a5c4	4	1500.00	89591836-2323-461e-92be-d265d5598469	60ea232c-467d-451c-ba35-c7b5b4e438da
2024-03-10 10:05:12.373621+00	2024-03-10 10:05:12.373621+00	dec9d451-8aa7-4b52-acf2-b99059e2b982	5	2000.00	89591836-2323-461e-92be-d265d5598469	8ae525cc-9b34-42a5-b33b-c8cd2caba1f1
2024-03-10 10:05:12.373621+00	2024-03-10 10:05:12.373621+00	d1c91bdb-6051-48e6-b6c6-579a2b9b40ec	6	4000.00	89591836-2323-461e-92be-d265d5598469	60aabb24-f95d-47eb-9b5b-fa53794415ab
2024-03-10 10:05:12.373621+00	2024-03-10 10:05:12.373621+00	d5c9ce42-f2a3-4637-bf15-a40b6ee34720	7	28500.00	89591836-2323-461e-92be-d265d5598469	a94cde51-511e-414b-8c2b-afb4e1cc9a40
2024-03-18 08:13:27.844116+00	2024-03-18 08:13:27.844116+00	b9fe4d89-93e8-4fe4-a734-7a6bb5c332ab	1	1500000.00	28972fb5-62f6-4819-afc7-199539e42577	d4b67ec9-c2c9-4f6b-964e-f03e389c8c2f
2024-03-18 08:13:27.844116+00	2024-03-18 08:13:27.844116+00	51ce8514-dd1b-4834-9d29-a457e724a6df	2	45000.00	28972fb5-62f6-4819-afc7-199539e42577	a94cde51-511e-414b-8c2b-afb4e1cc9a40
2024-03-18 08:13:27.844116+00	2024-03-18 08:13:27.844116+00	1a671f27-2ce7-4210-821b-d9216d0fa420	3	25000.00	28972fb5-62f6-4819-afc7-199539e42577	523ade17-98eb-43f8-8040-608b60324f4b
\.


--
-- Data for Name: contributions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.contributions (created_at, updated_at, id, status, quoted_on, dealership_name, total, upvotes, downvotes, remark, city_id, user_id, variant_id, color_id) FROM stdin;
2024-02-18 05:07:16.75697+00	2024-02-18 05:07:16.75697+00	13cc3e04-a5a9-4de8-8304-866fecd4d1b9	PD	2024-02-18		94400.00	1	0		713b7600-4c05-48fc-86d1-31974c747ce3	fef1f4f4-96d4-473e-bbec-e077c396089c	7965067e-dac3-4b60-ba6b-9b8c7e719c72	b3932082-b474-46f6-be1a-275ed5e263ac
2024-02-24 18:07:35.375421+00	2024-02-24 18:07:35.375421+00	fff9645f-8f21-4031-b179-9ff46f2e03fb	PD	2024-02-24		2740000.00	0	0		713b7600-4c05-48fc-86d1-31974c747ce3	11aceaac-d6a4-4835-bb93-2a51aaaad195	af665d7a-3816-4ded-bb8c-57b114588a1a	c58809b1-b2cb-42bd-9a7e-dea3cfb7f1f7
2024-02-24 18:21:48.873272+00	2024-02-24 18:21:48.873272+00	a38f17ad-d441-4b32-87be-b3dace80ff8b	PD	2024-02-24		2400000.00	0	0		713b7600-4c05-48fc-86d1-31974c747ce3	59030e56-cb06-4093-b576-3f6f2ffa9603	af665d7a-3816-4ded-bb8c-57b114588a1a	c58809b1-b2cb-42bd-9a7e-dea3cfb7f1f7
2024-02-28 13:43:11.158834+00	2024-02-28 13:43:11.158834+00	f47f7cd4-a757-4cd9-8a6c-b6172b3daf93	PD	2024-02-29		0.00	1	0		8be181da-5344-4156-9d06-5fa4e98aec2d	7540db5f-1069-45f4-9fa9-b85de1092814	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b	c21b92cf-1db4-4dcb-9a02-4ac3c8b4b89d
2024-03-07 13:34:20.74296+00	2024-03-07 13:34:20.74296+00	786a731d-8adb-4430-92d1-73f9491a3e03	PD	2024-03-07		98000.00	0	0		713b7600-4c05-48fc-86d1-31974c747ce3	0c95228e-47d8-4fa9-aa0f-a260913e211f	7965067e-dac3-4b60-ba6b-9b8c7e719c72	\N
2024-01-30 05:17:43.584383+00	2024-01-30 05:17:43.584383+00	4885ef82-f64e-40ca-bb2a-6e0d4d56ff08	AC	2024-01-30	Khushi Kia, Nashik	1102658.00	2	0	Very smooth purchasing process	713b7600-4c05-48fc-86d1-31974c747ce3	479c457f-d99e-40d4-b5e7-38ecb8b271b4	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b	\N
2024-03-10 10:05:12.364308+00	2024-03-10 10:05:12.364308+00	89591836-2323-461e-92be-d265d5598469	PD	2024-03-10	Anutek	98000.00	0	0	This is wrong	713b7600-4c05-48fc-86d1-31974c747ce3	e03edb6b-3137-4461-a0ee-9e73d58f08a8	7965067e-dac3-4b60-ba6b-9b8c7e719c72	ae7d1105-cb9f-483a-b9b6-d7cd4f9d1527
2024-02-23 05:14:49.789995+00	2024-02-23 05:14:49.789995+00	1e4136f3-b950-4ffb-bd18-ca3e2e5c2989	PD	2024-02-23		119000.00	0	1		713b7600-4c05-48fc-86d1-31974c747ce3	9db134d5-bc29-411e-898c-2331bb99ab08	7965067e-dac3-4b60-ba6b-9b8c7e719c72	\N
2024-03-18 08:13:27.833598+00	2024-03-18 08:13:27.833598+00	28972fb5-62f6-4819-afc7-199539e42577	PD	2024-03-18	Irfan	1430000.00	0	0	xyz	713b7600-4c05-48fc-86d1-31974c747ce3	4f173bce-c90a-437f-9690-acaf88b93490	7965067e-dac3-4b60-ba6b-9b8c7e719c72	832574a1-345a-4c7f-9f76-a2b5f675b63e
2024-02-17 08:02:47.105171+00	2024-02-17 08:02:47.105171+00	f1e4c888-d13c-4924-8c6c-92ea3b790cf0	AC	2022-02-28	Anutek Engineering	94844.00	2	0	Good Vehicle	713b7600-4c05-48fc-86d1-31974c747ce3	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	7965067e-dac3-4b60-ba6b-9b8c7e719c72	b3932082-b474-46f6-be1a-275ed5e263ac
\.


--
-- Data for Name: contributions_attachments; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.contributions_attachments (id, contribution_id, attachment_id) FROM stdin;
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.countries (id, name, code) FROM stdin;
d30001cb-0e7f-4989-a2e0-1705e5e1fe18	India	IN
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2024-01-29 18:26:49.062259+00	b93323c0-3c7e-453f-8e28-8705108b1448	https://onroadcdn.blr1.digitaloceanspaces.com/p/b93323c0-3c7e-453f-8e28-8705108b1448.jpg	1	[{"added": {}}]	13	0bb5a044-bff7-40a1-9d67-73fa28050c26
2	2024-01-30 04:05:42.17109+00	baee03de-c14a-4258-976c-7ff4f90ceb4a	Malik Bagwala	3		12	0bb5a044-bff7-40a1-9d67-73fa28050c26
3	2024-01-30 04:05:42.174717+00	2b683193-95e0-47cf-b985-7aa30fec5709	Malik Bagwala	3		12	0bb5a044-bff7-40a1-9d67-73fa28050c26
4	2024-01-30 04:49:45.477247+00	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b	Kia Sonet HTK Plus 1.2 Petrol MT 2023	1	[{"added": {}}]	18	0bb5a044-bff7-40a1-9d67-73fa28050c26
5	2024-01-30 04:53:14.130054+00	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b	Kia Sonet HTK Plus 1.2 Petrol MT 2023	2	[{"changed": {"fields": ["Specifications"]}}]	18	0bb5a044-bff7-40a1-9d67-73fa28050c26
6	2024-02-02 18:18:51.669205+00	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b	Kia Sonet HTK Plus 1.2 Petrol MT 2023	2	[{"changed": {"fields": ["Short description"]}}]	18	0bb5a044-bff7-40a1-9d67-73fa28050c26
7	2024-02-02 18:19:51.994679+00	af665d7a-3816-4ded-bb8c-57b114588a1a	Hyndai Creta SX (O) 1.5 Diesel AT 2024	2	[{"changed": {"fields": ["Short description"]}}]	18	0bb5a044-bff7-40a1-9d67-73fa28050c26
8	2024-02-02 18:19:58.226658+00	af665d7a-3816-4ded-bb8c-57b114588a1a	Hyndai Creta SX (O) 1.5 Diesel AT 2024	2	[{"changed": {"fields": ["Attachments"]}}]	18	0bb5a044-bff7-40a1-9d67-73fa28050c26
9	2024-02-02 18:20:10.112043+00	c58809b1-b2cb-42bd-9a7e-dea3cfb7f1f7	Abyss Black Pearl	2	[{"changed": {"fields": ["Attachments"]}}]	19	0bb5a044-bff7-40a1-9d67-73fa28050c26
10	2024-02-02 18:20:37.772436+00	c58809b1-b2cb-42bd-9a7e-dea3cfb7f1f7	Abyss Black Pearl	2	[{"changed": {"fields": ["Attachments"]}}]	19	0bb5a044-bff7-40a1-9d67-73fa28050c26
11	2024-02-02 18:52:37.329401+00	4ee01662-ba0b-4ccb-bb4d-b8288e64e5f6	Volkswagen	2	[{"changed": {"fields": ["Code"]}}]	9	0bb5a044-bff7-40a1-9d67-73fa28050c26
12	2024-02-02 18:52:45.927291+00	09365eaa-c764-424d-a5a3-b8a65f859356	Force Motors	2	[{"changed": {"fields": ["Code"]}}]	9	0bb5a044-bff7-40a1-9d67-73fa28050c26
13	2024-02-11 08:28:58.12373+00	cb9e45ba-6de8-40e9-afc3-bb03504fd06f	https://s3.ap-south-1.amazonaws.com/onroad.one/p/cb9e45ba-6de8-40e9-afc3-bb03504fd06f.jpg	1	[{"added": {}}]	13	0bb5a044-bff7-40a1-9d67-73fa28050c26
14	2024-02-11 08:37:15.979423+00	70a0aa0d-18a1-40fe-a24e-b117d6f17a2e	https://s3.ap-south-1.amazonaws.com/onroad.one/p/70a0aa0d-18a1-40fe-a24e-b117d6f17a2e.jpg	1	[{"added": {}}]	13	0bb5a044-bff7-40a1-9d67-73fa28050c26
15	2024-02-11 08:52:33.365552+00	95056f20-c721-4cea-a38b-290b02163be2	https://s3.ap-south-1.amazonaws.com/onroad.one/p/95056f20-c721-4cea-a38b-290b02163be2.webp	1	[{"added": {}}]	13	0bb5a044-bff7-40a1-9d67-73fa28050c26
16	2024-02-11 09:02:55.896564+00	b0e26026-7d2a-4baa-97ca-a6c1ce7fa410	developer.bagwala@gmail.com - 2024-02-11 09:05:57.759316+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
17	2024-02-11 09:02:55.8995+00	62a44dcb-a2c5-46fa-b86c-80335d72e9b5	m.bagwala@gmail.com - 2024-02-11 09:03:32.725199+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
18	2024-02-11 09:02:55.900524+00	aa08ccf0-0d9b-440d-9121-2a33d81a3b19	m.bagwala@gmail.com - 2024-02-10 12:47:18.016785+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
19	2024-02-11 09:02:55.901602+00	16f3bc54-e178-4f72-8ab2-0d4f7bdd8876	m.bagwala@gmail.com - 2024-02-10 12:46:38.433781+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
20	2024-02-11 09:02:55.902512+00	f046f953-cf37-4822-9e86-6146018e4206	m.bagwala@gmail.com - 2024-02-10 12:46:22.458010+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
21	2024-02-11 09:02:55.903402+00	5eeb7e93-44b4-4265-be2d-8da66dedea7b	m.bagwala@gmail.com - 2024-02-10 12:45:34.834601+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
22	2024-02-11 09:02:55.904234+00	1b08738e-27f9-4ebd-aa13-4edd6a4ddb19	m.bagwala@gmail.com - 2024-02-06 16:45:37.808086+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
23	2024-02-11 09:02:55.905251+00	8a80fd8a-62e2-453c-b8e7-fc231b066f82	m.bagwala@gmail.com - 2024-02-06 16:43:45.280697+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
24	2024-02-11 09:02:55.90636+00	d8f0b4b0-e119-4d1a-8f5c-e08507aef60b	m.bagwala@gmail.com - 2024-02-05 17:03:07.048072+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
25	2024-02-11 09:02:55.907347+00	89c47d16-cd37-4890-8b38-8cbfdd742d14	m.bagwala@gmail.com - 2024-02-05 16:59:07.881115+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
26	2024-02-11 09:02:55.908265+00	d28f3cd0-34a7-4e98-ad1f-3bb87607d557	m.bagwala@gmail.com - 2024-02-05 16:57:50.918089+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
27	2024-02-11 09:02:55.909294+00	b0d87462-02dd-493d-8564-b9c1470eb2c6	m.bagwala@gmail.com - 2024-02-04 12:31:58.760556+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
28	2024-02-11 09:02:55.910165+00	5747eacd-c56c-47db-8873-2e05e0a2834e	m.bagwala@gmail.com - 2024-02-04 11:07:12.812899+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
29	2024-02-11 09:02:55.910955+00	cf2067e3-a424-49ee-90bb-b5e252d3268c	developer.bagwala@gmail.com - 2024-02-04 10:02:44.585072+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
30	2024-02-11 09:02:55.911797+00	ba8b7f35-de2c-4573-88e9-125503a66d21	developer.bagwala@gmail.com - 2024-02-04 09:55:12.440445+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
31	2024-02-11 09:02:55.91268+00	8227c504-8e89-471f-bbe1-45f39d989132	m.bagwala@gmail.com - 2024-02-04 09:53:43.364370+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
32	2024-02-11 09:02:55.913441+00	751b49e9-060f-4a73-afad-d8389b91eee5	m.bagwala@gmail.com - 2024-02-04 09:52:16.711208+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
33	2024-02-11 09:02:55.91427+00	e32bf6cd-5b2a-4874-b3cd-fa4ed0a12b62	m.bagwala@gmail.com - 2024-02-04 08:03:21.514165+00:00	3		24	0bb5a044-bff7-40a1-9d67-73fa28050c26
34	2024-02-17 08:01:04.643911+00	d2729b53-8b58-4abf-8f23-356c7a6bb42c	Okinawa Praise Pro 2022/2024-02-14/Nagpur/98000.00	3		14	0bb5a044-bff7-40a1-9d67-73fa28050c26
35	2024-02-17 08:01:04.647053+00	b9ea71e5-ffed-4861-9554-2559c2f52281	Hyndai Creta SX (O) 1.5 Diesel AT 2024/2024-01-30/Nashik/2172022.00	3		14	0bb5a044-bff7-40a1-9d67-73fa28050c26
36	2024-02-17 08:01:04.648897+00	ae6d8318-76ca-4156-9c1c-b94529fc4159	Okinawa Praise Pro 2022/2024-02-04/Nagpur/99706.00	3		14	0bb5a044-bff7-40a1-9d67-73fa28050c26
37	2024-02-17 08:01:04.650338+00	44497c19-15ca-4b72-85d8-494115a18df0	Hyndai Creta SX (O) 1.5 Diesel AT 2024/2024-01-31/Mumbai/2070000.00	3		14	0bb5a044-bff7-40a1-9d67-73fa28050c26
38	2024-02-17 10:14:50.45357+00	93c27b32-6e16-4d12-8c27-c8065aa48c02	https://s3.ap-south-1.amazonaws.com/onroad.one/p/93c27b32-6e16-4d12-8c27-c8065aa48c02.webp	1	[{"added": {}}]	13	0bb5a044-bff7-40a1-9d67-73fa28050c26
39	2024-02-17 10:14:57.619687+00	f91c481c-748a-42f3-9a17-d5e43e5c9443	Aurora Black Pearl	2	[{"changed": {"fields": ["Attachments"]}}]	19	0bb5a044-bff7-40a1-9d67-73fa28050c26
40	2024-02-17 10:17:05.413812+00	7965067e-dac3-4b60-ba6b-9b8c7e719c72	Okinawa Praise Pro 2022	2	[{"changed": {"fields": ["Short description"]}}]	18	0bb5a044-bff7-40a1-9d67-73fa28050c26
41	2024-02-17 10:17:40.023299+00	eee85ab4-29b9-4622-b669-3731193735ca	https://s3.ap-south-1.amazonaws.com/onroad.one/p/eee85ab4-29b9-4622-b669-3731193735ca.webp	1	[{"added": {}}]	13	0bb5a044-bff7-40a1-9d67-73fa28050c26
42	2024-02-17 10:17:41.320074+00	b3932082-b474-46f6-be1a-275ed5e263ac	Glossy Red Black	2	[{"changed": {"fields": ["Attachments"]}}]	19	0bb5a044-bff7-40a1-9d67-73fa28050c26
43	2024-02-18 04:59:23.027097+00	84a4a8dd-d940-4e19-aa9e-21a1ea246afb	hello@maalik.dev	3		12	0bb5a044-bff7-40a1-9d67-73fa28050c26
44	2024-02-18 05:02:34.758731+00	59ad7db2-17e8-43f9-b714-2b9b1bbcddbd	Okinawa Praise Pro 2022/2022-05-07/Nashik/97600.00	3		14	0bb5a044-bff7-40a1-9d67-73fa28050c26
45	2024-02-18 05:02:48.45144+00	47f4cb1b-47e3-407a-9deb-d3d0f1877f78	developer.bagwala@gmail.com	3		12	0bb5a044-bff7-40a1-9d67-73fa28050c26
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	django_dramatiq	task
7	core	city
8	core	country
9	core	make
10	core	priceitem
11	core	vehicletype
12	core	user
13	core	attachment
14	core	contribution
15	core	contributionpriceitem
16	core	refreshtoken
17	core	state
18	core	variant
19	core	variantcolor
20	core	vehicle
21	core	vote
22	core	otp
23	core	passwordchangerequest
24	core	usertoken
25	core	userpasskeys
\.


--
-- Data for Name: django_dramatiq_task; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.django_dramatiq_task (id, status, created_at, updated_at, message_data, actor_name, queue_name) FROM stdin;
972d9b4d-2053-4a5a-b61f-11f47f72b192	done	2024-01-29 18:13:40.586622+00	2024-01-29 18:13:46.141793+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a20452d4d61696c20566572696669636174696f6e222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e456d61696c20566572696669636174696f6e202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e2020202020202e6f7470207b5c6e2020202020202020666f6e742d73697a653a203272656d3b5c6e2020202020202020666f6e742d7765696768743a203730303b5c6e2020202020202020636f6c6f723a20233465323638333b202f2a204465657020507572706c65202a2f5c6e20202020202020206d617267696e3a203230707820303b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020202020746578742d616c69676e3a2063656e7465723b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e456d61696c20566572696669636174696f6e202d204f6e526f61643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e4d616c696b2042616777616c613c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546f20636f6d706c65746520796f757220726567697374726174696f6e2077697468204f6e526f61642c20706c65617365207573652074686520666f6c6c6f77696e675c6e20202020202020206f6e652d74696d652070617373776f726420284f5450293a5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226f74705c223e3435353034343c2f6469763e5c6e5c6e2020202020203c703e5c6e202020202020202054686973204f54502069732076616c696420666f72203c7374726f6e673e35206d696e757465733c2f7374726f6e673e2e20496620796f75206469646e27745c6e202020202020202072657175657374207468697320766572696669636174696f6e2c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e4265737420726567617264732c3c6272202f3e4f6e526f6164205465616d3c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b2268656c6c6f406d61616c696b2e646576225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2239373264396234642d323035332d346135612d623631662d313166343766373262313932222c226d6573736167655f74696d657374616d70223a313730363535323032303537307d	send_email	default
50cec41f-84e1-4861-a526-38381cc45574	done	2024-01-29 18:16:15.13204+00	2024-01-29 18:16:20.097451+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f6164322e6d61616c696b2e6465763f6163636573733d65794a68624763694f694a49557a49314e694973496e523563434936496b705856434a392e65794a70595851694f6a45334d4459314e5449784e7a5573496e4e3159694936496d4a685a5755774d32526c4c574d784e4745744e4449314f4330354e7a5a6a4c54646d5a6a526d4f54426a5a57493059534973496d5634634349364d5463774e6a55314d6a63334e53776964584e6c636c396a6247467062584d694f6e73696543316f59584e31636d4574595778736233646c5a4331796232786c6379493657794a6a62323530636d6c696458527663694973496e567a5a584969585377696543316f59584e31636d457464584e6c636931705a434936496d4a685a5755774d32526c4c574d784e4745744e4449314f4330354e7a5a6a4c54646d5a6a526d4f54426a5a57493059534973496e67746147467a64584a684c57526c5a6d463162485174636d39735a534936496d4e76626e527961574a3164473979496e31392e363647367846526170544d7a51706749434e4765303336565146647468385630556d30764864574c356b7326616d703b726566726573683d36383933343437332d356634632d343463612d393436322d6138613939646630353663335c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b2268656c6c6f406d61616c696b2e646576225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2235306365633431662d383465312d343836312d613532362d333833383163633435353734222c226d6573736167655f74696d657374616d70223a313730363535323137353132397d	send_email	default
2d2dd211-9446-4064-bac7-f224bb45dee2	done	2024-02-24 18:24:35.973092+00	2024-02-24 18:24:42.173859+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d37316231353663342d396666622d346134622d393030312d32363964616266653730306226616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226c6164616e6968656d616c40676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2232643264643231312d393434362d343036342d626163372d663232346262343564656532222c226d6573736167655f74696d657374616d70223a313730383739393037353935377d	send_email	default
fbc6a6d0-5759-416f-80f4-3196a8c200b7	done	2024-02-25 05:37:03.012157+00	2024-02-25 05:37:37.356822+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d37376235396532352d366238392d343866392d383536642d61316333623966663934323026616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2266626336613664302d353735392d343136662d383066342d333139366138633230306237222c226d6573736167655f74696d657374616d70223a313730383833393432323938387d	send_email	default
4af8a18a-43a2-428e-927b-89b7bb06540e	done	2024-01-29 18:20:13.898803+00	2024-01-29 18:20:19.702459+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a2050617373776f72642052657365742052657175657374222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e52657365742050617373776f7264202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d2052657365742050617373776f72643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e4d616c696b2042616777616c613c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f20726573657420796f7572204f6e526f6164206163636f756e742070617373776f72642e20546f5c6e20202020202020207365637572656c7920726573657420796f75722070617373776f72642c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f6164322e6d61616c696b2e6465762f72657365742f63343630616333622d313839312d343362302d393032342d6231663964663938323039343f753d32623638333139332d393565302d343763662d623938352d3761613330666563353730395c223e52657365742050617373776f72643c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f20726573657420796f75722070617373776f7264206f7220646f6e2774206861766520616e204f6e526f61645c6e20202020202020206163636f756e742c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546869732070617373776f7264207265736574206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f722073656375726974795c6e2020202020202020707572706f7365732e5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2234616638613138612d343361322d343238652d393237622d383962376262303635343065222c226d6573736167655f74696d657374616d70223a313730363535323431333838397d	send_email	default
6848d912-6663-4b32-9a2d-05e9a085046a	done	2024-01-29 18:23:01.917693+00	2024-01-29 18:23:07.389385+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a2050617373776f72642052657365742052657175657374222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e52657365742050617373776f7264202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d2052657365742050617373776f72643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e4d616c696b2042616777616c613c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f20726573657420796f7572204f6e526f6164206163636f756e742070617373776f72642e20546f5c6e20202020202020207365637572656c7920726573657420796f75722070617373776f72642c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f6164322e6d61616c696b2e6465762f72657365742f63343630616333622d313839312d343362302d393032342d6231663964663938323039343f753d32623638333139332d393565302d343763662d623938352d3761613330666563353730395c223e52657365742050617373776f72643c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f20726573657420796f75722070617373776f7264206f7220646f6e2774206861766520616e204f6e526f61645c6e20202020202020206163636f756e742c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546869732070617373776f7264207265736574206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f722073656375726974795c6e2020202020202020707572706f7365732e5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2236383438643931322d363636332d346233322d396132642d303565396130383530343661222c226d6573736167655f74696d657374616d70223a313730363535323538313930337d	send_email	default
e577941e-8b0e-4360-be5a-b70a68a717ce	done	2024-03-01 12:48:01.031107+00	2024-03-01 12:48:07.225091+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d38353262663262632d623832332d343561362d616539632d66653266313961373632313726616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2265353737393431652d386230652d343336302d626535612d623730613638613731376365222c226d6573736167655f74696d657374616d70223a313730393239373238303531357d	send_email	default
7a82adf7-7a7d-41bf-91f3-a8548dbdd4de	done	2024-01-30 04:10:47.43572+00	2024-01-30 04:10:52.589887+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a20452d4d61696c20566572696669636174696f6e222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e456d61696c20566572696669636174696f6e202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e2020202020202e6f7470207b5c6e2020202020202020666f6e742d73697a653a203272656d3b5c6e2020202020202020666f6e742d7765696768743a203730303b5c6e2020202020202020636f6c6f723a20233465323638333b202f2a204465657020507572706c65202a2f5c6e20202020202020206d617267696e3a203230707820303b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020202020746578742d616c69676e3a2063656e7465723b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e456d61696c20566572696669636174696f6e202d204f6e526f61643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e4d616c696b2042616777616c613c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546f20636f6d706c65746520796f757220726567697374726174696f6e2077697468204f6e526f61642c20706c65617365207573652074686520666f6c6c6f77696e675c6e20202020202020206f6e652d74696d652070617373776f726420284f5450293a5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226f74705c223e3339383932303c2f6469763e5c6e5c6e2020202020203c703e5c6e202020202020202054686973204f54502069732076616c696420666f72203c7374726f6e673e35206d696e757465733c2f7374726f6e673e2e20496620796f75206469646e27745c6e202020202020202072657175657374207468697320766572696669636174696f6e2c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e4265737420726567617264732c3c6272202f3e4f6e526f6164205465616d3c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2237613832616466372d376137642d343162662d393166332d613835343864626464346465222c226d6573736167655f74696d657374616d70223a313730363538373834373432347d	send_email	default
d051fb4d-a76c-4da6-9e73-96154ca4813f	done	2024-01-30 04:21:03.955878+00	2024-01-30 04:21:09.146136+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a20452d4d61696c20566572696669636174696f6e222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e456d61696c20566572696669636174696f6e202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e2020202020202e6f7470207b5c6e2020202020202020666f6e742d73697a653a203272656d3b5c6e2020202020202020666f6e742d7765696768743a203730303b5c6e2020202020202020636f6c6f723a20233465323638333b202f2a204465657020507572706c65202a2f5c6e20202020202020206d617267696e3a203230707820303b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020202020746578742d616c69676e3a2063656e7465723b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e456d61696c20566572696669636174696f6e202d204f6e526f61643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e486974657368203c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546f20636f6d706c65746520796f757220726567697374726174696f6e2077697468204f6e526f61642c20706c65617365207573652074686520666f6c6c6f77696e675c6e20202020202020206f6e652d74696d652070617373776f726420284f5450293a5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226f74705c223e3032353132343c2f6469763e5c6e5c6e2020202020203c703e5c6e202020202020202054686973204f54502069732076616c696420666f72203c7374726f6e673e35206d696e757465733c2f7374726f6e673e2e20496620796f75206469646e27745c6e202020202020202072657175657374207468697320766572696669636174696f6e2c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e4265737420726567617264732c3c6272202f3e4f6e526f6164205465616d3c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b227368696d70696869746573683240676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2264303531666234642d613736632d346461362d396537332d393631353463613438313366222c226d6573736167655f74696d657374616d70223a313730363538383436333933377d	send_email	default
cb08d53c-0e8d-4c80-a0d8-9abed29db2f0	done	2024-01-31 08:05:21.412922+00	2024-01-31 08:05:26.537253+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a20452d4d61696c20566572696669636174696f6e222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e456d61696c20566572696669636174696f6e202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e2020202020202e6f7470207b5c6e2020202020202020666f6e742d73697a653a203272656d3b5c6e2020202020202020666f6e742d7765696768743a203730303b5c6e2020202020202020636f6c6f723a20233465323638333b202f2a204465657020507572706c65202a2f5c6e20202020202020206d617267696e3a203230707820303b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020202020746578742d616c69676e3a2063656e7465723b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e456d61696c20566572696669636174696f6e202d204f6e526f61643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e41736875746f73682050616e67617668616e653c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546f20636f6d706c65746520796f757220726567697374726174696f6e2077697468204f6e526f61642c20706c65617365207573652074686520666f6c6c6f77696e675c6e20202020202020206f6e652d74696d652070617373776f726420284f5450293a5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226f74705c223e3139333530303c2f6469763e5c6e5c6e2020202020203c703e5c6e202020202020202054686973204f54502069732076616c696420666f72203c7374726f6e673e35206d696e757465733c2f7374726f6e673e2e20496620796f75206469646e27745c6e202020202020202072657175657374207468697320766572696669636174696f6e2c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e4265737420726567617264732c3c6272202f3e4f6e526f6164205465616d3c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b2261736875746f73682e76657361746f676f40676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2263623038643533632d306538642d346338302d613064382d396162656432396462326630222c226d6573736167655f74696d657374616d70223a313730363638383332313430317d	send_email	default
e6a2f117-dd56-41b1-a909-226b4a7df8ee	done	2024-03-10 06:14:39.155677+00	2024-03-10 06:14:43.957474+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a2050617373776f72642052657365742052657175657374222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e52657365742050617373776f7264202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d2052657365742050617373776f72643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e6d2e62616777616c6140676d61696c2e636f6d3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f20726573657420796f7572204f6e526f6164206163636f756e742070617373776f72642e20546f5c6e20202020202020207365637572656c7920726573657420796f75722070617373776f72642c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e652f72657365742f636666623632393535663231306331363134353735363035656437623636326532333833366535613762343130346534313538616533343830643430383162343f753d30333064333461302d366263332d346565642d613662342d3037653166663931393061365c223e52657365742050617373776f72643c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f20726573657420796f75722070617373776f7264206f7220646f6e2774206861766520616e204f6e526f61645c6e20202020202020206163636f756e742c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546869732070617373776f7264207265736574206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f722073656375726974795c6e2020202020202020707572706f7365732e5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2265366132663131372d646435362d343162312d613930392d323236623461376466386565222c226d6573736167655f74696d657374616d70223a313731303035313237393134307d	send_email	default
1f4d784e-1032-472b-a4d8-a06ecb590c6b	done	2024-01-31 14:55:57.745783+00	2024-01-31 14:56:04.017219+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a2050617373776f72642052657365742052657175657374222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e52657365742050617373776f7264202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d2052657365742050617373776f72643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e4d616c696b2042616777616c613c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f20726573657420796f7572204f6e526f6164206163636f756e742070617373776f72642e20546f5c6e20202020202020207365637572656c7920726573657420796f75722070617373776f72642c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e652f72657365742f33633166636662612d353030652d343664302d393134652d3134326433653738376232643f753d30333064333461302d366263332d346565642d613662342d3037653166663931393061365c223e52657365742050617373776f72643c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f20726573657420796f75722070617373776f7264206f7220646f6e2774206861766520616e204f6e526f61645c6e20202020202020206163636f756e742c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546869732070617373776f7264207265736574206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f722073656375726974795c6e2020202020202020707572706f7365732e5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2231663464373834652d313033322d343732622d613464382d613036656362353930633662222c226d6573736167655f74696d657374616d70223a313730363731323935373733327d	send_email	default
ddbd1347-9067-49b1-8c46-e98723c6e39f	done	2024-01-31 14:57:27.109972+00	2024-01-31 14:57:33.770489+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f6163636573733d65794a68624763694f694a49557a49314e694973496e523563434936496b705856434a392e65794a70595851694f6a45334d4459334d544d774e446373496e4e3159694936496a417a4d47517a4e4745774c545a69597a4d744e47566c5a4331684e6d49304c5441335a54466d5a6a6b784f5442684e694973496d5634634349364d5463774e6a63784d7a59304e79776964584e6c636c396a6247467062584d694f6e73696543316f59584e31636d4574595778736233646c5a4331796232786c6379493657794a6a62323530636d6c696458527663694973496e567a5a584969585377696543316f59584e31636d457464584e6c636931705a434936496a417a4d47517a4e4745774c545a69597a4d744e47566c5a4331684e6d49304c5441335a54466d5a6a6b784f5442684e694973496e67746147467a64584a684c57526c5a6d463162485174636d39735a534936496d4e76626e527961574a3164473979496e31392e6c5044434d464c524e4f474a4d424d6442684f4c704450316a31563550456555703852536156623645754926616d703b726566726573683d39393762353561652d653438612d343864312d396561372d6662313962353762323238625c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2264646264313334372d393036372d343962312d386334362d653938373233633665333966222c226d6573736167655f74696d657374616d70223a313730363731333034373039387d	send_email	default
95219505-c09e-40c7-9e73-ab54e2828488	done	2024-03-11 05:22:03.03856+00	2024-03-11 05:22:08.447424+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d31396631343433612d636261342d343638652d383137342d64396135613432623034323026616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2239353231393530352d633039652d343063372d396537332d616235346532383238343838222c226d6573736167655f74696d657374616d70223a313731303133343532333032317d	send_email	default
e5d5b72a-f9ff-4ad2-a8c1-99ee90116b6c	done	2024-01-31 14:58:01.305831+00	2024-01-31 14:58:06.491719+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a2050617373776f72642052657365742052657175657374222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e52657365742050617373776f7264202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d2052657365742050617373776f72643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e4d616c696b2042616777616c613c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f20726573657420796f7572204f6e526f6164206163636f756e742070617373776f72642e20546f5c6e20202020202020207365637572656c7920726573657420796f75722070617373776f72642c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e652f72657365742f33633166636662612d353030652d343664302d393134652d3134326433653738376232643f753d30333064333461302d366263332d346565642d613662342d3037653166663931393061365c223e52657365742050617373776f72643c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f20726573657420796f75722070617373776f7264206f7220646f6e2774206861766520616e204f6e526f61645c6e20202020202020206163636f756e742c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546869732070617373776f7264207265736574206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f722073656375726974795c6e2020202020202020707572706f7365732e5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2265356435623732612d663966662d346164322d613863312d393965653930313136623663222c226d6573736167655f74696d657374616d70223a313730363731333038313239357d	send_email	default
9dc4d37f-7457-411c-a863-66a6141aef1d	done	2024-01-31 16:37:39.941371+00	2024-01-31 16:37:45.860707+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a2050617373776f72642052657365742052657175657374222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e52657365742050617373776f7264202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d2052657365742050617373776f72643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e4d616c696b2042616777616c613c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f20726573657420796f7572204f6e526f6164206163636f756e742070617373776f72642e20546f5c6e20202020202020207365637572656c7920726573657420796f75722070617373776f72642c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e652f72657365742f66303466313066302d333932632d346264372d613131612d3139343966643865663633643f753d30333064333461302d366263332d346565642d613662342d3037653166663931393061365c223e52657365742050617373776f72643c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f20726573657420796f75722070617373776f7264206f7220646f6e2774206861766520616e204f6e526f61645c6e20202020202020206163636f756e742c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546869732070617373776f7264207265736574206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f722073656375726974795c6e2020202020202020707572706f7365732e5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2239646334643337662d373435372d343131632d613836332d363661363134316165663164222c226d6573736167655f74696d657374616d70223a313730363731393035393933317d	send_email	default
f46c8e6c-3bd2-4ddf-b375-b8035c095716	done	2024-03-15 12:23:55.339361+00	2024-03-15 12:24:00.143338+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d39626662303266392d346532652d343635642d396333622d30336665613237393238323426616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2266343663386536632d336264322d346464662d623337352d623830333563303935373136222c226d6573736167655f74696d657374616d70223a313731303530353433343838317d	send_email	default
9510b50d-1c04-4583-90e8-f72c6a2efb41	done	2024-02-02 19:11:16.942883+00	2024-02-02 19:11:22.460972+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f6163636573733d65794a68624763694f694a49557a49314e694973496e523563434936496b705856434a392e65794a70595851694f6a45334d4459354d4445774e7a5973496e4e3159694936496a417a4d47517a4e4745774c545a69597a4d744e47566c5a4331684e6d49304c5441335a54466d5a6a6b784f5442684e694973496d5634634349364d5463774e6a6b774d5459334e69776964584e6c636c396a6247467062584d694f6e73696543316f59584e31636d4574595778736233646c5a4331796232786c6379493657794a6a62323530636d6c696458527663694973496e567a5a584969585377696543316f59584e31636d457464584e6c636931705a434936496a417a4d47517a4e4745774c545a69597a4d744e47566c5a4331684e6d49304c5441335a54466d5a6a6b784f5442684e694973496e67746147467a64584a684c57526c5a6d463162485174636d39735a534936496d4e76626e527961574a3164473979496e31392e467574754e4b5f4452315767693854446c4f505f465865686d4876783870355262594d4b6231376333456326616d703b726566726573683d34616533363634382d366462322d343164622d383236302d6564666263643534353336385c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2239353130623530642d316330342d343538332d393065382d663732633661326566623431222c226d6573736167655f74696d657374616d70223a313730363930313037363933317d	send_email	default
c3b516e7-03fa-4ca2-bf6d-beeefe21cd3a	done	2024-02-02 19:12:33.893265+00	2024-02-02 19:12:38.634988+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a2050617373776f72642052657365742052657175657374222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e52657365742050617373776f7264202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d2052657365742050617373776f72643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e4d616c696b2042616777616c613c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f20726573657420796f7572204f6e526f6164206163636f756e742070617373776f72642e20546f5c6e20202020202020207365637572656c7920726573657420796f75722070617373776f72642c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e652f72657365742f31333264316336312d356635382d346563662d383839312d6336306663356330333863613f753d30333064333461302d366263332d346565642d613662342d3037653166663931393061365c223e52657365742050617373776f72643c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f20726573657420796f75722070617373776f7264206f7220646f6e2774206861766520616e204f6e526f61645c6e20202020202020206163636f756e742c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546869732070617373776f7264207265736574206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f722073656375726974795c6e2020202020202020707572706f7365732e5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2263336235313665372d303366612d346361322d626636642d626565656665323163643361222c226d6573736167655f74696d657374616d70223a313730363930313135333838387d	send_email	default
0727c61d-ba50-4bc7-8912-c434b0b7e4a4	done	2024-02-02 19:21:31.429163+00	2024-02-02 19:21:36.189941+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a2050617373776f72642052657365742052657175657374222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e52657365742050617373776f7264202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d2052657365742050617373776f72643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e4d616c696b2042616777616c613c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f20726573657420796f7572204f6e526f6164206163636f756e742070617373776f72642e20546f5c6e20202020202020207365637572656c7920726573657420796f75722070617373776f72642c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e652f72657365742f33653830393664662d363762662d343362382d396265652d3034316332653165663865323f753d66663964356461392d656562662d343836352d393534392d3239323136396161353339335c223e52657365742050617373776f72643c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f20726573657420796f75722070617373776f7264206f7220646f6e2774206861766520616e204f6e526f61645c6e20202020202020206163636f756e742c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546869732070617373776f7264207265736574206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f722073656375726974795c6e2020202020202020707572706f7365732e5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d616c696b2e76657361746f676f40676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2230373237633631642d626135302d346263372d383931322d633433346230623765346134222c226d6573736167655f74696d657374616d70223a313730363930313639313431317d	send_email	default
0bdafbc8-f163-4ec7-a0dd-061e80b467b7	done	2024-03-20 05:08:41.813567+00	2024-03-20 05:08:46.404252+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d66333634633164332d303931612d343964322d393138302d30666566393834343966663726616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2230626461666263382d663136332d346563372d613064642d303631653830623436376237222c226d6573736167655f74696d657374616d70223a313731303931313332313738377d	send_email	default
1e0614ae-701a-4f28-a011-5e7a2ab8f207	done	2024-02-04 05:25:58.758116+00	2024-02-04 05:26:03.480805+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f6163636573733d65794a68624763694f694a49557a49314e694973496e523563434936496b705856434a392e65794a70595851694f6a45334d4463774d6a517a4e546773496e4e3159694936496a417a4d47517a4e4745774c545a69597a4d744e47566c5a4331684e6d49304c5441335a54466d5a6a6b784f5442684e694973496d5634634349364d5463774e7a41794e446b314f43776964584e6c636c396a6247467062584d694f6e73696543316f59584e31636d4574595778736233646c5a4331796232786c6379493657794a6a62323530636d6c696458527663694973496e567a5a584969585377696543316f59584e31636d457464584e6c636931705a434936496a417a4d47517a4e4745774c545a69597a4d744e47566c5a4331684e6d49304c5441335a54466d5a6a6b784f5442684e694973496e67746147467a64584a684c57526c5a6d463162485174636d39735a534936496d4e76626e527961574a3164473979496e31392e7a365a35645a6a74467375367233645869526c5a4f30706d50332d4f6e394859534e365443314d5561303826616d703b726566726573683d33383461386235632d396261652d343832362d613364642d6639343039633337653963665c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2231653036313461652d373031612d346632382d613031312d356537613261623866323037222c226d6573736167655f74696d657374616d70223a313730373032343335383734337d	send_email	default
d4969ff3-a467-412f-8397-0fbfcf8d735a	done	2024-02-04 05:27:04.880861+00	2024-02-04 05:27:10.843091+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f6163636573733d65794a68624763694f694a49557a49314e694973496e523563434936496b705856434a392e65794a70595851694f6a45334d4463774d6a51304d6a5173496e4e3159694936496a417a4d47517a4e4745774c545a69597a4d744e47566c5a4331684e6d49304c5441335a54466d5a6a6b784f5442684e694973496d5634634349364d5463774e7a41794e5441794e43776964584e6c636c396a6247467062584d694f6e73696543316f59584e31636d4574595778736233646c5a4331796232786c6379493657794a6a62323530636d6c696458527663694973496e567a5a584969585377696543316f59584e31636d457464584e6c636931705a434936496a417a4d47517a4e4745774c545a69597a4d744e47566c5a4331684e6d49304c5441335a54466d5a6a6b784f5442684e694973496e67746147467a64584a684c57526c5a6d463162485174636d39735a534936496d4e76626e527961574a3164473979496e31392e4477644164333262657672454756726b415a7630786a505773746132435a5f6e736e4f6d3739423544675526616d703b726566726573683d33383461386235632d396261652d343832362d613364642d6639343039633337653963665c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2264343936396666332d613436372d343132662d383339372d306662666366386437333561222c226d6573736167655f74696d657374616d70223a313730373032343432343836387d	send_email	default
176095d9-dfbc-4c70-a532-f0278a3b70f7	done	2024-02-04 09:48:43.405038+00	2024-02-04 09:48:48.634512+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a2050617373776f72642052657365742052657175657374222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e52657365742050617373776f7264202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d2052657365742050617373776f72643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e4d616c696b2042616777616c613c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f20726573657420796f7572204f6e526f6164206163636f756e742070617373776f72642e20546f5c6e20202020202020207365637572656c7920726573657420796f75722070617373776f72642c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e652f72657365742f656665353639333439613834363161356361373366633130636232383361646337313638643261313537343633393266326364346638396435336163326131363f753d30333064333461302d366263332d346565642d613662342d3037653166663931393061365c223e52657365742050617373776f72643c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f20726573657420796f75722070617373776f7264206f7220646f6e2774206861766520616e204f6e526f61645c6e20202020202020206163636f756e742c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546869732070617373776f7264207265736574206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f722073656375726974795c6e2020202020202020707572706f7365732e5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2231373630393564392d646662632d346337302d613533322d663032373861336237306637222c226d6573736167655f74696d657374616d70223a313730373034303132333338357d	send_email	default
b2775e49-bfeb-4e2c-becb-e1dc5333e716	done	2024-02-04 09:57:44.609047+00	2024-02-04 09:57:49.617964+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a2050617373776f72642052657365742052657175657374222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e52657365742050617373776f7264202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d2052657365742050617373776f72643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e646576656c6f7065722e62616777616c6140676d61696c2e636f6d3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f20726573657420796f7572204f6e526f6164206163636f756e742070617373776f72642e20546f5c6e20202020202020207365637572656c7920726573657420796f75722070617373776f72642c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e652f72657365742f383534636665333164356638326464616466383735623235336232343335623434313964343764306461633833313265393531643433316265303063376130333f753d34376634636231622d343765332d343037612d396465622d6433643066313837376637385c223e52657365742050617373776f72643c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f20726573657420796f75722070617373776f7264206f7220646f6e2774206861766520616e204f6e526f61645c6e20202020202020206163636f756e742c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546869732070617373776f7264207265736574206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f722073656375726974795c6e2020202020202020707572706f7365732e5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b22646576656c6f7065722e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2262323737356534392d626665622d346532632d626563622d653164633533333365373136222c226d6573736167655f74696d657374616d70223a313730373034303636343539307d	send_email	default
15005fa1-fc29-4ebc-9185-9c18ff5c261e	done	2024-03-23 09:41:13.604827+00	2024-03-23 09:47:32.096019+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d63386331653739372d356663352d343961612d623065632d66353361316235353137653426616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b2274726163656261636b223a2254726163656261636b20286d6f737420726563656e742063616c6c206c617374293a5c6e202046696c65205c222f7573722f6c6f63616c2f6c69622f707974686f6e332e31322f736974652d7061636b616765732f6472616d617469712f776f726b65722e70795c222c206c696e65203438352c20696e2070726f636573735f6d6573736167655c6e20202020726573203d206163746f72282a6d6573736167652e617267732c202a2a6d6573736167652e6b7761726773295c6e202020202020202020205e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5c6e202046696c65205c222f7573722f6c6f63616c2f6c69622f707974686f6e332e31322f736974652d7061636b616765732f6472616d617469712f6163746f722e70795c222c206c696e65203138322c20696e205f5f63616c6c5f5f5c6e2020202072657475726e2073656c662e666e282a617267732c202a2a6b7761726773295c6e20202020202020202020205e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5c6e202046696c65205c222f6170702f636f72652f7461736b732f73656e645f656d61696c2e70795c222c206c696e652031362c20696e2073656e645f656d61696c5c6e20202020656d61696c2e73656e6428295c6e202046696c65205c222f7573722f6c6f63616c2f6c69622f707974686f6e332e31322f736974652d7061636b616765732f646a616e676f2f636f72652f6d61696c2f6d6573736167652e70795c222c206c696e65203330302c20696e2073656e645c6e2020202072657475726e2073656c662e6765745f636f6e6e656374696f6e286661696c5f73696c656e746c79292e73656e645f6d65737361676573285b73656c665d295c6e20202020202020202020205e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5c6e202046696c65205c222f7573722f6c6f63616c2f6c69622f707974686f6e332e31322f736974652d7061636b616765732f646a616e676f2f636f72652f6d61696c2f6261636b656e64732f736d74702e70795c222c206c696e65203133362c20696e2073656e645f6d657373616765735c6e2020202073656e74203d2073656c662e5f73656e64286d657373616765295c6e20202020202020202020205e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5e5c6e202046696c65205c222f7573722f6c6f63616c2f6c69622f707974686f6e332e31322f736974652d7061636b616765732f646a616e676f2f636f72652f6d61696c2f6261636b656e64732f736d74702e70795c222c206c696e65203135352c20696e205f73656e645c6e2020202073656c662e636f6e6e656374696f6e2e73656e646d61696c285c6e202046696c65205c222f7573722f6c6f63616c2f6c69622f707974686f6e332e31322f736d74706c69622e70795c222c206c696e65203837362c20696e2073656e646d61696c5c6e20202020726169736520534d545053656e6465725265667573656428636f64652c20726573702c2066726f6d5f61646472295c6e736d74706c69622e534d545053656e646572526566757365643a20283535302c206227352e372e302046726f6d2061646472657373206973206e6f74206f6e65206f6620796f757220616464726573736573272c20274f6e726f6164203c737570706f7274406d61616c696b2e6465763e27295c6e222c2272657472696573223a357d2c226d6573736167655f6964223a2231353030356661312d666332392d346562632d393138352d396331386666356332363165222c226d6573736167655f74696d657374616d70223a313731313138363837333232387d	send_email	default
1758fb9b-5862-4bb8-90e1-b616a57efd2d	done	2024-02-04 11:29:50.464867+00	2024-02-04 11:29:55.763586+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a20452d4d61696c20566572696669636174696f6e222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e456d61696c20566572696669636174696f6e202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e2020202020202e6f7470207b5c6e2020202020202020666f6e742d73697a653a203272656d3b5c6e2020202020202020666f6e742d7765696768743a203730303b5c6e2020202020202020636f6c6f723a20233465323638333b202f2a204465657020507572706c65202a2f5c6e20202020202020206d617267696e3a203230707820303b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020202020746578742d616c69676e3a2063656e7465723b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e456d61696c20566572696669636174696f6e202d204f6e526f61643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e68656c6c6f406d61616c696b2e6465763c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546f20636f6d706c65746520796f757220726567697374726174696f6e2077697468204f6e526f61642c20706c65617365207573652074686520666f6c6c6f77696e675c6e20202020202020206f6e652d74696d652070617373776f726420284f5450293a5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226f74705c223e3538383532313c2f6469763e5c6e5c6e2020202020203c703e5c6e202020202020202054686973204f54502069732076616c696420666f72203c7374726f6e673e35206d696e757465733c2f7374726f6e673e2e20496620796f75206469646e27745c6e202020202020202072657175657374207468697320766572696669636174696f6e2c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e4265737420726567617264732c3c6272202f3e4f6e526f6164205465616d3c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b2268656c6c6f406d61616c696b2e646576225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2231373538666239622d353836322d346262382d393065312d623631366135376566643264222c226d6573736167655f74696d657374616d70223a313730373034363139303435337d	send_email	default
63f17dff-4a10-4c54-8ef0-3ec146a37711	done	2024-03-23 09:48:23.638448+00	2024-03-23 09:48:28.694282+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d64376530396466362d376464302d343666392d393836342d38303230623132623337633726616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b22646576656c6f7065722e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2236336631376466662d346131302d346335342d386566302d336563313436613337373131222c226d6573736167655f74696d657374616d70223a313731313138373330333631377d	send_email	default
3efd0304-f6f1-4c91-9f51-52e1ad0466e6	done	2024-02-05 16:54:07.91554+00	2024-02-05 16:54:13.524766+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d61323466616533372d303439362d346538632d626366372d37336664646531386136613226616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2233656664303330342d663666312d346339312d396635312d353265316164303436366536222c226d6573736167655f74696d657374616d70223a313730373135323034373930327d	send_email	default
344ab1dc-3aeb-4174-a83d-89c13d70f4d4	done	2024-02-05 16:58:07.062528+00	2024-02-05 16:58:11.46712+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a2050617373776f72642052657365742052657175657374222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e52657365742050617373776f7264202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d2052657365742050617373776f72643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e6d2e62616777616c6140676d61696c2e636f6d3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f20726573657420796f7572204f6e526f6164206163636f756e742070617373776f72642e20546f5c6e20202020202020207365637572656c7920726573657420796f75722070617373776f72642c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e652f72657365742f626665373062373765663136643361393238353162303236623934333561383534643838616635353766306464336231303630353836313436656461346131643f753d30333064333461302d366263332d346565642d613662342d3037653166663931393061365c223e52657365742050617373776f72643c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f20726573657420796f75722070617373776f7264206f7220646f6e2774206861766520616e204f6e526f61645c6e20202020202020206163636f756e742c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546869732070617373776f7264207265736574206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f722073656375726974795c6e2020202020202020707572706f7365732e5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2233343461623164632d336165622d343137342d613833642d383963313364373066346434222c226d6573736167655f74696d657374616d70223a313730373135323238373035337d	send_email	default
d0b23365-5609-41da-b713-b4189c36ec5b	done	2024-03-26 11:47:24.109524+00	2024-03-26 11:47:29.636044+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d33333130373664342d623535382d346563322d386433352d37363836356339326235383126616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2264306232333336352d353630392d343164612d623731332d623431383963333665633562222c226d6573736167655f74696d657374616d70223a313731313435333634343037387d	send_email	default
ca3ebf80-9a80-448f-bb98-8c07c35028e8	done	2024-02-06 16:40:37.845178+00	2024-02-06 16:40:44.026907+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d66356264316664622d646331312d343435302d393736342d32343231393430356262356326616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2263613365626638302d396138302d343438662d626239382d386330376333353032386538222c226d6573736167655f74696d657374616d70223a313730373233373633373832387d	send_email	default
07625df4-1c37-46af-9c1a-bec2fbe2ebde	done	2024-02-10 12:41:38.474928+00	2024-02-10 12:41:42.692485+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d34353534386633302d306663372d346461352d613739612d35323538613866363562653426616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2230373632356466342d316333372d343661662d396331612d626563326662653265626465222c226d6573736167655f74696d657374616d70223a313730373536383839383435357d	send_email	default
b25a20ae-123a-4a9e-b128-489d7c4d0d3c	done	2024-02-10 12:42:18.046856+00	2024-02-10 12:42:22.43979+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b224f6e526f61643a2050617373776f72642052657365742052657175657374222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e52657365742050617373776f7264202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d2052657365742050617373776f72643c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e6d2e62616777616c6140676d61696c2e636f6d3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f20726573657420796f7572204f6e526f6164206163636f756e742070617373776f72642e20546f5c6e20202020202020207365637572656c7920726573657420796f75722070617373776f72642c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e652f72657365742f363634336430616565303838366237343433616666386430303537633438333236316537393864376336656437623031643130343561303632376539666233383f753d30333064333461302d366263332d346565642d613662342d3037653166663931393061365c223e52657365742050617373776f72643c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f20726573657420796f75722070617373776f7264206f7220646f6e2774206861766520616e204f6e526f61645c6e20202020202020206163636f756e742c20706c656173652069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020546869732070617373776f7264207265736574206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f722073656375726974795c6e2020202020202020707572706f7365732e5c6e2020202020203c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2262323561323061652d313233612d346139652d623132382d343839643763346430643363222c226d6573736167655f74696d657374616d70223a313730373536383933383033347d	send_email	default
9f9c74cb-da6a-4cfc-b5b4-39a7915b8ed4	done	2024-02-11 08:58:32.769357+00	2024-02-11 08:58:38.287176+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d38393734623933632d396166322d346335322d613434622d63643636616633383431333926616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2239663963373463622d646136612d346366632d623562342d333961373931356238656434222c226d6573736167655f74696d657374616d70223a313730373634313931323735307d	send_email	default
e6ab5895-d15b-4afa-a048-1682f0bded8d	done	2024-02-20 13:06:08.4768+00	2024-02-20 13:06:13.130888+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d63343266383838302d343138662d343639322d623163662d35393536323733313762643326616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2265366162353839352d643135622d346166612d613034382d313638326630626465643864222c226d6573736167655f74696d657374616d70223a313730383433343336383436337d	send_email	default
9b987a40-a393-47b6-b1e2-1cf7b102a588	done	2024-02-24 18:19:38.804865+00	2024-02-24 18:19:46.090601+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d31666439643763352d633830352d343866322d393065662d35386133376237626466353226616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b2268656d616c6c4077696e6a69742e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2239623938376134302d613339332d343762362d623165322d316366376231303261353838222c226d6573736167655f74696d657374616d70223a313730383739383737383738397d	send_email	default
573a96b2-d5e6-45d7-ba0a-ad0542a966e8	done	2024-03-28 09:03:44.735436+00	2024-03-28 09:03:49.38345+00	\\x7b2271756575655f6e616d65223a2264656661756c74222c226163746f725f6e616d65223a2273656e645f656d61696c222c2261726773223a5b225369676e20696e20746f204f6e526f6164222c223c21444f43545950452068746d6c3e5c6e3c68746d6c206c616e673d5c22656e5c223e5c6e20203c686561643e5c6e202020203c6d65746120636861727365743d5c225554462d385c22202f3e5c6e202020203c6d65746120687474702d65717569763d5c22582d55412d436f6d70617469626c655c2220636f6e74656e743d5c2249453d656467655c22202f3e5c6e202020203c6d657461206e616d653d5c2276696577706f72745c2220636f6e74656e743d5c2277696474683d6465766963652d77696474682c20696e697469616c2d7363616c653d312e305c22202f3e5c6e202020203c7469746c653e5369676e20496e2077697468204d61676963204c696e6b202d204f6e526f61643c2f7469746c653e5c6e202020203c6c696e6b5c6e20202020202072656c3d5c227374796c6573686565745c225c6e202020202020687265663d5c2268747470733a2f2f666f6e74732e676f6f676c65617069732e636f6d2f637373323f66616d696c793d527562696b3a77676874403330303b3430303b3530303b37303026646973706c61793d737761705c225c6e202020202f3e5c6e202020203c7374796c653e5c6e2020202020202e636f6e7461696e6572207b5c6e20202020202020206d61782d77696474683a2036303070783b5c6e20202020202020206d617267696e3a2030206175746f3b5c6e202020202020202070616464696e673a20323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666663b5c6e2020202020202020626f726465722d7261646975733a20313070783b5c6e2020202020207d5c6e5c6e2020202020206832207b5c6e2020202020202020636f6c6f723a20233333333b5c6e2020202020207d5c6e5c6e20202020202070207b5c6e2020202020202020636f6c6f723a20233535353b5c6e2020202020207d5c6e5c6e2020202020207374726f6e67207b5c6e2020202020202020636f6c6f723a20233131313b5c6e2020202020207d5c6e5c6e20202020202061207b5c6e2020202020202020646973706c61793a20696e6c696e652d626c6f636b3b5c6e202020202020202070616464696e673a203130707820323070783b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233666343263313b202f2a204465657020507572706c65202a2f5c6e2020202020202020636f6c6f723a20236666662021696d706f7274616e743b5c6e2020202020202020746578742d6465636f726174696f6e3a206e6f6e653b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020207472616e736974696f6e3a206261636b67726f756e642d636f6c6f7220302e33733b5c6e2020202020207d5c6e5c6e202020202020613a686f766572207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20233561326439313b202f2a204461726b6572207368616465206f6e20686f766572202a2f5c6e2020202020207d5c6e5c6e2020202020202e6e6f7465207b5c6e20202020202020206261636b67726f756e642d636f6c6f723a20236666653538663b202f2a20536f667465722059656c6c6f77202a2f5c6e2020202020202020636f6c6f723a20233535353b202f2a204461726b6572205465787420436f6c6f72202a2f5c6e202020202020202070616464696e673a20313070783b5c6e2020202020202020626f726465722d7261646975733a203570783b5c6e20202020202020206d617267696e2d746f703a20323070783b5c6e2020202020207d5c6e202020203c2f7374796c653e5c6e20203c2f686561643e5c6e20203c626f64795c6e202020207374796c653d5c225c6e202020202020666f6e742d66616d696c793a20527562696b2c20417269616c2c2073616e732d73657269663b5c6e2020202020206261636b67726f756e642d636f6c6f723a20236630663166333b5c6e2020202020206d617267696e3a20303b5c6e20202020202070616464696e673a20322e3572656d20303b5c6e202020205c225c6e20203e5c6e202020203c64697620636c6173733d5c22636f6e7461696e65725c223e5c6e2020202020203c68323e4f6e526f6164202d205369676e20496e2077697468204d61676963204c696e6b3c2f68323e5c6e5c6e2020202020203c703e48656c6c6f203c7374726f6e673e3c2f7374726f6e673e2c3c2f703e5c6e5c6e2020202020203c703e5c6e202020202020202057652776652072656365697665642061207265717565737420746f207369676e20696e20746f20796f7572204f6e526f6164206163636f756e742e20546f207365637572656c795c6e20202020202020207369676e20696e2c20636c69636b20746865206c696e6b2062656c6f773a5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e3c6120687265663d5c2268747470733a2f2f6f6e726f61642e6f6e653f636f64653d33323435376338362d363135612d346534612d623131352d64316237626664363436313926616d703b747970653d56435c223e5369676e20496e2077697468204d61676963204c696e6b3c2f613e3c2f703e5c6e5c6e2020202020203c703e5c6e2020202020202020496620796f75206469646e2774207265717565737420746f207369676e20696e206f7220646f6e2774206861766520616e204f6e526f6164206163636f756e742c20706c656173655c6e202020202020202069676e6f7265207468697320656d61696c2e5c6e2020202020203c2f703e5c6e5c6e2020202020203c703e54686973206d61676963206c696e6b2069732076616c696420666f722061206c696d697465642074696d6520666f7220736563757269747920707572706f7365732e3c2f703e5c6e5c6e2020202020203c64697620636c6173733d5c226e6f74655c223e5c6e20202020202020203c7374726f6e673e4e6f74653a3c2f7374726f6e673e20446f206e6f742073686172652074686973206c696e6b207769746820616e796f6e6520666f7220796f75725c6e202020202020202073656375726974792e5c6e2020202020203c2f6469763e5c6e5c6e2020202020203c703e5c6e20202020202020204265737420726567617264732c3c6272202f3e5c6e20202020202020204f6e526f6164205465616d5c6e2020202020203c2f703e5c6e202020203c2f6469763e5c6e20203c2f626f64793e5c6e3c2f68746d6c3e5c6e222c5b226d2e62616777616c6140676d61696c2e636f6d225d5d2c226b7761726773223a7b7d2c226f7074696f6e73223a7b7d2c226d6573736167655f6964223a2235373361393662322d643565362d343564372d626130612d616430353432613936366538222c226d6573736167655f74696d657374616d70223a313731313631363632343730397d	send_email	default
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2024-01-29 17:42:31.967604+00
2	contenttypes	0002_remove_content_type_name	2024-01-29 17:42:31.973468+00
3	auth	0001_initial	2024-01-29 17:42:32.011322+00
4	auth	0002_alter_permission_name_max_length	2024-01-29 17:42:32.016463+00
5	auth	0003_alter_user_email_max_length	2024-01-29 17:42:32.026048+00
6	auth	0004_alter_user_username_opts	2024-01-29 17:42:32.032206+00
7	auth	0005_alter_user_last_login_null	2024-01-29 17:42:32.042078+00
8	auth	0006_require_contenttypes_0002	2024-01-29 17:42:32.043726+00
9	auth	0007_alter_validators_add_error_messages	2024-01-29 17:42:32.049256+00
10	auth	0008_alter_user_username_max_length	2024-01-29 17:42:32.055104+00
11	auth	0009_alter_user_last_name_max_length	2024-01-29 17:42:32.066851+00
12	auth	0010_alter_group_name_max_length	2024-01-29 17:42:32.079176+00
13	auth	0011_update_proxy_permissions	2024-01-29 17:42:32.088391+00
14	auth	0012_alter_user_first_name_max_length	2024-01-29 17:42:32.100413+00
15	core	0001_initial	2024-01-29 17:42:33.128728+00
16	admin	0001_initial	2024-01-29 17:42:33.197613+00
17	admin	0002_logentry_remove_auto_add	2024-01-29 17:42:33.232978+00
18	admin	0003_logentry_add_action_flag_choices	2024-01-29 17:42:33.254058+00
19	core	0002_alter_contribution_status	2024-01-29 17:42:33.314284+00
20	core	0003_alter_contribution_status_alter_contribution_total	2024-01-29 17:42:33.384506+00
21	core	0004_alter_contribution_downvotes_and_more	2024-01-29 17:42:33.884882+00
22	core	0005_priceitem_serial_no_alter_variant_specifications	2024-01-29 17:42:33.893977+00
23	core	0006_alter_vote_user	2024-01-29 17:42:33.948936+00
24	core	0007_alter_user_email_alter_user_username	2024-01-29 17:42:34.020771+00
25	core	0008_alter_user_email	2024-01-29 17:42:34.052572+00
26	core	0009_rename_file_attachment_url_attachment_etag_and_more	2024-01-29 17:42:34.268566+00
27	core	0010_alter_attachment_options_attachment_created_at_and_more	2024-01-29 17:42:34.342822+00
28	core	0011_alter_attachment_url	2024-01-29 17:42:34.376162+00
29	core	0012_alter_attachment_created_by_and_more	2024-01-29 17:42:34.488509+00
30	django_dramatiq	0001_initial	2024-01-29 17:42:34.499607+00
31	django_dramatiq	0002_auto_20191104_1354	2024-01-29 17:42:34.518173+00
32	django_dramatiq	0003_auto_20200204_0842	2024-01-29 17:42:34.523769+00
33	sessions	0001_initial	2024-01-29 17:42:34.550541+00
34	core	0013_variant_short_description_alter_city_code_and_more	2024-02-01 17:32:42.23001+00
35	core	0014_variant_slug_alter_variant_name	2024-02-02 18:06:55.192728+00
36	core	0015_alter_variant_slug	2024-02-02 18:15:25.160238+00
37	core	0016_make_code_vehicletype_code	2024-02-02 18:43:17.753326+00
38	core	0017_alter_make_code_alter_vehicletype_code	2024-02-02 18:43:17.762339+00
39	core	0018_alter_make_code_alter_vehicletype_code	2024-02-02 18:54:40.826739+00
40	core	0019_usertoken	2024-02-04 07:38:22.289127+00
41	core	0020_usertoken_client	2024-02-04 07:38:22.316329+00
42	core	0021_alter_usertoken_options_usertoken_description	2024-02-04 07:38:22.357642+00
43	core	0022_delete_otp	2024-02-04 09:46:18.334922+00
44	core	0023_delete_passwordchangerequest	2024-02-04 09:46:18.341829+00
45	core	0024_alter_contribution_downvotes_and_more	2024-02-14 16:41:15.22416+00
46	core	0025_alter_userpasskeys_credential_id	2024-02-14 16:41:15.261614+00
47	core	0026_alter_userpasskeys_sign_count	2024-02-14 16:41:15.291022+00
48	core	0027_alter_userpasskeys_credential_id_and_more	2024-02-14 16:41:15.364739+00
49	core	0028_delete_refreshtoken	2024-02-14 16:41:15.369976+00
50	core	0029_remove_userpasskeys_sign_count_userpasskeys_name_and_more	2024-02-14 16:41:15.446205+00
51	core	0030_alter_userpasskeys_options	2024-02-14 16:41:15.469021+00
52	core	0031_alter_contribution_status	2024-03-10 07:53:35.66619+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
7yggr9mg94lfxxh4ogjp9ymxjaghsczz	.eJwtzkkOgjAYQOG7dC2mlMHWlUCiEYcEMQ4r8gNl0Ba0lSAx3l1jPMDL917oBlpf-YCmL5RVIARvSo6mCPLJsNgEZXj3-yaSNA1i3SypXh42ft1jyzmvV2mgQgaJ7w5Hz8uPCveCbi-PneycYs7me85V7AbPPtoK5ZWnLo7QCHWaq6TOvwTOmEMI5YY9yalhF8AMAFwYQFzMTIsT0yz-QQPyNzV0uoKqVgpagi08KyXUYpy1Er3fH68fQfA:1riDtF:Wi8tEL8EOs7R7DOFdxYJwD2jRtcgkOSzUP0MXT71yyg	2024-03-21 13:34:29.657791+00
y550djdm15em0vrfqj38el2skq5txq69	.eJxVjrkOwjAQRP_FNbbW8fqiTM83RLs-SAAlUo4K8e8kUgooR_PeaN6io23tu20pczdkcRXAbAkQJdfqJQJpGbPz0ptKTQALqXHi8qsxpWcZDzc_aLxPKk3jOg-sDkSd7aJuUy6v9mT_Bnpa-t1Ga71xDEZz0JT3G8Gm4JANFiLINgTPxsTSZB0r6egKR28BXay8B_H5ArsDQIg:1rUWCO:dXky4c-OeiXCKX5aloJVdxiuGwdLQ0_ARwJDgEFwRpI	2024-02-12 18:17:36.051016+00
39xq0tmqxggu4xj56xaig15ruicwutn9	e30:1riDvV:G87GKK50JiXeRBCkblnLFfnoXN01Lee0WdUNsRScDss	2024-03-21 13:36:49.033834+00
7k0m3s2btgciplz50fynd0kgy4bffbhz	eyJhdXRoX2NoYWxsZW5nZSI6IjNqdFlIT1FQemNPUEI5RzgyTXR3VjZHTExZaXFndG9KSXJ2RUFnOGVFeWN0TVRSWmdabHdyVENUWkVRNlVRbjl5QkM5aVVLby0tREVGNldIRElxOTdBIn0:1raX31:Xk-7mEj0PbJqafxUbN6wC2BmILwD49qAbV7fFpGRHjY	2024-02-29 08:24:47.21567+00
hdfqsiz4hb4wu52gbhkkswdr8gy02e49	e30:1raX3Y:mzjZJDZPu1gPgG4xn6J_zhco0iiRxj8u5EDG9FKqFrQ	2024-02-29 08:25:20.782967+00
ajx3zr2wzw5ex3q9mezlhgjteazcsjb0	.eJxNzttugjAAgOF36fVq6sBivZpi5ikih-LhirRQAW2xA7Ey47tvJrvYA_z5_gdg7bVI0oJJKapcgBG4be7TwuR7raqmNVFU4J2yff5-GOsFdXBQx9OKaI0niannCE6y076Gjkd9GDSRcQa3-jCv9De8lfok_XUQu-G-GIM3oFnTnEUHRg_w39tAsp0Ol9SELT9YUeopSy-WlBNvyy-GYqXcVUmHs_Drs9w553op1-4aJ_2uw0Sga3JJWZyJrRtQ0s4COWgTGK5eXtuIOimzXwJZKLNshiDmqQVtITLIMLchckT_eCR9ghj-CyqmXlOqx1lumGQfuWKl7KUXBZ7PHzB4Y04:1rasvw:0D3ir-9mqpnP_rUqK7tgJlIbU8oo_0xikwF-dMTZzTE	2024-03-01 07:46:56.956033+00
f9ue9bn19wivadb5z4kp297zzqzgw2po	eyJhdXRoX2NoYWxsZW5nZSI6IjV2S3hrUVhjSzVxdmpMcURrODVuSjJDTE1BUzhFa1ZTa0hGa0g0UlJ1WjZ3ejdZNzVQQWpQZUlZbEgxMzhvMmdSR254QVVFUEZ2RWFtY2lTWFRaX25RIn0:1rbFT2:6hd6v-HRu8X7PLzYwQTP1Z1M2vUPDgzOoz9SC7HTohw	2024-03-02 07:50:36.365543+00
me0u4x9wdpytvxz10h4mzyidp5ch8qah	.eJxVjjsOwyAQBe9CHdCC1yykTJ8zWCywcT6yJX-qKHePLblI6jczem_VpXXpu3WuU3cv6qyAuU2AqFmENEKyOhZPmhpJLkAL2Xl1-tU45Wcddrc80nAbTR6HZbqz2RFzrLO5jqW-Lgf7F-jT3G92EJdQmmJ9YLYkMVgC60vgHKPH4BCzEJYqFQFw-yG1BQKi6gqIqM8XxoRAuw:1rZRvR:9CvcOxW01opjDd_H4I59pSqBfFMnQKCAhmAv4n91ej0	2024-02-26 08:44:29.154157+00
swtvllkea91659qxxasi4ge0dgsuiew0	eyJhdXRoX2NoYWxsZW5nZSI6InUtWjhfNThwckJmNjVWNWEyTEF0X2piOXpZMnE2MEk2Q2hPZzFQQ0VGNkhSSlhzek9CWVRONU9FbGRua1ZVck9SUHBvc1ItVmg5X2tFdnAwVFBqQnFnIn0:1rdNuV:Jrd1rLrT9d9hZ8ENo6DS9NK8SucdaQlwGbqrEoU5soY	2024-03-08 05:15:47.117706+00
qdh9qtt4w5sexmmjgcqrry4n7jtaxmqf	.eJxNzktzgjAYheH_knXpNASQuBJplUHKxUvBbpiPkAoqlBIgo47_vTjTRc_-zPPeEPRdkbICzmdeHziaoonkg_--1pxA2kGdHucLSZdbTIzCGD69pddyYtVZyGv7w7U3cRxFSmsKfyvUg2gig75W3eBHrgeSHVd2077EA-ki9IQaEOLEL2h6Q_-9hU6GjXIllrEDuZvYrD_5PqsKaDWasc7CziW_Jl_uUNF95MR7cx0IQ5W60LZvvm4lwmtyOl_hRJ07bhamdvjjXR5eL3iblvlIYAyMAzAlN0BTNJPoSpZRoqigYxiXY6r_HWqoHlEFr8bCmSzrY9k9s-8K3e-_aNdiGg:1rdwYV:IirnHFCdLbqtooKsCAmXgOsmseJjuwzB4OB8UCKVm5U	2024-03-09 18:15:23.983843+00
dlb09i3axskj7rkliy7w7cn85zxufcg7	e30:1rdwZV:fSkfhscCr52u0su7aYhRJP7wI89rq9yzcv-xASEX-AY	2024-03-09 18:16:25.618246+00
4tb2scf7ydgjwmak1vt9cghm43pc3w6h	eyJhdXRoX2NoYWxsZW5nZSI6InlLMnhCd25ZY2tpeDVaVkg2NmgyOTZ3ZWwycnMtRFJ1d0JiaDI0Q3lnZmtWbVNfSnZBaVB0QXVpbk9pMjhTYWtKNjkzVDFwbFdRSXU2alV4Vi1YR1F3In0:1rdwbM:as7OfhgxRo_1InXllF_KqflS0aRrwqVx48_v38TIFw4	2024-03-09 18:18:20.005913+00
10jtsq6mk006lmy1721pfugvhl5jut50	.eJxVzDsOwjAQRdG9uCaWP-OxTUnPGqKZjE0CKJHyqRB7h0gpoH73vJdqaVv7dlvK3A6izsowBzIADdcaGzBkmywYm-gruWSC6Ryq0y9j6h5l3K3cabxNupvGdR5Y74k-1kVfJynPy9H-HfS09F_tEJ0AYSoMuYA3YJk8YM7IoXhCco4RYojZ2hQ4VZeyUE4xigOx6v0Bqpw_zg:1rpWbq:baVOedzntK96WjcwjFwlHVXxiqbob-7o_oW_TS26uD4	2024-04-10 16:58:42.794867+00
cbr09delggavo9ynopzuobuxd3jxo32e	.eJxVzMFOg0AUheF3Ye2QYS4w4K5gTU0KNLHU6IbcO8wAdQIJUBM1vrtguqjrc_7v26nwMrfVZdJj1dXOvcOJAuS-z8gYyXyOHovrUDIJBkXEA65E6NzdZoTqXfdrW5-xbwZXDf08duSuF_e6Tm421Nom1-8_oMWpXWoVgAg0CQJQMXlhrEkjD7QwQnqeF0UCIkm-qiMKUSIoZTwAiKXPJS7Bgv6ZqkVrdd_o1TQ7BJblbyaHj_1Zp8qmxctB7vbHR1HYWTGiMYGDSp5a6E6xX5fV9qHLos-mtENzSrfHflOMz8lkG16y_HUsvuzG-fkFz8ljjw:1rplf6:yvup_KzfmRdLacftRxFtD2SVhCvsZpwPecqzVXTQeKk	2024-04-11 09:03:04.568883+00
01rp41dc4xqhdfcavjhuodoi2x77r5bm	eyJhdXRoX2NoYWxsZW5nZSI6IlhNelQxM1N6RHk2dEJfTC03N0hfLXRHYnpfR2Q3RkVIMm4zUGsxdHpJVUkyQUFHQU1vSmM4OVE3d3phNHA0M3NSWWRqMGdmSDI5NXc3RzFaM3hEMU5nIn0:1s4wG3:Ay2_BWyJywAvXvWLMprGNoboRZgovdeksPSzMaT84OY	2024-05-23 05:23:55.516303+00
\.


--
-- Data for Name: makes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.makes (id, name, estb_year, code) FROM stdin;
65586920-747c-4e98-bdf3-eb0571cfd101	Maruti Suzuki	1981	MAR
208e6363-d7b2-4ccf-91f7-9f3b661da4a9	Hyundai	1967	HYU
610ffb65-7b92-4604-acda-3b49598c0736	Tata Motors	1945	TAT
146a47ba-5812-4854-afa2-fcd2d7255fce	Mahindra & Mahindra	1945	MAH
1f5bee5a-043d-453b-8b57-05c419cd561c	Honda	1948	HON
d73da496-f35b-4cc0-9318-633406cddb42	Toyota	1937	TOY
6e7ff323-e59e-405d-8968-4a0ac6473b37	Ford	1903	FOR
f6022c9d-ac1c-44f5-9e07-867b80a3cadc	Kia	1944	KIA
d04bc353-c5d5-45a4-b679-88784447e932	Renault	1899	REN
dc84b41d-c43d-4f8c-85d4-5599b476a2de	Nissan	1933	NIS
b919b7f5-af01-403e-8613-fe998f96e902	Skoda	1895	SKO
7e774d85-9350-4399-a3df-c5f8b5508f25	Mercedes-Benz	1926	MER
34e55ce5-6e05-462d-846e-bcd8bb8913c5	BMW	1916	BMW
2e99bd5a-f3e6-4373-ab88-2a0cf47f2c17	Audi	1910	AUD
d2aae664-e280-44da-98a0-03214d62a6a9	Volvo	1927	VOL
4f9d9964-84a1-4a00-9e8f-0fafba4fe9b4	Jaguar	1922	JAG
f6fe441a-823d-429f-a549-d1120f865d8a	Land Rover	1948	LAN
72347e22-3d29-4616-9f24-c7200bf1d7c8	Jeep	1941	JEE
11cd6871-d9a0-4632-a45a-b2f27455719c	Fiat	1899	FIA
d0763beb-6cac-45ae-b21c-e3b12d64bb70	Okinawa	2015	OKI
091671c2-6d80-4ba7-9d27-3cdbe24be1e8	MG Motor	1924	MGM
4ee01662-ba0b-4ccb-bb4d-b8288e64e5f6	Volkswagen	1937	VLK
09365eaa-c764-424d-a5a3-b8a65f859356	Force Motors	1958	FRC
\.


--
-- Data for Name: price_items; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.price_items (created_at, updated_at, id, name, description, category, type, serial_no) FROM stdin;
2024-01-20 03:45:34.446+00	2024-01-27 11:34:38.407158+00	bee9b5c2-6e97-494d-9cd9-140380c78c16	Road Tax		MI	DB	2
2024-01-20 03:45:34.446+00	2024-01-27 11:34:50.922177+00	9edf5329-d563-49ae-b1b7-f18e6bfbc15d	Insurance		IN	DB	3
2024-01-20 03:45:34.446+00	2024-01-27 11:35:04.044296+00	60ea232c-467d-451c-ba35-c7b5b4e438da	RTO		RTO	DB	4
2024-01-20 03:45:34.446+00	2024-01-27 11:35:10.443852+00	8ae525cc-9b34-42a5-b33b-c8cd2caba1f1	Accessories		OA	DB	5
2024-01-27 11:31:20.22877+00	2024-01-27 11:35:28.970601+00	60aabb24-f95d-47eb-9b5b-fa53794415ab	Misc		MI	DB	6
2024-01-20 03:45:34.442+00	2024-01-27 11:36:29.088628+00	d4b67ec9-c2c9-4f6b-964e-f03e389c8c2f	Ex-Showroom	Ex showroom price inclusive of taxes	EX	DB	1
2024-01-28 05:08:53.266016+00	2024-01-28 05:08:53.266037+00	7a6e79cf-563c-4808-bd21-c13ce2e82827	Extended Warranty		EW	DB	10
2024-01-20 03:45:34.446+00	2024-01-28 05:10:37.051107+00	a94cde51-511e-414b-8c2b-afb4e1cc9a40	FAME II Subsidy		SU	CR	25
2024-01-20 03:45:34.446+00	2024-01-28 05:10:45.518018+00	523ade17-98eb-43f8-8040-608b60324f4b	State Subsidy		SU	CR	26
2024-01-20 03:45:34.446+00	2024-01-28 05:10:49.931888+00	a832dd83-3ec5-47ed-946a-06d7905a07cd	Discount		DI	CR	27
2024-01-28 05:11:17.773322+00	2024-01-28 05:11:17.773334+00	e9e36ee7-c32b-481a-8cd3-c248a57cc3bd	Fast Tag		FT	DB	11
2024-01-28 05:11:52.198374+00	2024-01-28 05:11:52.198383+00	640df0bf-f2d5-4c37-b464-7aab07382f53	Basic Kit		OA	DB	12
2024-01-28 05:12:04.03497+00	2024-01-28 05:12:04.034981+00	0081a02a-0a43-49c1-9ed2-8ac55c25f1fc	Local Taxes		LBT	DB	13
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.states (id, name, code, country_id) FROM stdin;
9d282558-9e18-4c41-a0a7-08116e012a81	Andaman and Nicobar Islands	AN	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
d0a039df-6e75-4597-9f80-fa3a055b0bee	Andhra Pradesh	AP	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
2edcbd08-3238-4873-9bbd-55c79cdc71f3	Arunachal Pradesh	AR	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
694a90d0-c9a5-4835-95df-e9498c78c360	Assam	AS	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
aaeb6b5f-0633-47b5-9100-e9024700ece0	Bihar	BR	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
d306bac9-5e52-4af9-9c71-dec993c2baba	Chandigarh	CG	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
ea160870-ab8b-4cae-a772-0a80b566470f	Chhattisgarh	CH	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
ddcae2d2-c10e-451a-a418-744c4f447653	Dadra and Nagar Haveli	DH	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
86df600d-f67a-4b2a-8238-75b9880f9423	Daman and Diu	DD	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
d6b39040-4721-4313-aa69-733bf78b0214	Delhi	DL	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
3f7d7055-8b25-4f89-9765-0cd37dd0a99c	Goa	GA	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
e1721c20-ab9c-44ca-a4f8-5cab6cc36ad6	Gujarat	GJ	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
1cb5bf87-e09b-4605-86bb-f11df93794b6	Haryana	HR	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
616becf7-866b-4cb6-aa57-0afa29cac4f4	Himachal Pradesh	HP	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
8889d547-3ba6-469e-bcf6-4329aede50b1	Jammu and Kashmir	JK	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
6c763981-576b-450b-8db6-778b1c243803	Jharkhand	JH	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
cccb653d-fb71-4cc1-bfd3-f0737de22ae3	Karnataka	KA	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
f8911f17-19b1-46d9-b708-a727912638c8	Kerala	KL	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
7d06e07f-73e2-4fbb-9ee8-2ffa9570eeda	Lakshadweep	LD	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
7b7382f9-b9dc-42b4-8a2d-264a731fe7cb	Madhya Pradesh	MP	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
afa1a4c7-c742-4deb-ba10-79d131bf2a10	Maharashtra	MH	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
d7c7eee9-db08-4e00-a306-55790fbb52b5	Manipur	MN	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
e0173d54-80cd-48c0-9c92-61853ebef7b9	Meghalaya	ML	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
d0a2b263-0189-4e7b-9422-74d3e3915294	Mizoram	MZ	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
1e973ad2-b99d-4bc8-b688-8e9c8d84acdf	Nagaland	NL	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
57eb2330-c405-46f3-a60a-0622d0086b77	Odisha	OR	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
fdc8eeae-14e2-45bb-b91c-88f586bde4eb	Puducherry	PY	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
82ebab7f-eeaf-4a1d-9d1d-31780a997ced	Punjab	PB	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
7b0ea670-6161-44cf-85e4-98e2d2f37975	Rajasthan	RJ	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
983e6bf6-bb24-40f1-a07f-0d846b8d9bae	Sikkim	SK	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
99c94553-c81e-4dfb-98b1-377247c307bb	Tamil Nadu	TN	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
b65398bc-aa42-475d-bc07-a6730719da86	Telangana	TS	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
1d8e1820-480f-4c27-a44f-198d7063010f	Tripura	TR	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
ee5968f1-81d8-40b2-982e-4b4c5d5205bc	Uttarakhand	UK	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
d72eae33-d05a-4350-aebf-08cef4fbf34d	Uttar Pradesh	UP	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
4d66d7f3-42f7-4fb7-945b-5093e9902b93	West Bengal	WB	d30001cb-0e7f-4989-a2e0-1705e5e1fe18
\.


--
-- Data for Name: user_passkeys; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_passkeys (created_at, updated_at, id, public_key, credential_id, description, user_id, name) FROM stdin;
2024-02-14 16:49:24.120657+00	2024-02-14 16:49:24.120677+00	b70f0933-803d-41f5-86a5-ab414f4049b5	\\xa50102032620012158201669a15d33dd9ec3d592d496bb61b06a97b237d820ff957b51a628030a43718722582093bfa4ede88c3c33e9bba6b67e32cf24d61a700ba55b9cf259d71745a814f7a3	\\x01ccce5ab5b8e59ee7fe4c602a5c63bd0a7ec088eb734adf274bcb84c5c6667c317cb0545e9d41ee0aa8addb71ac7112209b851817c50a0b40861bc7c2e64d431d	faridaqaid@gmail.com	9db134d5-bc29-411e-898c-2331bb99ab08	\N
2024-02-15 03:01:21.851147+00	2024-02-15 03:01:21.851166+00	c42a67db-f63d-411f-9dc1-784b93bd4dbe	\\xa5010203262001215820904d9a4cdd62e673a25a8ab2c8c515aa3f574495c7698da2688a4d2b1561a0b8225820cd2ebf9feca688799875b6d1c63ac048c470341fdabe68f314a20357c4f03e58	\\xeca38d55c028cbc55574f546673331976aac99e6	m.bagwala@gmail.com	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	\N
2024-02-15 08:24:25.537222+00	2024-02-15 08:24:25.537253+00	d456584f-ef1f-4437-bfe5-73f4f8ec9d0b	\\xa50102032620012158203df81fccac5f1185c66bb6f9e6ce4b00a88413ed5f31f3c168a1c83eb5f726b4225820657e7a2c925eff01735aa617c2bdc25d6c62bcd2ffecf953cc24ecd1cb916b45	\\x010426fcab6f3cc1b0337ad415f8d264703bb732650111a747dac3ce46f01146baffbc9dc5f1148800b03b79eae3c92cb109bbcf79f31d85b84a8d6c1591a6f4c5	shimpihitesh2@gmail.com	479c457f-d99e-40d4-b5e7-38ecb8b271b4	\N
2024-02-23 05:15:34.350439+00	2024-02-23 05:15:34.350461+00	c5286ebd-59a0-4fd4-963f-c1c0ed20ac65	\\xa5010203262001215820383e3d22bbb86d5a6dad44149127bfc7ab4a1de37fd37f5881336230ba8aff71225820ba6957115279fdcb08c8be5dcd2b582e9734341d51d98a1239953f7a80f604b1	\\x01453a7920c5e6aec8f44c22d5bc04728a6e7669dc1e067f23c10ca892c11dbba6a2eb8ebe6abbe49217b326cef98f39374dd98469d2a2930d0dfd8724ee61e490	faridaqaid@gmail.com	9db134d5-bc29-411e-898c-2331bb99ab08	\N
2024-02-24 18:16:11.040277+00	2024-02-24 18:16:11.040295+00	0adcfd06-1cf3-487f-86a8-2137d53ae890	\\xa5010203262001215820cb7210256605a287b439327f0c3adfea157428034aa093791ce31b24134e186c2258208516dccb24751086c6722e20c6c3747a5bb33dcdf954656c2817eaf97ea0c8af	\\x280adac9c62b5c042218469dcc807705f3236aa31bfd0ff725bbc96694d07d0a	hemall@winjit.com	11aceaac-d6a4-4835-bb93-2a51aaaad195	\N
2024-02-24 18:17:55.931074+00	2024-02-24 18:17:55.931096+00	634a8098-fd86-4b6a-ab4e-9bcf2327cfa5	\\xa50102032620012158203261991275fc1774cbb72459a8c2f83f5e91663c36a098b93b04603777959dbb225820071c84396acbbb6aa752a53b217f2d40912aa2d5eeea5d6b9d58ded4268076e6	\\x01a661cf2262f88f45e06c8c919f4bec3cc082b2d060a93091be1d1fb74ddd4ac7cb1cf15553b1c510b7c659879fc56de9c061fb78a72c2661d376705de824a27e	hemall@winjit.com	11aceaac-d6a4-4835-bb93-2a51aaaad195	\N
2024-03-07 13:36:36.063727+00	2024-03-07 13:36:36.063748+00	ce831dc5-a825-4f6d-8607-d6ef5a23afda	\\xa5010203262001215820ae7e5455cbe4455b6540ce43ed1facde563e406d02c4a6687ce9f1c3c30aec71225820fa8939c3aa1da19b903509d54f4acbe6ba85702a57f7b7a3c3062e826144e879	\\xb7871ace523d3bb2b98688c7d6d2d14954a441913540628fcbde35fd370d337f	ayushahirrao2030@gmail.com	0c95228e-47d8-4fa9-aa0f-a260913e211f	\N
\.


--
-- Data for Name: user_tokens; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_tokens (created_at, updated_at, id, token, used, expires_at, type, user_id, client, description) FROM stdin;
2024-02-15 03:01:01.82156+00	2024-02-15 03:01:02.142658+00	a6bc5c80-2dd7-4daf-a712-91bda9aee059	8c24e6b2-d6a9-45fa-b621-2cafea480257	t	2024-02-15 03:06:01.817809+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-15 08:25:21.901994+00	2024-02-15 08:25:21.902008+00	21bec161-3d7a-4718-a0d4-2dcf3846c7e4	541aec9d-8f16-4d01-b28b-ee2ecd3118f4	f	2024-02-22 08:25:21.899239+00	RF	479c457f-d99e-40d4-b5e7-38ecb8b271b4	web	\N
2024-02-16 04:57:47.096166+00	2024-02-16 04:57:47.265513+00	2724b5fc-6530-4a8b-bd0c-6f4205f4d602	5d7e5233-2c77-47f0-b7d5-c8a710f38cce	t	2024-02-16 05:02:47.094347+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-16 07:46:29.32066+00	2024-02-16 07:46:29.538939+00	acaff1ef-6317-4f58-a72d-965fc22e3c06	f9760614-2d82-468d-80c3-a243e7a4260e	t	2024-02-16 07:51:29.318365+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-17 05:26:28.688424+00	2024-02-17 05:26:28.937441+00	1da8fe42-817d-4c32-b8a9-5be3cce93603	75f30385-2c78-4cc6-8b08-de0c9be035bf	t	2024-02-17 05:31:28.68601+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-17 07:31:02.988228+00	2024-02-17 07:31:03.331967+00	f5c4e3f3-bfc4-43ff-8d88-db5cc3d279b6	5c8d9d04-f44d-47a5-9af9-a9d7f791ee46	t	2024-02-17 07:36:02.984998+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-17 08:19:06.561424+00	2024-02-17 08:19:07.430179+00	8878d2ac-4991-4641-ae5b-58581fca77b1	1aeaf897-7a78-47c9-809f-83b51279844c	t	2024-02-17 08:24:06.55874+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-17 08:19:29.626904+00	2024-02-17 08:19:36.235705+00	ecadf5c5-3306-40d5-a490-02b4d3fc4b4d	c9375d2a-b2a8-4e4d-a79d-1d114d8d3493	t	2024-02-17 08:24:29.624906+00	VC	ff9d5da9-eebf-4865-9549-292169aa5393	web	\N
2024-02-17 08:20:54.154144+00	2024-02-17 08:20:54.414434+00	d008f325-4276-45ea-b3b1-66538a885b95	e3af7193-cbc7-4c2d-bc53-df6803382307	t	2024-02-17 08:25:54.150342+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-23 09:41:13.225157+00	2024-03-23 09:41:13.225168+00	55396a63-f389-4461-bd5c-37a6a27f872f	c8c1e797-5fc5-49aa-b0ec-f53a1b5517e4	f	2024-03-23 09:46:13.223107+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-17 08:35:10.526503+00	2024-02-17 08:35:11.088485+00	ef9a35a1-ec95-425d-8af8-47b1abf7834b	91206089-f6fe-4e5a-a4ae-d109b777c331	t	2024-02-17 08:40:10.524855+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-18 03:38:46.944361+00	2024-02-18 03:38:47.190677+00	e02ccc33-f778-464b-8131-7dcb63df5fb2	7ae85680-f19c-42e2-8871-25f8ca3b301d	t	2024-02-18 03:43:46.942498+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-18 04:56:13.014893+00	2024-02-18 04:56:13.292305+00	cdeb65c9-b4ba-4a16-8c45-abdcce34790a	526c2b0a-b9a0-478c-a392-cfd2d83171cf	t	2024-02-18 05:01:13.01277+00	VC	ff9d5da9-eebf-4865-9549-292169aa5393	web	\N
2024-02-08 20:34:56.769149+00	2024-02-08 20:34:56.769162+00	0d774136-d125-42d0-a135-2d5c19c595d4	4545ec85-da20-4cde-b754-96e0895038fd	f	2024-02-08 20:39:56.766666+00	VC	046ba5a0-39a3-4a1b-a805-6c822c8df4c3	web	\N
2024-02-18 04:56:56.744437+00	2024-02-18 04:56:57.229893+00	608dd519-c6c4-485a-952a-b74d860bb556	05c25d39-b65b-4017-9fb6-8697f80d935d	t	2024-02-18 05:01:56.742751+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-24 18:15:51.892745+00	2024-02-24 18:15:52.131246+00	89476493-7eb4-4125-8ca9-af60394f6fa3	80f04cc5-e7c3-40fa-a90e-2e9b4f734267	t	2024-02-24 18:20:51.890263+00	VC	11aceaac-d6a4-4835-bb93-2a51aaaad195	web	\N
2024-02-18 05:05:09.051163+00	2024-02-18 05:05:09.381805+00	b6fc3df7-7fb0-427a-88c2-c5b5508bd620	ddcb4f66-7ad4-40a5-b54b-f5d1afe4d4ed	t	2024-02-18 05:10:09.048769+00	VC	fef1f4f4-96d4-473e-bbec-e077c396089c	web	\N
2024-02-19 02:46:42.562076+00	2024-02-19 02:46:42.771985+00	b2324f84-026a-4729-8564-7364e0aa657c	3b85e806-d28e-4c4b-8b38-45826fe06838	t	2024-02-19 02:51:42.560662+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-14 16:42:21.871085+00	2024-02-14 16:42:22.170485+00	2eb5a0e1-7453-4564-8871-42bd4ad97e73	f01d3434-3ab0-4bc4-8ecf-2e0f432207d7	t	2024-02-14 16:47:21.867365+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-20 13:06:08.459365+00	2024-02-20 13:06:24.957816+00	334a3066-23fb-4a63-a5e5-052502ef764e	c42f8880-418f-4692-b1cf-595627317bd3	t	2024-02-20 13:11:08.456488+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-14 16:43:31.245766+00	2024-02-14 16:43:31.541973+00	e4a04076-314f-4caa-b9c6-eb14a27e94ae	6a3b9a3e-8ccc-42f6-b005-f055c94882ba	t	2024-02-14 16:48:31.242512+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-21 11:14:05.344199+00	2024-02-21 11:14:05.54714+00	b31a9bcb-9828-48a3-bad5-fe7bcd81d2a4	4ee0f06a-bd9f-4b38-afc7-82e9012866eb	t	2024-02-21 11:19:05.34169+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-14 16:48:30.082319+00	2024-02-14 16:48:30.737745+00	f6cfcfa7-1cc9-4a6c-915e-873b7ffddd08	f79160e3-3c40-469f-a172-a4468e25739b	t	2024-02-14 16:53:30.080385+00	VC	9db134d5-bc29-411e-898c-2331bb99ab08	web	\N
2024-02-23 05:13:00.961866+00	2024-02-23 05:13:01.859156+00	889c05c0-bca6-4acf-8a72-2a44030ae3ce	f352ab8f-04c0-49e0-b6ce-7ebc0fba2bcb	t	2024-02-23 05:18:00.958859+00	VC	9db134d5-bc29-411e-898c-2331bb99ab08	web	\N
2024-02-14 17:27:15.860004+00	2024-02-14 17:27:16.155925+00	c0d688c6-0f78-40f6-8e64-e523c3ae078a	6b58fe22-f5d2-4c74-bb1e-83af157c30e3	t	2024-02-14 17:32:15.857538+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-23 07:27:10.694636+00	2024-02-23 07:27:10.931188+00	63b02915-863a-476f-a7d5-301deacd329e	2dfd8c6e-6891-4757-9dc7-16ee48e1b56e	t	2024-02-23 07:32:10.690505+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-23 07:36:59.962617+00	2024-02-23 07:37:00.446883+00	508dcb21-4387-4498-8c5c-57fd9039cf42	d55dc665-00dd-40e6-8e8e-8f06c806a253	t	2024-02-23 07:41:59.959608+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-23 12:57:08.644869+00	2024-02-23 12:57:09.186964+00	b7cd0e8e-bdc4-4b50-b7aa-5ee477b32131	bcdeada8-3664-4720-bc65-c35636d5c894	t	2024-02-23 13:02:08.642499+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-24 18:05:53.620196+00	2024-02-24 18:05:54.001322+00	86bea144-af3a-41b2-ad2f-627a6df5791f	56c74603-e9b2-4277-836e-62ebb0ad8e62	t	2024-02-24 18:10:53.61821+00	VC	11aceaac-d6a4-4835-bb93-2a51aaaad195	web	\N
2024-02-24 18:06:17.149639+00	2024-02-24 18:06:17.436169+00	5e73a1ba-2b9b-4dcd-83ac-43dc0156d1c9	1cd36cf7-2d7d-4845-b210-fa8a2e21dbe1	t	2024-02-24 18:11:17.14791+00	VC	11aceaac-d6a4-4835-bb93-2a51aaaad195	web	\N
2024-02-24 18:17:34.301292+00	2024-02-24 18:17:34.967544+00	6b94c5bd-1825-4649-b2d5-560f545f98cd	430bdad0-4e64-4416-a19f-3cc33cd5b7f6	t	2024-02-24 18:22:34.298704+00	VC	11aceaac-d6a4-4835-bb93-2a51aaaad195	web	\N
2024-02-24 18:18:50.108258+00	2024-02-24 18:18:50.525987+00	ee4dfb98-8067-4a99-8348-dbc86ac314be	ec4b2411-4c00-41d6-926c-2d49ef0b4e3e	t	2024-02-24 18:23:50.104806+00	VC	11aceaac-d6a4-4835-bb93-2a51aaaad195	web	\N
2024-02-24 18:19:38.785147+00	2024-02-24 18:20:44.598852+00	4df591b0-9323-4d3f-9794-3246b10398ff	1fd9d7c5-c805-48f2-90ef-58a37b7bdf52	t	2024-02-24 18:24:38.783075+00	VC	11aceaac-d6a4-4835-bb93-2a51aaaad195	web	\N
2024-02-24 18:20:50.791085+00	2024-02-24 18:20:51.264909+00	9bcd5e82-d8af-4140-8e55-6345842a4392	be5e6e8a-c76b-407f-8e28-1f0e4c09494c	t	2024-02-24 18:25:50.78927+00	VC	11aceaac-d6a4-4835-bb93-2a51aaaad195	web	\N
2024-02-24 18:21:01.139134+00	2024-02-24 18:21:01.489936+00	1e45217f-73a4-4d14-ad58-cc3636c328be	30c6e6b2-7efb-4a7b-bb37-47ce01f318e7	t	2024-02-24 18:26:01.135861+00	VC	11aceaac-d6a4-4835-bb93-2a51aaaad195	web	\N
2024-02-24 18:21:24.238161+00	2024-02-24 18:21:24.52751+00	ffac3c54-8847-4367-8da2-024a10a3ce85	00304331-be5c-40ab-81dc-b3a269731ff9	t	2024-02-24 18:26:24.235922+00	VC	59030e56-cb06-4093-b576-3f6f2ffa9603	web	\N
2024-02-24 18:24:35.954352+00	2024-02-24 18:24:53.676298+00	17fad8ac-447e-4155-b3ed-0b49a0e6a1b5	71b156c4-9ffb-4a4b-9001-269dabfe700b	t	2024-02-24 18:29:35.952256+00	VC	59030e56-cb06-4093-b576-3f6f2ffa9603	web	\N
2024-02-24 18:24:53.682471+00	2024-02-24 18:24:53.682483+00	38ecf1f4-770a-489f-9d12-fbe9f47dc58e	f8d69f6f-9ad9-40b4-bed7-24cd91be4710	f	2024-03-02 18:24:53.680666+00	RF	59030e56-cb06-4093-b576-3f6f2ffa9603	web	\N
2024-02-24 18:28:18.739762+00	2024-02-24 18:28:19.263512+00	d04304cc-776f-4bf3-ae3a-72028dcf00ee	8aa23406-f182-43c6-9713-39f8c81d38dd	t	2024-02-24 18:33:18.737825+00	VC	11aceaac-d6a4-4835-bb93-2a51aaaad195	web	\N
2024-02-24 18:29:49.623691+00	2024-02-24 18:29:50.033602+00	475a6abb-e2fe-435b-85ff-a639d468fe1e	fb67ab2e-0ef5-43f1-bb21-65f5df76fea4	t	2024-02-24 18:34:49.621704+00	VC	11aceaac-d6a4-4835-bb93-2a51aaaad195	web	\N
2024-02-24 18:36:01.414779+00	2024-02-24 18:36:01.977449+00	264db120-d29f-42f1-83ba-4c2b2259db16	a15f4db6-d869-4022-9488-0b3569c94f73	t	2024-02-24 18:41:01.410788+00	VC	11aceaac-d6a4-4835-bb93-2a51aaaad195	web	\N
2024-02-24 18:36:19.594986+00	2024-02-24 18:36:19.934514+00	4ed50573-1b0c-4243-b4ae-c41fd0733bc5	29e2811e-1925-4d47-9754-a2487fb9e5b9	t	2024-02-24 18:41:19.59308+00	VC	11aceaac-d6a4-4835-bb93-2a51aaaad195	web	\N
2024-02-25 05:37:02.983329+00	2024-02-25 05:38:06.173942+00	82674c74-6d56-435c-af52-6a044d44551e	77b59e25-6b89-48f9-856d-a1c3b9ff9420	t	2024-02-25 05:42:02.979851+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-02-28 13:42:27.582936+00	2024-02-28 13:42:27.76292+00	df9d73b5-5121-4a5e-9d6b-3eddd57af84f	8b5c9200-7d0e-415f-b868-c996d05e31d6	t	2024-02-28 13:47:27.580795+00	VC	7540db5f-1069-45f4-9fa9-b85de1092814	web	\N
2024-02-28 13:42:27.768985+00	2024-02-28 13:42:27.769012+00	e9b0e3f8-8317-4fc3-893d-5e83a890a179	67bd4b7a-2b00-4a39-8c13-dddc2a669a0e	f	2024-03-06 13:42:27.766193+00	RF	7540db5f-1069-45f4-9fa9-b85de1092814	web	\N
2024-03-01 12:48:00.511713+00	2024-03-01 12:48:17.837518+00	0dc00d90-48e7-4e05-8ea0-5a10a1ac2322	852bf2bc-b823-45a6-ae9c-fe2f19a76217	t	2024-03-01 12:53:00.509102+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-05 07:01:21.980375+00	2024-03-05 07:01:22.349869+00	a8cea72e-3365-41d1-840b-6d84d215daca	0e2994af-762c-4941-bde3-f9329185bc62	t	2024-03-05 07:06:21.97733+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-05 09:51:21.66084+00	2024-03-05 09:51:22.009298+00	0ab7c22c-1ee3-48ef-bff9-a119ee9661fa	b30f391c-ed01-4696-923c-7433ca57b90c	t	2024-03-05 09:56:21.658925+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-07 13:31:57.874361+00	2024-03-07 13:31:58.149634+00	a39656b1-3466-44ae-ab7b-6272c9bf7e89	082971aa-73cc-4c88-a87b-097a45e9435c	t	2024-03-07 13:36:57.871632+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-07 13:34:07.209869+00	2024-03-07 13:34:07.592774+00	786504d9-bee2-4c3d-93fb-c2f7613e9d54	326a0695-a11e-47ed-8b8b-787dfe8b283d	t	2024-03-07 13:39:07.207799+00	VC	0c95228e-47d8-4fa9-aa0f-a260913e211f	web	\N
2024-03-07 13:36:10.395874+00	2024-03-07 13:36:11.189483+00	73d1fd21-1337-4cb7-8fab-624e79f83b6a	c2dca94a-b70d-42cb-b633-e4e2f74f0f2c	t	2024-03-07 13:41:10.393379+00	VC	0c95228e-47d8-4fa9-aa0f-a260913e211f	web	\N
2024-03-07 13:38:31.497156+00	2024-03-07 13:38:32.838339+00	b3443a84-5b1f-40fe-a553-92cc3f03cd93	c724b7ee-97ae-4959-bfd3-b2b8b65213b1	t	2024-03-07 13:43:31.494539+00	VC	0c95228e-47d8-4fa9-aa0f-a260913e211f	web	\N
2024-03-10 06:14:39.136225+00	2024-03-10 06:14:55.618705+00	80eb248e-63ef-4ddb-a9c7-eb9f124d580a	cffb62955f210c1614575605ed7b662e23836e5a7b4104e4158ae3480d4081b4	t	2024-03-10 06:19:39.13383+00	PR	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-10 07:56:56.025131+00	2024-03-10 07:56:57.061379+00	dbe81882-7fb0-45f7-b6d3-4afc3465d7bc	eced6e77-acc4-4fa3-8d82-ed3dfd6d9a90	t	2024-03-10 08:01:56.02159+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-10 10:04:34.446659+00	2024-03-10 10:04:34.853318+00	973e748c-4365-478f-8d38-710cd41c7ffd	9d010f70-7b8c-4eb0-9673-bc8b8f0028fe	t	2024-03-10 10:09:34.442793+00	VC	e03edb6b-3137-4461-a0ee-9e73d58f08a8	web	\N
2024-03-11 05:22:03.007522+00	2024-03-11 05:22:22.334375+00	721137e7-7dff-49c5-8a5c-af020bfcc047	19f1443a-cba4-468e-8174-d9a5a42b0420	t	2024-03-11 05:27:03.005461+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-15 18:13:08.700067+00	2024-03-15 18:13:09.048022+00	ed8857d0-5ee0-4bab-ac39-31d57d273c0c	2b92738a-4b9b-463e-b617-ceeb6cde7fe4	t	2024-03-15 18:18:08.698264+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-15 10:25:00.266675+00	2024-03-15 10:25:01.12606+00	ee662597-ebdd-488b-8775-4929052f7bb3	ed96e8ea-ed4b-4864-a8e2-70e1c9843865	t	2024-03-15 10:30:00.263225+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-18 04:43:13.191142+00	2024-03-18 04:43:13.921847+00	350fdde0-101a-4aea-bf54-72c791416258	381d39ba-b56a-45b8-b3f5-053492addcd7	t	2024-03-18 04:48:13.188555+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-15 12:22:09.174806+00	2024-03-15 12:22:09.716201+00	685bddab-837f-4f75-8ce7-c6d7f2622bf2	f705764b-1e64-4cc5-8dd0-ef8994b4dc7f	t	2024-03-15 12:27:09.172334+00	VC	fef1f4f4-96d4-473e-bbec-e077c396089c	web	\N
2024-03-18 07:55:48.140363+00	2024-03-18 07:55:48.865811+00	56901d10-dd30-4f9b-856d-0990116946a6	4045185c-1661-44f0-aede-9c66f8e762e0	t	2024-03-18 08:00:48.137802+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-15 12:23:54.876457+00	2024-03-15 12:24:11.647764+00	d848bf76-8fd7-4fc5-87ed-2f13ee0c3939	9bfb02f9-4e2e-465d-9c3b-03fea2792824	t	2024-03-15 12:28:54.874065+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-18 08:08:37.338689+00	2024-03-18 08:08:37.673352+00	c1ee00cd-57f8-449f-b13c-7411fd05d439	12aa242d-48af-4592-96b9-45ff362e2f1f	t	2024-03-18 08:13:37.335652+00	VC	e03edb6b-3137-4461-a0ee-9e73d58f08a8	web	\N
2024-03-18 08:12:24.924739+00	2024-03-18 08:12:25.665698+00	acf11a8f-eabf-43b4-91fa-eedcccdaca82	c7838732-f806-4daf-84d1-40dc1ea4e618	t	2024-03-18 08:17:24.922072+00	VC	4f173bce-c90a-437f-9690-acaf88b93490	web	\N
2024-03-18 16:52:34.04504+00	2024-03-18 16:52:34.388801+00	873db6ce-7b37-480e-87d0-08c3dbccc61a	ba0ecdcc-09c8-4bf8-9b39-df79ac82fb04	t	2024-03-18 16:57:34.042138+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-20 05:07:29.067067+00	2024-03-20 05:07:29.692912+00	d956c606-9490-4c83-b2b6-7d1a547fa8aa	6608f771-517d-4029-9cf2-7bad5a58c339	t	2024-03-20 05:12:29.064915+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-20 05:07:38.127883+00	2024-03-20 05:07:38.440295+00	a639af07-eb47-41a9-bf08-c5fab94245de	b52f585e-f1a6-4d7d-88a7-9e430f0bc7a5	t	2024-03-20 05:12:38.125129+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-20 05:07:45.048468+00	2024-03-20 05:07:45.422721+00	8c8e875e-3004-449b-aa80-bf6e68d4022d	ce5e6716-8360-402c-abc3-12d3a7fc2bde	t	2024-03-20 05:12:45.046373+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-20 05:07:52.438618+00	2024-03-20 05:07:52.712269+00	b7aa3a7c-1c89-4d12-a809-97c30b21a3fd	70d25f8b-d81e-4a70-b5cc-81b43ffdc5ef	t	2024-03-20 05:12:52.436471+00	VC	fef1f4f4-96d4-473e-bbec-e077c396089c	web	\N
2024-03-20 05:08:01.408334+00	2024-03-20 05:08:02.681571+00	38633dca-936f-49a6-8436-cfe1e2004da0	b28917e8-42c7-4a28-b32e-5c7007727ab6	t	2024-03-20 05:13:01.403933+00	VC	e03edb6b-3137-4461-a0ee-9e73d58f08a8	web	\N
2024-03-20 05:08:14.507292+00	2024-03-20 05:08:14.795776+00	a42aa820-4ca1-4160-be36-406302d0255a	5c65da4f-5640-46c0-8d86-dec2bc0b29e3	t	2024-03-20 05:13:14.505116+00	VC	ff9d5da9-eebf-4865-9549-292169aa5393	web	\N
2024-03-20 05:08:26.786888+00	2024-03-20 05:08:27.637053+00	2b346f15-9b01-405b-bece-e638d452a787	c3719fb8-bea2-4c94-a28e-11aa91772265	t	2024-03-20 05:13:26.784773+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-20 05:08:41.784102+00	2024-03-20 05:08:59.927672+00	b25e1574-4c4e-499e-a555-fdffb6ab0a04	f364c1d3-091a-49d2-9180-0fef98449ff7	t	2024-03-20 05:13:41.781648+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-20 05:09:49.804295+00	2024-03-20 05:09:50.072278+00	71e2f606-961f-4775-b8d6-99c3c21e6623	5055504c-19c1-49b9-bc0b-df932ea6f08e	t	2024-03-20 05:14:49.801133+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-23 09:40:55.060229+00	2024-03-23 09:40:57.018669+00	8d42fe1d-547b-4879-89bc-6cb95d4e6e4a	55ba786b-1ab2-4b66-9f86-b350200fa936	t	2024-03-23 09:45:55.057752+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-23 09:48:23.613148+00	2024-03-23 09:48:37.225076+00	dadd17ed-1e86-4bb6-aedf-834e4d1505e4	d7e09df6-7dd0-46f9-9864-8020b12b37c7	t	2024-03-23 09:53:23.610597+00	VC	fef1f4f4-96d4-473e-bbec-e077c396089c	web	\N
2024-03-23 09:48:37.232887+00	2024-03-23 09:48:37.232906+00	cb1c27bc-3780-4196-9c87-bd68dbb532ec	358465d7-7b1b-414d-8737-0bd7e30ec0ab	f	2024-03-30 09:48:37.230461+00	RF	fef1f4f4-96d4-473e-bbec-e077c396089c	web	\N
2024-03-26 11:47:24.075963+00	2024-03-26 11:47:41.591806+00	1671f6b2-5717-4619-b125-067cf97d3b96	331076d4-b558-4ec2-8d35-76865c92b581	t	2024-03-26 11:52:24.07296+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-26 11:47:51.875165+00	2024-03-26 11:47:52.200266+00	5f9aec72-bc7d-4165-8546-e39e109a24c5	555e81d9-deb0-4f1c-b5e7-895e55bcf2d6	t	2024-03-26 11:52:51.870868+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-27 16:48:14.87136+00	2024-03-27 16:48:15.206674+00	464d5f5c-b536-4fbb-bf37-f73448e82e1c	12c13ad3-3fdb-480a-a2a0-532a0d024d76	t	2024-03-27 16:53:14.867704+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-03-28 09:03:44.692847+00	2024-03-28 09:04:11.925881+00	b832ad89-f593-414d-8eb6-f11ff7f7e9fe	32457c86-615a-4e4a-b115-d1b7bfd64619	t	2024-03-28 09:08:44.689523+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-04-02 08:29:41.172761+00	2024-04-02 08:29:41.682871+00	e6e5b663-514e-464e-b38e-7897d8bb8f87	c6cfdcc2-a591-4f4a-9b8e-43be78103e0e	t	2024-04-02 08:34:41.167459+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-04-02 08:30:32.520497+00	2024-04-02 08:30:33.407744+00	3de9a8ca-15b9-4e71-aa74-18c3f2655af9	3d0b076f-b426-43a2-ac4b-0dd4aee846b8	t	2024-04-02 08:35:32.516766+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-04-02 08:30:33.420609+00	2024-04-02 08:30:33.420646+00	f1d17be0-f0cd-4880-9943-52b1fe19347a	b5c0e6b3-2027-456a-9df7-df3965a0cd44	f	2024-04-09 08:30:33.414169+00	RF	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-04-05 15:53:34.433528+00	2024-04-05 15:53:34.804505+00	877babdc-fd77-405e-bf6f-16279d3dbcd4	29e834cb-7625-4e68-99d5-13d95653eee1	t	2024-04-05 15:58:34.430925+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-04-17 09:29:27.252725+00	2024-04-17 09:29:27.798027+00	36f3070c-5b4c-4b79-856c-06a256834898	9494b90f-a708-49f6-8c13-b90fa9b9b025	t	2024-04-17 09:34:27.250549+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-04-29 09:11:32.134242+00	2024-04-29 09:11:32.811166+00	8f6192c5-8c94-4c55-9c4f-12c9390ebc56	790cecdb-d6fc-4d8a-a81e-c357e1973c16	t	2024-04-29 09:16:32.132115+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-04-29 09:11:32.816673+00	2024-04-29 09:11:32.816687+00	c5d9706a-d45a-4151-bae9-74112216bcaa	9e2e74c1-93b6-4876-babf-42f7e9a792c8	f	2024-05-06 09:11:32.815034+00	RF	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
2024-05-03 16:31:09.461994+00	2024-05-03 16:31:10.120377+00	895d2fa1-c27e-4bbb-b97e-1ed114172289	363d5fe3-0a64-4d34-9e6e-6f3789c32987	t	2024-05-03 16:36:09.459411+00	VC	479c457f-d99e-40d4-b5e7-38ecb8b271b4	web	\N
2024-05-03 16:31:10.12716+00	2024-05-03 16:31:10.127177+00	06a5514d-2117-44da-918d-2ab0d3958a30	4344282d-8360-4e1d-a841-cca11276864d	f	2024-05-10 16:31:10.125035+00	RF	479c457f-d99e-40d4-b5e7-38ecb8b271b4	web	\N
2024-05-09 05:24:48.565506+00	2024-05-09 05:24:49.049577+00	c2280d1f-d814-4fc3-807f-422f6a9b01f2	756d9388-3228-49d3-b03b-e67d16c6fff6	t	2024-05-09 05:29:48.562724+00	VC	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	web	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users (password, last_login, is_superuser, username, is_staff, is_active, date_joined, created_at, updated_at, id, avatar, google_id, apple_id, first_name, last_name, email, email_verified, has_contributed, city_id) FROM stdin;
	\N	f	shubham782000@gmail.com	f	t	2024-02-08 20:34:56.756554+00	2024-02-08 20:34:56.757071+00	2024-02-08 20:34:56.764801+00	046ba5a0-39a3-4a1b-a805-6c822c8df4c3	https://lh3.googleusercontent.com/a/ACg8ocJcU9pT9Q7YU4vxQGoDjydGjAk8qmCIsKA6PcwQ4ZePGw=s96-c	116648507290057827560	\N	shubham	kumar	shubham782000@gmail.com	t	f	\N
argon2$argon2id$v=19$m=102400,t=2,p=8$N0R5Tnh0WWFOZGtzOWdndG1NZXpGVg$qMutcBuhw8UF8f//vqozYx2hwlLEc0ZQZokPpcCBcfc	\N	f	ashutosh.vesatogo@gmail.com	f	t	2024-01-31 08:05:21.161417+00	2024-01-31 08:05:21.161804+00	2024-01-31 08:05:21.286423+00	e0974db9-20c6-40a9-98aa-5ad594de9703		\N	\N	Ashutosh	Pangavhane	ashutosh.vesatogo@gmail.com	f	f	713b7600-4c05-48fc-86d1-31974c747ce3
	\N	f	vesatogo111@gmail.com	f	t	2024-02-02 19:19:01.730867+00	2024-02-02 19:19:01.731312+00	2024-02-02 19:19:01.741389+00	bcf01653-d849-4a68-8f85-29ee1b1f1142	https://lh3.googleusercontent.com/a/ACg8ocJPem5FJfHJkVljLIhy8LNdm5_V9Q0NNFZw99dsjdOOlbU=s96-c	104937666345225713914	\N	Vesatogo	Innovations	vesatogo111@gmail.com	t	f	\N
	\N	f	rohit.agarwal@drivex.in	f	t	2024-02-28 13:42:27.568852+00	2024-02-28 13:42:27.569315+00	2024-02-28 13:42:27.57924+00	7540db5f-1069-45f4-9fa9-b85de1092814	https://lh3.googleusercontent.com/a/ACg8ocI0lY1YEZdalYZz52vUJM8fKZU2cLPM0UAYgU9VHIhv=s96-c	110395343877159200389	\N	Rohit	Agarwal	rohit.agarwal@drivex.in	t	t	\N
	\N	f	ladanihemal@gmail.com	f	t	2024-02-24 18:21:24.226112+00	2024-02-24 18:21:24.226457+00	2024-02-24 18:21:24.233904+00	59030e56-cb06-4093-b576-3f6f2ffa9603	https://lh3.googleusercontent.com/a/ACg8ocImM77jZOXWPjn2CLj49qA3v1YWACrgeD3MYs6HKvk9Azg=s96-c	103645477353959595389	\N	Hemal	Ladani	ladanihemal@gmail.com	t	t	\N
	\N	f	hemall@winjit.com	f	t	2024-02-24 18:05:53.608304+00	2024-02-24 18:05:53.608831+00	2024-02-24 18:36:19.590509+00	11aceaac-d6a4-4835-bb93-2a51aaaad195	https://lh3.googleusercontent.com/a/ACg8ocKJjgIU8Q-zoO8vdG_sDOhvQHppyAb_x9R8aXN08DVy=s96-c	102411634977643144548	\N	Hemal	Ladani	hemall@winjit.com	t	t	\N
	\N	f	faridaqaid@gmail.com	f	t	2024-02-14 16:48:30.068358+00	2024-02-14 16:48:30.068774+00	2024-02-23 05:13:00.956501+00	9db134d5-bc29-411e-898c-2331bb99ab08	https://lh3.googleusercontent.com/a/ACg8ocL5_GJmxQ5N3LKCdBj2LDfmBYR05GxlT63InDbsRootJEgl=s96-c	114112427531549200259	\N	Farida	Bagwala	faridaqaid@gmail.com	t	t	\N
	\N	f	developer.bagwala@gmail.com	f	t	2024-02-18 05:05:09.037182+00	2024-02-18 05:05:09.037547+00	2024-03-20 05:07:52.434825+00	fef1f4f4-96d4-473e-bbec-e077c396089c	https://lh3.googleusercontent.com/a/ACg8ocKMcbGdSYVzqVyh39rIEGngf99odoo8eVhjPxI2anbXICA=s96-c	106157915725824202864	\N	Malik	Bagwala	developer.bagwala@gmail.com	t	t	\N
	\N	f	ayushahirrao2030@gmail.com	f	t	2024-03-07 13:34:07.194708+00	2024-03-07 13:34:07.195205+00	2024-03-07 13:38:31.493065+00	0c95228e-47d8-4fa9-aa0f-a260913e211f	https://lh3.googleusercontent.com/a/ACg8ocK77D-ijYI4eFitt-M4VBTGHFDLILQPYjBAW0OlvF4E=s96-c	115233889892543473822	\N	Ayush	Ahirrao	ayushahirrao2030@gmail.com	t	t	\N
	\N	f	maalikaws@gmail.com	f	t	2024-03-10 10:04:34.426706+00	2024-03-10 10:04:34.427452+00	2024-03-20 05:08:01.399898+00	e03edb6b-3137-4461-a0ee-9e73d58f08a8	https://lh3.googleusercontent.com/a/ACg8ocIRMVHBVqsZYSBcknCQoi-drDr2d1MrRfCVmiAZKZiSFA=s96-c	107707203050633286137	\N	Malik AWS		maalikaws@gmail.com	t	t	713b7600-4c05-48fc-86d1-31974c747ce3
	\N	f	malik.vesatogo@gmail.com	f	t	2024-01-31 14:53:49.628411+00	2024-01-31 14:53:49.629171+00	2024-03-20 05:08:14.503482+00	ff9d5da9-eebf-4865-9549-292169aa5393	https://lh3.googleusercontent.com/a/ACg8ocJjo1qV1TcFx1aKpzKVC9C9Ekq2ekLuzbAAoIYkXqBak-s=s96-c	101119608392380815442	\N	Malik	Bagwala	malik.vesatogo@gmail.com	t	f	\N
	\N	f	khatikirfan883@gmail.com	f	t	2024-03-18 08:12:24.911424+00	2024-03-18 08:12:24.911882+00	2024-03-18 08:14:26.141932+00	4f173bce-c90a-437f-9690-acaf88b93490	https://lh3.googleusercontent.com/a/ACg8ocIMtAApBX0h2DwBARO8ETYrDFs4KfPTI_Wh-SamtoOY=s96-c	101320259480772795700	\N	irfan	khatik	khatikirfan883@gmail.com	t	t	713b7600-4c05-48fc-86d1-31974c747ce3
argon2$argon2id$v=19$m=102400,t=2,p=8$a05jN2luQ204dzhnM2kxU01ZcFZIbQ$xvHac84y6E/dEGi9oDORvi1Y6ID0fopktjNOsmQU4qU	\N	f	m.bagwala@gmail.com	f	t	2024-01-30 04:10:47.164184+00	2024-01-30 04:10:47.164676+00	2024-05-09 05:24:48.559341+00	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	https://lh3.googleusercontent.com/a/ACg8ocJQE0CbO-sDetYZMQTMv6rGYT0dHnvOxHWW3-fW_hKCMBAtuk4D-g=s96-c	114342518340670104926	\N	Malik	Bagwala	m.bagwala@gmail.com	t	t	713b7600-4c05-48fc-86d1-31974c747ce3
argon2$argon2id$v=19$m=102400,t=2,p=8$a1dxUzA1UWY2RFpoRDdCNW1sdnJlWA$89doQfMo4/VdExR6iuRwY2w7vJWHlz9kcr/JvzAoeYQ	2024-03-27 16:47:52.454979+00	t	admin	t	t	2024-01-29 17:42:38.106268+00	2024-01-29 17:42:38.106744+00	2024-03-27 16:47:34.495756+00	0bb5a044-bff7-40a1-9d67-73fa28050c26		\N	\N	Onroad	Admin	admin@example.com	f	f	\N
argon2$argon2id$v=19$m=102400,t=2,p=8$RHhVQWlaaXNFTkwwZVk3MmQ0Y3lrbw$5pL69O5PHbjdEMCO83VrIdOE5pJvdud4+x7rF7+BzBg	\N	f	shimpihitesh2@gmail.com	f	t	2024-01-30 04:21:03.72714+00	2024-01-30 04:21:03.727552+00	2024-05-03 16:31:09.457003+00	479c457f-d99e-40d4-b5e7-38ecb8b271b4	https://lh3.googleusercontent.com/a/ACg8ocJd-TLmuG8P9w8IjSOM-JWeXi9RcDXMuPbqrPHuH8DcEbpYLNmp5Q=s96-c	102019166878897295842	\N	Hitesh		shimpihitesh2@gmail.com	t	t	713b7600-4c05-48fc-86d1-31974c747ce3
\.


--
-- Data for Name: users_groups; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users_groups (id, user_id, group_id) FROM stdin;
4	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6	1
6	479c457f-d99e-40d4-b5e7-38ecb8b271b4	1
14	e0974db9-20c6-40a9-98aa-5ad594de9703	1
15	ff9d5da9-eebf-4865-9549-292169aa5393	1
27	bcf01653-d849-4a68-8f85-29ee1b1f1142	1
44	046ba5a0-39a3-4a1b-a805-6c822c8df4c3	1
50	9db134d5-bc29-411e-898c-2331bb99ab08	1
68	fef1f4f4-96d4-473e-bbec-e077c396089c	1
75	11aceaac-d6a4-4835-bb93-2a51aaaad195	1
83	59030e56-cb06-4093-b576-3f6f2ffa9603	1
88	7540db5f-1069-45f4-9fa9-b85de1092814	1
92	0c95228e-47d8-4fa9-aa0f-a260913e211f	1
96	e03edb6b-3137-4461-a0ee-9e73d58f08a8	1
103	4f173bce-c90a-437f-9690-acaf88b93490	1
\.


--
-- Data for Name: users_user_permissions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: variant_colors; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.variant_colors (id, name, hex_code, variant_id) FROM stdin;
832574a1-345a-4c7f-9f76-a2b5f675b63e	Black	\N	7965067e-dac3-4b60-ba6b-9b8c7e719c72
ae7d1105-cb9f-483a-b9b6-d7cd4f9d1527	White	\N	7965067e-dac3-4b60-ba6b-9b8c7e719c72
4ec485a9-567d-4b98-8ef4-6f4ac8284028	Pewter Olive	#282A1D	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b
c21b92cf-1db4-4dcb-9a02-4ac3c8b4b89d	Glacier White Pearl	#F4FBFD	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b
bc5ef1c2-796d-4a88-b8ce-4edf5aa0bb99	Sparkling Silver	#B1B1B3	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b
5a03d12e-0c6e-40e2-8958-56b858a671ef	Gravity Grey	#36373C	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b
3c7a0352-97c2-4bfe-830b-077ff01201de	Intense Red	#B2001E	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b
b5290f91-9937-4a42-88ee-df14fc8a8c90	Imperial Blue	#2B2C71	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b
e5d8b574-df6e-4f8a-b6e1-0c1c0590d02b	Intense Red with Aurora Black Pearl	#B2001D	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b
0b70dfab-1b83-4a64-bf3b-9df447bda2b3	Glacier White Pearl with Aurora Black Pearl	#F4F8F9	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b
bc1d6887-1561-45b7-9ed5-965de0e9b9f0	Xclusive Matte Graphite	#3B3D3E	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b
2d68e5d9-3b05-4b8d-82b2-8239e8e500f5	Clear White	#EFF5F5	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b
c58809b1-b2cb-42bd-9a7e-dea3cfb7f1f7	Abyss Black Pearl	#1D1C1C	af665d7a-3816-4ded-bb8c-57b114588a1a
f91c481c-748a-42f3-9a17-d5e43e5c9443	Aurora Black Pearl	#151718	4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b
b3932082-b474-46f6-be1a-275ed5e263ac	Glossy Red Black	\N	7965067e-dac3-4b60-ba6b-9b8c7e719c72
\.


--
-- Data for Name: variant_colors_attachments; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.variant_colors_attachments (id, variantcolor_id, attachment_id) FROM stdin;
2	f91c481c-748a-42f3-9a17-d5e43e5c9443	93c27b32-6e16-4d12-8c27-c8065aa48c02
3	b3932082-b474-46f6-be1a-275ed5e263ac	eee85ab4-29b9-4622-b669-3731193735ca
\.


--
-- Data for Name: variants; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.variants (id, launch_date, name, fuel_type, transmission, description, specifications, manufacturer_link, vehicle_id, short_description, slug) FROM stdin;
7965067e-dac3-4b60-ba6b-9b8c7e719c72	2022-09-04	Okinawa Praise Pro 2022	EL	AT	The Okinawa PraisePro is equipped with a 2.7 kWh BLDC motor. It takes 2-3 hours to achieve a full charge for its battery, offering a claimed range of 88 km per charge. The model is available in one variant, STD.	{"gps": "No", "tyre": "90/90-12 Tubeless (Front/Rear)", "speed": "56 kmph", "wheel": "Stylish Aluminum Alloy Wheel", "battery": "2.08 kWh Lithium-ion (Detachable Battery)", "voltage": "72V", "floor_mat": "Stylish Body Coloured", "headlight": "LED with DRL Function", "back_light": "Unique Design with LED rear Winkers", "controller": "E-ABS (Electronic- Assisted Braking System) with regenerative energy", "dimensions": "1970X715X1165mm", "peak_power": "2700 W", "suspension": "Front- Hydraulic Telescopic Rear- Double Shocker with dual tube technology", "brake_lever": "CNC Machined with Lever Adjustment", "seat_height": "800mm", "speedometer": "Digital", "brake_system": "FR- Disc | RR- Disc", "key_features": "Central Locking with Anti-theft Alarm, Keyless Entry, Find My Scooter Function, Mobile Charging USB Port, Motor Walking Assistance (Front/Reverse Motion)", "charging_time": "2-3 HRs", "motor_warranty": "3 Yrs/30,000KMs (whichever is earlier)***", "battery_warranty": "3 Years", "ground_clearance": "175mm", "loading_capacity": "150Kg", "range_per_charge": {"name": "81 km/Charge (Sports Mode)", "description": "Under Ideal Test Conditions - Specific Range Depends Upon Riding Condition and Road Condition"}, "climbing_approval": "Approved at 7 degrees", "arai_icat_approved": "Yes", "road_side_assistance": "Yes (Optional)", "charger_specification": "Micro-Charger with Auto Cut Function", "mobile_app_connectivity": "No"}	https://okinawascooters.com/scooters/praisepro	b4680840-0baa-47c4-9226-ac1f38b17037	The Okinawa PraisePro is equipped with a 2.7 kWh BLDC motor. It takes 2-3 hours to achieve a full charge for its battery, offering a claimed range of 88 km per charge. The model is available in one variant, STD.	okinawa-praise-pro-2022-e3894ab3e2
4a69bf1a-a8a7-4911-bf14-daabd8bc0b9b	2023-01-01	Kia Sonet HTK Plus 1.2 Petrol MT 2023	PT	MT	The Kia Sonet HTK Plus 1.2 Petrol MT 2023 is a compact SUV that offers a blend of style, comfort, and efficiency. It's powered by a 1.2-liter petrol engine paired with a manual transmission, aiming to provide a balance between performance and fuel economy. The exterior design is modern and eye-catching, with distinctive Kia styling cues such as the signature tiger-nose grille. \r\n\r\nInside, the HTK Plus trim offers a comfortable and tech-equipped cabin. Key features typically include a touchscreen infotainment system with smartphone connectivity, a sound system, and a range of convenience features like power windows, air conditioning, and more. Safety features may include dual airbags, ABS with EBD, and rear parking sensors.\r\n\r\nThe Sonet is known for its practicality, offering ample cabin space and luggage capacity for its class. It's a popular choice for those seeking a compact SUV that's suitable for urban environments yet capable of handling occasional longer journeys.	{"capacity": {"doors": "5 Doors", "bootspace": "385 litres", "no_of_rows": "2 Rows", "seating_capacity": "5 Person", "fuel_tank_capacity": "45 litres"}, "dimensions_and_weight": {"width": "1790 mm", "height": "1642 mm", "length": "3995 mm", "wheelbase": "2500 mm"}, "engine_and_transmission": {"engine": "1197 cc, 4 Cylinders Inline, 4 Valves/Cylinder, DOHC", "fuel_type": "Petrol", "max_power": "82 bhp @ 6000 rpm", "drivetrain": "FWD", "max_torque": "115 Nm @ 4200 rpm", "engine_type": "Smartstream G 1.2", "transmission": "Manual - 5 Gears", "electric_motor": "No", "emission_standard": "BS6 Phase 2"}, "suspensions_brakes_steering_tyres": {"wheels": "Alloy Wheels", "rear_tyres": "215 / 60 R16", "front_tyres": "215 / 60 R16", "spare_wheel": "Steel", "steering_type": "Power assisted (Electric)", "rear_brake_type": "Drum", "rear_suspension": "Coupled Torsion Beam Axle with Coil Spring", "front_brake_type": "Disc", "front_suspension": "McPherson Strut with Coil Spring"}}	https://www.kia.com/in/our-vehicles/sonet/showroom.html	bb12863a-b5e2-4b33-85cf-a3e0211d3729	The 2023 Kia Sonet HTK Plus 1.2 Petrol MT is a stylish compact SUV, featuring a 1.2-liter engine and manual transmission for a balanced blend of performance and fuel efficiency. With modern design cues, a tech-equipped cabin, and safety features, it's known for practicality, making it a popular choice for urban and occasional longer drives.	kia-sonet-htk-plus-12-petrol-mt-2023-9f54366267
af665d7a-3816-4ded-bb8c-57b114588a1a	2024-01-01	Hyndai Creta SX (O) 1.5 Diesel AT 2024	DL	AT	# 2024 Hyundai Creta Facelift Overview\r\nThe 2024 Hyundai Creta facelift has been launched in India, introducing bolder styling, enhanced features, and three engine options in the popular mid-size SUV segment. Here's a brief summary:\r\n## Key Updates:\r\n- **Refreshed Design:**\r\n  - New grille, headlights, bumpers, and a more muscular stance.\r\n- **Feature-packed:**\r\n  - Panoramic sunroof, ventilated seats, ADAS (Advanced Driver Assistance Systems), and a fully digital instrument cluster.\r\n- **Three Engine Choices:**\r\n  - 1.5L naturally aspirated petrol, 1.5L turbocharged petrol, and 1.5L diesel.\r\n  - Available with manual, automatic, and DCT transmissions.\r\n- **Competitive Pricing:**\r\n  - Starting at Rs. 10.99 lakhs (ex-showroom).\r\n  - Comparable to rivals like Kia Seltos, Maruti Suzuki Grand Vitara, and Toyota Urban Cruiser Hyryder.\r\n## Overall Impression:\r\nThe 2024 Creta facelift builds on its predecessor's strengths, featuring a sharper look, a tech-laden interior, and diverse powertrain options. It continues to be a formidable player in the Indian SUV market, providing value, style, and a range of features suitable for urban driving and occasional off-road adventures.	{"price": "Rs. 13.09 Lakh onwards", "engine": "1482 to 1497 cc", "fuel_type": "Petrol & Diesel", "transmission": "Manual & Automatic", "seating_capacity": "5 Seater"}	https://www.hyundai.com/in/en/find-a-car/creta/highlights	408b40a3-9830-4537-8257-f331e6ed83b3	The 2024 Hyundai Creta Facelift in India brings bold design upgrades, advanced features including a panoramic sunroof and ADAS, and three engine choices (1.5L petrol, turbocharged petrol, and diesel) with manual, automatic, and DCT transmissions. Priced competitively at Rs. 10.99 lakhs onwards, it stands as a formidable mid-size SUV, rivaling competitors for style, value, and versatility.	hyndai-creta-sx-o-15-diesel-at-2024-5577834374
\.


--
-- Data for Name: variants_attachments; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.variants_attachments (id, variant_id, attachment_id) FROM stdin;
1	af665d7a-3816-4ded-bb8c-57b114588a1a	b93323c0-3c7e-453f-8e28-8705108b1448
\.


--
-- Data for Name: vehicle_types; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.vehicle_types (id, name, category, code) FROM stdin;
ecd0ab5b-c1a3-4f5e-8904-e139968b8681	Compact SUV	CRS	COM
6be8a535-c5a7-4409-88ca-9f5198d04bee	SUV	SUV	SUV
5f60c271-9214-4d5f-9b8a-684c9181e490	Sedan	SED	SED
79f14dac-a150-457f-9cf5-5c49e09e5c50	Hatchback	HAT	HAT
409d5ccf-972f-4ede-9d59-06f878115a54	MPV	SUV	MPV
a1f60e7c-398f-4a59-9f2f-334c3ae5bda2	Scooter	MO	SCO
\.


--
-- Data for Name: vehicles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.vehicles (id, name, make_id, vehicle_type_id) FROM stdin;
4f1f8751-20a0-49ef-9dfc-ca6edff0d422	Maruti Suzuki Swift	65586920-747c-4e98-bdf3-eb0571cfd101	79f14dac-a150-457f-9cf5-5c49e09e5c50
401ff32e-ac00-42bf-9483-9f681fc62b8d	Maruti Suzuki Baleno	65586920-747c-4e98-bdf3-eb0571cfd101	79f14dac-a150-457f-9cf5-5c49e09e5c50
973b200c-beb9-4033-bfd8-912134e2cf4e	Maruti Suzuki Fronx	65586920-747c-4e98-bdf3-eb0571cfd101	79f14dac-a150-457f-9cf5-5c49e09e5c50
1568fc26-84d4-4aed-9f01-6e78ad653b6d	Maruti Suzuki Dzire	65586920-747c-4e98-bdf3-eb0571cfd101	5f60c271-9214-4d5f-9b8a-684c9181e490
a2d0cb11-8a3c-48a8-8009-954cf27b925f	Maruti Suzuki Invicto	65586920-747c-4e98-bdf3-eb0571cfd101	5f60c271-9214-4d5f-9b8a-684c9181e490
a88f3e70-60e3-432c-bf21-8235cce7a57b	Maruti Suzuki Ciaz	65586920-747c-4e98-bdf3-eb0571cfd101	5f60c271-9214-4d5f-9b8a-684c9181e490
c431d030-1764-4317-be7c-145773099206	Maruti Suzuki Vitara Brezza	65586920-747c-4e98-bdf3-eb0571cfd101	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
79439299-395b-4eea-8114-2e88b54aff57	Maruti Suzuki Ertiga	65586920-747c-4e98-bdf3-eb0571cfd101	409d5ccf-972f-4ede-9d59-06f878115a54
0bb7a8ae-bc18-44a9-906e-fdcb91c9eeb0	Maruti Suzuki Grand Vitara	65586920-747c-4e98-bdf3-eb0571cfd101	6be8a535-c5a7-4409-88ca-9f5198d04bee
408b40a3-9830-4537-8257-f331e6ed83b3	Hyundai Creta	208e6363-d7b2-4ccf-91f7-9f3b661da4a9	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
4d4fdd24-91a3-41fd-b063-d326009109d9	Hyundai Venue	208e6363-d7b2-4ccf-91f7-9f3b661da4a9	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
b802bd5f-295d-4d76-8bda-e427fe1dfb4c	Hyundai i20	208e6363-d7b2-4ccf-91f7-9f3b661da4a9	79f14dac-a150-457f-9cf5-5c49e09e5c50
416b9388-8ece-4dfe-adf7-5bc3f97a486a	Hyundai Verna	208e6363-d7b2-4ccf-91f7-9f3b661da4a9	5f60c271-9214-4d5f-9b8a-684c9181e490
1de989c9-a1d4-440b-990c-4ff68bde8fb5	Hyundai Kona Electric	208e6363-d7b2-4ccf-91f7-9f3b661da4a9	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
a714dc3e-da40-45ec-9a4f-885a14716047	Tata Motors Altroz	610ffb65-7b92-4604-acda-3b49598c0736	79f14dac-a150-457f-9cf5-5c49e09e5c50
26a107ba-3292-4136-a594-4ab7464346fb	Tata Motors Tiago	610ffb65-7b92-4604-acda-3b49598c0736	79f14dac-a150-457f-9cf5-5c49e09e5c50
9b9eec73-ea01-4284-924f-cdce14389a06	Tata Motors Nexon	610ffb65-7b92-4604-acda-3b49598c0736	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
14d8c683-4de7-484d-8bcd-91bdf2c5e606	Tata Motors Harrier	610ffb65-7b92-4604-acda-3b49598c0736	6be8a535-c5a7-4409-88ca-9f5198d04bee
98eb06d1-b7f4-4148-adf9-d6e6574ae4a5	Tata Motors Safari	610ffb65-7b92-4604-acda-3b49598c0736	6be8a535-c5a7-4409-88ca-9f5198d04bee
bda0b3cf-c296-498c-b761-685d184482d6	Mahindra & Mahindra XUV300	146a47ba-5812-4854-afa2-fcd2d7255fce	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
b81a1a15-5a45-4711-8684-63a215479c49	Mahindra & Mahindra Scorpio	146a47ba-5812-4854-afa2-fcd2d7255fce	6be8a535-c5a7-4409-88ca-9f5198d04bee
6dd94b5f-8f64-46b7-9b5c-5f3d8418be3a	Mahindra & Mahindra Thar	146a47ba-5812-4854-afa2-fcd2d7255fce	6be8a535-c5a7-4409-88ca-9f5198d04bee
3ea73f64-8a58-4cc2-b577-45b3d2cefaa7	Mahindra & Mahindra Bolero	146a47ba-5812-4854-afa2-fcd2d7255fce	6be8a535-c5a7-4409-88ca-9f5198d04bee
114aed0a-832b-403e-8c07-ebb78f14e23c	Mahindra & Mahindra Alturas G4	146a47ba-5812-4854-afa2-fcd2d7255fce	6be8a535-c5a7-4409-88ca-9f5198d04bee
c4e06a74-cb93-45b2-b01a-8a99a17940ab	Honda City	1f5bee5a-043d-453b-8b57-05c419cd561c	5f60c271-9214-4d5f-9b8a-684c9181e490
62d80141-4ad9-475b-aae1-6ae759090760	Honda Amaze	1f5bee5a-043d-453b-8b57-05c419cd561c	5f60c271-9214-4d5f-9b8a-684c9181e490
f3098168-7be0-4de8-84d7-fce69b14b95a	Honda Civic	1f5bee5a-043d-453b-8b57-05c419cd561c	5f60c271-9214-4d5f-9b8a-684c9181e490
0299cbed-04f8-4670-b2b0-24ff847b0642	Honda WR-V	1f5bee5a-043d-453b-8b57-05c419cd561c	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
b7667000-de5d-4252-bb37-e450e4a3bf6d	Honda CR-V	1f5bee5a-043d-453b-8b57-05c419cd561c	6be8a535-c5a7-4409-88ca-9f5198d04bee
be8e782d-faea-4c9f-bee0-22d88ed87406	Toyota Hyrider	d73da496-f35b-4cc0-9318-633406cddb42	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
df2f7706-ba7d-4d1e-9428-11940ea6a721	Toyota Hycross	d73da496-f35b-4cc0-9318-633406cddb42	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
39cfa5c7-5c97-47c2-9665-ec19238bc81b	Volkswagen Polo	4ee01662-ba0b-4ccb-bb4d-b8288e64e5f6	79f14dac-a150-457f-9cf5-5c49e09e5c50
05b6f9aa-a246-4853-9ce1-43438695b203	Volkswagen Vento	4ee01662-ba0b-4ccb-bb4d-b8288e64e5f6	5f60c271-9214-4d5f-9b8a-684c9181e490
318357f7-468f-46a2-a6c5-eba67f9707e9	Volkswagen Tiguan Allspace	4ee01662-ba0b-4ccb-bb4d-b8288e64e5f6	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
b47bbe3d-b26d-45c5-80d0-cafe19736cca	Volkswagen Taigun	4ee01662-ba0b-4ccb-bb4d-b8288e64e5f6	6be8a535-c5a7-4409-88ca-9f5198d04bee
313c2012-7ff6-47c2-88d5-06f781a82e5e	Ford EcoSport	6e7ff323-e59e-405d-8968-4a0ac6473b37	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
d554f275-fe77-4c9a-b7b3-f97e0b928cfc	Ford Figo	6e7ff323-e59e-405d-8968-4a0ac6473b37	79f14dac-a150-457f-9cf5-5c49e09e5c50
75f86084-fd79-4987-9925-0718092ce5dd	Ford Freestyle	6e7ff323-e59e-405d-8968-4a0ac6473b37	79f14dac-a150-457f-9cf5-5c49e09e5c50
c078ab82-4614-4e86-b41c-1d58727b8e84	Ford Aspire	6e7ff323-e59e-405d-8968-4a0ac6473b37	5f60c271-9214-4d5f-9b8a-684c9181e490
fb3965e0-1240-44d4-b652-4a650990dcef	Ford Endeavour	6e7ff323-e59e-405d-8968-4a0ac6473b37	6be8a535-c5a7-4409-88ca-9f5198d04bee
30d96dbc-0785-4979-a417-b38d6053dcac	Kia Seltos	f6022c9d-ac1c-44f5-9e07-867b80a3cadc	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
bb12863a-b5e2-4b33-85cf-a3e0211d3729	Kia Sonet	f6022c9d-ac1c-44f5-9e07-867b80a3cadc	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
43176cbb-54bc-4ee6-aef6-4685a0896e2b	Kia Carnival	f6022c9d-ac1c-44f5-9e07-867b80a3cadc	409d5ccf-972f-4ede-9d59-06f878115a54
9073d695-0c38-46d6-aff5-f355ce2d4779	Renault Kwid	d04bc353-c5d5-45a4-b679-88784447e932	79f14dac-a150-457f-9cf5-5c49e09e5c50
dd21892f-0b9b-46f7-8068-e319e87a9692	Renault Triber	d04bc353-c5d5-45a4-b679-88784447e932	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
8ae76668-8f76-4dbc-8719-6eeb2660235c	Renault Duster	d04bc353-c5d5-45a4-b679-88784447e932	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
81150120-a332-4d7e-9a61-2c472221ec94	Renault Kiger	d04bc353-c5d5-45a4-b679-88784447e932	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
fdbf9a27-bf83-46ab-a25a-827d5d063a4e	Nissan Magnite	dc84b41d-c43d-4f8c-85d4-5599b476a2de	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
496cde96-6ef4-4def-b3a3-eedf8bb14e8f	Nissan Kicks	dc84b41d-c43d-4f8c-85d4-5599b476a2de	6be8a535-c5a7-4409-88ca-9f5198d04bee
812487aa-7d46-44c0-a087-a1d62aafaca8	Skoda Rapid	b919b7f5-af01-403e-8613-fe998f96e902	5f60c271-9214-4d5f-9b8a-684c9181e490
2a765a97-d4cd-4dbe-92d9-5cb818e4f991	Skoda Superb	b919b7f5-af01-403e-8613-fe998f96e902	5f60c271-9214-4d5f-9b8a-684c9181e490
45b97a24-bd06-4c9a-bf2f-ef51940ea65a	Skoda Slavia	b919b7f5-af01-403e-8613-fe998f96e902	5f60c271-9214-4d5f-9b8a-684c9181e490
5d3df941-fd2b-49f8-8962-73af94f7a48a	Skoda Kushaq	b919b7f5-af01-403e-8613-fe998f96e902	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
2ccfe64c-66b6-4fd7-b1c3-9dc42ba60d1e	Mercedes-Benz C-Class	7e774d85-9350-4399-a3df-c5f8b5508f25	5f60c271-9214-4d5f-9b8a-684c9181e490
9ba8df04-7695-4ea5-afa5-da7d7b2bc377	Mercedes-Benz E-Class	7e774d85-9350-4399-a3df-c5f8b5508f25	5f60c271-9214-4d5f-9b8a-684c9181e490
f6288875-535e-49df-9ecb-4fd02213adfc	Mercedes-Benz S-Class	7e774d85-9350-4399-a3df-c5f8b5508f25	5f60c271-9214-4d5f-9b8a-684c9181e490
967bc5d5-0fc1-4829-8893-9fe787162dbd	Mercedes-Benz GLC	7e774d85-9350-4399-a3df-c5f8b5508f25	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
0c2fa263-a600-4f03-b4ae-acb6d18d120a	Mercedes-Benz GLE	7e774d85-9350-4399-a3df-c5f8b5508f25	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
453e65ba-ac1e-4577-8b11-98726acae774	BMW 3 Series	34e55ce5-6e05-462d-846e-bcd8bb8913c5	5f60c271-9214-4d5f-9b8a-684c9181e490
db3cfec5-afa7-4bed-b61d-c501631c84e2	BMW 5 Series	34e55ce5-6e05-462d-846e-bcd8bb8913c5	5f60c271-9214-4d5f-9b8a-684c9181e490
d5f74371-bf1c-45a3-a5ed-8521cfa82e57	BMW X1	34e55ce5-6e05-462d-846e-bcd8bb8913c5	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
546fc1df-0599-49d4-b077-13bef554e819	BMW X3	34e55ce5-6e05-462d-846e-bcd8bb8913c5	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
3fc6df94-cfee-47d0-872c-c4c4a2edfb80	BMW X5	34e55ce5-6e05-462d-846e-bcd8bb8913c5	6be8a535-c5a7-4409-88ca-9f5198d04bee
a2ea8145-0a00-484a-9fd0-797a88c81dc5	Audi A4	2e99bd5a-f3e6-4373-ab88-2a0cf47f2c17	5f60c271-9214-4d5f-9b8a-684c9181e490
903e2859-7889-48d4-aa69-a0395c2ebe54	Audi A6	2e99bd5a-f3e6-4373-ab88-2a0cf47f2c17	5f60c271-9214-4d5f-9b8a-684c9181e490
69840d26-b539-473f-a51c-6a017acfd620	Audi Q3	2e99bd5a-f3e6-4373-ab88-2a0cf47f2c17	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
7dd45568-1abe-4581-9292-0d7afcd15501	Audi Q5	2e99bd5a-f3e6-4373-ab88-2a0cf47f2c17	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
3936fb0f-15de-4e25-9e76-4b3816fb9b50	Audi Q7	2e99bd5a-f3e6-4373-ab88-2a0cf47f2c17	6be8a535-c5a7-4409-88ca-9f5198d04bee
b4fc2112-9850-45b1-b392-13e431b317a6	Volvo V40	d2aae664-e280-44da-98a0-03214d62a6a9	79f14dac-a150-457f-9cf5-5c49e09e5c50
d42d3ae7-74e1-4a12-8c8c-d4bff7efc86d	Volvo S60	d2aae664-e280-44da-98a0-03214d62a6a9	5f60c271-9214-4d5f-9b8a-684c9181e490
d81b1f29-84fe-477c-9a0a-8548037c40ba	Volvo S90	d2aae664-e280-44da-98a0-03214d62a6a9	5f60c271-9214-4d5f-9b8a-684c9181e490
38bf2856-536f-4b04-be50-40f8ff651bee	Volvo XC40	d2aae664-e280-44da-98a0-03214d62a6a9	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
1fa4c161-2fbb-4510-86c6-9053211c1a72	Volvo XC60	d2aae664-e280-44da-98a0-03214d62a6a9	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
70b27199-b705-4807-9202-96d522fba8c9	Volvo XC90	d2aae664-e280-44da-98a0-03214d62a6a9	6be8a535-c5a7-4409-88ca-9f5198d04bee
e6624bd1-3a5c-4e2f-847d-34b59bf609ad	Jaguar XE	4f9d9964-84a1-4a00-9e8f-0fafba4fe9b4	5f60c271-9214-4d5f-9b8a-684c9181e490
f2052f57-b106-48ce-aa36-7348bbc713f0	Jaguar XF	4f9d9964-84a1-4a00-9e8f-0fafba4fe9b4	5f60c271-9214-4d5f-9b8a-684c9181e490
48782875-c92b-4c83-b621-a1ee1a103c00	Jaguar F-PACE	4f9d9964-84a1-4a00-9e8f-0fafba4fe9b4	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
6ce01b58-44c7-4ae0-b5c7-3c26f2c1f5a9	Land Rover Discovery Sport	f6fe441a-823d-429f-a549-d1120f865d8a	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
94cc50f8-f1ba-468f-a12d-9ee5a14b3e76	Land Rover Range Rover Evoque	f6fe441a-823d-429f-a549-d1120f865d8a	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
cae75089-939e-41f5-ab04-80693f63acfa	Land Rover Range Rover Sport	f6fe441a-823d-429f-a549-d1120f865d8a	6be8a535-c5a7-4409-88ca-9f5198d04bee
81ba4826-ea38-45ce-9aee-9f83a6862dba	MG Motor Hector	091671c2-6d80-4ba7-9d27-3cdbe24be1e8	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
4909e2a7-7b29-4b45-ae93-018439614348	MG Motor ZS EV	091671c2-6d80-4ba7-9d27-3cdbe24be1e8	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
08a14656-3c7d-44ac-acdf-e2c8f7090c84	MG Motor Astor	091671c2-6d80-4ba7-9d27-3cdbe24be1e8	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
6fdc183c-ef4b-4b75-a554-037641d09b79	MG Motor Gloster	091671c2-6d80-4ba7-9d27-3cdbe24be1e8	6be8a535-c5a7-4409-88ca-9f5198d04bee
332b9ceb-9cbe-46f9-a91a-b8272bd986b0	Jeep Compass	72347e22-3d29-4616-9f24-c7200bf1d7c8	ecd0ab5b-c1a3-4f5e-8904-e139968b8681
7f5af72a-1356-4a76-8d25-ccbbc5acfaba	Jeep Wrangler	72347e22-3d29-4616-9f24-c7200bf1d7c8	6be8a535-c5a7-4409-88ca-9f5198d04bee
7068e4bc-18c0-40d3-b5bf-77c8e499c2b2	Fiat Punto	11cd6871-d9a0-4632-a45a-b2f27455719c	79f14dac-a150-457f-9cf5-5c49e09e5c50
ed5fecb7-30c1-4024-bf4e-e34346289940	Fiat Linea	11cd6871-d9a0-4632-a45a-b2f27455719c	5f60c271-9214-4d5f-9b8a-684c9181e490
b4680840-0baa-47c4-9226-ac1f38b17037	Praise	d0763beb-6cac-45ae-b21c-e3b12d64bb70	a1f60e7c-398f-4a59-9f2f-334c3ae5bda2
30ea6e3b-d9d9-4112-bd42-023fc1f83b4d	Hyundai Alcazar	208e6363-d7b2-4ccf-91f7-9f3b661da4a9	6be8a535-c5a7-4409-88ca-9f5198d04bee
\.


--
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.votes (created_at, updated_at, id, type, contribution_id, user_id) FROM stdin;
2024-02-17 07:51:45.651221+00	2024-02-17 07:51:45.651221+00	d798a9d2-8307-4bee-a91f-b32914eb522e	UP	4885ef82-f64e-40ca-bb2a-6e0d4d56ff08	479c457f-d99e-40d4-b5e7-38ecb8b271b4
2024-02-17 08:21:29.930079+00	2024-02-17 08:21:29.930079+00	2da0bc55-5374-4be6-b101-5e052fa55a52	UP	4885ef82-f64e-40ca-bb2a-6e0d4d56ff08	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6
2024-02-23 07:32:15.308709+00	2024-02-23 07:32:15.308709+00	db71fa5e-2fbe-4797-8ada-cb735f516547	DN	1e4136f3-b950-4ffb-bd18-ca3e2e5c2989	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6
2024-02-23 07:32:18.847099+00	2024-02-23 07:32:18.847099+00	d7eaa89d-70e3-4eed-b131-7c460d92c7ac	UP	13cc3e04-a5a9-4de8-8304-866fecd4d1b9	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6
2024-02-28 13:44:36.100526+00	2024-02-28 13:44:40.350086+00	620ef990-6112-4ade-bbf0-a04376443c7a	UP	f47f7cd4-a757-4cd9-8a6c-b6172b3daf93	7540db5f-1069-45f4-9fa9-b85de1092814
2024-03-10 10:05:51.285029+00	2024-03-10 10:05:51.285029+00	2e6972f6-d96d-4d90-9daa-f3d9dec719c4	UP	f1e4c888-d13c-4924-8c6c-92ea3b790cf0	e03edb6b-3137-4461-a0ee-9e73d58f08a8
2024-02-17 08:03:22.154747+00	2024-02-17 08:03:22.154747+00	c886caa5-6aad-4871-bf07-32901a98a66b	UP	f1e4c888-d13c-4924-8c6c-92ea3b790cf0	030d34a0-6bc3-4eed-a6b4-07e1ff9190a6
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: admin
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: admin
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: admin
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: admin
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: admin
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: admin
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 4, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 100, true);


--
-- Name: contributions_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.contributions_attachments_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 45, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 25, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 52, true);


--
-- Name: users_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_groups_id_seq', 122, true);


--
-- Name: users_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_user_permissions_id_seq', 1, false);


--
-- Name: variant_colors_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.variant_colors_attachments_id_seq', 3, true);


--
-- Name: variants_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.variants_attachments_id_seq', 1, true);


--
-- Name: topology_id_seq; Type: SEQUENCE SET; Schema: topology; Owner: admin
--

SELECT pg_catalog.setval('topology.topology_id_seq', 1, false);


--
-- Name: hdb_action_log hdb_action_log_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: admin
--

ALTER TABLE ONLY hdb_catalog.hdb_action_log
    ADD CONSTRAINT hdb_action_log_pkey PRIMARY KEY (id);


--
-- Name: hdb_cron_event_invocation_logs hdb_cron_event_invocation_logs_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: admin
--

ALTER TABLE ONLY hdb_catalog.hdb_cron_event_invocation_logs
    ADD CONSTRAINT hdb_cron_event_invocation_logs_pkey PRIMARY KEY (id);


--
-- Name: hdb_cron_events hdb_cron_events_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: admin
--

ALTER TABLE ONLY hdb_catalog.hdb_cron_events
    ADD CONSTRAINT hdb_cron_events_pkey PRIMARY KEY (id);


--
-- Name: hdb_metadata hdb_metadata_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: admin
--

ALTER TABLE ONLY hdb_catalog.hdb_metadata
    ADD CONSTRAINT hdb_metadata_pkey PRIMARY KEY (id);


--
-- Name: hdb_metadata hdb_metadata_resource_version_key; Type: CONSTRAINT; Schema: hdb_catalog; Owner: admin
--

ALTER TABLE ONLY hdb_catalog.hdb_metadata
    ADD CONSTRAINT hdb_metadata_resource_version_key UNIQUE (resource_version);


--
-- Name: hdb_scheduled_event_invocation_logs hdb_scheduled_event_invocation_logs_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: admin
--

ALTER TABLE ONLY hdb_catalog.hdb_scheduled_event_invocation_logs
    ADD CONSTRAINT hdb_scheduled_event_invocation_logs_pkey PRIMARY KEY (id);


--
-- Name: hdb_scheduled_events hdb_scheduled_events_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: admin
--

ALTER TABLE ONLY hdb_catalog.hdb_scheduled_events
    ADD CONSTRAINT hdb_scheduled_events_pkey PRIMARY KEY (id);


--
-- Name: hdb_schema_notifications hdb_schema_notifications_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: admin
--

ALTER TABLE ONLY hdb_catalog.hdb_schema_notifications
    ADD CONSTRAINT hdb_schema_notifications_pkey PRIMARY KEY (id);


--
-- Name: hdb_version hdb_version_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: admin
--

ALTER TABLE ONLY hdb_catalog.hdb_version
    ADD CONSTRAINT hdb_version_pkey PRIMARY KEY (hasura_uuid);


--
-- Name: attachments attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: contribution_price_items contribution_price_item_unique; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contribution_price_items
    ADD CONSTRAINT contribution_price_item_unique UNIQUE (contribution_id, price_item_id);


--
-- Name: contribution_price_items contribution_price_items_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contribution_price_items
    ADD CONSTRAINT contribution_price_items_pkey PRIMARY KEY (id);


--
-- Name: contribution_price_items contribution_serial_no_unique; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contribution_price_items
    ADD CONSTRAINT contribution_serial_no_unique UNIQUE (contribution_id, serial_no);


--
-- Name: contributions_attachments contributions_attachment_contribution_id_attachme_1b924f0a_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contributions_attachments
    ADD CONSTRAINT contributions_attachment_contribution_id_attachme_1b924f0a_uniq UNIQUE (contribution_id, attachment_id);


--
-- Name: contributions_attachments contributions_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contributions_attachments
    ADD CONSTRAINT contributions_attachments_pkey PRIMARY KEY (id);


--
-- Name: contributions contributions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contributions
    ADD CONSTRAINT contributions_pkey PRIMARY KEY (id);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_dramatiq_task django_dramatiq_task_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_dramatiq_task
    ADD CONSTRAINT django_dramatiq_task_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: makes makes_code_67a30dd4_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.makes
    ADD CONSTRAINT makes_code_67a30dd4_uniq UNIQUE (code);


--
-- Name: makes makes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.makes
    ADD CONSTRAINT makes_pkey PRIMARY KEY (id);


--
-- Name: price_items price_items_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.price_items
    ADD CONSTRAINT price_items_pkey PRIMARY KEY (id);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: user_passkeys user_passkeys_credential_id_016b7a67_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_passkeys
    ADD CONSTRAINT user_passkeys_credential_id_016b7a67_uniq UNIQUE (credential_id);


--
-- Name: user_passkeys user_passkeys_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_passkeys
    ADD CONSTRAINT user_passkeys_pkey PRIMARY KEY (id);


--
-- Name: user_tokens user_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_tokens
    ADD CONSTRAINT user_tokens_pkey PRIMARY KEY (id);


--
-- Name: users users_apple_id_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_apple_id_key UNIQUE (apple_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_google_id_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_google_id_key UNIQUE (google_id);


--
-- Name: users_groups users_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users_groups
    ADD CONSTRAINT users_groups_pkey PRIMARY KEY (id);


--
-- Name: users_groups users_groups_user_id_group_id_fc7788e8_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users_groups
    ADD CONSTRAINT users_groups_user_id_group_id_fc7788e8_uniq UNIQUE (user_id, group_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_user_permissions users_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users_user_permissions
    ADD CONSTRAINT users_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_user_permissions users_user_permissions_user_id_permission_id_3b86cbdf_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users_user_permissions
    ADD CONSTRAINT users_user_permissions_user_id_permission_id_3b86cbdf_uniq UNIQUE (user_id, permission_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: variant_colors_attachments variant_colors_attachmen_variantcolor_id_attachme_f246b268_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variant_colors_attachments
    ADD CONSTRAINT variant_colors_attachmen_variantcolor_id_attachme_f246b268_uniq UNIQUE (variantcolor_id, attachment_id);


--
-- Name: variant_colors_attachments variant_colors_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variant_colors_attachments
    ADD CONSTRAINT variant_colors_attachments_pkey PRIMARY KEY (id);


--
-- Name: variant_colors variant_colors_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variant_colors
    ADD CONSTRAINT variant_colors_pkey PRIMARY KEY (id);


--
-- Name: variant_colors variant_colors_variant_id_name_8b236f25_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variant_colors
    ADD CONSTRAINT variant_colors_variant_id_name_8b236f25_uniq UNIQUE (variant_id, name);


--
-- Name: variants_attachments variants_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variants_attachments
    ADD CONSTRAINT variants_attachments_pkey PRIMARY KEY (id);


--
-- Name: variants_attachments variants_attachments_variant_id_attachment_id_fabd455f_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variants_attachments
    ADD CONSTRAINT variants_attachments_variant_id_attachment_id_fabd455f_uniq UNIQUE (variant_id, attachment_id);


--
-- Name: variants variants_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_pkey PRIMARY KEY (id);


--
-- Name: variants variants_slug_8e3bb316_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_slug_8e3bb316_uniq UNIQUE (slug);


--
-- Name: vehicle_types vehicle_types_code_e8abf8b3_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicle_types
    ADD CONSTRAINT vehicle_types_code_e8abf8b3_uniq UNIQUE (code);


--
-- Name: vehicle_types vehicle_types_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicle_types
    ADD CONSTRAINT vehicle_types_pkey PRIMARY KEY (id);


--
-- Name: vehicles vehicles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_pkey PRIMARY KEY (id);


--
-- Name: votes votes_contribution_id_user_id_c683cc92_uniq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_contribution_id_user_id_c683cc92_uniq UNIQUE (contribution_id, user_id);


--
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: hdb_cron_event_invocation_event_id; Type: INDEX; Schema: hdb_catalog; Owner: admin
--

CREATE INDEX hdb_cron_event_invocation_event_id ON hdb_catalog.hdb_cron_event_invocation_logs USING btree (event_id);


--
-- Name: hdb_cron_event_status; Type: INDEX; Schema: hdb_catalog; Owner: admin
--

CREATE INDEX hdb_cron_event_status ON hdb_catalog.hdb_cron_events USING btree (status);


--
-- Name: hdb_cron_events_unique_scheduled; Type: INDEX; Schema: hdb_catalog; Owner: admin
--

CREATE UNIQUE INDEX hdb_cron_events_unique_scheduled ON hdb_catalog.hdb_cron_events USING btree (trigger_name, scheduled_time) WHERE (status = 'scheduled'::text);


--
-- Name: hdb_scheduled_event_status; Type: INDEX; Schema: hdb_catalog; Owner: admin
--

CREATE INDEX hdb_scheduled_event_status ON hdb_catalog.hdb_scheduled_events USING btree (status);


--
-- Name: hdb_version_one_row; Type: INDEX; Schema: hdb_catalog; Owner: admin
--

CREATE UNIQUE INDEX hdb_version_one_row ON hdb_catalog.hdb_version USING btree (((version IS NOT NULL)));


--
-- Name: attachments_created_by_id_3222e0ad; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX attachments_created_by_id_3222e0ad ON public.attachments USING btree (created_by_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: cities_state_id_24484747; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX cities_state_id_24484747 ON public.cities USING btree (state_id);


--
-- Name: contribution_price_items_contribution_id_309a9434; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX contribution_price_items_contribution_id_309a9434 ON public.contribution_price_items USING btree (contribution_id);


--
-- Name: contribution_price_items_price_item_id_22af535b; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX contribution_price_items_price_item_id_22af535b ON public.contribution_price_items USING btree (price_item_id);


--
-- Name: contributions_attachments_attachment_id_420d32c5; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX contributions_attachments_attachment_id_420d32c5 ON public.contributions_attachments USING btree (attachment_id);


--
-- Name: contributions_attachments_contribution_id_75ad5ccc; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX contributions_attachments_contribution_id_75ad5ccc ON public.contributions_attachments USING btree (contribution_id);


--
-- Name: contributions_city_id_a77a43ec; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX contributions_city_id_a77a43ec ON public.contributions USING btree (city_id);


--
-- Name: contributions_color_id_273439dd; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX contributions_color_id_273439dd ON public.contributions USING btree (color_id);


--
-- Name: contributions_user_id_350f1265; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX contributions_user_id_350f1265 ON public.contributions USING btree (user_id);


--
-- Name: contributions_variant_id_4e4da3a4; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX contributions_variant_id_4e4da3a4 ON public.contributions USING btree (variant_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_dramatiq_task_updated_at_bb623596; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX django_dramatiq_task_updated_at_bb623596 ON public.django_dramatiq_task USING btree (updated_at);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: makes_code_67a30dd4_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX makes_code_67a30dd4_like ON public.makes USING btree (code varchar_pattern_ops);


--
-- Name: states_country_id_bdb47937; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX states_country_id_bdb47937 ON public.states USING btree (country_id);


--
-- Name: user_passkeys_user_id_a0f2f271; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_passkeys_user_id_a0f2f271 ON public.user_passkeys USING btree (user_id);


--
-- Name: user_tokens_token_5bc595c5; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_tokens_token_5bc595c5 ON public.user_tokens USING btree (token);


--
-- Name: user_tokens_token_5bc595c5_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_tokens_token_5bc595c5_like ON public.user_tokens USING btree (token varchar_pattern_ops);


--
-- Name: user_tokens_user_id_31273822; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_tokens_user_id_31273822 ON public.user_tokens USING btree (user_id);


--
-- Name: users_apple_id_221fddca_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX users_apple_id_221fddca_like ON public.users USING btree (apple_id varchar_pattern_ops);


--
-- Name: users_city_id_2e41ae86; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX users_city_id_2e41ae86 ON public.users USING btree (city_id);


--
-- Name: users_email_0ea73cca_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX users_email_0ea73cca_like ON public.users USING btree (email varchar_pattern_ops);


--
-- Name: users_google_id_49fe2bb1_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX users_google_id_49fe2bb1_like ON public.users USING btree (google_id varchar_pattern_ops);


--
-- Name: users_groups_group_id_2f3517aa; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX users_groups_group_id_2f3517aa ON public.users_groups USING btree (group_id);


--
-- Name: users_groups_user_id_f500bee5; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX users_groups_user_id_f500bee5 ON public.users_groups USING btree (user_id);


--
-- Name: users_user_permissions_permission_id_6d08dcd2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX users_user_permissions_permission_id_6d08dcd2 ON public.users_user_permissions USING btree (permission_id);


--
-- Name: users_user_permissions_user_id_92473840; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX users_user_permissions_user_id_92473840 ON public.users_user_permissions USING btree (user_id);


--
-- Name: users_username_e8658fc8_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX users_username_e8658fc8_like ON public.users USING btree (username varchar_pattern_ops);


--
-- Name: variant_colors_attachments_attachment_id_9e0f05a4; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX variant_colors_attachments_attachment_id_9e0f05a4 ON public.variant_colors_attachments USING btree (attachment_id);


--
-- Name: variant_colors_attachments_variantcolor_id_b737b339; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX variant_colors_attachments_variantcolor_id_b737b339 ON public.variant_colors_attachments USING btree (variantcolor_id);


--
-- Name: variant_colors_variant_id_eae93791; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX variant_colors_variant_id_eae93791 ON public.variant_colors USING btree (variant_id);


--
-- Name: variants_attachments_attachment_id_060718d8; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX variants_attachments_attachment_id_060718d8 ON public.variants_attachments USING btree (attachment_id);


--
-- Name: variants_attachments_variant_id_55c24ac8; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX variants_attachments_variant_id_55c24ac8 ON public.variants_attachments USING btree (variant_id);


--
-- Name: variants_name_56154327; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX variants_name_56154327 ON public.variants USING btree (name);


--
-- Name: variants_name_56154327_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX variants_name_56154327_like ON public.variants USING btree (name varchar_pattern_ops);


--
-- Name: variants_slug_8e3bb316_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX variants_slug_8e3bb316_like ON public.variants USING btree (slug varchar_pattern_ops);


--
-- Name: variants_vehicle_id_3c4b1716; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX variants_vehicle_id_3c4b1716 ON public.variants USING btree (vehicle_id);


--
-- Name: vehicle_types_code_e8abf8b3_like; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX vehicle_types_code_e8abf8b3_like ON public.vehicle_types USING btree (code varchar_pattern_ops);


--
-- Name: vehicles_make_id_acbaedc2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX vehicles_make_id_acbaedc2 ON public.vehicles USING btree (make_id);


--
-- Name: vehicles_vehicle_type_id_45741935; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX vehicles_vehicle_type_id_45741935 ON public.vehicles USING btree (vehicle_type_id);


--
-- Name: votes_contribution_id_3b396dcd; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX votes_contribution_id_3b396dcd ON public.votes USING btree (contribution_id);


--
-- Name: votes_user_id_def56ed6; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX votes_user_id_def56ed6 ON public.votes USING btree (user_id);


--
-- Name: makes before_insert_or_update_make; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER before_insert_or_update_make BEFORE INSERT OR UPDATE ON public.makes FOR EACH ROW EXECUTE FUNCTION public.update_make_code();


--
-- Name: vehicle_types before_insert_or_update_vehicle; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER before_insert_or_update_vehicle BEFORE INSERT OR UPDATE ON public.vehicle_types FOR EACH ROW EXECUTE FUNCTION public.update_vehicle_code();


--
-- Name: variants before_insert_update_generate_slug; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER before_insert_update_generate_slug BEFORE INSERT OR UPDATE ON public.variants FOR EACH ROW EXECUTE FUNCTION public.generate_slug();


--
-- Name: contribution_price_items contribution_price_item_trigger; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER contribution_price_item_trigger AFTER INSERT OR DELETE OR UPDATE ON public.contribution_price_items FOR EACH ROW EXECUTE FUNCTION public.update_contribution_total();


--
-- Name: contributions contribution_update_user_trigger; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER contribution_update_user_trigger AFTER INSERT OR DELETE OR UPDATE ON public.contributions FOR EACH ROW EXECUTE FUNCTION public.update_user_contributions();


--
-- Name: votes contribution_vote_trigger; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER contribution_vote_trigger AFTER INSERT OR DELETE OR UPDATE ON public.votes FOR EACH ROW EXECUTE FUNCTION public.update_contribution_votes();


--
-- Name: hdb_cron_event_invocation_logs hdb_cron_event_invocation_logs_event_id_fkey; Type: FK CONSTRAINT; Schema: hdb_catalog; Owner: admin
--

ALTER TABLE ONLY hdb_catalog.hdb_cron_event_invocation_logs
    ADD CONSTRAINT hdb_cron_event_invocation_logs_event_id_fkey FOREIGN KEY (event_id) REFERENCES hdb_catalog.hdb_cron_events(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hdb_scheduled_event_invocation_logs hdb_scheduled_event_invocation_logs_event_id_fkey; Type: FK CONSTRAINT; Schema: hdb_catalog; Owner: admin
--

ALTER TABLE ONLY hdb_catalog.hdb_scheduled_event_invocation_logs
    ADD CONSTRAINT hdb_scheduled_event_invocation_logs_event_id_fkey FOREIGN KEY (event_id) REFERENCES hdb_catalog.hdb_scheduled_events(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: attachments attachments_created_by_id_3222e0ad_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_created_by_id_3222e0ad_fk_users_id FOREIGN KEY (created_by_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cities cities_state_id_24484747_fk_states_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_state_id_24484747_fk_states_id FOREIGN KEY (state_id) REFERENCES public.states(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contribution_price_items contribution_price_i_contribution_id_309a9434_fk_contribut; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contribution_price_items
    ADD CONSTRAINT contribution_price_i_contribution_id_309a9434_fk_contribut FOREIGN KEY (contribution_id) REFERENCES public.contributions(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contribution_price_items contribution_price_i_price_item_id_22af535b_fk_price_ite; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contribution_price_items
    ADD CONSTRAINT contribution_price_i_price_item_id_22af535b_fk_price_ite FOREIGN KEY (price_item_id) REFERENCES public.price_items(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contributions_attachments contributions_attach_attachment_id_420d32c5_fk_attachmen; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contributions_attachments
    ADD CONSTRAINT contributions_attach_attachment_id_420d32c5_fk_attachmen FOREIGN KEY (attachment_id) REFERENCES public.attachments(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contributions_attachments contributions_attach_contribution_id_75ad5ccc_fk_contribut; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contributions_attachments
    ADD CONSTRAINT contributions_attach_contribution_id_75ad5ccc_fk_contribut FOREIGN KEY (contribution_id) REFERENCES public.contributions(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contributions contributions_city_id_a77a43ec_fk_cities_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contributions
    ADD CONSTRAINT contributions_city_id_a77a43ec_fk_cities_id FOREIGN KEY (city_id) REFERENCES public.cities(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contributions contributions_color_id_273439dd_fk_variant_colors_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contributions
    ADD CONSTRAINT contributions_color_id_273439dd_fk_variant_colors_id FOREIGN KEY (color_id) REFERENCES public.variant_colors(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contributions contributions_user_id_350f1265_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contributions
    ADD CONSTRAINT contributions_user_id_350f1265_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: contributions contributions_variant_id_4e4da3a4_fk_variants_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contributions
    ADD CONSTRAINT contributions_variant_id_4e4da3a4_fk_variants_id FOREIGN KEY (variant_id) REFERENCES public.variants(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: states states_country_id_bdb47937_fk_countries_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_country_id_bdb47937_fk_countries_id FOREIGN KEY (country_id) REFERENCES public.countries(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_passkeys user_passkeys_user_id_a0f2f271_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_passkeys
    ADD CONSTRAINT user_passkeys_user_id_a0f2f271_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_tokens user_tokens_user_id_31273822_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_tokens
    ADD CONSTRAINT user_tokens_user_id_31273822_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users users_city_id_2e41ae86_fk_cities_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_city_id_2e41ae86_fk_cities_id FOREIGN KEY (city_id) REFERENCES public.cities(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_groups users_groups_group_id_2f3517aa_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users_groups
    ADD CONSTRAINT users_groups_group_id_2f3517aa_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_groups users_groups_user_id_f500bee5_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users_groups
    ADD CONSTRAINT users_groups_user_id_f500bee5_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_permissions users_user_permissio_permission_id_6d08dcd2_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users_user_permissions
    ADD CONSTRAINT users_user_permissio_permission_id_6d08dcd2_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_permissions users_user_permissions_user_id_92473840_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users_user_permissions
    ADD CONSTRAINT users_user_permissions_user_id_92473840_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: variant_colors_attachments variant_colors_attac_attachment_id_9e0f05a4_fk_attachmen; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variant_colors_attachments
    ADD CONSTRAINT variant_colors_attac_attachment_id_9e0f05a4_fk_attachmen FOREIGN KEY (attachment_id) REFERENCES public.attachments(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: variant_colors_attachments variant_colors_attac_variantcolor_id_b737b339_fk_variant_c; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variant_colors_attachments
    ADD CONSTRAINT variant_colors_attac_variantcolor_id_b737b339_fk_variant_c FOREIGN KEY (variantcolor_id) REFERENCES public.variant_colors(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: variant_colors variant_colors_variant_id_eae93791_fk_variants_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variant_colors
    ADD CONSTRAINT variant_colors_variant_id_eae93791_fk_variants_id FOREIGN KEY (variant_id) REFERENCES public.variants(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: variants_attachments variants_attachments_attachment_id_060718d8_fk_attachments_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variants_attachments
    ADD CONSTRAINT variants_attachments_attachment_id_060718d8_fk_attachments_id FOREIGN KEY (attachment_id) REFERENCES public.attachments(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: variants_attachments variants_attachments_variant_id_55c24ac8_fk_variants_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variants_attachments
    ADD CONSTRAINT variants_attachments_variant_id_55c24ac8_fk_variants_id FOREIGN KEY (variant_id) REFERENCES public.variants(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: variants variants_vehicle_id_3c4b1716_fk_vehicles_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_vehicle_id_3c4b1716_fk_vehicles_id FOREIGN KEY (vehicle_id) REFERENCES public.vehicles(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vehicles vehicles_make_id_acbaedc2_fk_makes_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_make_id_acbaedc2_fk_makes_id FOREIGN KEY (make_id) REFERENCES public.makes(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vehicles vehicles_vehicle_type_id_45741935_fk_vehicle_types_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_vehicle_type_id_45741935_fk_vehicle_types_id FOREIGN KEY (vehicle_type_id) REFERENCES public.vehicle_types(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: votes votes_contribution_id_3b396dcd_fk_contributions_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_contribution_id_3b396dcd_fk_contributions_id FOREIGN KEY (contribution_id) REFERENCES public.contributions(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: votes votes_user_id_def56ed6_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_def56ed6_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg110+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg110+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- Database "template_postgis" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg110+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg110+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: template_postgis; Type: DATABASE; Schema: -; Owner: admin
--

CREATE DATABASE template_postgis WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template_postgis OWNER TO admin;

\connect template_postgis

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: template_postgis; Type: DATABASE PROPERTIES; Schema: -; Owner: admin
--

ALTER DATABASE template_postgis IS_TEMPLATE = true;
ALTER DATABASE template_postgis SET search_path TO '$user', 'public', 'topology', 'tiger';


\connect template_postgis

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO admin;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO admin;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO admin;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: admin
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: admin
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: admin
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: admin
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: admin
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: admin
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: admin
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: topology_id_seq; Type: SEQUENCE SET; Schema: topology; Owner: admin
--

SELECT pg_catalog.setval('topology.topology_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

