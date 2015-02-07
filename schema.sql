--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: api_keys; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE api_keys (
    user_id integer NOT NULL,
    key character varying(255) NOT NULL,
    source character varying(255),
    actions integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE api_keys OWNER TO postgres;

--
-- Name: dependencies; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dependencies (
    module_id integer NOT NULL,
    dependency character varying(255) NOT NULL,
    full_dependency character varying(255) NOT NULL
);


ALTER TABLE dependencies OWNER TO postgres;

--
-- Name: downloads_daily; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE downloads_daily (
    version_id integer NOT NULL,
    date date NOT NULL,
    count integer DEFAULT 0 NOT NULL
);


ALTER TABLE downloads_daily OWNER TO postgres;

--
-- Name: endorsements; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE endorsements (
    user_id integer NOT NULL,
    module_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE endorsements OWNER TO postgres;

--
-- Name: exception_requests; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE exception_requests (
    id integer NOT NULL,
    exception_type_id integer NOT NULL,
    path text NOT NULL,
    method character varying(255) NOT NULL,
    referer text,
    ip character varying(255) NOT NULL,
    data text NOT NULL,
    msg text NOT NULL,
    trace text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE exception_requests OWNER TO postgres;

--
-- Name: exception_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE exception_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exception_requests_id_seq OWNER TO postgres;

--
-- Name: exception_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE exception_requests_id_seq OWNED BY exception_requests.id;


--
-- Name: exception_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE exception_types (
    id integer NOT NULL,
    label text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    count integer DEFAULT 0 NOT NULL
);


ALTER TABLE exception_types OWNER TO postgres;

--
-- Name: exception_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE exception_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exception_types_id_seq OWNER TO postgres;

--
-- Name: exception_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE exception_types_id_seq OWNED BY exception_types.id;


--
-- Name: github_accounts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE github_accounts (
    user_id integer NOT NULL,
    github_login text NOT NULL,
    github_user_id integer DEFAULT 0 NOT NULL,
    access_token text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE github_accounts OWNER TO postgres;

--
-- Name: lapis_migrations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lapis_migrations (
    name character varying(255) NOT NULL
);


ALTER TABLE lapis_migrations OWNER TO postgres;

--
-- Name: linked_modules; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE linked_modules (
    module_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE linked_modules OWNER TO postgres;

--
-- Name: manifest_admins; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE manifest_admins (
    user_id integer NOT NULL,
    manifest_id integer NOT NULL,
    is_owner boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE manifest_admins OWNER TO postgres;

--
-- Name: manifest_backups; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE manifest_backups (
    id integer NOT NULL,
    manifest_id integer NOT NULL,
    development boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    last_backup timestamp without time zone,
    repository_url text NOT NULL
);


ALTER TABLE manifest_backups OWNER TO postgres;

--
-- Name: manifest_backups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE manifest_backups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE manifest_backups_id_seq OWNER TO postgres;

--
-- Name: manifest_backups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE manifest_backups_id_seq OWNED BY manifest_backups.id;


--
-- Name: manifest_modules; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE manifest_modules (
    manifest_id integer NOT NULL,
    module_id integer NOT NULL,
    module_name character varying(255) NOT NULL
);


ALTER TABLE manifest_modules OWNER TO postgres;

--
-- Name: manifests; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE manifests (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    is_open boolean NOT NULL,
    display_name character varying(255),
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    modules_count integer DEFAULT 0 NOT NULL,
    versions_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE manifests OWNER TO postgres;

--
-- Name: manifests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE manifests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE manifests_id_seq OWNER TO postgres;

--
-- Name: manifests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE manifests_id_seq OWNED BY manifests.id;


--
-- Name: modules; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE modules (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    downloads integer DEFAULT 0 NOT NULL,
    current_version_id integer NOT NULL,
    summary character varying(255),
    description text,
    license character varying(255),
    homepage character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    display_name character varying(255),
    endorsements_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE modules OWNER TO postgres;

--
-- Name: modules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE modules_id_seq OWNER TO postgres;

--
-- Name: modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE modules_id_seq OWNED BY modules.id;


--
-- Name: rocks; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rocks (
    id integer NOT NULL,
    version_id integer NOT NULL,
    arch character varying(255) NOT NULL,
    downloads integer DEFAULT 0 NOT NULL,
    rock_key character varying(255) NOT NULL,
    rock_fname character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE rocks OWNER TO postgres;

--
-- Name: rocks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rocks_id_seq OWNER TO postgres;

--
-- Name: rocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rocks_id_seq OWNED BY rocks.id;


--
-- Name: user_data; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_data (
    user_id integer NOT NULL,
    email_verified boolean DEFAULT false NOT NULL,
    password_reset_token character varying(255),
    data text NOT NULL
);


ALTER TABLE user_data OWNER TO postgres;

--
-- Name: user_module_tags; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_module_tags (
    user_id integer NOT NULL,
    module_id integer NOT NULL,
    tag character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE user_module_tags OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    encrypted_password character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    flags integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE versions (
    id integer NOT NULL,
    module_id integer NOT NULL,
    version_name character varying(255) NOT NULL,
    rockspec_key character varying(255) NOT NULL,
    rockspec_fname character varying(255) NOT NULL,
    downloads integer DEFAULT 0 NOT NULL,
    rockspec_downloads integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    display_version_name character varying(255),
    lua_version character varying(255),
    development boolean DEFAULT false NOT NULL,
    source_url text
);


ALTER TABLE versions OWNER TO postgres;

--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE versions_id_seq OWNER TO postgres;

--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY exception_requests ALTER COLUMN id SET DEFAULT nextval('exception_requests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY exception_types ALTER COLUMN id SET DEFAULT nextval('exception_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY manifest_backups ALTER COLUMN id SET DEFAULT nextval('manifest_backups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY manifests ALTER COLUMN id SET DEFAULT nextval('manifests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY modules ALTER COLUMN id SET DEFAULT nextval('modules_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rocks ALTER COLUMN id SET DEFAULT nextval('rocks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY api_keys
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (key);


--
-- Name: dependencies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_pkey PRIMARY KEY (module_id, dependency);


--
-- Name: downloads_daily_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY downloads_daily
    ADD CONSTRAINT downloads_daily_pkey PRIMARY KEY (version_id, date);


--
-- Name: endorsements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY endorsements
    ADD CONSTRAINT endorsements_pkey PRIMARY KEY (user_id, module_id);


--
-- Name: exception_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY exception_requests
    ADD CONSTRAINT exception_requests_pkey PRIMARY KEY (id);


--
-- Name: exception_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY exception_types
    ADD CONSTRAINT exception_types_pkey PRIMARY KEY (id);


--
-- Name: github_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY github_accounts
    ADD CONSTRAINT github_accounts_pkey PRIMARY KEY (user_id, github_user_id);


--
-- Name: lapis_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lapis_migrations
    ADD CONSTRAINT lapis_migrations_pkey PRIMARY KEY (name);


--
-- Name: linked_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY linked_modules
    ADD CONSTRAINT linked_modules_pkey PRIMARY KEY (module_id, user_id);


--
-- Name: manifest_admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY manifest_admins
    ADD CONSTRAINT manifest_admins_pkey PRIMARY KEY (user_id, manifest_id);


--
-- Name: manifest_backups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY manifest_backups
    ADD CONSTRAINT manifest_backups_pkey PRIMARY KEY (id);


--
-- Name: manifest_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY manifest_modules
    ADD CONSTRAINT manifest_modules_pkey PRIMARY KEY (manifest_id, module_id);


--
-- Name: manifests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY manifests
    ADD CONSTRAINT manifests_pkey PRIMARY KEY (id);


--
-- Name: modules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY modules
    ADD CONSTRAINT modules_pkey PRIMARY KEY (id);


--
-- Name: rocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rocks
    ADD CONSTRAINT rocks_pkey PRIMARY KEY (id);


--
-- Name: user_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_data
    ADD CONSTRAINT user_data_pkey PRIMARY KEY (user_id);


--
-- Name: user_module_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_module_tags
    ADD CONSTRAINT user_module_tags_pkey PRIMARY KEY (user_id, module_id, tag);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: api_keys_user_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX api_keys_user_id_idx ON api_keys USING btree (user_id);


--
-- Name: exception_requests_exception_type_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX exception_requests_exception_type_id_idx ON exception_requests USING btree (exception_type_id);


--
-- Name: exception_types_label_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX exception_types_label_idx ON exception_types USING btree (label);


--
-- Name: manifest_modules_manifest_id_module_name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX manifest_modules_manifest_id_module_name_idx ON manifest_modules USING btree (manifest_id, module_name);


--
-- Name: manifest_modules_module_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX manifest_modules_module_id_idx ON manifest_modules USING btree (module_id);


--
-- Name: manifests_name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX manifests_name_idx ON manifests USING btree (name);


--
-- Name: module_search_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX module_search_idx ON modules USING gin (to_tsvector('english'::regconfig, (((((COALESCE(display_name, name))::text || ' '::text) || (COALESCE(summary, ''::character varying))::text) || ' '::text) || COALESCE(description, ''::text))));


--
-- Name: modules_downloads_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX modules_downloads_idx ON modules USING btree (downloads);


--
-- Name: modules_name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX modules_name_idx ON modules USING btree (name);


--
-- Name: modules_user_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX modules_user_id_idx ON modules USING btree (user_id);


--
-- Name: modules_user_id_name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX modules_user_id_name_idx ON modules USING btree (user_id, name);


--
-- Name: rocks_rock_fname_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX rocks_rock_fname_idx ON rocks USING btree (rock_fname);


--
-- Name: rocks_rock_key_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX rocks_rock_key_idx ON rocks USING btree (rock_key);


--
-- Name: rocks_version_id_arch_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX rocks_version_id_arch_idx ON rocks USING btree (version_id, arch);


--
-- Name: user_module_tags_module_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX user_module_tags_module_id_idx ON user_module_tags USING btree (module_id);


--
-- Name: users_flags_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX users_flags_idx ON users USING btree (flags);


--
-- Name: users_lower_email_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX users_lower_email_idx ON users USING btree (lower((email)::text));


--
-- Name: users_lower_username_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX users_lower_username_idx ON users USING btree (lower((username)::text));


--
-- Name: users_slug_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX users_slug_idx ON users USING btree (slug);


--
-- Name: versions_downloads_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX versions_downloads_idx ON versions USING btree (downloads);


--
-- Name: versions_module_id_version_name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX versions_module_id_version_name_idx ON versions USING btree (module_id, version_name);


--
-- Name: versions_rockspec_fname_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX versions_rockspec_fname_idx ON versions USING btree (rockspec_fname);


--
-- Name: versions_rockspec_key_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX versions_rockspec_key_idx ON versions USING btree (rockspec_key);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: lapis_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lapis_migrations (name) FROM stdin;
1370275336
1370277180
1393557726
1401338237
1401338238
1401600469
1401727722
1401727723
1401727724
1401810343
1408086639
1413268904
\.


--
-- PostgreSQL database dump complete
--

