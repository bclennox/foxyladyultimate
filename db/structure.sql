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
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: games; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.games (
    id integer NOT NULL,
    starts_at timestamp with time zone,
    canceled boolean DEFAULT false,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    location_id bigint NOT NULL
);


--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.games_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: good_job_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.good_job_batches (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    description text,
    serialized_properties jsonb,
    on_finish text,
    on_success text,
    on_discard text,
    callback_queue_name text,
    callback_priority integer,
    enqueued_at timestamp(6) without time zone,
    discarded_at timestamp(6) without time zone,
    finished_at timestamp(6) without time zone,
    jobs_finished_at timestamp(6) without time zone
);


--
-- Name: good_job_executions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.good_job_executions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    active_job_id uuid NOT NULL,
    job_class text,
    queue_name text,
    serialized_params jsonb,
    scheduled_at timestamp(6) without time zone,
    finished_at timestamp(6) without time zone,
    error text,
    error_event smallint,
    error_backtrace text[],
    process_id uuid,
    duration interval
);


--
-- Name: good_job_processes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.good_job_processes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    state jsonb,
    lock_type smallint
);


--
-- Name: good_job_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.good_job_settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    key text,
    value jsonb
);


--
-- Name: good_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.good_jobs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    queue_name text,
    priority integer,
    serialized_params jsonb,
    scheduled_at timestamp with time zone,
    performed_at timestamp with time zone,
    finished_at timestamp with time zone,
    error text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    active_job_id uuid,
    concurrency_key text,
    cron_key text,
    retried_good_job_id uuid,
    cron_at timestamp with time zone,
    batch_id uuid,
    batch_callback_id uuid,
    is_discrete boolean,
    executions_count integer,
    job_class text,
    error_event smallint,
    labels text[],
    locked_by_id uuid,
    locked_at timestamp(6) without time zone
);


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.locations (
    id bigint NOT NULL,
    name character varying NOT NULL,
    url character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.players (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    phone character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    access_token character varying(255),
    deleted_at timestamp with time zone,
    retired boolean DEFAULT false NOT NULL,
    short_name character varying NOT NULL
);


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.players_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.players_id_seq OWNED BY public.players.id;


--
-- Name: quips; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quips (
    id bigint NOT NULL,
    confirmation text NOT NULL,
    rejection text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: quips_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quips_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quips_id_seq OWNED BY public.quips.id;


--
-- Name: responses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.responses (
    id integer NOT NULL,
    player_id integer,
    game_id integer,
    playing boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: responses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.responses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.responses_id_seq OWNED BY public.responses.id;


--
-- Name: schedules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schedules (
    id integer NOT NULL,
    day character varying(255),
    "time" character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    location character varying(255),
    location_id bigint NOT NULL
);


--
-- Name: schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.schedules_id_seq OWNED BY public.schedules.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    smtp_password character varying NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players ALTER COLUMN id SET DEFAULT nextval('public.players_id_seq'::regclass);


--
-- Name: quips id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quips ALTER COLUMN id SET DEFAULT nextval('public.quips_id_seq'::regclass);


--
-- Name: responses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.responses ALTER COLUMN id SET DEFAULT nextval('public.responses_id_seq'::regclass);


--
-- Name: schedules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedules ALTER COLUMN id SET DEFAULT nextval('public.schedules_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: good_job_batches good_job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.good_job_batches
    ADD CONSTRAINT good_job_batches_pkey PRIMARY KEY (id);


--
-- Name: good_job_executions good_job_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.good_job_executions
    ADD CONSTRAINT good_job_executions_pkey PRIMARY KEY (id);


--
-- Name: good_job_processes good_job_processes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.good_job_processes
    ADD CONSTRAINT good_job_processes_pkey PRIMARY KEY (id);


--
-- Name: good_job_settings good_job_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.good_job_settings
    ADD CONSTRAINT good_job_settings_pkey PRIMARY KEY (id);


--
-- Name: good_jobs good_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.good_jobs
    ADD CONSTRAINT good_jobs_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: quips quips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quips
    ADD CONSTRAINT quips_pkey PRIMARY KEY (id);


--
-- Name: responses responses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.responses
    ADD CONSTRAINT responses_pkey PRIMARY KEY (id);


--
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_good_job_executions_on_active_job_id_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_job_executions_on_active_job_id_and_created_at ON public.good_job_executions USING btree (active_job_id, created_at);


--
-- Name: index_good_job_executions_on_process_id_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_job_executions_on_process_id_and_created_at ON public.good_job_executions USING btree (process_id, created_at);


--
-- Name: index_good_job_jobs_for_candidate_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_job_jobs_for_candidate_lookup ON public.good_jobs USING btree (priority, created_at) WHERE (finished_at IS NULL);


--
-- Name: index_good_job_settings_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_good_job_settings_on_key ON public.good_job_settings USING btree (key);


--
-- Name: index_good_jobs_jobs_on_finished_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_jobs_on_finished_at ON public.good_jobs USING btree (finished_at) WHERE ((retried_good_job_id IS NULL) AND (finished_at IS NOT NULL));


--
-- Name: index_good_jobs_jobs_on_priority_created_at_when_unfinished; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_jobs_on_priority_created_at_when_unfinished ON public.good_jobs USING btree (priority DESC NULLS LAST, created_at) WHERE (finished_at IS NULL);


--
-- Name: index_good_jobs_on_active_job_id_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_active_job_id_and_created_at ON public.good_jobs USING btree (active_job_id, created_at);


--
-- Name: index_good_jobs_on_batch_callback_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_batch_callback_id ON public.good_jobs USING btree (batch_callback_id) WHERE (batch_callback_id IS NOT NULL);


--
-- Name: index_good_jobs_on_batch_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_batch_id ON public.good_jobs USING btree (batch_id) WHERE (batch_id IS NOT NULL);


--
-- Name: index_good_jobs_on_concurrency_key_when_unfinished; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_concurrency_key_when_unfinished ON public.good_jobs USING btree (concurrency_key) WHERE (finished_at IS NULL);


--
-- Name: index_good_jobs_on_cron_key_and_created_at_cond; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_cron_key_and_created_at_cond ON public.good_jobs USING btree (cron_key, created_at) WHERE (cron_key IS NOT NULL);


--
-- Name: index_good_jobs_on_cron_key_and_cron_at_cond; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_good_jobs_on_cron_key_and_cron_at_cond ON public.good_jobs USING btree (cron_key, cron_at) WHERE (cron_key IS NOT NULL);


--
-- Name: index_good_jobs_on_labels; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_labels ON public.good_jobs USING gin (labels) WHERE (labels IS NOT NULL);


--
-- Name: index_good_jobs_on_locked_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_locked_by_id ON public.good_jobs USING btree (locked_by_id) WHERE (locked_by_id IS NOT NULL);


--
-- Name: index_good_jobs_on_priority_scheduled_at_unfinished_unlocked; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_priority_scheduled_at_unfinished_unlocked ON public.good_jobs USING btree (priority, scheduled_at) WHERE ((finished_at IS NULL) AND (locked_by_id IS NULL));


--
-- Name: index_good_jobs_on_queue_name_and_scheduled_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_queue_name_and_scheduled_at ON public.good_jobs USING btree (queue_name, scheduled_at) WHERE (finished_at IS NULL);


--
-- Name: index_good_jobs_on_scheduled_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_good_jobs_on_scheduled_at ON public.good_jobs USING btree (scheduled_at) WHERE (finished_at IS NULL);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON public.schema_migrations USING btree (version);


--
-- Name: schedules fk_rails_adb60b2104; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT fk_rails_adb60b2104 FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: games fk_rails_d35c8ddede; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT fk_rails_d35c8ddede FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20250629163432'),
('20250629140837'),
('20250217032902'),
('20250217031314'),
('20250217031313'),
('20250217031312'),
('20250217031311'),
('20250217031310'),
('20250217031309'),
('20250217031308'),
('20250217031307'),
('20250217031306'),
('20240830114043'),
('20240830114042'),
('20231116123629'),
('20231115031846'),
('20231115031845'),
('20231115031844'),
('20231115031843'),
('20231115031842'),
('20231109021740'),
('20231109021632'),
('20230118030156'),
('20230118030155'),
('20230118030154'),
('20230117035511'),
('20230114191236'),
('20210115040650'),
('20210112035156'),
('20210112035103'),
('20150404030021'),
('20141228163853'),
('20141228163852'),
('20130529023505'),
('20130216181708'),
('20130131211059'),
('20130129221821'),
('20130129185309'),
('20130126210524'),
('20130126202957'),
('20130123043730'),
('20130123034111'),
('20130123020547');

