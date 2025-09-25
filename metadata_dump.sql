--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22
-- Dumped by pg_dump version 12.22

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activity; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.activity (
    id text NOT NULL,
    "timestamp" timestamp without time zone,
    user_id text,
    object_id text,
    revision_id text,
    activity_type text,
    data text
);


ALTER TABLE public.activity OWNER TO ckan;

--
-- Name: activity_detail; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.activity_detail (
    id text NOT NULL,
    activity_id text,
    object_id text,
    object_type text,
    activity_type text,
    data text
);


ALTER TABLE public.activity_detail OWNER TO ckan;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO ckan;

--
-- Name: api_token; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.api_token (
    id text NOT NULL,
    name text,
    user_id text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_access timestamp without time zone,
    plugin_extras jsonb
);


ALTER TABLE public.api_token OWNER TO ckan;

--
-- Name: dashboard; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.dashboard (
    user_id text NOT NULL,
    activity_stream_last_viewed timestamp without time zone NOT NULL,
    email_last_sent timestamp without time zone DEFAULT LOCALTIMESTAMP NOT NULL
);


ALTER TABLE public.dashboard OWNER TO ckan;

--
-- Name: group; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public."group" (
    id text NOT NULL,
    name text NOT NULL,
    title text,
    description text,
    created timestamp without time zone,
    state text,
    type text NOT NULL,
    approval_status text,
    image_url text,
    is_organization boolean DEFAULT false
);


ALTER TABLE public."group" OWNER TO ckan;

--
-- Name: group_extra; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.group_extra (
    id text NOT NULL,
    group_id text,
    key text,
    value text,
    state text
);


ALTER TABLE public.group_extra OWNER TO ckan;

--
-- Name: group_extra_revision; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.group_extra_revision (
    id text NOT NULL,
    group_id text,
    key text,
    value text,
    state text,
    revision_id text NOT NULL,
    continuity_id text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean
);


ALTER TABLE public.group_extra_revision OWNER TO ckan;

--
-- Name: group_revision; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.group_revision (
    id text NOT NULL,
    name text NOT NULL,
    title text,
    description text,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    state text,
    revision_id text NOT NULL,
    continuity_id text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean,
    type text NOT NULL,
    approval_status text,
    image_url text,
    is_organization boolean DEFAULT false
);


ALTER TABLE public.group_revision OWNER TO ckan;

--
-- Name: member; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.member (
    id text NOT NULL,
    group_id text,
    table_id text NOT NULL,
    state text,
    table_name text NOT NULL,
    capacity text NOT NULL
);


ALTER TABLE public.member OWNER TO ckan;

--
-- Name: member_revision; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.member_revision (
    id text NOT NULL,
    table_id text NOT NULL,
    group_id text,
    state text,
    revision_id text NOT NULL,
    continuity_id text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean,
    table_name text NOT NULL,
    capacity text NOT NULL
);


ALTER TABLE public.member_revision OWNER TO ckan;

--
-- Name: package; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.package (
    id text NOT NULL,
    name character varying(100) NOT NULL,
    title text,
    version character varying(100),
    url text,
    notes text,
    author text,
    author_email text,
    maintainer text,
    maintainer_email text,
    state text,
    license_id text,
    type text,
    owner_org text,
    private boolean DEFAULT false,
    metadata_modified timestamp without time zone,
    creator_user_id text,
    metadata_created timestamp without time zone,
    plugin_data jsonb
);


ALTER TABLE public.package OWNER TO ckan;

--
-- Name: package_extra; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.package_extra (
    id text NOT NULL,
    key text,
    value text,
    state text,
    package_id text
);


ALTER TABLE public.package_extra OWNER TO ckan;

--
-- Name: package_extra_revision; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.package_extra_revision (
    id text NOT NULL,
    key text,
    value text,
    revision_id text NOT NULL,
    state text,
    package_id text,
    continuity_id text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean
);


ALTER TABLE public.package_extra_revision OWNER TO ckan;

--
-- Name: package_member; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.package_member (
    package_id text NOT NULL,
    user_id text NOT NULL,
    capacity text NOT NULL,
    modified timestamp without time zone NOT NULL
);


ALTER TABLE public.package_member OWNER TO ckan;

--
-- Name: package_relationship; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.package_relationship (
    id text NOT NULL,
    subject_package_id text,
    object_package_id text,
    type text,
    comment text,
    state text
);


ALTER TABLE public.package_relationship OWNER TO ckan;

--
-- Name: package_relationship_revision; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.package_relationship_revision (
    id text NOT NULL,
    subject_package_id text,
    object_package_id text,
    type text,
    comment text,
    revision_id text NOT NULL,
    continuity_id text,
    state text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean
);


ALTER TABLE public.package_relationship_revision OWNER TO ckan;

--
-- Name: package_revision; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.package_revision (
    id text NOT NULL,
    name character varying(100) NOT NULL,
    title text,
    version character varying(100),
    url text,
    notes text,
    author text,
    author_email text,
    maintainer text,
    maintainer_email text,
    revision_id text NOT NULL,
    state text,
    continuity_id text,
    license_id text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean,
    type text,
    owner_org text,
    private boolean DEFAULT false,
    metadata_modified timestamp without time zone,
    creator_user_id text,
    metadata_created timestamp without time zone
);


ALTER TABLE public.package_revision OWNER TO ckan;

--
-- Name: package_tag; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.package_tag (
    id text NOT NULL,
    state text,
    package_id text,
    tag_id text
);


ALTER TABLE public.package_tag OWNER TO ckan;

--
-- Name: package_tag_revision; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.package_tag_revision (
    id text NOT NULL,
    revision_id text NOT NULL,
    state text,
    package_id text,
    tag_id text,
    continuity_id text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean
);


ALTER TABLE public.package_tag_revision OWNER TO ckan;

--
-- Name: rating; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.rating (
    id text NOT NULL,
    user_id text,
    user_ip_address text,
    rating double precision,
    created timestamp without time zone,
    package_id text
);


ALTER TABLE public.rating OWNER TO ckan;

--
-- Name: resource; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.resource (
    id text NOT NULL,
    url text NOT NULL,
    format text,
    description text,
    "position" integer,
    hash text,
    state text,
    extras text,
    name text,
    resource_type text,
    mimetype text,
    mimetype_inner text,
    size bigint,
    last_modified timestamp without time zone,
    cache_url text,
    cache_last_updated timestamp without time zone,
    webstore_url text,
    webstore_last_updated timestamp without time zone,
    created timestamp without time zone,
    url_type text,
    package_id text DEFAULT ''::text NOT NULL,
    metadata_modified timestamp without time zone
);


ALTER TABLE public.resource OWNER TO ckan;

--
-- Name: resource_revision; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.resource_revision (
    id text NOT NULL,
    url text NOT NULL,
    format text,
    description text,
    "position" integer,
    revision_id text NOT NULL,
    hash text,
    state text,
    continuity_id text,
    extras text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean,
    name text,
    resource_type text,
    mimetype text,
    mimetype_inner text,
    size bigint,
    last_modified timestamp without time zone,
    cache_url text,
    cache_last_updated timestamp without time zone,
    webstore_url text,
    webstore_last_updated timestamp without time zone,
    created timestamp without time zone,
    url_type text,
    package_id text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.resource_revision OWNER TO ckan;

--
-- Name: resource_view; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.resource_view (
    id text NOT NULL,
    resource_id text,
    title text,
    description text,
    view_type text NOT NULL,
    "order" integer NOT NULL,
    config text
);


ALTER TABLE public.resource_view OWNER TO ckan;

--
-- Name: revision; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.revision (
    id text NOT NULL,
    "timestamp" timestamp without time zone,
    author character varying(200),
    message text,
    state text,
    approved_timestamp timestamp without time zone
);


ALTER TABLE public.revision OWNER TO ckan;

--
-- Name: system_info; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.system_info (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    value text,
    state text DEFAULT 'active'::text NOT NULL
);


ALTER TABLE public.system_info OWNER TO ckan;

--
-- Name: system_info_id_seq; Type: SEQUENCE; Schema: public; Owner: ckan
--

CREATE SEQUENCE public.system_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.system_info_id_seq OWNER TO ckan;

--
-- Name: system_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ckan
--

ALTER SEQUENCE public.system_info_id_seq OWNED BY public.system_info.id;


--
-- Name: system_info_revision; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.system_info_revision (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    value text,
    revision_id text NOT NULL,
    continuity_id integer,
    state text DEFAULT 'active'::text NOT NULL,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean
);


ALTER TABLE public.system_info_revision OWNER TO ckan;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.tag (
    id text NOT NULL,
    name character varying(100) NOT NULL,
    vocabulary_id character varying(100)
);


ALTER TABLE public.tag OWNER TO ckan;

--
-- Name: task_status; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.task_status (
    id text NOT NULL,
    entity_id text NOT NULL,
    entity_type text NOT NULL,
    task_type text NOT NULL,
    key text NOT NULL,
    value text NOT NULL,
    state text,
    error text,
    last_updated timestamp without time zone
);


ALTER TABLE public.task_status OWNER TO ckan;

--
-- Name: term_translation; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.term_translation (
    term text NOT NULL,
    term_translation text NOT NULL,
    lang_code text NOT NULL
);


ALTER TABLE public.term_translation OWNER TO ckan;

--
-- Name: tracking_raw; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.tracking_raw (
    user_key character varying(100) NOT NULL,
    url text NOT NULL,
    tracking_type character varying(10) NOT NULL,
    access_timestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tracking_raw OWNER TO ckan;

--
-- Name: tracking_summary; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.tracking_summary (
    url text NOT NULL,
    package_id text,
    tracking_type character varying(10) NOT NULL,
    count integer NOT NULL,
    running_total integer DEFAULT 0 NOT NULL,
    recent_views integer DEFAULT 0 NOT NULL,
    tracking_date date
);


ALTER TABLE public.tracking_summary OWNER TO ckan;

--
-- Name: user; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public."user" (
    id text NOT NULL,
    name text NOT NULL,
    apikey text,
    created timestamp without time zone,
    about text,
    password text,
    fullname text,
    email text,
    reset_key text,
    sysadmin boolean DEFAULT false,
    activity_streams_email_notifications boolean DEFAULT false,
    state text DEFAULT 'active'::text NOT NULL,
    plugin_extras jsonb,
    image_url text,
    last_active timestamp without time zone
);


ALTER TABLE public."user" OWNER TO ckan;

--
-- Name: user_following_dataset; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.user_following_dataset (
    follower_id text NOT NULL,
    object_id text NOT NULL,
    datetime timestamp without time zone NOT NULL
);


ALTER TABLE public.user_following_dataset OWNER TO ckan;

--
-- Name: user_following_group; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.user_following_group (
    follower_id text NOT NULL,
    object_id text NOT NULL,
    datetime timestamp without time zone NOT NULL
);


ALTER TABLE public.user_following_group OWNER TO ckan;

--
-- Name: user_following_user; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.user_following_user (
    follower_id text NOT NULL,
    object_id text NOT NULL,
    datetime timestamp without time zone NOT NULL
);


ALTER TABLE public.user_following_user OWNER TO ckan;

--
-- Name: vocabulary; Type: TABLE; Schema: public; Owner: ckan
--

CREATE TABLE public.vocabulary (
    id text NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.vocabulary OWNER TO ckan;

--
-- Name: system_info id; Type: DEFAULT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.system_info ALTER COLUMN id SET DEFAULT nextval('public.system_info_id_seq'::regclass);


--
-- Data for Name: activity; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.activity (id, "timestamp", user_id, object_id, revision_id, activity_type, data) FROM stdin;
\.


--
-- Data for Name: activity_detail; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.activity_detail (id, activity_id, object_id, object_type, activity_type, data) FROM stdin;
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.alembic_version (version_num) FROM stdin;
9f33a0280c51
\.


--
-- Data for Name: api_token; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.api_token (id, name, user_id, created_at, last_access, plugin_extras) FROM stdin;
fsK0uu1sceu6kxq7cm1SbAfRzuXFqzoZqM2ffmTQLIo	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 13:41:20.32812	\N	\N
RBIfhznWUDsFVrJ6GwX98hZNoEy2QjZEuOTXOpJ2On8	local_token	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 13:45:00.898517	\N	\N
wzkK52c0uor6BDBof50RU7oD8virUZ4IKGfjNcUt--w	institutions-sync-token	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 13:54:59.155104	2025-09-22 16:21:48.087628	\N
drDi6FpCf69xTUr3vIQeIWlbP6_BBAYZliquH1VL0Z0	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 17:45:14.609784	\N	\N
QH0GoXWBKvlFjGv6QkiOVFwt10QXW-J36MCwp0dI0n8	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 17:47:47.338492	\N	\N
PaJ5zRU_Im_E5-E4O5y-cwSlwka3BncfdapbDZva3rE	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 17:54:49.421122	\N	\N
k0Na1V5XbL0RbfZtLvYM2dQUI-qrZ-93VUwKYJJd0Kw	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 18:10:14.784788	\N	\N
EFS9Zhcam2Uze5mNGxl9fk5OX0BL_UHOM-hd4u0DysI	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 18:22:02.447772	\N	\N
9soCsQxxk-ksUa3tEX9PAocKnG_7u-qMjMfYle5LDSU	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 18:24:35.306356	\N	\N
yGjs1Ea4hro4SOvqN8T9SNhLzTtsqEqhPL1bK_Hl4Yo	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 18:28:57.78146	\N	\N
l9zdhnn2n_ufSeOQL7FIZ59FXptYQZgH8QbqwfZoXns	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 18:32:41.295631	\N	\N
3yhMzWD5Gkrg_OKA441sGiYcBDTVqD0ucujg4HcsyWs	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 18:37:29.649013	\N	\N
aPQeVhJFpV2HdEZZ52EKVah0vfKlutwp-WdEpO3f_UI	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 18:44:50.909262	\N	\N
WJiig5m6lffHms135QNJsk16hctyuRUIarY3neqDfXI	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 19:00:34.18784	\N	\N
Jyr2-kLc0N9c3UrEanQBniBfOzHBJUOI5_Ri4Cky3PA	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 19:06:08.140738	\N	\N
H_Fdne6ZWt0IXPd9wFKjxEzoLX_YcIkY95yS0kWE5cU	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 19:10:33.620962	\N	\N
KONuBXO3uByRvEspxPOXmwg8EfTo4zqiZTBJlX56xuc	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 19:14:44.565484	\N	\N
q6UhXauJEgMCZn0Ka3IihZ2tLgcQRk9Vz0T9OgQlwL8	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 19:57:35.706006	\N	\N
S23_MzuZ5YT2EmU7J0CxC_Qd0U-r2l0qPUQFF4OS7Ks	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 20:27:37.44159	\N	\N
QN6b24B1Nb1tUEZQRUvb20NW1PD_UdSTAeEcqyTzbrs	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 20:32:05.363693	\N	\N
FpNwg6PQdQB8oXbSTJFj7F4qwRQRdDnDy_UX01Og-HI	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 20:37:48.74139	\N	\N
5B4HAbBAaEI-fsYt338wNx0ccF50MbsPX9OM1gvtzWY	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 20:43:48.606396	\N	\N
sK1fd9CvBey_QV564NDQ_1Ec4bwp1P5aJYB6JQ2jE-c	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 21:45:42.938956	\N	\N
kEJYTbHO43whU_vdLlkEeMnEIqMalfhrsdhx1r87czY	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 12:49:13.771243	\N	\N
-3wlHcwnnF3elZciKOPqAsTqdBjjx14JirIn1k6ecCQ	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 12:53:13.868274	\N	\N
d6TNTkqyd_JYdDKaxTKDCPgmm-P39kcv7DmtEEcWBm8	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 13:39:21.909123	\N	\N
MhcHaLud6eRuc6aLAOaPhW8gD3z2gFQEWXKO_hSafUU	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 13:50:12.375942	\N	\N
6KIJ98cU6iVMimVnfrukx1Dn5IMpewVOyv_PGU4seqY	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 14:03:36.05417	\N	\N
StMiWWvU7bop1IzcyYzYgFOcO6waOGRvqihkhfxoLew	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 14:14:12.277891	\N	\N
q5fQ875pR2DjNn1Zfb5tNQ5A_KH3e4UgFmBFgY0-DzA	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 14:50:35.999482	\N	\N
NJk8RKy6VEgGbVXZHsi8wV4aPhDmWDd3RtI40kU-1Sw	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 15:03:48.466776	\N	\N
TYGNqc07ca7VQNdmDP1u-xdxVod3JSM1h7c77dNhpws	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 16:12:52.308819	\N	\N
2fH0oLaHUYoSmO154F3L6DA3QfQrGlFTY_VbFQ1l15o	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 16:21:20.305808	\N	\N
Did5jBl0rLXw-CnraS_GJCqGUjXut91Dn13iFfB7pLg	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 16:22:59.100841	\N	\N
2EvUwGyQgyIBxa001AYmgYJmB-Rx7fEnQZk1RLXNUFs	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 16:25:32.84031	\N	\N
vhUNA3Db7QWDj-Ucs_WyILlHCHf2O8X3EgACKWx7p0U	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 16:30:44.836517	\N	\N
kHJTorMHKBIg6O0lGuv19L63UVArgyU3Z5YTV9zOtBA	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 16:36:22.760365	\N	\N
dp6AKHXVMvAxnNpw54zQtC_vCgbefmF-2Ju2TS2MapI	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 16:41:25.425946	\N	\N
ylP7L1nXa9twoUEI6n93EPjYMf35KafLD9yuWvqcEUo	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 16:48:53.275692	\N	\N
cU9TN1t0eN6wAaYliwXikiHtxFH0kwrT4FbM6LGJ8_s	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 13:59:11.829291	\N	\N
Yzn4YaXDcl_2_9H6Bm77dd26jwOGCLF6wOklQZH7pn4	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 16:34:25.00043	\N	\N
S3SVJlqQ2L8JSHG7_EbKHNbQ7ivYW0y8Wih3PU_dq_4	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 16:37:23.174578	\N	\N
F1Sht5FKdzrYpxFRcd_uNcGGfry-PL1IVlSmTVqfMLg	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 16:54:50.777234	\N	\N
PVEGxxnx2cOd--2K4UruI5gBZV1VvXPKQujephLd62Y	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 17:07:06.857145	\N	\N
g8D4ApO8X11ceRVODlkITLMe83pWLV3dD-d8b3s78nc	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 17:18:14.980348	\N	\N
fdvrkkh00oykcX7pE-MUpjG8iPd1VND8gMh3a2-USho	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 17:25:54.111591	\N	\N
HneXXJbpuGUpBg46KkCYfsndphwscHH27JISuEVPPaY	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 17:40:48.543314	\N	\N
cEQEoZg7TPaStR-IJQ19QxV3YdjtJCwDWkHQUW-zIKs	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 17:45:33.516784	\N	\N
C_E0QyaQvCx8cE87ViVHuM_nYU42J_UJC--oLC71HzI	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 17:50:37.731301	\N	\N
BZL9_o6CvtHh1Wv3wb_riGwG8Bqfdq9PCjo8Gx_i0fM	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 17:55:48.285304	\N	\N
krdvJXMMHb4_W3ZpE-jpsNYEVb9mFLaFeO69lY8Wb5I	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 18:00:07.794656	\N	\N
70hpicKRNOkWJH1uj8Yr06ONC5hSLgrgwHbgx09DWUc	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 18:21:43.315071	\N	\N
vGw3L44Vcvu0I0gs6bQt-P0Mbr1awXp1a_Asm6h359k	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 18:24:50.351593	\N	\N
oGbv3LdMjFPEqTxyetj30QR2uOQ-ULL1IhuEdZRTh1k	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 18:27:33.734846	\N	\N
oZGD2OLNS499R5qmGOuJIu9StzLxIyXSr929hi2Whg0	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 18:29:22.339369	\N	\N
5zF9iwcL1QYPLDXV1WpyYMGSp6lxyFQs2_PRbxZKEdQ	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 18:34:02.816545	\N	\N
yNE0yD5rdxfwNDC3Y1D1aBcTX4Z7U8v6Z1WOtWeDM0Q	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 18:54:02.176347	\N	\N
IiNrWo65xWkgJDH8555n4oU1yd9hpowq9GARhjNAPkk	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 19:17:11.305641	\N	\N
EsOANS-k8Q9grVkmZ-bt76VUJmhqtCO3lI6wXrLO9ag	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 19:20:19.259912	\N	\N
-35H40v9qrTlUyfjuFdn63xHJKBVRqcA1a-FebwYx1o	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 19:24:26.104851	\N	\N
Tv3LFIWCLViaIPVWqyemnK-P_1XhI669kGcn89J6qNg	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 20:18:22.176944	\N	\N
U0luDpTE7dZC-oqmKeNTBZUWsY5EEzYeW9if6mMaVrE	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 20:21:10.86702	\N	\N
-DRl5Lcs2zMRnycUWQo7XqMF12bLlSzEb91aEuyR4uo	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 20:29:23.753797	\N	\N
sxSM1AUHTHD-GSomCSX0NWEEq3hihOS9AWJ6bna--ek	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 20:33:11.374516	\N	\N
z6VTx-tyS-ECodEXO9DTCSaRtiP6osqBW2vct0kvph0	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 20:46:13.513317	\N	\N
GYF6VO6MsfOCJMhKf-64oWfAODHFmuH4igxI2L8mPs8	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 20:54:04.670062	\N	\N
lFkuZcyKNsc4tSuUA4Ptn6NeKbarRE68tSFOI5imeMc	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 20:55:42.773957	\N	\N
AG3clyOdE6LKD0j4QbUF7rXDpcmG0eqxThx9AcjR-8w	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 20:57:41.352718	\N	\N
5TodWDyMs3zwlPwLa_8xOGTHmrDvdFL3LZpfIX7g130	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 21:01:43.24398	\N	\N
X1tsNv_YSdB1JPj8vDsHEAMI9gS2wSyTUs6cY5PRFwc	datapusher	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 21:07:13.431489	\N	\N
\.


--
-- Data for Name: dashboard; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.dashboard (user_id, activity_stream_last_viewed, email_last_sent) FROM stdin;
7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 13:41:13.220528	2025-09-22 13:41:13.220535
\.


--
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public."group" (id, name, title, description, created, state, type, approval_status, image_url, is_organization) FROM stdin;
39e5a7fa-96cb-4c1b-b05d-825db0801594	koninklijk-belgisch-instituut-voor-natuurwetenschappen	Koninklijk Belgisch Instituut voor Natuurwetenschappen		2025-09-22 13:56:27.222437	active	group	approved		f
52bd6a8e-a044-480d-8c86-9aeb135dd4f7	british-antarctic-survey	British Antarctic Survey		2025-09-22 13:56:28.91122	active	group	approved		f
f3c05b89-ae29-4798-b851-3f847333d9eb	macquarie-university-department-of-biological-sciences	Macquarie University – Department of Biological Sciences		2025-09-22 13:56:30.632975	active	group	approved		f
0e9ea7d9-b300-44a1-aea5-e1e0b9fd9644	universite-libre-de-bruxelles	Université Libre de Bruxelles		2025-09-22 13:56:32.551826	active	group	approved		f
6dfb3459-5fdd-487c-a001-1e63d3318100	sir-alister-hardy-foundation-for-ocean-science	Sir Alister Hardy Foundation for Ocean Science		2025-09-22 13:56:34.599126	active	group	approved		f
75876ec7-e686-4240-a1ce-2a9cdf5929ee	alfred-wegener-institut-helmholtz-zentrum-fur-polar-und-meeresforschung	Alfred-Wegener-Institut (Helmholtz-Zentrum für Polar- und Meeresforschung)		2025-09-22 13:56:36.317558	active	group	approved		f
293b388d-43d1-41b9-874f-3594204df05c	sorbonne-universite	Sorbonne Université		2025-09-22 13:56:37.996747	active	group	approved		f
d4543bd1-9877-4ca6-b088-6811839e3991	antarctic-climate-ecosystems-cooperative-research-centre	Antarctic Climate & Ecosystems Cooperative Research Centre		2025-09-22 13:56:39.704045	active	group	approved		f
a390a520-185a-498f-b7e1-1f3955bcc910	unviersite-libre-de-bruxelles-laboratoire-de-biologie-marine	Unviersité Libre de Bruxelles — Laboratoire de Biologie Marine		2025-09-22 13:56:41.482857	active	group	approved		f
a28f25a4-fea1-4e38-9f10-10dfeffe6910	oregon-state-university-hatfield-marine-science-center	Oregon State University, Hatfield Marine Science Center		2025-09-22 13:56:43.210919	active	group	approved		f
2be97b83-283e-4bd3-906a-67b3a393c11e	university-of-california-santa-cruz-department-of-ecology-and-evolutionary-biology	University of California Santa Cruz, Department of Ecology and Evolutionary Biology		2025-09-22 13:56:44.892982	active	group	approved		f
264f6298-0e34-43a8-bf68-b28a235fbc8e	universiteit-antwerpen	Universiteit Antwerpen		2025-09-22 13:56:46.594355	active	group	approved		f
8dc59986-db13-4f28-8e67-a935b692e707	sistema-de-informacion-sobre-biodiversidad-de-colombia-sib-colombia	Sistema de Información sobre Biodiversidad de Colombia - SiB Colombia		2025-09-22 13:56:48.287833	active	group	approved		f
ff8aa929-7052-48b5-b09d-18cdb9c7a0dc	fisheries-and-oceans-canada-bedford-institute-of-oceanography	Fisheries and Oceans Canada – Bedford Institute of Oceanography		2025-09-22 13:56:50.005938	active	group	approved		f
3a427c28-8873-4307-87d9-e9adbe837138	joint-nature-conservation-committee	Joint Nature Conservation Committee		2025-09-22 13:56:51.700599	active	group	approved		f
3a4aa10f-a20e-4dc7-b841-554397287ff7	institut-francais-de-recherche-pour-lexploitation-de-la-mer-ifremer-centre-de-brest	Institut Français de Recherche pour l'Exploitation de la Mer, IFREMER, Centre de Brest		2025-09-22 13:56:53.398839	active	group	approved		f
e641c794-b901-4796-8f84-1c560bed38ee	noaa-southeast-fisheries-science-center-national-marine-fisheries-service-southeast-miami-laboratory	NOAA, Southeast Fisheries Science Center, National Marine Fisheries Service Southeast Miami Laboratory		2025-09-22 13:56:55.146679	active	group	approved		f
95785cd3-73db-4b63-939a-436a66050fab	integrated-marine-observing-system	Integrated Marine Observing System		2025-09-22 13:56:56.922155	active	group	approved		f
bacaf6cf-7a04-447d-9e0a-c60078e8fb8c	cornell-university	Cornell University		2025-09-22 13:56:58.604146	active	group	approved		f
9897699d-0fd1-4ad4-8358-eccee53d8384	rosenstiel-school-of-marine-atmospheric-science-university-of-miami	Rosenstiel School of Marine & Atmospheric Science, University of Miami		2025-09-22 13:57:00.303817	active	group	approved		f
6810f491-2ccf-49fe-92c0-0ccdb7b214fb	sveriges-meteorologiska-och-hydrologiska-institut	Sveriges meteorologiska och hydrologiska institut		2025-09-22 13:57:01.997254	active	group	approved		f
1b8c14b9-2b90-4d42-9c90-b78d5c1c1177	woods-hole-oceanographic-institution	Woods Hole Oceanographic Institution		2025-09-22 13:57:03.764811	active	group	approved		f
b05309c2-88ee-45c5-9bc8-a71f5ec8b9d7	deltares	Deltares		2025-09-22 13:57:05.599912	active	group	approved		f
2ae535d8-068b-4da4-8c87-5f587fa81715	gulf-of-mexico-coastal-ocean-observing-system	Gulf of Mexico Coastal Ocean Observing System		2025-09-22 13:57:07.367003	active	group	approved		f
06ea9a4a-38e1-4eae-a9e8-dde613cc96c4	pacific-islands-ocean-observing-system	Pacific Islands Ocean Observing System		2025-09-22 13:57:09.234136	active	group	approved		f
fe44c029-cb97-41a9-99e7-2dcfc88f187c	university-of-tasmania-institute-for-marine-and-antarctic-studies	University of Tasmania, Institute for Marine and Antarctic Studies		2025-09-22 13:57:10.960072	active	group	approved		f
7e174027-29cb-4598-81bd-e70d298243e7	natural-resources-wales	Natural Resources Wales		2025-09-22 13:57:12.663505	active	group	approved		f
da452a4a-f160-4367-9289-1fdcc49e87ee	james-cook-university-townsville	James Cook University, Townsville		2025-09-22 13:57:14.333932	active	group	approved		f
6482c50d-b486-4dfd-9a3b-71b0f551db2b	northwest-atlantic-fisheries-centre-dfo-nwafc-fisheries-and-oceans-canada	Northwest Atlantic Fisheries Centre (DFO – NWAFC), Fisheries and Oceans Canada		2025-09-22 13:57:16.032946	active	group	approved		f
be1c91b6-bd6a-4374-a097-d8974586b1c3	institut-francais-de-recherche-pour-lexploitation-de-la-mer-ifremer-centre-de-nantes	Institut Français de Recherche pour l'Exploitation de la Mer,  IFREMER, Centre de Nantes		2025-09-22 13:57:17.733303	active	group	approved		f
275c6efa-aabf-4f30-972a-a1a5bdf4a526	finnish-environment-institute	Finnish Environment Institute		2025-09-22 13:57:19.410047	active	group	approved		f
0c4a0415-9ef9-4b50-9f55-33e10dac20ef	australian-museum	Australian Museum		2025-09-22 13:57:21.094722	active	group	approved		f
a2b5f56d-0cd5-415f-b839-726896209e41	radboud-university	Radboud University		2025-09-22 13:57:22.761196	active	group	approved		f
ea8f768b-9884-459b-8895-68489faa3d1d	boston-university-department-of-biology	Boston University, Department of Biology		2025-09-22 13:57:24.415405	active	group	approved		f
ef095ef5-d3a6-446b-beb5-eae3e3066aff	national-museum-of-natural-history-smithsonian-institution	National Museum of Natural History, Smithsonian Institution		2025-09-22 13:57:26.153799	active	group	approved		f
6a0220c4-d2c2-4453-99ae-f89ca5907538	afrobis	AfrOBIS		2025-09-22 13:57:37.917411	active	organization	approved		t
564d4b37-c5a3-4a4a-8585-acaacf0134b3	antarctic-obis	Antarctic OBIS	The OBIS node for Antarctica is run by the Royal Belgian Institute of Natural Sciences (RBINS) under the aegis of the Scientific Committee on Antarctic Research (SCAR). 	2025-09-22 13:57:38.005332	active	organization	approved		t
b73c7e06-2936-4b03-97a0-be42125a5587	university-of-california-san-diego-scripps-institution-of-oceanography	University of California, San Diego, Scripps Institution of Oceanography		2025-09-22 14:07:01.370411	active	group	approved		f
841fb472-2474-434f-8f23-b46aeb320c24	canadian-wildlife-service-quebec-region	Canadian Wildlife Service - Quebec Region		2025-09-22 14:07:03.167537	active	group	approved		f
365ac034-63ba-4116-b87f-8bd8c34e6b40	arctic-obis	Arctic OBIS	The Arctic Biodiversity Data Service (ABDS) is the data-management framework for the Conservation of Arctic Flora and Fauna (CAFF), the biodiversity working group of the Arctic Council, and its programs and activities including the Circumpolar Biodiversity Monitoring Programme (CBMP). It is an online, interoperable data management system that serves as a focal point and common platform for all CAFF programs and projects as well as a dynamic source for up-to-date circumpolar Arctic biodiversity information and emerging trends.\n\nThe goal of the ABDS is to increase access to Arctic biodiversity data for the common good of scientists, policy makers and other stakeholders both inside and outside of the Arctic. It is intended to allow for discovery, archiving and access to data at various scales. Such a framework is essential to ensure effective, consistent, and long-term management of Arctic Biodiversity data.	2025-09-22 13:57:38.091813	active	organization	approved		t
6bab9702-e011-417e-aa58-2adedd1d0a72	caribbean-obis	Caribbean OBIS	The Caribbean Regional Node for OBIS serves the Caribbean region, centralizing and curating the regional datasets.  We also provide training courses and technical advise in the wider Caribbean, Central and South America in Spanish. The operative center is located at the Universidad Simón Bolívar, Caracas, Venezuela which partially supports the node as an academic activity.	2025-09-22 13:57:38.179357	active	organization	approved		t
3e117d1c-778e-4aca-9b34-b294399a2947	esp-obis	ESP OBIS		2025-09-22 13:57:38.268676	active	organization	approved		t
55650f16-ddc3-4321-a692-f71569ac5472	eurobis	EurOBIS	EurOBIS - the European Node of the international Ocean Biodiversity Information System (OBIS) - publishes distribution data on marine species, collected within European marine waters or collected by European researchers outside European marine waters.	2025-09-22 13:57:38.38672	active	organization	approved		t
c2a5adb7-d4eb-45d8-bb4c-d967b2dc1b0b	fish-obis	Fish OBIS	FishNet2 and FishBase together are the new global thematic Fish OBIS node. FishNet2 will provide specimen-vouchered occurrences and data derived from specimens, and FishBase will provide occurrence data gathered through trawling surveys, ecological monitoring etc. 	2025-09-22 13:57:38.487497	active	organization	approved		t
5df18ad4-0207-4834-a1a6-1942c73dcb33	hab-obis	HAB OBIS	The OBIS HAB node is a thematic node compiling and processiong data on occurrence of toxin producing micro-algae species and their impacts on ecosystems and human activity. The node covers the species included in the IOC-UNESCO Taxonomic Reference List of Harmful Micro Algae at http://www.marinespecies.org/hab/index.php. It is supported by a network of editors covering specific regions. In a first phase the editors are primarily harvesting the literature for known occurrences in order to have a base line data set in OBIS on toxic microalgae which will serve to validate occurrence data from larger data sets and time series in OBIS. This specific data set on toxic micro-alge will provide an important data basis for the first Global Harmful Algal Bloom Status Report.  	2025-09-22 13:57:38.584651	active	organization	approved		t
e45382da-08cb-4943-a10a-66c1707c10a5	indobis	IndOBIS	The Indian Ocean Biodiversity Information System (IndOBIS) is a Regional OBIS Node (RON) run by the Centre for Marine Living Resources and Ecology (CMLRE) since 2009. The primary objectives of IndOBIS are the collection, collation and dissemination of spatially and taxonomically resolved marine species distribution records from the Indian Ocean region and the maintenance of voucher specimens from the Indian EEZ. 	2025-09-22 13:57:38.665044	active	organization	approved		t
d771a5b4-dcf5-4a11-b566-1f07cfc00e43	medobis	MedOBIS	MedOBIS, the Regional OBIS Node for the Mediterranean Sea, is hosted by the Institute of Marine Biology, Biotechnology and Aquaculture https://imbbc.hcmr.gr/ (IMBBC), Hellenic Centre for Marine Research, HCMR https://www.hcmr.gr/en/ (Ελληνικό Κέντρο Θαλασσίων Ερευνών, ΕΛ.ΚΕ.Θ.Ε.), Heraklion (Crete). Launched in 2003, it has already been operational in 2005 as a Tier 3 Node of EurOBIS and covered the Eastern Mediterranean and the Black Sea. Under the European projects EMODNET and LifeWatchGreece (started in 2013), it became a Tier 2 node and extended to all Mediterranean Sea. MedOBIS provides access to data from a wide range of sources and time periods, including new and historical data sets. MedOBIS actively contributes to global scientific effort for FAIR and OPEN data.	2025-09-22 13:57:38.754562	active	organization	approved		t
2e58e60a-3874-43d6-94c5-c2cce73fe7ad	obis-argentina	OBIS Argentina	OBIS Argentina (acronym AROBIS, Argentina Ocean Biodiversity Information System ) is an IODE ADU hosted in CCT CONICET-CENPAT, Puerto Madryn, Chubut, Argentina.  The node centralizes the information about the distribution of vertebrates and invertebrates from the coastal areas of Argentina and the continental shelf of the South-western Atlantic Ocean called the Patagonian Large Marine Ecosystem (PLME). It also integrates data about the distribution of resident vertebrates which emigrate to the Southern Ocean and the Pacific. At regional level AROBIS is presented as a functional precursor for  Linked Open Data to  improve the discoverability of the content of the databases.	2025-09-22 13:57:38.849101	active	organization	approved		t
afbabc3f-3452-4a94-a729-0bf5de4bb667	obis-australia	OBIS Australia	OBIS Australia is the regional OBIS Node for Australia. Its aim is fostering the online provision of marine species data from the Australian region and adjacent seas, or data from Australian providers, into the OBIS international data network. These data can also be forwarded to GBIF and Atlas of Living Australia (ALA) on a case by case basis. The website describes our activities and related resources.	2025-09-22 13:57:38.986935	active	organization	approved		t
e7b5ae11-6c1f-42b6-b054-68b878b7f357	obis-black-sea	OBIS Black Sea		2025-09-22 13:57:39.064879	active	organization	approved		t
3b7600e8-0c2f-4bda-9c19-02bc6b215254	obis-brazil	OBIS Brazil		2025-09-22 13:57:39.155416	active	organization	approved		t
b06998dc-2511-4456-a560-7a34acd5b9ad	obis-canada	OBIS Canada	OBIS Canada is the Canadian regional node of the International Ocean Biodiversity Information System (OBIS).	2025-09-22 13:57:39.255826	active	organization	approved		t
ad23811c-45d9-46cb-9322-c0f2e04c5f7f	obis-china	OBIS China	OBIS China is the regional OBIS node for Chinese region. OBIS China is responsible for collection, collation, and dissemination of data and information about the biodiversity of the China seas. Its main functions are to foster the on-line provision of marine species data from Chinese region into the OBIS portal, and to provide an access for Chinese users to the international OBIS data network. OBIS China is hosted by Institute of oceanology, Chinese Academy of Sciences.\n\nMission and Objectives: OBIS China will manage marine biodiversity data from the seas of China, put data online, connect Chinese marine species data with the international OBIS network, and provide data service online.\n\nSpatial Coverage: Sea areas of China (including Bohai Sea, Yellow Sea, East China Sea, and South China Sea) and adjacent western Pacific Ocean\nTemporal Coverage: From 1950s to the present\nTaxonomic coverage: Algae, protozoa, invertebrates, and fish\n\nServices offered: OBIS China will provide information concerning marine biodiversity relevant to regions of concern, and provide a local portal for submission and services of data request.	2025-09-22 13:57:39.423734	active	organization	approved		t
c5c65e91-5a2b-4dc8-9cdc-cac9a3189282	obis-colombia	OBIS Colombia	The OBIS node for Colombia is hosted by the Marine and Coastal Research Institute (INVEMAR), which is an IODE Associate Data Unit.  INVEMAR is a national institution in charge of marine research, the generation of data and establishing data management systems to share environmental data. \n	2025-09-22 13:57:39.553813	active	organization	approved		t
ad7a11ef-329f-4473-9805-f238e56456c3	obis-cpps	OBIS CPPS	The Permanent Commission for the South Pacific (CPPS) is an intergovernmental body with international legal personality, created by mandate of the countries through the Santiago Declaration in 1952. This Regional Maritime Organization promotes and articulates the maritime policies of its Member States: Chile, Colombia, Ecuador and Peru.  As a knowledge node of marine information in the Southeast Pacific region, CPPS provides the platform to integrate data from different projects and programs carried out in the region. CPPS is currently an IODE/ADU member since 2017 (CPPS-OBIS), but its activities compiling marine biological observation data of identifiable marine species started several years before.	2025-09-22 13:57:39.666464	active	organization	approved		t
e4d56021-ff07-409c-a434-2aabe55e55ee	obis-deep-sea	OBIS Deep Sea	The Deep-sea OBIS node is one of the global thematic nodes of the Ocean Biodiversity Information System, hosted at the OBIS secretariat, and managed by the Senckenberg Research Institute and Natural History Museum. The deep-sea OBIS node aims to provide a single integrated access point to high-quality data and information on the diversity, abundance and distribution of all deep-sea organisms and their ecosystem properties, including habitat and environmental characteristics. The further development of this deep-sea OBIS node and data portal is a shared responsibility of the wider deep-sea scientific community, and is supported by the International network for scientific investigation of deep-sea ecosystems (INEEP project, http://www.indeep-project.org/) and the Deep Ocean Stewardship Initiative (DOSI, http://dosi-project.org/).	2025-09-22 13:57:39.767988	active	organization	approved		t
a05350f5-edc6-4bda-b485-1ff5d6698e72	obis-ecuador	OBIS Ecuador		2025-09-22 13:57:39.861663	active	organization	approved		t
1b6795b6-16dd-48e6-9f07-eea472ec3a69	obis-gbif-norway	OBIS-GBIF Norway	GBIF Norway is the Norwegian participant node in the Global Biodiversity Information Facility, GBIF. Our main task is to make primary data on biological diversity from the Norwegian collections and observation databases freely available and to coordinate and support GBIF-related activities and data use in Norway.	2025-09-22 13:57:39.958734	active	organization	approved		t
90dc8b01-a056-4c45-b582-1d2f85486fae	obis-indonesia	OBIS Indonesia		2025-09-22 13:57:40.081383	active	organization	approved		t
6696572f-aaac-4cd9-8005-77b2014c89ae	obis-isa	OBIS ISA	The International Seabed Authority (ISA), established under the 1982 United Nations Convention on the Law of the Sea (the Convention) and the 1994 Agreement relating to the Implementation of Part XI of the Convention, is the organization through which States Parties to the Convention organize and control activities in the international seabed area (the Area).  As part of its mandate, ISA is required to take the measures necessary to ensure the effective protection for the marine environment from harmful effects that may arise from the activities carried out in the Area.  In addition, ISA is required to promote and encourage the conduct of marine scientific research in the Area and coordinate and disseminate the results of such research and analysis, when available. The ISA is also specifically mentioned in the Convention as the primary international competent organization through which States Parties have to cooperate to establish marine scientific research programmes in the Area for the benefit of developing States.   As of June 2021, ISA has entered into thirty-one contracts (31) for exploration of mineral resources, involving twenty-one (21) countries. The vast majority relates to the exploration of polymetallic nodules (19 contracts) in the Clarion-Clipperton Fracture Zone (CCZ) in the Eastern Pacific Ocean. Further contracts have also been signed for the exploration of polymetallic sulphides (7 contracts) in the North Atlantic Ocean and the Indian Ocean, and cobalt-rich ferromanganese crusts (5 contracts) in the Western Pacific Ocean and South Atlantic Ocean.  ISA holds centralized data of public and private information on marine mineral resources and environmental baseline data acquired by exploration contractors during their exploration activities. The environmental data, including biological, physical and geochemical parameters of the seafloor and water column ecosystems, is accessible to the public through the “ISA Deep Seabed and Ocean Database” (DeepData) (URL: http://data.isa.org.jm).  	2025-09-22 13:57:40.166466	active	organization	approved		t
2987cc44-b92d-4309-913c-54cba1ac777b	obis-japan	OBIS Japan	OBIS Japan node collects marine species information around Japan. OBIS Japan node is hosted  by Japan Agency for Marine-Earth Science and Technology (JAMSTEC). Further data and information on marine species around Japan can be found in BISMaL (http://www.godac.jamstec.go.jp/bismal/e/)	2025-09-22 13:57:40.268514	active	organization	approved		t
903f707f-3fd9-4309-bc2a-9a45f4f8930d	obis-kenya	OBIS Kenya	The Kenya Marine and Fisheries Research Institute (KMFRI), which is also the National Oceanographic Data Centre for Kenya, runs the national OBIS node for Kenya. KMFRI’s main role is to undertake research in marine and freshwater fisheries, aquaculture, environmental and ecological studies, in order to provide scientific data and information for sustainable exploitation, management and conservation of Kenya’s fisheries resources.	2025-09-22 13:57:40.521089	active	organization	approved		t
42710998-0d40-4076-aadb-7c8b2373a937	obis-korea	OBIS Korea	MABIK was established in 2015 as the national agency responsible for developing the marine economy and creating value using marine bio resources. The overall aim of MABIK is to turn marine biological resources into national assets, contributing to the advancement of marine research, economy, and education.	2025-09-22 13:57:40.692754	active	organization	approved		t
0489b1f3-df5e-46ef-83e4-4337b9efa016	obis-malaysia	OBIS Malaysia	OBIS Malaysia is housed at the Institute of Oceanography and Environment (INOS), Universiti Malaysia Terengganu. INOS is the leading research institute in Malaysia focusing on oceanography and marine science and has been recognised by the Ministry of Education, Malaysia as ‘Higher Institution Centre of Excellence’ (HICOE) in marine science. On the international scale, INOS is one of Associate Data Unit under International Oceanographic Data and Information Exchange (IODE). The South China Sea Repository and Reference Centre (RRC) under INOS, which is the responsible unit for OBIS Malaysia currently curated more than 20,000 marine specimens and recognised by the Ministry of Water, Land and Natural Resources, Malaysia as the main centre for marine collection in Malaysia.	2025-09-22 13:57:40.795433	active	organization	approved		t
1c9bdc15-f881-4f56-b6e6-83a8871ba956	obis-panama	OBIS Panama		2025-09-22 13:57:40.918461	active	organization	approved		t
cc21fcd3-f085-4ded-b8aa-21f89b5ada4c	obis-seamap	OBIS-SEAMAP	OBIS-SEAMAP, Ocean Biodiversity Information System Spatial Ecological Analysis of Megavertebrate Populations, is a spatially referenced online database, aggregating marine mammal, seabird, sea turtle and ray & shark observation data from across the globe. OBIS-SEAMAP, hosted at Marine Geospatial Ecology Lab, Duke University, is aimed at augmenting our understanding of the distribution and the ecology of the target species by quantifying the global patterns of marine species distribution and biodiversity and designing and implementing standard databases and innovative sampling techniques. Started in 2002 by the funding from Alfred P. Sloan Foundation and continued to grow through the past funding from National Science Foundation, National Oceanographic Partnership Program and Naval Postgraduate School, OBIS-SEAMAP has become one of the largest data repository of this kind.	2025-09-22 13:57:41.05885	active	organization	approved		t
2b63abfc-d39d-41ba-bbbe-0648c9b1fd87	obis-secretariat	OBIS Secretariat	The OBIS secretariat, hosted at the UNESCO/IOC project office for IODE in Oostende (Belgium), provides training and technical assistance to its data providers, guides new data standards and technical developments, and encourages international cooperation to foster the group benefits of the network. 	2025-09-22 13:57:41.150418	active	organization	approved		t
7a423a6a-2a56-4969-93dd-2c21bd4ac1ab	obis-senegal	OBIS Senegal	OBIS Senegal is a node of the Marine Biodiversity Data Management System (OBIS), hosted by the Oceanographic Research Center of Dakar-Thiaroye (CRODT) of the Senegalese Institute for Agricultural Research (ISRA). OBIS Senegal has a subregional scope, since it gathers data collected from west african marine waters. It began its activities in 2014. OBIS Senegal also has ambitions to provide services and tools for data management to institutions in the West African region.	2025-09-22 13:57:41.254786	active	organization	approved		t
f575884b-0a5f-4e59-a764-eb9ebfff8340	obis-uk	OBIS UK	The UK OBIS Node is hosted at the Marine Biological Association (MBA) in Plymouth, UK.  The MBA is one of the world’s longest-running societies dedicated to promoting research into our oceans and the life they support. Since 1884 we have been providing a unified, clear, independent voice on behalf of the marine biological community and currently have a growing membership in over 40 countries. We also run a leading marine biological research laboratory where many eminent scientists - including 7 Nobel prize winners - have carried out their research.	2025-09-22 13:57:41.354519	active	organization	approved		t
2e573b25-7383-4777-be3d-af71c9b771d9	obis-usa	OBIS USA	Ocean Biodiversity Information System USA (OBIS-USA) brings together marine biological observation data – recorded observations of identifiable marine species at a known time and place, collected primarily from U.S. Waters or with U.S. funding.	2025-09-22 13:57:41.436338	active	organization	approved		t
32b6fa33-c5c0-45b1-9080-dcdb64cd9da4	oceans-past-initiative	Oceans Past Initiative	The Oceans Past Initiative (OPI) is a global research network for marine historical research. Our goal is to enhance knowledge and understanding of how the diversity, distribution and abundance of marine life in the world’s oceans has changed over the long term to better indicate future changes and possibilities. OPI welcomes anyone interested in the history of humankind’s interactions with life in the oceans including paleo-ecologists and climatologists, archaeologists, marine environmental historians, economic historians, oral historians, historical ecologists, fisheries historians, and marine environmental and fisheries policy makers and managers.	2025-09-22 13:57:41.520353	active	organization	approved		t
e8c40209-a18d-4905-8b54-daec5e04a402	ocean-tracking-network	Ocean Tracking Network	The Ocean Tracking Network is a global aquatic animal tracking, data management, and partnership platform headquartered at Dalhousie University in Canada.\n\nOTN and its partners are using electronic tags to track many keystone, commercially important, and endangered species at an international scale, across all ocean regions.\n\nThe OTN Data Centre is responsible for the collection, aggregation, cross-referencing, and dissemination (both public and private) of acoustic detection data. OTNDC also maintains linkages to sibling acoustic telemetry data centres all over the world, and feeds global biogeographical information systems such as OBIS with animal tracking data as it is eventually made publicly available under the terms of the OTN Data Policy.	2025-09-22 13:57:41.600245	active	organization	approved		t
dd2f9ef7-1908-495a-ab74-247ff7379be9	pego-obis	PEGO OBIS	The OBIS node for the Persian Gulf and Gulf of Oman is run by the National Oceanographic Data Centre at the Iranian National Institute for Oceanography and Atmospheric Science (INIOAS).	2025-09-22 13:57:41.687506	active	organization	approved		t
2ecc04f6-b7ba-43ee-8548-adeea0ffc171	sea-obis	SEA OBIS	The ASEAN Centre for Biodiversity (ACB), established in 2005, is ASEAN’s response to the challenge of biodiversity loss. It is an intergovernmental organization that facilitates cooperation and coordination among the ten ASEAN Member States (AMS) and with regional and international organizations on the conservation and sustainable use of biological diversity, and the fair and equitable sharing of benefits arising from the use of such natural treasures.	2025-09-22 13:57:41.767122	active	organization	approved		t
697bfd7d-15e1-4b83-b0ee-8f926acc42a4	swp-obis	SWP OBIS	The Southwestern Pacific OBIS Node site is a gateway to marine biodiversity data from the Ross Sea (Antarctica), the Southern Ocean south of New Zealand, the New Zealand Exclusive Economic Zone, and surrounding seas in the south western Pacific Ocean. The Southwestern Pacific Regional OBIS Node is hosted by New Zealand’s National Institute of Water & Atmospheric Research (NIWA).	2025-09-22 13:57:41.852551	active	organization	approved		t
0b58fb0f-aa97-46ae-b245-ebf99e354c26	houston-advanced-research-center	Houston Advanced Research Center		2025-09-22 14:06:37.428517	active	group	approved		f
aa0a925a-1639-4470-9778-36c809078650	us-national-oceanographic-data-center-nodc	US National Oceanographic Data Center (NODC)		2025-09-22 14:06:39.136915	active	group	approved		f
1f25906e-abaf-4d80-bb52-cca85e0e6826	marine-institute-headquarters-galway	Marine Institute Headquarters, Galway		2025-09-22 14:06:44.401458	active	group	approved		f
0f5bcf48-2536-4eda-9890-b90979e67f23	fishermen-and-scientists-research-society	Fishermen and Scientists Research Society		2025-09-22 14:06:46.325127	active	group	approved		f
a92d9cbc-1892-4083-9eb1-8b606b96d53f	pacific-islands-fisheries-science-center-noaa-national-marine-fisheries-service-dole-street-office	Pacific Islands Fisheries Science Center, NOAA National Marine Fisheries Service, Dole Street Office		2025-09-22 14:06:48.077304	active	group	approved		f
fdacd702-3d20-4ec8-9b78-9fb5e58aed85	national-marine-fisheries-service-northeast-fisheries-science-center-massachusetts	National Marine Fisheries Service, Northeast Fisheries Science Center, Massachusetts		2025-09-22 14:06:49.815437	active	group	approved		f
c6e40c34-af79-49ad-b264-215a7412b267	australian-institute-of-marine-science-townsville	Australian Institute of Marine Science, Townsville		2025-09-22 14:06:51.565538	active	group	approved		f
3d11c74f-6f73-447f-b26e-1b5f1dedd827	national-museums-of-northern-ireland	National Museums of Northern Ireland		2025-09-22 14:06:53.881268	active	group	approved		f
68211384-c996-4cea-b513-640245865f3f	maurice-lamontagne-institute-dfo-mli-iml-fisheries-and-oceans-canada	Maurice Lamontagne Institute (DFO – MLI, IML), Fisheries and Oceans Canada		2025-09-22 14:06:57.74578	active	group	approved		f
0d792c5d-4fae-4bba-a304-ca301be2df70	swedish-environmental-protection-agency	Swedish Environmental Protection Agency		2025-09-22 14:06:59.615502	active	group	approved		f
e092d59e-78d0-4a96-ab2c-780b96c2dc7e	national-coral-reef-monitoring-program	National Coral Reef Monitoring Program 		2025-09-22 14:06:55.781155	active	group	approved		f
b2f11608-d736-4228-b023-ea890e70f458	central-northern-california-ocean-observing-system	Central & Northern California Ocean Observing System		2025-09-22 14:07:04.911625	active	group	approved		f
ce45ea14-e92e-4cde-88e1-0975b5230c88	natural-england	Natural England		2025-09-22 14:07:06.686721	active	group	approved		f
bdf364aa-7c2d-4ebe-9e23-32d53d165765	instituto-de-investigaciones-marinas-y-costeras	Instituto de Investigaciones Marinas y  Costeras		2025-09-22 14:07:08.366871	active	group	approved		f
0b98dbfe-c3c3-4c9a-8ef0-748ca63df702	us-geological-survey-patuxent-wildlife-research-center	U.S. Geological Survey – Patuxent Wildlife Research Center		2025-09-22 14:07:10.096559	active	group	approved		f
51fdd65d-819f-4f04-bdca-61c977ecc5b1	universidad-del-valle	Universidad del Valle		2025-09-22 14:07:11.816849	active	group	approved		f
798c1858-ec4b-4995-8153-e4757954f0db	koninklijk-nederlands-instituut-voor-onderzoek-der-zee	Koninklijk Nederlands Instituut voor Onderzoek der Zee		2025-09-22 14:07:13.537672	active	group	approved		f
85103d1a-32b9-432b-9477-17d798863fd8	deakin-university	Deakin University		2025-09-22 14:07:15.234559	active	group	approved		f
31decf3a-eca7-48bd-a0df-4e5ad6184b84	parques-nacionales-naturales-de-colombia	Parques Nacionales Naturales de Colombia		2025-09-22 14:07:17.023902	active	group	approved		f
febe0919-ebae-4143-b13b-2d16c3be7b7a	university-of-hull-oceans-past-initiative	University of Hull, Oceans Past Initiative		2025-09-22 14:07:18.755821	active	group	approved		f
2be3f8c6-0305-40ce-a886-e16fe1d5b866	universidade-dos-acores-departamento-de-oceanografia-e-pescas	Universidade dos Açores – Departamento de Oceanografia e Pescas		2025-09-22 14:07:20.476454	active	group	approved		f
b317dc0d-8a62-4185-b81f-58f8ce10f677	coralina	CORALINA		2025-09-22 14:07:22.340201	active	group	approved		f
90524ed2-5832-4d0e-93bd-8199dbab28e6	victoria-state-government-department-of-environment-land-water-planning	Victoria State Government —Department of Environment, Land, Water & Planning		2025-09-22 14:07:24.217664	active	group	approved		f
10302fdc-b9d1-48c2-adaf-9db10247c965	universiteit-gent-marine-biology-research-group	Universiteit Gent, Marine Biology research group		2025-09-22 14:07:26.064855	active	group	approved		f
f79362d0-ac5f-4f3e-adf2-40dd62c1750e	universidad-cientifica-del-sur	Universidad Científica del Sur		2025-09-22 14:07:27.817009	active	group	approved		f
f310ae60-2665-486c-aa2f-79087f0eb160	naval-information-warfare-center-pacific	Naval Information Warfare Center Pacific		2025-09-22 14:07:29.528004	active	group	approved		f
eb9da7c3-1e8d-4ee9-832c-094feca3b764	happywhale	Happywhale		2025-09-22 14:07:31.315924	active	group	approved		f
e36390bf-7bf5-401c-9416-563eb9764b71	japan-oceanographic-data-center	Japan Oceanographic Data Center		2025-09-22 14:07:33.147307	active	group	approved		f
a33882e2-da54-4760-918d-959fad0c885a	parque-nacional-natural-los-corales-del-rosario-y-de-san-bernardo	Parque Nacional Natural Los Corales del Rosario y de San Bernardo		2025-09-22 14:07:35.077057	active	group	approved		f
13553e47-6461-4b99-b3a3-f08668a89c46	antarctic-biodiversity-information-facility	Antarctic Biodiversity Information Facility		2025-09-22 14:07:37.004789	active	group	approved		f
0dcf8d2c-cc1f-4fdc-b642-5a65f9829fb3	university-of-liverpool	University of Liverpool		2025-09-22 14:07:38.927858	active	group	approved		f
592a4f7e-3dd2-4979-a5cd-9444de39a3e5	california-academy-of-sciences	California Academy of Sciences		2025-09-22 14:07:40.684314	active	group	approved		f
fb9a34d1-2e3e-4b0b-b7e5-4811b5582a5f	national-academy-of-sciences-of-ukraine-o-o-kovalevsky-institute-of-biology-of-the-southern-seas	National Academy of Sciences of Ukraine, O. O. Kovalevsky Institute of Biology of the Southern Seas		2025-09-22 14:07:42.445022	active	group	approved		f
c5ea1454-5a27-4f68-8751-b719b1f22e91	universidad-simon-bolivar	Universidad Simon Bolivar		2025-09-22 14:07:44.166683	active	group	approved		f
25c465b1-11ab-48f5-9171-0c9daad96682	florida-museum-of-natural-history	Florida Museum of Natural History		2025-09-22 14:07:45.863646	active	group	approved		f
b457f063-800f-455a-888a-af4961e486e8	university-of-alaska-fairbanks-school-of-fisheries-and-oceans	University of Alaska Fairbanks - School of Fisheries and Oceans		2025-09-22 14:07:47.650334	active	group	approved		f
667c0d64-27f9-4851-8fb6-87d460d543f5	national-centers-for-coastal-ocean-science	National Centers for Coastal Ocean Science		2025-09-22 14:07:51.085555	active	group	approved		f
59bbd82d-d9d2-4744-bfb5-be609e893aea	caribbean-coastal-ocean-observing-system	Caribbean Coastal Ocean Observing System		2025-09-22 14:07:52.837771	active	group	approved		f
be0878c0-57b1-4f4d-8bc9-90383a35f8c7	universidade-federal-de-sao-paulo-campus-sao-paolo	Universidade Federal de São Paulo, Campus Sao Paolo		2025-09-22 14:07:54.579176	active	group	approved		f
c2fea925-2541-450f-aa6b-88db3659c6b5	wageningen-marine-research	Wageningen Marine Research		2025-09-22 14:07:56.337412	active	group	approved		f
60d230ea-04bb-4bf0-bc31-931986c6f8ad	museums-victoria	Museums Victoria		2025-09-22 14:07:58.053408	active	group	approved		f
e928747c-cbc0-45c3-ac29-7d50ffd9a540	macquarie-university	Macquarie University		2025-09-22 14:07:59.847783	active	group	approved		f
5154fc27-ad82-44e9-a9a0-54880a290a81	monterey-bay-aquarium-research-institute	Monterey Bay Aquarium Research Institute		2025-09-22 14:08:01.617957	active	group	approved		f
d96a1343-305f-4dd8-9065-dce0e486cb0d	national-oceanography-centre-southampton	National Oceanography Centre, Southampton		2025-09-22 14:08:03.346695	active	group	approved		f
5d3f93d2-b551-478e-98f6-be5325aab839	reef-check-foundation	Reef Check Foundation		2025-09-22 14:08:05.11289	active	group	approved		f
6a9bb29b-626b-4adc-80f3-c0d5e8bf1541	museum-national-dhistoire-naturelle-ird	Museum National d'Histoire Naturelle / IRD		2025-09-22 14:08:06.809092	active	group	approved		f
61865196-9996-4c6b-9f95-e56b48656f79	canadian-wildlife-service-atlantic-region	Canadian Wildlife Service - Atlantic Region		2025-09-22 14:08:08.542792	active	group	approved		f
cfe2357b-8494-4915-a4af-e5e78f9a2d0e	vlaamse-overheid-beleidsdomein-landbouw-en-visserij-instituut-voor-landbouw-visserij-en	Vlaamse overheid; Beleidsdomein Landbouw en Visserij; Instituut voor landbouw- , visserij en voedingsonderzoek; Kenniseenheid: Dier; Aquatisch Milieu en Kwaliteit		2025-09-22 14:08:10.41441	active	group	approved		f
88783a78-f253-4f14-9c47-75ec6af444eb	instituto-espanol-de-oceanografia	Instituto Español de Oceanografía		2025-09-22 14:08:12.256628	active	group	approved		f
d2765fce-1dc3-4a5d-8bf2-498ab4dca5c1	univserity-of-california-santa-cruz	Univserity of California, Santa Cruz		2025-09-22 14:08:14.284864	active	group	approved		f
eba18a36-8bf8-465e-ac22-faf91d8842c1	koninklijk-nederlands-instituut-voor-onderzoek-der-zee-yerseke	Koninklijk Nederlands Instituut voor Onderzoek der Zee, Yerseke		2025-09-22 14:08:16.096595	active	group	approved		f
bcf08a4d-30c6-48f7-abd7-8c9ec80bfdb8	centro-para-el-estudio-de-sistemas-marinos-centro-nacional-patagonico	Centro para el Estudio de Sistemas Marinos, Centro Nacional Patagónico		2025-09-22 14:08:17.818873	active	group	approved		f
6fe6381f-bb07-424d-a851-195f25b6f6d9	noaa-center-for-sponsored-coastal-ocean-research-silver-spring	NOAA, Center for Sponsored Coastal Ocean Research, Silver Spring		2025-09-22 14:08:19.548311	active	group	approved		f
fc266a55-849b-4d77-a3ae-6c87be229e74	plymouth-marine-laboratory	Plymouth Marine Laboratory		2025-09-22 14:08:21.256713	active	group	approved		f
baf6eb4a-004f-46e0-93b0-33ddb3b5c062	universidade-estadual-do-norte-fluminense-darcy-ribeiro	Universidade Estadual do Norte Fluminense Darcy Ribeiro		2025-09-22 14:08:22.931274	active	group	approved		f
abf49f90-3508-4a79-8291-7285b2f35eaf	university-of-tartu-estonian-marine-institute	University of Tartu, Estonian Marine Institute		2025-09-22 14:08:24.684805	active	group	approved		f
d5869af9-6e98-4c5d-827d-5c05ebbb06c1	the-university-of-western-australia	The University of Western Australia		2025-09-22 14:08:26.45774	active	group	approved		f
5ad2c0af-ffc4-4cb9-b191-bbe63620020d	berkeley-natural-history-museums	Berkeley Natural History Museums		2025-09-22 14:08:28.230197	active	group	approved		f
6222c029-d926-4655-9dbb-2ab5bb2f935d	gulf-region-fisheries-and-oceans-canada	Gulf Region, Fisheries and Oceans Canada		2025-09-22 14:08:29.994412	active	group	approved		f
e054b50c-c05a-4962-91a6-adad139afe90	hellenic-centre-for-marine-research-institute-of-marine-biology-biotechnology-and-aquaculture	Hellenic Centre for Marine Research - Institute of Marine Biology, Biotechnology and Aquaculture		2025-09-22 14:08:31.741732	active	group	approved		f
95d7dd4e-f07e-4ebe-9559-801d52a42ea1	british-oceanographic-data-centre	British Oceanographic Data Centre		2025-09-22 14:08:33.510353	active	group	approved		f
cb9b615b-33aa-495a-a565-fd98a0b307f6	station-biologique-de-roscoff	Station Biologique de Roscoff		2025-09-22 14:08:35.292455	active	group	approved		f
2538a5d4-9f12-4d90-894f-1b269da5ac0b	international-seabed-authority	International Seabed Authority		2025-09-22 14:08:37.048972	active	group	approved		f
2c60df9f-d7e2-4d5c-a18b-860da9bfad32	universiteit-amsterdam	Universiteit Amsterdam		2025-09-22 14:08:38.817788	active	group	approved		f
d5b9d5ec-1686-43ba-92bc-7fa793c225e4	secretaria-de-pesca-de-la-provincia-del-chubut	Secretaría de Pesca de la Provincia del Chubut		2025-09-22 14:08:40.531178	active	group	approved		f
29ddffca-2484-4ede-9e6d-6f7e11895bfd	universidade-federal-de-santa-catarina	Universidade Federal de Santa Catarina		2025-09-22 14:08:42.244556	active	group	approved		f
dfa67296-40ed-4632-ac81-54a869dbfb97	university-of-the-virgin-islands	University of the Virgin Islands		2025-09-22 14:08:44.118238	active	group	approved		f
05787a9d-bc52-4e47-8ac8-b7dad21abfd3	csiro-oceans-and-atmospheric-research-brisbane	CSIRO Oceans and Atmospheric Research, Brisbane		2025-09-22 14:08:48.618251	active	group	approved		f
02aca92a-1742-40f0-bd6d-13a6c385ae8e	burke-museum	Burke Museum		2025-09-22 14:08:50.587101	active	group	approved		f
b21517fa-4431-4711-beb2-a92639c62ea5	huntsman-marine-science-centre	Huntsman Marine Science Centre		2025-09-22 14:08:52.36422	active	group	approved		f
0af463d7-be40-46b8-ae06-de54d1c501a7	council-for-scientific-and-industrial-research-stellenbosch	Council for Scientific and Industrial Research, Stellenbosch		2025-09-22 14:08:54.115431	active	group	approved		f
970491c8-f9c6-494d-bafe-6f50dee92d35	pacific-community	Pacific Community		2025-09-22 14:08:56.131855	active	group	approved		f
e915a1fb-c859-448d-8b03-143524fa4bb7	laboratoire-doceanographie-de-villefranche-sur-mer	Laboratoire d'Océanographie de Villefranche-sur-Mer		2025-09-22 14:08:58.086259	active	group	approved		f
b5c3662c-af5e-4f83-977b-344869ac4ddd	state-of-maine-department-of-marine-resources-bureau-of-sea-run-fisheries-and-habitat	State of Maine — Department of Marine Resources — Bureau of Sea Run Fisheries and Habitat		2025-09-22 14:08:59.970669	active	group	approved		f
5ade6690-8569-4f9f-b076-2f3483b83196	conservation-of-arctic-flora-and-fauna	Conservation of Arctic Flora and Fauna.		2025-09-22 14:09:01.74751	active	group	approved		f
7bac9cb3-5240-43ec-9090-75f596724d84	royal-ontario-museum	Royal Ontario Museum		2025-09-22 14:09:03.556573	active	group	approved		f
d0b92a8f-0c1a-46c8-a1a7-7c1aa2535ab1	queensland-museum	Queensland Museum		2025-09-22 14:09:05.340552	active	group	approved		f
a3b95820-ea5c-48d8-bcf3-383a602205f6	us-geological-survey-everglades-research-offices	U.S. Geological Survey – Everglades Research Offices		2025-09-22 14:09:07.090024	active	group	approved		f
6b693b05-3dae-4e77-b27b-39e85055d903	university-of-central-florida	University of Central Florida		2025-09-22 14:09:08.80139	active	group	approved		f
a427377b-8b01-46a4-993e-066e3b60877c	csiro-oceans-and-atmosphere-information-and-data-centre-hobart	CSIRO Oceans and Atmosphere Information and Data Centre, Hobart		2025-09-22 14:09:10.552436	active	group	approved		f
dba4cd0d-0b05-45e1-9786-c7ac5306f342	centre-for-marine-living-resources-ecology-ministry-of-earth-sciences-government-of-india	Centre for Marine Living Resources & Ecology, Ministry of Earth Sciences, Government of India		2025-09-22 14:09:12.278622	active	group	approved		f
70ec09c1-9d93-475d-ac96-2b89bae385ab	institut-de-la-mer-de-villefranche	Institut de la Mer de Villefranche		2025-09-22 14:09:14.021814	active	group	approved		f
7450d9d6-b6a8-4888-988c-841eb76b3217	museum-and-art-gallery-northern-territory	Museum and Art Gallery, Northern Territory		2025-09-22 14:09:15.753458	active	group	approved		f
97da71e8-2ef4-4130-9ef7-7a6093e2cfa6	canadian-museum-of-nature-research-collections	Canadian Museum of Nature, Research & Collections		2025-09-22 14:09:17.753065	active	group	approved		f
4efd84fb-5e9d-4720-a609-200cb1029874	freshwater-institute-dfo-fwi-fisheries-and-oceans-canada	Freshwater Institute (DFO – FWI), Fisheries and Oceans Canada		2025-09-22 14:09:19.524162	active	group	approved		f
eec99556-493c-4cb8-a936-fca189a62cae	jamstec-tokyo-office	JAMSTEC Tokyo Office		2025-09-22 14:09:21.28736	active	group	approved		f
33c501a0-0d47-4b52-ab11-0521c8ed1149	western-australian-museum	Western Australian Museum		2025-09-22 14:09:23.022554	active	group	approved		f
4861c99c-6b53-4674-8134-78f0dfa0cd45	university-of-california-santa-barbara	University of California, Santa Barbara		2025-09-22 14:09:24.828963	active	group	approved		f
9de9e83a-dd8b-408f-a194-90e9945d13e3	institute-of-oceanology-chinese-academy-of-sciences-qingdao	Institute of Oceanology Chinese Academy of Sciences, Qingdao		2025-09-22 14:09:26.64155	active	group	approved		f
16c09054-fef9-498b-93ba-e758ec693db0	instituto-espanol-de-oceanografia-centro-oceanografico-de-baleares	Instituto Español de Oceanografía – Centro Oceanográfico de Baleares		2025-09-22 14:09:30.240703	active	group	approved		f
98b88afe-c722-46cb-94ef-16d9c0bad789	thunen-institut-fur-seefischerei	Thünen Institut für Seefischerei		2025-09-22 14:09:31.987458	active	group	approved		f
f95cc150-edd8-4c05-9993-e85d4818f643	vavau-environmental-protection-association	Vava’u Environmental Protection Association		2025-09-22 14:09:33.690985	active	group	approved		f
e4f66786-d8a0-41bd-a73d-6007f356a245	universitat-de-les-illes-balears	Universitat de les Illes Balears		2025-09-22 14:09:35.427919	active	group	approved		f
cc724260-7325-4707-b8f2-24989b4b6b04	university-of-british-columbia	University of British Columbia		2025-09-22 14:09:37.193389	active	group	approved		f
247d7f49-f4eb-4992-8266-566b930bfd93	murdoch-university	Murdoch University		2025-09-22 14:09:38.893798	active	group	approved		f
86859ff8-d542-4199-96f3-5643a144b409	southwestern-pacific-obis-node	Southwestern Pacific OBIS Node		2025-09-22 14:09:40.6534	active	group	approved		f
d265acf8-05f0-40ef-893f-54fda0e6e435	university-college-cork	University College Cork		2025-09-22 14:09:42.387455	active	group	approved		f
9e150867-6f43-4b7d-96e0-3bd895916154	university-of-tasmania	University of Tasmania		2025-09-22 14:09:44.086496	active	group	approved		f
5f4afc28-fddd-470e-9b95-8a994031d8f3	faculty-of-sciences-university-of-lisbon	Faculty of Sciences, University of Lisbon		2025-09-22 14:09:45.884316	active	group	approved		f
b73ebe41-513e-40b0-aaf6-db43312af36d	hakai-institute	Hakai Institute		2025-09-22 14:09:47.624113	active	group	approved		f
8f56f7d5-1936-4492-8451-c957075738b0	puerto-rico-department-of-natural-and-environmental-resources	Puerto Rico Department of Natural and Environmental Resources		2025-09-22 14:09:49.363463	active	group	approved		f
7db51825-df14-4cb3-8bb5-c3f2f6a7eb5a	virginia-institute-of-marine-sciences	Virginia Institute of Marine Sciences		2025-09-22 14:09:51.08972	active	group	approved		f
e4315c27-31f4-4e8c-acc7-8a43755e1370	university-of-california-los-angeles	University of California Los Angeles		2025-09-22 14:09:52.818955	active	group	approved		f
a25d5eaf-775e-4d23-a215-c7c6c8447365	birdlife-australia	Birdlife Australia		2025-09-22 14:09:54.48392	active	group	approved		f
eb5171b4-dcb3-48e4-a3dd-8bb7d3a99c5b	tartu-ulikool	Tartu Ülikool		2025-09-22 14:09:56.192143	active	group	approved		f
ab4fc39b-575d-4421-9ec0-8e8cd90cadeb	south-african-institute-for-aquatic-biodiversity	South African Institute for Aquatic Biodiversity		2025-09-22 14:09:57.902909	active	group	approved		f
750c7541-d48a-4f99-8f6c-2775a02b0572	tasmanian-museum-and-art-gallery-collections-and-research-facility	Tasmanian Museum and Art Gallery – Collections and Research Facility		2025-09-22 14:09:59.59594	active	group	approved		f
8c7473b5-a75b-4e6e-b1dd-3a06a296b656	world-whaling-history	World Whaling History		2025-09-22 14:10:01.352553	active	group	approved		f
7d6c7a83-5ae8-4cdc-b96f-ad40114917ca	commission-for-the-conservation-of-antarctic-marine-living-resources	Commission for the Conservation of Antarctic Marine Living Resources		2025-09-22 14:10:03.118726	active	group	approved		f
b6700fd3-827c-4560-9366-e8fad31cccf3	vrije-universiteit-brussel	Vrije Universiteit Brussel		2025-09-22 14:10:05.886975	active	group	approved		f
53f56e02-066f-45a9-8d29-ba7c19567d47	australian-bureau-of-agricultural-and-resource-economics-and-sciences	Australian Bureau of Agricultural and Resource Economics and Sciences		2025-09-22 14:10:07.784303	active	group	approved		f
b1943950-4d4c-4b47-9ee4-d287b4d97863	university-of-california-marine-science-institute-santa-barbara	University of California, Marine Science Institute , Santa Barbara		2025-09-22 14:10:09.603809	active	group	approved		f
a69bda88-d70a-45e3-9405-b2bf6749d7a3	california-state-university-fullerton	California State University, Fullerton		2025-09-22 14:10:11.363937	active	group	approved		f
23561cf1-9650-45d8-b728-9b7d3ec0e512	university-of-alaska-fairbanks	University of Alaska Fairbanks		2025-09-22 14:10:13.050093	active	group	approved		f
d69a857b-28c0-4d05-aa49-af58910b8731	asean-centre-for-biodiversity	ASEAN Centre for Biodiversity		2025-09-22 14:10:14.738604	active	group	approved		f
6aa22741-c9e7-466a-80e3-b1795f322c3a	institut-de-recherche-pour-le-developpement-centre-de-noumea	Institut de Recherche pour le Développement, Centre de Nouméa		2025-09-22 14:10:16.48539	active	group	approved		f
787a1240-3ed9-4cb0-9e3e-6718c2f5c710	dalhousie-university	Dalhousie University		2025-09-22 14:10:18.28515	active	group	approved		f
784ccd58-c05b-407c-88cf-dc302be8050d	university-of-trieste-marine-biology-laboratory	University of Trieste – Marine Biology Laboratory		2025-09-22 14:10:19.997082	active	group	approved		f
437da419-407c-41dd-a578-14154a75617f	department-of-conservation-wellington-office	Department of Conservation- Wellington Office		2025-09-22 14:10:21.691437	active	group	approved		f
4b73dd5c-401b-48d9-8cf9-d327566524d6	seto-marine-biological-laboratory-graduate-school-of-science-kyoto-university	Seto Marine Biological Laboratory, Graduate School of Science, Kyoto University		2025-09-22 14:10:23.480101	active	group	approved		f
96b1c050-93a4-4ac0-8050-2471bb072d66	museum-national-dhistoire-naturelle-service-du-patrimoine-naturel	Muséum National d'Histoire Naturelle – Service du Patrimoine naturel		2025-09-22 14:10:25.700771	active	group	approved		f
896bf7f3-ff8c-4a5a-a064-e44dc6fe2e06	universite-de-bretagne-occidentale	Université de Bretagne Occidentale		2025-09-22 14:10:28.218847	active	group	approved		f
0b8d19bb-d4a2-48a4-88c6-edf90b2a6793	tokyo-university-of-marine-science-and-technology	Tokyo University of Marine Science and Technology		2025-09-22 14:10:31.689365	active	group	approved		f
695cf72a-771d-4ae1-bd07-707bf4147ea8	csiro-dutton-park-brisbane	CSIRO Dutton Park, Brisbane		2025-09-22 14:10:33.422522	active	group	approved		f
64408501-8ded-4236-b0a5-e4cc1fad2987	frontier-research-center-for-global-changejamstec	Frontier Research Center for Global Change/JAMSTEC		2025-09-22 14:10:35.308399	active	group	approved		f
5140454a-8995-46ef-b886-89a28020afbd	instituto-portugues-do-mar-e-da-atmosfera-i-p	Instituto Português do Mar e da Atmosfera, I. P.		2025-09-22 14:10:37.518039	active	group	approved		f
e55040d3-0f68-484d-9b8a-0d437de16e0c	senckenberg-gesellschaft-fur-naturforschung	Senckenberg Gesellschaft für Naturforschung		2025-09-22 14:10:39.328101	active	group	approved		f
0e481ec9-4c62-4a03-a1e3-e52fd7e17a35	university-of-south-florida-college-of-marine-science	University of South Florida, College of Marine Science		2025-09-22 14:10:41.020953	active	group	approved		f
d6a9c63b-7de9-4876-b619-97274fddf870	japan-agency-for-marine-earth-science-and-technology-yokosuka	Japan Agency for Marine-Earth Science and Technology, Yokosuka		2025-09-22 14:10:42.785534	active	group	approved		f
3043933b-6f03-460b-a889-f93e8115fb4a	katholieke-universiteit-leuven	Katholieke Universiteit Leuven		2025-09-22 14:10:44.490856	active	group	approved		f
d4d01d14-725a-40a0-96f0-a48acbc0be97	laboratoire-doceanologie-et-geosciences-umr-8187-centre-national-de-la-recherche-scientifique	Laboratoire d'Océanologie et Geosciences - UMR 8187 - Centre National de la Recherche Scientifique - Université du Littoral Côte d'Opale - Université de Lille		2025-09-22 14:10:46.199354	active	group	approved		f
94cbac79-581a-4546-b820-f38d651f2250	national-oceanic-and-atmospheric-administration	National Oceanic and Atmospheric Administration		2025-09-22 14:10:47.959788	active	group	approved		f
6c046ca7-3a9d-4914-9e99-7c712510762f	museum-of-tropical-queensland	Museum of Tropical Queensland		2025-09-22 14:10:49.696086	active	group	approved		f
ec3ae82c-2467-4ccf-a1de-8da8c76f7ff1	institute-of-ocean-science-dfo-ios-fisheries-and-oceans-canada	Institute of Ocean Science (DFO – IOS), Fisheries and Oceans Canada		2025-09-22 14:10:51.418619	active	group	approved		f
5edc05dd-7b0e-4e73-8d3c-866f00563324	high-north-research-centre-for-climate-and-the-environment	High North Research Centre for Climate and the Environment		2025-09-22 14:10:53.103435	active	group	approved		f
11758483-b1ff-4869-b808-7bef397d68b9	csir-national-institute-of-oceanography-goa	CSIR - National Institute of Oceanography, Goa		2025-09-22 14:10:54.824093	active	group	approved		f
78e0b382-6a4a-4b5d-be80-4816ae16c03d	scripps-institution-of-oceanography	Scripps Institution of Oceanography		2025-09-22 14:10:56.551894	active	group	approved		f
7a8c235e-d4cc-44df-a8d8-79cfade6dadd	gowny-inspektorat-ochrony-srodowiska-gios	Główny Inspektorat Ochrony Środowiska (GIOŚ)		2025-09-22 14:10:58.29275	active	group	approved		f
2d23e7f7-8ff0-40c8-af6e-71908729ea59	inaturalist-nz	iNaturalist NZ		2025-09-22 14:10:59.984379	active	group	approved		f
6dbd818e-9ec6-4a49-9ec7-403161a3daff	kenya-marine-and-fisheries-research-institute	Kenya Marine and Fisheries Research Institute		2025-09-22 14:11:01.717905	active	group	approved		f
2b52d11f-0b8a-4189-84b3-28d5a6bedd4e	queensland-government	Queensland Government		2025-09-22 14:11:03.426829	active	group	approved		f
e1c1b14f-d7d9-4341-93ef-b4e958cfeef5	institute-of-marine-research	Institute of Marine Research		2025-09-22 14:11:05.194059	active	group	approved		f
f33c3fdb-fb5a-4423-9853-6de85c21eaf7	institute-of-zoology-zoological-society-of-london	Institute of Zoology, Zoological Society of London		2025-09-22 14:11:06.925813	active	group	approved		f
8208125a-decf-4f71-9ee5-cabc48336ee8	environment-and-climate-change-canada	Environment and Climate Change Canada		2025-09-22 14:11:08.62613	active	group	approved		f
4950329a-ec0d-45f2-8728-16e312f54480	polar-knowledge-canada	Polar Knowledge Canada		2025-09-22 14:11:10.482717	active	group	approved		f
c4c09832-10d1-4b07-baf9-9dbafbf8039e	the-stazione-zoologica-anton-dohrn	The Stazione Zoologica Anton Dohrn		2025-09-22 14:11:12.288976	active	group	approved		f
4c737d42-3faa-4c48-8946-0bc77f024ecd	italian-national-institute-for-environmental-protection-and-research-branch-office-chioggia	Italian National Institute for Environmental Protection and Research — Branch office Chioggia		2025-09-22 14:11:13.994829	active	group	approved		f
d004b51b-2ed5-4a73-893c-358861e80bed	university-of-plymouth	University of Plymouth		2025-09-22 14:11:15.685106	active	group	approved		f
dfb7a014-0e42-4e48-83aa-bc26cc28f163	fundacion-charles-darwin	Fundación Charles Darwin		2025-09-22 14:11:17.454837	active	group	approved		f
a4cb7546-84c4-4d48-be51-07acdfd0c52d	bishop-museum	Bishop Museum		2025-09-22 14:11:19.251516	active	group	approved		f
65ae22f8-78da-48de-b395-ef8a054117f5	florida-fish-and-wildlife-conservation-commission-fish-and-wildlife-research-institute	Florida Fish and Wildlife Conservation Commission, Fish and Wildlife Research Institute		2025-09-22 14:11:21.157859	active	group	approved		f
8e802012-99d8-4029-b6d2-3aab7d633045	southern-gulf-of-st-lawrence-coalition-on-sustainability	Southern Gulf of St. Lawrence Coalition on Sustainability		2025-09-22 14:11:22.916895	active	group	approved		f
b3873ace-2e25-4610-be44-677538dccf32	pod-federaal-wetenschapsbeleid	POD Federaal Wetenschapsbeleid		2025-09-22 14:11:24.741231	active	group	approved		f
a563a3d3-0e3c-4fc8-895b-6c022c853670	diversity-of-the-indo-pacific-network	Diversity of the Indo-Pacific Network		2025-09-22 14:11:26.457725	active	group	approved		f
7924147f-5b51-49c0-a1e7-3c52d0b7f8a8	noaa-southwest-fisheries-science-center-fisheries-resources-division-la-jolla	NOAA, Southwest Fisheries Science Center,  Fisheries Resources Division, La Jolla		2025-09-22 14:11:28.212781	active	group	approved		f
033d95ac-20c8-4586-89ac-6d417d20cd5a	hellenic-centre-for-marine-research-crete	Hellenic Centre for Marine Research, Crete		2025-09-22 14:11:29.925009	active	group	approved		f
0675a51b-6cc9-4cd6-bc0a-fc74fe13751a	university-of-south-florida-st-petersburg	University of South Florida, St. Petersburg		2025-09-22 14:11:31.646748	active	group	approved		f
d38658b9-6bd5-4b0b-969f-63aeff3e2132	tasmanian-museum-and-art-gallery	Tasmanian Museum and Art Gallery		2025-09-22 14:11:33.382791	active	group	approved		f
54bb88ce-067f-4742-a38f-d9de6aa67991	institute-of-oceanography-and-fisheries-croatia	Institute of Oceanography and  Fisheries Croatia		2025-09-22 14:11:36.739198	active	group	approved		f
167b8f8d-d89e-4f9c-905b-25c67d1a792b	department-of-environment-and-heritage-protection	Department of Environment and Heritage Protection		2025-09-22 14:11:39.454451	active	group	approved		f
2fdf01ab-1278-49db-9f8c-223c8d61d0ec	ospar-commission	OSPAR Commission		2025-09-22 14:11:41.191769	active	group	approved		f
32c00f85-c3ca-4872-8d94-61ec822f042e	texas-am-university-college-station-department-of-oceanography	Texas A&M University, College Station – Department of Oceanography		2025-09-22 14:11:42.954293	active	group	approved		f
8518d6b4-e106-469b-9cb8-06abe0fc2b55	university-of-georgia-odum-school-of-ecology	University of Georgia, Odum School of Ecology		2025-09-22 14:11:44.656051	active	group	approved		f
800762c8-d262-4992-9683-fb5f1aff2c1c	instituto-de-estudos-do-mar-almirante-paulo-moreira-ieapm	Instituto de Estudos do Mar Almirante Paulo Moreira - IEAPM		2025-09-22 14:11:46.353623	active	group	approved		f
7274e8ed-e151-45ae-9d36-bdd1aaaa3c02	the-bailey-matthews-national-shell-museum	The Bailey-Matthews National Shell Museum		2025-09-22 14:11:48.089044	active	group	approved		f
14301816-4f12-486b-8f7c-06a95ed5011b	the-natural-history-museum	The Natural History Museum		2025-09-22 14:11:49.785479	active	group	approved		f
52d7435b-c1ee-45e1-8c37-109eb4d7c6ff	national-institute-for-environmental-studies	National Institute for Environmental Studies		2025-09-22 14:11:51.490819	active	group	approved		f
9473a245-2c00-459a-a9a4-5101643f96c5	south-australian-museum	South Australian Museum		2025-09-22 14:11:53.343943	active	group	approved		f
bce4dbd9-6032-4046-a7c6-2763e2b9b65a	university-of-tsukuba-shimoda-marine-research-center	University of Tsukuba, Shimoda Marine Research Center		2025-09-22 14:11:55.413966	active	group	approved		f
7ea7c6d8-b190-41ba-9220-cb2afa26aedd	axiom-data-science	Axiom Data Science		2025-09-22 14:11:57.432671	active	group	approved		f
859c1ca6-f244-4ec6-9fd4-9f4ff789e1b9	aristotle-university-of-thessaloniki	Aristotle University of Thessaloniki		2025-09-22 14:11:59.091447	active	group	approved		f
6e6209ae-9722-4618-997e-574bd8bf9232	universidad-del-magdalena	Universidad del Magdalena		2025-09-22 14:12:00.771531	active	group	approved		f
e907c070-e714-4cbd-9452-fd9835d754c0	universiteit-gent-faculteit-wetenschap	Universiteit Gent, Faculteit Wetenschap		2025-09-22 14:12:02.522715	active	group	approved		f
50a6b81f-aa28-4c82-9701-3dcf237eb676	ministry-of-the-environment	Ministry of the Environment		2025-09-22 14:12:04.449574	active	group	approved		f
cae19eda-cf6e-410f-8def-2f9f4f547a81	zoological-institute-of-the-russian-academy-of-sciences	Zoological Institute of the Russian Academy of Sciences		2025-09-22 14:12:06.235741	active	group	approved		f
5cddb6d0-4ad6-4f7c-a5f8-b62b744538c1	korea-ocean-research-development-institute	Korea Ocean Research & Development Institute		2025-09-22 14:12:09.491821	active	group	approved		f
e7291ef6-c93c-4d32-a3bf-56e5bfbbbe59	the-marine-mammal-laboratory	The Marine Mammal Laboratory		2025-09-22 14:12:11.27315	active	group	approved		f
a16dd315-42e4-4265-82a1-cca335347a61	universite-de-liege	Université de Liège		2025-09-22 14:12:13.021181	active	group	approved		f
c7a3397f-16f3-490b-aee6-40f0128b047a	bulgarian-academy-of-sciences-institute-of-oceanology	Bulgarian Academy of Sciences, Institute of Oceanology		2025-09-22 14:12:14.75035	active	group	approved		f
fb6ac69a-97ba-41aa-8393-6899331e54d9	roskilde-university	Roskilde University		2025-09-22 14:12:16.463497	active	group	approved		f
91b32882-1919-4ea9-b8d1-6a1a234b6d54	universidad-central-de-venezuela	Universidad Central de Venezuela		2025-09-22 14:12:18.180797	active	group	approved		f
13d92eaf-54e6-4030-917d-92f07ed3ac15	seaturtleorg	SEATURTLE.ORG		2025-09-22 14:12:19.889971	active	group	approved		f
f677b5bc-4d9a-4e3c-8581-81e6b7cb4543	universidade-federal-do-parana	Universidade Federal do Paraná		2025-09-22 14:12:21.65849	active	group	approved		f
ec093b2d-a8cc-4cac-942a-382e052740d7	uk-seabed-resources-ltd	UK Seabed Resources Ltd.		2025-09-22 14:12:23.437829	active	group	approved		f
c596f9de-a718-4452-a72e-6114b4df376a	lebanese-university-faculty-of-sciences-marine-research-centre	Lebanese University — Faculty of Sciences — Marine Research Centre		2025-09-22 14:12:25.303889	active	group	approved		f
aa3f2b1d-0c60-4683-b34b-72a697014c06	national-council-for-scientific-research-national-center-for-marine-sciences-laboratory-of-marine	National Council for Scientific Research – National Center for Marine Sciences – Laboratory of Marine Ecology and Plankton		2025-09-22 14:12:27.061398	active	group	approved		f
e4b9e642-5e3c-477d-8beb-d7d0695f1529	eamer-science-policy	Eamer Science & Policy		2025-09-22 14:12:28.838919	active	group	approved		f
214d4414-7bd0-4e93-8880-29ce5f7f8a4c	bundesanstalt-fur-geowissenschaften-und-rohstoffe-bgr-in-hannover	Bundesanstalt für Geowissenschaften und Rohstoffe (BGR) in Hannover		2025-09-22 14:12:30.641814	active	group	approved		f
824218af-abd6-494d-8516-df3976f15036	biodiversity-research-centre-academia-sinica	Biodiversity Research Centre, Academia Sinica		2025-09-22 14:12:32.325421	active	group	approved		f
82afeb70-c1a1-4f44-abbc-e4011fbd6fe1	center-for-environment-fisheries-and-aquaculture-science-lowestoft-laboratory	Center for Environment, Fisheries and Aquaculture Science, Lowestoft Laboratory		2025-09-22 14:12:34.140574	active	group	approved		f
3a8c7ba9-7568-4ae5-af84-8774a9d68c84	helcom-baltic-marine-environment-protection-commission	HELCOM - Baltic Marine Environment Protection Commission		2025-09-22 14:12:35.866266	active	group	approved		f
ac23012e-f084-4e91-a387-ab2710215700	national-museum-of-nature-and-science-department-of-zoology-tsukuba	National Museum of Nature and Science, Department of Zoology, Tsukuba		2025-09-22 14:12:37.621175	active	group	approved		f
f6e30ff9-73a7-4d8d-aa0f-394fec886cc4	diveboard	Diveboard		2025-09-22 14:12:39.383533	active	group	approved		f
3d13dcc2-f9e2-4ea6-8927-3fdc64f2599e	instituut-voor-landbouw-visserij-en-voedingonderzoek	Instituut voor Landbouw, Visserij en voedingonderzoek		2025-09-22 14:12:41.166126	active	group	approved		f
a6f164ab-e1f5-4685-81ec-e307c1005059	agri-food-and-biosciences-institute	Agri-Food and Biosciences Institute		2025-09-22 14:12:42.967502	active	group	approved		f
03a65aa1-ef3b-4ba2-b55a-f9e1309350c5	museo-argentino-de-ciencias-naturales-bernardino-rivadavia	Museo Argentino de Ciencias Naturales "Bernardino Rivadavia"		2025-09-22 14:12:44.685559	active	group	approved		f
981ece61-8d8d-49b3-aa77-5604c05b25a5	universidade-federal-da-bahia	Universidade Federal da Bahia		2025-09-22 14:12:46.392186	active	group	approved		f
fb7d769c-25af-491e-82d7-2814bb44adfa	pontificia-universidad-catolica-de-chile-santiago	Pontificia Universidad Católica de Chile, Santiago		2025-09-22 14:12:48.220495	active	group	approved		f
e8af040b-6c07-471b-8f38-e2e2c2a3618a	universidad-nacional-mayor-de-san-marcos	Universidad Nacional Mayor de San Marcos		2025-09-22 14:12:49.930723	active	group	approved		f
7dac64a8-dbeb-4200-9ddc-3cce519d268c	centro-nacional-patagonico	Centro Nacional Patagónico†		2025-09-22 14:12:51.626076	active	group	approved		f
89d0ab20-89d1-4def-b62c-5bdb334ba91c	the-university-of-the-west-indies-st-augustine-campus	The University of the West Indies, St. Augustine Campus		2025-09-22 14:12:53.355796	active	group	approved		f
30262bfe-a8cc-4358-842c-d6f2215dbc27	universidade-federal-do-ceara	Universidade Federal do Ceará		2025-09-22 14:12:55.091736	active	group	approved		f
871ab2eb-b6e4-4d17-82e4-a0d19dc00734	university-of-hawaii	University of Hawaii		2025-09-22 14:12:57.015966	active	group	approved		f
9bcaadda-82db-4337-969b-f20c2fd6df9f	university-of-concepcion-chile	University of Concepcion, Chile		2025-09-22 14:12:59.319904	active	group	approved		f
54ad8d42-a77e-4ba9-9086-5616f5b1bfa3	universidade-federal-de-sao-paulo	Universidade Federal de Sao Paulo		2025-09-22 14:13:01.108887	active	group	approved		f
802e6fa7-dcfa-47ae-8fba-fc82384781ce	university-of-puerto-rico-at-mayaguez	University of Puerto Rico at Mayagüez		2025-09-22 14:13:03.502567	active	group	approved		f
d381c204-7ca8-4c47-9009-da41186d3ddb	universidad-nacional-de-mar-del-plata	Universidad Nacional de Mar del Plata		2025-09-22 14:13:05.270855	active	group	approved		f
bb4dca58-991a-4bf6-9b45-58773ebfc74b	universidade-federal-do-maranhao	Universidade Federal do Maranhão		2025-09-22 14:13:07.118054	active	group	approved		f
28edba86-d7b0-4680-aeae-76a6ea1fb665	universidad-de-oriente	Universidad de Oriente		2025-09-22 14:13:08.946296	active	group	approved		f
1525c747-c4f0-4722-b9ff-f1b3110c4722	universidad-de-la-republica	Universidad de la República		2025-09-22 14:13:10.650621	active	group	approved		f
2266f8b8-d21c-4396-b121-38a6d0d10904	observatoire-oceanologique-de-villefranche	Observatoire Océanologique de Villefranche		2025-09-22 14:13:12.350623	active	group	approved		f
266b5bf5-ff83-4884-99d1-e57d24c62938	environmental-hydraulics-institute	Environmental Hydraulics Institute		2025-09-22 14:13:14.088859	active	group	approved		f
b8d845b9-9dba-47e7-ba82-21c73c3a4a40	ukrainian-scientific-centre-of-ecology-of-the-sea	Ukrainian Scientific Centre of Ecology of the Sea		2025-09-22 14:13:15.824043	active	group	approved		f
041a8159-b1a2-4b4e-984e-dfa10a7183b8	uit-the-arctic-university-of-norway	UiT - the Arctic University of Norway		2025-09-22 14:13:19.257726	active	group	approved		f
db4af8aa-7de7-4549-bbd2-2279e29221c1	university-of-north-carolina-wilmington	University of North Carolina Wilmington		2025-09-22 14:13:29.14111	active	group	approved		f
275f4e71-3c27-4493-8557-264bf2bdc573	arvam-agence-pour-la-recherche-et-la-valorisation-marine	ARVAM Agence pour la Recherche et la Valorisation Marine		2025-09-22 14:13:30.992127	active	group	approved		f
1f14f01f-988f-4b30-be8a-30f5affec66d	universite-de-bordeaux-i-environnements-et-paleoenvironnements-oceaniques-talence	Universite de Bordeaux I, Environnements et Paléoenvironnements OCéaniques , Talence		2025-09-22 14:13:32.757504	active	group	approved		f
25f14782-5f5b-4fdc-815b-5ab6361eb4b7	centre-national-de-la-recherche-scientifique	Centre National de la Recherche Scientifique		2025-09-22 14:13:34.447493	active	group	approved		f
70de0a28-cbe6-48a6-ad7f-c5f865d95e57	hdr-inc	HDR, Inc.		2025-09-22 14:13:36.233944	active	group	approved		f
bf870d7f-9771-4ec4-bec4-96a93ac48db4	charles-darwin-university	Charles Darwin University		2025-09-22 14:13:38.239621	active	group	approved		f
52311b2d-544b-4fc9-8f50-a2bc46dd021e	european-bioinformatics-institute	European Bioinformatics Institute		2025-09-22 14:13:40.218513	active	group	approved		f
686eebff-1ae4-4ffc-aa82-b4e57d6bc878	university-of-st-andrews-scottish-oceans-institute	University of St Andrews, Scottish Oceans Institute		2025-09-22 14:13:41.920264	active	group	approved		f
4a747e3c-d413-407b-9b33-0971c3e1c715	universidad-las-palmas-de-gran-canaria	Universidad Las Palmas de Gran Canaria		2025-09-22 14:13:43.669645	active	group	approved		f
42dc3aa1-6da8-423f-8661-36a18ac5f228	umea-university	Umeå University		2025-09-22 14:13:45.414596	active	group	approved		f
a07368ee-ae2d-4f0b-a5ef-2fe499d50916	rhodes-university	Rhodes University		2025-09-22 14:13:47.265677	active	group	approved		f
b2b51546-3b53-4352-a662-cc01be4e15e4	geomarine-research	Geomarine Research		2025-09-22 14:13:48.999597	active	group	approved		f
0c646368-381c-4755-9662-208f7beefec2	university-of-oslo-natural-history-museum	University of Oslo - Natural History Museum		2025-09-22 14:13:50.724432	active	group	approved		f
8181c435-3025-4586-b923-06bbd11d74a8	universidade-federal-do-espirito-santo	Universidade Federal do Espírito Santo		2025-09-22 14:13:52.486506	active	group	approved		f
b49c0d7a-ab4e-49da-8740-966a1e3bf988	universite-bourgogne-franche-comte	Université Bourgogne - Franche-Comté		2025-09-22 14:13:54.229718	active	group	approved		f
4d85c067-dd49-4389-9b5d-d7f2f7c9619a	laboratoire-biogeosciences-umr-cnrsub-6282	Laboratoire Biogéosciences (UMR CNRS/uB 6282)		2025-09-22 14:13:55.922887	active	group	approved		f
0b4bdd41-6d09-4acc-8686-f19daa04ca80	israel-oceanographic-limnological-research	Israel Oceanographic & Limnological Research		2025-09-22 14:13:57.653476	active	group	approved		f
a3e2256d-8325-43aa-80fc-2609c4773bed	us-geological-survey-menlo-park-campus	U.S. Geological Survey – Menlo Park Campus		2025-09-22 14:13:59.329583	active	group	approved		f
2110e2c1-1004-4df9-939d-59c145d8863a	department-of-fisheries-and-oceans-st-andrews-biological-station	Department of Fisheries and Oceans - St. Andrews Biological Station		2025-09-22 14:14:01.050167	active	group	approved		f
14f7ee4f-e08e-4a46-b871-4986f878734c	de-beers-namibia-holdings	De Beers Namibia Holdings		2025-09-22 14:14:02.78964	active	group	approved		f
a07e42c6-9d8c-41a9-a584-a7ab36182661	unesco-ioc	UNESCO-IOC		2025-09-22 14:14:04.492022	active	group	approved		f
10c56773-42dd-48ac-b112-7f93635f77f5	tel-aviv-university-department-of-zoology	Tel Aviv University, Department of Zoology		2025-09-22 14:14:06.297833	active	group	approved		f
22afadf4-defa-4dc5-84d6-43753cb4b6a6	bureau-of-marine-resources	Bureau of Marine Resources		2025-09-22 14:14:08.019487	active	group	approved		f
b36f3a08-c0f3-4113-9701-8be7a96c6994	the-australian-national-university	The Australian National University		2025-09-22 14:14:09.72962	active	group	approved		f
97030076-b67c-4297-82da-9719f19f627d	italian-national-institute-for-environmental-protection-and-research	Italian National Institute for Environmental Protection and research		2025-09-22 14:14:11.440376	active	group	approved		f
7392a5b0-980d-4fad-b474-87508f4764a7	uniwersytet-odzki	Uniwersytet Łódzki		2025-09-22 14:14:13.192696	active	group	approved		f
1faa8adc-06fa-4d42-9ac1-29d184df23dd	auckland-war-memorial-museum	Auckland War Memorial Museum		2025-09-22 14:14:14.890544	active	group	approved		f
d56c7b0b-6ae9-468c-ac9d-9376fc21da16	asociacion-para-el-estudio-y-la-conservacion-de-las-aves-en-colombia-calidris	Asociación para el Estudio y la Conservación de las Aves en Colombia-Calidris.		2025-09-22 14:14:16.599094	active	group	approved		f
b7d6f9fd-961c-43da-96d7-2a96958f52a5	belgian-national-committee-on-antarctic-research	Belgian National Committee on Antarctic Research		2025-09-22 14:14:18.313168	active	group	approved		f
0a48dceb-ee1b-4a15-bdf8-f0600922140b	royal-netherlands-academy-of-arts-and-sciences-netherlands-institute-of-ecology	Royal Netherlands Academy of Arts and Sciences – Netherlands Institute of Ecology		2025-09-22 14:14:20.05493	active	group	approved		f
3b6e7d4d-aeca-4ed8-84b0-341a127c6961	italian-national-research-council	Italian National Research Council		2025-09-22 14:14:21.819616	active	group	approved		f
57cfc1e2-015b-4305-9a9c-c8d4e97edb7e	universita-de-pisa-dipartmento-di-scienze-agrarie-alimentari-e-agro-ambientali	Universita de Pisa – Dipartmento di Scienze Agrarie, Alimentari e Agro-ambientali		2025-09-22 14:14:23.739109	active	group	approved		f
95b31416-1012-4b3c-866a-cef324346386	universita-politecnica-delle-marche	Università Politecnica delle Marche		2025-09-22 14:14:25.556433	active	group	approved		f
ae9514c5-f98e-467d-9971-3a710a0eb8f9	aalborg-university-department-of-culture-and-global-studies	Aalborg University - Department of Culture and Global Studies		2025-09-22 14:14:27.321637	active	group	approved		f
0d67c71d-6211-4e72-be4c-524bfc6a1d08	marine-biological-museum-chinese-academy-of-sciences	Marine Biological Museum, Chinese Academy of Sciences		2025-09-22 14:14:29.011946	active	group	approved		f
9b5a030b-4fba-40a2-b1f3-28c105710dde	chinese-academy-of-sciences-institute-of-oceanology-jiaozhou-bay-marine-ecosystem-research-station	Chinese Academy of Sciences — Institute of Oceanology — Jiaozhou Bay Marine Ecosystem Research Station		2025-09-22 14:14:30.697121	active	group	approved		f
8703524f-c585-4ce8-b585-7332c5a7d9dd	university-of-auckland	University of Auckland		2025-09-22 14:14:32.775837	active	group	approved		f
e828a308-7500-47c6-8e7a-708cc0a8ee24	scar-antarctic-biodiversity-portal	SCAR Antarctic Biodiversity Portal		2025-09-22 14:14:34.445824	active	group	approved		f
98cbc4d9-113f-421b-ae1e-93940b14b0a9	hawaii-institute-of-marine-biology-university-of-hawaii	Hawaii Institute of Marine Biology, University of Hawaii		2025-09-22 14:14:36.255174	active	group	approved		f
331e4a28-5a0d-40c9-9156-8d069ed07e7e	university-of-waikato	University of Waikato		2025-09-22 14:14:37.992168	active	group	approved		f
90e12cca-89b1-4682-846b-4ec3604123d8	dragonfly-data-science	Dragonfly Data Science		2025-09-22 14:14:39.815526	active	group	approved		f
3d9e9d8c-def3-4e2d-b37d-92ac91094c61	university-of-california-san-diego	University of California, San Diego		2025-09-22 14:14:41.6925	active	group	approved		f
dd32ba32-b24a-4022-b3e0-3370ac3b64b4	university-of-alaska-fairbanks-deparment-of-biology-wildlife	University of Alaska Fairbanks - Deparment of Biology & Wildlife		2025-09-22 14:14:43.439058	active	group	approved		f
fd57bbc8-c10b-43ef-a0e7-1a11c34d3c6a	universidad-de-alicante	Universidad de Alicante		2025-09-22 14:14:45.19812	active	group	approved		f
26a7a9c1-1a70-49f8-82ab-e7502f538b12	universite-de-tunis-el-manar	Université de Tunis El Manar		2025-09-22 14:14:47.015652	active	group	approved		f
1a25085b-990b-4a54-90dc-edf8b1bb5187	university-of-manitoba-department-of-biological-sciences	University of Manitoba – Department of Biological Sciences		2025-09-22 14:14:48.766576	active	group	approved		f
9a7fcc54-154a-4fc7-b1a6-5a82bed8d016	st-francis-xavier-university-department-of-biology	St. Francis Xavier University – Department of Biology		2025-09-22 14:14:50.490444	active	group	approved		f
5dee680a-6ac8-42b5-80ea-37bc20b6753a	universidad-nacional-autonoma-de-mexico	Universidad Nacional Autónoma de México		2025-09-22 14:14:52.223505	active	group	approved		f
c0724b90-69b6-4cd1-997e-e5b34f96d23a	museu-nacional-ufrj	Museu Nacional UFRJ		2025-09-22 14:14:53.921155	active	group	approved		f
95f850a5-917a-42ff-8394-c0b03f115000	fundacion-universidad-de-bogota-jorge-tadeo-lozano	Fundación Universidad de Bogotá Jorge Tadeo Lozano		2025-09-22 14:14:55.649023	active	group	approved		f
8b115d2c-b78f-48c1-91c7-98361c0cb9b2	unidad-multidisciplinaria-de-docencia-e-investigacion-umdi-sisal	Unidad Multidisciplinaria de Docencia e Investigación, UMDI-Sisal		2025-09-22 14:14:57.389387	active	group	approved		f
a7227e00-5b28-4afc-b42c-01a3faf61b3e	sapienza-university-of-roma	Sapienza University of Roma		2025-09-22 14:14:59.087726	active	group	approved		f
fda51120-160d-4ce7-901b-30b7bc880320	universite-de-carthage	Université de Carthage		2025-09-22 14:15:00.794509	active	group	approved		f
72ecf145-6884-41d5-bd1e-da35039b930f	university-of-malta	University of Malta		2025-09-22 14:15:02.583923	active	group	approved		f
38ec64ce-f8b3-4ccd-a4e2-da3375ea1b87	brijuni-national-park	Brijuni National Park		2025-09-22 14:15:04.331427	active	group	approved		f
a54646d7-acb9-4ea3-9343-f89998f264a4	australian-national-university-research-school-of-earth-science	Australian National University, Research School of Earth Science		2025-09-22 14:15:06.056319	active	group	approved		f
14653056-8541-41d0-a2b3-734760b78a49	universidad-de-carabobo	Universidad de Carabobo		2025-09-22 14:15:07.791157	active	group	approved		f
0a6d885d-16e2-4e6c-8f78-909e76e77498	universidad-de-buenos-aires-instituto-de-ecologia-genetica-y-evolucion-de-buenos-aires	Universidad de Buenos Aires — Instituto de Ecologia, Genetica y Evolucion de Buenos Aires		2025-09-22 14:15:09.519632	active	group	approved		f
c1353b20-43a4-48db-afce-c235c0d21698	royal-netherlands-institute-for-sea-research-estuarine-delta-systems	Royal Netherlands Institute for Sea Research — Estuarine & Delta Systems		2025-09-22 14:15:11.228575	active	group	approved		f
45cb320e-e6b7-4bb6-b7cb-5f26f82bdeaf	aristotle-university-of-thessaloniki-department-of-biology-laboratory-of-zoology	Aristotle University of Thessaloniki -  Department of Biology - Laboratory of Zoology		2025-09-22 14:15:12.955804	active	group	approved		f
ce4fb67b-6511-4f4c-aa81-2c5420fc2ea6	leibniz-institute-for-baltic-sea-research-warnemunde	Leibniz Institute for Baltic Sea Research, Warnemünde		2025-09-22 14:15:14.723238	active	group	approved		f
0ba72d15-bf93-4054-b617-295cea604bb5	university-of-utrecht	University of Utrecht		2025-09-22 14:15:16.485138	active	group	approved		f
7c34f5c0-445b-459a-bd5e-22f96833cd2c	wwf-colombia	WWF Colombia		2025-09-22 14:15:19.793108	active	group	approved		f
e3f190a8-f874-4276-84fb-f858a25bbefc	national-oceanic-and-atmospheric-administrationalaska-fisheries-science-center	National Oceanic and Atmospheric Administration/Alaska Fisheries Science Center		2025-09-22 14:15:21.52556	active	group	approved		f
578dd6fa-f3e7-4b1f-98c0-9707a0943ba8	acadia-university	Acadia University		2025-09-22 14:15:23.228046	active	group	approved		f
5a985427-7f22-46d7-bd22-aeddc7ad3e10	maritimes-region-fisheries-and-oceans-canada	Maritimes Region, Fisheries and Oceans Canada		2025-09-22 14:15:24.958965	active	group	approved		f
3670b7bd-946d-4ef5-81a5-7b096970fffc	oregon-state-university	Oregon State University		2025-09-22 14:15:26.690733	active	group	approved		f
f677db11-cdfc-4368-9ce0-121944ca84a1	california-academy-of-sciences-department-of-ichthyology	California Academy of Sciences - Department of Ichthyology		2025-09-22 14:15:28.393187	active	group	approved		f
d7e650cc-411b-407f-955a-b6613b4c90bb	demokritos-institute-of-biosciences-and-applications	Demokritos, Institute of Biosciences and Applications		2025-09-22 14:15:30.141898	active	group	approved		f
a8d5729e-7683-4bed-97ba-41d0e3be5256	national-academy-of-sciences-of-ukraine-institute-of-biology-of-the-southern-seas-department-of	National Academy of Sciences of Ukraine – Institute of Biology of the Southern Seas – Department of plankton		2025-09-22 14:15:31.880626	active	group	approved		f
8a296a60-bfde-49d2-97fe-fcd2324f0bdd	cumbria-biodiversity-data-centre	Cumbria Biodiversity Data Centre		2025-09-22 14:15:33.59199	active	group	approved		f
1d23733b-3ed4-4ed6-8b3f-fae276fedec8	centre-de-recherche-scientifique-de-conakry-rogbane	Centre de Recherche Scientifique de Conakry Rogbanè		2025-09-22 14:15:35.360786	active	group	approved		f
3e1fb479-298b-4eff-941a-f310e8d3d577	vanuatu-fisheries-department	Vanuatu Fisheries Department		2025-09-22 14:15:37.089943	active	group	approved		f
14d675a7-d1f2-49ea-9a1e-162eb685c77a	universite-du-quebec-a-chicoutimi	Université du Québec à Chicoutimi		2025-09-22 14:15:38.819817	active	group	approved		f
39a98f06-6b1a-4992-9a3b-d9bb8a8e4b6e	university-of-bergen	University of Bergen		2025-09-22 14:15:40.523405	active	group	approved		f
9db06246-8fe2-4beb-a72b-955c2c4b900a	federal-university-of-rio-grande-furg-rio-grande	Federal University of Rio Grande-FURG, Rio Grande		2025-09-22 14:15:42.252968	active	group	approved		f
f94f0237-b7ba-4017-8822-ee1f639aa822	csiro-oceans-atmosphere-indian-ocean-marine-research-centre	CSIRO Oceans & Atmosphere, Indian Ocean Marine Research Centre		2025-09-22 14:15:44.09177	active	group	approved		f
18766a0e-02b1-4822-a081-482843b09fbd	us-geological-survey-wetland-and-aquatic-research-center	U.S. Geological Survey – Wetland and Aquatic Research Center		2025-09-22 14:15:45.790947	active	group	approved		f
cc0710f8-adae-4cd6-a2e7-4c7952cbf434	university-of-southern-maine	University of Southern Maine		2025-09-22 14:15:47.527668	active	group	approved		f
8a6b18a8-42f3-4dab-ad4c-d955e42f45da	bureau-of-safety-and-environmental-enforcement	Bureau of Safety and Environmental Enforcement		2025-09-22 14:15:49.301962	active	group	approved		f
5c3cc68d-d631-48bc-b014-21ccf3575b4b	bureau-of-ocean-energy-management-of-the-us-department-of-the-interior	Bureau of Ocean Energy Management of the US Department of the Interior		2025-09-22 14:15:51.021923	active	group	approved		f
71f19e42-5d5f-4e60-b210-d7ace05fa1ce	museo-nazionale-dellantartide-genova	Museo Nazionale dell'Antartide, Genova		2025-09-22 14:15:52.725803	active	group	approved		f
cd0f0ebf-9da5-4c2c-b659-5c38c2110585	government-of-south-australia-department-for-environment-and-water	Government of South Australia — Department for Environment and Water		2025-09-22 14:15:56.218325	active	group	approved		f
957e2ff4-5c75-4e3f-bab1-475aa7a49bce	university-college-cork-coastal-and-marine-research-centre	University College Cork, Coastal and Marine Research Centre		2025-09-22 14:15:57.952159	active	group	approved		f
22350a3c-c83e-45f2-adc5-9808b43af107	ministry-of-agriculture-and-fisheries	Ministry of Agriculture and Fisheries		2025-09-22 14:15:59.656093	active	group	approved		f
0a6bdabd-17d3-46b8-b8b7-2acbdafadd4f	hellenic-centre-for-marine-research-institute-of-oceanography	Hellenic Centre for Marine Research - Institute of Oceanography		2025-09-22 14:16:01.429497	active	group	approved		f
a9d14ae5-3e72-4fd6-aa83-df22c98f88f0	museum-national-dhistoire-naturelle-departement-ecologie-et-gestion-de-la-biodiversite-umr-7204	Muséum national d'Histoire naturelle – Département Ecologie et Gestion de la Biodiversité (UMR 7204 : CERSP55)		2025-09-22 14:16:03.214519	active	group	approved		f
790f7f15-d509-4411-9793-6109e8d44ae6	ocean-mineral-singapore-pte-ltd	Ocean Mineral Singapore Pte. Ltd.		2025-09-22 14:16:04.990792	active	group	approved		f
56b34daf-4f9b-4903-bcb5-141dd7e57416	bigelow-laboratory-for-ocean-sciences	Bigelow Laboratory for Ocean Sciences		2025-09-22 14:16:06.772488	active	group	approved		f
319ddbdb-0b65-49af-a139-b2442cabc7fe	instituto-del-mar-del-peru	Instituto del Mar del Perú		2025-09-22 14:16:08.493	active	group	approved		f
d8330346-9980-462b-bbfd-68c0f11b5d29	china-ocean-mineral-resources-research-and-development-association	China Ocean Mineral Resources Research and Development Association		2025-09-22 14:16:11.355085	active	group	approved		f
1cd90651-b3f0-4fad-ab76-be61c5594c3d	canadian-healthy-oceans-network	Canadian Healthy Oceans Network		2025-09-22 14:16:13.054687	active	group	approved		f
ebaf77ce-93bf-4735-a41f-d26a9a678c16	trinity-college-dublin-centre-for-environmental-humanities	Trinity College Dublin, Centre for Environmental Humanities		2025-09-22 14:16:15.790866	active	group	approved		f
7c943458-177c-489a-911a-c25531396c79	marshall-islands-marine-resources-authority	Marshall Islands Marine Resources Authority		2025-09-22 14:16:17.520515	active	group	approved		f
55aa18f2-1792-4a23-93dc-ebda8ee05769	geoscience-australia	Geoscience Australia		2025-09-22 14:16:19.426461	active	group	approved		f
33a71dd7-05c3-4b7c-bb9d-4bc5c73bbba4	university-of-the-aegean-lesvos	University of the Aegean, Lesvos		2025-09-22 14:16:21.221541	active	group	approved		f
f3f82d23-b44c-4229-b616-e7fa7419cafa	instituto-milenio-de-oceanografia	Instituto Milenio de Oceanografía		2025-09-22 14:16:22.963216	active	group	approved		f
4e23aad2-247e-41df-a8b8-359b9157fd62	comision-colombiana-del-oceano	Comisión Colombiana del Océano		2025-09-22 14:16:24.68443	active	group	approved		f
15ccbbcb-4b8e-4b97-8297-c486593f7a76	universidade-federal-do-rio-grande-instituto-de-oceanografia	Universidade Federal do Rio Grande, Instituto de Oceanografia		2025-09-22 14:16:26.426957	active	group	approved		f
781f9b8e-bdce-4400-9519-2c072a788345	senckenberg-research-institute-german-centre-for-marine-biodiversity-research	Senckenberg Research Institute — German Centre for Marine Biodiversity Research		2025-09-22 14:16:28.165493	active	group	approved		f
06976510-431b-47ad-95c5-b0205ec11367	coinatlantic-dalhousie-university	COINAtlantic Dalhousie University		2025-09-22 14:16:29.92518	active	group	approved		f
bc254a05-5330-4808-b9df-905609fb2f95	columbia-university	Columbia University		2025-09-22 14:16:31.660172	active	group	approved		f
273eda46-d046-4410-8132-10e776acdb86	allied-whale	Allied Whale		2025-09-22 14:16:33.35864	active	group	approved		f
e076a784-c13a-4875-8260-7db7edc1ace3	terrestrial-ecosystem-research-network	Terrestrial Ecosystem Research Network		2025-09-22 14:16:35.155903	active	group	approved		f
c0f0cc1b-3957-481e-bd3a-2ce18a3485a9	universitat-de-barcelona	Universitat de Barcelona		2025-09-22 14:16:36.899009	active	group	approved		f
2fb53a11-bc7b-4382-9103-4169636ce0c8	memorial-university-of-newfoundland	Memorial University of Newfoundland		2025-09-22 14:16:38.697586	active	group	approved		f
3161c47e-40d4-476f-aa67-af91613c6b05	national-academy-of-sciences-of-ukraine-institute-of-marine-biology	National Academy of Sciences of Ukraine , Institute of Marine Biology		2025-09-22 14:16:40.457375	active	group	approved		f
7daf6658-d28d-4996-ae3a-d1bc3a588624	government-of-western-australia-department-of-biodiversity-conservation-and-attractions	Government of Western Australia — Department of Biodiversity, Conservation and Attractions		2025-09-22 14:16:42.164469	active	group	approved		f
e030f2f2-bc17-4bfc-b79f-0766cc77c538	national-museum-of-wales-departement-of-biodiversity-and-systematic-biology	National Museum of Wales – Departement of Biodiversity and Systematic Biology		2025-09-22 14:16:43.955136	active	group	approved		f
c47dcbae-9ede-452b-96ce-a36b2f7c1502	the-costa-lab	The Costa Lab		2025-09-22 14:16:45.923526	active	group	approved		f
8c04baba-b920-4a37-bb07-6abf7073447c	curtin-university-of-technology	Curtin University of Technology		2025-09-22 14:16:47.689738	active	group	approved		f
5f584f24-3c78-470b-ae63-730e55531cad	atlas-of-life	Atlas of life		2025-09-22 14:16:49.489454	active	group	approved		f
7e4b70fe-a40d-49e4-a6b1-8bc5cf7060ca	envirosphere-consultants-ltd	Envirosphere Consultants Ltd		2025-09-22 14:16:51.18741	active	group	approved		f
4091fe33-4ada-430a-a7af-29988307eb8b	northwest-atlantic-fisheries-organization	Northwest Atlantic Fisheries Organization		2025-09-22 14:16:52.891191	active	group	approved		f
9534a9bd-538e-449b-8d38-a11bbb125157	pacific-fisheries-research-center-tinro-center	Pacific Fisheries Research Center (TINRO-Center)		2025-09-22 14:16:54.590687	active	group	approved		f
ea1b9a7d-6bc9-4e7b-a203-f9675c718e12	csiro-ecosystem-sciences	CSIRO Ecosystem Sciences		2025-09-22 14:16:56.324562	active	group	approved		f
5e2a5f0e-4bae-4ee6-a1f6-a83b7fc05983	ruhr-universitat-bochum-fakultat-fur-biologie-und-biotechnologie-evolutionsokologie-und	Ruhr-Universität Bochum – Fakultät für Biologie und Biotechnologie – Evolutionsökologie und Biodiversität der Tiere		2025-09-22 14:16:58.064437	active	group	approved		f
1c6b0c0c-f86d-4b92-b65b-75c21042fb8e	louisiana-state-university-department-of-oceanography-and-coastal-sciences	Louisiana State University – Department of Oceanography and Coastal Sciences		2025-09-22 14:16:59.792472	active	group	approved		f
95a7fa73-5bb4-46c3-ac72-e9555e97a129	university-of-north-carolina-wilmington-department-of-biology-and-marine-biology	University of North Carolina Wilmington – Department of Biology and Marine Biology		2025-09-22 14:17:03.243399	active	group	approved		f
38cf0810-99e0-4ea4-a6b7-87103db5bd51	linstitut-superieur-des-sciences-et-de-medecine-veterinaire-de-dalaba	L'Institut Supérieur des Sciences et de Médecine Vétérinaire de Dalaba 		2025-09-22 14:17:01.5058	active	group	approved		f
896717b9-05b3-4b2b-8a38-22371e16353a	columbia-university-lamont-doherty-earth-observatory	Columbia University, Lamont-Doherty Earth Observatory		2025-09-22 14:17:06.826553	active	group	approved		f
2f740479-94fc-4f47-823e-76f41a10a7b9	department-of-conservation-whangarei-office	Department of Conservation – Whangarei Office		2025-09-22 14:17:08.624989	active	group	approved		f
320c32cf-8bde-428e-a241-5a1a1ebc923a	brown-university-department-of-ecology-and-evolutionary-biology	Brown University, Department of Ecology and Evolutionary Biology		2025-09-22 14:17:10.408851	active	group	approved		f
a4e695b8-5b32-41d2-9f6a-729f9e7d8861	university-of-washington-school-of-aquatic-fishery-sciences	University of Washington, School of Aquatic & Fishery Sciences		2025-09-22 14:17:12.123517	active	group	approved		f
76444f19-f085-4f64-b58c-831be1b301c5	duke-university-department-of-biology	Duke University, Department of Biology		2025-09-22 14:17:13.822392	active	group	approved		f
26d3f977-6e82-4581-b1c6-c5cf1ae82370	university-of-new-mexico-department-of-biology	University of New Mexico - Department of Biology		2025-09-22 14:17:15.554633	active	group	approved		f
31724b87-bf0c-4298-80eb-e24291b984fa	blackbeard-biologic-science-and-environmental-advisors	Blackbeard Biologic – Science and Environmental Advisors		2025-09-22 14:17:17.959046	active	group	approved		f
77d6ca18-7168-43d0-9972-4975c20cc79a	santa-barbara-museum-of-natural-history-department-of-invertebrate-zoology	Santa Barbara Museum of Natural History — Department of Invertebrate Zoology		2025-09-22 14:17:19.712903	active	group	approved		f
ea3a236c-45d7-4c32-919a-c10da2dd7860	royal-british-columbia-museum-natural-history-section	Royal British Columbia Museum – Natural History Section		2025-09-22 14:17:21.423153	active	group	approved		f
0e2c5d11-b457-4591-a6fd-ccdca7c374e7	marine-megafauna-foundation	Marine Megafauna Foundation		2025-09-22 14:17:23.255098	active	group	approved		f
a97a215d-523e-4f91-8367-44d18fefd38c	georgia-aquarium	Georgia Aquarium		2025-09-22 14:17:25.108554	active	group	approved		f
59466127-5c6e-43ad-853f-d9e1a37ec452	marine-biodiversity-observation-network-southern-california-bight	Marine Biodiversity Observation Network – Southern California Bight		2025-09-22 14:17:26.815956	active	group	approved		f
1e64082e-1d09-4520-91e2-6ddf17f84332	universidad-de-antioquia	Universidad de Antioquia		2025-09-22 14:17:28.552469	active	group	approved		f
21bf7239-177e-4a8a-9680-51331a64e26e	royal-belgian-institute-for-natural-sciences-directorate-natural-environment-conservation-biology	Royal Belgian Institute for Natural Sciences – Directorate Natural Environment – Conservation Biology Unit		2025-09-22 14:17:30.333908	active	group	approved		f
38755801-6e78-4e0a-94af-c7791e702f6e	ministry-of-natural-resources	Ministry of Natural Resources		2025-09-22 14:17:32.06468	active	group	approved		f
7912a981-e5a0-4975-b53d-30830d129ca1	universite-laval-departement-de-biologie	Université Laval – Departement de biologie		2025-09-22 14:17:33.79969	active	group	approved		f
b0992960-4c48-45f3-9e16-c1f1bad299f6	russian-academy-of-sciences-zoological-institute-laboratory-of-marine-research	Russian Academy of Sciences - Zoological Institute - Laboratory of Marine Research		2025-09-22 14:17:35.572685	active	group	approved		f
bf0c1ec5-ac35-47ff-a6a8-5f84795bfd02	technopole-brest-iroise	Technopole Brest Iroise		2025-09-22 14:17:37.322585	active	group	approved		f
baba4053-fb2e-4edb-be66-944cfc931bd2	university-of-florence-department-of-biology	University of Florence – Department of Biology		2025-09-22 14:17:39.032991	active	group	approved		f
e7c382c7-84b1-40bd-af9c-b7933c66bfbe	universita-di-cagliari-facolta-di-ingegneria-e-architettura	Università di Cagliari – Facoltà di ingegneria e architettura		2025-09-22 14:17:40.757777	active	group	approved		f
b8049a5b-f24a-43a6-8262-504a5173708d	laboratory-for-polar-ecology	Laboratory for Polar Ecology		2025-09-22 14:17:42.484952	active	group	approved		f
c199db40-ff32-499e-9257-ae6c8007bc94	istituto-nazionale-di-oceanografia-e-di-geofisica-sperimentale-trieste	Istituto Nazionale di Oceanografia e di Geofisica Sperimentale, Trieste		2025-09-22 14:17:44.217631	active	group	approved		f
0cff2f7b-0fe9-4942-a56a-51fc4135d432	university-of-maryland-college-park	University of Maryland, College Park		2025-09-22 14:17:45.889805	active	group	approved		f
081bdd5a-3455-4cf1-9ed9-ddd146a2d170	stony-brook-university	Stony Brook University		2025-09-22 14:17:47.589431	active	group	approved		f
a5b41d40-894b-4eb5-80ca-122ebdf7ff39	oceanites-inc	Oceanites, Inc.		2025-09-22 14:17:49.360157	active	group	approved		f
65488a08-d482-4264-a0c2-f8bd06ef4a4e	rutgers-university-institute-of-marine-and-coastal-sciences	Rutgers University, Institute of Marine and Coastal Sciences		2025-09-22 14:17:51.119834	active	group	approved		f
2f7e4c19-87d1-4268-af7d-c6cb5fa8d769	university-of-tokyo-atmosphere-and-ocean-research-institute	University of Tokyo – Atmosphere and Ocean Research Institute		2025-09-22 14:17:52.824712	active	group	approved		f
6cfd8035-e247-4504-971b-caadee81763b	university-of-glasgow	University of Glasgow		2025-09-22 14:17:54.560184	active	group	approved		f
e73a8255-71d5-41f9-933b-a18e901e3615	conservacion-informacion-y-estudio-sobre-cetaceos	Conservación, Información y Estudio sobre Cetáceos		2025-09-22 14:17:56.323634	active	group	approved		f
c1b5e8af-b036-40dc-a2bc-d1c42ae78ae3	national-research-council-canada-halifax	National Research Council Canada, Halifax		2025-09-22 14:17:58.057265	active	group	approved		f
05204486-dab3-42ed-9ec0-1403a353a042	centre-de-recherche-oceanographique-de-dakar-thiaroye-crodt-isra-lpaosf-esp-ucad	Centre de Recherche Océanographique de Dakar Thiaroye (CRODT-ISRA)/ LPAOSF-ESP-UCAD		2025-09-22 14:17:59.921537	active	group	approved		f
6b76c48f-efa2-448a-af46-c3d5f6d4665d	greenland-institute-of-natural-resources	Greenland Institute Of Natural Resources		2025-09-22 14:18:03.227694	active	group	approved		f
f8fe8f1e-6d61-4f83-8bf3-471a5bc6fb26	coonamessett-farm-foundation	Coonamessett Farm Foundation		2025-09-22 14:18:05.037751	active	group	approved		f
ed012786-9b56-4575-821e-808d8b7e5d73	sinop-university-fisheries-faculty	Sinop University, Fisheries Faculty		2025-09-22 14:18:06.856705	active	group	approved		f
50cf7216-e271-4ebc-ac4d-23566f026653	porcupine-marine-natural-history-society	Porcupine Marine Natural History Society		2025-09-22 14:18:08.633086	active	group	approved		f
85fcf0e2-d821-4784-98ba-2402db3fb55f	coastal-research-and-education-society-of-long-island	Coastal Research and Education Society of Long Island		2025-09-22 14:18:10.40098	active	group	approved		f
6dd01f72-a424-45d2-a833-25cdb99143ef	fisheries-and-oceans-canada-prince-edward-island	Fisheries and Oceans Canada – Prince Edward Island		2025-09-22 14:18:12.3512	active	group	approved		f
6d091871-5558-47f4-9ba9-91a9b1454f9c	klaipedos-universitetas	Klaipėdos Universitetas		2025-09-22 14:18:14.141069	active	group	approved		f
9d85f7e1-e1eb-4eb7-9d05-0dd34eaeff47	instituto-oceanografico-de-venezuela-universidad-de-oriente	Instituto Oceanográfico de Venezuela, Universidad de Oriente		2025-09-22 14:18:15.862009	active	group	approved		f
f1695411-1b0d-4a9b-b15d-101260a6386d	university-of-iceland	University of Iceland		2025-09-22 14:18:17.556027	active	group	approved		f
b191e299-f7ac-4453-99a8-222f8f84e707	bedford-institute-of-oceanography-marine-ecology-laboratory	Bedford Institute of Oceanography  — Marine Ecology Laboratory		2025-09-22 14:18:19.296402	active	group	approved		f
8e1f44a2-7307-4f93-b8bc-28a8f4392a8f	caleb-university-lagos	Caleb University Lagos		2025-09-22 14:18:21.029347	active	group	approved		f
58b3f3bd-1eae-46d5-900e-11ca507b87fe	european-university-at-saint-petersburg	European University at Saint Petersburg		2025-09-22 14:18:22.822755	active	group	approved		f
ffe9a0f6-afae-481f-b815-213e5b44c6bb	unep-world-conservation-monitoring-centre	UNEP World Conservation Monitoring Centre		2025-09-22 14:18:26.199406	active	group	approved		f
afa505c5-0691-4b6b-b2fc-fa1b57e751a2	university-of-queensland-global-change-institute	University of Queensland — Global Change Institute		2025-09-22 14:18:27.992721	active	group	approved		f
909d5101-5dc0-41a2-b6ce-d937af40f22e	pusat-penelitian-oseanografi-lemabga-ilmu-pengetahuan-indonesia	Pusat Penelitian Oseanografi. Lemabga Ilmu Pengetahuan Indonesia		2025-09-22 14:18:29.762871	active	group	approved		f
c3e73526-c426-4dee-a47c-3b486aa8651c	fisheries-and-oceans-canada-arctic-biological-station	Fisheries and Oceans Canada – Arctic Biological Station		2025-09-22 14:18:31.492323	active	group	approved		f
5b8e8fa3-e48a-4782-b20a-84bf98f25fbd	hellenic-centre-for-marine-research-institute-of-marine-biological-resources-and-inland-waters	Hellenic Centre for Marine Research - Institute of Marine Biological Resources and Inland Waters		2025-09-22 14:18:33.261198	active	group	approved		f
488609bd-f95a-4c2c-8470-0b2f7c182f80	institut-mauritanien-de-recherche-oceanographique-et-des-peches	Institut Mauritanien de Recherche Océanographique et des Pêches		2025-09-22 14:18:38.036612	active	group	approved		f
a5ad5928-e434-40de-b488-d35fd780af53	brema-laboratory	Brema Laboratory		2025-09-22 14:18:39.894218	active	group	approved		f
6e73238d-12bd-4491-bd28-d2dfe6317b38	koninklijke-nederlandse-academie-van-wetenschappen	Koninklijke Nederlandse Academie van Wetenschappen		2025-09-22 14:18:41.632391	active	group	approved		f
41d2036a-5db3-4b98-9c7d-dd5b9282779b	government-of-the-republic-of-korea	Government of the Republic of Korea		2025-09-22 14:18:43.364457	active	group	approved		f
72d9bde2-e769-40b2-bec5-77ea05d23d15	iranian-national-institute-for-oceanography-and-atmospheric-science	Iranian National Institute for Oceanography and Atmospheric Science		2025-09-22 14:18:45.129331	active	group	approved		f
fbad0960-5aa7-4ef8-813d-0b7065a19739	instituto-venezolano-de-investigaciones-cientificas-centro-de-ecologia	Instituto Venezolano de Investigaciones Científicas – Centro de Ecología		2025-09-22 14:18:46.855088	active	group	approved		f
10b0d4ab-5e7d-43bb-9e87-5d2baf8f98ee	nauru-fisheries-and-marine-resources-authority	Nauru Fisheries and Marine Resources Authority		2025-09-22 14:18:48.563877	active	group	approved		f
3787a1ae-37b2-47b0-9268-230e936245b8	florida-state-university-coastal-and-marine-laboratory	Florida State University Coastal and Marine Laboratory		2025-09-22 14:18:50.452416	active	group	approved		f
94b92c30-177e-4153-b3c7-42ada07b5703	bulgarian-academy-of-sciences-the-institute-of-biodiversity-and-ecosystem-research	Bulgarian Academy of Sciences –The Institute of Biodiversity and Ecosystem Research		2025-09-22 14:18:52.161674	active	group	approved		f
a2aad2ef-dc6d-473f-8f36-a80f57226869	australasian-seabird-group	Australasian Seabird Group		2025-09-22 14:18:55.628368	active	group	approved		f
cd4fe3d9-4bb8-4eb1-adf1-8d77d21b4d90	global-sea-mineral-resources	Global Sea Mineral Resources		2025-09-22 14:18:57.482868	active	group	approved		f
5c53cb4a-d4ef-4ed4-ad1a-c1b26cc5b10a	department-of-fisheries-and-oceans	Department of Fisheries and Oceans		2025-09-22 14:18:59.305008	active	group	approved		f
23514126-0125-4b5b-8b8e-afabd2e718d6	western-australian-parks-and-wildlife-service	Western Australian Parks and Wildlife Service		2025-09-22 14:19:01.026033	active	group	approved		f
7260de8c-8862-4d9d-9114-91b6e74e0799	huntsman-marine-science-centre-atlantic-reference-centre	Huntsman Marine Science Centre - Atlantic Reference Centre		2025-09-22 14:19:02.756832	active	group	approved		f
a907ca4e-8f41-47a1-aced-481293fbc5d9	service-territorial-de-lenvironnement-de-wallis-et-futuna	Service Territorial de l’Environnement de Wallis et Futuna		2025-09-22 14:19:04.482835	active	group	approved		f
83295a28-507f-44ab-94e2-e4e34d5c6dd7	fisheries-research-board-of-canada	Fisheries Research Board of Canada		2025-09-22 14:19:06.207377	active	group	approved		f
ed05a484-94e2-42a7-bc1d-8bb296bc236f	universitat-hamburg-centrum-fur-naturkunde-zoologisches-museum	Universität Hamburg, Centrum für Naturkunde, Zoologisches Museum		2025-09-22 14:19:07.950545	active	group	approved		f
fa671f6c-9f4c-4388-9b46-bf937fdac55e	university-of-lund	University of Lund		2025-09-22 14:19:09.68479	active	group	approved		f
79b8f927-ac45-49e3-a334-18f00d1803dc	department-of-botany-and-plant-biology	Department of botany and plant biology		2025-09-22 14:19:11.411466	active	group	approved		f
ed0423cb-ddf1-488f-8f84-a82481f1cbd9	alexandria-university-faculty-of-science-oceanography-department	Alexandria University-Faculty of Science- Oceanography Department		2025-09-22 14:19:13.167123	active	group	approved		f
1ab918bf-0e1c-472b-abcf-8b3bc2bf13ea	centre-for-whale-research	Centre for Whale Research		2025-09-22 14:19:14.889753	active	group	approved		f
946832e3-55ab-427f-9387-215486006b34	museum-amager	Museum Amager		2025-09-22 14:19:16.597464	active	group	approved		f
e49ae6f8-c969-46ec-bd91-041b3f10e35c	university-of-crete	University of Crete		2025-09-22 14:19:18.294959	active	group	approved		f
c6c56895-34ef-4d72-a81b-7c7edd0f7001	mcgill-university	McGill University		2025-09-22 14:19:19.963622	active	group	approved		f
8ac4554d-ae0a-4299-9cf7-16b8e34b498a	foundation-for-research-and-technology-hellas-institute-of-applied-computational-mathematics	Foundation for Research and Technology - Hellas - Institute of Applied & Computational Mathematics		2025-09-22 14:19:21.695141	active	group	approved		f
48de3fb1-78e5-4d3c-9884-d23e311d355a	museum-national-dhistoire-naturelle-departement-milieux-et-peuplements-aquatiques-umr-borea-7208	Muséum National d'Histoire Naturelle – Département Milieux et Peuplements Aquatiques (UMR BOREA 7208)		2025-09-22 14:19:23.451025	active	group	approved		f
496de303-2fb9-40ca-af98-7827a51a7352	museum-national-dhistoire-naturelle-departement-systematique-et-evolution-umr-7205	Muséum national d’Histoire naturelle — Département Systématique et Évolution (UMR 7205)		2025-09-22 14:19:25.294863	active	group	approved		f
33d16463-04d7-4cdf-9f48-a5b579ea0de0	kenna-eco-diving	Kenna Eco Diving		2025-09-22 14:19:27.031473	active	group	approved		f
2635b358-7f08-4993-9778-d8e0effc64ec	the-marine-environment-monitoring-and-assessment-national-database	 The Marine Environment Monitoring and Assessment National database		2025-09-22 14:18:53.909086	active	group	approved		f
662dbd69-398a-4b2b-8873-aff6f24df360	observatoire-oceanologique-de-villefranche-sur-mer-universite-paris6	Observatoire Océanologique de Villefranche-sur-Mer, Université Paris6		2025-09-22 14:19:28.731744	active	group	approved		f
bee2a67b-338b-4933-9df6-56da7df3b524	dipartimento-di-scienze-della-terra-dellambiente-e-della-vita	Dipartimento di Scienze della terra, dell'ambiente e della vita		2025-09-22 14:19:30.492326	active	group	approved		f
47c7b42f-04b8-4d67-9c22-414f3f9b96da	the-university-of-the-south-pacific	The University of the South Pacific		2025-09-22 14:19:32.216891	active	group	approved		f
64d3bbd4-a41a-4118-9b75-bf9a4248a1fe	institut-fur-polarokologie-der-christian-albrechts-universitat	Institut für Polarökologie der Christian-Albrechts-Universität		2025-09-22 14:19:33.989282	active	group	approved		f
c08fb08b-5f00-432c-a08a-e3a776d5397b	university-of-queensland-st-lucia-campus	University of Queensland, St Lucia Campus		2025-09-22 14:19:35.731986	active	group	approved		f
b9aa7a4f-7705-4116-9b01-42d23853edae	de-beers-group	De Beers Group		2025-09-22 14:19:37.430381	active	group	approved		f
2494cf3d-c036-43e4-b61d-b83c719152ee	corporacion-autonoma-regional-del-magdalena	Corporacion Autonoma Regional del Magdalena		2025-09-22 14:19:39.531488	active	group	approved		f
a31e2fc6-00f9-4ea9-9a02-88ad5d42fdbc	university-of-applied-science-cologne	University of Applied Science, Cologne		2025-09-22 14:19:41.270867	active	group	approved		f
b3d572fb-d2da-4b44-a667-ae05ee60fec8	universite-laval	Université Laval		2025-09-22 14:19:43.023683	active	group	approved		f
6aeca3bd-eb91-4e62-a62b-08d029464ca1	la-coruna-university-department-of-animal-plant-and-ecological-biology	La Coruña University – Department of animal, plant and ecological biology		2025-09-22 14:19:44.79436	active	group	approved		f
42802943-91da-496b-9304-fe05fba26dea	centro-oceanografico-de-canarias-instituto-espanol-de-oceanografia	Centro Oceanográfico de Canarias - Instituto Español de Oceanografía		2025-09-22 14:19:46.533657	active	group	approved		f
b79969d3-8a32-47b2-ab85-3e037a3ebde4	cape-breton-university	Cape Breton University		2025-09-22 14:19:48.298536	active	group	approved		f
762a482a-fbf9-48c6-9323-78a43787cc82	the-university-of-tokyo-atmosphere-and-ocean-research-institute	The University of Tokyo, Atmosphere and Ocean Research Institute		2025-09-22 14:19:50.060611	active	group	approved		f
2e6f20ff-174d-471a-93ca-aa35c937217d	the-a-o-kovalevsky-institute-of-marine-biological-research-of-russian-academia-of-science-department	The A. O. Kovalevsky Institute of Marine Biological Research of Russian Academia of Science –  Department of Plankton		2025-09-22 14:19:51.76264	active	group	approved		f
473e25d2-f6ee-428e-b5b5-c3a6a36c6859	station-marine-dendoume	Station Marine d'Endoume		2025-09-22 14:19:53.553936	active	group	approved		f
56c4c1ab-1610-499e-9a73-48b4106b2020	brachnet	BrachNet		2025-09-22 14:19:55.234404	active	group	approved		f
3a027de3-39cd-40ea-91a3-30051f39b8f2	roskilde-university-department-of-environmental-social-and-spatial-change	Roskilde University – Department of Environmental, Social and Spatial Change		2025-09-22 14:19:56.96407	active	group	approved		f
5dcfaf5b-324f-42fe-994a-33446b036f5c	national-institute-of-polar-research	National Institute of Polar Research		2025-09-22 14:19:58.669822	active	group	approved		f
85ee2140-7aa0-4c83-bf34-263ffc7a7192	national-marine-information-and-research-centre-namibia	National Marine Information and Research Centre Namibia		2025-09-22 14:20:00.427778	active	group	approved		f
97b539c5-bc65-4737-9d7c-cbc95f819e0b	national-university-of-ireland-galway-the-martin-ryan-science-institute-department-of-zoology	National University of Ireland, Galway – The Martin Ryan Science Institute – Department of Zoology		2025-09-22 14:20:02.209882	active	group	approved		f
1e4f1796-a242-403e-ad9d-a634ba595c35	interoceanmetal-joint-organization	Interoceanmetal Joint Organization		2025-09-22 14:20:03.944895	active	group	approved		f
c7f9bed8-88a8-495c-b6fa-91a0584cbc61	cascadia-research	Cascadia Research		2025-09-22 14:20:05.852384	active	group	approved		f
e419466f-fa01-410e-9927-aa4adec6cc6c	african-marine-mammal-conservation-organisation	African Marine Mammal Conservation Organisation		2025-09-22 14:20:07.753781	active	group	approved		f
06a07584-f542-4afe-aeb5-b6473a741d99	associacao-para-investigacao-costeira-e-marinha	Associação para Investigação Costeira e Marinha		2025-09-22 14:20:09.681138	active	group	approved		f
91866e0e-2d75-4f9d-9832-31a6bee7ab05	plankton-society-of-japan	Plankton Society of Japan		2025-09-22 14:20:13.05968	active	group	approved		f
b0cfdfdb-da1c-4c7f-ae7b-7e97cc6e6ff0	universidad-de-bogota-jorge-tadeo-lozano-santa-marta	Universidad de Bogota Jorge Tadeo Lozano, Santa Marta		2025-09-22 14:20:14.799676	active	group	approved		f
0454d9bd-c0c6-4ccb-a0ff-93ea450caef0	tennenbaum-marine-observatories-network	Tennenbaum Marine Observatories Network		2025-09-22 14:20:16.535353	active	group	approved		f
2a37b414-184e-465b-9889-51dedbad61e0	norwegian-institute-for-water-research	Norwegian  Institute for Water Research		2025-09-22 14:20:18.224057	active	group	approved		f
95ff4110-38f2-45ea-9590-7c4b98d42ed3	centre-destudis-avancats-de-blanes	Centre d'Estudis Avançats de Blanes		2025-09-22 14:20:19.928965	active	group	approved		f
8807331f-2acd-4ffb-a11a-ecf63932938a	university-of-hawaii-department-of-biology-fisheries-ecology-research-laboratory	University of Hawaii — Department of Biology — Fisheries Ecology Research Laboratory		2025-09-22 14:20:21.655369	active	group	approved		f
f9111607-a254-4e22-b446-4bc1bfd47e26	national-geographic-society-pristine-seas	National Geographic Society — Pristine Seas		2025-09-22 14:20:23.4571	active	group	approved		f
7c0e278e-3d30-460b-b9d5-f01019e7e567	us-national-park-service-kalaupapa-national-historical-park	US National Park Service — Kalaupapa National Historical Park		2025-09-22 14:20:25.587344	active	group	approved		f
03fd422e-1128-426a-b018-5edc03f91bb6	schleswig-holstein-landesamt-fur-landwirtschaft-umwelt-und-landliche-raume	Schleswig-Holstein – Landesamt für Landwirtschaft, Umwelt und ländliche Räume		2025-09-22 14:20:27.526271	active	group	approved		f
cf982b50-f875-4821-9115-d3ab3cd534ae	universitat-zu-kiel-institut-fur-okosystemforschung	Universität zu Kiel — Institut für Ökosystemforschung	Address: Olshausenstrasse 75, Kiel, D-24118, Germany\nAcronym: ÖSF	2025-09-22 14:20:29.307852	active	group	approved		f
ecc5ea65-f993-4aa6-8fa4-1ab289353b41	marecamp	Marecamp	Address: Lungomare Scardamiano, 1, 95021 Aci Castello CT, Italy, Aci Castello, Italy	2025-09-22 14:20:32.920834	active	group	approved		f
7436a13d-9f88-4db9-b5c7-e8606faeb723	smithsonian-institution	Smithsonian Institution	Address: PO Box 37012NHB MRC 106, Washington, DC, 20013-7012, United States of America\nAcronym: SI\nOcean Expert Members: 4	2025-09-22 14:20:34.72252	active	group	approved		f
0752d200-4b76-48e7-bff3-76aa8e25a23a	south-australian-museum-department-of-marine-invertebrates	South Australian Museum – Department of Marine Invertebrates	Address: GPO Box 234, South Australia, 5000, Australia	2025-09-22 14:20:40.070994	active	group	approved		f
8e19eb22-322f-44ec-84e3-252063a113cf	deep-ocean-resources-development-co-ltd	Deep Ocean Resources Development Co. Ltd.	Address: 1-3-15, Nihombashihoridomecho Towanihombashihoridome Bldg. 2F. , Chuo-Ku, 103-0012, Japan\nAcronym: DORD	2025-09-22 14:20:41.864198	active	group	approved		f
edc723c1-5850-4b0d-8336-441378903b91	acadia-centre-for-estuarine-research	Acadia Centre for Estuarine Research	Address: Acadia University, Box 115,  23 Westwood Avenue, Wolfsville, Nova Scotia, Canada\nAcronym: ACER	2025-09-22 14:20:48.81192	active	group	approved		f
6ea78550-2cc0-465c-8624-3d18d8923e71	pennsylvania-state-university	Pennsylvania State University	Address: 201 Old Main, , University Park, Pennsylvania, 16802, United States of America\nAcronym: PennState\nOcean Expert Members: 2	2025-09-22 14:20:52.259947	active	group	approved		f
713c12dd-e249-43b2-ae63-8a1778bde3d6	universidad-ces	Universidad CES	Address: Calle 10 #22-04, Universidad CES, El Poblado, Bloque B- Oficinas profesores 5to. piso, Medellin, Antioquia, 050021, Colombia\nAcronym: Universidad CES\nActivities: Teacher/research about coastal marine ecosystems, specially about biodiversity and ecological interactions\nOcean Expert Members: 3	2025-09-22 14:20:54.018467	active	group	approved	instituteLogo.jpg	f
64b55e5c-b41c-4b45-8286-fc183fc1e22b	national-academy-of-sciences-i-i-schmalhausen-institute-of-zoology	National Academy of Sciences – I. I. Schmalhausen Institute of Zoology	Address: Vul. B. Khmelnytskogo, 15, Kyiv, 01030, Ukraine	2025-09-22 14:20:57.537676	active	group	approved		f
a075242f-cc8f-4715-aeee-67effbd099b0	national-oceanic-atmospheric-administration-national-marine-fisheries-service	National Oceanic & Atmospheric Administration, National Marine Fisheries Service	Address: 1315 East West Hwy, Silver Spring, MD, 20910, United States of America\nAcronym: NOAA/NMFS\nOcean Expert Members: 3	2025-09-22 14:20:59.385955	active	group	approved		f
1b0cfdcd-04f2-4e67-a455-594cdf99925d	institute-for-coastal-marine-environment-national-research-council	Institute for Coastal Marine Environment - National Research Council	Address: Località Sa MardiniTorregrande, Oristano, 09170, Italy\nAcronym: IAMC-CNR\nOcean Expert Members: 1	2025-09-22 14:21:03.198502	active	group	approved		f
531735c5-33bc-4a17-9905-5cbb84d92027	suffolk-university-biology-department	Suffolk University – Biology Department	Country: United States of America	2025-09-22 14:21:05.005888	active	group	approved		f
4cb9a9b0-e4f6-4b64-a1ae-cb455ee7a8fb	universidad-del-zulia	Universidad del Zulia	Address: Av. 16 con calle 67 B, Maracaibo, Zulia, Maracaibo, Zulia, 4001, Venezuela (Bolivarian Republic of)\nAcronym: LUZ\nOcean Expert Members: 2	2025-09-22 14:21:06.883314	active	group	approved		f
21d6bbfc-e133-4a04-9e16-5e37479de70b	nova-scotia-museum	Nova Scotia Museum	Address: 1747 Summer St, Halifax, NS B3H 3A6, Canada	2025-09-22 14:21:09.002676	active	group	approved		f
4778b9bb-91a2-47ce-99d3-fa0265cb20ac	ecocentro-puerto-madryn	Ecocentro Puerto Madryn	Address: Jules Verne 3784, Puerto Madryn , Chubut, U9120OJA, Argentina	2025-09-22 14:21:13.034914	active	group	approved		f
1242c07b-ffab-4f55-b8ab-94bc4970f5d2	university-of-western-australia-centre-for-marine-futures	University of Western  Australia, Centre for Marine Futures	Address: 35 Stirling Highway, Crawley , 6009,, Australia	2025-09-22 14:21:14.818374	active	group	approved		f
0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	azura-consulting-llc	Azura Consulting LLC	Address: n/a, n/a, n/a, United States of America\nActivities: Azura offers a variety of environmental consulting services focused on the research, conservation and management of protected species and habitats.	2025-09-22 14:21:18.424291	active	group	approved		f
eef94ec3-bca8-4b26-b6f3-9324d7f9799c	dalhousie-university-department-of-biology	Dalhousie University – Department of Biology	Address: 1355 Oxford Street, 8th Floor Life Sciences Centre (Biology), Halifax, Nova Scotia, B3H 4R2, Canada	2025-09-22 14:21:22.042832	active	group	approved		f
db358bae-c6bd-4a7f-8726-4b217cf389f5	aquarium-de-paris	Aquarium de Paris	Address: 5 avenue Albert de Mun  , Paris, 75016, France	2025-09-22 14:21:23.827914	active	group	approved		f
d76ba351-d472-460f-8569-4a832ef633ac	geo-tag-der-natur	GEO-Tag der Natur	Address: Rödingsmarkt 14, Hamburg, 20459, Germany\nActivities: <span>seit 2017 heisst der GEO-Tag der Artenvielfalt GEO-Tag der Natur.</span>	2025-09-22 14:21:25.523473	active	group	approved		f
8f98c818-40b2-42db-9121-4cc68b3bf2a8	university-of-calabar	UNIVERSITY OF CALABAR	Address: Eta-agbor, P.M.B 1115, CALABAR , 540004, Nigeria\nAcronym: UNICAL\nOcean Expert Members: 8	2025-09-22 14:21:30.99254	active	group	approved	instituteLogo.jpg	f
bb75c8dd-1dea-41b4-bc1d-725b29129e62	stockholm-university-department-of-systems-ecology	Stockholm University, Department of Systems Ecology	Address: Svante Arrhenius väg 21 AFrescati Backe, Stockholm, SE-106 91 , Sweden\nActivities: Research and teaching in the Department of Systems Ecology at Stockholm University focuses on the study of ecosystems and on sustainable use of natural resources\nOcean Expert Members: 2	2025-09-22 14:21:32.824112	active	group	approved	instituteLogo.jpg	f
bdc0848a-c777-49c3-ae3e-d2428c4465a6	universidad-nacional-autonoma-de-mexico-facultad-de-ciencias	Universidad Nacional Autonoma de Mexico, Facultad de Ciencias	Address: UNAM campus, Coyoacán, Yucatan, 04510, Mexico\nAcronym: UNAM UMDI Sisal\nActivities: <div><div></div></div> <div><div>Research on biodiversity of different taxonomic groups</div></div><br>\nOcean Expert Members: 6	2025-09-22 14:21:36.267627	active	group	approved		f
80e4933e-9e6d-4b53-afa6-65891c39b594	museum-of-new-zealand-te-papa-tongarewa	Museum of New Zealand Te Papa Tongarewa	Address: 55 Cable Street, PO Box 467, Wellington, 6011, New Zealand	2025-09-22 14:21:45.196915	active	group	approved		f
a389d6aa-e9ba-4af1-a86e-6ec8dca6fbf4	ornithological-society-of-new-zealand	Ornithological Society of New Zealand	Address: PO Box 834, Nelson, 7040, New Zealand\nAcronym: Birds NZ	2025-09-22 14:21:47.02941	active	group	approved		f
dafcfb4f-d7b8-45d3-9b61-e872659c975e	universidad-nacional-de-la-patagonia-austral-unidad-academica-caleta-olivia	Universidad Nacional de la Patagonia Austral - Unidad Académica Caleta Olivia	Address: Ruta Nacional 3, Caleta Olivia, Santa Cruz, 9011, Argentina\nAcronym: UNPA - UACO\nOcean Expert Members: 4	2025-09-22 14:21:48.835666	active	group	approved		f
59e8c52c-1e3d-49c2-9070-83cacf6a95c9	vlaamse-overheid-instituut-voor-natuur-en-bosonderzoek-afdeling-biodiversiteit-en-natuurlijk-milieu	Vlaamse overheid - Instituut voor Natuur- en Bosonderzoek - Afdeling Biodiversiteit en Natuurlijk Milieu - Onderzoeksgroep Ecosysteemdiversiteit	Address: Herman Teirlinckgebouw, Havenlaan 88 bus 73, Brussel, 1000, Belgium	2025-09-22 14:21:56.018733	active	group	approved		f
ed7bd8d8-ceb7-45b5-8cab-c28ea30fd2bb	tromso-university-museum	Tromso University Museum	Address: Lars Thørings veg 10 9006 Tromsø, Tromsø, Norway	2025-09-22 14:21:57.788176	active	group	approved		f
c22f3f61-efb4-43c2-8b85-eff313c57d92	arta-fisheries-department	Arta Fisheries Department	Address: Φλέμινγκ 6, Arta, TK 47132, Greece	2025-09-22 14:22:01.256567	active	group	approved		f
e97f5314-0d0e-4acd-8135-2b38cab75330	hartpury-college-and-university-centre	Hartpury College and University Centre	Address: Hartpury House , Gloucester, GL19 3BE, United Kingdom of Great Britain and Northern Ireland	2025-09-22 14:22:02.974668	active	group	approved		f
39ca8137-231e-497d-ae22-de66bc25d7a9	acadia-university-department-of-biology	Acadia University - Department of Biology	Address: 33 Westwood Avenue, Wolfsville, NS, B4P 2R6, Canada	2025-09-22 14:22:04.691762	active	group	approved		f
350c9b99-8b67-4836-8aa0-3ff8e1046072	auckland-council	Auckland Council	Address: Private Bag 92300    , Victoria Street West    , Auckland,  1142, New Zealand	2025-09-22 14:22:06.491306	active	group	approved		f
8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	centro-austral-de-investigaciones-cientificas	Centro Austral de Investigaciones Científicas	Address: Bernardo Houssay 200,  9410, Ushuaia, Tierra del Fuego, Argentina\nAcronym: CADIC\nOcean Expert Members: 15	2025-09-22 14:22:09.995704	active	group	approved	instituteLogo.jpg	f
3aef56bf-23cb-4135-ac0d-224a1d8545e5	goteborgs-naturhistoriska-museum	Göteborgs naturhistoriska museum	Address: Museivägen 10, Göteborg, 413 11, Sweden	2025-09-22 14:22:11.701547	active	group	approved		f
86610961-056c-4151-9c4e-3f6bb20c3832	universita-degli-studi-di-padova-dipartimento-di-geoscienze	Universita degli Studi di Padova — Dipartimento di Geoscienze	Address: Via Gradenigo, 6, Padova, 35131, Italy	2025-09-22 14:22:13.535578	active	group	approved		f
e4478358-2dcf-4384-b600-08b0e0de1c95	ecology-action-centre	Ecology Action Centre	Address: 2705 Fern Lane, Halifax, NS B3K 4L3, Canada	2025-09-22 14:22:15.260171	active	group	approved		f
d724cd5d-9e63-41bb-8e5d-73bb841f6cd5	csiro-oceans-and-atmopheric-research-brisbane	CSIRO Oceans and Atmopheric Research (Brisbane)	Country: Australia	2025-09-22 14:22:18.670771	active	group	approved		f
88075da4-0351-4e14-a7da-6114f0309775	dalhousie-university-department-of-oceanography	Dalhousie University, Department of Oceanography	Address: 1355 Oxford Street PO Box 15000, Halifax, NS, B3H 4R2, Canada\nOcean Expert Members: 8	2025-09-22 14:22:20.401682	active	group	approved		f
46b0d887-58bf-4976-be93-cfe1f1bb40bc	koninklijk-belgisch-instituut-voor-natuurwetenschappen-departement-invertebraten	Koninklijk Belgisch Instituut voor Natuurwetenschappen — Departement Invertebraten	Address: Vautierstraat 29, Brussel, 1000, Belgium	2025-09-22 14:22:22.407618	active	group	approved		f
d872e3e6-54fc-4a24-9c6f-c108d3d8696b	university-of-belgrade	University of Belgrade	Address: Studentski trg 1, Beograd, Serbia	2025-09-22 14:22:25.968305	active	group	approved		f
a2984ea7-0216-4f24-92ed-735096343c7d	agencia-nacional-de-hidrocarburos	Agencia Nacional de Hidrocarburos	Address: Calle 26 # 59-65 piso 2, Bogotá, Cundinamarca, 111321204, Colombia\nAcronym: ANH\nActivities: Promover el aprovechamiento óptimo y sostenible de los recursos hidrocarburíferos de Colombia, administrándolos integralmente y armonizando los intereses de la sociedad, el Estado y las empresas del sector\nOcean Expert Members: 2	2025-09-22 14:22:29.411624	active	group	approved		f
a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	la-trobe-institute-for-molecular-science	La Trobe Institute for Molecular Science	Address: Science Dr, Bundoora, VIC 3083, Australia\nAcronym: LIMS	2025-09-22 14:22:31.166187	active	group	approved		f
75ab8796-08cb-485d-b137-bdf246c84ad8	acap-humber-arm	ACAP Humber Arm	Address:  Suite 204, RA Pollett Building 61 Riverside Dr P.O. Box 564,  Corner Brook, NL, A2H 6E6, Canada	2025-09-22 14:22:32.900167	active	group	approved		f
63385ab9-f57a-4eae-a1ae-8212f114cc46	preveza-fisheries-department	Preveza Fisheries Department	Address: Dodonis 37, Preveza, 48100, Greece	2025-09-22 14:22:36.362948	active	group	approved		f
eb4bc51c-9225-4b28-960e-4123e11315b3	universite-de-lome-centre-de-gestion-integree-du-littoral-et-de-environnement	Université de Lomé, Centre De Gestion Integrée du Littoral et de Environnement	Address: BP 1515, Lome, -, Togo\nAcronym: CGILE\nOcean Expert Members: 8	2025-09-22 14:22:40.32983	active	group	approved	instituteLogo.jpg	f
83f33156-eeb2-4d6a-8b2c-195098119758	nova-scotian-institute-of-science	Nova Scotian Institute of Science	Address: c/o Reference and Research Services, Killam Memorial Library,, 6225 University Avenue, PO Box 15000,, Halifax, B3H 4R2, Canada\nAcronym: NSIS	2025-09-22 14:22:46.293446	active	group	approved		f
cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	university-of-hawaii-at-manoa	University of Hawaii at Manoa	Address: POST Bldg., Room 4011680 East-West Road, Honolulu, HI, 96822, United States of America\nAcronym: UH\nOcean Expert Members: 7	2025-09-22 14:22:50.049268	active	group	approved		f
eff016a7-9f02-46a2-aa39-3d5960c14801	tuscia-university-department-of-ecological-and-biological-sciences	Tuscia University - Department of Ecological and Biological Sciences	Address: Via S. Camillo de Lellis, Viterbo, Italy\nAcronym: DEB\nOcean Expert Members: 1	2025-09-22 14:22:51.872292	active	group	approved		f
b21f79c7-e15a-4794-beff-f4c353903d02	association-peau-bleue	Association Peau-Bleue	Address: 46 rue des Escais, Agde, 34300, France\nOcean Expert Members: 1	2025-09-22 14:22:53.601074	active	group	approved		f
1c002e91-1a9a-4f13-b514-fd11af8c32fd	corporacion-autonoma-regional-de-la-guajira	Corporación Autónoma Regional de La Guajira	Address: Carrera 7 No. 12-15, Riohacha, La Guajira, 57, Colombia\nAcronym: CORPOGUAJIRA\nActivities: Environmental Regional Authority&nbsp;\nOcean Expert Members: 10	2025-09-22 14:22:55.498855	active	group	approved		f
95df44c1-644f-437e-9c39-989caff18ee4	university-of-alaska-fairbanks-laboratory-for-ecological-wildlife-habitat-data-analysis-for-the-land	University of Alaska Fairbanks – Laboratory for Ecological Wildlife Habitat Data Analysis for the Land- and Seascape	Address: PO Box 757000, Fairbanks, AK 99775-7000, United States of America\nAcronym: EWHALE	2025-09-22 14:22:58.966372	active	group	approved		f
4842a628-3350-41c8-a922-53a20eb6d466	queens-university-department-of-biology	Queen's University – Department of Biology	Address: 116 Barrie St., Kingston, ON, K7L 3N6, Canada	2025-09-22 14:23:07.696708	active	group	approved		f
743f2f5f-4505-4ce5-b7f4-bbf026f091b7	cochin-university-of-science-and-technology	Cochin University of Science and Technology	Address: Cochin, Eranakulam, Kerala, 682016, India\nAcronym: CUSAT\nOcean Expert Members: 16	2025-09-22 14:23:09.696667	active	group	approved	instituteLogo.jpg	f
fc41f84f-3f3e-4a3b-b359-24f8b5f78d18	mindanao-state-university-tawi-tawi-college-of-technology-and-oceanography	Mindanao State University – Tawi-Tawi College of Technology and Oceanography	Address: Sanga-Sanga, Bongao, Tawi-Tawi, Philippines\nOcean Expert Members: 4	2025-09-22 14:23:11.520321	active	group	approved		f
8eac503f-e6d2-4c82-9e2f-e56768b39dce	nigerian-institute-for-oceanography-marine-research-niomr	Nigerian Institute for Oceanography & Marine Research (NIOMR)	Country: Nigeria	2025-09-22 14:23:16.727412	active	group	approved		f
86a164b6-9f2b-486a-b5c3-6435267a18c6	university-of-gdansk-institute-of-oceanography-department-of-marine-biology-and-ecology-marine	University of Gdansk – Institute of Oceanography – Department of Marine Biology and Ecology – Marine Invertebrates Ecophysiology Laboratory	Address: al. Marszałka Józefa Piłsudskiego 46, Gdynia, 81-378, Poland\nOcean Expert Members: 1	2025-09-22 14:23:21.935034	active	group	approved		f
5c164465-cecd-4316-a815-cf15782ff02e	university-of-prince-edward-island-department-of-biology	University of Prince Edward Island - Department of Biology	Country: Canada	2025-09-22 14:23:25.7541	active	group	approved		f
39436356-5c3a-4585-908f-787060c070a0	rijkswaterstaat-water-verkeer-en-leefomgeving	Rijkswaterstaat Water, Verkeer en Leefomgeving	Address: Postbus 2232, Utrecht, 3500 GE, Netherlands (Kingdom of the)\nAcronym: RWS WVL\nOcean Expert Members: 1	2025-09-22 14:23:27.872293	active	group	approved		f
d780d7e8-a438-400e-bc62-fd2d5e8b1084	deniz-kaplumbagalari-arastirma-merkezi	Deniz Kaplumbagalari Arastirma Merkezi	Address: Gökbel, Ortaca/Muğla, 48600 , Türkiye\nAcronym: DEKAMER\nActivities: <span>DEKAMER is carring out conservation projects and scientific studies on sea turtle nesting beaches beside rehabilitation studies.</span>	2025-09-22 14:23:31.4559	active	group	approved		f
cae477f4-9d6d-45d3-bfc7-b5f10ad444f2	kintama-research-services	Kintama Research Services	Address: 775 Terminal Avenue, Nanaimo, BC, V9S 4K1, Canada	2025-09-22 14:23:33.227528	active	group	approved		f
2c067a6e-ca86-4f79-af33-a945a4c36a22	central-marine-fisheries-research-institute-cochin	Central Marine Fisheries Research Institute, Cochin	Address: Post Box No. 1603, Ernakulam North P.O., Cochin, Kerala, 682018, India\nAcronym: CMFRI\nActivities: Marine Fisheries Research\nOcean Expert Members: 40	2025-09-22 14:23:35.01794	active	group	approved	instituteLogo.jpg	f
4a33f4a4-578c-428a-9c69-e8a5aa3ec214	p-p-shirshov-institute-of-oceanology-laboratory-of-plankton-communities-structure-and-dynamics	P. P. Shirshov Institute of Oceanology – Laboratory of plankton communities structure and dynamics	Address: 36 Nahimovskiy pr., Moscow, Russian Federation\nAcronym: IORAS	2025-09-22 14:23:36.963961	active	group	approved		f
b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	artoo-marine-biology-consultants	ARTOO Marine Biology Consultants	Address: Ocean Quay Marina, Belvidere Road, Southampton, SO14 5QY, United Kingdom of Great Britain and Northern Ireland	2025-09-22 14:23:40.548721	active	group	approved		f
efe098ee-f980-48fe-9967-a272a2089e34	discover-blue	Discover Blue	Address: c/o Manazuru Town Municipal Endo Shell Museum, Kanagawa, Japan	2025-09-22 14:23:42.317351	active	group	approved		f
5bec3a86-6382-4904-8a0a-9431a935c98b	ministry-of-natural-resources-and-environment-of-the-russian-federation	Ministry of Natural Resources and Environment of the Russian Federation	Address: 4/6 Bolshaya Gruzinskaya Ulitsa, Moscow, Moscow, 123995, Russian Federation	2025-09-22 14:23:43.982809	active	group	approved		f
70f6ad5f-a716-491d-9fdf-b2d87bf73ba0	universitat-wien	Universität Wien	Address: Universitätsring 1, Wien, 1010, Austria\nOcean Expert Members: 7	2025-09-22 14:23:47.478967	active	group	approved		f
cdc3b737-dc61-47f2-a64c-41e14d86ebd9	harvard-university	Harvard University	Address: 52 Oxford St, #365.20, Cambridge, Massachusetts, 02138, United States of America\nOcean Expert Members: 2	2025-09-22 14:23:50.865429	active	group	approved		f
14ce4c73-d741-4244-8616-6692f081937e	encana-corporation	Encana Corporation	Address: 1701 Hollis St, Halifax, NS B3J 3M8, Canada	2025-09-22 14:23:52.6557	active	group	approved		f
5606193d-7fd1-43be-994c-4f50d1d6e574	uni-research	Uni Research	Address: Postboks 7810, Bergen, N-5020, Norway\nActivities: large research institution, all disciplines\nOcean Expert Members: 1	2025-09-22 14:23:54.367137	active	group	approved		f
7f842dd9-aa48-44d8-8384-4101244729da	bishop-museum-department-of-natural-sciences	Bishop Museum — Department of Natural Sciences	Address: 1525 Bernice Street, Honolulu, HI 96817, United States of America	2025-09-22 14:23:57.833938	active	group	approved		f
e881e184-4253-4393-94b2-8ec4da61b63f	seasearch	Seasearch	Address: c/o Marine Conservation Society,, Over Ross House, Ross Park, Ross-on-Wye, Herefordshire, HR9 7US, United Kingdom of Great Britain and Northern Ireland	2025-09-22 14:24:01.695782	active	group	approved		f
e4df8c0d-98c5-4788-96b3-1c10c9d91209	ellerslie-biological-station	Ellerslie Biological Station	Address: 144 Bideford Rd, Ellerslie,  PE C0B 1J0, Canada\nActivities: now closed	2025-09-22 14:24:03.426961	active	group	approved		f
51ce9950-fab6-4e3b-a5b6-a545ec5f21f6	universite-de-nouvelle-caledonie	Université de Nouvelle-Caledonie	Address: 145, Avenue James Cook - BP R4, Nouméa Cedex, 98 851, New Caledonia\nOcean Expert Members: 1	2025-09-22 14:24:10.20374	active	group	approved		f
3cb1ecc3-11b3-4fec-8462-0ad21bda2969	bmt-scientific-marine-services-australia	BMT Scientific Marine Services- Australia	Address: 5 Hackney Road , Hackney, 5069, Australia\nActivities: <span>We support clients at every stage of the project lifecycle with a wide range of high-quality products and services, all backed by our expertise across sectors, geographies and disciplines<br><br></span><p>BMT provides engineering and scientific services and solutions to industry, commerce, policy makers, regulators and public sector operators.</p><br>	2025-09-22 14:24:11.909662	active	group	approved		f
453386c3-3c95-4211-922c-6205eedf7506	arizona-state-university	Arizona State University	Address:  Arizona State University, Tempe, phoenix, 85281, United States of America\nAcronym: ASU\nOcean Expert Members: 3	2025-09-22 14:24:15.828005	active	group	approved		f
2ccff11d-cf6e-47e9-b39a-db4e7faf84ee	test-auth-group	Test Auth Group		2025-09-22 15:55:19.483215	deleted	group	approved		f
46d109f1-b3b5-4e07-9baf-b248212be5fe	vlaamse-overheid-instituut-voor-natuur-en-bosonderzoek	Vlaamse Overheid - Instituut voor Natuur- en Bosonderzoek	Address: Kliniekstraat 25, Brussel, 1070, Belgium\nAcronym: INBO\nActivities: <p>The&nbsp;Research Institute for Nature and Forest (INBO)&nbsp;is the Flemish research and knowledge centre for nature and its sustainable management and use. INBO conducts research and supplies knowledge to all those who prepare or make the policies or are interested in them as a stakeholder.</p><p>Through its scientific research, INBO supports all agencies dealing with open space in the Flemish government, as well as in organisations involved in nature conservation, forestry, agriculture, hunting and fishery. INBO publishes its results as open data and provides data for international reporting. It participates in (inter)national research networks such as LTER, ALTER-Net, LifeWatch, …</p>\nOcean Expert Members: 3	2025-09-22 15:56:52.342592	active	group	approved	instituteLogo.jpg	f
88693b5e-94e7-4d47-acbc-5bd01eba1786	national-oceanic-and-atmospheric-administration-washington	National Oceanic and Atmospheric Administration, Washington	Address: 1401 Constitution Avenue, NW Room 6217, Washington, DC, 20230, United States of America\nAcronym: NOAA\nOcean Expert Members: 5	2025-09-22 15:56:54.124137	active	group	approved		f
4293c7dd-3b02-4e12-afef-e569b5df2618	fisheries-and-oceans-canada	Fisheries and Oceans Canada	Address: 200 Kent St, Ottowa, K1A 0E6, Canada\nOcean Expert Members: 9	2025-09-22 15:56:55.834923	active	group	approved		f
f234686a-2e28-4e40-83e9-e50af8375e59	intergovernmental-oceanographic-commission-of-unesco	Intergovernmental Oceanographic Commission of UNESCO	Address: 7, place de Fontenoy, Paris cedex 07, 75732, France\nAcronym: IOC\nActivities: The Intergovernmental Oceanographic Commission of UNESCO provides Member States of the United Nations with an essential mechanism for global co-operation in the study of the ocean.<br>The IOC assists governments to address their individual and collective ocean and coastal problems through the sharing of knowledge, information and technology and through the coordination of national programmes.\nOcean Expert Members: 102	2025-09-22 15:56:57.502091	active	group	approved	instituteLogo.jpg	f
de156325-2b12-4304-a79d-919ff71ad136	duke-university	Duke University	Address: 2127 Campus Drive, Box 90065, Durham, NC, 27708, United States of America\nOcean Expert Members: 2	2025-09-22 15:56:59.170615	active	group	approved		f
135cbcba-86fc-434f-b1fd-e9377b2e837d	national-institute-for-water-atmospheric-research	National Institute for Water & Atmospheric Research	Address: Private Bag 99940 Newmarket, Auckland 1149, 41 Market Place Viaduct Harbour , Wellington, Auckland Central 1010, 6241, New Zealand\nAcronym: NIWA\nActivities: systematics and taxonomy of polychaete worms\vbiology and ecology of polychaete worms\vbiogeography\vfreshwater nereids\vinformation systems and metadatabaes.\nOcean Expert Members: 21	2025-09-22 15:57:00.860585	active	group	approved	instituteLogo.jpg	f
8c413eeb-cd86-460e-8200-7806e64cecd3	pacific-biological-station-dfo-pbs-fisheries-and-oceans-canada	Pacific Biological Station (DFO – PBS), Fisheries and Oceans Canada	Address: 3190 Hammond Bay Rd., Nanaimo BC, V9T 6N7, Canada\nOcean Expert Members: 9	2025-09-22 15:57:02.599689	active	group	approved		f
0ba5eb77-b00a-4890-8527-af723e8c50eb	mount-allison-university-department-of-biology	Mount Allison University – Department of Biology	Address: Flemington Room 10563B York Street, Sackville, New Brunswick, E4L 1G7, Canada\nAcronym: MTA	2025-09-22 14:24:23.391606	active	group	approved		f
41c1add6-fb64-4b6e-9774-dc8bf78f285c	mount-allison-university	Mount Allison University	Address: 62 York St., Sackville, NB, E4L 1E2, Canada\nAcronym: MtA	2025-09-22 14:24:26.945622	active	group	approved		f
27d9eec0-70c2-41c8-b973-524a1fde24ad	cape-breton-university-bras-dor-institute-for-ecosystem-research	Cape Breton University – Bras D’Or Institute for Ecosystem Research	Address: 1250 Grand Lake Rd, Sydney, NS, Canada	2025-09-22 14:24:28.76913	active	group	approved		f
2e9a7a6a-01c2-45bc-aa9c-4d46323456bb	csir-national-institute-of-ocanography-regional-centre-kochi	CSIR- NATIONAL INSTITUTE OF OCANOGRAPHY REGIONAL CENTRE KOCHI	Address: High Court Junction, Abraham Madamakkal Road Near CMFRI, Kochi,  Kerala,  682018, India\nAcronym: CSIR-NIO\nOcean Expert Members: 5	2025-09-22 14:24:35.1789	active	group	approved		f
90966ad9-4d11-4371-8e14-013a22b0a8a8	an-severtsov-institute-of-ecology-and-evolution	A.N. Severtsov Institute of Ecology and Evolution	Address: 33 Leninskij prosp., Moscow, 117071, Russian Federation\nActivities: Mete choice, parental care and evolution of behaviour in cichlid fishes (Teleostei: Cichlidae).\nOcean Expert Members: 2	2025-09-22 14:24:38.730069	active	group	approved		f
50c2ccac-773d-4efb-a8ea-671b83a02cbf	texas-am-university-department-of-wildlife-and-fisheries	Texas A&M University — Department of Wildlife and Fisheries	Address: Building #1537, 2258 TAMU, College Station, TX, 77843-2258, United States of America	2025-09-22 14:24:42.13506	active	group	approved		f
d4406f37-d9f9-4759-a2f4-8288a2ed7545	associacio-cetacea	ASSOCIACIÓ CETÀCEA	Address: Mas Duran, 48, Àtic 1a, Barcelona, 08042 , Spain\nActivities: <span>We focus on the development of activities and studies that allow us to achieve the goals we set in our foundation. To do this we have created three separate areas, all working in a coordinated manner to develop education, training conservation and research campaigns and projects.</span>	2025-09-22 14:24:45.660693	active	group	approved		f
141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	boston-university-marine-program	Boston University Marine Program	Address: 5 Cummington Mall, Boston, MA, 02215, United States of America\nAcronym: BUMP\nOcean Expert Members: 2	2025-09-22 14:24:47.375582	active	group	approved		f
70395ad1-0a15-4b1a-b28a-8d6b9c211013	bras-dor-lake-biosphere-reserve-association	Bras d’Or Lake Biosphere Reserve Association	Address: 532 Chebucto St., P.O. Box 711, Baddeck, NS, B0E 1B0, Canada\nAcronym: BLCBRA	2025-09-22 14:24:50.919884	active	group	approved		f
5bc76a2a-8d9b-45a2-940a-eb5832c12b08	kagoshima-university-faculty-of-fisheries	Kagoshima University, Faculty of Fisheries	Address: Shimoarata 4-50-20, Kagoshima, Kagoshima, 890-0056, Japan\nActivities: Fisheries education and research\nOcean Expert Members: 1	2025-09-22 14:24:52.63441	active	group	approved		f
c1b034ce-3854-429c-9422-ffb7dc34c61d	institut-national-de-recherche-en-sciences-et-technologies-pour-lenvironnement-et-lagriculture	Institut national de recherche en sciences et technologies pour l'environnement et l'agriculture	Address: 147 rue de l'Université , Paris Cedex 07, 75338 , France\nAcronym: IRSTEA\nOcean Expert Members: 1	2025-09-22 14:24:57.865648	active	group	approved		f
a64192e5-d445-4165-9af6-6273a9ca7fe0	university-of-amsterdam-faculty-of-science-institute-for-biodiversity-and-ecosystem-dynamics	University of Amsterdam, Faculty of Science, Institute for Biodiversity and Ecosystem Dynamics	Address: Sciencepark 904, Amsterdam, 1098 XH , Netherlands (Kingdom of the)\nAcronym: IBED/ UvA\nActivities: At the broadest level, the mission of the Institute for Biodiversity and Ecosystem Dynamics (IBED) is to increase our understanding of the diversity and dynamics of ecosystems from the level of molecules and genes to entire ecosystems.<br>Our aim is to unravel how ecosystems function in their full complexity, and how they change due to natural processes and human interference.<br>The focus in IBED lies on the study of two interlinked aspects:<br>(i) how do organisms interact with one another and with their abiotic environment, and<br>(ii) what are the dynamics that emerge from these interactions\nOcean Expert Members: 2	2025-09-22 15:57:04.265987	active	group	approved	instituteLogo.jpg	f
90df177a-63af-44a9-bf2c-8a1d3623fb64	australian-antarctic-division	Australian Antarctic Division	Address: Channel Highway, Kingston, Tasmania, 7050, Australia\nAcronym: AAD\nActivities: Administering Australia's wide-ranging activities in antarctic and subantarctic regions is the responsibility of the Australian Antarctic Division (AAD), a part of the Australian Government\nOcean Expert Members: 4	2025-09-22 15:57:05.963311	active	group	approved		f
a932f0a0-a551-407f-a812-9eda4c4eac9e	university-of-technology-sydney	University of Technology, Sydney	Address: Bldg 4, Thomas St, Broadway, NSW Australia, 2007, Australia\nAcronym: UTS\nOcean Expert Members: 2	2025-09-22 15:57:07.65621	active	group	approved		f
ba214d46-0090-43ad-8768-9558a6af5fcf	bureau-waardenburg-bv-ecology-landscape	Bureau Waardenburg bv – Ecology & Landscape	Address: Postbus 365, Culemborg, 4100 AJ, Netherlands (Kingdom of the)\nOcean Expert Members: 2	2025-09-22 15:57:09.406399	active	group	approved		f
b9f23216-9065-44f4-856e-a254a57c20e0	universiteit-gent	Universiteit Gent	Address: St. Pietersnieuwsstraat 33, Gent, 9000, Belgium\nAcronym: UGent\nOcean Expert Members: 30	2025-09-22 15:57:18.386498	active	group	approved	instituteLogo.jpg	f
5837bbb0-db1e-4388-a7b4-6ec8dde4be45	institute-for-marine-and-antarctic-studies-imas-university-of-tasmania	Institute for Marine and Antarctic Studies (IMAS), University of Tasmania	Address: 20 Castray Esplanade, Hobart, Tasmania, 7001, Australia\nAcronym: IMAS\nOcean Expert Members: 12	2025-09-22 15:57:20.862425	active	group	approved		f
6d65e611-1921-4a04-b457-71e01531975c	united-nations-educational-scientific-and-cultural-organization	United Nations Educational, Scientific and Cultural Organization	Address: 7 Place de Fontenoy, Paris, 75007, France\nOcean Expert Members: 12	2025-09-22 15:57:22.627527	active	group	approved		f
95af0725-7f7b-4d25-9331-c16f872ad683	universite-de-la-rochelle-centre-detudes-biologiques-de-chize	Université de La Rochelle, Centre d'Etudes Biologiques de Chizé	Address: CNRS UMR 7372 - Université de La Rochelle, 405 Route de La Canauderie, Villiers-en-Bois, 79360, France\nAcronym: CEBC\nActivities: <h2><small>Des recherches interdisciplinaires sur l'écologie et l'évolution des vertébrés dans des milieux naturels et modifiés</small></h2><p><small>Les programmes de recherche portent sur l'étude de l'effet des variations, dans le temps et dans l'espace, des ressources disponibles. Aux variations d'origine naturelle, s'ajoutent également les variations du fait des changements climatiques et des activités anthropiques (agriculture, pêche...), sur les populations et communautés de vertébrés. Ces perspectives de recherche s'inscrivent également dans un but de gestion durable des ressources naturelles et de conservation de la biodiversité.&nbsp;</small></p><p><small>&nbsp;</small></p><p><small>Les chercheurs étudient différentes espèces de mammifères, oiseaux et reptiles, soit localement sur 50&nbsp;000 ha de plaines céréalières, soit en élevage sur les 10 hectares de forêts dont dispose le Centre, soit sur des sites plus lointains comme l’Afrique, l’Arctique et l’Antarctique. Le Centre mène en effet des études sur les prédateurs marins supérieurs des Terres Australes et Antarctiques Françaises (TAAF).</small></p>\nOcean Expert Members: 1	2025-09-22 15:57:24.366025	active	group	approved	instituteLogo.jpg	f
5028ad30-1eb0-4305-9e8f-11a2e64c8050	havs-och-vattenmyndigheten	 Havs- och Vattenmyndigheten		2025-09-22 14:06:40.83903	active	group	approved		f
c2400946-5534-4cf5-b5af-2f84beea12b3	commonwealth-scientific-and-industrial-research-organisation	Commonwealth Scientific and Industrial Research Organisation 		2025-09-22 14:09:28.444758	active	group	approved		f
3c50b952-0f6a-404e-9a0d-0d5003959792	instituto-de-investigaciones-marinas-y-costeras-jose-benito-vives-de-andreis	Instituto de Investigaciones Marinas y Costeras "José Benito Vives de Andreis"		2025-09-22 14:08:45.88621	active	group	approved		f
e4179653-bf67-4863-885a-005fe38d63e1	university-of-kansas	University of Kansas	Address: Haworth Hall    Lawrence    KS 66045, United States of America\nActivities: Evolution of Anthozoa, Sea anemones - especially their taxonomy, reproduction, and symbioses coral natural history, reproduction, taxonomy, and systematics of sea anemones; evolution of cnidarians; co\nOcean Expert Members: 3	2025-09-22 16:07:55.063032	active	group	approved		f
8b9956e9-9b6c-4d3b-af4e-9794dc16e045	national-biodiversity-data-centre	 National Biodiversity Data Centre		2025-09-22 14:13:17.522365	active	group	approved		f
5f755450-77f2-4464-92eb-2603af8bb620	coastal-oceans-research-and-development-indian-ocean	Coastal Oceans Research and Development Indian Ocean 		2025-09-22 14:15:54.541543	active	group	approved		f
46f9cb4f-b4f3-4491-ac7d-bb14636337ad	natural-environment-research-council	Natural Environment Research Council 		2025-09-22 14:18:24.519356	active	group	approved		f
6d5131dc-c688-4b0f-8527-0cc2256973c2	department-of-agriculture-forestry-and-fisheries	 Department of Agriculture, Forestry and Fisheries		2025-09-22 14:18:35.92553	active	group	approved		f
1451af60-3395-44d3-a7ac-0c0d27d1e941	centro-terra-viva-estudos-e-advocacia-ambiental	Centro Terra Viva -Estudos e Advocacia Ambiental 		2025-09-22 14:20:11.367374	active	group	approved		f
7b06fd53-2ccd-48a0-b9f7-d787524748d8	dakshin-foundation	Dakshin Foundation	Address:  #1818, 9th Cross, 5th Main Rd, B Block, CQAL Layout, Sahakar Nagar, Bengaluru, 560092, Bengaluru, Karnataka, 560092, India\nActivities: <ul><li>Community wellbeing and environment&nbsp;</li><li>Biodiversity and resource monitoring&nbsp;</li><li>Communities and resource governance&nbsp;</li><li>Environmental education</li></ul>\nOcean Expert Members: 3	2025-09-22 14:20:31.094371	active	group	approved		f
22c1fe0a-424a-4a44-8c63-d636552ba886	dalhousie-university-school-for-resource-and-environmental-studies	Dalhousie University – School for Resource and Environmental Studies	Address: Kenneth C. Rowe Management Building 6100 University Ave, PO BOX 15000, Halifax, Nova Scotia, B3H 4R2, Canada\nAcronym: DAL SRES\nOcean Expert Members: 1	2025-09-22 14:20:36.50948	active	group	approved		f
8a0c78a0-6e1d-4a12-9bbc-710156efb635	okinawa-institute-of-science-and-technology-graduate-university	Okinawa Institute of Science and Technology Graduate University	Address: 1919-1 Tancha, Onna-son, Kunigami-gun, Okinawa, 904-0495, Japan\nAcronym: OIST\nOcean Expert Members: 1	2025-09-22 14:20:38.327066	active	group	approved		f
62488d62-4141-4611-a267-5eef4dfac40e	suganthi-devadason-marine-research-institute	Suganthi Devadason Marine Research Institute	Address: ( Recognized by Manonmaniam Sundaranar University, Tirunelveli, India & UGC )  \t\r\n44 - Beach Road\r\n, Tuticorin, Tamil Nadu, 628 001, India\nAcronym: SDMRI\nActivities: \t\r\nSuganthi Devadason Marine Research Institute (SDMRI) is a non-governmental and non-profit Marine Research and Higher Education organization. The founders of SDMRI are well known personalities in the society. The Founder President of SDMRI, Mr. D.G. Rajan is an industrialist, administrator and social worker with various capacities in the society. SDMRI was established in 1998 under the Suganthi Devadason Trust (Reg. No. 290/1997) at Tuticorin, Tamil Nadu, India with the aim  \t\r\n• to meet out the research needs of marine and coastal   ecosystems in India;\r\n• to uplift the socio-economic conditions of coastal folk; and\r\n• to promote higher education for capacity building.\nOcean Expert Members: 4	2025-09-22 14:20:43.751203	active	group	approved		f
cea814d6-2e0a-4214-9c39-3fe730ca7cd5	institute-of-oceanography-and-environment	Institute of Oceanography and Environment	Address: Universiti Malaysia Terengganu (UMT),Mengabang Telipot, Kuala Terengganu, Terengganu, 21030, Malaysia\nAcronym: INOS\nActivities: The Institute of Oceanography (INOS) is a premier center of excellence in Malaysia that focuses its activities on oceanic and marine related research and post-graduate training.\r\n\r\nINOS has a long and strong tradition in marine science and oceanographic research. The Institute of Oceanography and Environment (INOS), a research institute located under the banner of Universiti Malaysia Terengganu was awarded the Higher Institutions Centre of Excellence (HICoE). \r\n\r\nRecommended by the Intergovernmental Oceanographic Commission of UNESCO, the institute is accorded official status as a center of excellence by the Malaysian Government in April 2001.\r\n\r\nINOS aims to be a leading regional center of research, post-graduate studies as well as the reference center for marine and its related environment with special emphasis on the South China Sea and its related ecosystems.<br>||ADU|| ||Accredited ADU|| ||OTGA RTC||<br>\nOcean Expert Members: 38	2025-09-22 14:20:45.517625	active	group	approved	instituteLogo.jpg	f
800cf29d-6348-4644-8584-20f8eeb2f68c	universidade-federal-do-rio-de-janeiro	Universidade Federal do Rio de Janeiro	Country: Brazil	2025-09-22 14:10:29.968917	active	group	approved		f
b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	us-geological-survey-southeast-ecological-science-center	U.S. Geological Survey,  Southeast Ecological Science Center	Address: Gainesville Lab7920 NW 71st Street, Gainesville, Florida, FL 32653, United States of America\nAcronym: USGS\nActivities: General biology, systematics, ecology, natural history, physiology, and zoogeography of freshwater and inshore marine fishes.\nOcean Expert Members: 2	2025-09-22 14:20:50.533734	active	group	approved		f
6807177e-d90f-455c-b50c-09a815a9b0fb	university-of-lodz-dept-invertebrate-zoology-hydrobiology-laboratory-of-polar-biology-and	University of Lodz – Dept. Invertebrate Zoology & Hydrobiology – Laboratory of Polar Biology and Oceanobiology	Address: ul. Banacha 12/16, Lodz, 90-237, Poland	2025-09-22 14:20:55.778441	active	group	approved		f
984d9654-fed4-4692-9292-f9e4eb115a3f	university-of-the-aegean	University of the Aegean	Address: University Hill, Mytilene, Lesvos, 81100, Greece\nActivities: Marine Euthrophication, Phytoplankton Ecology, Coastal Water, Quality, Ecotoxicology\nOcean Expert Members: 17	2025-09-22 14:21:01.386325	active	group	approved	instituteLogo.jpg	f
efb64a40-7d6e-484b-86de-63401ccc13ca	universite-du-quebec-a-rimouski-institut-des-sciences-de-la-mer-de-rimouski	Université du Québec à Rimouski, Institut des sciences de la mer de Rimouski	Address: 310 allée des Ursulines , Rimouski, Québec, G5L 3A1, Canada\nAcronym: ISMER\nActivities: The Institute is a research catalyst in the marine sciences field in Rimouski. Its contribution to the advancement of marine sciences is crucial.\nOcean Expert Members: 6	2025-09-22 14:21:11.003689	active	group	approved		f
c32577e8-2f21-4c34-a4ce-1641adacffd5	coastal-branch-of-natural-history-museum-and-institute-chiba	Coastal Branch of Natural History Museum and Institute, Chiba	Address: 123, Yoshio, Katsuura, Chiba Prefecture, 299-5242, Japan	2025-09-22 14:21:16.563402	active	group	approved		f
91f28432-5f2f-4f95-8bb7-9005e785b327	universidad-de-especialidades-espiritu-santo	Universidad de Especialidades Espíritu Santo	Address: Av. Samborondón Km 2.5, vía La Puntilla, Guayaquil, Guayas, 092301, Ecuador\nAcronym: UEES\nActivities: <p><b>Misión</b><br>Servir a la sociedad mediante la generación de entornos de aprendizaje para la formación integral de personas que, a través de la docencia, investigación&nbsp;y&nbsp;vinculación, contribuyan al desarrollo del país.</p><p><br><b>Visión</b><br>La UEES se visualiza como un centro de docencia, investigación&nbsp;y&nbsp;orientación que aporta alternativas para el desarrollo del país.</p>\nOcean Expert Members: 1	2025-09-22 14:21:20.321264	active	group	approved	instituteLogo.jpg	f
b7f123f8-c806-4e09-9a6b-590332c6b8aa	universita-di-genoa-facolta-di-scienze-matematiche-fisiche-e-naturali-dipartimento-per-lo-studio-del	Universita di Genoa; Facoltà di Scienze Matematiche Fisiche e Naturali; Dipartimento per lo Studio del Territorio e delle sue Risorse	Address: Corso Europa 26, Genova, 16132, Italy\nAcronym: DIPTERIS\nOcean Expert Members: 3	2025-09-22 14:21:27.295679	active	group	approved		f
c88cb4db-68fe-44f4-8057-37900c9bd8fd	wildlife-conservation-society	Wildlife Conservation Society	Address: 2300 Southern Boulevard, Bronx, New York, NY 10460, United States of America\nAcronym: WCS\nActivities: The Wildlife Conservation Society saves wildlife and wild places worldwide. We do so through science, global conservation, education and the management of the world's largest system of urban wildlife parks, led by the flagship Bronx Zoo. Together these activities change attitudes towards nature and help people imagine wildlife and humans living in harmony. WCS is committed to this mission because it is essential to the integrity of life on Earth. 	2025-09-22 14:21:29.215069	active	group	approved		f
59a0abde-da3b-44f6-8c10-3314dbd3e158	el-colegio-de-la-frontera-sur-unidad-campeche	El Colegio de la Frontera Sur, Unidad Campeche	Address: Av. Rancho Polígono 2-A, Ciudad Industrial, Campeche, Campeche,  24500, Mexico\nAcronym: ECOSUR\nOcean Expert Members: 3	2025-09-22 14:21:34.557943	active	group	approved		f
e6d5c49e-e7c6-4f94-b0b7-8ef444eaeb9c	japan-oil-gas-and-metals-national-corporation	Japan Oil, Gas and Metals National Corporation	Address: Toranomon Twin Building 2-10-1 Toranomon, Minato-ku, Tokyo, 105-0001, Japan\nAcronym: JOGMEC	2025-09-22 14:21:38.063568	active	group	approved		f
aee7e56c-06eb-476d-ac2f-f0faefcb2612	national-institute-of-oceanography-and-fisheries-alexandria	National Institute of Oceanography and Fisheries, Alexandria	Address: Kayet bay El anfoushy, Alexandria, -, Egypt\nAcronym: NIOF\nActivities: 1-Fisheries Research<br>2-Geological &amp; Geophysical Marine Survey.\r\nBathymetry Study.\r\nShallow Seismic study\r\nSediment variation of sea bottom<br>3- Statistical studied.<br>4- Seismic Hazards.<br>5- Geotechnical Study (drilling, SPT, Liquefaction).<br>6- Ground Water.<br>7- Environment Impact Assessment - EIA<br>8-Hydrograpic Study.<br>9- Pollution Impact<br>10- Coastal Management <br><br>||NODC||<br><br><br><br>\nOcean Expert Members: 66	2025-09-22 14:22:38.266787	active	group	approved	instituteLogo.jpg	f
71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	centro-interdisciplinario-de-ciencias-marinas-instituto-politecnico-nacional	Centro Interdisciplinario de Ciencias Marinas, Instituto Politécnico Nacional	Address: Centro Interdisciplinario de Ciencias Marinas Av. Instituto Politécnico Nacional s/n Col. Playa Palo de Santa Rita Apdo. Postal 592, La Paz, B.C.S., 23096, Mexico\nAcronym: CICIMAR-IPN\nActivities: Proporcionar servicios educativos de posgrado, desarrollar investigación científica y tecnológica tanto básica como aplicada, tendiente a la conservación y aprovechamiento de los recursos marinos para coadyuvar al desarrollo integral de México, así como contribuir a la difusión de la cultura científica y tecnológica dentro de la comunidad politécnica y de la sociedad en general. Para ello cuenta con una estructura y planta académica de excelencia en diversas disciplinas de las Ciencias Marinas y Pesqueras, con una infraestructura adecuada y con los servicios de apoyo requeridos para el cumplimiento de esta misión.\nOcean Expert Members: 37	2025-09-22 14:21:39.793982	active	group	approved		f
131aead9-4b5f-42c8-b1be-4efb65f27f85	asrc-energy-services	ASRC Energy Services	Address: 3900 C Street, Suite 701, Anchorage, Alaska, AK 99503, United States of America\nAcronym: AES\nActivities: <p><span>ASRC Energy Services (AES) is a subsidiary of&nbsp;<a target="_blank" rel="nofollow" href="http://www.asrc.com/">Arctic Slope Regional Corporation</a>&nbsp;(ASRC), the largest locally-owned and operated business in Alaska for more than three decades.</span></p><p><span>With more than 30 years of experience working in the world’s most challenging environments, AES has earned its reputation as the service provider of choice to the energy industry.</span></p>	2025-09-22 14:21:41.563952	active	group	approved		f
6656a424-96b6-48ce-a7ed-ac2c25236f3e	comision-permanente-para-el-pacifico-sur	Comisión Permanente para el Pacífico Sur	Address: Centro Empresarial 'Las Cámaras", Torre B,officinas 1,2 y3, Av. Francisco de Orellana y Miguel H. Alcivar, Guayaquil, Guayas, 090506, Ecuador\nAcronym: CPPS\nActivities: The Permanent Commission for the South Pacific (CPPS) is the appropriate Regional Maritime Organization responsible for the coordination of the maritime policies of its Member States: COLOMBIA, CHILE, ECUADOR and PERU. The Organization was established on 18 August 1952, as a result of "Declaration on the Maritime Zone" subscribed at Santiago by the Governments of Chile, Ecuador and Peru. Colombia joined the CPPS on 9 August, 1979.<br>||ADU||<br>\nOcean Expert Members: 9	2025-09-22 14:21:43.341516	active	group	approved	instituteLogo.jpg	f
ef5b612a-a6b9-48a5-8571-236f3dbea130	fundacion-patagonia-natural	Fundación Patagonia Natural	Address: Marcos A. Zar 760, Puerto Madryn, Chubut, Argentina\nAcronym: FPN\nOcean Expert Members: 2	2025-09-22 14:21:50.649146	active	group	approved		f
bf21ee67-a54a-4795-a97e-c308d18eb12e	us-geological-survey-alaska-science-center	U.S. Geological Survey – Alaska Science Center	Address: 4210 University Drive, Anchorage, AK, 99508, United States of America\nOcean Expert Members: 1	2025-09-22 14:21:52.419464	active	group	approved		f
c177523f-2836-40b9-8f30-84692218550a	blue-whale-study	Blue Whale Study	Address: C/ Post Office, Narrawong, , Victoria,  3285 , Australia\nAcronym: BWS\nActivities: <p>BWS has conducted ecological research on blue whales and their upwelling habitats in southern Australia.&nbsp; We work in cooperation with local, state and federal governments, NGOs, universities, industry and other research institutions to pursue good conservation outcomes for blue whales.</p><p>Our current studies focus on photo-identification of blue whales, and on the distribution and ecology of the species throughout their upwelling habitat.</p>	2025-09-22 14:21:54.222082	active	group	approved		f
bc60400e-420e-4599-98d6-18b90fe187f9	instituto-espanol-de-oceanografia-centro-oceanografico-de-malaga	Instituto Español de Oceanografía – Centro Oceanográfico de Málaga	Address: Puerto Pesquero, s/nApdo. 285, Fuengirola, Málaga, 29640, Spain\nAcronym: IEO\nActivities: El Centro Oceanográfico de Málaga, es uno de los 9 Centros Costeros que el Instituto Español de Oceanografía (IEO) tiene repartidos por el litoral peninsular e insular español. Además el IEO cuenta con una Sede central en Madrid, cinco plantas experimentales de acuicultura, doce estaciones mareográficas, una estación receptora de imágenes satélite y una flota de seis barcos oceanográficos de diverso tonelaje.\nOcean Expert Members: 13	2025-09-22 14:21:59.56135	active	group	approved		f
8d184328-c515-47b9-968c-105c21b20eea	institute-of-cetacean-research	Institute of Cetacean Research	Address: 2-12-4 Fukuura, Kanazawa Yokohama,  Kanagawa,  236-8648, Japan\nAcronym: ICR\nActivities: Through whale research and sighting surveys we are collecting valuable biological data for whale resource assessment. We also study DNA of cetaceans netted as by-catch during fishing, and conduct research on cetacean and other marine mammal strandings.	2025-09-22 14:22:08.260698	active	group	approved		f
b1da8b11-223d-4732-8017-3f719038dae0	csiro-oceans-and-atmosphere-st-lucia	CSIRO Oceans and Atmosphere, St Lucia	Address: 306 Carmody Road, St Lucia , QLD 4067, Australia\nActivities: The Queensland Bioscience Precinct is a state-of-the-art research facility based at the University of Queensland, housing more than 700 researchers.	2025-09-22 14:22:16.998097	active	group	approved		f
a0566913-b123-4db5-8795-c36dd15bfbd2	university-of-montenegro-institute-of-marine-biology	University of Montenegro-Institute of Marine Biology	Address: Dobrota bb, P.O. Box 69 , Kotor, 85330, Montenegro\nAcronym: UoM, IMB\nActivities: <span><span>Main sectors of research:<br></span>pelagic &amp; benthic communities, fisheries biology, aquaculture, environmental protection, sustainable development, neurohistology, neurophysiology, neurochemistry, behavioural studies, extraction and identification of bioactive compounds from marine organisms</span>\nOcean Expert Members: 3	2025-09-22 14:22:24.240425	active	group	approved		f
821f9831-8ab3-4015-8699-1493f2aa55bc	universitat-hamburg-biozentrum-grindel-und-zoologisches-museum	Universität Hamburg, Biozentrum Grindel und Zoologisches Museum	Address: Martin-Luther-King-Platz 3 \r\n, Hamburg, 20146, Germany\nAcronym: ZIM\nActivities: The Institute of Zoology consists of six divisions that offer a broad expertise in diverse areas of zoology, with a focus on evolutionary biology and ecology. Zoology at the University of Hamburg is represented by a young team of recently appointed professors, forming the backbone of a cutting-edge research environment.\r\nThe Institute of Zoology and the Zoological Museum are joined in a tight partnership, cooperating in both research and teaching.\nOcean Expert Members: 2	2025-09-22 14:22:27.664908	active	group	approved		f
2b07e482-a787-4499-9737-fa3e488f19e0	eoceans-research-and-consulting	eOceans Research and Consulting	Address: /, Halifax, Canada	2025-09-22 14:22:34.629101	active	group	approved		f
48021ea1-c7ba-4304-bf41-3ac7411be99e	universidad-de-antofagasta	Universidad de Antofagasta	Address: Universidad de Antofagasta 02800, Antofagasta, Antofagasta, 000000, Chile\nAcronym: UA\nActivities: <div>Ecology, Population genetics and Evolution of coastal species.</div><div>Ecology and Biogeography of parasites of marine organisms.</div><div>Epidemiology in Aquaculture.</div><div>Population dynamics of fishery resources.</div><div>Modeling of Complex Systems.</div><div>Bento-pelagic coupling.</div><div>Sedimentology and Paleo-Oceanography.</div><div>Ecotoxicology and environmental pollution.</div>\nOcean Expert Members: 7	2025-09-22 14:23:18.432767	active	group	approved	instituteLogo.jpg	f
8da43065-d681-4a4d-9f4b-37bc6598d9dd	universita-degli-studi-di-pavia-centro-interdisciplinaire-di-bioacustica-e-ricerche-ambientali	Università degli Studi di Pavia Centro Interdisciplinaire di Bioacustica E Ricerche Ambientali	Address: Via Taramelli 24, Pavia, 27100, Italy\nActivities: Bioacoustics is a branch of zoology, strictly related to ethology, that investigates sound production and reception in animals, including man. Bioacoustics also concerns the organs of hearing and the sound producing apparatus as well as the physiological and neurophysiological processes by which sounds are produced and received. Finally it attempts to understand relationships between the features of the sounds an animal produces and the nature of the environment in which they are used and the functions they are designed to serve. Its development dates effectively from about 1950, when practical recording and analyzing methods became readily available to the scientific community	2025-09-22 14:22:42.229517	active	group	approved		f
5a4618e8-aefc-4721-8adc-ff442928090d	csiro-bardi-jawi-turtle-tracking	CSIRO-Bardi Jawi Turtle Tracking	Address: GPO Box 1700, Canberra, ACT 2601, Australia\nActivities: his project is a partnership between CSIRO, the Bardi Jawi rangers and the Western Australian Department of Parks &amp; Wildlife.<br><br>The project aims to study the movement and feeding ecology of turtles, especially green turtles, in the Bardi Jawi Indigenous Protected Area, which is located in the Kimberley region of Western Australia. We are interested in where the turtles go, where they feed, and any other insights that we can obtain from the satellite tagged animals.<br><br>The turtles were captured and tagged in the Bardi Jawi Indigenous Protected Area, which was declared in 2013. This is managed for sustainable use of natural resources, including turtles (known as goorlil by the Bardi Jawi people)	2025-09-22 14:22:44.154764	active	group	approved		f
ea04f2bc-c054-4e92-bb94-dcb31404328c	universiteit-gent-afdeling-algologie	Universiteit Gent, Afdeling Algologie	Address: Krijgslaan 281, building S8, Gent, 9000, Belgium\nActivities: Our research focuses on genetics, diversity and distributions of marine macroalgae. We address questions ranging from descriptive taxonomy over ecological studies forecasting the distribution of species in relation to environmental change to genomics of selected green and brown seaweed species. A substantial part of our research involves a combination of fieldwork, culturing and manipulating seaweed strains to study their development (<i>Dictyota</i>), gamete development (<i>Ectocarpus</i>,&nbsp;<i>Ulva</i>) or morphogenesis and genomics (green seaweeds).\nOcean Expert Members: 1	2025-09-22 14:22:48.151387	active	group	approved		f
8c1caaf9-06f2-4808-82ac-f5d495bd19f5	programa-ecomar-inc	Programa EcoMar, Inc.	Address: Sarasota 121, Bella Vista, Santo Domingo, 11114, Dominican Republic\nAcronym: PROECOMAR\nActivities: Main research lines of Programa EcoMar: environmental education and management, fisheries, coastal marine ecology and biodiversity and climate change\nOcean Expert Members: 1	2025-09-22 14:22:57.281502	active	group	approved		f
56bb757e-7427-4bf2-afdc-7669b7cb4afc	ku-leuven-laboratory-of-biodiversity-and-evolutionary-genomics	KU Leuven - Laboratory of Biodiversity and Evolutionary Genomics	Address: Charles Deberiotstraat 32 - bus 2439, Leuven, 3000, Belgium\nAcronym: LBEG\nActivities: Our&nbsp;<a target="_blank" rel="nofollow" href="https://bio.kuleuven.be/eeb/lbeg/research.html">Research</a>&nbsp;focuses on biodiversity, mostly vertebrates diversity, with special attention to evolutionary genetics and speciation, parasitology, molecular ecology, fish ecology and systematics, and bioarcheology. Whenever possible we use complementary approaches at the genomic, phenotypic, ecological and environmental level to support our findings. We manage a medium-throughput genotyping laboratory, have access to a genomics platform and do our bioinformatics in house. We organize the bachelor courses of genetics and archaeozoology. Master courses are taught in chordate diversity, comparative and functional anatomy of chordates, marine ecology, speciation and phylogenetics, bioinformatics (quantitative and evolutionary genetics), wildlife management and archaeozoology.<br>We cooperate with partners across Europe and North America, and in the Southern Hemisphere (projects all over Africa, in Ecuador and Vietnam). Our research has applications in sustainable development, nature conservation, water and wildlife management, human biology, fisheries and aquaculture.\nOcean Expert Members: 1	2025-09-22 14:23:00.707404	active	group	approved	instituteLogo.jpg	f
5832257f-6aaf-4691-889b-d919e8a15159	centro-de-investigaciones-de-ecosistemas-costeros	Centro de Investigaciones de Ecosistemas Costeros	Address: Avenida Los Almácigos, Cayo Coco, Morón, Ciego de Ávila, 64900, Cuba\nAcronym: CIEC\nActivities: <span>El Centro de Investigaciones de Ecosistemas Costeros se encuentra ubicado en Cayo Coco, en la parte central del Archipiélago Sabana-Camagüey, al norte de la provincia de Ciego de Ávila, en el centro de Cuba.<br>Este cayo tiene un área aproximada de 370 km2 y constituye uno de los núcleos principales para el desarrollo del turismo en nuestro país debido a la gran belleza de muchos de sus recursos naturales, entre los que sobresalen, sus bosques, manglares, playas y su rica biodiversidad.</span>\nOcean Expert Members: 3	2025-09-22 14:23:02.464172	active	group	approved		f
3b779396-977e-48e6-9b33-9bc06991cbcc	acquario-di-genova	Acquario di Genova	Address: Costa Edutainment S.p.A.\r\nArea Porto Antico\r\nPonte Spinola, Genova, 16128, Italy\nAcronym: AdG\nActivities: Public Aquarium\nOcean Expert Members: 2	2025-09-22 14:23:04.250285	active	group	approved		f
65195257-f380-42b6-8127-c150f31de68d	bangladesh-sea-turtle-satellite-tracking-project	Bangladesh Sea Turtle Satellite Tracking Project	Address: Cox's Bazar, Bangladesh, 4700, Bangladesh\nActivities: Satellite tracking conducted to study migration and foraging habitat of sea turtle nest on our coast. Satellite&nbsp;Tracking involves attaching on the sea turtle shell a&nbsp;Platform Terminal Transmitter (PTT) and getting the&nbsp;transmission data from ARGOS Satellite. Te PTT send&nbsp;message to satellite each time the turtle comes to the&nbsp;surface to breathe and the analyzed data sent to MLA&nbsp;researcher via satellite regarding the location of the&nbsp;tracked turtle. MLA attached total&nbsp;13 PTT satellite tags on Olive ridley at St. Martin Island,&nbsp;Teknaf-Cox’s Bazar beach, Sonadia and at oﬀshore&nbsp;location near Dholghata beach.	2025-09-22 14:23:05.996669	active	group	approved		f
3b6db43c-5d62-4098-a9c6-605909db5458	hartpury-college-department-of-animal-and-land-science	Hartpury College — Department of Animal and Land Science	Address: Hartpury House, Gloucester , GL19 3BE, United Kingdom of Great Britain and Northern Ireland	2025-09-22 14:23:13.279855	active	group	approved		f
5dbf9540-1fec-4b79-a68a-0e39c1ce080f	dauphin-island-sea-labuniversity-of-south-alabama	Dauphin Island Sea Lab/University of South Alabama	Address: 101 Bienville Blvd., Dauphin Island, Alabama, 36528, United States of America\nActivities: Coastal biological oceanography. Research activities focus on understanding the effects of climate variability on the magnitude and consequences of jellyfish blooms in heavily fished ecosystem.\nOcean Expert Members: 1	2025-09-22 14:23:15.062871	active	group	approved		f
d3c8a85d-280a-4946-a3cd-2b6cdff818d3	centre-de-recherches-halieutiques-et-oceanologiques-du-benin	Centre de Recherches Halieutiques et Océanologiques du Bénin	Address: Zongo Bâtiment Badirou, BP 1665, Cotonou, Benin\nAcronym: CNDO CRHOB\nActivities: Design, develop, coordinate, execute and control national programs for fisheries and ocean research.<br>Identify and define problems whose resolution requires action of research and training in the science of the sea and adjacent coastal areas.<br>Promote all technologies and all the features that contribute to development through the enhancement of the aquatic environment.<br>Centralise data, promote the exchange, publication and dissemination of fisheries and ocean research and make recommendations for these purposes.<br>Provide information and popularisation of science and technology in different social, cultural and professional circles concerned.<br>Participate in the development and implementation of regional and international fisheries and ocean research consistent with national development objectives.<br>Realise research, production, expertise or advice in its fields of competence for the benefit of external public or private partners.<br>||NODC||<br>\nOcean Expert Members: 9	2025-09-22 14:23:20.214045	active	group	approved		f
a4b0d8f0-748f-45b4-bc42-4df697153b3e	lassociazione-culturale-scientifica-ketos	L’Associazione culturale scientifica KETOS	Address: xxx, xxx, Sicily, xxx, Italy\nActivities: <p>L’Associazione KETOS, è un ente culturale e scientifico senza scopi di lucro, costituito da ricercatori volontari. Nata dall’amore dei suoi fondatori nei confronti del mare e della Cetofauna che lo popola, mira ad approfondirne la conoscenza in ambito territoriale, stimolando l’interesse accademico nei loro confronti e promuovendone il rispetto e la tutela.</p><p>Le attività di ricerca della KETOS si svolgono nel Mar Mediterraneo meridionale e principalmente nel Mar Ionio occidentale, lungo le coste siciliane. Diversi, negli anni, sono stati i progetti di ricerca, di divulgazione e di educazione ambientale, svolti anche in collaborazione con enti pubblici e privati e con varie Università.</p><p>I risultati di studi condotti su differenti specie di Cetacei sono stati pubblicati in sede nazionale ed internazionale. I temi ecologici ed ambientali sono argomenti affrontati e trattati dalla KETOS costantemente, al fine di proseguire i suoi studi nel promulgare la conservazione della Cetofauna marina.</p>	2025-09-22 14:23:29.651117	active	group	approved		f
47dbcc5a-cbea-4dab-89b3-c6593167ec4c	world-maritime-university	World Maritime University	Address: Fiskehamnsgatan 1, 211 18, Malmö, SE-201 24, Sweden\nAcronym: WMU\nActivities: <p>The World Maritime University (WMU) in Malmö, Sweden is a postgraduate maritime university founded in 1983 by the International Maritime Organization (IMO), a specialized agency of the United Nations.&nbsp;</p><p>The aim of WMU is to further enhance the objectives and goals of IMO and IMO member States around the world through education, research, and capacity building to ensure safe, secure, and efficient shipping on clean oceans.&nbsp;WMU is truly an organization by and for the international maritime community.&nbsp;</p><p>The University operates on the basis of a Charter adopted by the IMO Assembly, and is accountable to the IMO Secretary-General, Council and Assembly, and to an international Board of Governors composed of representatives of some 50 different governmental, industry, labour and educational bodies. The University presents its annual report and budget to the IMO Council and also reports to the biennial session of the IMO Assembly. WMU receives the status, privileges and immunities of a UN institution in Sweden, and WMU degrees are recognized by the Swedish Ministry of Education and Research.</p>\nOcean Expert Members: 8	2025-09-22 14:23:38.777446	active	group	approved		f
e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	universidad-nacional-autonoma-de-mexico-mazatlan	Universidad Nacional Autónoma de México, Mazatlán	Address: Av. Joel Montes Camarena s/n, Col. Playa Sur, Mazatlán, Sinaloa, 82040, Mexico\nAcronym: UNAM\nActivities: The Institute for Marine Sciences and Limnology is an academic institution dealing on several marine and limnological aspects on the field of biology, chemistry, physics and geology.\nOcean Expert Members: 5	2025-09-22 14:23:45.773338	active	group	approved		f
596933a1-a00e-44b1-b9a9-7c223faa26d4	academy-of-natural-sciences-philadelphia	Academy of Natural Sciences, Philadelphia	Address: 1900 Benjamin Franklin Parkway, Philadelphia, Pennsylvania, PA 19103-1195, United States of America\nAcronym: ANSP\nActivities: The Academy of Natural Sciences, established in 1812, is the oldest natural science research institution and museum in the Americas. It's recognized internationally for its vast collections, research, exhibits, and educational programs. The Academy’s collection of over 17 million cataloged natural history specimens and artifacts is among the ten largest in the United States.\nOcean Expert Members: 2	2025-09-22 14:23:49.202112	active	group	approved		f
99acce96-4964-4e91-a278-4041df40e9f6	bccmulc-culture-collection-at-the-university-of-liege	BCCM/ULC culture collection at the University of Liège	Address: Allée du 6 Août, 11, Liège, 4000, Belgium\nActivities: <p><small><b>BCCM/ULC is a small and dedicated public collection, currently containing one of the largest collections of documented (sub)polar cyanobacteria worldwide.</b></small></p><h2><small><b>The BCCM/ULC collection is hosted by the research unit InBios -&nbsp;</b></small><a target="_blank" rel="nofollow" href="http://labos.ulg.ac.be/cip/"><small><b>Centre for Protein Engineering</b></small></a><small><b>&nbsp;(the Unit) of the&nbsp;</b></small><a target="_blank" rel="nofollow" href="http://www.uliege.be/"><small><b>University of Liège</b></small></a><small><b>. The host Unit is very active in research projects concerning the cyanobacterial diversity, biogeography, and ecophysiology, with a focus on polar biotopes. The used approach is polyphasic, including the isolation of strains and culture-independent methods (Amplicon sequencing of the 16S rRNA gene, metagenomics, comparative genomics). The participation to field expeditions in the Antarctic and Arctic has enabled to collect samples from many polar locations. Furthermore, bloom-forming and toxin-producing cyanobacterial communities in Belgian lakes are studied. Moreover, taxonomic research is carried out by the host Unit to improve the classification of the cyanobacterial phylum. It is based on a polyphasic approach combining the morphological and molecular characterizations of the strains.</b></small><br></h2>	2025-09-22 14:23:56.079524	active	group	approved		f
bd1d27e6-96cc-4a97-92bd-384228885c83	association-chene	Association CHENE	Address: 12 – 18 rue du musée, hameau « Bouillot », Allouville-Bellefosse, 76190 , France\nActivities: L’association CHENE – Centre d’Hébergement et d’Etude sur la Nature et l’Environnement&nbsp;<span>– agit depuis 1980 pour le respect et la défense de la faune sauvage. Ce nom a été donné en écho au chêne millénaire d’Allouville-Bellefosse, arbre patrimoine, situé à 2km de l’association. C’est une association loi 1901, agréée au titre de l’article L141-1 du code de l’environnement et membre fondateur de la fédération France Nature Environnement de Normandie</span>	2025-09-22 14:23:59.579178	active	group	approved		f
5cf9a03f-7e66-48af-9327-2dc4f39e7c01	centre-national-de-la-recherche-scientifique-observatoire-oceanologique-de-banyuls-sur-mer	Centre National de la Recherche Scientifique, Observatoire Océanologique de Banyuls sur Mer	Address: Avenue Pierre Fabre, Banyuls-sur-Mer, 66650, France\nAcronym: CNRS - OOB\nActivities: Le Centre de recherche en biodiversité et biotechnologies marines verra le jour d’ici 2014 au sein du Laboratoire Arago dirigé par le Professeur Philippe Lebaron. Ce projet de 11 millions d'euros H.T. sera financé par les Laboratoires Pierre Fabre, l'Etat, la Région, le Département, la Communauté des communes, la Commune de Banyuls, l'Université Pierre et Marie Curie-UPMC, l'Université de Perpignan, le CNRS et l'Institut National des Sciences de l'Univers.<br>Ce projet original de partenariat public privé regroupera des activités de recherche, de formation et de diffusion des connaissances scientifiques dans le domaine de la biodiversité marine et de l’écologie..\nOcean Expert Members: 6	2025-09-22 14:24:05.16541	active	group	approved	instituteLogo.jpg	f
76bac861-e7d0-44fe-b34d-fed4e5b5d665	institut-de-recherche-pour-le-developpement	Institut de Recherche pour le Développement	Address: IRD Bretagne, \r\nUMR LEMAR (IRD/CNRS/UBO),\r\nBP 70, 29 280 Plouzané, France, Plouzané, North Brittany, 29280, France\nAcronym: IRD\nActivities: The IRD is a unique institution in the landscape of European research for development. Its task is to conduct research in the South, for the South, with the South.\r\n\r\nIts researchers are working on issues of major global importance today: global warming, emerging diseases, biodiversity, access to water, migration, poverty, world hunger. The teaching and training they provide empowers and enables Southern scientific communities.\nOcean Expert Members: 1	2025-09-22 14:06:42.596385	active	group	approved		f
04dc13a7-cad6-4295-97b6-5ba171cfc70f	institut-de-recherche-pour-le-developpement-noumea-bp-a5-nouvelle-caledonie	Institut de Recherche pour le Développement, Noumea, BP A5, Nouvelle-Calédonie	Address: Centre IRD, Nouméa, New Caledonia, 98848, France\nAcronym: IRD\nActivities: The IRD (Institut de recherche pour le développement) is a French research organisation, original and unique on the European development research scene. Emphasizing interdisciplinarity, the IRD has focused its research for over 65 years on the relationship between man and its environment, in Africa, Mediterranean, Latin America, Asia and the French tropical overseas territories.  Its research, training and innovation activities are intended to contribute to the social, economic and cultural development of southern countries.\n\nOcean Expert Members: 1	2025-09-22 14:24:08.464229	active	group	approved		f
08261c43-f1a0-48ce-81fa-3a83731349b1	cawthron-institute	Cawthron Institute	Address: Private Bag 2, Nelson 7042, 98 Halifax Street East, Nelson, 7010, New Zealand\nActivities: <p>Cawthron Institute is New Zealand's largest independent science organisation, offering a broad spectrum of services to help protect the environment and support sustainable development of primary industries.</p><p>Based in the Nelson region, we work with regional councils, government departments, major industries, private companies, and other research organisations throughout New Zealand and around the world.&nbsp;</p><p>Cawthron is a diverse organisation employing almost 200 scientists, laboratory technicians, researchers and specialist staff from more than 20 different countries.</p>\nOcean Expert Members: 3	2025-09-22 14:24:14.065653	active	group	approved	instituteLogo.jpg	f
c7508cda-2d43-465e-9433-814f0b71d4a1	stanford-university-hopkins-marine-station	Stanford University, Hopkins Marine Station	Address: 120 Oceanview Blvd., Pacific Grove, California, CA 93950, United States of America\nAcronym: HMS\nActivities: Aerial Image of Hopkins Marine StationThe Hopkins Marine Station, located 90 miles from the main University campus in Pacific Grove, was founded in 1892 as the first marine laboratory on the west coast of North America. The modern laboratory facilities on the 11-acre campus on Cabrillo Point house ten faculty, all members of the Department of Biology. The Miller Library has a collection of literature in marine science. The Hopkins faculty offers undergraduate and graduate courses in biology which focus on the marine realm and involve topics including oceanography, environmental and comparative physiology, molecular evolution, biomechanics, cellular biology, conservation biology, and neurobiology and behavior. Most courses have laboratory sections that exploit the potential of working with readily available marine plants and animals. Small class sizes encourage close student-faculty interactions. Undergraduates have opportunities to carry out research projects with Hopkins faculty during the academic year or summer months. Courses  are offered in Winter, Spring, and Summer quarters. Summer classes are open to non-Stanford students.\nOcean Expert Members: 3	2025-09-22 14:24:17.588018	active	group	approved		f
cf37b8d5-c6fe-456b-922d-70da288be1ab	bare-sand-island-flatback-green-and-hawksbill-project	Bare Sand Island Flatback, Green and Hawksbill Project	Address: Ellengowan Drive, Casuarina, NT 081, Australia\nActivities: <p>t’s officially the 2012 flatback nesting season and AusTurtle are doing their thing for sea turtle research on Bare Sand Island.</p><p>A large population of flatback sea turtles nest at Bare Sand Island during the winter months. During this time, researchers gather data on the nesting turtles to estimate population size, monitor abundance and to determine any threats to survival.</p><p>As well flatbacks, the waters around Bare Sand Island support significant numbers of foraging green and hawksbill turtles. Both species are vulnerable to extinction under Australian classification (EPBC Act 1999). Green turtles are internationally classified as endangered and hawksbill turtles are critically endangered internationally (IUCN Red List).</p><p>The Austurtle research commenced in 1996 and is supported by Charles Darwin University. The research project is run by Dr Michael Guinea</p>	2025-09-22 14:24:19.517422	active	group	approved		f
d7588e22-a304-411e-9dd4-7b5afbd6d5d0	canterbury-museum	Canterbury Museum	Address: Rolleston Avenue, Christchurch , 8013, New Zealand\nActivities: Visit and explore New Zealand's rich cultural and natural heritage. Learn about the past, present and future of Canterbury.	2025-09-22 14:24:21.496285	active	group	approved		f
ce9241f6-12bf-4e79-a45a-e1b3715efe61	danmarks-tekniske-universitet	Danmarks Tekniske Universitet	Address: Anker Engelunds Vej 1, Bygning 101A , Kgs. Lyngby, 2800, Denmark\nAcronym: DTU\nOcean Expert Members: 5	2025-09-22 14:24:25.1704	active	group	approved	instituteLogo.jpg	f
1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	unesco-ioc-project-office-for-iode	UNESCO / IOC Project Office for IODE	Address: InnovOcean Campus, Jacobsenstraat 1, Oostende, 8400, Belgium\nAcronym: IODE\nActivities: The programme "International Oceanographic Data and Information Exchange" (IODE) of the "<a target="_blank" rel="nofollow" href="http://ioc-unesco.org">Intergovernmental Oceanographic Commission" (IOC)</a> of <a target="_blank" rel="nofollow" href="http://www.unesco.org">UNESCO</a>\r\n was established in 1961.<br>Its purpose is to enhance marine research, \r\nexploitation and development, by facilitating the exchange of \r\noceanographic data and information between participating Member States, \r\nand by meeting the needs of users for data and information products.<br><br><br><br>||OTGA RTC||\nOcean Expert Members: 20	2025-09-22 14:24:30.573861	active	group	approved	instituteLogo.jpg	f
76c01c2d-3f19-427b-b102-c3e2c00ca822	international-society-for-the-study-of-harmful-algae	International Society for the Study of Harmful Algae	Address: IOC Science and Communication Centre on Harmful Algae University of Copenhagen, Marine Biological Section,  Universitetsparken 4, Copenhagen Ø, 2100, Denmark\nAcronym: ISSHA\nActivities: <span>The International Society for the Study of Harmful Algae (ISSHA) was founded in 1997, in response to a request from the Intergovernmental Oceanographic Commission (IOC) of UNESCO for an international programme o­n harmful algae. The Society is affiliated to the ICSU family of organizations as a constituent part of the International Union of Biological Sciences (IUBS) through the International Association of Biological Oceanography (IABO). The overall mandate of the Society is to promote and foster research and training programs o­n harmful algae, and to co-sponsor meetings o­n this topic at the national, regional, and international level.<br></span><br>For more information, contact any of the&nbsp;<a target="_blank" rel="nofollow" href="http://www.issha.org/Contact-us">officers of ISSHA</a><br>	2025-09-22 14:24:32.353096	active	group	approved	instituteLogo.jpg	f
a982727a-c8b0-4c06-bc58-522c2d67dbcc	cayman-turtle-farm	Cayman Turtle Farm	Address: 786 Northwest Point Road, West Bay, PO Box 812 , Grand Cayman,  KY1-1303, Cayman Islands\nActivities: <span>Cayman's largest land-based tourist attraction, Cayman Turtle Centre: Island Wildlife Encounter hosts more than 200,000 visitors each year. Educational, cultural and entertainment programmes are consistently being created and updated to enhance the experience that can only be found at our world-renowned attraction</span>	2025-09-22 14:24:36.95195	active	group	approved		f
6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	maryland-department-of-natural-resources	Maryland Department of Natural Resources	Address: 580 Taylor Ave   Annapolis  MD Maryland 21401, Annapolis, United States of America\nAcronym: MD DNR\nActivities: Extensive water quality monitoring in Eastern US, both with automatic sampling equipment (ISCO's) and hand collection, familiar with the most current models of YSI and Hydrolab multi-parameter water q\nOcean Expert Members: 1	2025-09-22 14:24:40.429838	active	group	approved		f
7eb04b9d-202f-45d0-b49f-a67cc19307f5	biologia-molecular-marina	BIOLOGÍA MOLECULAR MARINA	Address: Departamento Ciencias Biológicas-Facultad de Ciencias,, Universidad de los Andes Carrera 1E No 18A - 10 (J 212/ J 308 lab) , Bogotá, 110111, Colombia\nAcronym: BIOMMAR\nActivities: Our interests are centered in the interaction between ecology and evolution, particularly of coral reef invertebrates such as octocorals, black corals, corals and sponges (and their symbionts). We are focusing on bridging phenotypic plasticity and ecological speciation as well as finding underlying adaptations to environmental conditions (including rising seawater temperature) and/or specialist symbionts in populations of coral reef organisms. However, we are doing a great effort to transfer our knowledge and research to the regions and local communities from the areas we have been working in the last few years. In addition, we have a number of synergies and funded projects on marine conservation biology, socioecological systems, octocoral systematics and community ecology. We follow an integrative biology approach including strong field, lab and computational components in our research.\nOcean Expert Members: 1	2025-09-22 14:24:43.951392	active	group	approved		f
fd38eafe-608a-4b8b-ad35-0817f95f794f	conservation-international-global-marine-division	Conservation International - Global Marine Division	Address: 2011 Crystal Drive\r\nSuite 500, Arlington, Virginia, 22202, United States of America\nAcronym: CI/GMD\nOcean Expert Members: 4	2025-09-22 14:24:49.133315	active	group	approved		f
3b9842e9-2d1f-4b4a-8538-fbe9912851d9	western-university-department-of-biology	Western University – Department of Biology	Address: 1151 Richmond Street, London, Ontario, N6A 5B7, Canada\nAcronym: UWO\nOcean Expert Members: 2	2025-09-22 14:24:54.371509	active	group	approved		f
71f64ffc-3a7e-43ae-a42f-5f2afe70971d	aquarium-of-the-pacific	Aquarium of the Pacific	Address: 00 Aquarium Way, Long Beach, California, 90802, United States of America\nActivities: <h2>Southern California’s Largest Aquarium</h2><p>The Aquarium of the Pacific’s mission is to instill a sense of wonder, respect, and stewardship for the Pacific Ocean, its inhabitants, and ecosystems. Our vision is to create an aquarium dedicated to conserving and building Natural Capital (Nature and Nature’s services) by building Social Capital (the interactions between and among peoples). The Aquarium of the Pacific has redefined the modern aquarium. It is a community gathering place where diverse cultures and the arts are celebrated and a place where important topics facing our planet and our ocean are explored by scientists, policymakers, and stakeholders in the search for sustainable solutions. It has taken a bold new approach in the future of aquariums with the opening of its Pacific Visions wing.</p>	2025-09-22 14:24:56.164096	active	group	approved		f
a4efb55b-125c-4e53-8520-c1d1657def53	wildlife-institute-of-india	Wildlife Institute of India	Address: Post Box No. 18 \r\nChandrabani, Dehra Dun, Uttaranchal, 248 001, India\nAcronym: WII\nActivities: Research and Development on Wildlife Conservation\r\nCapacity Building of Protected Area Managers and Frontline Staffs\r\nConsultancy on Wildlife Conservation and Protected Area\r\nEducation and Awareness on Environmental Conservation\nOcean Expert Members: 8	2025-09-22 14:24:59.67757	active	group	approved		f
e83539a2-a0bc-49c3-8502-f0eff7de87b9	obis-community	OBIS Community	This is a default organization for products that are added and it's not clear which part of the network they should be associated with.	2025-09-25 21:05:32.386577	active	organization	approved		t
\.


--
-- Data for Name: group_extra; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.group_extra (id, group_id, key, value, state) FROM stdin;
52e6b17a-70c9-43be-9536-c8dc59661a8f	39e5a7fa-96cb-4c1b-b05d-825db0801594	ocean_expert_id	18705	active
f29a9601-fc69-42f2-86aa-87a9f155cdd9	39e5a7fa-96cb-4c1b-b05d-825db0801594	data_source	obis_oceanexpert	active
f5a772ac-77c8-43df-932c-730f8d087e20	39e5a7fa-96cb-4c1b-b05d-825db0801594	sync_date	2025-09-22	active
5235b69c-dbf7-4a03-bbad-7b4a12970865	52bd6a8e-a044-480d-8c86-9aeb135dd4f7	ocean_expert_id	5163	active
15400337-d6c8-4e1a-9542-aacad97991be	52bd6a8e-a044-480d-8c86-9aeb135dd4f7	data_source	obis_oceanexpert	active
fa549f2e-7588-4ad8-b747-e176a816da6a	52bd6a8e-a044-480d-8c86-9aeb135dd4f7	sync_date	2025-09-22	active
7d72a8f1-c178-47a8-9a92-a365b2ad440b	f3c05b89-ae29-4798-b851-3f847333d9eb	ocean_expert_id	19390	active
af393d56-1a63-440d-a419-0836136a2432	f3c05b89-ae29-4798-b851-3f847333d9eb	data_source	obis_oceanexpert	active
33bc1500-2ef4-4870-8609-a45663469df8	f3c05b89-ae29-4798-b851-3f847333d9eb	sync_date	2025-09-22	active
db43f294-48f3-436f-9f2e-3a99beab4616	0e9ea7d9-b300-44a1-aea5-e1e0b9fd9644	ocean_expert_id	19324	active
a5a7c9a2-1b3c-48dc-89eb-4b16a3d2651e	0e9ea7d9-b300-44a1-aea5-e1e0b9fd9644	data_source	obis_oceanexpert	active
e4719641-4d22-4eb6-bd04-7f448383967f	0e9ea7d9-b300-44a1-aea5-e1e0b9fd9644	sync_date	2025-09-22	active
67cddde1-90ac-4e2a-b8d6-c402d27921cc	6dfb3459-5fdd-487c-a001-1e63d3318100	ocean_expert_id	8326	active
d51ca361-077c-4da6-8f17-73e290b55e66	6dfb3459-5fdd-487c-a001-1e63d3318100	data_source	obis_oceanexpert	active
dcfd27f3-79c6-444b-85b0-99d124e3b82b	6dfb3459-5fdd-487c-a001-1e63d3318100	sync_date	2025-09-22	active
04fc4a73-3144-44b8-801e-66bc7b3bfef7	75876ec7-e686-4240-a1ce-2a9cdf5929ee	ocean_expert_id	4953	active
a214f33f-3f3f-49a4-a335-8c6a74bc254f	75876ec7-e686-4240-a1ce-2a9cdf5929ee	data_source	obis_oceanexpert	active
1ed7d93d-c278-418e-9737-c19933008093	75876ec7-e686-4240-a1ce-2a9cdf5929ee	sync_date	2025-09-22	active
ccafb05a-09bc-41a5-89c4-b5d80e5ca22b	293b388d-43d1-41b9-874f-3594204df05c	ocean_expert_id	13830	active
320220cd-ae3a-4800-ba00-5381bf0df794	293b388d-43d1-41b9-874f-3594204df05c	data_source	obis_oceanexpert	active
48157713-584b-4c3e-bdae-c9ae588a0848	293b388d-43d1-41b9-874f-3594204df05c	sync_date	2025-09-22	active
1848c520-000f-4bee-99b1-72b1bbb3fa0f	d4543bd1-9877-4ca6-b088-6811839e3991	ocean_expert_id	19165	active
1e1bc71f-3063-4702-a5ca-e77f416ca1fa	d4543bd1-9877-4ca6-b088-6811839e3991	data_source	obis_oceanexpert	active
c2244fbe-3b7b-4c4e-997f-64059b76679b	d4543bd1-9877-4ca6-b088-6811839e3991	sync_date	2025-09-22	active
136cc4e3-a2a0-4303-9903-caf36680bee9	a390a520-185a-498f-b7e1-1f3955bcc910	ocean_expert_id	19589	active
250b66d0-1a99-41d2-8261-283eb3a5187d	a390a520-185a-498f-b7e1-1f3955bcc910	data_source	obis_oceanexpert	active
65e60f38-6d79-408d-ba90-b5998f293a87	a390a520-185a-498f-b7e1-1f3955bcc910	sync_date	2025-09-22	active
125232ea-00ea-4e28-b50a-37ed071161cb	a28f25a4-fea1-4e38-9f10-10dfeffe6910	ocean_expert_id	6434	active
f695eb24-837b-46e2-a81c-a9c5c3ddd275	a28f25a4-fea1-4e38-9f10-10dfeffe6910	data_source	obis_oceanexpert	active
1c7530c5-a3bb-43b1-9d45-e4c9c20c13ab	a28f25a4-fea1-4e38-9f10-10dfeffe6910	sync_date	2025-09-22	active
ee6dcf9c-e67f-47ee-81df-6f243b185d2b	2be97b83-283e-4bd3-906a-67b3a393c11e	ocean_expert_id	20910	active
6c02c5ff-4244-4695-881f-87365ae1b348	2be97b83-283e-4bd3-906a-67b3a393c11e	data_source	obis_oceanexpert	active
8dec0c1d-51c8-4ce8-baa3-d3c2dd7926fa	2be97b83-283e-4bd3-906a-67b3a393c11e	sync_date	2025-09-22	active
74570e51-f92a-40ba-b57e-ffa416fcc8cb	264f6298-0e34-43a8-bf68-b28a235fbc8e	ocean_expert_id	12703	active
81200c76-382f-4cb1-8ace-188011d0d03d	264f6298-0e34-43a8-bf68-b28a235fbc8e	data_source	obis_oceanexpert	active
2853bd69-c17c-4a46-a054-8381b9b2be61	264f6298-0e34-43a8-bf68-b28a235fbc8e	sync_date	2025-09-22	active
4dcbaf4e-5878-465b-a666-eadcbd99fa4d	8dc59986-db13-4f28-8e67-a935b692e707	ocean_expert_id	19053	active
10da814d-41b9-4f62-bd95-e35d8c5006a5	8dc59986-db13-4f28-8e67-a935b692e707	data_source	obis_oceanexpert	active
7a06d076-34ce-4503-bfd5-d16958341831	8dc59986-db13-4f28-8e67-a935b692e707	sync_date	2025-09-22	active
23967a42-cc85-4748-a808-a437ce7c6c93	ff8aa929-7052-48b5-b09d-18cdb9c7a0dc	ocean_expert_id	5070	active
9144f0b3-e32e-4121-a0d8-f00c384bc9d3	ff8aa929-7052-48b5-b09d-18cdb9c7a0dc	data_source	obis_oceanexpert	active
9b401dc5-4683-4a76-bdbe-5ec44cf80669	ff8aa929-7052-48b5-b09d-18cdb9c7a0dc	sync_date	2025-09-22	active
4c625035-4f0e-4f0e-b1f6-c0d23bd1b667	3a427c28-8873-4307-87d9-e9adbe837138	ocean_expert_id	6974	active
a95ca215-a789-425e-8499-25cbdff677e6	3a427c28-8873-4307-87d9-e9adbe837138	data_source	obis_oceanexpert	active
3638a8ff-8862-4799-a636-986d029de269	3a427c28-8873-4307-87d9-e9adbe837138	sync_date	2025-09-22	active
a8b25a75-3abf-4129-9581-9e2f606201dc	3a4aa10f-a20e-4dc7-b841-554397287ff7	ocean_expert_id	6509	active
cfbbc9c1-d3ef-426a-a8c3-0fa8f08ede70	3a4aa10f-a20e-4dc7-b841-554397287ff7	data_source	obis_oceanexpert	active
288bd405-b018-4527-91d1-720727adfd21	3a4aa10f-a20e-4dc7-b841-554397287ff7	sync_date	2025-09-22	active
575a0bf5-475b-4ea4-9ad2-eb5b9f932e12	e641c794-b901-4796-8f84-1c560bed38ee	ocean_expert_id	7534	active
f04f6148-4fac-4f5f-8e6c-80584dd25965	e641c794-b901-4796-8f84-1c560bed38ee	data_source	obis_oceanexpert	active
3b86879b-3f8d-46ea-a70b-99467c0b07d0	e641c794-b901-4796-8f84-1c560bed38ee	sync_date	2025-09-22	active
99edab20-a54d-4ec6-aa7c-45e67f51e8fe	95785cd3-73db-4b63-939a-436a66050fab	ocean_expert_id	11456	active
2efb841a-eb84-4e9c-90b5-d8a7f5adcf16	95785cd3-73db-4b63-939a-436a66050fab	data_source	obis_oceanexpert	active
e9243fae-686a-41cc-9fd3-bbcb2e0a9f19	95785cd3-73db-4b63-939a-436a66050fab	sync_date	2025-09-22	active
cee850bf-f757-4125-87e4-910e2744e18a	bacaf6cf-7a04-447d-9e0a-c60078e8fb8c	ocean_expert_id	5671	active
f608c022-ac67-4249-8ccf-2b3cb3f439d0	bacaf6cf-7a04-447d-9e0a-c60078e8fb8c	data_source	obis_oceanexpert	active
799e839c-127d-4082-bbca-57eb0ac0e814	bacaf6cf-7a04-447d-9e0a-c60078e8fb8c	sync_date	2025-09-22	active
024f64fb-0a15-4fea-b302-da03d2ad8f0a	9897699d-0fd1-4ad4-8358-eccee53d8384	ocean_expert_id	8124	active
01b1714b-05d8-41af-9d98-a3c71ae95072	9897699d-0fd1-4ad4-8358-eccee53d8384	data_source	obis_oceanexpert	active
0afc65f8-c9dc-40c7-b383-0a04a0c89848	9897699d-0fd1-4ad4-8358-eccee53d8384	sync_date	2025-09-22	active
ae1e2595-4041-4782-aa8c-5e23c1462ae6	6810f491-2ccf-49fe-92c0-0ccdb7b214fb	ocean_expert_id	8493	active
53504be4-28cf-4067-be5f-9a1670678cb1	6810f491-2ccf-49fe-92c0-0ccdb7b214fb	data_source	obis_oceanexpert	active
ca8e2d81-f66f-4774-a4b5-b8003f17ea7c	6810f491-2ccf-49fe-92c0-0ccdb7b214fb	sync_date	2025-09-22	active
bf91c307-2b9d-4431-888b-456c4367ca8f	1b8c14b9-2b90-4d42-9c90-b78d5c1c1177	ocean_expert_id	9783	active
4e88c631-23d9-4f3e-82cf-86fd1422e953	1b8c14b9-2b90-4d42-9c90-b78d5c1c1177	data_source	obis_oceanexpert	active
34b3a4eb-f48a-4254-b604-9d05b1a7512c	1b8c14b9-2b90-4d42-9c90-b78d5c1c1177	sync_date	2025-09-22	active
691ed0e0-7b7a-4809-b27d-d039cc967374	b05309c2-88ee-45c5-9bc8-a71f5ec8b9d7	ocean_expert_id	11289	active
7686e5f3-3562-4513-9d23-b06f10bd176a	b05309c2-88ee-45c5-9bc8-a71f5ec8b9d7	data_source	obis_oceanexpert	active
07eca2f0-ac44-4be0-8837-c60d5c79c2f7	b05309c2-88ee-45c5-9bc8-a71f5ec8b9d7	sync_date	2025-09-22	active
ecb52a3f-d415-473d-b50e-2c80ddd448b6	2ae535d8-068b-4da4-8c87-5f587fa81715	ocean_expert_id	18936	active
d1a54441-036d-42af-aa60-a71ef28842c4	2ae535d8-068b-4da4-8c87-5f587fa81715	data_source	obis_oceanexpert	active
2daf1477-fc92-4cfb-b3d1-90f184835e7f	2ae535d8-068b-4da4-8c87-5f587fa81715	sync_date	2025-09-22	active
a03eb286-d1df-4b5d-ad7a-478912b52449	06ea9a4a-38e1-4eae-a9e8-dde613cc96c4	ocean_expert_id	20188	active
d720bb52-f735-4498-9c60-083dd3a55e46	06ea9a4a-38e1-4eae-a9e8-dde613cc96c4	data_source	obis_oceanexpert	active
fc65df46-d2d0-4365-b73f-20ad5103184b	06ea9a4a-38e1-4eae-a9e8-dde613cc96c4	sync_date	2025-09-22	active
f9520836-9be8-4342-a922-04612c13a4b4	fe44c029-cb97-41a9-99e7-2dcfc88f187c	ocean_expert_id	13402	active
b9568900-6543-4b1a-a33d-9830b44f2e26	fe44c029-cb97-41a9-99e7-2dcfc88f187c	data_source	obis_oceanexpert	active
f4ed9c9c-cad9-4e4d-b572-daca5c611278	fe44c029-cb97-41a9-99e7-2dcfc88f187c	sync_date	2025-09-22	active
d5a20b5e-bba1-4935-a160-cff01ed46d06	7e174027-29cb-4598-81bd-e70d298243e7	ocean_expert_id	17314	active
e723e181-963d-4094-88b4-f91a859f84e8	7e174027-29cb-4598-81bd-e70d298243e7	data_source	obis_oceanexpert	active
393fd08f-f020-49db-82e5-86b819080a97	7e174027-29cb-4598-81bd-e70d298243e7	sync_date	2025-09-22	active
48fdfd5d-ef40-484b-bcc4-831654b0d3ed	da452a4a-f160-4367-9289-1fdcc49e87ee	ocean_expert_id	9738	active
e66484c5-8a02-4467-b018-522cf3fa2232	da452a4a-f160-4367-9289-1fdcc49e87ee	data_source	obis_oceanexpert	active
36428b13-7f6b-4735-945f-033b4c06bec6	da452a4a-f160-4367-9289-1fdcc49e87ee	sync_date	2025-09-22	active
b229fdbc-44d3-416f-af1b-b1d9ab1fb822	6482c50d-b486-4dfd-9a3b-71b0f551db2b	ocean_expert_id	9838	active
0ba72d15-96ff-4dec-9402-cf9da4f8c1ff	6482c50d-b486-4dfd-9a3b-71b0f551db2b	data_source	obis_oceanexpert	active
92545e84-f9e0-4b71-b108-aacdcb5dc5ad	6482c50d-b486-4dfd-9a3b-71b0f551db2b	sync_date	2025-09-22	active
8c404301-3a11-4eb7-b189-0bc1ba0f6247	be1c91b6-bd6a-4374-a097-d8974586b1c3	ocean_expert_id	6514	active
23c2a3e1-6001-4d13-b2e4-0e82d9a8a92c	be1c91b6-bd6a-4374-a097-d8974586b1c3	data_source	obis_oceanexpert	active
dc02e94c-1292-4e59-9f12-ab8d7add8a95	be1c91b6-bd6a-4374-a097-d8974586b1c3	sync_date	2025-09-22	active
f842d421-8432-43d0-a900-5784b0012fb4	275c6efa-aabf-4f30-972a-a1a5bdf4a526	ocean_expert_id	6169	active
650925c2-d2a7-47c8-84e3-446a343f9c05	275c6efa-aabf-4f30-972a-a1a5bdf4a526	data_source	obis_oceanexpert	active
0ea5802a-7b97-453e-a429-5174b86e67e1	275c6efa-aabf-4f30-972a-a1a5bdf4a526	sync_date	2025-09-22	active
3565dd62-de0b-4f09-bbc0-873e02ef088b	0c4a0415-9ef9-4b50-9f55-33e10dac20ef	ocean_expert_id	19275	active
c97402de-e422-448d-82ae-d6bb0e30179a	0c4a0415-9ef9-4b50-9f55-33e10dac20ef	data_source	obis_oceanexpert	active
cb6a9f08-b4af-4d45-a7a2-6c8bddecdae1	0c4a0415-9ef9-4b50-9f55-33e10dac20ef	sync_date	2025-09-22	active
cc381c75-2369-449f-8f43-583dceb5b2d2	a2b5f56d-0cd5-415f-b839-726896209e41	ocean_expert_id	23187	active
bb2c4735-1832-47ef-b201-3fc14bd186ff	a2b5f56d-0cd5-415f-b839-726896209e41	data_source	obis_oceanexpert	active
acf4ba2f-ceb3-4657-98ea-235397023814	a2b5f56d-0cd5-415f-b839-726896209e41	sync_date	2025-09-22	active
a8145609-820a-4c49-83ec-8c4d22ff0903	ea8f768b-9884-459b-8895-68489faa3d1d	ocean_expert_id	5108	active
3d86dfc3-ecb3-4a80-b733-3d78176d68a3	ea8f768b-9884-459b-8895-68489faa3d1d	data_source	obis_oceanexpert	active
3a5f86c2-aff4-440d-9288-317258df0107	ea8f768b-9884-459b-8895-68489faa3d1d	sync_date	2025-09-22	active
df216706-14e9-466f-9b81-e1df43410967	ef095ef5-d3a6-446b-beb5-eae3e3066aff	ocean_expert_id	7553	active
3ace41f4-a632-416f-9135-8b8335e30979	ef095ef5-d3a6-446b-beb5-eae3e3066aff	data_source	obis_oceanexpert	active
3a153777-7148-4aae-acf2-45dcc1d29c0b	ef095ef5-d3a6-446b-beb5-eae3e3066aff	sync_date	2025-09-22	active
975e16e9-fe6f-4604-8f2a-86b65a8fc957	6a0220c4-d2c2-4453-99ae-f89ca5907538	obis_node_id	14fc439c-707d-41d6-a3d4-b9d2696205fe	active
36666f17-1fd3-4235-98b2-eb2f090e3e54	6a0220c4-d2c2-4453-99ae-f89ca5907538	node_type	regional	active
2f18839c-2f9b-41e0-8492-b49c4e7f1aac	6a0220c4-d2c2-4453-99ae-f89ca5907538	node_url	https://obis.org/node/14fc439c-707d-41d6-a3d4-b9d2696205fe	active
60f0bda1-750e-42ab-9987-c2aec274195d	6a0220c4-d2c2-4453-99ae-f89ca5907538	longitude	18.8490854	active
2d1f8813-b962-47a6-8577-0d78ebde48d0	6a0220c4-d2c2-4453-99ae-f89ca5907538	latitude	-33.9235315	active
c02653a9-1eec-4cf7-abe1-e4fa43859e6c	6a0220c4-d2c2-4453-99ae-f89ca5907538	theme	Sub-Saharan African OBIS node	active
89752226-53cc-48a0-85e0-9a66291bdbef	6a0220c4-d2c2-4453-99ae-f89ca5907538	contacts	[{"givenname": "Tshikana", "surname": "Rasehlomi", "oceanexpert_id": 24561, "email": "TRasehlomi@environment.gov.za"}, {"givenname": "Ayanda", "surname": "Mahanjana", "oceanexpert_id": 61671, "email": "AMahanjana@dffe.gov.za"}]	active
23eca5c3-6eb9-4967-81c1-4560b7deebec	6a0220c4-d2c2-4453-99ae-f89ca5907538	feeds	[{"id": "d9907126-7fd7-4fbd-a5d5-f906e59bd815", "url": "https://ipt-nigeria.gbif.fr/rss.do"}, {"id": "9453eb8f-38ec-4c9c-8761-6372183c7093", "url": "https://ipt-cameroun.gbif.fr/rss.do"}, {"id": "052e40a0-84f9-4623-bccf-59ba8aa05a57", "url": "http://ipt.iobis.org/afrobis/rss.do"}, {"id": "c6e76d93-61bb-4465-9922-0c3b1d657cf4", "url": "http://ipt.saiab.ac.za/rss.do"}]	active
ab0f7485-8f0e-433f-aa62-c10a91f676a8	564d4b37-c5a3-4a4a-8585-acaacf0134b3	obis_node_id	dc6c6ea2-83f5-4b18-985a-9efff6320d69	active
6f4a3143-b679-406f-abeb-4dc68951cd0e	564d4b37-c5a3-4a4a-8585-acaacf0134b3	node_type	regional	active
b41aaa8f-c48b-4c03-a0f2-2a0e331fd12a	564d4b37-c5a3-4a4a-8585-acaacf0134b3	node_url	http://www.biodiversity.aq/	active
a4a28d91-84d2-4334-b831-c9a792cd2677	564d4b37-c5a3-4a4a-8585-acaacf0134b3	longitude	4.365477	active
31afcccf-a969-42a1-8252-39e522e91920	564d4b37-c5a3-4a4a-8585-acaacf0134b3	latitude	50.82524	active
d54c1912-5c2a-46bf-88d8-00804e2dc6d1	564d4b37-c5a3-4a4a-8585-acaacf0134b3	theme		active
b901c6f2-d760-4357-8592-4cec0169b329	564d4b37-c5a3-4a4a-8585-acaacf0134b3	contacts	[{"givenname": "Anton", "surname": "Van de Putte", "oceanexpert_id": 22246, "email": "avandeputte@naturalsciences.be"}, {"givenname": "Yi Ming", "surname": "Gan", "oceanexpert_id": 31194, "email": "ymgan@naturalsciences.be"}, {"givenname": "Pablo", "surname": "Deschepper", "oceanexpert_id": 76853, "email": "pdeschepper@naturalsciences.be"}, {"givenname": "Charlie", "surname": "Plasman", "oceanexpert_id": 63929, "email": "cplasman@naturalsciences.be"}]	active
7a781765-0ab6-47b0-bd29-173f668657b0	564d4b37-c5a3-4a4a-8585-acaacf0134b3	feeds	[{"id": "10214f27-4e6d-4edb-8de0-bce4bdd00e37", "url": "http://ipt.biodiversity.aq/rss.do"}]	active
343d083d-42e1-4d6c-8bd2-8f93f4f73d35	365ac034-63ba-4116-b87f-8bd8c34e6b40	obis_node_id	da50007b-7871-46cf-8530-441b5836d2c1	active
f6a12e6e-90fb-45ed-80a0-ad51d672a67d	365ac034-63ba-4116-b87f-8bd8c34e6b40	node_type	regional	active
99ba6812-4307-476c-a9c0-adb3cd58e011	365ac034-63ba-4116-b87f-8bd8c34e6b40	node_url	https://www.abds.is/	active
68bd3552-5fab-406c-83b1-ff40454c690d	365ac034-63ba-4116-b87f-8bd8c34e6b40	longitude	-18.1199337	active
d547ce36-4817-46bb-a67f-d988975841db	365ac034-63ba-4116-b87f-8bd8c34e6b40	latitude	65.6847385	active
f0bc500d-6ed3-4c05-886d-a22f7c410f1a	365ac034-63ba-4116-b87f-8bd8c34e6b40	theme		active
3eee2820-c7cd-4db3-b028-b3bc04cb44c8	365ac034-63ba-4116-b87f-8bd8c34e6b40	contacts	[{"givenname": "H\\u00f3lmgr\\u00edmur ", "surname": " Helgasson", "oceanexpert_id": 26759, "email": "hoddi@caff.is"}, {"givenname": "Kari", "surname": "Larusson", "oceanexpert_id": 26758, "email": "kari@caff.is"}]	active
5e546972-af02-4179-a513-014a03916c61	365ac034-63ba-4116-b87f-8bd8c34e6b40	feeds	[{"id": "0732bee5-4149-4f26-b197-51bb357342fd", "url": "http://geo.abds.is/ipt/rss.do"}]	active
25924c7a-436f-4844-afa1-1dd8e8f7c51b	6bab9702-e011-417e-aa58-2adedd1d0a72	obis_node_id	8385435b-bcf5-4bec-b827-8b480163d479	active
1d8f3fac-49fb-44e4-a98f-8cd64fdd1e92	6bab9702-e011-417e-aa58-2adedd1d0a72	node_type	regional	active
88373cfc-fb91-4b1b-a438-9739012f0727	6bab9702-e011-417e-aa58-2adedd1d0a72	node_url		active
6f81c1f1-6413-403e-8fb4-efc1425e844c	6bab9702-e011-417e-aa58-2adedd1d0a72	longitude	-66.8777622	active
99b2aad6-2924-4571-9183-a5e7b3346ef0	6bab9702-e011-417e-aa58-2adedd1d0a72	latitude	10.4083683	active
92454bd6-37dd-425d-9c46-6cab1a2a351f	6bab9702-e011-417e-aa58-2adedd1d0a72	theme		active
7e31847d-b061-45e9-aa1c-a24f22af15de	6bab9702-e011-417e-aa58-2adedd1d0a72	contacts	[{"givenname": "Eduardo ", "surname": "Klein", "oceanexpert_id": 9199, "email": "eklein@usb.ve"}, {"givenname": "Carlos", "surname": "Carmona", "oceanexpert_id": 47749, "email": "microphrys@gmail.com"}, {"givenname": "Carolina", "surname": "Peralta", "oceanexpert_id": 26345, "email": "anacarolaperaltab@gmail.com"}, {"givenname": "Jeannette", "surname": "Perez", "oceanexpert_id": 45931, "email": "perezjeannette@gmail.com"}, {"givenname": "Joxmer ", "surname": "Scott-Fr\\u00edas", "oceanexpert_id": 47770, "email": "joxmer@gmail.com"}]	active
060cd39b-50cc-437b-aa9c-e43ca0ad3d75	6bab9702-e011-417e-aa58-2adedd1d0a72	feeds	[{"id": "41f6b8bd-4096-4215-88e8-d2065bcac37a", "url": "https://ipt.vliz.be/cibima/rss.do"}, {"id": "8789b8fe-3699-4368-8a23-3408690731e4", "url": "http://ipt.iobis.org/caribbeanobis/rss.do"}, {"id": "e3b1d350-7cf3-4bd6-95f5-717636377cbe", "url": "http://ipt.iobis.org/mbon/rss.do"}]	active
17faa126-f6c7-4d9c-b2bd-e5be80dadf78	3e117d1c-778e-4aca-9b34-b294399a2947	obis_node_id	fd3a5df5-6a6f-46ca-a9c6-e61896a3f355	active
e8a08c72-6826-4880-b074-640120884666	3e117d1c-778e-4aca-9b34-b294399a2947	node_type	regional	active
8012400d-c3d4-4ef3-8571-348baa4d51e2	3e117d1c-778e-4aca-9b34-b294399a2947	node_url	http://ron.udec.cl/	active
246eec6e-afd1-4865-97ec-952939e78e57	3e117d1c-778e-4aca-9b34-b294399a2947	longitude	-73.0680649	active
78d3f758-5c88-4bf7-9e17-a12d4ae095a3	3e117d1c-778e-4aca-9b34-b294399a2947	latitude	-36.8262254	active
13137e4a-9751-41a9-ae0d-65944cfe0c28	3e117d1c-778e-4aca-9b34-b294399a2947	theme	Tropical and Subtropical Eastern South Pacific OBIS node	active
cda98dc4-0582-45fe-8d7e-0eacada490f9	3e117d1c-778e-4aca-9b34-b294399a2947	contacts	[{"givenname": "Pamela", "surname": "Hidalgo", "oceanexpert_id": 35026, "email": "pamelahidalgodiaz@gmail.com"}, {"givenname": "Ruben", "surname": "Escribano", "oceanexpert_id": 17974, "email": "rescribano@udec.cl"}, {"givenname": "Braulio", "surname": "FERN\\u00c1NDEZ", "oceanexpert_id": 35441, "email": "branferza@gmail.com"}, {"givenname": "Pedro", "surname": "Aros", "oceanexpert_id": 60586, "email": "parosmardones@gmail.com"}]	active
60882887-b7b3-47fb-847c-abf4866e2494	3e117d1c-778e-4aca-9b34-b294399a2947	feeds	[{"id": "ac3efd1d-0335-474d-9f6e-885a2e191541", "url": "http://ipt.iobis.org/esp-obis/rss.do"}]	active
ad5da8d2-8a1e-42a4-956e-094fe986faee	55650f16-ddc3-4321-a692-f71569ac5472	obis_node_id	4bf79a01-65a9-4db6-b37b-18434f26ddfc	active
6576d711-aff0-4b7d-ba66-d19d0885f071	55650f16-ddc3-4321-a692-f71569ac5472	node_type	regional	active
28b552c2-dd18-4238-9b0d-58c40b4559c3	55650f16-ddc3-4321-a692-f71569ac5472	node_url	http://www.eurobis.org	active
01ba8e51-c42f-45a7-9991-0488d919f30d	55650f16-ddc3-4321-a692-f71569ac5472	longitude	2.9294803	active
8ab2dc7f-7320-4c13-9a8b-39aa3bbf72bb	55650f16-ddc3-4321-a692-f71569ac5472	latitude	51.2332828	active
e1154d9f-7786-423a-bf60-baf4dd958b1b	55650f16-ddc3-4321-a692-f71569ac5472	theme	European OBIS node	active
505f234a-a59e-44c3-8159-fd64ef03a895	55650f16-ddc3-4321-a692-f71569ac5472	contacts	[{"givenname": "Leen", "surname": "Vandepitte", "oceanexpert_id": 12313, "email": "leen.vandepitte@vliz.be"}, {"givenname": "Joana", "surname": "Beja", "oceanexpert_id": 28269, "email": "joana.beja@vliz.be"}, {"givenname": "Ruben", "surname": "Perez Perez", "oceanexpert_id": 37533, "email": "ruben.perez@vliz.be"}]	active
745c02e5-f1db-4ef0-a2e2-16e0ca6b91f2	afbabc3f-3452-4a94-a729-0bf5de4bb667	longitude	147.3383337	active
01a76230-5ec4-440a-97ee-853de6b12738	afbabc3f-3452-4a94-a729-0bf5de4bb667	latitude	-42.886775	active
642583cd-0af9-48f0-a86f-8c3c5da2c617	afbabc3f-3452-4a94-a729-0bf5de4bb667	theme		active
cc5657d6-d3d6-4baa-9407-58b4dc9c291e	ad7a11ef-329f-4473-9805-f238e56456c3	node_type	regional	active
e24e96f0-b648-4fde-adb2-ee25d25ed4a5	ad7a11ef-329f-4473-9805-f238e56456c3	node_url	http://cpps-int.org/index.php/2015-04-28-20-21-16/nodo-obis	active
7cbf4835-9311-4705-a8ea-d764762bac05	55650f16-ddc3-4321-a692-f71569ac5472	feeds	[{"id": "2b52ff52-bd4f-4800-97b6-882bc7698a22", "url": "https://ipt.inbo.be/rss.do"}, {"id": "7bdabdca-cce9-4fe4-a6ea-f6d512439956", "url": "http://ipt.gbif.pt/ipt/rss.do"}, {"id": "7f0ebf4e-fc12-490c-bb2d-34b54a78e131", "url": "https://ipt.vliz.be/cnr-isp/rss.do"}, {"id": "a39e94d5-001a-43ca-914e-3e1cd770dd83", "url": "https://ipt.gbif.org.nz/rss.do"}, {"id": "0928f928-9ccc-49d0-bd17-a215044133c9", "url": "https://ipt.nlbif.nl/rss.do"}, {"id": "34791cdf-c885-4854-8a13-c7382ea09ee9", "url": "https://ipt.vliz.be/upload/rss.do"}, {"id": "e3dad797-a123-4e78-8473-5b0a295d3685", "url": "http://ipt.vliz.be/eurobis/rss.do"}]	active
57c322ec-7cc7-46dd-8d1a-7bf973c8b719	c2a5adb7-d4eb-45d8-bb4c-d967b2dc1b0b	obis_node_id	dcb0c76d-46a1-4e07-9a69-98cf3fd67576	active
691210c4-4691-4855-92de-ef83fa9001d0	c2a5adb7-d4eb-45d8-bb4c-d967b2dc1b0b	node_type	thematic	active
593afdd0-52bd-4fce-bbcc-115f28a8d19e	c2a5adb7-d4eb-45d8-bb4c-d967b2dc1b0b	node_url	http://www.fishnet2.net	active
4e5207b8-d0b4-4be0-b71c-fc5403d39551	c2a5adb7-d4eb-45d8-bb4c-d967b2dc1b0b	longitude	25.275605	active
cf4ca80a-ef12-43a6-b671-27b6aaead881	c2a5adb7-d4eb-45d8-bb4c-d967b2dc1b0b	latitude	35.3251232	active
3cdb1ad2-8f0a-4cde-8024-5794a62de7fe	c2a5adb7-d4eb-45d8-bb4c-d967b2dc1b0b	theme		active
b8334287-8468-4347-bb7a-34f8a69b0bbd	c2a5adb7-d4eb-45d8-bb4c-d967b2dc1b0b	contacts	[{"givenname": "Nicolas", "surname": "Bailly", "oceanexpert_id": 77, "email": "nbailly@hcmr.gr"}, {"givenname": "Henry", "surname": "Bart", "oceanexpert_id": 33848, "email": "hbartjr@tulane.edu"}, {"givenname": "Yasin", "surname": "Bakis", "oceanexpert_id": 38966, "email": "ybakis@tulane.edu"}]	active
cd536d69-7fcc-450a-8592-c4f1a110dd03	c2a5adb7-d4eb-45d8-bb4c-d967b2dc1b0b	feeds	[{"id": "734b8a14-8273-49ac-bd18-8bf8a227ae19", "url": "https://fishnet.tulane.edu/ipt/rss.do"}]	active
3b7d9ff8-6bb6-4202-b618-7b14da675901	5df18ad4-0207-4834-a1a6-1942c73dcb33	obis_node_id	33dec23c-af65-4fb1-a437-79543c562ef0	active
70bc9a59-536d-4a42-b97a-307158d0373f	5df18ad4-0207-4834-a1a6-1942c73dcb33	node_type	thematic	active
4197820a-c923-41aa-94c1-19d475b93fd6	5df18ad4-0207-4834-a1a6-1942c73dcb33	node_url	http://hab.ioc-unesco.org/	active
80afb137-5a15-42e1-a2db-04ccfa7c9cc8	5df18ad4-0207-4834-a1a6-1942c73dcb33	longitude	12.5573187	active
142c55ee-9fa7-48a9-afc8-c3a922c7681c	5df18ad4-0207-4834-a1a6-1942c73dcb33	latitude	55.703171	active
5ea284b1-ef17-4f22-8bd6-1c5de46cead5	5df18ad4-0207-4834-a1a6-1942c73dcb33	theme	Harmful Algal Blooms OBIS node	active
9537496d-7da4-4c86-8bd3-861637be7ffe	5df18ad4-0207-4834-a1a6-1942c73dcb33	contacts	[{"givenname": "Henrik", "surname": "Oksfeldt Enevoldsen", "oceanexpert_id": 594, "email": "h.enevoldsen@unesco.org"}]	active
93397d48-42d8-470b-b7cb-611958400e54	5df18ad4-0207-4834-a1a6-1942c73dcb33	feeds	[{"id": "8a8a6d22-37f1-473e-9fae-6c794ba7a93d", "url": "http://ipt.iobis.org/hab/rss.do"}]	active
56bd0624-ec1d-4194-9a20-5d5849f4c3e5	e45382da-08cb-4943-a10a-66c1707c10a5	obis_node_id	1a3b0f1a-4474-4d73-9ee1-d28f92a83996	active
7b5451b6-ca5b-43d5-b42a-d291be061fcd	e45382da-08cb-4943-a10a-66c1707c10a5	node_type	regional	active
5f543b22-e10e-4999-9fe3-c6793d8768ed	e45382da-08cb-4943-a10a-66c1707c10a5	node_url	https://indobis.in/	active
754b2cca-2ca1-4642-8a88-de943c51c904	e45382da-08cb-4943-a10a-66c1707c10a5	longitude	76.340945	active
b42ddf05-de3a-44ac-98b8-d46352fe3038	e45382da-08cb-4943-a10a-66c1707c10a5	latitude	10.004824	active
9ee88692-dd28-4e06-908f-b4e540466b5f	e45382da-08cb-4943-a10a-66c1707c10a5	theme	Indian OBIS node	active
c35aa678-6cfe-47b0-88e3-b0c13cbd578d	e45382da-08cb-4943-a10a-66c1707c10a5	contacts	[{"givenname": "Johnny", "surname": "Konjarla", "oceanexpert_id": 33322, "email": "johnny.konjarla@gmail.com"}, {"givenname": "Hashim", "surname": "Manjebrayakath", "oceanexpert_id": 80354, "email": "hashim@cmlre.gov.in"}]	active
65baf649-785c-4858-9bc5-1ec592968d94	e45382da-08cb-4943-a10a-66c1707c10a5	feeds	[{"id": "ac353c47-b78d-444f-84bc-0752bd384fef", "url": "http://ipt.iobis.org/indobis/rss.do"}]	active
774c56fe-1f7b-476f-b3f1-f0ff0187d3c0	d771a5b4-dcf5-4a11-b566-1f07cfc00e43	obis_node_id	1ad35eb9-c615-4733-864a-b585aebcfb70	active
5ea92427-3c3a-47c3-be39-b780337a838e	d771a5b4-dcf5-4a11-b566-1f07cfc00e43	node_type	regional	active
fd6be3bc-6d3b-4803-9ce0-2a9cea35eeae	d771a5b4-dcf5-4a11-b566-1f07cfc00e43	node_url	https://www.lifewatchgreece.eu/?q=content/medobis	active
c59df004-58c9-4348-9b7a-bd5861619c0b	d771a5b4-dcf5-4a11-b566-1f07cfc00e43	longitude	25.275605	active
954f807a-e4bc-4a04-a74e-c48cfa42a764	d771a5b4-dcf5-4a11-b566-1f07cfc00e43	latitude	35.3251232	active
987972d9-4e3f-4d4f-a49b-b933ac1d6d20	d771a5b4-dcf5-4a11-b566-1f07cfc00e43	theme	Mediterranean OBIS node	active
d9e99a90-496e-425d-9190-55dc481a9132	d771a5b4-dcf5-4a11-b566-1f07cfc00e43	contacts	[{"givenname": "Christos", "surname": "Arvanitidis", "oceanexpert_id": 24333, "email": "arvanitidis@hcmr.gr"}, {"givenname": "Dimitra", "surname": "Mavraki", "oceanexpert_id": 24395, "email": "dmavraki@hcmr.gr"}, {"givenname": "Melina", "surname": "Loulakaki", "oceanexpert_id": 66809, "email": "m.loulakaki@hcmr.gr"}]	active
cbdf97b0-0f6f-49a1-b609-f12616a42094	d771a5b4-dcf5-4a11-b566-1f07cfc00e43	feeds	[{"id": "32a04315-0346-467e-9fba-0a8336818ba1", "url": "http://ipt.medobis.eu/rss.do"}]	active
f125abfa-f55d-47c0-903e-206653aec1a6	2e58e60a-3874-43d6-94c5-c2cce73fe7ad	obis_node_id	464a96d8-c17e-4bbb-b6b8-778e1fb687c4	active
50f6c2bc-6c66-4cca-8edf-092739ba87a7	2e58e60a-3874-43d6-94c5-c2cce73fe7ad	node_type	regional	active
6c264080-407d-424e-8cac-43bba8ae58be	2e58e60a-3874-43d6-94c5-c2cce73fe7ad	node_url	http://arobis.cenpat-conicet.gob.ar/	active
7ad087b6-f893-4d23-bfb9-d9b0f277c0c6	2e58e60a-3874-43d6-94c5-c2cce73fe7ad	longitude	-65.0089691	active
35f0fc40-332f-4f10-b503-74cde88054c6	2e58e60a-3874-43d6-94c5-c2cce73fe7ad	latitude	-42.7847673	active
6ab0662a-28f1-4a02-9427-63ead3df266b	2e58e60a-3874-43d6-94c5-c2cce73fe7ad	theme		active
9eb8f864-2683-4749-8a55-7de9daee35e3	2e58e60a-3874-43d6-94c5-c2cce73fe7ad	contacts	[{"givenname": "Marcos ", "surname": "Zarate", "oceanexpert_id": 27516, "email": "zarate@cenpat-conicet.gob.ar"}]	active
dc212461-bdf1-4dfe-9b4e-19f72ae16777	2e58e60a-3874-43d6-94c5-c2cce73fe7ad	feeds	[{"id": "5894b37d-d245-4707-89f9-80af50230056", "url": "http://arobis.cenpat-conicet.gob.ar:8081/rss.do"}]	active
8db5ca63-70f5-49b2-99e3-678e5c0844f2	afbabc3f-3452-4a94-a729-0bf5de4bb667	obis_node_id	2a57cd59-6799-4579-955e-27c9af97aea4	active
e4d3ec17-04a6-42f8-a927-ca58452cc5fe	afbabc3f-3452-4a94-a729-0bf5de4bb667	node_type	regional	active
2f8925bf-f29e-4d2c-9562-15b96620e6e8	afbabc3f-3452-4a94-a729-0bf5de4bb667	node_url	http://www.obis.org.au	active
e19a8f1e-9d67-4648-8b99-be35c847cc72	afbabc3f-3452-4a94-a729-0bf5de4bb667	contacts	[{"givenname": "Katherine", "surname": "Tattersall", "oceanexpert_id": 35925, "email": "OBISAU@csiro.au"}, {"givenname": "Andres", "surname": "Roubicek", "oceanexpert_id": 25497, "email": "OBISAU@csiro.au"}, {"givenname": "Sachit", "surname": "Rajbhandari", "oceanexpert_id": 49717, "email": "OBISAU@csiro.au"}]	active
0e834b79-bf87-4d33-8f65-53f957b5454f	afbabc3f-3452-4a94-a729-0bf5de4bb667	feeds	[{"id": "42683bd2-2415-405b-8ddf-f7e9ca0d339e", "url": "https://www.marine.csiro.au/ipt/rss.do"}, {"id": "458f3f74-0e76-4a0e-a13b-0cb2ec8e54ab", "url": "https://data.aad.gov.au/ipt/rss.do"}]	active
491bcb46-a4f9-4aa6-84c1-86591174a9e3	e7b5ae11-6c1f-42b6-b054-68b878b7f357	obis_node_id	bdb3b59b-7dad-4c06-a2d6-3e576158cc4c	active
67c5ad8b-258d-4ac4-b4ce-3662a2a894ba	e7b5ae11-6c1f-42b6-b054-68b878b7f357	node_type	regional	active
19ca012f-f287-4f3f-9e56-4caa22426962	e7b5ae11-6c1f-42b6-b054-68b878b7f357	node_url	http://www.sea.gov.ua	active
b03761c8-b679-41b7-8369-bc913b3ed10d	e7b5ae11-6c1f-42b6-b054-68b878b7f357	longitude	30.7490426	active
2692edb5-6bb7-4d0c-a3ca-0624ccf2eadb	e7b5ae11-6c1f-42b6-b054-68b878b7f357	latitude	46.4609105	active
0fa4aa81-f521-423d-85b9-4e2678031b35	e7b5ae11-6c1f-42b6-b054-68b878b7f357	theme		active
f21351d0-2078-4dee-95b8-318dd2034f69	e7b5ae11-6c1f-42b6-b054-68b878b7f357	contacts	[{"givenname": "Oleksandr", "surname": "Neprokin", "oceanexpert_id": 19193, "email": "o.neprokin@gmail.com"}, {"givenname": "Oleksandr", "surname": "LEPOSHKIN", "oceanexpert_id": 29532, "email": "cephei7@gmail.com"}]	active
08e589a5-1504-4fcb-a876-4d1489b04fef	e7b5ae11-6c1f-42b6-b054-68b878b7f357	feeds	[{"id": "e104a503-dcb6-4d74-a7bd-5e5d57ed0b3e", "url": "http://gp.sea.gov.ua:8082/ipt/rss.do"}]	active
20755528-78ef-40f3-a16f-ac607432dc0b	3b7600e8-0c2f-4bda-9c19-02bc6b215254	obis_node_id	dde0dbd3-92fb-41e6-9f51-b1ae930a934b	active
5b0b89a3-98db-494a-95f2-4c196033f9f9	3b7600e8-0c2f-4bda-9c19-02bc6b215254	node_type	regional	active
7acd17b1-eb2f-4b21-ad91-39284bee49c1	3b7600e8-0c2f-4bda-9c19-02bc6b215254	node_url	https://www.sibbr.gov.br/	active
89cdb1cf-cf37-4f10-8269-610297ba9c09	3b7600e8-0c2f-4bda-9c19-02bc6b215254	longitude	-40.3036262	active
19bfdd7d-20f1-42d8-ba75-7c93d1a65082	3b7600e8-0c2f-4bda-9c19-02bc6b215254	latitude	-20.2763057	active
bebdbdf9-019e-4a47-9d06-f65fe7d8d359	3b7600e8-0c2f-4bda-9c19-02bc6b215254	theme	Brazil	active
7ad37d71-2096-4bf4-bcbf-a2d07aa0f152	3b7600e8-0c2f-4bda-9c19-02bc6b215254	contacts	[{"givenname": "Clara", "surname": "Fonseca", "oceanexpert_id": 74311, "email": "clara.fonseca@consultores.rnp.br"}, {"givenname": "Keila", "surname": "Juarez", "oceanexpert_id": null, "email": "keila.juarez@consultores.rnp.br"}]	active
8a6e79a2-4b05-4d33-bab3-32902961b5d5	3b7600e8-0c2f-4bda-9c19-02bc6b215254	feeds	[{"id": "3ec82b87-1893-4818-8f65-6448898ff75e", "url": "https://ipt.sibbr.gov.br/peld/rss.do"}, {"id": "61065b67-a4a4-4f2e-ada5-5471ce076157", "url": "https://ipt.sibbr.gov.br/mnrj/rss.do"}, {"id": "4b4c5b3c-2e16-4042-8626-122a3449ef21", "url": "http://ipt.iobis.org/wsaobis/rss.do"}]	active
a28c982b-a86a-48b4-9454-6ac64e2956d0	b06998dc-2511-4456-a560-7a34acd5b9ad	obis_node_id	7dfb2d90-9317-434d-8d4e-64adf324579a	active
45d364eb-944b-4230-9e5c-a07653053615	b06998dc-2511-4456-a560-7a34acd5b9ad	node_type	regional	active
5a0eb5a4-90cc-40e7-aaf1-2589f86c3764	b06998dc-2511-4456-a560-7a34acd5b9ad	node_url	https://www.dfo-mpo.gc.ca/science/data-donnees/obis/index-eng.html	active
6253b2af-8cf5-42b6-a416-cf9c9765460e	b06998dc-2511-4456-a560-7a34acd5b9ad	longitude	-63.6117797	active
d88aee0a-101f-4c73-adee-c6e642d2f136	b06998dc-2511-4456-a560-7a34acd5b9ad	latitude	44.6830254	active
c9b119ea-d229-40cb-bfad-26475f7b0edb	b06998dc-2511-4456-a560-7a34acd5b9ad	theme		active
5d2b622b-6e87-4b9e-ad2b-cdbc9179fa5f	b06998dc-2511-4456-a560-7a34acd5b9ad	contacts	[{"givenname": "Maria", "surname": "Cornthwaite", "oceanexpert_id": 44111, "email": "OBISCanada@dfo-mpo.gc.ca"}]	active
98576b7f-45e0-4511-9981-ea2e80d931fe	b06998dc-2511-4456-a560-7a34acd5b9ad	feeds	[{"id": "c40a1f97-1b7e-42d5-84a7-05e871d44a18", "url": "http://ipt.nature.ca/rss.do"}, {"id": "6ae5ad4f-2a01-43bd-9fb4-cc9c7f38f105", "url": "http://ipt.vliz.be/obiscanada/rss.do"}]	active
575995fb-de6c-4fbc-b6c8-14ca5456bae0	ad23811c-45d9-46cb-9322-c0f2e04c5f7f	obis_node_id	372be6e4-842d-414c-a485-ccfb20948450	active
0d5d96fe-311c-48b2-8575-f7002100abee	ad23811c-45d9-46cb-9322-c0f2e04c5f7f	node_type	regional	active
0e4842d2-ac31-4443-bc65-68766d8affdf	ad23811c-45d9-46cb-9322-c0f2e04c5f7f	node_url	http://www.iobis.org.cn	active
8d41ccb0-19c2-4a58-8684-5c3845b3af58	ad23811c-45d9-46cb-9322-c0f2e04c5f7f	longitude	120.3450896	active
e01859f2-ff23-4894-94b1-411ebbaa15f8	ad23811c-45d9-46cb-9322-c0f2e04c5f7f	latitude	36.0553875	active
69fd4ec1-2380-4356-bee7-461fcdc083e2	ad23811c-45d9-46cb-9322-c0f2e04c5f7f	theme		active
2551907d-d2fa-4df6-9cc3-3f4651058b38	ad23811c-45d9-46cb-9322-c0f2e04c5f7f	contacts	[{"givenname": "Kuidong", "surname": "Xu", "oceanexpert_id": 30609, "email": "kxu@qdio.ac.cn"}, {"givenname": "Zhaocui", "surname": "Meng", "oceanexpert_id": 56903, "email": "mengzhaocui@qdio.ac.cn"}]	active
4b78d0a2-d83c-43a2-9694-b61d2400ce22	ad23811c-45d9-46cb-9322-c0f2e04c5f7f	feeds	[{"id": "4f68445b-53b8-446e-92c4-3b5e6a1a0033", "url": "http://ipt.iobis.org/obis-china/rss.do"}]	active
700accbc-63e9-4092-9cc7-822a5f541366	c5c65e91-5a2b-4dc8-9cdc-cac9a3189282	obis_node_id	d2f71b1b-9138-4aba-ad8f-8327ac3d041e	active
b4ef3b76-9b74-46b7-9c60-1e5c5874f58c	c5c65e91-5a2b-4dc8-9cdc-cac9a3189282	node_type	regional	active
ce708314-60cc-4a1a-87d3-1602275fd0cd	c5c65e91-5a2b-4dc8-9cdc-cac9a3189282	node_url	http://siam.invemar.org.co/	active
22bdd57c-a4c3-40cd-817a-5901a85368ad	c5c65e91-5a2b-4dc8-9cdc-cac9a3189282	longitude	-74.230772	active
0422ef1e-c30d-4102-94b1-896dac2af561	c5c65e91-5a2b-4dc8-9cdc-cac9a3189282	latitude	11.18813	active
da8b12e9-2c0c-43af-a672-9aef3c2e1296	c5c65e91-5a2b-4dc8-9cdc-cac9a3189282	theme		active
24bd1f6f-4be5-4fec-9a9b-9ba6cba803ce	c5c65e91-5a2b-4dc8-9cdc-cac9a3189282	contacts	[{"givenname": "Martha", "surname": "Vides", "oceanexpert_id": 22542, "email": "martha.vides@invemar.org.co"}, {"givenname": "Erika ", "surname": "Montoya-Cadavid", "oceanexpert_id": 32510, "email": "erika.montoya@invemar.org.co"}]	active
c659edf4-0f56-4d91-8a48-1644f856d030	c5c65e91-5a2b-4dc8-9cdc-cac9a3189282	feeds	[{"id": "71bec177-ad8b-4c93-b643-7b2b8d3b46cf", "url": "https://ipt.biodiversidad.co/sibm/rss.do"}]	active
252422ff-d70a-43a0-b283-bf59a8e23e2f	ad7a11ef-329f-4473-9805-f238e56456c3	obis_node_id	ab4338af-28d1-402b-a01a-4caa41f90fc3	active
f821b699-d5f0-45b8-900f-94354ebe6f82	ad7a11ef-329f-4473-9805-f238e56456c3	longitude	-79.9199994	active
c14d3851-93c8-4324-9994-2cae55bc1b4b	ad7a11ef-329f-4473-9805-f238e56456c3	latitude	-2.1696643	active
e0247eb8-58e3-41be-a364-0e53123e6a2b	ad7a11ef-329f-4473-9805-f238e56456c3	theme	CPPS - South Pacific OBIS node	active
be3b9c03-ba3f-43cd-b6a1-490d4564dfa8	ad7a11ef-329f-4473-9805-f238e56456c3	contacts	[{"givenname": "M\\u00f3nica", "surname": "Machuca", "oceanexpert_id": 26239, "email": "mmachuca@cpps-int.org"}, {"givenname": "Zuleika", "surname": "Pinz\\u00f3n", "oceanexpert_id": 27016, "email": "zpinzon@cpps-int.org"}]	active
5d6325c9-89d8-47ed-b0f5-8e2b42324ee1	ad7a11ef-329f-4473-9805-f238e56456c3	feeds	[{"id": "bf0b677a-4f59-4b5d-9434-47ee8885f3b8", "url": "http://cpps.dyndns.info:8080/cpps-ipt/rss.do"}]	active
7e221ccb-46bf-4f3a-ad0b-5dd34e022050	e4d56021-ff07-409c-a434-2aabe55e55ee	obis_node_id	6f3223e3-50a6-4ba5-b02c-0037ae3863ce	active
45fc5ac9-445b-4c28-9928-630df34690a2	e4d56021-ff07-409c-a434-2aabe55e55ee	node_type	thematic	active
1b4094f4-8f8f-476a-8fea-10b1e076494d	e4d56021-ff07-409c-a434-2aabe55e55ee	node_url	https://obis.org/node/6f3223e3-50a6-4ba5-b02c-0037ae3863ce	active
aa3ac6eb-7bec-4dd0-a5e5-d3f60c2f38c0	e4d56021-ff07-409c-a434-2aabe55e55ee	longitude	12.5573187	active
ce73c0bb-04ac-409c-9e97-4b0d4bb4e2d9	e4d56021-ff07-409c-a434-2aabe55e55ee	latitude	55.703171	active
b9b4f7e7-3366-4aad-9b56-d260857e332b	e4d56021-ff07-409c-a434-2aabe55e55ee	theme		active
140d7572-ab7d-46f3-aa81-9e490fec0246	e4d56021-ff07-409c-a434-2aabe55e55ee	contacts	[{"givenname": "Hanieh", "surname": "Saeedi ", "oceanexpert_id": 31273, "email": "hanieh.saeedi@senckenberg.de"}]	active
a81b246a-a156-4c83-a240-76c0f22fa864	e4d56021-ff07-409c-a434-2aabe55e55ee	feeds	[{"id": "286288a8-ecdf-4d62-9159-85f22a72f4ec", "url": "http://ipt.iobis.org/obis-deepsea/rss.do"}]	active
b1005e0b-9a5a-4350-8a1c-8bb32a246c92	a05350f5-edc6-4bda-b485-1ff5d6698e72	obis_node_id	e339c31d-88f2-45ea-924d-2f8cef0d9fa9	active
66c45507-5062-4254-8077-1922c3ba922f	a05350f5-edc6-4bda-b485-1ff5d6698e72	node_type	regional	active
15390c29-f358-4e42-92c1-1b4218b14c81	a05350f5-edc6-4bda-b485-1ff5d6698e72	node_url	https://patrimonio.ambiente.gob.ec/iptmae/	active
2d8d1e07-f03f-42ef-bed6-2d4ea39ca23d	a05350f5-edc6-4bda-b485-1ff5d6698e72	longitude	-78.487916	active
82d4a231-feda-4894-8b05-74844ffed66a	a05350f5-edc6-4bda-b485-1ff5d6698e72	latitude	-0.205693	active
884855a2-2f31-4fc3-bb43-ece8a160d5df	a05350f5-edc6-4bda-b485-1ff5d6698e72	theme	Ecuador	active
13f2bfa4-eea4-4fc6-a41a-dfecf8f75572	a05350f5-edc6-4bda-b485-1ff5d6698e72	contacts	[{"givenname": "Victor", "surname": "Chocho", "oceanexpert_id": 59824, "email": "victor.chocho@ambiente.gob.ec"}]	active
0cbeac3b-7b8c-4385-a60d-9a8212addefb	a05350f5-edc6-4bda-b485-1ff5d6698e72	feeds	[{"id": "05ddcf00-a64f-4f9a-b17d-c981f872c50e", "url": "http://patrimonio.ambiente.gob.ec/iptmae/rss.do"}]	active
fab86f9c-d9c3-487f-81fc-d4df5177fdab	1b6795b6-16dd-48e6-9f07-eea472ec3a69	obis_node_id	fee25714-b532-42fb-8b75-d28e25c7b890	active
64d9637b-25d2-4e44-a3a8-5df3099fa6e5	1b6795b6-16dd-48e6-9f07-eea472ec3a69	node_type	regional	active
093d5953-534a-4d16-920a-a57f1de36edd	1b6795b6-16dd-48e6-9f07-eea472ec3a69	node_url	https://www.gbif.no/	active
3fd6e691-6193-4fb2-a919-9843debf0232	1b6795b6-16dd-48e6-9f07-eea472ec3a69	longitude	10.7698085	active
44ac63a7-c49b-482f-b0f2-3895702ddcfe	1b6795b6-16dd-48e6-9f07-eea472ec3a69	latitude	59.9200358	active
c5375972-4f5a-43b3-86cc-19edeb8b4766	1b6795b6-16dd-48e6-9f07-eea472ec3a69	theme	Norway	active
0b283e86-c4bb-40fc-b8e6-620e7d08d6f1	1b6795b6-16dd-48e6-9f07-eea472ec3a69	contacts	[{"givenname": "Arnfinn", "surname": "Morvik", "oceanexpert_id": 43262, "email": "arnfinn.morvik@hi.no"}, {"givenname": "Andreas", "surname": "Altenburger", "oceanexpert_id": 74471, "email": "andreas.altenburger@uit.no"}, {"givenname": "Sara", "surname": "Zamora Terol", "oceanexpert_id": 55550, "email": "sara.zamora.terol@hi.no"}, {"givenname": "Roc\\u00edo", "surname": "Casta\\u00f1o Primo", "oceanexpert_id": 40089, "email": "rocio.castano.primo@hi.no"}, {"givenname": "Vanessa", "surname": "Pitusi", "oceanexpert_id": 74608, "email": "vanessa.pitusi@uit.no"}, {"givenname": "Dag", "surname": "Endresen", "oceanexpert_id": 64359, "email": "dag.endresen@nhm.uio.no"}, {"givenname": "Katrine", "surname": "Kongshavn", "oceanexpert_id": 74534, "email": "Katrine.Kongshavn@uib.no"}]	active
92c35f9c-8717-4d89-920d-856341e9fcce	1b6795b6-16dd-48e6-9f07-eea472ec3a69	feeds	[{"id": "46b123f8-7e56-4e3d-96a1-0dd540484dd3", "url": "https://ipt.gbif.no/rss.do"}, {"id": "145099e1-e8f0-4bfe-a413-d6f65c9b93e2", "url": "https://gbif.imr.no/ipt/rss.do"}]	active
ee281c4d-0b0e-42e5-bea5-64214ec4b5ca	90dc8b01-a056-4c45-b582-1d2f85486fae	obis_node_id	f58e93e1-bfb6-46e2-9000-46c6eb0505ba	active
c11ced2d-b5e6-413a-a170-9b4cc3d0e649	90dc8b01-a056-4c45-b582-1d2f85486fae	node_type	regional	active
d22b19d1-96f5-4855-9630-a94859b6e76b	90dc8b01-a056-4c45-b582-1d2f85486fae	node_url	http://www.oseanografi.lipi.go.id/	active
d6761572-4ffc-4cd2-8e5c-7c477e5763ba	90dc8b01-a056-4c45-b582-1d2f85486fae	longitude	106.845344	active
8e734621-e26e-4e61-91ca-09c9e4581194	90dc8b01-a056-4c45-b582-1d2f85486fae	latitude	-6.124647	active
7bdff08a-d2f4-4b49-8876-2e84b701709d	90dc8b01-a056-4c45-b582-1d2f85486fae	theme	\N	active
4a3f3220-5674-432b-b2dc-f963181afb4d	90dc8b01-a056-4c45-b582-1d2f85486fae	contacts	[{"givenname": "Udhi", "surname": "Hernawan", "oceanexpert_id": 35377, "email": "udhi001@brin.go.id"}, {"givenname": "Priyadi", "surname": "Santoso", "oceanexpert_id": 35481, "email": "priy001@brin.go.id"}]	active
1a02691e-972e-4453-bfe0-1f8b235d8746	90dc8b01-a056-4c45-b582-1d2f85486fae	feeds	[{"id": "064b8864-ff4e-4d07-8e7e-6515f8781794", "url": "http://obis.lipi.go.id:8080/ipt/rss.do"}]	active
691e2e75-8a1f-4d96-bd77-fc858ca67f17	6696572f-aaac-4cd9-8005-77b2014c89ae	obis_node_id	9d2d95be-32eb-4d81-8911-32cb8bc641c8	active
c13ac312-4d27-4b73-a8b2-b15e672dfaf7	6696572f-aaac-4cd9-8005-77b2014c89ae	node_type	thematic	active
a5337d52-5136-4f24-8f8a-dc025387f342	6696572f-aaac-4cd9-8005-77b2014c89ae	node_url	https://www.isa.org.jm/	active
d6c95127-f8ff-45fa-bc4c-336f66cc91a6	6696572f-aaac-4cd9-8005-77b2014c89ae	longitude	-76.7939294	active
c287ed2d-00ea-473b-8532-d698cde06c5a	6696572f-aaac-4cd9-8005-77b2014c89ae	latitude	17.9643026	active
98d3c934-c88c-4e05-b13e-6c258e01b120	6696572f-aaac-4cd9-8005-77b2014c89ae	theme	\N	active
02ba8c29-ab71-44e2-a3ce-aab262151568	cc21fcd3-f085-4ded-b8aa-21f89b5ada4c	node_url	http://seamap.env.duke.edu	active
d9e01208-1bbd-44d6-bdbc-1947daf02311	cc21fcd3-f085-4ded-b8aa-21f89b5ada4c	longitude	-78.9441046	active
96378398-b262-495a-9b8b-2382e26444ba	6696572f-aaac-4cd9-8005-77b2014c89ae	contacts	[{"givenname": "Sheldon", "surname": "Carter", "oceanexpert_id": 31419, "email": "scarter@isa.org.jm"}, {"givenname": "Luciana", "surname": "Genio", "oceanexpert_id": 42446, "email": "lgenio@isa.org.jm"}]	active
6529bead-3121-45e1-9625-1a17533c072d	6696572f-aaac-4cd9-8005-77b2014c89ae	feeds	[{"id": "e6a25bcb-ee4a-4df4-a541-aa77362400b2", "url": "https://datasets.obis.org/hosted/isa/rss.xml"}]	active
f8ce57e0-7bb1-4afc-9b0a-54484b23971d	2987cc44-b92d-4309-913c-54cba1ac777b	obis_node_id	0d07a0ea-9c75-48e8-b3fd-c28d653f4270	active
31aff6e4-8b52-48a6-b21d-882067131feb	2987cc44-b92d-4309-913c-54cba1ac777b	node_type	regional	active
cca93628-5b8b-4cd8-b89c-06b270b9f592	2987cc44-b92d-4309-913c-54cba1ac777b	node_url	http://www.godac.jamstec.go.jp/bismal/e/index.html	active
0c2f7489-ba3d-4961-beea-89e15e564d25	2987cc44-b92d-4309-913c-54cba1ac777b	longitude	128.017735	active
fa0872a3-3e78-4861-b328-12eeac9bb641	2987cc44-b92d-4309-913c-54cba1ac777b	latitude	26.5219735	active
5894110b-b109-4ca1-af77-75afa34ea06a	2987cc44-b92d-4309-913c-54cba1ac777b	theme		active
c1817670-de74-4e4f-87d1-4dc317d67c73	2987cc44-b92d-4309-913c-54cba1ac777b	contacts	[{"givenname": "Takashi", "surname": "Hosono", "oceanexpert_id": 26688, "email": "hosonot@jamstec.go.jp"}, {"givenname": "Katsunori", "surname": "Fujikura", "oceanexpert_id": 17967, "email": "fujikura@jamstec.go.jp"}]	active
e6a267ce-714e-4920-9910-9e6d16514aa0	2987cc44-b92d-4309-913c-54cba1ac777b	feeds	[{"id": "fb6b90fc-2866-4277-b387-3822927fe92f", "url": "https://www.godac.jamstec.go.jp/ipt/rss.do"}]	active
b86e8205-0382-45d9-b926-48814a253af0	903f707f-3fd9-4309-bc2a-9a45f4f8930d	obis_node_id	aa56c74b-90ba-461d-b117-2b384571993b	active
bf53963a-e5f8-463a-81b8-d81a0f402e50	903f707f-3fd9-4309-bc2a-9a45f4f8930d	node_type	regional	active
9c40b2eb-e070-4d81-a1d0-dd4b9246e8cc	903f707f-3fd9-4309-bc2a-9a45f4f8930d	node_url	https://obis.org/node/aa56c74b-90ba-461d-b117-2b384571993b	active
08a051cc-dcd1-42c0-89e5-01bad9a9dc11	903f707f-3fd9-4309-bc2a-9a45f4f8930d	longitude	39.6819216	active
aeed56d3-47bf-49c3-95a3-233342db2933	903f707f-3fd9-4309-bc2a-9a45f4f8930d	latitude	-4.055256	active
bb102158-c4bd-49a7-ad0d-fbd5c7d44a83	903f707f-3fd9-4309-bc2a-9a45f4f8930d	theme		active
ad6a3631-03a7-412a-8960-b8b3400b4e75	903f707f-3fd9-4309-bc2a-9a45f4f8930d	contacts	[{"givenname": "Fatuma", "surname": "Mzingirwa", "oceanexpert_id": 38253, "email": "fmzingirwa@gmail.com"}, {"givenname": "Harrison", "surname": "Onganda", "oceanexpert_id": 5715, "email": "honganda@kmfri.go.ke"}]	active
5a373f4b-4d87-40ab-83b8-3dca35bd9f00	903f707f-3fd9-4309-bc2a-9a45f4f8930d	feeds	[{"id": "159b0108-3980-4c2d-a517-a7e840ee05be", "url": "http://ipt.vliz.be/kmfri/rss.do"}]	active
8b959f11-f51a-4438-adea-663c4b919b03	42710998-0d40-4076-aadb-7c8b2373a937	obis_node_id	fc5278f9-ea56-4a01-a48a-f8c4071e3b3e	active
b4319658-4b5e-4b52-a0ac-c4d19a4842b5	42710998-0d40-4076-aadb-7c8b2373a937	node_type	regional	active
d4107bc2-71e0-49e9-894a-48e6268fb198	42710998-0d40-4076-aadb-7c8b2373a937	node_url	https://www.mabik.re.kr/eng/index.do	active
affd7dbe-b876-4e4e-b987-547ad4b42456	42710998-0d40-4076-aadb-7c8b2373a937	longitude	126.6674868	active
2e3b8f32-d0d4-4ca1-b96e-74a226301a78	42710998-0d40-4076-aadb-7c8b2373a937	latitude	36.0171518	active
7359c11d-63bb-483a-bd38-de5645aabbf8	42710998-0d40-4076-aadb-7c8b2373a937	theme	Korea node	active
ef59003b-c2dd-4a7d-9ec5-573c757af821	42710998-0d40-4076-aadb-7c8b2373a937	contacts	[{"givenname": "Yong-Rock", "surname": "An", "oceanexpert_id": 61821, "email": "rock@mabik.re.kr"}, {"givenname": "Sang Ho", "surname": "Baek", "oceanexpert_id": 61528, "email": "shbaek@mabik.re.kr"}, {"givenname": "Oh Nam", "surname": "Kwon", "oceanexpert_id": 66935, "email": "onkwon@mabik.re.kr"}]	active
07b52f09-cbb2-4497-9608-2673479aefc6	42710998-0d40-4076-aadb-7c8b2373a937	feeds	[{"id": "126e8fa2-4d9b-41a0-89d4-b9296070cfe6", "url": "https://www.mbris.kr/ipt/rss.do"}]	active
08da73ac-c858-41d9-ac41-05fbededbe91	0489b1f3-df5e-46ef-83e4-4337b9efa016	obis_node_id	52486ef2-e094-4e8b-af77-6d434cf30ef2	active
aef10163-e990-41c9-b1f5-3ccfd3459d30	0489b1f3-df5e-46ef-83e4-4337b9efa016	node_type	regional	active
237954cb-7cf3-46b8-8463-6ab1bf4a63b0	0489b1f3-df5e-46ef-83e4-4337b9efa016	node_url	http://inos.umt.edu.my/?lang=en	active
93ab8c43-db48-4228-bec6-d55edaf0a22d	0489b1f3-df5e-46ef-83e4-4337b9efa016	longitude	103.0880208	active
88cc8cb6-30b8-443b-8180-a52326761fe8	0489b1f3-df5e-46ef-83e4-4337b9efa016	latitude	5.4075278	active
00b3032d-89fd-4979-a506-097b24908d90	0489b1f3-df5e-46ef-83e4-4337b9efa016	theme		active
d2775d80-bcc3-44ed-b750-5406c1e09926	0489b1f3-df5e-46ef-83e4-4337b9efa016	contacts	[{"givenname": "Aidy@Mohd Shawal", "surname": "Muslim", "oceanexpert_id": 20053, "email": "aidy@umt.edu.my"}, {"givenname": "Ahmad ", "surname": "Fakhrurrazi bin MOKHTAR", "oceanexpert_id": 59069, "email": "fakhrurrazi@umt.edu.my"}, {"givenname": "Muhammad Hafiz ", "surname": "Borkhanuddin", "oceanexpert_id": 82990, "email": "hborhan@umt.edu.my"}]	active
c0e94b38-2f36-4839-b6c1-cc0cddb234ff	0489b1f3-df5e-46ef-83e4-4337b9efa016	feeds	[{"id": "51a1b819-aede-4a36-b3c4-ed0eb1c1234c", "url": "http://ipt.iobis.org/obis-malaysia/rss.do"}]	active
13fcff63-b924-465a-80e2-a421ec89eca6	1c9bdc15-f881-4f56-b6e6-83a8871ba956	obis_node_id	f224ae79-1a05-4744-b0e6-934386bd71ed	active
744a5836-7b28-43a3-8bfb-52dcdc7a93fa	1c9bdc15-f881-4f56-b6e6-83a8871ba956	node_type	regional	active
54543d58-4741-4766-a6b2-e337c7de0a46	1c9bdc15-f881-4f56-b6e6-83a8871ba956	node_url	https://viceipup.up.ac.pa/CENDIOPAN/	active
a80e943f-b97c-4228-9cff-e5fd90c0e9ba	1c9bdc15-f881-4f56-b6e6-83a8871ba956	longitude	-79.5359716	active
17d02a7e-696b-4ebb-afcb-ff87f2cb352d	1c9bdc15-f881-4f56-b6e6-83a8871ba956	latitude	8.983968	active
c9663d02-1bf9-4eb5-86c5-31a5a60578f7	1c9bdc15-f881-4f56-b6e6-83a8871ba956	theme		active
1d0f4b52-a527-4945-92cf-9de0be1400f4	1c9bdc15-f881-4f56-b6e6-83a8871ba956	contacts	[{"givenname": "Perez-Rivera", "surname": "Edgar", "oceanexpert_id": 77582, "email": "edgar.perezr@up.ac.pa"}, {"givenname": "Hermelinda", "surname": "Peralta Ara\\u00faz", "oceanexpert_id": 62254, "email": "hermelinda.peralta@up.ac.pa"}]	active
e092c8dd-3e61-48d2-bc62-80abbf6c3f12	1c9bdc15-f881-4f56-b6e6-83a8871ba956	feeds	[{"id": "d627f01b-27ee-438a-ada9-5ecdaf91c590", "url": "https://ipt.obis.org/panama/rss.do"}]	active
75fd03d7-50a2-4664-8ef7-21b24e276ee9	cc21fcd3-f085-4ded-b8aa-21f89b5ada4c	obis_node_id	573654c1-4ce7-4ea2-b2f1-e4d42f8f9c31	active
c50a9ad7-6048-4430-9ade-a708f2bf6b2a	cc21fcd3-f085-4ded-b8aa-21f89b5ada4c	node_type	thematic	active
bc97b131-ec71-473a-a1f6-26866625f144	cc21fcd3-f085-4ded-b8aa-21f89b5ada4c	latitude	36.0045066	active
0aa24b63-ba62-46d0-abe3-ecf4fffd6210	cc21fcd3-f085-4ded-b8aa-21f89b5ada4c	theme	Marine Megavertebrates OBIS node	active
42d37389-d69b-45e4-bf8d-2257f1628f2f	cc21fcd3-f085-4ded-b8aa-21f89b5ada4c	contacts	[{"givenname": "Ei", "surname": "Fujioka", "oceanexpert_id": 20793, "email": "efujioka@duke.edu"}, {"givenname": "Patrick", "surname": "Halpin", "oceanexpert_id": 17972, "email": "phalpin@duke.edu"}, {"givenname": "Benjamin", "surname": "Donnelly", "oceanexpert_id": 22156, "email": "bendy@duke.edu"}]	active
b7af6b62-0f9b-4a62-b82b-74cf49bfcf6c	cc21fcd3-f085-4ded-b8aa-21f89b5ada4c	feeds	[{"id": "18954703-9b9d-4584-b46d-87846532c5ee", "url": "https://ipt.env.duke.edu/rss.do"}]	active
039762d0-56f7-4c6a-a29f-84b5f4e98d5b	2b63abfc-d39d-41ba-bbbe-0648c9b1fd87	obis_node_id	310922b4-9d0c-4de1-92d7-9b442d34765b	active
6916bca7-7d6c-4e3d-8761-e7cd32d9e81f	2b63abfc-d39d-41ba-bbbe-0648c9b1fd87	node_type	secretariat	active
aebc7830-e4ac-4b56-8bf4-07445bab6a46	2b63abfc-d39d-41ba-bbbe-0648c9b1fd87	node_url	https://obis.org	active
77572f29-3612-43ca-affc-24741b052f98	2b63abfc-d39d-41ba-bbbe-0648c9b1fd87	longitude	2.9294803	active
482aeb2c-417a-44d3-9279-f112e834c1bd	2b63abfc-d39d-41ba-bbbe-0648c9b1fd87	latitude	51.2332828	active
4c1f142e-87ef-45a8-acbe-17ed7f665fa3	2b63abfc-d39d-41ba-bbbe-0648c9b1fd87	theme	Contact the secretariat at <a href="mailto:helpdesk@obis.org">helpdesk@obis.org</a>.	active
289093f1-22dd-4e35-823a-af679a962de8	2b63abfc-d39d-41ba-bbbe-0648c9b1fd87	contacts	[{"givenname": "Elizabeth", "surname": "Lawrence", "oceanexpert_id": 50997, "email": "e.lawrence@unesco.org"}, {"givenname": "Ward", "surname": "Appeltans", "oceanexpert_id": 11770, "email": "w.appeltans@unesco.org"}, {"givenname": "Pieter", "surname": "Provoost", "oceanexpert_id": 26192, "email": "p.provoost@unesco.org"}, {"givenname": "Steve", "surname": "Formel", "oceanexpert_id": 54167, "email": "sk.formel@unesco.org"}, {"givenname": "Silas", "surname": "C. Principe", "oceanexpert_id": 40122, "email": "s.principe@unesco.org"}, {"givenname": "Saara", "surname": "Suominen", "oceanexpert_id": 43352, "email": "s.suominen@unesco.org"}, {"givenname": "Lisa", "surname": "Benedetti", "oceanexpert_id": 49824, "email": "l.benedetti@unesco.org"}, {"givenname": "Emilie", "surname": "Boulanger", "oceanexpert_id": 65848, "email": "e.boulanger@unesco.org"}, {"givenname": "Laurent", "surname": "Chmiel", "oceanexpert_id": 72350, "email": "l.chmiel@unesco.org"}]	active
cf05e182-05b2-433b-8978-36ea14868928	2b63abfc-d39d-41ba-bbbe-0648c9b1fd87	feeds	[{"id": "ba021304-65a5-4936-95cc-838788869c91", "url": "https://ipt.gbif.fr/rss.do"}, {"id": "24d3567b-3956-4c7e-84de-f29976fb2461", "url": "https://ipt.obis.org/secretariat/rss.do"}, {"id": "f27ab26d-46f3-462f-8274-2f1fa47ea652", "url": "https://raw.githubusercontent.com/iobis/metabarcoding-feed/refs/heads/main/feed_49b268f4-e5db-49a3-87ad-ee23f397eadd.rss"}, {"id": "d3020170-5700-4832-94b0-a75740648c76", "url": "https://ipt.obis.org/bioecoocean/rss.do"}, {"id": "8f020215-f4db-4b8c-94f0-8d1fbc0881e5", "url": "https://github.com/iobis/mgnify-feed/raw/master/feed.rss"}, {"id": "ec42e345-3001-449b-9d7d-8d10d97b5cc5", "url": "https://ipt.pensoft.net/rss.do"}, {"id": "f6ecda39-1165-4b36-86d3-61ada8abd7bb", "url": "http://ipt.obis.org/nonode/rss.do"}, {"id": "6362a6ef-ba8f-4a56-aa6c-67e0fa5ee933", "url": "https://smalldata.obis.org/api/rss/all"}, {"id": "ada32fbf-a4e5-4c23-b539-fb56403a49af", "url": "https://www.gbif.se/ipt/rss.do"}]	active
72c66567-20c8-463d-9f87-70db4cd4d103	7a423a6a-2a56-4969-93dd-2c21bd4ac1ab	obis_node_id	a31658c6-e934-4e48-bc5b-8da1dccabba6	active
f6146ce8-d70f-4ca2-8d29-6e791fd22607	7a423a6a-2a56-4969-93dd-2c21bd4ac1ab	node_type	regional	active
2ad86cfc-db3e-42cc-b185-390d27593f05	7a423a6a-2a56-4969-93dd-2c21bd4ac1ab	node_url	http://ipt.iobis.org/senegal/	active
56d02bd6-8029-4e11-a9ed-c501c3c1d810	7a423a6a-2a56-4969-93dd-2c21bd4ac1ab	longitude	-17.426065	active
a690b739-bc99-46a8-a786-307ff3505f15	7a423a6a-2a56-4969-93dd-2c21bd4ac1ab	latitude	14.70111	active
6564b693-81e5-414b-87f2-2371ea6fcc64	7a423a6a-2a56-4969-93dd-2c21bd4ac1ab	theme		active
096d0048-d87a-4daa-a8e5-fa6e89ab5230	7a423a6a-2a56-4969-93dd-2c21bd4ac1ab	contacts	null	active
d46a266c-1b91-4cfc-a27a-a560997fd306	7a423a6a-2a56-4969-93dd-2c21bd4ac1ab	feeds	[{"id": "1c5522c3-3feb-4640-b313-9f31e22b54b6", "url": "http://ipt.iobis.org/senegal/rss.do"}]	active
35aa3246-9147-4767-996f-b570fd2a0df4	f575884b-0a5f-4e59-a764-eb9ebfff8340	obis_node_id	f92d5d7f-47a6-4605-9fd0-a8538dfde3fd	active
eece4895-4c76-45a4-b15a-40986238daaf	f575884b-0a5f-4e59-a764-eb9ebfff8340	node_type	regional	active
701da20d-1b44-4736-9dec-4fe2bbd8721a	f575884b-0a5f-4e59-a764-eb9ebfff8340	node_url	https://www.mba.ac.uk	active
9de9d5ec-0743-4955-86a7-00f0c88ba335	f575884b-0a5f-4e59-a764-eb9ebfff8340	longitude	-4.1413264	active
3c1b3c0c-66c9-40ab-8e68-2c175881f319	f575884b-0a5f-4e59-a764-eb9ebfff8340	latitude	50.3642993	active
590a28b4-2134-425e-a4d4-6734972c3874	f575884b-0a5f-4e59-a764-eb9ebfff8340	theme		active
7b8da3ce-7b2b-4683-9bdf-2a785f2bd749	f575884b-0a5f-4e59-a764-eb9ebfff8340	contacts	[{"givenname": "Dan", "surname": "Lear", "oceanexpert_id": 23316, "email": "dble@mba.ac.uk"}, {"givenname": "Kevin", "surname": "Paxman", "oceanexpert_id": 36086, "email": "kevpax@mba.ac.uk"}, {"givenname": "Chloe", "surname": "Figueroa Ashforth", "oceanexpert_id": 56774, "email": "chlfig@mba.ac.uk"}, {"givenname": "Charlie", "surname": "Gough", "oceanexpert_id": 58245, "email": "chagou@mba.ac.uk"}]	active
8e5fac2b-db52-47bb-ba79-bba40f1691bc	f575884b-0a5f-4e59-a764-eb9ebfff8340	feeds	[{"id": "d5d261ce-9955-4c5d-a10b-64bb1d88a3dc", "url": "https://www.dassh.ac.uk/ipt/rss.do"}]	active
9d1f02b9-726d-4396-bff0-966b3710ec6b	2e573b25-7383-4777-be3d-af71c9b771d9	obis_node_id	b7c47783-a020-4173-b390-7b57c4fa1426	active
de72a56e-25e5-43b2-a31a-d612ae25cac4	2e573b25-7383-4777-be3d-af71c9b771d9	node_type	regional	active
256708eb-53cf-4b03-be0f-b5026aa144d7	2e573b25-7383-4777-be3d-af71c9b771d9	node_url	https://www.usgs.gov/obis-usa	active
64d8885c-8558-474f-b29e-e80cf4241d92	2e573b25-7383-4777-be3d-af71c9b771d9	longitude	-105.2749529	active
c6e2827b-f38b-42c8-8ca1-2cdd19cc2e35	2e573b25-7383-4777-be3d-af71c9b771d9	latitude	40.0069147	active
0ab046b4-b4d2-478e-894b-8099011362db	2e573b25-7383-4777-be3d-af71c9b771d9	theme		active
09ef5867-64e4-48ec-b38c-6e841e64f6d2	2e573b25-7383-4777-be3d-af71c9b771d9	contacts	[{"givenname": "Mark", "surname": "Wiltermuth", "oceanexpert_id": 78661, "email": "mwiltermuth@usgs.gov"}, {"givenname": "Mathew", "surname": "Biddle", "oceanexpert_id": 24749, "email": "mathew.biddle@noaa.gov"}]	active
681cab20-acf2-4c74-9a2f-192e708e65a3	697bfd7d-15e1-4b83-b0ee-8f926acc42a4	feeds	[{"id": "b46bd714-39a5-42b6-a997-42e529d898cb", "url": "https://nzobisipt.niwa.co.nz/rss.do"}]	active
8133f804-bd36-4ef6-8973-a896182e5db4	2e573b25-7383-4777-be3d-af71c9b771d9	feeds	[{"id": "5354096d-0a0c-4a0b-8f76-8df2802367af", "url": "https://ipt.idigbio.org/rss.do"}, {"id": "82a07ead-4a56-4e85-9331-d4c2743bfa3e", "url": "https://fisheye.specifycloud.org/export/rss/"}, {"id": "c9839b70-5dce-42d1-ba8e-4e51782d2146", "url": "https://bison.usgs.gov/ipt/rss.do"}, {"id": "efb15359-a72b-48dd-8195-065ea832bad5", "url": "http://ipt.calacademy.org:8080/rss.do"}, {"id": "753ce293-c4c0-4ee5-bf22-361db7b89e3a", "url": "https://ipt.geome-db.org/rss.do"}, {"id": "8112d75b-7e78-4641-9e09-9a2cc7db7375", "url": "https://ipt-obis.gbif.us/rss.do"}, {"id": "11f7ef88-79a5-40eb-99ff-6c979044dcdb", "url": "http://ipt.nhm.ku.edu:8080/ipt/rss.do"}, {"id": "2ba26b79-d120-4c65-8a20-ad4c88637120", "url": "https://ipt.floridamuseum.ufl.edu/ipt/rss.do"}, {"id": "43f7007d-7f00-432b-9de8-95bc1f26374b", "url": "https://ipt.vertnet.org/rss.do"}, {"id": "1c0bd945-86d2-404e-a557-452752673747", "url": "https://ichthyology.specify.ku.edu/export/rss/"}, {"id": "702587c9-13a5-4c27-a7e5-6eb6736f16b0", "url": "https://raw.githubusercontent.com/iobis/invertbase-feed/main/feed.rss"}]	active
42d8d49d-cef3-4a0c-bd4e-695052e723e8	32b6fa33-c5c0-45b1-9080-dcdb64cd9da4	obis_node_id	307cc0a7-238f-4dd5-8e5b-25e0310d983d	active
6e4dc319-2b3f-4ae0-bb1b-dfc810ea852b	32b6fa33-c5c0-45b1-9080-dcdb64cd9da4	node_type	thematic	active
ff7b2f2c-c481-4b55-b1db-8704caa686a2	32b6fa33-c5c0-45b1-9080-dcdb64cd9da4	node_url	http://oceanspast.org/	active
55fb906f-8f25-44ed-911d-a140e62e95c7	32b6fa33-c5c0-45b1-9080-dcdb64cd9da4	longitude	-0.3737226	active
f791c5ae-6146-4ab4-9c7f-7097e785d5fa	32b6fa33-c5c0-45b1-9080-dcdb64cd9da4	latitude	53.7693069	active
18bee5be-bfb9-4014-bad7-274794a5c818	32b6fa33-c5c0-45b1-9080-dcdb64cd9da4	theme		active
2cc26a5b-e8b4-4331-93e1-985d7704e03a	32b6fa33-c5c0-45b1-9080-dcdb64cd9da4	contacts	[{"givenname": "John", "surname": "Nicholls", "oceanexpert_id": 27029, "email": "john.nicholls@tcd.ie"}, {"givenname": "Laoise", "surname": "Dillon", "oceanexpert_id": 49630, "email": "dillonl5@tcd.ie"}]	active
e2bbe361-4ee9-4287-8dd9-7ac723f78ea6	32b6fa33-c5c0-45b1-9080-dcdb64cd9da4	feeds	null	active
8910c95d-57a0-415d-836d-aeb0ef365c8f	e8c40209-a18d-4905-8b54-daec5e04a402	obis_node_id	68f83ea7-69a7-44fd-be77-3c3afd6f3cf8	active
495ba28d-cfd6-4f7b-81fa-5cc76df85c55	e8c40209-a18d-4905-8b54-daec5e04a402	node_type	thematic	active
a57f2d84-8744-4d6a-96a7-be50f6254b17	e8c40209-a18d-4905-8b54-daec5e04a402	node_url	https://members.oceantrack.org	active
9251d601-8eb2-4e68-ab84-909483a64488	e8c40209-a18d-4905-8b54-daec5e04a402	longitude	-63.5966302	active
7ee81a7c-adb3-4773-b646-abbbe7fbaccd	e8c40209-a18d-4905-8b54-daec5e04a402	latitude	44.635729	active
34e91157-e3db-4812-8e6a-0a179e006f01	e8c40209-a18d-4905-8b54-daec5e04a402	theme		active
f9f14938-86b5-46ee-9562-f41610071794	e8c40209-a18d-4905-8b54-daec5e04a402	contacts	[{"givenname": "Angela", "surname": "Dini", "oceanexpert_id": 40292, "email": "angela.dini@dal.ca"}, {"givenname": "Jonathan", "surname": "Pye", "oceanexpert_id": 31190, "email": "jonathan.pye@dal.ca"}, {"givenname": "Caitlin", "surname": "Bate", "oceanexpert_id": 51520, "email": "caitlin.bate@dal.ca"}, {"givenname": "Brian", "surname": "Jones", "oceanexpert_id": 31189, "email": "brian.jones@dal.ca"}]	active
77594ccb-f76d-41d8-b90b-624aa870b750	e8c40209-a18d-4905-8b54-daec5e04a402	feeds	[{"id": "484069ae-da92-43bc-835b-86ed774b95c6", "url": "https://oceantrack.org/ipt/rss.do"}]	active
13657287-dd95-4d1f-9f13-8e19f2653e85	dd2f9ef7-1908-495a-ab74-247ff7379be9	obis_node_id	066e070a-04ca-4cee-acb3-66379fe49d49	active
43407f58-5bdd-4ccf-905b-8ad06aa9b131	dd2f9ef7-1908-495a-ab74-247ff7379be9	node_type	regional	active
6c8835c1-8d64-4b2d-819d-750046c49354	dd2f9ef7-1908-495a-ab74-247ff7379be9	node_url	https://obis.org/node/066e070a-04ca-4cee-acb3-66379fe49d49	active
0b04920f-33d7-410d-8404-b70f2d2b0039	dd2f9ef7-1908-495a-ab74-247ff7379be9	longitude	51.3697947	active
6e30ac01-83ab-4674-b9e6-907a69f5204a	dd2f9ef7-1908-495a-ab74-247ff7379be9	latitude	35.658441	active
40ad3d18-8cd5-4fd5-8e63-16b7564caa62	dd2f9ef7-1908-495a-ab74-247ff7379be9	theme	Persian Gulf and Gulf of Oman OBIS node	active
f69c8868-4bc9-4b6a-b33f-aa8c197b52c5	dd2f9ef7-1908-495a-ab74-247ff7379be9	contacts	[{"givenname": "Abdolvahab", "surname": "Maghsoudlou", "oceanexpert_id": 24441, "email": "wahabbio@gmail.com"}]	active
d9e98c05-1e57-432b-bb0b-e8ccbae5d1e4	dd2f9ef7-1908-495a-ab74-247ff7379be9	feeds	[{"id": "94021428-b469-11ea-b3de-0242ac130004", "url": "http://pego-obis.inio.ac.ir/ipt/rss.do"}]	active
bfefcef0-ac6d-4467-98ff-9d9448cd595a	2ecc04f6-b7ba-43ee-8548-adeea0ffc171	obis_node_id	e19d3c02-134f-45b8-9577-e34e8d89cc22	active
b2bfa17e-04a0-447c-855e-d3d695361b20	2ecc04f6-b7ba-43ee-8548-adeea0ffc171	node_type	regional	active
e6f2ffe7-88dd-43a7-beac-363433946d35	2ecc04f6-b7ba-43ee-8548-adeea0ffc171	node_url	http://chm.aseanbiodiversity.org	active
a87c7c7d-47b7-4377-8487-d3de3fc1bb94	2ecc04f6-b7ba-43ee-8548-adeea0ffc171	longitude	121.2350166	active
aabdafe4-d52c-468b-942c-0b2a53aed003	2ecc04f6-b7ba-43ee-8548-adeea0ffc171	latitude	14.1622749	active
9c6cf982-f73d-4d48-ba8d-91e0c2fdef00	2ecc04f6-b7ba-43ee-8548-adeea0ffc171	theme	South-East Asian OBIS node	active
39cb5274-b965-4e0d-8b56-f7e250396726	2ecc04f6-b7ba-43ee-8548-adeea0ffc171	contacts	[{"givenname": "Christian", "surname": "Elloran", "oceanexpert_id": 21501, "email": "cbelloran@aseanbiodiversity.org"}, {"givenname": "Pauline Carmel Joy ", "surname": "Eje", "oceanexpert_id": 30807, "email": "pcjeje@aseanbiodiversity.org"}]	active
99c98121-57b4-4eb0-8da2-ce2a7ad058f6	2ecc04f6-b7ba-43ee-8548-adeea0ffc171	feeds	[{"id": "c2d7cdb0-8fea-423a-8e01-b33f30d29c07", "url": "http://bim-mirror.aseanbiodiversity.org:8080/ipt/rss.do"}, {"id": "36257bc7-94e5-48e3-8a65-57b308743a05", "url": "http://ipt.iobis.org/seaobis/rss.do"}]	active
7600a950-37b5-47f0-9b74-ab81964128e9	697bfd7d-15e1-4b83-b0ee-8f926acc42a4	obis_node_id	6c17c09e-5cc2-4d5a-8463-e866731d35a1	active
83a1f96e-f24b-47c6-b5ab-d76184c8383d	697bfd7d-15e1-4b83-b0ee-8f926acc42a4	node_type	regional	active
75b4cd74-ad62-42fe-8915-f0bb044d9e19	697bfd7d-15e1-4b83-b0ee-8f926acc42a4	node_url	https://niwa.co.nz/our-science/coasts-and-oceans/tools-and-resources/southwestern-pacific-obis-node	active
84843b84-19ad-4011-94ed-eb842bc91a29	697bfd7d-15e1-4b83-b0ee-8f926acc42a4	longitude	174.7596359	active
59ab68c5-cd8a-42a1-8a44-fde852ec6657	697bfd7d-15e1-4b83-b0ee-8f926acc42a4	latitude	-36.8441406	active
ccfa449b-dad9-4ee2-8bd4-16e29cbeb864	697bfd7d-15e1-4b83-b0ee-8f926acc42a4	theme	South-West Pacific OBIS node	active
66eea8ec-5a35-4136-b07d-398cb4fd6299	697bfd7d-15e1-4b83-b0ee-8f926acc42a4	contacts	[{"givenname": "Kevin", "surname": "Mackay", "oceanexpert_id": 19633, "email": "kevin.mackay@niwa.co.nz"}]	active
df8adead-fd24-4032-82ec-137e5f06c9e8	0b58fb0f-aa97-46ae-b245-ebf99e354c26	ocean_expert_id	19401	active
6123e4af-cfa0-4739-a4ed-33adf62aeabc	0b58fb0f-aa97-46ae-b245-ebf99e354c26	data_source	obis_oceanexpert	active
09590aff-cb40-493b-a37b-3e2c41d240fc	0b58fb0f-aa97-46ae-b245-ebf99e354c26	sync_date	2025-09-22	active
a1f05e9b-b955-4c3d-9156-177e46edced9	aa0a925a-1639-4470-9778-36c809078650	ocean_expert_id	15911	active
a88f53eb-9ebe-4b64-b63a-3910cf419d2c	aa0a925a-1639-4470-9778-36c809078650	data_source	obis_oceanexpert	active
c7302970-d7b2-404f-bf49-2182d6e8e5a5	aa0a925a-1639-4470-9778-36c809078650	sync_date	2025-09-22	active
5ac13472-b296-42e1-bbac-a2c05b8e8f15	5028ad30-1eb0-4305-9e8f-11a2e64c8050	ocean_expert_id	19522	active
e9cdf0e3-ee6e-418f-90c9-5305dc3999d0	5028ad30-1eb0-4305-9e8f-11a2e64c8050	data_source	obis_oceanexpert	active
ad244321-8840-4d44-84cb-e2f8cda57fdf	5028ad30-1eb0-4305-9e8f-11a2e64c8050	sync_date	2025-09-22	active
4ece440a-5009-487a-ade7-43e2bc89dba9	76bac861-e7d0-44fe-b34d-fed4e5b5d665	data_source	obis_oceanexpert	active
9cd78f78-55f2-4201-b0a0-14197871d76f	76bac861-e7d0-44fe-b34d-fed4e5b5d665	sync_date	2025-09-22	active
433eb947-33d8-4879-bdcc-5c4d4e56324b	1f25906e-abaf-4d80-bb52-cca85e0e6826	ocean_expert_id	7201	active
2a133f55-dba4-4c4a-aef5-a160eaf34f4a	1f25906e-abaf-4d80-bb52-cca85e0e6826	data_source	obis_oceanexpert	active
aa29ff4d-c912-459e-ba81-757408ae7440	1f25906e-abaf-4d80-bb52-cca85e0e6826	sync_date	2025-09-22	active
8852c55d-f0fd-457b-86bc-415392b99eca	0f5bcf48-2536-4eda-9890-b90979e67f23	ocean_expert_id	19303	active
92a7f292-85e5-4e7a-92f9-d42d5a189179	0f5bcf48-2536-4eda-9890-b90979e67f23	data_source	obis_oceanexpert	active
e28094c4-9b5d-42c2-9dd1-cba6aa814280	0f5bcf48-2536-4eda-9890-b90979e67f23	sync_date	2025-09-22	active
944bb80e-01db-4f68-838c-4304c970fb58	a92d9cbc-1892-4083-9eb1-8b606b96d53f	ocean_expert_id	7537	active
f374557f-6be3-40a8-8a44-ece45c2a84e9	a92d9cbc-1892-4083-9eb1-8b606b96d53f	data_source	obis_oceanexpert	active
f146b45b-51a5-4fda-b3f5-282f661849b4	a92d9cbc-1892-4083-9eb1-8b606b96d53f	sync_date	2025-09-22	active
45212e4f-f881-4440-83d7-768c0c8a67fd	fdacd702-3d20-4ec8-9b78-9fb5e58aed85	ocean_expert_id	7541	active
cc033f2f-378c-41ad-892e-97182863d1da	fdacd702-3d20-4ec8-9b78-9fb5e58aed85	data_source	obis_oceanexpert	active
9e7227ab-7d71-41f0-8b05-b9fce016b455	fdacd702-3d20-4ec8-9b78-9fb5e58aed85	sync_date	2025-09-22	active
60438604-b505-41f6-ab36-178ce8589155	c6e40c34-af79-49ad-b264-215a7412b267	ocean_expert_id	96	active
590b293a-8654-41de-8d62-2e56571f3715	c6e40c34-af79-49ad-b264-215a7412b267	data_source	obis_oceanexpert	active
12f84d61-eafc-4e1a-8117-49671301f4bb	c6e40c34-af79-49ad-b264-215a7412b267	sync_date	2025-09-22	active
887900e5-6326-40a8-9685-4caee7743063	3d11c74f-6f73-447f-b26e-1b5f1dedd827	ocean_expert_id	11615	active
6dd1f475-745b-4c76-9d8f-79ca093728d3	3d11c74f-6f73-447f-b26e-1b5f1dedd827	data_source	obis_oceanexpert	active
dbf98f4a-7048-4af5-bb82-73326470cf37	3d11c74f-6f73-447f-b26e-1b5f1dedd827	sync_date	2025-09-22	active
598ac607-7098-4398-be2e-06c2b5999c95	e092d59e-78d0-4a96-ab2c-780b96c2dc7e	ocean_expert_id	23174	active
867f93ec-61ab-4232-9967-c25eb81886ac	e092d59e-78d0-4a96-ab2c-780b96c2dc7e	data_source	obis_oceanexpert	active
a924d0cf-68f8-472e-b59b-7543bd52fbed	e092d59e-78d0-4a96-ab2c-780b96c2dc7e	sync_date	2025-09-22	active
e7bf6678-9af1-4f47-86ac-caa622baeb0c	68211384-c996-4cea-b513-640245865f3f	ocean_expert_id	6190	active
c12d18dc-10b2-4ba6-9805-d8234354edab	68211384-c996-4cea-b513-640245865f3f	data_source	obis_oceanexpert	active
6504258a-c88a-42c9-8b2a-58c9f29ecbdd	68211384-c996-4cea-b513-640245865f3f	sync_date	2025-09-22	active
cd6a969d-841b-4ae4-b289-c564dd4dc484	0d792c5d-4fae-4bba-a304-ca301be2df70	ocean_expert_id	23203	active
7aa7832c-5b51-4abe-bd9d-09c2956bb92f	0d792c5d-4fae-4bba-a304-ca301be2df70	data_source	obis_oceanexpert	active
0e25e721-6cd6-43be-9698-36bbba086e2b	0d792c5d-4fae-4bba-a304-ca301be2df70	sync_date	2025-09-22	active
0710ab8a-ea91-4dac-9c61-228ddfc2578c	b73c7e06-2936-4b03-97a0-be42125a5587	ocean_expert_id	15406	active
23941b0e-11b9-4520-8b9e-05f929745e58	b73c7e06-2936-4b03-97a0-be42125a5587	data_source	obis_oceanexpert	active
cc353fb8-b9b8-473b-bf4b-1dc2f4e78b3c	b73c7e06-2936-4b03-97a0-be42125a5587	sync_date	2025-09-22	active
5b4bfabb-004b-4cdc-a7c2-248397d9cbe0	841fb472-2474-434f-8f23-b46aeb320c24	ocean_expert_id	19285	active
3236f8f2-6ca9-48c7-ae3f-5340a88ea490	841fb472-2474-434f-8f23-b46aeb320c24	data_source	obis_oceanexpert	active
55228908-6218-43d9-afbf-166a02f0de47	841fb472-2474-434f-8f23-b46aeb320c24	sync_date	2025-09-22	active
be5b0aa6-e312-431e-9e5b-c751357d5ce1	b2f11608-d736-4228-b023-ea890e70f458	ocean_expert_id	23204	active
058bdf14-808c-409a-b317-f60a467a5251	b2f11608-d736-4228-b023-ea890e70f458	data_source	obis_oceanexpert	active
b0e15558-1072-4533-95d4-054955513f21	b2f11608-d736-4228-b023-ea890e70f458	sync_date	2025-09-22	active
8d33025c-f821-40d7-82e4-3b14eb05b65b	ce45ea14-e92e-4cde-88e1-0975b5230c88	ocean_expert_id	23114	active
a0455c25-b236-4913-8abd-e2554e0e4ccc	ce45ea14-e92e-4cde-88e1-0975b5230c88	data_source	obis_oceanexpert	active
897b25dd-bae4-47df-a02a-bc93a3285fa7	ce45ea14-e92e-4cde-88e1-0975b5230c88	sync_date	2025-09-22	active
c61d4fb3-3ec9-46d6-b564-4294b025bae8	bdf364aa-7c2d-4ebe-9e23-32d53d165765	ocean_expert_id	17925	active
300b4d03-6f5e-42c4-8dff-667e864e5ecb	bdf364aa-7c2d-4ebe-9e23-32d53d165765	data_source	obis_oceanexpert	active
4873b416-a871-4db9-b485-fae43a22dacc	bdf364aa-7c2d-4ebe-9e23-32d53d165765	sync_date	2025-09-22	active
89d201a6-a7e4-4613-bd4d-85e36557a2de	0b98dbfe-c3c3-4c9a-8ef0-748ca63df702	ocean_expert_id	19363	active
97915161-0cf5-4a52-ac25-ab63a27a416b	0b98dbfe-c3c3-4c9a-8ef0-748ca63df702	data_source	obis_oceanexpert	active
dab2db40-191d-48ff-993d-fb5b6d019b1e	0b98dbfe-c3c3-4c9a-8ef0-748ca63df702	sync_date	2025-09-22	active
8ebec2e8-e0f2-4307-975a-7144538b0bb8	51fdd65d-819f-4f04-bdca-61c977ecc5b1	ocean_expert_id	18879	active
bb0c23f6-dd3e-477d-8842-3638f04c4003	51fdd65d-819f-4f04-bdca-61c977ecc5b1	data_source	obis_oceanexpert	active
7cc4f2e6-b795-4790-92d8-d1b110b81ae0	51fdd65d-819f-4f04-bdca-61c977ecc5b1	sync_date	2025-09-22	active
5736493e-724b-4346-8844-4e8951c222c6	798c1858-ec4b-4995-8153-e4757954f0db	ocean_expert_id	7656	active
e8f178a0-6e60-4e36-8b44-f9c65233128c	798c1858-ec4b-4995-8153-e4757954f0db	data_source	obis_oceanexpert	active
148c154a-b067-43df-8f90-f078eb60d5e1	798c1858-ec4b-4995-8153-e4757954f0db	sync_date	2025-09-22	active
4136a0bd-514c-4378-8013-0e21a7a1f3a3	85103d1a-32b9-432b-9477-17d798863fd8	ocean_expert_id	19636	active
f89edba7-0dcd-482d-a37a-aa75b66648ee	85103d1a-32b9-432b-9477-17d798863fd8	data_source	obis_oceanexpert	active
d4efe757-815a-426c-82e1-a378f0a60ce1	85103d1a-32b9-432b-9477-17d798863fd8	sync_date	2025-09-22	active
be0b6941-ab79-46e2-88c8-9b0e4ae43e6d	31decf3a-eca7-48bd-a0df-4e5ad6184b84	ocean_expert_id	18356	active
9c160c7f-bfca-46b9-8082-c58842a972dc	31decf3a-eca7-48bd-a0df-4e5ad6184b84	data_source	obis_oceanexpert	active
ed64ef2a-9273-47c7-9bd9-f6f6568ab99b	31decf3a-eca7-48bd-a0df-4e5ad6184b84	sync_date	2025-09-22	active
56cce3f5-fcd1-47d0-be3e-7b7ed6974a84	febe0919-ebae-4143-b13b-2d16c3be7b7a	ocean_expert_id	17927	active
40611cac-8f9f-4609-99f9-773f614b95c9	febe0919-ebae-4143-b13b-2d16c3be7b7a	data_source	obis_oceanexpert	active
002af674-d3a9-42aa-b6b6-ba615e02dd01	febe0919-ebae-4143-b13b-2d16c3be7b7a	sync_date	2025-09-22	active
958131c3-562b-4d8e-b15a-b1ada8fe55f9	2be3f8c6-0305-40ce-a886-e16fe1d5b866	ocean_expert_id	19372	active
8f263d1f-208f-4b51-9daf-c52fd5887daa	2be3f8c6-0305-40ce-a886-e16fe1d5b866	data_source	obis_oceanexpert	active
bc8bef91-e38a-4d29-bea2-45d1999b819a	2be3f8c6-0305-40ce-a886-e16fe1d5b866	sync_date	2025-09-22	active
01214889-8ef3-4f2d-9326-6f4ea51abe8e	b317dc0d-8a62-4185-b81f-58f8ce10f677	ocean_expert_id	17783	active
2edcdbc9-6c6b-4928-bb04-fdf13ed4af40	b317dc0d-8a62-4185-b81f-58f8ce10f677	data_source	obis_oceanexpert	active
1b24f2d3-a5b3-4529-a76b-6b80125e4296	b317dc0d-8a62-4185-b81f-58f8ce10f677	sync_date	2025-09-22	active
9be4a351-186a-4566-a390-7a8b832a1642	90524ed2-5832-4d0e-93bd-8199dbab28e6	ocean_expert_id	19503	active
48935f36-2a8b-4b7f-9360-6287f9816d86	90524ed2-5832-4d0e-93bd-8199dbab28e6	data_source	obis_oceanexpert	active
d66b49d9-a78d-47e6-8e74-efc794e2dbce	90524ed2-5832-4d0e-93bd-8199dbab28e6	sync_date	2025-09-22	active
999612cf-49f5-4fc3-b66a-22e9bb2c6165	10302fdc-b9d1-48c2-adaf-9db10247c965	ocean_expert_id	11235	active
c0b3ff70-408c-46bf-b023-31eb892ee286	10302fdc-b9d1-48c2-adaf-9db10247c965	data_source	obis_oceanexpert	active
ab31ea28-ec4b-4c12-a806-c0475f9a0bd0	10302fdc-b9d1-48c2-adaf-9db10247c965	sync_date	2025-09-22	active
f9d0a6d4-b3fa-4ec6-9472-a6acb86f95d9	f79362d0-ac5f-4f3e-adf2-40dd62c1750e	ocean_expert_id	17434	active
5c512200-198f-425f-ac00-f071ca6a44c3	f79362d0-ac5f-4f3e-adf2-40dd62c1750e	data_source	obis_oceanexpert	active
02010d9d-0bc6-4646-91d9-1d101a2b496d	f79362d0-ac5f-4f3e-adf2-40dd62c1750e	sync_date	2025-09-22	active
5d449bcc-0b89-4077-b63a-8f1843808ea7	f310ae60-2665-486c-aa2f-79087f0eb160	ocean_expert_id	23188	active
7c1e1679-f6ad-420c-b4b2-1d7dfea7f827	f310ae60-2665-486c-aa2f-79087f0eb160	data_source	obis_oceanexpert	active
a5d23365-9e6e-4329-b2a2-a87662cbbdfd	f310ae60-2665-486c-aa2f-79087f0eb160	sync_date	2025-09-22	active
0502cc6c-c628-4e21-8f3c-a8714c20022d	eb9da7c3-1e8d-4ee9-832c-094feca3b764	ocean_expert_id	23182	active
c66a4a5c-37ed-4648-ba5c-b6260e56eb06	eb9da7c3-1e8d-4ee9-832c-094feca3b764	data_source	obis_oceanexpert	active
537ab7e0-ded9-4d1b-a1c3-b98cfddf5292	eb9da7c3-1e8d-4ee9-832c-094feca3b764	sync_date	2025-09-22	active
3da7b7d4-4091-4c17-881c-6b25ac532496	e36390bf-7bf5-401c-9416-563eb9764b71	ocean_expert_id	11036	active
5d170ef6-787b-405e-821b-a1682abc8897	e36390bf-7bf5-401c-9416-563eb9764b71	data_source	obis_oceanexpert	active
97ae2754-fffe-4769-a455-753703b11ac6	e36390bf-7bf5-401c-9416-563eb9764b71	sync_date	2025-09-22	active
a24dc4ef-59d4-45d2-9907-9666d9b9794d	a33882e2-da54-4760-918d-959fad0c885a	ocean_expert_id	19413	active
4dd08750-dc71-43e8-8c94-fef9a6bcf369	a33882e2-da54-4760-918d-959fad0c885a	data_source	obis_oceanexpert	active
67abf4b1-0883-4324-99c8-b7e4b6478dbe	a33882e2-da54-4760-918d-959fad0c885a	sync_date	2025-09-22	active
0eb4b6cb-ab92-40c4-811a-81bf192ea4f0	13553e47-6461-4b99-b3a3-f08668a89c46	ocean_expert_id	19457	active
84e39575-6fec-40c6-acb1-45350c165470	13553e47-6461-4b99-b3a3-f08668a89c46	data_source	obis_oceanexpert	active
df7e660d-95d0-4c9d-a07f-9174d94def60	13553e47-6461-4b99-b3a3-f08668a89c46	sync_date	2025-09-22	active
d52b47c8-5c03-4adb-a9f7-a14b7fa4637a	0dcf8d2c-cc1f-4fdc-b642-5a65f9829fb3	ocean_expert_id	11722	active
e7203dce-68ea-4212-90ad-4de6700d91fe	0dcf8d2c-cc1f-4fdc-b642-5a65f9829fb3	data_source	obis_oceanexpert	active
b8098de3-c363-4f4a-9536-8fd4277e9838	0dcf8d2c-cc1f-4fdc-b642-5a65f9829fb3	sync_date	2025-09-22	active
eb2c7be4-c6a8-4584-a1a8-ec37de2ad55c	592a4f7e-3dd2-4979-a5cd-9444de39a3e5	ocean_expert_id	5196	active
fa1684e7-3116-44cf-aaa0-d8de0784a8c8	592a4f7e-3dd2-4979-a5cd-9444de39a3e5	data_source	obis_oceanexpert	active
482811fc-e093-4460-8da5-9874303b86e4	592a4f7e-3dd2-4979-a5cd-9444de39a3e5	sync_date	2025-09-22	active
38ba0943-edb9-4575-b37d-17a58f4d3ff7	fb9a34d1-2e3e-4b0b-b7e5-4811b5582a5f	ocean_expert_id	6675	active
59da2982-f3d7-4e57-b195-70e53f4d6546	fb9a34d1-2e3e-4b0b-b7e5-4811b5582a5f	data_source	obis_oceanexpert	active
db741190-bdac-483c-9a27-95933da30ca2	fb9a34d1-2e3e-4b0b-b7e5-4811b5582a5f	sync_date	2025-09-22	active
bb29917b-fa7b-4a83-9e3f-d9f5b01dc8fa	c5ea1454-5a27-4f68-8751-b719b1f22e91	ocean_expert_id	8887	active
6918e1c8-9c64-4f08-b248-aa1c402d4b42	c5ea1454-5a27-4f68-8751-b719b1f22e91	data_source	obis_oceanexpert	active
b70a00e7-48cd-4d4f-a012-3ba672ae57bf	c5ea1454-5a27-4f68-8751-b719b1f22e91	sync_date	2025-09-22	active
74e06bd9-0aec-4299-96bc-57db58ed4de5	25c465b1-11ab-48f5-9171-0c9daad96682	ocean_expert_id	19304	active
8209d7c2-636f-4c6a-9aea-cc0be083badd	25c465b1-11ab-48f5-9171-0c9daad96682	data_source	obis_oceanexpert	active
0bf1426c-d9c3-4332-b8c1-6d7d7e128b11	25c465b1-11ab-48f5-9171-0c9daad96682	sync_date	2025-09-22	active
0039aa10-8b0c-4042-b772-754b32781f77	b457f063-800f-455a-888a-af4961e486e8	ocean_expert_id	12745	active
0ec88377-ff0a-4b73-aec7-275049a83129	b457f063-800f-455a-888a-af4961e486e8	data_source	obis_oceanexpert	active
ae1c029e-279d-4906-a6fa-f1c0524cf552	b457f063-800f-455a-888a-af4961e486e8	sync_date	2025-09-22	active
d1289bda-5d80-4e81-a442-e7d2d64b2a2d	667c0d64-27f9-4851-8fb6-87d460d543f5	ocean_expert_id	23190	active
c6f8528e-e053-4d80-8169-036c259bcb4d	667c0d64-27f9-4851-8fb6-87d460d543f5	data_source	obis_oceanexpert	active
0d22793d-a065-47e5-adfc-38d9bb2d0f76	667c0d64-27f9-4851-8fb6-87d460d543f5	sync_date	2025-09-22	active
88519815-d5b6-4933-bb22-bdd1423b777f	59bbd82d-d9d2-4744-bfb5-be609e893aea	ocean_expert_id	16063	active
038a7837-93c2-4049-8f37-17ba93c26b9b	59bbd82d-d9d2-4744-bfb5-be609e893aea	data_source	obis_oceanexpert	active
dde7284b-5aa7-45eb-ae72-cd1050b08755	59bbd82d-d9d2-4744-bfb5-be609e893aea	sync_date	2025-09-22	active
856d3157-ff15-4fe2-ab43-b1a0973bc47b	be0878c0-57b1-4f4d-8bc9-90383a35f8c7	ocean_expert_id	22585	active
b2f9b0f5-9ad9-437b-a7fd-17ccdeacb074	be0878c0-57b1-4f4d-8bc9-90383a35f8c7	data_source	obis_oceanexpert	active
75349049-046b-432f-9632-c5502888aa0a	be0878c0-57b1-4f4d-8bc9-90383a35f8c7	sync_date	2025-09-22	active
7da853e6-04f4-4939-b6dc-2c26db7f4514	c2fea925-2541-450f-aa6b-88db3659c6b5	ocean_expert_id	22957	active
1113b6fb-8fdb-45fb-8c24-e939c6a59a7e	c2fea925-2541-450f-aa6b-88db3659c6b5	data_source	obis_oceanexpert	active
c3c1302e-789d-4fe6-92fc-d14363a2b5d5	c2fea925-2541-450f-aa6b-88db3659c6b5	sync_date	2025-09-22	active
4f292ce0-1d5a-400a-aef9-5dd84581919e	60d230ea-04bb-4bf0-bc31-931986c6f8ad	ocean_expert_id	18185	active
3801a970-38d4-412e-9566-c7676d15e4e5	60d230ea-04bb-4bf0-bc31-931986c6f8ad	data_source	obis_oceanexpert	active
31ed4746-e0ee-4639-bf85-dab893ce29a7	60d230ea-04bb-4bf0-bc31-931986c6f8ad	sync_date	2025-09-22	active
8f5ba5aa-5f91-4bd0-ab05-edeafe5dc8c3	e928747c-cbc0-45c3-ac29-7d50ffd9a540	ocean_expert_id	19389	active
d287bd39-625f-4104-9272-ca94a039c899	e928747c-cbc0-45c3-ac29-7d50ffd9a540	data_source	obis_oceanexpert	active
44d54dc2-aa44-4ec9-84a5-ff56f3bb5afc	e928747c-cbc0-45c3-ac29-7d50ffd9a540	sync_date	2025-09-22	active
f5dad341-9ef4-43f7-964b-a741f4225bc5	5154fc27-ad82-44e9-a9a0-54880a290a81	ocean_expert_id	7363	active
87906e7b-5fa5-4bfd-b89a-e82e4ef947d5	5154fc27-ad82-44e9-a9a0-54880a290a81	data_source	obis_oceanexpert	active
edeabf50-96af-499c-8b50-3e32b1a88d34	5154fc27-ad82-44e9-a9a0-54880a290a81	sync_date	2025-09-22	active
17ad24b1-d5ce-409e-aa92-17ead2788df2	d96a1343-305f-4dd8-9065-dce0e486cb0d	data_source	obis_oceanexpert	active
f63b6614-eedc-4d6b-87b6-1146a69384c0	d96a1343-305f-4dd8-9065-dce0e486cb0d	sync_date	2025-09-22	active
f8191bcd-eadc-442f-8b6d-15e76571ebb3	5d3f93d2-b551-478e-98f6-be5325aab839	ocean_expert_id	23205	active
01d81be6-7c88-4679-8476-3837c985ca13	5d3f93d2-b551-478e-98f6-be5325aab839	data_source	obis_oceanexpert	active
e9a429f9-14c0-46c3-aca7-75eadd4100e0	5d3f93d2-b551-478e-98f6-be5325aab839	sync_date	2025-09-22	active
dd8dfc96-4c5c-426f-b5c7-bef8f3da1fa9	6a9bb29b-626b-4adc-80f3-c0d5e8bf1541	ocean_expert_id	5501	active
0b9636a1-4e1c-4d57-9cd2-d913f2b5e3a6	6a9bb29b-626b-4adc-80f3-c0d5e8bf1541	data_source	obis_oceanexpert	active
6fbc676a-4c50-40c2-945a-a486e5e00a5f	6a9bb29b-626b-4adc-80f3-c0d5e8bf1541	sync_date	2025-09-22	active
98bfaa2d-d35f-453a-b555-6dfef6e7d862	61865196-9996-4c6b-9f95-e56b48656f79	ocean_expert_id	19284	active
2a67732b-60d6-4a6a-b393-62a1787fb4c7	61865196-9996-4c6b-9f95-e56b48656f79	data_source	obis_oceanexpert	active
357bef2c-3be9-4ac6-b65c-935434d49062	61865196-9996-4c6b-9f95-e56b48656f79	sync_date	2025-09-22	active
96b69e74-493b-4fbc-a1b7-cdc63aeab44f	cfe2357b-8494-4915-a4af-e5e78f9a2d0e	ocean_expert_id	19366	active
bf506a0f-39f6-482a-9422-e70c060825e8	cfe2357b-8494-4915-a4af-e5e78f9a2d0e	data_source	obis_oceanexpert	active
e77986b0-d5da-4edd-9125-177c5c1a4245	cfe2357b-8494-4915-a4af-e5e78f9a2d0e	sync_date	2025-09-22	active
7b45429e-8fac-4199-be20-f07d7fdcb61c	88783a78-f253-4f14-9c47-75ec6af444eb	ocean_expert_id	18010	active
d66ce803-4f66-4ca5-a5ea-d8ad7a9f7d6f	88783a78-f253-4f14-9c47-75ec6af444eb	data_source	obis_oceanexpert	active
f6ffedc5-aa5e-44a2-83a8-f99a109a09a4	88783a78-f253-4f14-9c47-75ec6af444eb	sync_date	2025-09-22	active
974f501c-b573-4bd7-93e2-e2bd9f01bd62	d2765fce-1dc3-4a5d-8bf2-498ab4dca5c1	ocean_expert_id	17545	active
a5cbcb15-154b-4c71-aea6-60bee4984548	d2765fce-1dc3-4a5d-8bf2-498ab4dca5c1	data_source	obis_oceanexpert	active
b5e79a61-5598-4d1a-a7ab-a57566e078fc	d2765fce-1dc3-4a5d-8bf2-498ab4dca5c1	sync_date	2025-09-22	active
92c9d0cb-1486-4a35-b46c-e8c0f1478a50	eba18a36-8bf8-465e-ac22-faf91d8842c1	ocean_expert_id	16218	active
6752ece4-7892-4ecc-af57-272999a779fa	eba18a36-8bf8-465e-ac22-faf91d8842c1	data_source	obis_oceanexpert	active
feb9c97e-beb5-464e-9311-8e44511385b8	eba18a36-8bf8-465e-ac22-faf91d8842c1	sync_date	2025-09-22	active
bbd01633-201c-494a-8dd2-f0aca8e33ecb	bcf08a4d-30c6-48f7-abd7-8c9ec80bfdb8	ocean_expert_id	18212	active
a75ac417-3cd1-4246-b07f-1a20dd01d5bd	bcf08a4d-30c6-48f7-abd7-8c9ec80bfdb8	data_source	obis_oceanexpert	active
3c604ef3-92a7-4902-a604-bec6e8fde1d3	bcf08a4d-30c6-48f7-abd7-8c9ec80bfdb8	sync_date	2025-09-22	active
576c8675-45f5-4f3b-9e50-4d24e62c34cf	6fe6381f-bb07-424d-a851-195f25b6f6d9	ocean_expert_id	7692	active
1d5111e9-3131-4d05-91dd-0b8d48581272	6fe6381f-bb07-424d-a851-195f25b6f6d9	data_source	obis_oceanexpert	active
349cf2f2-cbd4-4004-bae9-7430c0bc10f6	6fe6381f-bb07-424d-a851-195f25b6f6d9	sync_date	2025-09-22	active
8ae280f4-800e-43f4-9bb4-7c0edaf4ba76	fc266a55-849b-4d77-a3ae-6c87be229e74	ocean_expert_id	7979	active
8ebe43cb-1b87-412b-980b-f47c206ece42	fc266a55-849b-4d77-a3ae-6c87be229e74	data_source	obis_oceanexpert	active
eb349681-1002-4845-9d4c-8f7a8bbb1073	fc266a55-849b-4d77-a3ae-6c87be229e74	sync_date	2025-09-22	active
da3861bd-ea48-4d08-9747-0cb8768458fe	baf6eb4a-004f-46e0-93b0-33ddb3b5c062	ocean_expert_id	22463	active
964856fe-b54c-4a63-9684-427cb6698648	baf6eb4a-004f-46e0-93b0-33ddb3b5c062	data_source	obis_oceanexpert	active
44716b45-11a5-48b1-b537-77f66e47f338	baf6eb4a-004f-46e0-93b0-33ddb3b5c062	sync_date	2025-09-22	active
d2284937-aedb-4b68-80e8-eec12841fe6c	abf49f90-3508-4a79-8291-7285b2f35eaf	ocean_expert_id	6094	active
80cd37a5-7e6a-4d8a-a911-8e38d9b6edf8	abf49f90-3508-4a79-8291-7285b2f35eaf	data_source	obis_oceanexpert	active
92f2b65e-ce7f-421b-ab10-c2e8daee9377	abf49f90-3508-4a79-8291-7285b2f35eaf	sync_date	2025-09-22	active
e6b5d75a-dfa9-4571-9403-8c715db0982c	d5869af9-6e98-4c5d-827d-5c05ebbb06c1	ocean_expert_id	18840	active
aa569db2-22f2-49d8-ac36-9b14f3a6530f	d5869af9-6e98-4c5d-827d-5c05ebbb06c1	data_source	obis_oceanexpert	active
dc919a04-8f52-497e-9cec-dec63f19eb55	d5869af9-6e98-4c5d-827d-5c05ebbb06c1	sync_date	2025-09-22	active
c38dd78b-6ec6-40d1-8e8d-f5b85e1e7630	5ad2c0af-ffc4-4cb9-b191-bbe63620020d	ocean_expert_id	20644	active
93fb4ce9-196c-48ae-9fb7-b21ee169fc10	5ad2c0af-ffc4-4cb9-b191-bbe63620020d	data_source	obis_oceanexpert	active
b99e0583-dfd6-4c72-8a62-3c108b5d4f04	5ad2c0af-ffc4-4cb9-b191-bbe63620020d	sync_date	2025-09-22	active
644348ef-6f4f-4ecf-8146-50a596f54f33	6222c029-d926-4655-9dbb-2ab5bb2f935d	ocean_expert_id	6185	active
e4181c14-50aa-4275-ade3-10d58b27cbe3	6222c029-d926-4655-9dbb-2ab5bb2f935d	data_source	obis_oceanexpert	active
1657fb28-ba57-477c-9471-6e27636eaf97	6222c029-d926-4655-9dbb-2ab5bb2f935d	sync_date	2025-09-22	active
6f06c003-6689-4c39-aad5-aec1d8d580ed	e054b50c-c05a-4962-91a6-adad139afe90	ocean_expert_id	6715	active
2613f605-645f-41bc-8c2b-37c0bc6c9739	e054b50c-c05a-4962-91a6-adad139afe90	data_source	obis_oceanexpert	active
f20be627-8a9f-48ac-8ac5-e58909a89dd8	e054b50c-c05a-4962-91a6-adad139afe90	sync_date	2025-09-22	active
2fd22cd8-f284-452c-8394-3b2d94f32fc7	95d7dd4e-f07e-4ebe-9559-801d52a42ea1	ocean_expert_id	5168	active
a517ace2-f8e5-47e5-9829-1f425972231c	95d7dd4e-f07e-4ebe-9559-801d52a42ea1	data_source	obis_oceanexpert	active
ba10f37c-190c-4ac8-986f-00b51f0101df	95d7dd4e-f07e-4ebe-9559-801d52a42ea1	sync_date	2025-09-22	active
c1dca97f-b6fb-4afc-8a54-9c3b6e372a9a	cb9b615b-33aa-495a-a565-fd98a0b307f6	ocean_expert_id	19642	active
2a950937-94d3-47b6-b9ae-849ed1ed02c1	cb9b615b-33aa-495a-a565-fd98a0b307f6	data_source	obis_oceanexpert	active
35bbbf7d-3467-41e2-8334-3fa38b77016e	cb9b615b-33aa-495a-a565-fd98a0b307f6	sync_date	2025-09-22	active
49da7fa6-ba46-4351-9af9-b47dd3eecab8	2538a5d4-9f12-4d90-894f-1b269da5ac0b	ocean_expert_id	13169	active
29e0aba3-db32-4771-8819-4fa3f1bda67b	2538a5d4-9f12-4d90-894f-1b269da5ac0b	data_source	obis_oceanexpert	active
db51cb57-1823-43b5-bb1e-af5ec25c59c8	2538a5d4-9f12-4d90-894f-1b269da5ac0b	sync_date	2025-09-22	active
1c53b927-cf43-4ae8-8710-af9c8294afe1	2c60df9f-d7e2-4d5c-a18b-860da9bfad32	ocean_expert_id	19569	active
e0117171-8bcc-4e46-9e2f-567518726d35	2c60df9f-d7e2-4d5c-a18b-860da9bfad32	data_source	obis_oceanexpert	active
901b230e-8386-45c9-9e74-1a889c61a2d6	2c60df9f-d7e2-4d5c-a18b-860da9bfad32	sync_date	2025-09-22	active
040f4d83-7ed3-4c16-b2a0-c232075118f0	d5b9d5ec-1686-43ba-92bc-7fa793c225e4	ocean_expert_id	19538	active
18181154-477c-45b8-998c-02f122d50fa0	d5b9d5ec-1686-43ba-92bc-7fa793c225e4	data_source	obis_oceanexpert	active
6a66d43d-7bdd-40c4-bd51-20ce3021b19a	d5b9d5ec-1686-43ba-92bc-7fa793c225e4	sync_date	2025-09-22	active
d5b44b0f-3e2b-4442-ac29-bd659fa73357	29ddffca-2484-4ede-9e6d-6f7e11895bfd	ocean_expert_id	7785	active
dfa4c808-0950-4699-978a-d505b4030c64	29ddffca-2484-4ede-9e6d-6f7e11895bfd	data_source	obis_oceanexpert	active
b234864b-7b0b-492d-8178-0cae2561c2ce	29ddffca-2484-4ede-9e6d-6f7e11895bfd	sync_date	2025-09-22	active
f452a3af-f0f2-43ed-a02d-4354a4cc30a6	dfa67296-40ed-4632-ac81-54a869dbfb97	ocean_expert_id	9407	active
a75614e9-3abd-4b28-8f7e-74e36b4edd7b	dfa67296-40ed-4632-ac81-54a869dbfb97	data_source	obis_oceanexpert	active
a17e1d55-d94f-4a41-9d4a-ea72aa7fdc1b	dfa67296-40ed-4632-ac81-54a869dbfb97	sync_date	2025-09-22	active
eb25a13f-22de-41ec-9af2-4a01516eadeb	3c50b952-0f6a-404e-9a0d-0d5003959792	data_source	obis_oceanexpert	active
82dc4a1f-648f-4a67-85c3-2a38f2f632ae	3c50b952-0f6a-404e-9a0d-0d5003959792	sync_date	2025-09-22	active
ae7280b0-cd0a-4be7-8b6d-f36da84fd1ca	05787a9d-bc52-4e47-8ac8-b7dad21abfd3	ocean_expert_id	5605	active
83bdf5a4-2376-483c-8532-b967557e15b5	05787a9d-bc52-4e47-8ac8-b7dad21abfd3	data_source	obis_oceanexpert	active
aeaac9e5-2729-42f6-a1c6-6dfd5d4e66b9	05787a9d-bc52-4e47-8ac8-b7dad21abfd3	sync_date	2025-09-22	active
2b14746a-98ea-421b-88ba-4c5436fbf1a3	02aca92a-1742-40f0-bd6d-13a6c385ae8e	ocean_expert_id	19315	active
01263db7-439e-4615-b57a-9b2a28009d3d	02aca92a-1742-40f0-bd6d-13a6c385ae8e	data_source	obis_oceanexpert	active
52ff93e4-5638-41e2-a55c-86d93cd04a9f	02aca92a-1742-40f0-bd6d-13a6c385ae8e	sync_date	2025-09-22	active
882e886f-3bb6-43fb-a263-194285936738	b21517fa-4431-4711-beb2-a92639c62ea5	ocean_expert_id	12548	active
d254dcb5-7efc-47f4-98de-ec0d440a9b4c	b21517fa-4431-4711-beb2-a92639c62ea5	data_source	obis_oceanexpert	active
a13495e3-026a-434f-a3cd-bfd8f69ea6ef	b21517fa-4431-4711-beb2-a92639c62ea5	sync_date	2025-09-22	active
4cc1e420-6f1b-4233-be7e-12081b724338	0af463d7-be40-46b8-ae06-de54d1c501a7	ocean_expert_id	5684	active
2a6ee479-553f-4b5f-a104-b96bd2ad49a4	0af463d7-be40-46b8-ae06-de54d1c501a7	data_source	obis_oceanexpert	active
6b16e0e1-aa99-44e7-8752-2c33511b0649	0af463d7-be40-46b8-ae06-de54d1c501a7	sync_date	2025-09-22	active
6afbcd87-0b63-4077-b0a1-fc4743da1315	970491c8-f9c6-494d-bafe-6f50dee92d35	ocean_expert_id	8279	active
2f182a9e-15f8-49e9-9c53-d2a9e66a18a4	970491c8-f9c6-494d-bafe-6f50dee92d35	data_source	obis_oceanexpert	active
7ee8daf9-ee46-4975-80ed-a3928e53374b	970491c8-f9c6-494d-bafe-6f50dee92d35	sync_date	2025-09-22	active
57be95c5-7671-4a1b-adb0-dc9aa4beef4b	e915a1fb-c859-448d-8b03-143524fa4bb7	ocean_expert_id	18357	active
460d0fbf-6e79-448f-9fb6-59060080e53a	e915a1fb-c859-448d-8b03-143524fa4bb7	data_source	obis_oceanexpert	active
7f775231-299d-4b70-9b06-5d2af2c29a03	e915a1fb-c859-448d-8b03-143524fa4bb7	sync_date	2025-09-22	active
557563d4-b630-4aba-93d8-c531adf2e95b	b5c3662c-af5e-4f83-977b-344869ac4ddd	ocean_expert_id	19593	active
a4d06fdf-4716-4f2f-8219-b1b86b7eaa5f	b5c3662c-af5e-4f83-977b-344869ac4ddd	data_source	obis_oceanexpert	active
262bf292-4f79-4ff4-8843-3318fc5a29a9	b5c3662c-af5e-4f83-977b-344869ac4ddd	sync_date	2025-09-22	active
741abdee-116f-4288-9117-0ce1884b7e1a	5ade6690-8569-4f9f-b076-2f3483b83196	ocean_expert_id	17768	active
036e7861-c876-417d-8ad7-fb3b434e7d18	5ade6690-8569-4f9f-b076-2f3483b83196	data_source	obis_oceanexpert	active
f1f41389-1a08-4e26-a949-c68374f604eb	5ade6690-8569-4f9f-b076-2f3483b83196	sync_date	2025-09-22	active
0f424aae-4588-49ac-b08f-b400c7f2baae	7bac9cb3-5240-43ec-9090-75f596724d84	ocean_expert_id	19531	active
dd489939-da03-4006-b854-288494507d4a	7bac9cb3-5240-43ec-9090-75f596724d84	data_source	obis_oceanexpert	active
0c53726d-420b-4091-8c74-5ea2703c4441	7bac9cb3-5240-43ec-9090-75f596724d84	sync_date	2025-09-22	active
5995c752-d53d-41a9-8737-796020bf7988	d0b92a8f-0c1a-46c8-a1a7-7c1aa2535ab1	ocean_expert_id	19411	active
0a27fe2e-d842-4ebb-a0d6-e29f3012ce78	d0b92a8f-0c1a-46c8-a1a7-7c1aa2535ab1	data_source	obis_oceanexpert	active
3179917e-6273-42f9-929e-2fd154d37deb	d0b92a8f-0c1a-46c8-a1a7-7c1aa2535ab1	sync_date	2025-09-22	active
923d3c5d-4f5c-4659-8c25-3f6ecb6ef35a	a3b95820-ea5c-48d8-bcf3-383a602205f6	ocean_expert_id	19362	active
658f2375-6f49-4c78-910a-58ba7adceb8a	a3b95820-ea5c-48d8-bcf3-383a602205f6	data_source	obis_oceanexpert	active
29935ea7-ff4a-420c-902d-6edcde9b7dc6	a3b95820-ea5c-48d8-bcf3-383a602205f6	sync_date	2025-09-22	active
fe12b779-d1b6-4b8a-81eb-66752a6601c8	6b693b05-3dae-4e77-b27b-39e85055d903	ocean_expert_id	18261	active
1b9a81d3-c5c4-4594-b6ff-24a93d2fa74f	6b693b05-3dae-4e77-b27b-39e85055d903	data_source	obis_oceanexpert	active
322e9bbf-948d-495e-8fd7-48ce60c9fcfd	6b693b05-3dae-4e77-b27b-39e85055d903	sync_date	2025-09-22	active
d6d661ae-4e70-4b3a-b360-80da355a96b3	a427377b-8b01-46a4-993e-066e3b60877c	ocean_expert_id	18229	active
aab7e593-3721-4c54-9748-a7202d6ffe3d	a427377b-8b01-46a4-993e-066e3b60877c	data_source	obis_oceanexpert	active
d0246ad1-c145-47b3-8760-f29897de08e8	a427377b-8b01-46a4-993e-066e3b60877c	sync_date	2025-09-22	active
9d2d274d-4f0c-4e01-bb71-6f8a0b997286	dba4cd0d-0b05-45e1-9786-c7ac5306f342	ocean_expert_id	11420	active
29f3aaa2-51f3-40ad-908a-d3f3f1a12a91	dba4cd0d-0b05-45e1-9786-c7ac5306f342	data_source	obis_oceanexpert	active
ea4fab35-3517-4764-ab19-91eb3ff977f9	dba4cd0d-0b05-45e1-9786-c7ac5306f342	sync_date	2025-09-22	active
6d483f23-826f-41e0-9da9-5cb7298f640f	70ec09c1-9d93-475d-ac96-2b89bae385ab	ocean_expert_id	21945	active
c98b192c-8758-4b3b-81ad-86ad6b33f551	70ec09c1-9d93-475d-ac96-2b89bae385ab	data_source	obis_oceanexpert	active
208720f1-8e0e-410a-8e57-e88be176e036	70ec09c1-9d93-475d-ac96-2b89bae385ab	sync_date	2025-09-22	active
02b02f09-0326-46ed-a1a2-e9f7c6721456	7450d9d6-b6a8-4888-988c-841eb76b3217	ocean_expert_id	19575	active
f917c591-8116-467d-bf4d-ffb98c2288f2	7450d9d6-b6a8-4888-988c-841eb76b3217	data_source	obis_oceanexpert	active
aeddc928-a87c-4778-83ec-05684b201488	7450d9d6-b6a8-4888-988c-841eb76b3217	sync_date	2025-09-22	active
8829f76b-f5e9-4029-b575-893a3dec37ce	97da71e8-2ef4-4130-9ef7-7a6093e2cfa6	ocean_expert_id	5222	active
140e69a7-b386-4f48-8e59-67283733db43	97da71e8-2ef4-4130-9ef7-7a6093e2cfa6	data_source	obis_oceanexpert	active
2da5cef3-3984-483d-a2e0-e17ca9966275	97da71e8-2ef4-4130-9ef7-7a6093e2cfa6	sync_date	2025-09-22	active
4b01e1ac-bd65-44e5-bd49-2c6dc9b3bf87	4efd84fb-5e9d-4720-a609-200cb1029874	ocean_expert_id	6110	active
4c50560f-2713-40b1-be41-1c7581c8e45c	4efd84fb-5e9d-4720-a609-200cb1029874	data_source	obis_oceanexpert	active
2ddaff88-30b2-4d92-8aae-5d3b05f2184d	4efd84fb-5e9d-4720-a609-200cb1029874	sync_date	2025-09-22	active
ac87ef7e-7cfc-4091-914d-40e191d84527	eec99556-493c-4cb8-a936-fca189a62cae	ocean_expert_id	18293	active
f480dc5a-b9c5-4f39-940e-31d3e3a9a425	eec99556-493c-4cb8-a936-fca189a62cae	data_source	obis_oceanexpert	active
3c8e94cb-eff4-42da-81e4-82bd757de9dd	eec99556-493c-4cb8-a936-fca189a62cae	sync_date	2025-09-22	active
9466246d-e004-4378-afe6-cec94dca9e73	33c501a0-0d47-4b52-ab11-0521c8ed1149	ocean_expert_id	19312	active
b3794539-3527-4af6-98cc-9446779b8778	33c501a0-0d47-4b52-ab11-0521c8ed1149	data_source	obis_oceanexpert	active
4dcff45f-518c-42be-8f9a-04ab300393b7	33c501a0-0d47-4b52-ab11-0521c8ed1149	sync_date	2025-09-22	active
1348d59c-1c8e-4d87-b438-8fa975b61ca6	4861c99c-6b53-4674-8134-78f0dfa0cd45	ocean_expert_id	16187	active
f5c6cd58-08e5-461e-9667-f30e97097b1a	4861c99c-6b53-4674-8134-78f0dfa0cd45	data_source	obis_oceanexpert	active
7b1981ee-9753-4734-8089-9f1a6db8c596	4861c99c-6b53-4674-8134-78f0dfa0cd45	sync_date	2025-09-22	active
28d15f8a-c985-48d5-b964-65c9402ba554	9de9e83a-dd8b-408f-a194-90e9945d13e3	ocean_expert_id	6749	active
3989d656-9f8c-496f-b231-54247085e797	9de9e83a-dd8b-408f-a194-90e9945d13e3	data_source	obis_oceanexpert	active
acd7d2bb-e910-4bd0-b82c-74b2bd8db3c1	9de9e83a-dd8b-408f-a194-90e9945d13e3	sync_date	2025-09-22	active
94092fa4-4374-4512-8292-31f6998f440e	c2400946-5534-4cf5-b5af-2f84beea12b3	ocean_expert_id	19301	active
40646f4d-a681-47db-8008-79037dfbea65	c2400946-5534-4cf5-b5af-2f84beea12b3	data_source	obis_oceanexpert	active
f4020c7f-2ac4-4f51-b188-d39ca9ad5e67	c2400946-5534-4cf5-b5af-2f84beea12b3	sync_date	2025-09-22	active
87708126-2278-456e-aca6-2e770837c6c0	16c09054-fef9-498b-93ba-e758ec693db0	ocean_expert_id	10957	active
90212964-0d0a-4019-b9fb-008ba8642262	16c09054-fef9-498b-93ba-e758ec693db0	data_source	obis_oceanexpert	active
800fdfe9-9141-4a83-b9a0-7695ee2c4a9a	16c09054-fef9-498b-93ba-e758ec693db0	sync_date	2025-09-22	active
ba052e7d-58d6-42b5-b985-f6cdba5572a9	98b88afe-c722-46cb-94ef-16d9c0bad789	ocean_expert_id	15531	active
8d8b16c4-51c9-4884-80ff-1f3a600b70fa	98b88afe-c722-46cb-94ef-16d9c0bad789	data_source	obis_oceanexpert	active
cf11d1be-80d9-4f4d-94b7-f369a4db77cc	98b88afe-c722-46cb-94ef-16d9c0bad789	sync_date	2025-09-22	active
136601a8-3ede-49ea-b3bb-46149ff44b9b	f95cc150-edd8-4c05-9993-e85d4818f643	ocean_expert_id	23193	active
74eb181c-af0a-4114-b643-76d7c06d1299	f95cc150-edd8-4c05-9993-e85d4818f643	data_source	obis_oceanexpert	active
8902fda4-0d21-44f3-ace3-c3cab966e7ab	f95cc150-edd8-4c05-9993-e85d4818f643	sync_date	2025-09-22	active
bb3ef0bd-3e63-4968-a86a-06db3f4b9746	e4f66786-d8a0-41bd-a73d-6007f356a245	ocean_expert_id	16705	active
b15a945c-b995-4b68-913c-998d4e932d02	e4f66786-d8a0-41bd-a73d-6007f356a245	data_source	obis_oceanexpert	active
a38e8c92-7d89-4a87-a7ff-a3b2d16d5b11	e4f66786-d8a0-41bd-a73d-6007f356a245	sync_date	2025-09-22	active
252caf23-1bba-4d81-8daf-8681e294a81f	cc724260-7325-4707-b8f2-24989b4b6b04	ocean_expert_id	5899	active
57cbb059-d1b8-416c-ac97-e82c3d4811e1	cc724260-7325-4707-b8f2-24989b4b6b04	data_source	obis_oceanexpert	active
d9240287-b4ab-49f9-83dc-b83b9ede36a6	cc724260-7325-4707-b8f2-24989b4b6b04	sync_date	2025-09-22	active
01bef14f-55e1-4f8e-afe0-f2b25062a617	247d7f49-f4eb-4992-8266-566b930bfd93	ocean_expert_id	15539	active
4916e5b1-a7cd-4a89-ab27-5e98e09fd2a7	247d7f49-f4eb-4992-8266-566b930bfd93	data_source	obis_oceanexpert	active
4f835d0a-ae05-4a25-9b4c-97749c89256d	247d7f49-f4eb-4992-8266-566b930bfd93	sync_date	2025-09-22	active
6fe8825b-ea85-4635-97ea-c3d2cc7e7a3d	86859ff8-d542-4199-96f3-5643a144b409	ocean_expert_id	19634	active
19d557bc-77e4-485a-94d4-3ed7ec978051	86859ff8-d542-4199-96f3-5643a144b409	data_source	obis_oceanexpert	active
3e6dcdec-b98a-4e97-b1cd-e5268ac1aa71	86859ff8-d542-4199-96f3-5643a144b409	sync_date	2025-09-22	active
17a7ffbc-feae-4ab0-a437-8014af0f5f08	d265acf8-05f0-40ef-893f-54fda0e6e435	ocean_expert_id	19321	active
48578f58-4728-4680-8bc1-31ea160501e8	d265acf8-05f0-40ef-893f-54fda0e6e435	data_source	obis_oceanexpert	active
db7d0bff-40af-4a3d-bc58-214e20bc1b0d	d265acf8-05f0-40ef-893f-54fda0e6e435	sync_date	2025-09-22	active
992464a3-5dd3-47a2-b75b-95a604d352bb	9e150867-6f43-4b7d-96e0-3bd895916154	ocean_expert_id	18077	active
d80d00be-d7d1-4b99-969c-1ed2bc7158ba	9e150867-6f43-4b7d-96e0-3bd895916154	data_source	obis_oceanexpert	active
c3a59940-96c0-44b8-beb7-7534bdccc896	9e150867-6f43-4b7d-96e0-3bd895916154	sync_date	2025-09-22	active
2d821095-594e-4126-bf45-dcb71a287f91	5f4afc28-fddd-470e-9b95-8a994031d8f3	ocean_expert_id	11132	active
f0cbcc49-1943-4c15-9498-af217c320b90	5f4afc28-fddd-470e-9b95-8a994031d8f3	data_source	obis_oceanexpert	active
004a5843-4448-4a96-92ed-aa903bcd2e93	5f4afc28-fddd-470e-9b95-8a994031d8f3	sync_date	2025-09-22	active
bb0eec64-365c-4162-a5a9-0f6762839436	b73ebe41-513e-40b0-aaf6-db43312af36d	ocean_expert_id	20121	active
5d6bc8e4-7965-4223-b7dc-2d8423260ca5	b73ebe41-513e-40b0-aaf6-db43312af36d	data_source	obis_oceanexpert	active
ff2195ce-f72d-4ca3-a792-f45fd40bfabf	b73ebe41-513e-40b0-aaf6-db43312af36d	sync_date	2025-09-22	active
2cdd72b3-272c-4a18-83e3-d28a01abfd74	8f56f7d5-1936-4492-8451-c957075738b0	ocean_expert_id	23206	active
42a80622-6b9f-465d-85c7-43d4a525e856	8f56f7d5-1936-4492-8451-c957075738b0	data_source	obis_oceanexpert	active
3976d4e6-ff46-4e04-9487-591a43e044b1	8f56f7d5-1936-4492-8451-c957075738b0	sync_date	2025-09-22	active
693db904-8860-4591-a507-34267b9bb6d3	7db51825-df14-4cb3-8bb5-c3f2f6a7eb5a	ocean_expert_id	19317	active
c61a1c5a-426e-4cdb-ac0b-3391dfad5070	7db51825-df14-4cb3-8bb5-c3f2f6a7eb5a	data_source	obis_oceanexpert	active
c9f4bdcb-3752-458f-a830-1afd69fc4c91	7db51825-df14-4cb3-8bb5-c3f2f6a7eb5a	sync_date	2025-09-22	active
9d1cb875-22e4-4ae3-b4e3-e1d178ca9892	e4315c27-31f4-4e8c-acc7-8a43755e1370	ocean_expert_id	18841	active
62a5f863-a0f3-49f1-88ea-b9d26fe82826	e4315c27-31f4-4e8c-acc7-8a43755e1370	data_source	obis_oceanexpert	active
5d9c383c-5e25-4e26-861a-b1015bad4b82	e4315c27-31f4-4e8c-acc7-8a43755e1370	sync_date	2025-09-22	active
323235dd-4eea-43b8-ac0e-58d79c017dd0	a25d5eaf-775e-4d23-a215-c7c6c8447365	ocean_expert_id	19273	active
9183c3a5-a77d-43be-90b8-d751ff4700cd	a25d5eaf-775e-4d23-a215-c7c6c8447365	data_source	obis_oceanexpert	active
76d24b22-95ed-4a8f-afba-9fdb003ddf64	a25d5eaf-775e-4d23-a215-c7c6c8447365	sync_date	2025-09-22	active
a3bb102b-1e4c-4757-9615-1bd99289bc49	eb5171b4-dcb3-48e4-a3dd-8bb7d3a99c5b	ocean_expert_id	18755	active
f58556fa-81ed-4b0a-a768-c4f3fad279f5	eb5171b4-dcb3-48e4-a3dd-8bb7d3a99c5b	data_source	obis_oceanexpert	active
4043cf05-5401-45ed-b6bc-dd2d9e30df73	eb5171b4-dcb3-48e4-a3dd-8bb7d3a99c5b	sync_date	2025-09-22	active
27ed55b3-0aab-4a51-a02c-305d38b35e3f	ab4fc39b-575d-4421-9ec0-8e8cd90cadeb	ocean_expert_id	6970	active
fb3dfeab-33e4-48a3-9865-cc11d5a3ead2	ab4fc39b-575d-4421-9ec0-8e8cd90cadeb	data_source	obis_oceanexpert	active
feecf585-8109-473b-befd-2ebcc3afe280	ab4fc39b-575d-4421-9ec0-8e8cd90cadeb	sync_date	2025-09-22	active
3752c84b-c417-4952-bee5-418ea341c6fe	750c7541-d48a-4f99-8f6c-2775a02b0572	ocean_expert_id	19431	active
d5059204-e545-49f5-8510-e4719082d2ab	750c7541-d48a-4f99-8f6c-2775a02b0572	data_source	obis_oceanexpert	active
e1f9e6a5-5e64-40d7-8c7e-decef447a794	750c7541-d48a-4f99-8f6c-2775a02b0572	sync_date	2025-09-22	active
423f8763-e9e2-42cc-b9ab-5f260b001ee3	8c7473b5-a75b-4e6e-b1dd-3a06a296b656	ocean_expert_id	19338	active
7241186f-d413-498a-88a6-d6a87eebfbc4	8c7473b5-a75b-4e6e-b1dd-3a06a296b656	data_source	obis_oceanexpert	active
2f2f6f50-bbea-47f4-b5c8-e052f063bea3	8c7473b5-a75b-4e6e-b1dd-3a06a296b656	sync_date	2025-09-22	active
fc70abe4-1298-4fbd-9f7d-8978008fa7ae	7d6c7a83-5ae8-4cdc-b96f-ad40114917ca	ocean_expert_id	19300	active
e59cde05-11a6-4d85-b75c-59635f4601f5	7d6c7a83-5ae8-4cdc-b96f-ad40114917ca	data_source	obis_oceanexpert	active
a55b9693-4a49-4f93-b5f3-6a28cb503204	7d6c7a83-5ae8-4cdc-b96f-ad40114917ca	sync_date	2025-09-22	active
93911adb-4c4d-44eb-87c3-fd3d744e8b9e	b6700fd3-827c-4560-9366-e8fad31cccf3	ocean_expert_id	9550	active
0d765883-5197-40db-8e9b-afe1ec190e76	b6700fd3-827c-4560-9366-e8fad31cccf3	data_source	obis_oceanexpert	active
b23d3bd5-88c8-40e1-aeff-353b51048165	b6700fd3-827c-4560-9366-e8fad31cccf3	sync_date	2025-09-22	active
f4a9d9c9-0ccf-4cd6-b2d2-94e7801c2b9a	53f56e02-066f-45a9-8d29-ba7c19567d47	ocean_expert_id	19358	active
82891aa5-b19e-47fb-b2f3-f1bfa7abb74e	53f56e02-066f-45a9-8d29-ba7c19567d47	data_source	obis_oceanexpert	active
75278266-0801-40b0-813f-f0a54165402a	53f56e02-066f-45a9-8d29-ba7c19567d47	sync_date	2025-09-22	active
d6309da7-0fb5-4d94-9e18-ed4f1aa8ad46	b1943950-4d4c-4b47-9ee4-d287b4d97863	ocean_expert_id	7227	active
03aa3d0e-fdf7-4465-9a46-6e6b011ff7ce	b1943950-4d4c-4b47-9ee4-d287b4d97863	data_source	obis_oceanexpert	active
92d9e973-ff9d-43f7-98ee-b8c1d54f380d	b1943950-4d4c-4b47-9ee4-d287b4d97863	sync_date	2025-09-22	active
63e89bbe-e787-4728-93ae-9be3bed48f33	a69bda88-d70a-45e3-9405-b2bf6749d7a3	ocean_expert_id	23207	active
98a803ee-c77d-4a9a-a138-b8225b57f9fb	a69bda88-d70a-45e3-9405-b2bf6749d7a3	data_source	obis_oceanexpert	active
a53a88b8-d441-44f0-8666-e5a13269ef9d	a69bda88-d70a-45e3-9405-b2bf6749d7a3	sync_date	2025-09-22	active
bf61da00-10ba-4e06-bdb9-bbabc752c1d5	23561cf1-9650-45d8-b728-9b7d3ec0e512	ocean_expert_id	20908	active
d64f8503-10a0-4e5a-afe7-94420f552af8	23561cf1-9650-45d8-b728-9b7d3ec0e512	data_source	obis_oceanexpert	active
e2981065-2cd5-4667-b3cc-37b676ad6bad	23561cf1-9650-45d8-b728-9b7d3ec0e512	sync_date	2025-09-22	active
ef7e2b2b-aee2-478c-826f-57e03f978286	d69a857b-28c0-4d05-aa49-af58910b8731	ocean_expert_id	15961	active
b9d32684-62c8-45d4-9385-c3e205f8c058	d69a857b-28c0-4d05-aa49-af58910b8731	data_source	obis_oceanexpert	active
f3e1aae3-ee03-4d23-8d22-8d6c954fcef1	d69a857b-28c0-4d05-aa49-af58910b8731	sync_date	2025-09-22	active
a50ea037-369c-421b-a4b4-429663580904	6aa22741-c9e7-466a-80e3-b1795f322c3a	ocean_expert_id	6581	active
b3ee3851-d112-499f-b31a-a2d8be9a1064	6aa22741-c9e7-466a-80e3-b1795f322c3a	data_source	obis_oceanexpert	active
66a5bf63-fcb6-4311-8476-b59967aa4378	6aa22741-c9e7-466a-80e3-b1795f322c3a	sync_date	2025-09-22	active
2b142284-e46b-43ce-8612-9bd2b8a2f08c	787a1240-3ed9-4cb0-9e3e-6718c2f5c710	ocean_expert_id	5711	active
3062a1e9-87c7-492d-8590-d1d472033cfd	787a1240-3ed9-4cb0-9e3e-6718c2f5c710	data_source	obis_oceanexpert	active
854618f8-3683-455b-825d-e36d57094430	787a1240-3ed9-4cb0-9e3e-6718c2f5c710	sync_date	2025-09-22	active
15af0ba9-ac6e-468a-bbfe-89f15a86cdda	784ccd58-c05b-407c-88cf-dc302be8050d	ocean_expert_id	19370	active
bfdb31f8-4367-4d38-a416-5ce46c795b5f	784ccd58-c05b-407c-88cf-dc302be8050d	data_source	obis_oceanexpert	active
f85907a8-5500-4b33-a8f7-26852a63fdb5	784ccd58-c05b-407c-88cf-dc302be8050d	sync_date	2025-09-22	active
7b659534-7ea8-4ad1-aadf-930ff6b6e06d	437da419-407c-41dd-a578-14154a75617f	ocean_expert_id	20909	active
4d658bac-2ce1-4485-947f-17448e089597	437da419-407c-41dd-a578-14154a75617f	data_source	obis_oceanexpert	active
c3a3f0c3-a923-483c-b84b-81e0e9ff9aed	437da419-407c-41dd-a578-14154a75617f	sync_date	2025-09-22	active
44bdbe07-b773-4b38-94ac-5e8671e7422e	4b73dd5c-401b-48d9-8cf9-d327566524d6	ocean_expert_id	8299	active
a8b982a3-81d2-4ee1-98a4-7ea0abc9b535	4b73dd5c-401b-48d9-8cf9-d327566524d6	data_source	obis_oceanexpert	active
ff93936e-cdd3-420c-9491-a615bcbd763e	4b73dd5c-401b-48d9-8cf9-d327566524d6	sync_date	2025-09-22	active
2d3dad8e-2e42-4736-95db-04063ce0bbb7	96b1c050-93a4-4ac0-8050-2471bb072d66	ocean_expert_id	19410	active
bd1a0ac7-2d59-40a3-a149-0eef4159791a	96b1c050-93a4-4ac0-8050-2471bb072d66	data_source	obis_oceanexpert	active
0c5306b6-dbed-46cc-ab72-136d44d5baea	96b1c050-93a4-4ac0-8050-2471bb072d66	sync_date	2025-09-22	active
61dcbe1b-0466-4388-be11-173d43b6eb0b	896bf7f3-ff8c-4a5a-a064-e44dc6fe2e06	ocean_expert_id	20186	active
87f07d90-a46f-4910-8fb4-c9113a2082e0	896bf7f3-ff8c-4a5a-a064-e44dc6fe2e06	data_source	obis_oceanexpert	active
138b681d-9bce-4332-b2bd-bee1a87072e5	896bf7f3-ff8c-4a5a-a064-e44dc6fe2e06	sync_date	2025-09-22	active
181bacc5-f1ff-4bb3-8aee-fd6acec2a9f5	800cf29d-6348-4644-8584-20f8eeb2f68c	data_source	obis_oceanexpert	active
1df7fbf8-c549-4437-95a4-afe880c3179d	800cf29d-6348-4644-8584-20f8eeb2f68c	sync_date	2025-09-22	active
b32171bc-bfb1-4b91-b6ef-542d5de31138	0b8d19bb-d4a2-48a4-88c6-edf90b2a6793	ocean_expert_id	8668	active
520960a9-0dfa-42ca-85dc-db6e3aed007b	0b8d19bb-d4a2-48a4-88c6-edf90b2a6793	data_source	obis_oceanexpert	active
c60450de-07f9-4509-877b-1f2405bb2f62	0b8d19bb-d4a2-48a4-88c6-edf90b2a6793	sync_date	2025-09-22	active
653e707a-2ea8-4f02-b58d-01ca8df2cfa1	695cf72a-771d-4ae1-bd07-707bf4147ea8	ocean_expert_id	17021	active
aae8a590-5e6d-4634-b4c7-0634d84bf64b	695cf72a-771d-4ae1-bd07-707bf4147ea8	data_source	obis_oceanexpert	active
032712f9-f8f1-4ef4-a1e5-cba1c8e752f2	695cf72a-771d-4ae1-bd07-707bf4147ea8	sync_date	2025-09-22	active
67c3e6ee-dad3-49ef-b0dd-01d334fa9134	64408501-8ded-4236-b0a5-e4cc1fad2987	ocean_expert_id	13003	active
472ce609-f9f9-4e2d-bfc5-184560e10b99	64408501-8ded-4236-b0a5-e4cc1fad2987	data_source	obis_oceanexpert	active
87732a2a-03f7-47ed-be79-312d1aace615	64408501-8ded-4236-b0a5-e4cc1fad2987	sync_date	2025-09-22	active
9c341ea2-5900-4219-9043-a882266fa790	5140454a-8995-46ef-b886-89a28020afbd	ocean_expert_id	14932	active
4815e0e1-a2b8-49d2-9cec-a9893fd66d5f	5140454a-8995-46ef-b886-89a28020afbd	data_source	obis_oceanexpert	active
cab5536d-1fc2-4a47-a1a8-9fad23ccc116	5140454a-8995-46ef-b886-89a28020afbd	sync_date	2025-09-22	active
bb659874-9ec2-4fc4-8bcd-95ac0ccdf4b1	e55040d3-0f68-484d-9b8a-0d437de16e0c	ocean_expert_id	6271	active
78e3a771-4b29-4f71-be16-521ab2e77991	e55040d3-0f68-484d-9b8a-0d437de16e0c	data_source	obis_oceanexpert	active
44d9998c-974f-4ab3-ad63-152a36425d4f	e55040d3-0f68-484d-9b8a-0d437de16e0c	sync_date	2025-09-22	active
01a3313b-27aa-402e-9527-8cfa48f31c10	0e481ec9-4c62-4a03-a1e3-e52fd7e17a35	ocean_expert_id	5836	active
8ecd7714-1abd-44c6-9dbd-93202596f2f4	0e481ec9-4c62-4a03-a1e3-e52fd7e17a35	data_source	obis_oceanexpert	active
aa438daa-5cbd-4bed-ad89-7a011f3518f2	0e481ec9-4c62-4a03-a1e3-e52fd7e17a35	sync_date	2025-09-22	active
2922ea6f-f161-45e1-805d-ecc281f46f9d	d6a9c63b-7de9-4876-b619-97274fddf870	ocean_expert_id	11797	active
6e70542f-1d73-4513-adec-01296a6e3fb1	d6a9c63b-7de9-4876-b619-97274fddf870	data_source	obis_oceanexpert	active
21267870-f5b1-4e3f-82d9-2577efe24519	d6a9c63b-7de9-4876-b619-97274fddf870	sync_date	2025-09-22	active
0413d930-fcc4-470f-a86a-35933c66a297	3043933b-6f03-460b-a889-f93e8115fb4a	ocean_expert_id	19418	active
c82e6bb2-6aad-4e18-87ee-a7c18f97b4ed	3043933b-6f03-460b-a889-f93e8115fb4a	data_source	obis_oceanexpert	active
b5d9534c-16ab-470e-aff3-62329c7a5c67	3043933b-6f03-460b-a889-f93e8115fb4a	sync_date	2025-09-22	active
f5fec54d-d38c-4d1f-a1be-45bb77fc547d	d4d01d14-725a-40a0-96f0-a48acbc0be97	ocean_expert_id	18797	active
88930e5d-1f8d-49a9-94ce-533895c7974e	d4d01d14-725a-40a0-96f0-a48acbc0be97	data_source	obis_oceanexpert	active
119067de-23c7-4721-abfd-bdd75386089b	d4d01d14-725a-40a0-96f0-a48acbc0be97	sync_date	2025-09-22	active
4a4f535c-8f06-4092-92ef-bd9d55149d7f	94cbac79-581a-4546-b820-f38d651f2250	ocean_expert_id	21659	active
ad7c4344-f39c-4264-96b9-156b823c1434	94cbac79-581a-4546-b820-f38d651f2250	data_source	obis_oceanexpert	active
c21c4e6c-03b8-4733-ba73-8046e023fdfe	94cbac79-581a-4546-b820-f38d651f2250	sync_date	2025-09-22	active
27ba0324-b2db-4a6a-9a83-04a78bf7737a	6c046ca7-3a9d-4914-9e99-7c712510762f	ocean_expert_id	19412	active
d8e3abf4-ad31-4c3c-a6d7-533f475e208d	6c046ca7-3a9d-4914-9e99-7c712510762f	data_source	obis_oceanexpert	active
870ad927-3d58-4df8-beb3-68f135c12111	6c046ca7-3a9d-4914-9e99-7c712510762f	sync_date	2025-09-22	active
06042572-99d8-4dfc-8eea-e2378aeae0cf	ec3ae82c-2467-4ccf-a1de-8da8c76f7ff1	ocean_expert_id	6741	active
fd320b1b-13a0-4067-b972-67e19c6ce685	ec3ae82c-2467-4ccf-a1de-8da8c76f7ff1	data_source	obis_oceanexpert	active
d040792f-5bb0-4023-a549-39a086d3ba61	ec3ae82c-2467-4ccf-a1de-8da8c76f7ff1	sync_date	2025-09-22	active
a52f1ecc-1f0f-4c2b-a1ce-dbd578d97996	5edc05dd-7b0e-4e73-8d3c-866f00563324	ocean_expert_id	19588	active
2c77cada-44ec-4e73-a50b-7057602c9249	5edc05dd-7b0e-4e73-8d3c-866f00563324	data_source	obis_oceanexpert	active
98f02bfa-a2e7-4297-b558-76573d3ab161	5edc05dd-7b0e-4e73-8d3c-866f00563324	sync_date	2025-09-22	active
0c79bcc1-cab0-4185-a0bf-4459a318edf2	11758483-b1ff-4869-b808-7bef397d68b9	ocean_expert_id	7503	active
a774197c-88f4-49e8-9490-bb37de47e9fe	11758483-b1ff-4869-b808-7bef397d68b9	data_source	obis_oceanexpert	active
4bf39506-bcf1-48ed-9b8f-ea0d3562b391	11758483-b1ff-4869-b808-7bef397d68b9	sync_date	2025-09-22	active
bedb020c-d609-43ec-ba90-f4ead3c291df	78e0b382-6a4a-4b5d-be80-4816ae16c03d	ocean_expert_id	17339	active
7ed4c956-c285-4fcd-b9f8-e0b06030a36c	78e0b382-6a4a-4b5d-be80-4816ae16c03d	data_source	obis_oceanexpert	active
4e0c5f6d-190d-4e0c-9a82-d9a1c4869510	78e0b382-6a4a-4b5d-be80-4816ae16c03d	sync_date	2025-09-22	active
0ef25882-4922-43dd-b496-73ab8c85cf82	7a8c235e-d4cc-44df-a8d8-79cfade6dadd	ocean_expert_id	19294	active
f029d585-4e00-42b1-bb9a-4a85457fc5a7	7a8c235e-d4cc-44df-a8d8-79cfade6dadd	data_source	obis_oceanexpert	active
e45987c3-bf04-450d-9ba6-730997f759fb	7a8c235e-d4cc-44df-a8d8-79cfade6dadd	sync_date	2025-09-22	active
b394b6b9-49f3-4d7c-bbc7-8e0bb2958c9e	2d23e7f7-8ff0-40c8-af6e-71908729ea59	ocean_expert_id	19561	active
97b7e63c-5f7a-4f2e-b8c2-3ce069fd766f	2d23e7f7-8ff0-40c8-af6e-71908729ea59	data_source	obis_oceanexpert	active
ca7c3862-8721-424e-8660-9d100ce052a4	2d23e7f7-8ff0-40c8-af6e-71908729ea59	sync_date	2025-09-22	active
79d022a4-11b9-47dc-9d90-ceba547e7133	6dbd818e-9ec6-4a49-9ec7-403161a3daff	ocean_expert_id	11578	active
369661d1-c327-4c17-b6e9-c93422bb6da0	6dbd818e-9ec6-4a49-9ec7-403161a3daff	data_source	obis_oceanexpert	active
7bb34f6b-8bce-4365-a858-c8f80769fa29	6dbd818e-9ec6-4a49-9ec7-403161a3daff	sync_date	2025-09-22	active
4bcb6e1d-ba35-4f49-a658-71f672df96b3	2b52d11f-0b8a-4189-84b3-28d5a6bedd4e	ocean_expert_id	18364	active
291b5362-81c0-439b-9806-204d6f991a64	2b52d11f-0b8a-4189-84b3-28d5a6bedd4e	data_source	obis_oceanexpert	active
a938288f-24f9-4f75-909b-a8183869f6af	2b52d11f-0b8a-4189-84b3-28d5a6bedd4e	sync_date	2025-09-22	active
d9c0b2e6-7038-41ee-a387-8138227c1655	e1c1b14f-d7d9-4341-93ef-b4e958cfeef5	ocean_expert_id	6717	active
990e01c5-a528-4861-8698-e71ddf3c2aa6	e1c1b14f-d7d9-4341-93ef-b4e958cfeef5	data_source	obis_oceanexpert	active
9533e9cf-65f9-4814-87a8-a9b5addf1596	e1c1b14f-d7d9-4341-93ef-b4e958cfeef5	sync_date	2025-09-22	active
561ab682-a10c-43f8-9412-5a4e6b941b0a	f33c3fdb-fb5a-4423-9853-6de85c21eaf7	ocean_expert_id	6759	active
27ba5b92-61f6-48ef-aefe-34398dd471c4	f33c3fdb-fb5a-4423-9853-6de85c21eaf7	data_source	obis_oceanexpert	active
92fd5233-0343-4e72-a933-decc143e05ee	f33c3fdb-fb5a-4423-9853-6de85c21eaf7	sync_date	2025-09-22	active
6b3dbcdd-d56b-47fc-8e8d-39120431c04e	8208125a-decf-4f71-9ee5-cabc48336ee8	ocean_expert_id	19601	active
88905d91-deaa-4e07-a3aa-9eddae2e9ccf	8208125a-decf-4f71-9ee5-cabc48336ee8	data_source	obis_oceanexpert	active
23851c21-41e4-4458-aebe-5d3400bf6e6a	8208125a-decf-4f71-9ee5-cabc48336ee8	sync_date	2025-09-22	active
8e7f93db-6b12-46be-a661-665a619f9cde	4950329a-ec0d-45f2-8728-16e312f54480	ocean_expert_id	19626	active
181d03f2-f7a9-4a09-be0f-a5c17060d117	4950329a-ec0d-45f2-8728-16e312f54480	data_source	obis_oceanexpert	active
045c0133-a4bf-4e99-8fd8-2f5e7d52e105	4950329a-ec0d-45f2-8728-16e312f54480	sync_date	2025-09-22	active
62c9122b-b4ba-4364-912c-32000aa1aac9	c4c09832-10d1-4b07-baf9-9dbafbf8039e	ocean_expert_id	8450	active
aeef5da5-458f-4f3f-a1ef-db7c270a623a	c4c09832-10d1-4b07-baf9-9dbafbf8039e	data_source	obis_oceanexpert	active
e0aa2584-3357-4a6a-9f49-cb43026e33ab	c4c09832-10d1-4b07-baf9-9dbafbf8039e	sync_date	2025-09-22	active
7b390ec7-ec1e-4971-a0a6-44adbf058a5c	4c737d42-3faa-4c48-8946-0bc77f024ecd	ocean_expert_id	19580	active
6aac76db-be3a-4c50-b9e1-c74224b5056d	4c737d42-3faa-4c48-8946-0bc77f024ecd	data_source	obis_oceanexpert	active
f4e9efa1-8474-4c5f-9013-86b8384367b1	4c737d42-3faa-4c48-8946-0bc77f024ecd	sync_date	2025-09-22	active
02c27231-3d3b-4549-aeda-3dbb0dcf7cb8	d004b51b-2ed5-4a73-893c-358861e80bed	ocean_expert_id	5804	active
08f21d12-2804-4241-8736-71b1901e09e0	d004b51b-2ed5-4a73-893c-358861e80bed	data_source	obis_oceanexpert	active
355bc82a-f900-482e-963a-e542074dd45a	d004b51b-2ed5-4a73-893c-358861e80bed	sync_date	2025-09-22	active
5b6d92ee-6eeb-432b-bceb-63d26bad19a9	dfb7a014-0e42-4e48-83aa-bc26cc28f163	ocean_expert_id	18303	active
079f585d-a9fb-45c4-91bd-41d10edf6194	dfb7a014-0e42-4e48-83aa-bc26cc28f163	data_source	obis_oceanexpert	active
d54da937-dac7-4a15-abca-4c6b4b2d7042	dfb7a014-0e42-4e48-83aa-bc26cc28f163	sync_date	2025-09-22	active
0d184f64-2b74-407e-a520-b3eac49b5cb7	a4cb7546-84c4-4d48-be51-07acdfd0c52d	ocean_expert_id	5122	active
24b1e0d3-afc1-437e-b9f9-6e12baf936d3	a4cb7546-84c4-4d48-be51-07acdfd0c52d	data_source	obis_oceanexpert	active
dee1b400-9825-4e4d-95e6-1bf7055e4afc	a4cb7546-84c4-4d48-be51-07acdfd0c52d	sync_date	2025-09-22	active
075c193c-3c52-454f-9eb4-a33eff0c3fc5	65ae22f8-78da-48de-b395-ef8a054117f5	ocean_expert_id	6238	active
ab5f9abb-f712-437a-842e-80ba4beb2b23	65ae22f8-78da-48de-b395-ef8a054117f5	data_source	obis_oceanexpert	active
43e07897-1e16-4210-9f40-9f7c5e3e7f6b	65ae22f8-78da-48de-b395-ef8a054117f5	sync_date	2025-09-22	active
f7c340e1-87ef-4d56-a080-44c6535bd02a	8e802012-99d8-4029-b6d2-3aab7d633045	ocean_expert_id	19471	active
9a3d8763-9a25-4925-917b-5f210edbd5ef	8e802012-99d8-4029-b6d2-3aab7d633045	data_source	obis_oceanexpert	active
5bc85c88-d5d2-464f-a569-19b7da8eee7d	8e802012-99d8-4029-b6d2-3aab7d633045	sync_date	2025-09-22	active
8726d078-0da4-45f8-9c37-43e7165c982a	b3873ace-2e25-4610-be44-677538dccf32	ocean_expert_id	10708	active
b5a01088-4ab5-4874-ac80-61c92422aef5	b3873ace-2e25-4610-be44-677538dccf32	data_source	obis_oceanexpert	active
5f6a1121-be69-4753-b871-8caacfeae99a	b3873ace-2e25-4610-be44-677538dccf32	sync_date	2025-09-22	active
6dd0f6eb-0e9b-4136-b204-2ce4d290632b	a563a3d3-0e3c-4fc8-895b-6c022c853670	ocean_expert_id	20413	active
edf40a83-6ca7-4385-9135-f917d5529ccf	a563a3d3-0e3c-4fc8-895b-6c022c853670	data_source	obis_oceanexpert	active
837d2b5c-84dc-4262-a34b-49b6c9c0afab	a563a3d3-0e3c-4fc8-895b-6c022c853670	sync_date	2025-09-22	active
6dbbcff7-e29c-43d7-8e36-b65850cbfeec	7924147f-5b51-49c0-a1e7-3c52d0b7f8a8	ocean_expert_id	7581	active
275fde3c-4f7a-48d3-bde3-c8cf16d9206d	7924147f-5b51-49c0-a1e7-3c52d0b7f8a8	data_source	obis_oceanexpert	active
273c0f32-0a9f-44f3-93c7-19cf9a587000	7924147f-5b51-49c0-a1e7-3c52d0b7f8a8	sync_date	2025-09-22	active
5a7b9673-8639-4b13-87ef-e82d0ba401ad	033d95ac-20c8-4586-89ac-6d417d20cd5a	ocean_expert_id	19609	active
e2c61438-86be-4d83-8d1a-9c736d58f5a2	033d95ac-20c8-4586-89ac-6d417d20cd5a	data_source	obis_oceanexpert	active
dfd5a5fc-8101-432d-ad75-ca7615bd468a	033d95ac-20c8-4586-89ac-6d417d20cd5a	sync_date	2025-09-22	active
bbdab533-5cb6-4533-bda6-9a95fdbabd53	0675a51b-6cc9-4cd6-bc0a-fc74fe13751a	ocean_expert_id	19371	active
a7950356-24d9-4851-ba4f-2cfd5763640a	0675a51b-6cc9-4cd6-bc0a-fc74fe13751a	data_source	obis_oceanexpert	active
0ff695db-6dd5-424a-a9f4-b656608d7fb3	0675a51b-6cc9-4cd6-bc0a-fc74fe13751a	sync_date	2025-09-22	active
697a318f-de0e-42c3-b971-38915f2dc98f	d38658b9-6bd5-4b0b-969f-63aeff3e2132	ocean_expert_id	19430	active
d1fc8dee-c674-438b-9c26-0290b4dab0eb	d38658b9-6bd5-4b0b-969f-63aeff3e2132	data_source	obis_oceanexpert	active
8e5242c6-d710-4cd6-9334-29c540d1c34e	d38658b9-6bd5-4b0b-969f-63aeff3e2132	sync_date	2025-09-22	active
7f122df8-70d6-4a49-a172-520a0667d04c	54bb88ce-067f-4742-a38f-d9de6aa67991	ocean_expert_id	9824	active
5accf821-0057-445a-a6cc-c6caffd5b756	54bb88ce-067f-4742-a38f-d9de6aa67991	data_source	obis_oceanexpert	active
77401fa7-873f-4f51-8fac-d3e4604aeda0	54bb88ce-067f-4742-a38f-d9de6aa67991	sync_date	2025-09-22	active
6c349806-143e-4653-bf38-a6b617630983	167b8f8d-d89e-4f9c-905b-25c67d1a792b	ocean_expert_id	18363	active
c13ebaae-84ed-4d78-9363-8583c6c9c5b1	167b8f8d-d89e-4f9c-905b-25c67d1a792b	data_source	obis_oceanexpert	active
c3dcd66a-9f4b-45ad-8c0d-64df676d7af3	167b8f8d-d89e-4f9c-905b-25c67d1a792b	sync_date	2025-09-22	active
412ba9b3-b8f7-4e8b-8f05-3d9f5637ff18	2fdf01ab-1278-49db-9f8c-223c8d61d0ec	ocean_expert_id	21369	active
6762e359-cfc6-483a-a1eb-7cb116ffe613	2fdf01ab-1278-49db-9f8c-223c8d61d0ec	data_source	obis_oceanexpert	active
db38719f-b9a7-4e39-9d80-47fa8b9c6e9a	2fdf01ab-1278-49db-9f8c-223c8d61d0ec	sync_date	2025-09-22	active
4ff94df8-42aa-48bd-88f8-a019536110bc	32c00f85-c3ca-4872-8d94-61ec822f042e	ocean_expert_id	5852	active
c29b69c7-3eec-4afe-85e5-9e9f8defb3a3	32c00f85-c3ca-4872-8d94-61ec822f042e	data_source	obis_oceanexpert	active
bff90b9f-beee-48d2-8017-df86b691fbd1	32c00f85-c3ca-4872-8d94-61ec822f042e	sync_date	2025-09-22	active
99fd62bd-44b6-40b5-8fea-25a0cee67714	8518d6b4-e106-469b-9cb8-06abe0fc2b55	ocean_expert_id	23184	active
cb8e9d7b-47b3-48a7-9469-bd68ea3742d6	8518d6b4-e106-469b-9cb8-06abe0fc2b55	data_source	obis_oceanexpert	active
c4afad0d-a95b-4d53-b40e-f4444f7dd34c	8518d6b4-e106-469b-9cb8-06abe0fc2b55	sync_date	2025-09-22	active
a505fd4f-6670-45ba-8173-7c2daf247e2a	800762c8-d262-4992-9683-fb5f1aff2c1c	ocean_expert_id	18663	active
7aa3c55e-b658-4b8e-809b-e3af51590a90	800762c8-d262-4992-9683-fb5f1aff2c1c	data_source	obis_oceanexpert	active
c1b0f9ac-ed4d-4286-9d8a-c29f33a29315	800762c8-d262-4992-9683-fb5f1aff2c1c	sync_date	2025-09-22	active
f146dbd2-8e24-439a-aa21-d52f4c47bd29	7274e8ed-e151-45ae-9d36-bdd1aaaa3c02	ocean_expert_id	23189	active
f768d2e8-68c4-4cc0-a2cf-597bfccc8735	7274e8ed-e151-45ae-9d36-bdd1aaaa3c02	data_source	obis_oceanexpert	active
701121ca-342b-4ca9-935d-bed05a431b87	7274e8ed-e151-45ae-9d36-bdd1aaaa3c02	sync_date	2025-09-22	active
7557de16-73c0-464b-b8ef-a497ecd17adf	14301816-4f12-486b-8f7c-06a95ed5011b	ocean_expert_id	8603	active
03a1366a-90eb-49de-b831-855ef5e88dc2	14301816-4f12-486b-8f7c-06a95ed5011b	data_source	obis_oceanexpert	active
14b325de-8884-4931-9329-c478f46aa175	14301816-4f12-486b-8f7c-06a95ed5011b	sync_date	2025-09-22	active
fec24781-998f-4be5-95c0-435bc6d1ad18	52d7435b-c1ee-45e1-8c37-109eb4d7c6ff	ocean_expert_id	7485	active
77b312fa-bd0e-4e22-b83c-f03c11aff420	52d7435b-c1ee-45e1-8c37-109eb4d7c6ff	data_source	obis_oceanexpert	active
ca485eb2-7c6b-4afe-a563-ae314f2746b3	52d7435b-c1ee-45e1-8c37-109eb4d7c6ff	sync_date	2025-09-22	active
cb9fafba-bc4e-463a-8500-05c966040929	9473a245-2c00-459a-a9a4-5101643f96c5	ocean_expert_id	19474	active
85eb5027-92c1-4a15-a133-7b14d8734e8f	9473a245-2c00-459a-a9a4-5101643f96c5	data_source	obis_oceanexpert	active
c2436564-13fc-4a0e-952b-6a1066a97446	9473a245-2c00-459a-a9a4-5101643f96c5	sync_date	2025-09-22	active
5b46bf1c-92a7-4ef6-bdeb-f60670ead1a4	bce4dbd9-6032-4046-a7c6-2763e2b9b65a	ocean_expert_id	18292	active
a19e2b09-3c1f-4fce-8bf4-e5a0e4ee0167	bce4dbd9-6032-4046-a7c6-2763e2b9b65a	data_source	obis_oceanexpert	active
19e8b5d7-a3c7-46c3-8971-08a07eed50a6	bce4dbd9-6032-4046-a7c6-2763e2b9b65a	sync_date	2025-09-22	active
55a06f6f-bed7-40b8-809d-dfaa240ce35d	7ea7c6d8-b190-41ba-9220-cb2afa26aedd	ocean_expert_id	18955	active
0a490ac3-b577-4bec-8d0c-d7a386642ff0	7ea7c6d8-b190-41ba-9220-cb2afa26aedd	data_source	obis_oceanexpert	active
ea900064-74ec-4ab9-8e85-75858897ea1b	7ea7c6d8-b190-41ba-9220-cb2afa26aedd	sync_date	2025-09-22	active
f615f539-c4b4-4406-97cc-070fb253eecc	859c1ca6-f244-4ec6-9fd4-9f4ff789e1b9	ocean_expert_id	16122	active
77c34fad-b786-44df-bc40-a67673710347	859c1ca6-f244-4ec6-9fd4-9f4ff789e1b9	data_source	obis_oceanexpert	active
18a7fd6d-9b4f-439e-99b9-8198f79dba6f	859c1ca6-f244-4ec6-9fd4-9f4ff789e1b9	sync_date	2025-09-22	active
2d87e3e4-5457-4917-b421-5b4a80a6573d	6e6209ae-9722-4618-997e-574bd8bf9232	ocean_expert_id	10047	active
e478a3bf-bda7-4090-a71a-5bdf982b2043	6e6209ae-9722-4618-997e-574bd8bf9232	data_source	obis_oceanexpert	active
0297e785-5d7b-4a07-9cc6-143d72593a93	6e6209ae-9722-4618-997e-574bd8bf9232	sync_date	2025-09-22	active
a06f762a-d324-42b3-9141-0aa5a9974651	e907c070-e714-4cbd-9452-fd9835d754c0	ocean_expert_id	9162	active
2ab7da50-94b7-4ef2-befe-9320dcee347f	e907c070-e714-4cbd-9452-fd9835d754c0	data_source	obis_oceanexpert	active
06864242-ff3c-4972-9e7f-a834a713e671	e907c070-e714-4cbd-9452-fd9835d754c0	sync_date	2025-09-22	active
ef1a57e6-1541-41d7-8467-d86736aff699	50a6b81f-aa28-4c82-9701-3dcf237eb676	ocean_expert_id	19339	active
e4cf5ae4-77df-4542-8a86-6373470a9d3e	50a6b81f-aa28-4c82-9701-3dcf237eb676	data_source	obis_oceanexpert	active
1f69b328-68e1-4f09-befe-c87318befbc2	50a6b81f-aa28-4c82-9701-3dcf237eb676	sync_date	2025-09-22	active
56362e8c-08d2-4c2e-8ad7-ad29a8b993e9	cae19eda-cf6e-410f-8def-2f9f4f547a81	ocean_expert_id	9651	active
ca67f1d2-b577-4693-8823-8a2a36fe2fb1	cae19eda-cf6e-410f-8def-2f9f4f547a81	data_source	obis_oceanexpert	active
510a3d14-e927-4d79-be7c-38781848d500	cae19eda-cf6e-410f-8def-2f9f4f547a81	sync_date	2025-09-22	active
b8eb70df-447e-4d6f-86ad-65afff96d125	5cddb6d0-4ad6-4f7c-a5f8-b62b744538c1	ocean_expert_id	7029	active
3ea0cb24-17f6-4962-a2fc-8413baf547d3	5cddb6d0-4ad6-4f7c-a5f8-b62b744538c1	data_source	obis_oceanexpert	active
b8f9712d-6982-4028-982b-e38531cae8e6	5cddb6d0-4ad6-4f7c-a5f8-b62b744538c1	sync_date	2025-09-22	active
8403b356-f223-4ef8-9266-269080fc5585	e7291ef6-c93c-4d32-a3bf-56e5bfbbbe59	ocean_expert_id	20874	active
80280c13-600c-4176-8bc8-21f02786a411	e7291ef6-c93c-4d32-a3bf-56e5bfbbbe59	data_source	obis_oceanexpert	active
70643daf-d2f7-4341-8709-9ef290484259	e7291ef6-c93c-4d32-a3bf-56e5bfbbbe59	sync_date	2025-09-22	active
9a823efb-3b2f-46c2-ad40-43bd18a672df	a16dd315-42e4-4265-82a1-cca335347a61	ocean_expert_id	16194	active
4c984562-0053-4fd9-99e7-e3c9ed075fe5	a16dd315-42e4-4265-82a1-cca335347a61	data_source	obis_oceanexpert	active
ff27c146-1040-4d9d-ba07-2095e749838b	a16dd315-42e4-4265-82a1-cca335347a61	sync_date	2025-09-22	active
169548d1-d866-4017-a0cf-fde34532255f	c7a3397f-16f3-490b-aee6-40f0128b047a	ocean_expert_id	6748	active
730a6e40-f2bf-4c77-b74d-624ba0a11f14	c7a3397f-16f3-490b-aee6-40f0128b047a	data_source	obis_oceanexpert	active
bfaacc7a-4d7e-4d74-9390-5cd56c5c88f0	c7a3397f-16f3-490b-aee6-40f0128b047a	sync_date	2025-09-22	active
2230b398-9de0-41ca-8350-72a63f73098d	fb6ac69a-97ba-41aa-8393-6899331e54d9	ocean_expert_id	19450	active
1545bcc2-f16b-4eb6-8089-77defba22093	fb6ac69a-97ba-41aa-8393-6899331e54d9	data_source	obis_oceanexpert	active
cb788312-c7ec-4a60-a3c7-090fed3851a0	fb6ac69a-97ba-41aa-8393-6899331e54d9	sync_date	2025-09-22	active
60d6ffe1-25c8-4014-b39f-796a28394323	91b32882-1919-4ea9-b8d1-6a1a234b6d54	ocean_expert_id	18896	active
94b5e305-27f4-4874-a57f-83e6741fcd23	91b32882-1919-4ea9-b8d1-6a1a234b6d54	data_source	obis_oceanexpert	active
01440943-3d85-4ccc-b899-1a18a7d933d1	91b32882-1919-4ea9-b8d1-6a1a234b6d54	sync_date	2025-09-22	active
59cdbbcf-f879-40bf-8b78-b9312e9797c7	13d92eaf-54e6-4030-917d-92f07ed3ac15	ocean_expert_id	23181	active
b7a76029-3c3b-42b9-8245-79a04121ca72	13d92eaf-54e6-4030-917d-92f07ed3ac15	data_source	obis_oceanexpert	active
0d5192de-d711-4e59-a1de-343422704136	13d92eaf-54e6-4030-917d-92f07ed3ac15	sync_date	2025-09-22	active
02fcd92c-b2f8-4edb-a9cd-de55d74a0788	f677b5bc-4d9a-4e3c-8581-81e6b7cb4543	ocean_expert_id	15153	active
9002c8cb-efa2-464c-a607-c2e51ffcdd56	f677b5bc-4d9a-4e3c-8581-81e6b7cb4543	data_source	obis_oceanexpert	active
518870ad-2054-4ca1-8b4d-7f29958b7c10	f677b5bc-4d9a-4e3c-8581-81e6b7cb4543	sync_date	2025-09-22	active
ffe99fda-e5b4-4fd1-85f4-4f1b453bcd6b	ec093b2d-a8cc-4cac-942a-382e052740d7	ocean_expert_id	21891	active
891da87e-dc98-4419-a706-efcbcc7bbbd3	ec093b2d-a8cc-4cac-942a-382e052740d7	data_source	obis_oceanexpert	active
8d61856d-0e93-4a87-b662-78ba184aa765	ec093b2d-a8cc-4cac-942a-382e052740d7	sync_date	2025-09-22	active
0d4e39c9-5e5f-4e08-a6a4-1edb721133fe	c596f9de-a718-4452-a72e-6114b4df376a	ocean_expert_id	19515	active
6a20d4d5-51ef-4fd2-8a68-e55b81f1e826	c596f9de-a718-4452-a72e-6114b4df376a	data_source	obis_oceanexpert	active
8815efc5-d253-42f5-9a9c-71014b85a69e	c596f9de-a718-4452-a72e-6114b4df376a	sync_date	2025-09-22	active
91eb95d6-4ef0-473f-8099-b336d9beab05	aa3f2b1d-0c60-4683-b34b-72a697014c06	ocean_expert_id	19527	active
d5f64fec-33f3-41ce-910a-c59c817aff67	aa3f2b1d-0c60-4683-b34b-72a697014c06	data_source	obis_oceanexpert	active
e63c7a4a-b2d6-436a-8442-02a00d92a485	aa3f2b1d-0c60-4683-b34b-72a697014c06	sync_date	2025-09-22	active
a59baea2-1af2-4fdb-8b3a-596a86a04d5e	e4b9e642-5e3c-477d-8beb-d7d0695f1529	ocean_expert_id	19486	active
548fa040-52d1-4e65-b897-68c2a2239cb7	e4b9e642-5e3c-477d-8beb-d7d0695f1529	data_source	obis_oceanexpert	active
44d3bf4d-0cf5-4274-ba2a-e7d3fa50ec6c	e4b9e642-5e3c-477d-8beb-d7d0695f1529	sync_date	2025-09-22	active
8230e303-1db0-4ef0-bcde-c66e9eb7714a	214d4414-7bd0-4e93-8880-29ce5f7f8a4c	ocean_expert_id	11193	active
02489e8c-d377-4095-b3a9-60005fd5c4e9	214d4414-7bd0-4e93-8880-29ce5f7f8a4c	data_source	obis_oceanexpert	active
d2de13b1-fc22-45c4-b4dc-8c2f94099122	214d4414-7bd0-4e93-8880-29ce5f7f8a4c	sync_date	2025-09-22	active
df507953-0732-48d6-bd83-2ad8f0fd6418	824218af-abd6-494d-8516-df3976f15036	ocean_expert_id	20778	active
c155b5cf-bebf-422c-bfcd-c8955ebafe5e	824218af-abd6-494d-8516-df3976f15036	data_source	obis_oceanexpert	active
fc23c478-5d0d-41a8-bd82-5f2d609bfadd	824218af-abd6-494d-8516-df3976f15036	sync_date	2025-09-22	active
9172b8cd-4164-4488-b8e0-6102246cd413	82afeb70-c1a1-4f44-abbc-e4011fbd6fe1	ocean_expert_id	5247	active
0f095852-35d8-4cec-9ad4-208034da3427	82afeb70-c1a1-4f44-abbc-e4011fbd6fe1	data_source	obis_oceanexpert	active
75ed1600-f207-456a-87b9-7b2b42832596	82afeb70-c1a1-4f44-abbc-e4011fbd6fe1	sync_date	2025-09-22	active
2c2ac453-c6eb-4e6d-9a12-84b88a1bf1cd	3a8c7ba9-7568-4ae5-af84-8774a9d68c84	ocean_expert_id	20989	active
a29c2a97-8a6a-4af2-8bbf-699ac019eea3	3a8c7ba9-7568-4ae5-af84-8774a9d68c84	data_source	obis_oceanexpert	active
36141ffa-ed4d-48b7-a2fa-5b5f07dca487	3a8c7ba9-7568-4ae5-af84-8774a9d68c84	sync_date	2025-09-22	active
7815988a-1fd7-4d39-a556-4710f4aa02fe	ac23012e-f084-4e91-a387-ab2710215700	ocean_expert_id	16145	active
5becda34-d087-47b9-b658-687ede84f1e2	ac23012e-f084-4e91-a387-ab2710215700	data_source	obis_oceanexpert	active
e085a1c9-3b35-43e3-a19b-f6954e2478c7	ac23012e-f084-4e91-a387-ab2710215700	sync_date	2025-09-22	active
3d02f669-7afa-4940-abe0-cfae82d2a45d	f6e30ff9-73a7-4d8d-aa0f-394fec886cc4	ocean_expert_id	19614	active
cd99e2bb-48df-49df-ab34-a122ff84eaa3	f6e30ff9-73a7-4d8d-aa0f-394fec886cc4	data_source	obis_oceanexpert	active
32e57e44-2bfc-49d8-b121-be391a3174a1	f6e30ff9-73a7-4d8d-aa0f-394fec886cc4	sync_date	2025-09-22	active
14a21ebe-47c7-44ac-830e-7fedcccc826b	3d13dcc2-f9e2-4ea6-8927-3fdc64f2599e	ocean_expert_id	18819	active
076f966e-80a8-444a-9f70-51d13c75c7a8	3d13dcc2-f9e2-4ea6-8927-3fdc64f2599e	data_source	obis_oceanexpert	active
d05278d4-fa63-4f49-a899-8c21751e105a	3d13dcc2-f9e2-4ea6-8927-3fdc64f2599e	sync_date	2025-09-22	active
2d250519-53bb-496e-b269-06aef00bf1dd	a6f164ab-e1f5-4685-81ec-e307c1005059	ocean_expert_id	13220	active
e57263b3-5595-4ac1-9dc4-5d6f75f5f918	a6f164ab-e1f5-4685-81ec-e307c1005059	data_source	obis_oceanexpert	active
39140a68-6f2b-4519-b196-fec6d5b2193d	a6f164ab-e1f5-4685-81ec-e307c1005059	sync_date	2025-09-22	active
fcf72443-a094-4990-bfb4-2600fa6106fe	03a65aa1-ef3b-4ba2-b55a-f9e1309350c5	ocean_expert_id	18	active
582779a2-5421-438e-be6a-37303e8b7b90	03a65aa1-ef3b-4ba2-b55a-f9e1309350c5	data_source	obis_oceanexpert	active
c6e109cd-bcfa-4c8f-bfef-b8544dd60282	03a65aa1-ef3b-4ba2-b55a-f9e1309350c5	sync_date	2025-09-22	active
989a99dc-3775-43d4-a01e-82ffaa4ea42b	981ece61-8d8d-49b3-aa77-5604c05b25a5	ocean_expert_id	5423	active
76a7288e-85b9-4fac-8ea7-1dd37d2e3375	981ece61-8d8d-49b3-aa77-5604c05b25a5	data_source	obis_oceanexpert	active
3d63008b-13dd-4b50-9da2-941b5167803c	981ece61-8d8d-49b3-aa77-5604c05b25a5	sync_date	2025-09-22	active
ad7490a8-2607-4350-95f5-9f08c7ed248b	fb7d769c-25af-491e-82d7-2814bb44adfa	ocean_expert_id	7991	active
a5bf8840-eba9-47bf-8383-dd38de040eea	fb7d769c-25af-491e-82d7-2814bb44adfa	data_source	obis_oceanexpert	active
d0e5528e-f99a-40b9-853d-91aa00b582c7	fb7d769c-25af-491e-82d7-2814bb44adfa	sync_date	2025-09-22	active
6f631e1e-0a0f-4723-a32c-8af1ee622617	e8af040b-6c07-471b-8f38-e2e2c2a3618a	ocean_expert_id	8886	active
f9a40e17-ead2-481d-b3b1-b1fc18728ebe	e8af040b-6c07-471b-8f38-e2e2c2a3618a	data_source	obis_oceanexpert	active
29073eaf-631e-401c-9778-fbc6bd3f7642	e8af040b-6c07-471b-8f38-e2e2c2a3618a	sync_date	2025-09-22	active
7b56e8b8-9558-4cd8-9d35-d2112a630033	7dac64a8-dbeb-4200-9ddc-3cce519d268c	ocean_expert_id	9684	active
368a7a09-dec3-46a4-96d8-3140231207b8	7dac64a8-dbeb-4200-9ddc-3cce519d268c	data_source	obis_oceanexpert	active
a332493f-0d9f-48be-b818-7d8be4458f71	7dac64a8-dbeb-4200-9ddc-3cce519d268c	sync_date	2025-09-22	active
0274efd0-6268-4116-9d44-0055838d2192	89d0ab20-89d1-4def-b62c-5bdb334ba91c	ocean_expert_id	9977	active
9a52edac-998b-484e-8813-14723db0440b	89d0ab20-89d1-4def-b62c-5bdb334ba91c	data_source	obis_oceanexpert	active
5df66085-81b7-4237-a561-f960cace7331	89d0ab20-89d1-4def-b62c-5bdb334ba91c	sync_date	2025-09-22	active
102ccb29-0752-4e68-aa43-415b2c74fba5	30262bfe-a8cc-4358-842c-d6f2215dbc27	ocean_expert_id	11293	active
842b83c6-4be3-43a8-8bac-f4e10ff90311	30262bfe-a8cc-4358-842c-d6f2215dbc27	data_source	obis_oceanexpert	active
a1a32b11-686b-43d3-b511-ff0ccd2e4537	30262bfe-a8cc-4358-842c-d6f2215dbc27	sync_date	2025-09-22	active
cb95d44a-399a-40df-9a7d-4bebb3392356	871ab2eb-b6e4-4d17-82e4-a0d19dc00734	ocean_expert_id	13020	active
c943b50b-f3f9-482e-b9c9-1c4aaf8a0553	871ab2eb-b6e4-4d17-82e4-a0d19dc00734	data_source	obis_oceanexpert	active
c5a53b82-0840-40a1-8d9a-70a5b2d5efd6	871ab2eb-b6e4-4d17-82e4-a0d19dc00734	sync_date	2025-09-22	active
f23b4376-14fb-462e-82cc-2325a9e1b0d6	9bcaadda-82db-4337-969b-f20c2fd6df9f	ocean_expert_id	13338	active
7d640e76-7522-4df5-b04d-f756f9ff2ed4	9bcaadda-82db-4337-969b-f20c2fd6df9f	data_source	obis_oceanexpert	active
b2dd9269-f54e-43ec-8f7f-d2554d9028b1	9bcaadda-82db-4337-969b-f20c2fd6df9f	sync_date	2025-09-22	active
6a2d1dae-3781-4dd0-96db-cb35cf8d6160	54ad8d42-a77e-4ba9-9086-5616f5b1bfa3	ocean_expert_id	15498	active
d6d373a4-f598-4df9-b1af-741445eb020a	54ad8d42-a77e-4ba9-9086-5616f5b1bfa3	data_source	obis_oceanexpert	active
9c652dba-3d3d-4ac5-b54d-e6b044ecd304	54ad8d42-a77e-4ba9-9086-5616f5b1bfa3	sync_date	2025-09-22	active
7de14cc1-24e6-4d46-9e38-742d628115cf	802e6fa7-dcfa-47ae-8fba-fc82384781ce	ocean_expert_id	19330	active
d4ab493b-356e-4dd2-9f2a-a08f501944d9	802e6fa7-dcfa-47ae-8fba-fc82384781ce	data_source	obis_oceanexpert	active
52ca3d3b-c3bb-4675-89c3-df597ec3d8ea	802e6fa7-dcfa-47ae-8fba-fc82384781ce	sync_date	2025-09-22	active
6a99f4c9-7028-4dcf-84f5-7690e5b2741d	d381c204-7ca8-4c47-9009-da41186d3ddb	ocean_expert_id	19349	active
16870f7a-e642-4336-939c-bb05ec9091e5	d381c204-7ca8-4c47-9009-da41186d3ddb	data_source	obis_oceanexpert	active
df911623-3504-42d2-8a5e-199a35caba55	d381c204-7ca8-4c47-9009-da41186d3ddb	sync_date	2025-09-22	active
b39a1e32-1b23-4ed3-b51f-033660207fff	bb4dca58-991a-4bf6-9b45-58773ebfc74b	ocean_expert_id	19396	active
c2f62b45-8ce5-4230-990b-74f76927d4e3	bb4dca58-991a-4bf6-9b45-58773ebfc74b	data_source	obis_oceanexpert	active
dcc1ad2f-4b7c-4209-af9c-3b27403c2a94	bb4dca58-991a-4bf6-9b45-58773ebfc74b	sync_date	2025-09-22	active
cd5b1638-9ad3-41c2-ae64-3597d5cf685b	28edba86-d7b0-4680-aeae-76a6ea1fb665	ocean_expert_id	19442	active
b310ada5-dc4d-4816-8ad1-b7277aaa7d69	28edba86-d7b0-4680-aeae-76a6ea1fb665	data_source	obis_oceanexpert	active
d520b736-a39a-4013-bea2-44afac511a79	28edba86-d7b0-4680-aeae-76a6ea1fb665	sync_date	2025-09-22	active
5de1dfd2-c5cc-457c-93dc-be7927168ecc	1525c747-c4f0-4722-b9ff-f1b3110c4722	ocean_expert_id	19444	active
3097300a-1219-4320-80d6-5355a233d269	1525c747-c4f0-4722-b9ff-f1b3110c4722	data_source	obis_oceanexpert	active
506e5256-c2d6-42ae-961b-e9a203084dc7	1525c747-c4f0-4722-b9ff-f1b3110c4722	sync_date	2025-09-22	active
cdd68040-bd72-4e3f-9f0f-a0d998bd1194	2266f8b8-d21c-4396-b121-38a6d0d10904	ocean_expert_id	11197	active
78292440-3183-4b49-a0ec-7aeea91600a4	2266f8b8-d21c-4396-b121-38a6d0d10904	data_source	obis_oceanexpert	active
d721d769-150d-4a95-9901-13b2386bc9c7	2266f8b8-d21c-4396-b121-38a6d0d10904	sync_date	2025-09-22	active
cc65d339-d8c8-4b5b-aa2a-bbdbbd40882b	266b5bf5-ff83-4884-99d1-e57d24c62938	ocean_expert_id	14102	active
3c404401-cbeb-4cad-a6d6-a6c24ccdaad1	266b5bf5-ff83-4884-99d1-e57d24c62938	data_source	obis_oceanexpert	active
7f5aca74-71e8-4848-9f24-84f4e126b1a9	266b5bf5-ff83-4884-99d1-e57d24c62938	sync_date	2025-09-22	active
1fd7e4c3-5040-4742-a74c-b085f0a69cc9	b8d845b9-9dba-47e7-ba82-21c73c3a4a40	ocean_expert_id	11858	active
e3b1b8ef-fe42-4615-b92e-c82a22b5b13a	b8d845b9-9dba-47e7-ba82-21c73c3a4a40	data_source	obis_oceanexpert	active
f57b3a65-b70b-4fcd-a585-f2fc0114f5bc	b8d845b9-9dba-47e7-ba82-21c73c3a4a40	sync_date	2025-09-22	active
d3705649-6a5c-4439-a801-942b71ed52b0	8b9956e9-9b6c-4d3b-af4e-9794dc16e045	ocean_expert_id	19590	active
f7f612bf-ff0e-472c-b673-8813ce2a832f	8b9956e9-9b6c-4d3b-af4e-9794dc16e045	data_source	obis_oceanexpert	active
5145a35f-e15e-4789-9af1-2aef0d7369e3	8b9956e9-9b6c-4d3b-af4e-9794dc16e045	sync_date	2025-09-22	active
f26948f6-9ce0-40c4-90ba-4e08ac9b8258	041a8159-b1a2-4b4e-984e-dfa10a7183b8	ocean_expert_id	20448	active
edcb4be3-9e1b-422e-937a-bf9f3908bb2f	041a8159-b1a2-4b4e-984e-dfa10a7183b8	data_source	obis_oceanexpert	active
c93a3f7b-85d0-441a-926b-8d3a6bd4cc6d	041a8159-b1a2-4b4e-984e-dfa10a7183b8	sync_date	2025-09-22	active
dfbf7758-70ba-426a-a9aa-1969474d74ca	db4af8aa-7de7-4549-bbd2-2279e29221c1	ocean_expert_id	17542	active
c3b99c6f-a716-4360-8334-b199297cb0d7	db4af8aa-7de7-4549-bbd2-2279e29221c1	data_source	obis_oceanexpert	active
83f51d0a-9613-489a-b6fa-8192fba12588	db4af8aa-7de7-4549-bbd2-2279e29221c1	sync_date	2025-09-22	active
dfacdb43-ee6c-4696-99ab-d5844c27e18f	275f4e71-3c27-4493-8557-264bf2bdc573	ocean_expert_id	5010	active
e6283f61-843a-45cd-bb78-f5855ae677bb	275f4e71-3c27-4493-8557-264bf2bdc573	data_source	obis_oceanexpert	active
fde00e3b-b66d-4270-a5ca-586e277ca0f9	275f4e71-3c27-4493-8557-264bf2bdc573	sync_date	2025-09-22	active
812283f0-413a-4a9b-9c25-9d2960401f87	1f14f01f-988f-4b30-be8a-30f5affec66d	ocean_expert_id	5506	active
7920ce14-948a-4e6a-9dff-433298a6369c	1f14f01f-988f-4b30-be8a-30f5affec66d	data_source	obis_oceanexpert	active
bbc6f8c8-851c-4eb6-b7aa-4f21a9f4137f	1f14f01f-988f-4b30-be8a-30f5affec66d	sync_date	2025-09-22	active
7db3ffce-4af4-4b13-9d02-69842b9aaedb	25f14782-5f5b-4fdc-815b-5ab6361eb4b7	ocean_expert_id	13777	active
bc76cb8f-4585-4929-9974-eaa7c8ee001d	25f14782-5f5b-4fdc-815b-5ab6361eb4b7	data_source	obis_oceanexpert	active
c3f99528-45a0-48cd-9759-3c5d094c1dd0	25f14782-5f5b-4fdc-815b-5ab6361eb4b7	sync_date	2025-09-22	active
2a983a44-3908-4434-9a86-66db5a3f425b	70de0a28-cbe6-48a6-ad7f-c5f865d95e57	ocean_expert_id	23183	active
b42f4b32-e576-4011-b099-38fa6249135a	70de0a28-cbe6-48a6-ad7f-c5f865d95e57	data_source	obis_oceanexpert	active
83486818-9c57-47cc-8e74-fe27362f97e0	70de0a28-cbe6-48a6-ad7f-c5f865d95e57	sync_date	2025-09-22	active
84656ea2-9cb3-45d5-acd3-50f527cb6ee7	bf870d7f-9771-4ec4-bec4-96a93ac48db4	ocean_expert_id	20839	active
59ce71cf-92cd-478c-92da-e86a1f45bf7c	bf870d7f-9771-4ec4-bec4-96a93ac48db4	data_source	obis_oceanexpert	active
d9d73a54-4d25-4c35-9dc9-779cd1c8d656	bf870d7f-9771-4ec4-bec4-96a93ac48db4	sync_date	2025-09-22	active
27df6952-6a83-470e-8cdc-67cbeb606d9b	52311b2d-544b-4fc9-8f50-a2bc46dd021e	ocean_expert_id	23192	active
18bee475-3b76-4ddc-b532-bc26722686cb	52311b2d-544b-4fc9-8f50-a2bc46dd021e	data_source	obis_oceanexpert	active
a9993ca5-cd09-404a-b0b4-b196e55d36a6	52311b2d-544b-4fc9-8f50-a2bc46dd021e	sync_date	2025-09-22	active
90d9d446-f647-492c-8d35-48e5d99f3c5d	686eebff-1ae4-4ffc-aa82-b4e57d6bc878	ocean_expert_id	10795	active
9ff633c6-48cf-47ca-a3ce-9c5bf456130e	686eebff-1ae4-4ffc-aa82-b4e57d6bc878	data_source	obis_oceanexpert	active
c44aee8f-4cbe-4a8c-9482-2f7a6826d2cd	686eebff-1ae4-4ffc-aa82-b4e57d6bc878	sync_date	2025-09-22	active
9e17a72a-aeef-43c6-b4a7-7514caba596d	4a747e3c-d413-407b-9b33-0971c3e1c715	ocean_expert_id	18991	active
a436a765-3a13-4386-9c96-b864d4863bf5	4a747e3c-d413-407b-9b33-0971c3e1c715	data_source	obis_oceanexpert	active
89e9e85c-d6ea-4e0d-8c97-74756588b0f5	4a747e3c-d413-407b-9b33-0971c3e1c715	sync_date	2025-09-22	active
dcf16305-5cb4-4bbe-b23f-41ef84944566	42dc3aa1-6da8-423f-8661-36a18ac5f228	ocean_expert_id	23142	active
a585ad92-c435-433d-a72d-b10020f64df8	42dc3aa1-6da8-423f-8661-36a18ac5f228	data_source	obis_oceanexpert	active
c155ea89-ee35-411f-a478-c0dd79175acd	42dc3aa1-6da8-423f-8661-36a18ac5f228	sync_date	2025-09-22	active
e1f2a5bd-68aa-4b3c-9cd8-12cd0743b3a8	a07368ee-ae2d-4f0b-a5ef-2fe499d50916	ocean_expert_id	12097	active
71489267-9534-4d9d-8a6b-1f1de3f979a9	a07368ee-ae2d-4f0b-a5ef-2fe499d50916	data_source	obis_oceanexpert	active
40107a74-8d56-4390-b4d0-d8ba4f1fec3f	a07368ee-ae2d-4f0b-a5ef-2fe499d50916	sync_date	2025-09-22	active
2f14fa4a-a19c-4be5-9e98-54d9e0d0fff3	b2b51546-3b53-4352-a662-cc01be4e15e4	ocean_expert_id	19605	active
8faa57ec-cfc9-4f8e-b922-e26764c220b2	b2b51546-3b53-4352-a662-cc01be4e15e4	data_source	obis_oceanexpert	active
caa48d8d-ec71-4baa-a152-95ff0f38bf66	b2b51546-3b53-4352-a662-cc01be4e15e4	sync_date	2025-09-22	active
3bab2c42-2a48-46cf-87d7-054e8d132eef	0c646368-381c-4755-9662-208f7beefec2	ocean_expert_id	19318	active
e7f2acb2-0b18-4dc7-af4c-291e5481ce89	0c646368-381c-4755-9662-208f7beefec2	data_source	obis_oceanexpert	active
38a81553-ab4e-4a2f-b255-c5eab6f5c5d8	0c646368-381c-4755-9662-208f7beefec2	sync_date	2025-09-22	active
8acbf701-62e0-405d-a60e-d8b7c8853100	8181c435-3025-4586-b923-06bbd11d74a8	ocean_expert_id	8902	active
5833362a-c966-4aa5-9edb-9926de943ebd	8181c435-3025-4586-b923-06bbd11d74a8	data_source	obis_oceanexpert	active
cf38eafa-0723-410c-8592-ee8800979b3a	8181c435-3025-4586-b923-06bbd11d74a8	sync_date	2025-09-22	active
9aff98d6-7d59-4801-8600-ba681b938e45	b49c0d7a-ab4e-49da-8740-966a1e3bf988	ocean_expert_id	19556	active
420abd40-6b47-47a0-835f-00f6f6d74a6e	b49c0d7a-ab4e-49da-8740-966a1e3bf988	data_source	obis_oceanexpert	active
238bf0a7-a88f-4d87-8e69-00dd88eda6ea	b49c0d7a-ab4e-49da-8740-966a1e3bf988	sync_date	2025-09-22	active
0cbc53ce-0043-49d0-8a70-70d6db7ec499	4d85c067-dd49-4389-9b5d-d7f2f7c9619a	ocean_expert_id	19298	active
4e7c74dd-0876-476f-ae88-0d68146247a9	4d85c067-dd49-4389-9b5d-d7f2f7c9619a	data_source	obis_oceanexpert	active
f84df522-494b-47f9-b35a-148eb70310a4	4d85c067-dd49-4389-9b5d-d7f2f7c9619a	sync_date	2025-09-22	active
7dc4172e-5850-4aba-933e-8ddbb0d1bcbb	0b4bdd41-6d09-4acc-8686-f19daa04ca80	ocean_expert_id	4889	active
790587e4-aecf-4530-9c80-8a0148a780b3	0b4bdd41-6d09-4acc-8686-f19daa04ca80	data_source	obis_oceanexpert	active
1c5604df-bb02-499c-816c-2c211ca83d21	0b4bdd41-6d09-4acc-8686-f19daa04ca80	sync_date	2025-09-22	active
bde1001c-577a-4959-9cd9-5f1b36599017	a3e2256d-8325-43aa-80fc-2609c4773bed	ocean_expert_id	10233	active
d089373d-16f0-409a-8ff7-42d1b2348ae8	a3e2256d-8325-43aa-80fc-2609c4773bed	data_source	obis_oceanexpert	active
efeefaad-9c0f-4e0b-a56a-0b2aeedad929	a3e2256d-8325-43aa-80fc-2609c4773bed	sync_date	2025-09-22	active
df1531f6-59f5-49e7-8c04-dcad7c04bf45	2110e2c1-1004-4df9-939d-59c145d8863a	ocean_expert_id	11096	active
ae103350-f647-4450-b645-0066340c832c	2110e2c1-1004-4df9-939d-59c145d8863a	data_source	obis_oceanexpert	active
71c6f51f-db8e-42e8-8841-b68454578777	2110e2c1-1004-4df9-939d-59c145d8863a	sync_date	2025-09-22	active
0a561757-4d6a-4f3e-93c6-26ca9c29637c	14f7ee4f-e08e-4a46-b871-4986f878734c	ocean_expert_id	20901	active
cae0ee24-3aaf-4311-8f67-145023df2303	14f7ee4f-e08e-4a46-b871-4986f878734c	data_source	obis_oceanexpert	active
fa558eb0-8c9e-4c47-8152-ff1e8d6276b4	14f7ee4f-e08e-4a46-b871-4986f878734c	sync_date	2025-09-22	active
a0902861-9388-4288-8b44-898942959bb0	a07e42c6-9d8c-41a9-a584-a7ab36182661	ocean_expert_id	17805	active
36d070b4-646f-400e-8717-01c7f021db29	a07e42c6-9d8c-41a9-a584-a7ab36182661	data_source	obis_oceanexpert	active
95086f01-11d1-44ae-996d-8d86b732f86c	a07e42c6-9d8c-41a9-a584-a7ab36182661	sync_date	2025-09-22	active
2b608498-38c4-4203-a097-72c247c80c52	10c56773-42dd-48ac-b112-7f93635f77f5	ocean_expert_id	5872	active
4eedf867-27e9-47ab-86ec-26129ace4b2f	10c56773-42dd-48ac-b112-7f93635f77f5	data_source	obis_oceanexpert	active
d6bc38e1-6e2a-4fbe-8c66-fd8c5ed367cf	10c56773-42dd-48ac-b112-7f93635f77f5	sync_date	2025-09-22	active
9b42799d-b890-44bb-9402-2ff1a7c88d2e	22afadf4-defa-4dc5-84d6-43753cb4b6a6	ocean_expert_id	20854	active
719af06e-091e-4a9f-a984-efc67dde5302	22afadf4-defa-4dc5-84d6-43753cb4b6a6	data_source	obis_oceanexpert	active
45e97915-3f69-48e4-bc43-deb2baf18e52	22afadf4-defa-4dc5-84d6-43753cb4b6a6	sync_date	2025-09-22	active
3bf872d3-961b-4467-a7ff-1ddf4aec2d2a	b36f3a08-c0f3-4113-9701-8be7a96c6994	ocean_expert_id	16203	active
6c1b8be9-9f91-44c3-8a04-511fe21a0fc0	b36f3a08-c0f3-4113-9701-8be7a96c6994	data_source	obis_oceanexpert	active
bda11310-2749-453f-8fcd-864a8020c891	b36f3a08-c0f3-4113-9701-8be7a96c6994	sync_date	2025-09-22	active
10e0ff53-9779-4c00-b74c-d0db197f3d63	97030076-b67c-4297-82da-9719f19f627d	ocean_expert_id	15791	active
efb7d7cc-8cf3-4228-a33f-6db9a6587513	97030076-b67c-4297-82da-9719f19f627d	data_source	obis_oceanexpert	active
ff4bdafc-d93c-4403-aea5-e8a194aa61a0	97030076-b67c-4297-82da-9719f19f627d	sync_date	2025-09-22	active
dc47498c-65ec-43df-a710-37ad78df2cc0	7392a5b0-980d-4fad-b474-87508f4764a7	ocean_expert_id	18336	active
18f442b3-9102-43d4-a76e-92aa938b239d	7392a5b0-980d-4fad-b474-87508f4764a7	data_source	obis_oceanexpert	active
f9264a7d-3423-4b31-9fb0-36ad2d751b7f	7392a5b0-980d-4fad-b474-87508f4764a7	sync_date	2025-09-22	active
8fdc5b27-2c42-4fd0-a7d2-0f468f6d5eea	1faa8adc-06fa-4d42-9ac1-29d184df23dd	ocean_expert_id	19272	active
31c155ad-0e8a-4041-971c-cd3926552c08	1faa8adc-06fa-4d42-9ac1-29d184df23dd	data_source	obis_oceanexpert	active
6b45351a-2e26-43b2-9fa1-ba40eaed5629	1faa8adc-06fa-4d42-9ac1-29d184df23dd	sync_date	2025-09-22	active
d2229bb9-60eb-40d0-9314-352328f26da0	d56c7b0b-6ae9-468c-ac9d-9376fc21da16	ocean_expert_id	20807	active
b252bf05-501a-46a9-a176-f1039c623a3a	d56c7b0b-6ae9-468c-ac9d-9376fc21da16	data_source	obis_oceanexpert	active
b67efb01-2532-41c3-a71a-6322583a46c6	d56c7b0b-6ae9-468c-ac9d-9376fc21da16	sync_date	2025-09-22	active
c3402f2c-8fff-4521-9588-cf5c0a8efcb4	b7d6f9fd-961c-43da-96d7-2a96958f52a5	ocean_expert_id	19337	active
25d12ddc-f41a-4d0b-9b85-5a2dc4fba99f	b7d6f9fd-961c-43da-96d7-2a96958f52a5	data_source	obis_oceanexpert	active
9f419518-7433-4b53-ae91-0ff9bfaeeaa4	b7d6f9fd-961c-43da-96d7-2a96958f52a5	sync_date	2025-09-22	active
72dd7483-3037-4f6c-a113-f01cf20472a2	0a48dceb-ee1b-4a15-bdf8-f0600922140b	ocean_expert_id	19530	active
8759b53e-b66f-4efd-a71e-0d2434866c62	0a48dceb-ee1b-4a15-bdf8-f0600922140b	data_source	obis_oceanexpert	active
dabbbcfb-7dcc-4ff4-9f80-08b9fecf8a6b	0a48dceb-ee1b-4a15-bdf8-f0600922140b	sync_date	2025-09-22	active
166c5905-b51c-4c97-bfb9-7bd0c95e8cf5	3b6e7d4d-aeca-4ed8-84b0-341a127c6961	ocean_expert_id	13433	active
337bc998-c6a1-478f-bf6f-a46abd792f5a	3b6e7d4d-aeca-4ed8-84b0-341a127c6961	data_source	obis_oceanexpert	active
02644837-827a-43fe-8eed-bc0d4ff381f0	3b6e7d4d-aeca-4ed8-84b0-341a127c6961	sync_date	2025-09-22	active
a4416a84-1421-4144-8639-7532906cc9f0	57cfc1e2-015b-4305-9a9c-c8d4e97edb7e	ocean_expert_id	19446	active
e1f28707-3999-42ac-a51c-3252517e6136	57cfc1e2-015b-4305-9a9c-c8d4e97edb7e	data_source	obis_oceanexpert	active
ec4ec36a-9db3-4b4d-8a8c-4027fd725e05	57cfc1e2-015b-4305-9a9c-c8d4e97edb7e	sync_date	2025-09-22	active
3559c166-e0e6-4eed-b0f6-4a14c866c746	95b31416-1012-4b3c-866a-cef324346386	ocean_expert_id	18893	active
57a41d42-e086-4764-a2a0-c3f02060fc4b	95b31416-1012-4b3c-866a-cef324346386	data_source	obis_oceanexpert	active
6741efe7-cda8-4ea2-abb5-dfb638eb12e9	95b31416-1012-4b3c-866a-cef324346386	sync_date	2025-09-22	active
0617f82b-edc5-46ff-ba14-2185bbc53e7b	ae9514c5-f98e-467d-9971-3a710a0eb8f9	ocean_expert_id	19185	active
cf6f5093-3f79-40ba-b077-1d40f94668df	ae9514c5-f98e-467d-9971-3a710a0eb8f9	data_source	obis_oceanexpert	active
2e65ab08-48ec-4f10-93db-4cb7bdd3eec9	ae9514c5-f98e-467d-9971-3a710a0eb8f9	sync_date	2025-09-22	active
9a68a7d2-67e2-42d9-938b-5bad6698e491	0d67c71d-6211-4e72-be4c-524bfc6a1d08	ocean_expert_id	19292	active
402dca55-8101-4a8d-bd2e-4bff852a591b	0d67c71d-6211-4e72-be4c-524bfc6a1d08	data_source	obis_oceanexpert	active
2ffed988-d5fb-4873-bdcf-18db7cfa12c4	0d67c71d-6211-4e72-be4c-524bfc6a1d08	sync_date	2025-09-22	active
8459c032-531d-4d66-aacd-ca7e493287a1	9b5a030b-4fba-40a2-b1f3-28c105710dde	ocean_expert_id	19581	active
3a6ec77a-70e9-4382-868a-b7256b483c67	9b5a030b-4fba-40a2-b1f3-28c105710dde	data_source	obis_oceanexpert	active
b82ccfd8-7e8e-4ba6-9518-fd2fc62e8887	9b5a030b-4fba-40a2-b1f3-28c105710dde	sync_date	2025-09-22	active
19c49f20-470b-46d0-bd39-496e3f03242e	8703524f-c585-4ce8-b585-7332c5a7d9dd	ocean_expert_id	15650	active
51f1cfcc-36b9-46c4-b9d7-8568b9f15dd5	8703524f-c585-4ce8-b585-7332c5a7d9dd	data_source	obis_oceanexpert	active
25c1b959-dcf7-407b-b50a-390e90e6e6ae	8703524f-c585-4ce8-b585-7332c5a7d9dd	sync_date	2025-09-22	active
3581962d-f19b-4c2b-8a98-55be836c867a	e828a308-7500-47c6-8e7a-708cc0a8ee24	ocean_expert_id	20847	active
1e046d80-7b96-4ba5-8c5d-f90f8fe29946	e828a308-7500-47c6-8e7a-708cc0a8ee24	data_source	obis_oceanexpert	active
7d17919d-19b0-48e2-ac4d-7dd6062d5175	e828a308-7500-47c6-8e7a-708cc0a8ee24	sync_date	2025-09-22	active
42d7d312-7000-47f1-ad9a-fff09bf8922d	98cbc4d9-113f-421b-ae1e-93940b14b0a9	ocean_expert_id	20169	active
eb1bd064-4c8a-4d16-b058-9b93fbac3cf7	98cbc4d9-113f-421b-ae1e-93940b14b0a9	data_source	obis_oceanexpert	active
caf319f7-6ae6-4683-803f-49a7323dc7c5	98cbc4d9-113f-421b-ae1e-93940b14b0a9	sync_date	2025-09-22	active
923461d1-91d7-4787-98e5-f4f6969667e0	331e4a28-5a0d-40c9-9156-8d069ed07e7e	ocean_expert_id	19497	active
0cd439f0-bb3b-4480-9644-81926a5a9455	331e4a28-5a0d-40c9-9156-8d069ed07e7e	data_source	obis_oceanexpert	active
00e9e6a5-c4dd-433d-9bc4-78a7a3dccc5c	331e4a28-5a0d-40c9-9156-8d069ed07e7e	sync_date	2025-09-22	active
4f6d6492-46eb-407c-be7d-fbdb144fe748	90e12cca-89b1-4682-846b-4ec3604123d8	ocean_expert_id	19485	active
0ee66e0e-e82a-4b7f-a5d2-294b034a6028	90e12cca-89b1-4682-846b-4ec3604123d8	data_source	obis_oceanexpert	active
a4018e86-8b0b-4207-bb26-4f1ce716a85a	90e12cca-89b1-4682-846b-4ec3604123d8	sync_date	2025-09-22	active
0de40e17-7854-4267-a35b-1f6ef6a99a2a	3d9e9d8c-def3-4e2d-b37d-92ac91094c61	ocean_expert_id	13724	active
1c249238-0c50-4878-88a6-59a1049c61ec	3d9e9d8c-def3-4e2d-b37d-92ac91094c61	data_source	obis_oceanexpert	active
ec7fc1a8-7ce0-47f9-ab16-9ec07171e68b	3d9e9d8c-def3-4e2d-b37d-92ac91094c61	sync_date	2025-09-22	active
efac4f7a-8c09-4368-9bef-7c966d7e3444	dd32ba32-b24a-4022-b3e0-3370ac3b64b4	ocean_expert_id	20907	active
7d49a0d6-5127-47f0-ac61-9055f4f93291	dd32ba32-b24a-4022-b3e0-3370ac3b64b4	data_source	obis_oceanexpert	active
543b9e68-6a4c-4ee0-98ba-44e5cff652f1	dd32ba32-b24a-4022-b3e0-3370ac3b64b4	sync_date	2025-09-22	active
19cc7b1b-b8dd-4406-9040-a5fcdc6c8908	fd57bbc8-c10b-43ef-a0e7-1a11c34d3c6a	ocean_expert_id	13636	active
7a9d4f25-1d2c-420f-9782-abc2a731b224	fd57bbc8-c10b-43ef-a0e7-1a11c34d3c6a	data_source	obis_oceanexpert	active
f8b943f8-051b-49f7-9efa-6ab4693178de	fd57bbc8-c10b-43ef-a0e7-1a11c34d3c6a	sync_date	2025-09-22	active
d4bd3cb8-df59-4642-a1f4-c21aa1860b90	26a7a9c1-1a70-49f8-82ab-e7502f538b12	ocean_expert_id	23201	active
ab928371-d656-48dc-a4ca-df1499a2e303	26a7a9c1-1a70-49f8-82ab-e7502f538b12	data_source	obis_oceanexpert	active
c274ba46-eaa7-482c-92fd-67beac0c8fad	26a7a9c1-1a70-49f8-82ab-e7502f538b12	sync_date	2025-09-22	active
a98554b4-39a3-4cee-961e-63cc9e99dbcf	1a25085b-990b-4a54-90dc-edf8b1bb5187	ocean_expert_id	19376	active
20f95b0a-52ac-45ff-8f5f-bb65c0ec260f	1a25085b-990b-4a54-90dc-edf8b1bb5187	data_source	obis_oceanexpert	active
1ab31fca-78c4-4d95-a0e7-481f98d755d5	1a25085b-990b-4a54-90dc-edf8b1bb5187	sync_date	2025-09-22	active
f064f859-f2e7-4048-b901-140a03e9de05	9a7fcc54-154a-4fc7-b1a6-5a82bed8d016	ocean_expert_id	19481	active
45a8bf23-63e8-4e3d-a545-47531b017586	9a7fcc54-154a-4fc7-b1a6-5a82bed8d016	data_source	obis_oceanexpert	active
e27fa43d-b899-4490-b3c9-83106f17f8fb	9a7fcc54-154a-4fc7-b1a6-5a82bed8d016	sync_date	2025-09-22	active
f48e84a4-2b0b-444f-b4a9-967da9fe20d1	5dee680a-6ac8-42b5-80ea-37bc20b6753a	ocean_expert_id	16018	active
a1ac3d6b-d27c-44b1-bb56-96b9ce67b5da	5dee680a-6ac8-42b5-80ea-37bc20b6753a	data_source	obis_oceanexpert	active
df04b1e6-a48b-4a8b-8972-3442975c0c62	5dee680a-6ac8-42b5-80ea-37bc20b6753a	sync_date	2025-09-22	active
9ef53f5e-2e39-4734-a4e2-73f9e0956fe9	c0724b90-69b6-4cd1-997e-e5b34f96d23a	ocean_expert_id	13167	active
0567be21-ee48-407a-b842-b2f5f854d0b0	c0724b90-69b6-4cd1-997e-e5b34f96d23a	data_source	obis_oceanexpert	active
71b419ed-9390-4697-9124-4c46b1eb6068	c0724b90-69b6-4cd1-997e-e5b34f96d23a	sync_date	2025-09-22	active
841e3aab-a317-4e16-aa29-445f83b11590	95f850a5-917a-42ff-8394-c0b03f115000	ocean_expert_id	18213	active
0d033e69-7520-4cb8-94e6-fbad1ae78abe	95f850a5-917a-42ff-8394-c0b03f115000	data_source	obis_oceanexpert	active
46904701-bc48-49a8-bf2e-32dd9ba3758c	95f850a5-917a-42ff-8394-c0b03f115000	sync_date	2025-09-22	active
693daa74-0957-4b6b-aac6-c1091d4a2c67	8b115d2c-b78f-48c1-91c7-98361c0cb9b2	ocean_expert_id	17785	active
f40f0f62-fc15-4757-bff8-0f1ebb7fa56f	8b115d2c-b78f-48c1-91c7-98361c0cb9b2	data_source	obis_oceanexpert	active
fe1fb56e-860f-4d50-88fe-edfe7f4f17f1	8b115d2c-b78f-48c1-91c7-98361c0cb9b2	sync_date	2025-09-22	active
80c600f4-18f3-4b31-b7a9-45addd4b057d	a7227e00-5b28-4afc-b42c-01a3faf61b3e	ocean_expert_id	15109	active
bc12189f-9b4b-4ca9-b8ee-76d7c8014eae	a7227e00-5b28-4afc-b42c-01a3faf61b3e	data_source	obis_oceanexpert	active
6298bb36-2031-49d9-85d1-6acca8749ccc	a7227e00-5b28-4afc-b42c-01a3faf61b3e	sync_date	2025-09-22	active
0431cc20-43ec-44d0-b572-4c9d12fefbbe	fda51120-160d-4ce7-901b-30b7bc880320	ocean_expert_id	18874	active
403b3919-9c27-4c0a-8db0-0dfbb9beaf73	fda51120-160d-4ce7-901b-30b7bc880320	data_source	obis_oceanexpert	active
7856ffa5-12f0-4351-a2ae-4881717c59b1	fda51120-160d-4ce7-901b-30b7bc880320	sync_date	2025-09-22	active
106ff2e1-ca2d-408a-907f-5e7401d059c6	72ecf145-6884-41d5-bd1e-da35039b930f	ocean_expert_id	19672	active
2819908b-02cd-4094-a417-4c9db6a025bb	72ecf145-6884-41d5-bd1e-da35039b930f	data_source	obis_oceanexpert	active
9c1bd99a-80fe-4ca5-853d-05f6a8ad8e98	72ecf145-6884-41d5-bd1e-da35039b930f	sync_date	2025-09-22	active
2b7bf601-d681-43bc-8769-1e4d56be0c34	38ec64ce-f8b3-4ccd-a4e2-da3375ea1b87	ocean_expert_id	23197	active
c606a11e-8e75-4f75-960c-17c5a0e4ab5a	38ec64ce-f8b3-4ccd-a4e2-da3375ea1b87	data_source	obis_oceanexpert	active
b69e25ab-8fe0-428f-a14e-6fb3461bdd88	38ec64ce-f8b3-4ccd-a4e2-da3375ea1b87	sync_date	2025-09-22	active
1b239dba-7b07-4fdf-8cc3-2ee24539eaa2	a54646d7-acb9-4ea3-9343-f89998f264a4	ocean_expert_id	10566	active
5da07652-a3db-456b-8c69-78300f1270c7	a54646d7-acb9-4ea3-9343-f89998f264a4	data_source	obis_oceanexpert	active
4220a017-e67b-4dcf-b750-c30f7dc6b0e8	a54646d7-acb9-4ea3-9343-f89998f264a4	sync_date	2025-09-22	active
cc167203-c857-4a3c-bd64-f1aaf0ef887e	14653056-8541-41d0-a2b3-734760b78a49	ocean_expert_id	20112	active
bfd68d09-14f9-45d9-a743-f80a80fdccbb	14653056-8541-41d0-a2b3-734760b78a49	data_source	obis_oceanexpert	active
edb58c53-e344-478e-a712-a39755d87ff5	14653056-8541-41d0-a2b3-734760b78a49	sync_date	2025-09-22	active
9a252269-d58c-4fa3-b358-69846f1f9518	0a6d885d-16e2-4e6c-8f78-909e76e77498	ocean_expert_id	19576	active
9fb2b4fc-0f61-404f-8677-0fd505c5dc10	0a6d885d-16e2-4e6c-8f78-909e76e77498	data_source	obis_oceanexpert	active
12f29f44-c368-4f26-a324-be7e1c9a669d	0a6d885d-16e2-4e6c-8f78-909e76e77498	sync_date	2025-09-22	active
a5a3ae0e-be6c-4a58-bdcb-f1603dadba6e	c1353b20-43a4-48db-afce-c235c0d21698	ocean_expert_id	19584	active
f445fb51-8c60-41a2-87e4-e8c793237674	c1353b20-43a4-48db-afce-c235c0d21698	data_source	obis_oceanexpert	active
7af67ca6-7911-4d32-a6a3-3a3ed988cc27	c1353b20-43a4-48db-afce-c235c0d21698	sync_date	2025-09-22	active
01e57328-9f11-4223-971b-f7377c85463c	45cb320e-e6b7-4bb6-b7cb-5f26f82bdeaf	ocean_expert_id	19191	active
0d14874a-ba9b-4217-8ca0-526bdc7502c8	45cb320e-e6b7-4bb6-b7cb-5f26f82bdeaf	data_source	obis_oceanexpert	active
e10ce5da-b2fa-40ad-a26b-a2cfbeac9ea2	45cb320e-e6b7-4bb6-b7cb-5f26f82bdeaf	sync_date	2025-09-22	active
47ca25de-4657-47cb-a6dd-ccd91c578eb6	ce4fb67b-6511-4f4c-aa81-2c5420fc2ea6	ocean_expert_id	5053	active
d3d9ad77-471c-4c2b-9cb9-e9840fc64cba	ce4fb67b-6511-4f4c-aa81-2c5420fc2ea6	data_source	obis_oceanexpert	active
3d12c1b4-9fe5-41ca-a397-9d0c4f92a6ac	ce4fb67b-6511-4f4c-aa81-2c5420fc2ea6	sync_date	2025-09-22	active
7061aa06-e7e0-4ee9-b67d-5e2470859565	0ba72d15-bf93-4054-b617-295cea604bb5	ocean_expert_id	17272	active
9eb91771-a501-4d85-a89a-755df9f16a5a	0ba72d15-bf93-4054-b617-295cea604bb5	data_source	obis_oceanexpert	active
f097dfdf-0f01-4692-8444-a24f16f3d4ab	0ba72d15-bf93-4054-b617-295cea604bb5	sync_date	2025-09-22	active
3f51e44f-0372-4f55-a768-18a6d7d20a5d	7c34f5c0-445b-459a-bd5e-22f96833cd2c	ocean_expert_id	20451	active
5c670c70-baf8-4e87-b87e-686b528d26c7	7c34f5c0-445b-459a-bd5e-22f96833cd2c	data_source	obis_oceanexpert	active
09468929-3b14-442e-a3e2-5acb8163c4b0	7c34f5c0-445b-459a-bd5e-22f96833cd2c	sync_date	2025-09-22	active
ef02a29f-537c-4db8-8305-17c326d986e1	e3f190a8-f874-4276-84fb-f858a25bbefc	ocean_expert_id	20985	active
9c8a2e5b-5a56-4cdf-90fd-486cd316326f	e3f190a8-f874-4276-84fb-f858a25bbefc	data_source	obis_oceanexpert	active
014cb5af-3115-4a7a-a81d-f2d5794922cb	e3f190a8-f874-4276-84fb-f858a25bbefc	sync_date	2025-09-22	active
4e440095-9bbc-48b5-9f13-3a33563e17b4	578dd6fa-f3e7-4b1f-98c0-9707a0943ba8	ocean_expert_id	19173	active
09493b1b-ab99-4ab6-b4ab-39b97de0b97d	578dd6fa-f3e7-4b1f-98c0-9707a0943ba8	data_source	obis_oceanexpert	active
62efa9cf-4c83-4669-84ef-3e321e82c543	578dd6fa-f3e7-4b1f-98c0-9707a0943ba8	sync_date	2025-09-22	active
c1cb571c-b5b2-4cbd-8b63-d19d75be50d8	5a985427-7f22-46d7-bd22-aeddc7ad3e10	ocean_expert_id	5811	active
655699a1-6250-4a5a-b567-ddd26f224713	5a985427-7f22-46d7-bd22-aeddc7ad3e10	data_source	obis_oceanexpert	active
e2e1b178-5d52-4514-98fe-426ec4a8122c	5a985427-7f22-46d7-bd22-aeddc7ad3e10	sync_date	2025-09-22	active
8a41018f-4b23-48f3-9d0b-e859989e2453	3670b7bd-946d-4ef5-81a5-7b096970fffc	ocean_expert_id	13818	active
2c8fca41-5f00-4b23-9868-d32844edd677	3670b7bd-946d-4ef5-81a5-7b096970fffc	data_source	obis_oceanexpert	active
06f46c4e-6d62-436e-8883-6d6dcd72224d	3670b7bd-946d-4ef5-81a5-7b096970fffc	sync_date	2025-09-22	active
c6539796-c999-46bc-af4d-26de37172a48	f677db11-cdfc-4368-9ce0-121944ca84a1	ocean_expert_id	19280	active
11b69e7f-002e-4124-a4d8-cd163d325c41	f677db11-cdfc-4368-9ce0-121944ca84a1	data_source	obis_oceanexpert	active
e0d16c6b-44e6-4607-ac8a-5701bd0c5f73	f677db11-cdfc-4368-9ce0-121944ca84a1	sync_date	2025-09-22	active
7ed12561-d56e-4284-b709-e4475a39c79b	d7e650cc-411b-407f-955a-b6613b4c90bb	ocean_expert_id	20045	active
0e7449f3-d5ca-42a5-9808-5bdf340e6825	d7e650cc-411b-407f-955a-b6613b4c90bb	data_source	obis_oceanexpert	active
d15b4943-0da5-48f9-a108-6cf44ea0d023	d7e650cc-411b-407f-955a-b6613b4c90bb	sync_date	2025-09-22	active
2fe62582-4493-497d-b28b-272d8d3d35f3	a8d5729e-7683-4bed-97ba-41d0e3be5256	ocean_expert_id	19526	active
0f96f2cd-63e9-4f68-8390-710bd78781a8	a8d5729e-7683-4bed-97ba-41d0e3be5256	data_source	obis_oceanexpert	active
b5c3e9af-2907-470f-8ee9-1deec35bff46	a8d5729e-7683-4bed-97ba-41d0e3be5256	sync_date	2025-09-22	active
45fd23d4-b69e-4e8a-b1fb-53554272bd50	8a296a60-bfde-49d2-97fe-fcd2324f0bdd	ocean_expert_id	19488	active
98f57c5f-17c9-462a-9d63-99c2a4464b1d	8a296a60-bfde-49d2-97fe-fcd2324f0bdd	data_source	obis_oceanexpert	active
240cd322-dd66-4959-a809-65766e0d90d6	8a296a60-bfde-49d2-97fe-fcd2324f0bdd	sync_date	2025-09-22	active
12940079-b997-4c9a-a537-a7375b5c6d67	1d23733b-3ed4-4ed6-8b3f-fae276fedec8	ocean_expert_id	17811	active
b3aba71d-e4fe-423b-a5bc-0e632c421fa4	1d23733b-3ed4-4ed6-8b3f-fae276fedec8	data_source	obis_oceanexpert	active
4554dca7-15aa-46a7-bf5f-2a0aa344ea5a	1d23733b-3ed4-4ed6-8b3f-fae276fedec8	sync_date	2025-09-22	active
aa85423a-02ff-4fcc-a33c-1661a6bdad04	3e1fb479-298b-4eff-941a-f310e8d3d577	ocean_expert_id	21791	active
4560f466-c026-4c93-ac08-060323354571	3e1fb479-298b-4eff-941a-f310e8d3d577	data_source	obis_oceanexpert	active
cdc868bc-fb3d-445c-808d-52368e95e217	3e1fb479-298b-4eff-941a-f310e8d3d577	sync_date	2025-09-22	active
0750e793-ea65-4d81-b70f-138e230ac2e2	14d675a7-d1f2-49ea-9a1e-162eb685c77a	ocean_expert_id	19473	active
a0ef5e66-91b9-4feb-9b75-2d36d887aa65	14d675a7-d1f2-49ea-9a1e-162eb685c77a	data_source	obis_oceanexpert	active
f2efa00c-c590-4660-87f2-6bb0c6b6b7fa	14d675a7-d1f2-49ea-9a1e-162eb685c77a	sync_date	2025-09-22	active
2277879c-95ed-4c79-b938-29f7f2f4135d	39a98f06-6b1a-4992-9a3b-d9bb8a8e4b6e	ocean_expert_id	19398	active
5945c4bc-7830-4bce-90d5-29a7f7f15978	39a98f06-6b1a-4992-9a3b-d9bb8a8e4b6e	data_source	obis_oceanexpert	active
6939de9c-2e6c-4485-aac7-2a7562b410eb	39a98f06-6b1a-4992-9a3b-d9bb8a8e4b6e	sync_date	2025-09-22	active
73dc90b3-d11e-42be-98b3-c0cfaba695c0	9db06246-8fe2-4beb-a72b-955c2c4b900a	ocean_expert_id	13853	active
c8e4f97c-d5ed-4738-8bbb-f18fda462857	9db06246-8fe2-4beb-a72b-955c2c4b900a	data_source	obis_oceanexpert	active
c60927bc-ad29-44d5-bd9e-9dc7f7498e87	9db06246-8fe2-4beb-a72b-955c2c4b900a	sync_date	2025-09-22	active
3980de31-dada-47b2-9e0b-cf519a6a5ba6	f94f0237-b7ba-4017-8822-ee1f639aa822	ocean_expert_id	22762	active
c26a0933-02c1-4fa7-b46e-beabbadff2d5	f94f0237-b7ba-4017-8822-ee1f639aa822	data_source	obis_oceanexpert	active
85e93222-6d3f-4207-8864-600d6eb52832	f94f0237-b7ba-4017-8822-ee1f639aa822	sync_date	2025-09-22	active
2786dcc5-858e-4c8a-86c2-ed3a329954e9	18766a0e-02b1-4822-a081-482843b09fbd	ocean_expert_id	19361	active
5923e084-a05d-451a-b8cd-f1082238e7b6	18766a0e-02b1-4822-a081-482843b09fbd	data_source	obis_oceanexpert	active
72463fbd-6ac9-4b72-afd6-8817879b80d0	18766a0e-02b1-4822-a081-482843b09fbd	sync_date	2025-09-22	active
6c04ce68-3877-4ca3-bac7-6fb90525c58c	cc0710f8-adae-4cd6-a2e7-4c7952cbf434	ocean_expert_id	20849	active
c67aa81c-65dd-46d9-8e0f-c5b82d13751c	cc0710f8-adae-4cd6-a2e7-4c7952cbf434	data_source	obis_oceanexpert	active
ba4e7c84-f008-4b21-bcfc-4a65196e42ff	cc0710f8-adae-4cd6-a2e7-4c7952cbf434	sync_date	2025-09-22	active
d388a832-04db-4627-b95a-7bf77dc2c257	8a6b18a8-42f3-4dab-ad4c-d955e42f45da	ocean_expert_id	20855	active
cdf2c8d9-611d-4183-a92d-3e309e2aea41	8a6b18a8-42f3-4dab-ad4c-d955e42f45da	data_source	obis_oceanexpert	active
5e8f02cd-73c0-4e3d-aa14-a68f18f05623	8a6b18a8-42f3-4dab-ad4c-d955e42f45da	sync_date	2025-09-22	active
6719f648-a56d-4b39-9319-8fe12d6e40f9	5c3cc68d-d631-48bc-b014-21ccf3575b4b	ocean_expert_id	7304	active
17218f2d-930e-46e5-8c33-22b030695435	5c3cc68d-d631-48bc-b014-21ccf3575b4b	data_source	obis_oceanexpert	active
b4b408cc-30d9-4e59-8210-4c1768e46374	5c3cc68d-d631-48bc-b014-21ccf3575b4b	sync_date	2025-09-22	active
e7c01f2b-5d24-42c9-84c9-32182429d25e	71f19e42-5d5f-4e60-b210-d7ace05fa1ce	ocean_expert_id	19424	active
59441ab4-7c30-4c2b-a73f-31a6c1422ef9	71f19e42-5d5f-4e60-b210-d7ace05fa1ce	data_source	obis_oceanexpert	active
cc8188a1-5e10-45db-80ee-3cf768284ec4	71f19e42-5d5f-4e60-b210-d7ace05fa1ce	sync_date	2025-09-22	active
26ee2de1-19e5-4d24-9212-2f0eb5f4ebfa	5f755450-77f2-4464-92eb-2603af8bb620	ocean_expert_id	18726	active
1644928c-90ef-4c21-809d-cbb4ce3a7e79	5f755450-77f2-4464-92eb-2603af8bb620	data_source	obis_oceanexpert	active
bceb89b8-bc2d-4ac7-9f0c-904fafb8511f	5f755450-77f2-4464-92eb-2603af8bb620	sync_date	2025-09-22	active
6feba3ab-4416-42d2-aaef-5dad7c23da6e	cd0f0ebf-9da5-4c2c-b659-5c38c2110585	ocean_expert_id	19494	active
3ef1c3bf-afec-4699-be87-85ec8938caa8	cd0f0ebf-9da5-4c2c-b659-5c38c2110585	data_source	obis_oceanexpert	active
ff9661cb-1332-4f75-881c-c7bb60ae0ba0	cd0f0ebf-9da5-4c2c-b659-5c38c2110585	sync_date	2025-09-22	active
d6158196-53b0-4733-af2c-51688f1c9d89	957e2ff4-5c75-4e3f-bab1-475aa7a49bce	ocean_expert_id	11144	active
df9d28be-2ae1-4ebd-b341-d4e22ba6c2af	957e2ff4-5c75-4e3f-bab1-475aa7a49bce	data_source	obis_oceanexpert	active
481a973d-8c7a-46f7-a871-6ee11c110ae0	957e2ff4-5c75-4e3f-bab1-475aa7a49bce	sync_date	2025-09-22	active
0f959715-2d33-473e-a7a7-9ce3a735b01c	22350a3c-c83e-45f2-adc5-9808b43af107	ocean_expert_id	23194	active
7729c1b3-42c2-47f7-bada-ae34e9e33bd2	22350a3c-c83e-45f2-adc5-9808b43af107	data_source	obis_oceanexpert	active
c0dff655-72bd-4611-a59a-4d886590ba00	22350a3c-c83e-45f2-adc5-9808b43af107	sync_date	2025-09-22	active
755c4950-61d6-419b-b31d-1b8386f8e3e0	0a6bdabd-17d3-46b8-b8b7-2acbdafadd4f	ocean_expert_id	19310	active
bac21a52-1bec-4222-bdab-4e646faf2daf	0a6bdabd-17d3-46b8-b8b7-2acbdafadd4f	data_source	obis_oceanexpert	active
d9aaf66a-4b4f-4f8c-bd59-470ec5c8d9cd	0a6bdabd-17d3-46b8-b8b7-2acbdafadd4f	sync_date	2025-09-22	active
2dd9cffd-48ab-4397-a046-e20e70a5447d	a9d14ae5-3e72-4fd6-aa83-df22c98f88f0	ocean_expert_id	17680	active
6b6d4ee7-99e2-4691-8204-eab42ba71ba3	a9d14ae5-3e72-4fd6-aa83-df22c98f88f0	data_source	obis_oceanexpert	active
156166b7-3898-432b-a2e2-b60ebe974fcc	a9d14ae5-3e72-4fd6-aa83-df22c98f88f0	sync_date	2025-09-22	active
6d7f34d8-d61a-403a-b4a0-11aea5488c83	790f7f15-d509-4411-9793-6109e8d44ae6	ocean_expert_id	21890	active
a957ec93-4de6-459a-8f96-1f15f3079768	790f7f15-d509-4411-9793-6109e8d44ae6	data_source	obis_oceanexpert	active
06d65fa5-57e1-4140-ac2e-0eae4b8eaab6	790f7f15-d509-4411-9793-6109e8d44ae6	sync_date	2025-09-22	active
a4f3d515-142c-4fcf-aab5-16703245d444	56b34daf-4f9b-4903-bcb5-141dd7e57416	ocean_expert_id	5091	active
5c8e9cae-dff8-4ee9-8461-69a6105373b7	56b34daf-4f9b-4903-bcb5-141dd7e57416	data_source	obis_oceanexpert	active
689f52e4-3305-494e-8d80-1752d94d3d6f	56b34daf-4f9b-4903-bcb5-141dd7e57416	sync_date	2025-09-22	active
cf7b4f9a-d98a-4e6b-b767-d96daccb2160	319ddbdb-0b65-49af-a139-b2442cabc7fe	ocean_expert_id	19059	active
3d07e10c-fc4b-4478-8f4d-2933c6661171	319ddbdb-0b65-49af-a139-b2442cabc7fe	data_source	obis_oceanexpert	active
0f59c8b9-8e05-44c8-a8e3-9ff401e929ef	319ddbdb-0b65-49af-a139-b2442cabc7fe	sync_date	2025-09-22	active
a38c9082-3ad0-42c1-8259-b02e2d751157	d8330346-9980-462b-bbfd-68c0f11b5d29	ocean_expert_id	21892	active
c5a1846f-3815-40b9-ad1e-aa61dbc3354c	d8330346-9980-462b-bbfd-68c0f11b5d29	data_source	obis_oceanexpert	active
ea413f3f-481a-41e6-81e0-d9a9268c257a	d8330346-9980-462b-bbfd-68c0f11b5d29	sync_date	2025-09-22	active
bea0a033-9747-41f3-92eb-db2a7d23b908	1cd90651-b3f0-4fad-ab76-be61c5594c3d	ocean_expert_id	19281	active
3387f2c5-1f34-40b5-8f11-70138c5f3675	1cd90651-b3f0-4fad-ab76-be61c5594c3d	data_source	obis_oceanexpert	active
805215e9-a72d-4b1d-a629-48045370a0f0	1cd90651-b3f0-4fad-ab76-be61c5594c3d	sync_date	2025-09-22	active
913efb91-1d6c-44e0-8024-379f4f7a5b00	ebaf77ce-93bf-4735-a41f-d26a9a678c16	ocean_expert_id	18799	active
d624017b-2587-438b-86d8-42aacfefc519	ebaf77ce-93bf-4735-a41f-d26a9a678c16	data_source	obis_oceanexpert	active
14384199-9910-4c54-9b0a-6d15c3afdaca	ebaf77ce-93bf-4735-a41f-d26a9a678c16	sync_date	2025-09-22	active
172e3324-8886-47da-9e69-b7618dbfcd56	7c943458-177c-489a-911a-c25531396c79	ocean_expert_id	20548	active
c2469867-0232-4838-b7c3-ab25d91eef79	7c943458-177c-489a-911a-c25531396c79	data_source	obis_oceanexpert	active
e0da043a-93b7-457e-8e15-d1fd2e8c7008	7c943458-177c-489a-911a-c25531396c79	sync_date	2025-09-22	active
d49a48ab-caf9-44e7-9790-0c8e5d33960c	55aa18f2-1792-4a23-93dc-ebda8ee05769	ocean_expert_id	10307	active
2259b18b-10ea-4361-9a72-2e9c72b79e32	55aa18f2-1792-4a23-93dc-ebda8ee05769	data_source	obis_oceanexpert	active
3a52f969-e04c-4436-a412-2bac851b2bf7	55aa18f2-1792-4a23-93dc-ebda8ee05769	sync_date	2025-09-22	active
64c079f2-926f-4356-9e11-d370a8111c3f	33a71dd7-05c3-4b7c-bb9d-4bc5c73bbba4	ocean_expert_id	9039	active
63be6d96-b074-43ce-98b9-afcee171359e	33a71dd7-05c3-4b7c-bb9d-4bc5c73bbba4	data_source	obis_oceanexpert	active
cbe56399-bf7c-4b06-b614-12c3c3ca069d	33a71dd7-05c3-4b7c-bb9d-4bc5c73bbba4	sync_date	2025-09-22	active
0fb8690b-2570-490a-a290-6a5cd256706e	f3f82d23-b44c-4229-b616-e7fa7419cafa	ocean_expert_id	16784	active
1f97dd21-db24-439e-a5e5-eaee733d503e	f3f82d23-b44c-4229-b616-e7fa7419cafa	data_source	obis_oceanexpert	active
beeab782-4b49-41a2-b816-2c4acb2f53cc	f3f82d23-b44c-4229-b616-e7fa7419cafa	sync_date	2025-09-22	active
3e3d2edb-346f-4351-baaa-da2bba7725e0	4e23aad2-247e-41df-a8b8-359b9157fd62	ocean_expert_id	11218	active
bc2e193c-4263-4ec8-aec8-66ffea7822bc	4e23aad2-247e-41df-a8b8-359b9157fd62	data_source	obis_oceanexpert	active
772e86c5-0929-42a4-9206-56eb334d4805	4e23aad2-247e-41df-a8b8-359b9157fd62	sync_date	2025-09-22	active
361fdd38-c3f1-4db2-a3d9-21831887a1ab	15ccbbcb-4b8e-4b97-8297-c486593f7a76	ocean_expert_id	12678	active
48d54103-a349-4de3-aff8-b8b3aeb5817b	15ccbbcb-4b8e-4b97-8297-c486593f7a76	data_source	obis_oceanexpert	active
59af9d85-9c2e-4c96-8fd9-20c34c823da9	15ccbbcb-4b8e-4b97-8297-c486593f7a76	sync_date	2025-09-22	active
784bf164-f2ed-4176-8913-5a3b7937e6ba	781f9b8e-bdce-4400-9519-2c072a788345	ocean_expert_id	19509	active
c240b54a-d332-43a8-9517-b76f3b43b31e	781f9b8e-bdce-4400-9519-2c072a788345	data_source	obis_oceanexpert	active
e75e7abe-4b49-42b8-921f-5a643e8f5a43	781f9b8e-bdce-4400-9519-2c072a788345	sync_date	2025-09-22	active
e4cccb0a-78ec-4f85-82e9-89fbcb7e07f5	06976510-431b-47ad-95c5-b0205ec11367	ocean_expert_id	20889	active
459c111b-eb0b-4d86-a091-8bddc70e8f2d	06976510-431b-47ad-95c5-b0205ec11367	data_source	obis_oceanexpert	active
24ecc619-7978-4384-8a4a-1abdcb7d323f	06976510-431b-47ad-95c5-b0205ec11367	sync_date	2025-09-22	active
8fe07ee2-490c-4548-ae51-0b547c84d03e	bc254a05-5330-4808-b9df-905609fb2f95	ocean_expert_id	5583	active
81ee8e61-f547-4689-bd71-fb5ee6c7c18a	bc254a05-5330-4808-b9df-905609fb2f95	data_source	obis_oceanexpert	active
0e0efb1b-88cd-469b-b537-3e7b5d757d48	bc254a05-5330-4808-b9df-905609fb2f95	sync_date	2025-09-22	active
6fafe2ad-da82-4269-a085-672d04598770	273eda46-d046-4410-8132-10e776acdb86	ocean_expert_id	20784	active
9cd798f3-e2da-4d80-ad99-750d87e1b348	273eda46-d046-4410-8132-10e776acdb86	data_source	obis_oceanexpert	active
b07d8f41-3c41-4b1d-bced-6ee35b99399c	273eda46-d046-4410-8132-10e776acdb86	sync_date	2025-09-22	active
f01b3894-587f-497d-9ff9-1b3b95683812	e076a784-c13a-4875-8260-7db7edc1ace3	ocean_expert_id	19435	active
6ec17bd1-3d7b-4944-87e6-27ba0b0de715	e076a784-c13a-4875-8260-7db7edc1ace3	data_source	obis_oceanexpert	active
2e1e7456-521f-4d93-bfe0-0a7d55fb5802	e076a784-c13a-4875-8260-7db7edc1ace3	sync_date	2025-09-22	active
62b7be9f-8328-4cc4-ab99-15b9c99aaba4	c0f0cc1b-3957-481e-bd3a-2ce18a3485a9	ocean_expert_id	23191	active
422e22f1-072e-40cf-bd89-07e8a7f70cb9	c0f0cc1b-3957-481e-bd3a-2ce18a3485a9	data_source	obis_oceanexpert	active
7c1aa016-f3f0-4c75-9d8b-62189f5685a8	c0f0cc1b-3957-481e-bd3a-2ce18a3485a9	sync_date	2025-09-22	active
c96aec2c-e8b7-48b5-a76c-3af3ad8b678c	2fb53a11-bc7b-4382-9103-4169636ce0c8	ocean_expert_id	19340	active
1ab78dde-6621-4405-9413-1a3b1525e4f3	2fb53a11-bc7b-4382-9103-4169636ce0c8	data_source	obis_oceanexpert	active
18acbe44-4abc-4fe1-a71e-6818b4348c37	2fb53a11-bc7b-4382-9103-4169636ce0c8	sync_date	2025-09-22	active
a8ef5603-1bba-4293-84f7-d55ceb7d4b95	3161c47e-40d4-476f-aa67-af91613c6b05	ocean_expert_id	17300	active
eb04eba5-bf0d-4159-a9ee-27eed05dee72	3161c47e-40d4-476f-aa67-af91613c6b05	data_source	obis_oceanexpert	active
ccacc2dd-305c-4127-b749-8eb45db21e46	3161c47e-40d4-476f-aa67-af91613c6b05	sync_date	2025-09-22	active
05503aef-5281-4360-b1eb-27b85f4155a4	7daf6658-d28d-4996-ae3a-d1bc3a588624	ocean_expert_id	19502	active
f569bd8b-17af-4561-9db5-fbaee8a7ab93	7daf6658-d28d-4996-ae3a-d1bc3a588624	data_source	obis_oceanexpert	active
be096c79-0d5a-466e-a739-4dc8bbe297aa	7daf6658-d28d-4996-ae3a-d1bc3a588624	sync_date	2025-09-22	active
37f81df7-f7da-4f10-b9af-b9e9a98f08ec	e030f2f2-bc17-4bfc-b79f-0766cc77c538	ocean_expert_id	19553	active
c3d6aa33-fda5-44bb-9016-ce1a16ea1c66	e030f2f2-bc17-4bfc-b79f-0766cc77c538	data_source	obis_oceanexpert	active
40608e3c-0f04-4a0c-bc92-704b646c4be9	e030f2f2-bc17-4bfc-b79f-0766cc77c538	sync_date	2025-09-22	active
579297ed-1bdc-4d05-9133-23202f44513f	c47dcbae-9ede-452b-96ce-a36b2f7c1502	ocean_expert_id	20892	active
827f1ae7-5b68-41dd-afbf-249cbec83b64	c47dcbae-9ede-452b-96ce-a36b2f7c1502	data_source	obis_oceanexpert	active
d10cf32b-0b0b-4410-a233-b4f73e089c54	c47dcbae-9ede-452b-96ce-a36b2f7c1502	sync_date	2025-09-22	active
8974c6dc-d56f-46fb-811e-eb89354c3468	8c04baba-b920-4a37-bb07-6abf7073447c	ocean_expert_id	67	active
763156d4-66bf-4bb1-9296-2ec078880d7a	8c04baba-b920-4a37-bb07-6abf7073447c	data_source	obis_oceanexpert	active
8b3a8909-f1cf-4846-9b4e-ca1d14add26e	8c04baba-b920-4a37-bb07-6abf7073447c	sync_date	2025-09-22	active
d3fac6b5-21ad-41cb-a522-73573af9cf9d	5f584f24-3c78-470b-ae63-730e55531cad	ocean_expert_id	20814	active
b32939e2-d1b3-40de-9eec-bb157400907a	5f584f24-3c78-470b-ae63-730e55531cad	data_source	obis_oceanexpert	active
bcffca15-bd20-441b-99a6-fbd6a84b14d1	5f584f24-3c78-470b-ae63-730e55531cad	sync_date	2025-09-22	active
9ff0a716-6594-437a-af49-4cdf7c3e9784	7e4b70fe-a40d-49e4-a6b1-8bc5cf7060ca	ocean_expert_id	19490	active
c40ff013-78d6-4460-be5a-a98820ea85bf	7e4b70fe-a40d-49e4-a6b1-8bc5cf7060ca	data_source	obis_oceanexpert	active
80fd2fd4-1603-4b66-9e6c-629ee977360a	7e4b70fe-a40d-49e4-a6b1-8bc5cf7060ca	sync_date	2025-09-22	active
abf9b204-03f6-4655-abba-3b29186690f1	4091fe33-4ada-430a-a7af-29988307eb8b	ocean_expert_id	18847	active
669f860f-3a26-496b-89a4-526ed643be1f	4091fe33-4ada-430a-a7af-29988307eb8b	data_source	obis_oceanexpert	active
183def94-4d47-409a-b0e5-858754a6cc40	4091fe33-4ada-430a-a7af-29988307eb8b	sync_date	2025-09-22	active
b6cf56b2-4f3f-4152-a150-7da1216235b7	9534a9bd-538e-449b-8d38-a11bbb125157	ocean_expert_id	10093	active
7a39da8d-b14a-40de-adfc-677871a715cd	9534a9bd-538e-449b-8d38-a11bbb125157	data_source	obis_oceanexpert	active
e6352f51-aad6-4d2b-8fa9-f089f8bca39d	9534a9bd-538e-449b-8d38-a11bbb125157	sync_date	2025-09-22	active
21ee6524-9c31-45f9-88cb-00492e9a86f2	ea1b9a7d-6bc9-4e7b-a203-f9675c718e12	ocean_expert_id	19385	active
acae946b-5267-4ef0-8471-fd3b7460c22b	ea1b9a7d-6bc9-4e7b-a203-f9675c718e12	data_source	obis_oceanexpert	active
f40920a8-f115-40c0-998a-845896472e97	ea1b9a7d-6bc9-4e7b-a203-f9675c718e12	sync_date	2025-09-22	active
0a7257a6-ba52-4eeb-83d7-764c6a6974e9	5e2a5f0e-4bae-4ee6-a1f6-a83b7fc05983	ocean_expert_id	19533	active
e2799e1b-c47e-460b-8ab4-0da264dc443e	5e2a5f0e-4bae-4ee6-a1f6-a83b7fc05983	data_source	obis_oceanexpert	active
407e374b-7b86-42a5-8c9e-b0a10c65d3ad	5e2a5f0e-4bae-4ee6-a1f6-a83b7fc05983	sync_date	2025-09-22	active
a15466f3-413a-4664-90a1-625e519a548e	1c6b0c0c-f86d-4b92-b65b-75c21042fb8e	ocean_expert_id	19565	active
24a4b094-c1ba-41e7-ba5e-1240230a4c43	1c6b0c0c-f86d-4b92-b65b-75c21042fb8e	data_source	obis_oceanexpert	active
846bf50d-1ccb-4720-8f02-f2d204aa30d4	1c6b0c0c-f86d-4b92-b65b-75c21042fb8e	sync_date	2025-09-22	active
d69fabcf-2e1c-42b3-9513-e372f2be2e9a	38cf0810-99e0-4ea4-a6b7-87103db5bd51	ocean_expert_id	19577	active
4c70d985-29a4-43af-bb8f-3c434aceb5ae	38cf0810-99e0-4ea4-a6b7-87103db5bd51	data_source	obis_oceanexpert	active
f042a537-632a-4219-8c59-2fca4a84b904	38cf0810-99e0-4ea4-a6b7-87103db5bd51	sync_date	2025-09-22	active
99a033f9-c858-4a7b-8eee-6901291b3eff	95a7fa73-5bb4-46c3-ac72-e9555e97a129	ocean_expert_id	19391	active
2a5fcc52-b289-46ee-8bef-08fbc1afa358	95a7fa73-5bb4-46c3-ac72-e9555e97a129	data_source	obis_oceanexpert	active
1f06f73f-7a74-495a-9448-882e1906ec06	95a7fa73-5bb4-46c3-ac72-e9555e97a129	sync_date	2025-09-22	active
bd8e377c-6bbd-49d1-82cb-4b02b24b62a6	896717b9-05b3-4b2b-8a38-22371e16353a	ocean_expert_id	18934	active
4e3ffe53-e5ea-443b-9bfc-47ac76a43e69	896717b9-05b3-4b2b-8a38-22371e16353a	data_source	obis_oceanexpert	active
66a866cc-03d0-456d-ab9d-a20f743437fd	896717b9-05b3-4b2b-8a38-22371e16353a	sync_date	2025-09-22	active
44b06997-5a7d-44e0-84e1-2ae9b61ac2f1	2f740479-94fc-4f47-823e-76f41a10a7b9	ocean_expert_id	19395	active
b4cf0484-5b67-44ea-8250-e4751f4512d3	2f740479-94fc-4f47-823e-76f41a10a7b9	data_source	obis_oceanexpert	active
ef349570-2c17-4b62-a79e-91d0abd77041	2f740479-94fc-4f47-823e-76f41a10a7b9	sync_date	2025-09-22	active
93da9c9c-900a-46f4-b5d7-dc18177224d0	320c32cf-8bde-428e-a241-5a1a1ebc923a	ocean_expert_id	5170	active
6ba337ec-bfe6-4426-9d1e-a0ad165b3833	320c32cf-8bde-428e-a241-5a1a1ebc923a	data_source	obis_oceanexpert	active
e1837a80-4563-44b8-97ea-c65a1f20f3f7	320c32cf-8bde-428e-a241-5a1a1ebc923a	sync_date	2025-09-22	active
7aaee6dc-24f0-4d03-9ae0-f3f03ada29b3	a4e695b8-5b32-41d2-9f6a-729f9e7d8861	ocean_expert_id	9456	active
3d94c0ec-8eb0-4b4e-9d82-13941e173355	a4e695b8-5b32-41d2-9f6a-729f9e7d8861	data_source	obis_oceanexpert	active
86e3607f-9b87-4f22-9fa9-ac454401e4a5	a4e695b8-5b32-41d2-9f6a-729f9e7d8861	sync_date	2025-09-22	active
cd29ab9f-ef08-420e-ab6f-35b1880d3afd	76444f19-f085-4f64-b58c-831be1b301c5	ocean_expert_id	16706	active
074c5268-6506-4df2-a4da-6134d496c8a8	76444f19-f085-4f64-b58c-831be1b301c5	data_source	obis_oceanexpert	active
35afb031-a358-4948-8598-a6ad60abec32	76444f19-f085-4f64-b58c-831be1b301c5	sync_date	2025-09-22	active
4023bc1c-8f37-4d6b-add3-952825fecd6f	26d3f977-6e82-4581-b1c6-c5cf1ae82370	ocean_expert_id	19302	active
463a3277-350d-4513-802b-cb66ed40d6bd	26d3f977-6e82-4581-b1c6-c5cf1ae82370	data_source	obis_oceanexpert	active
ce548ecb-16ad-4641-857a-ecfb107bf950	26d3f977-6e82-4581-b1c6-c5cf1ae82370	sync_date	2025-09-22	active
54051a8a-ef8f-4ee1-b9a9-21d1f673b2b9	31724b87-bf0c-4298-80eb-e24291b984fa	ocean_expert_id	19452	active
d091f8f2-5a71-425f-9cf4-fd3111bf2965	31724b87-bf0c-4298-80eb-e24291b984fa	data_source	obis_oceanexpert	active
85e52ca8-994d-4d46-a18d-649a0c3ef925	31724b87-bf0c-4298-80eb-e24291b984fa	sync_date	2025-09-22	active
24bd1964-57dc-4b79-b56e-062bb04c54a0	77d6ca18-7168-43d0-9972-4975c20cc79a	ocean_expert_id	19504	active
edb9d151-a6a3-451d-b715-127842d50b82	77d6ca18-7168-43d0-9972-4975c20cc79a	data_source	obis_oceanexpert	active
bfcf2464-eb90-49fe-aa30-927d0e896f57	77d6ca18-7168-43d0-9972-4975c20cc79a	sync_date	2025-09-22	active
8cf6df02-aa6e-48a3-8e95-67009e0dedb0	ea3a236c-45d7-4c32-919a-c10da2dd7860	ocean_expert_id	19558	active
7b79700a-167b-438b-87fa-4031391746f0	ea3a236c-45d7-4c32-919a-c10da2dd7860	data_source	obis_oceanexpert	active
7a679e9c-5a14-4fa0-b306-e7ee172fb027	ea3a236c-45d7-4c32-919a-c10da2dd7860	sync_date	2025-09-22	active
de1485e9-2af2-4251-8978-e7a9c0e9a7fe	0e2c5d11-b457-4591-a6fd-ccdca7c374e7	ocean_expert_id	19594	active
b459ab68-8b23-4fea-8cb0-e9001d9f8460	0e2c5d11-b457-4591-a6fd-ccdca7c374e7	data_source	obis_oceanexpert	active
61399408-43d1-457c-94e4-82252764341c	0e2c5d11-b457-4591-a6fd-ccdca7c374e7	sync_date	2025-09-22	active
e43517e8-d286-44f9-a6ee-1404f6981a0f	a97a215d-523e-4f91-8367-44d18fefd38c	ocean_expert_id	19606	active
6de7a360-7cd2-46c3-9280-0869942b61f2	a97a215d-523e-4f91-8367-44d18fefd38c	data_source	obis_oceanexpert	active
f79fab76-7975-4d2b-b8ba-a1d070fb5c71	a97a215d-523e-4f91-8367-44d18fefd38c	sync_date	2025-09-22	active
4e390871-d97d-4bcb-a8aa-9f103412a5a4	59466127-5c6e-43ad-853f-d9e1a37ec452	ocean_expert_id	19534	active
4f9f10d3-6b08-48fb-a56f-6f0798bb9f5d	59466127-5c6e-43ad-853f-d9e1a37ec452	data_source	obis_oceanexpert	active
adb2a653-3718-46f7-94e0-1585a1172e79	59466127-5c6e-43ad-853f-d9e1a37ec452	sync_date	2025-09-22	active
e9d4abe9-e8f0-4abd-a97f-13320eb4a4e3	1e64082e-1d09-4520-91e2-6ddf17f84332	ocean_expert_id	16726	active
3acc5232-7474-4bb9-8717-110a14b262c7	1e64082e-1d09-4520-91e2-6ddf17f84332	data_source	obis_oceanexpert	active
499d123a-9276-4071-8a30-1e5ed5f2387b	1e64082e-1d09-4520-91e2-6ddf17f84332	sync_date	2025-09-22	active
45bfeb3c-e1cb-4bee-beca-b68c1a7bf7eb	21bf7239-177e-4a8a-9680-51331a64e26e	ocean_expert_id	19487	active
8b3388d1-e4c3-40e2-a7a8-eadc5c61519f	21bf7239-177e-4a8a-9680-51331a64e26e	data_source	obis_oceanexpert	active
f2538278-bdb4-411e-b228-5058a34168e1	21bf7239-177e-4a8a-9680-51331a64e26e	sync_date	2025-09-22	active
884f0a71-88f3-4be2-b16d-d190caa3ef7a	38755801-6e78-4e0a-94af-c7791e702f6e	ocean_expert_id	23195	active
1d5449cd-fb91-48d2-b48f-8d9943f663d6	38755801-6e78-4e0a-94af-c7791e702f6e	data_source	obis_oceanexpert	active
ecf126aa-4493-4f8c-aff5-df8d0748b17f	38755801-6e78-4e0a-94af-c7791e702f6e	sync_date	2025-09-22	active
8875e534-d739-45f2-99a5-6aa4c6dc7371	7912a981-e5a0-4975-b53d-30830d129ca1	ocean_expert_id	19406	active
3b5e56af-dd0a-46b5-9ab1-5bd1d1ce360a	7912a981-e5a0-4975-b53d-30830d129ca1	data_source	obis_oceanexpert	active
8ee029b1-0e60-4cd4-9e24-e29cf5b8d7bc	7912a981-e5a0-4975-b53d-30830d129ca1	sync_date	2025-09-22	active
cbdb73bf-1e3a-4eee-94b0-2fc5885c9df5	b0992960-4c48-45f3-9e16-c1f1bad299f6	ocean_expert_id	19336	active
6c1f403f-8538-42f2-93de-40d183fedda3	b0992960-4c48-45f3-9e16-c1f1bad299f6	data_source	obis_oceanexpert	active
88990bab-8fda-4af3-a45c-45c9eefb7523	b0992960-4c48-45f3-9e16-c1f1bad299f6	sync_date	2025-09-22	active
e29a8f5e-acca-48d1-a893-0a4d79cdb01b	bf0c1ec5-ac35-47ff-a6a8-5f84795bfd02	ocean_expert_id	18758	active
9876b56e-1b5e-42f3-8e20-744b675d30ce	bf0c1ec5-ac35-47ff-a6a8-5f84795bfd02	data_source	obis_oceanexpert	active
0278dea7-0a81-4607-8d3b-dbf451bdb7de	bf0c1ec5-ac35-47ff-a6a8-5f84795bfd02	sync_date	2025-09-22	active
6bb7f1d1-5ecb-4dc0-8fd3-e6992a3aabed	baba4053-fb2e-4edb-be66-944cfc931bd2	ocean_expert_id	19394	active
80921f42-1435-4aec-baf1-26d77bfd1152	baba4053-fb2e-4edb-be66-944cfc931bd2	data_source	obis_oceanexpert	active
6d06ff14-7cd5-4064-8629-6d519b8b6955	baba4053-fb2e-4edb-be66-944cfc931bd2	sync_date	2025-09-22	active
7583013f-137f-411c-ab96-a721ad013267	e7c382c7-84b1-40bd-af9c-b7933c66bfbe	ocean_expert_id	19400	active
c53bb758-6d91-4b07-9d74-42165912b5e0	e7c382c7-84b1-40bd-af9c-b7933c66bfbe	data_source	obis_oceanexpert	active
aad8be18-3dc3-4084-b9a5-76908524a928	e7c382c7-84b1-40bd-af9c-b7933c66bfbe	sync_date	2025-09-22	active
94d964a3-b4eb-4296-8baa-68a3bed4aad2	b8049a5b-f24a-43a6-8262-504a5173708d	ocean_expert_id	19618	active
5ad275df-81ee-4677-894a-100991e2dbf6	b8049a5b-f24a-43a6-8262-504a5173708d	data_source	obis_oceanexpert	active
1dd50ab0-521a-431a-97cc-e44df3792727	b8049a5b-f24a-43a6-8262-504a5173708d	sync_date	2025-09-22	active
2d7af030-eb07-4db3-9d9d-72ea836b3269	c199db40-ff32-499e-9257-ae6c8007bc94	ocean_expert_id	6941	active
cc8f086a-f2f3-4a14-84ff-a09f96c0a64e	c199db40-ff32-499e-9257-ae6c8007bc94	data_source	obis_oceanexpert	active
4dd6d9b9-fbc1-43a3-a174-5d2b63336cb3	c199db40-ff32-499e-9257-ae6c8007bc94	sync_date	2025-09-22	active
9909598a-b5e7-4743-9957-03bb2fe47766	0cff2f7b-0fe9-4942-a56a-51fc4135d432	ocean_expert_id	9238	active
572dec07-420f-4b94-a371-18b01d75d3a4	0cff2f7b-0fe9-4942-a56a-51fc4135d432	data_source	obis_oceanexpert	active
5890af67-1365-4386-9992-a08e2f3d86de	0cff2f7b-0fe9-4942-a56a-51fc4135d432	sync_date	2025-09-22	active
aa91bcbd-707c-4d71-98ed-0751df1ef1a3	081bdd5a-3455-4cf1-9ed9-ddd146a2d170	ocean_expert_id	19541	active
f2906450-d5fd-4c3f-9b91-75792ba5cedb	081bdd5a-3455-4cf1-9ed9-ddd146a2d170	data_source	obis_oceanexpert	active
ff87c5b2-ccef-4ec5-909f-fa3028e72abf	081bdd5a-3455-4cf1-9ed9-ddd146a2d170	sync_date	2025-09-22	active
e469e4d8-ed11-40ab-a24e-c6f42a8e6949	a5b41d40-894b-4eb5-80ca-122ebdf7ff39	ocean_expert_id	19551	active
e4c16c1f-3994-4180-838e-5d1150be00f8	a5b41d40-894b-4eb5-80ca-122ebdf7ff39	data_source	obis_oceanexpert	active
1506478c-fa53-40ca-ab2e-dd08c6c464ef	a5b41d40-894b-4eb5-80ca-122ebdf7ff39	sync_date	2025-09-22	active
45c18456-2dc0-4670-aa8f-53ffeb98eb91	65488a08-d482-4264-a0c2-f8bd06ef4a4e	ocean_expert_id	16162	active
e636f85d-0d0e-4126-917e-b8324b437520	65488a08-d482-4264-a0c2-f8bd06ef4a4e	data_source	obis_oceanexpert	active
f0f02c3f-512f-4422-ab3a-ec0430663fcd	65488a08-d482-4264-a0c2-f8bd06ef4a4e	sync_date	2025-09-22	active
fa109d4a-0574-42e0-b606-f04cc76db748	2f7e4c19-87d1-4268-af7d-c6cb5fa8d769	ocean_expert_id	12468	active
bd938e89-264b-45ea-b01c-a30d648feb4a	2f7e4c19-87d1-4268-af7d-c6cb5fa8d769	data_source	obis_oceanexpert	active
5fcc3fbb-5e09-4b60-b931-2c76eeedfa43	2f7e4c19-87d1-4268-af7d-c6cb5fa8d769	sync_date	2025-09-22	active
a9210e70-afba-42e3-a187-37db62003990	6cfd8035-e247-4504-971b-caadee81763b	ocean_expert_id	19332	active
80a13c43-c02b-4123-8b83-b2165a011c5a	6cfd8035-e247-4504-971b-caadee81763b	data_source	obis_oceanexpert	active
921a9df9-8664-44d0-bd98-ab418d61534f	6cfd8035-e247-4504-971b-caadee81763b	sync_date	2025-09-22	active
1de56e29-c4bc-44ca-bb94-6e9a8dde5893	e73a8255-71d5-41f9-933b-a18e901e3615	ocean_expert_id	20884	active
aa57a4ba-fbe3-4827-b2b1-47fd4eaca650	e73a8255-71d5-41f9-933b-a18e901e3615	data_source	obis_oceanexpert	active
912ef9eb-9e1c-4634-84a1-f1a011020059	e73a8255-71d5-41f9-933b-a18e901e3615	sync_date	2025-09-22	active
bb3fd698-6fda-45db-a343-eef8287e355c	c1b5e8af-b036-40dc-a2bc-d1c42ae78ae3	ocean_expert_id	17469	active
730d96d9-010f-4936-b539-726ccf3316a6	c1b5e8af-b036-40dc-a2bc-d1c42ae78ae3	data_source	obis_oceanexpert	active
39028856-fc35-44df-89e1-2f87c821a5b3	c1b5e8af-b036-40dc-a2bc-d1c42ae78ae3	sync_date	2025-09-22	active
ac065024-3fd3-4f95-b5c5-49f7ec2c1d3d	05204486-dab3-42ed-9ec0-1403a353a042	ocean_expert_id	13565	active
8b11036b-6f45-47d8-85c8-40acfbcf754b	05204486-dab3-42ed-9ec0-1403a353a042	data_source	obis_oceanexpert	active
e2815f49-ace7-4296-95c0-599395a59130	05204486-dab3-42ed-9ec0-1403a353a042	sync_date	2025-09-22	active
0e79fd4e-c2ce-485f-8103-9a906904fd73	6b76c48f-efa2-448a-af46-c3d5f6d4665d	ocean_expert_id	21187	active
be132143-bf39-4314-bc8b-ef5b76135fdb	6b76c48f-efa2-448a-af46-c3d5f6d4665d	data_source	obis_oceanexpert	active
7626dce5-6940-4370-ae97-e62d09a6867d	6b76c48f-efa2-448a-af46-c3d5f6d4665d	sync_date	2025-09-22	active
3f44f31c-5b8c-448d-8532-a6cfe28b482a	f8fe8f1e-6d61-4f83-8bf3-471a5bc6fb26	ocean_expert_id	20891	active
6b727836-25f2-4344-b422-5831e23eabea	f8fe8f1e-6d61-4f83-8bf3-471a5bc6fb26	data_source	obis_oceanexpert	active
eee23bee-427f-475c-a710-7605758cf0fa	f8fe8f1e-6d61-4f83-8bf3-471a5bc6fb26	sync_date	2025-09-22	active
64c3ddb7-df29-409c-8c67-578a6626a40f	ed012786-9b56-4575-821e-808d8b7e5d73	ocean_expert_id	11872	active
3afeda06-ed95-4bd1-a6c6-9a2732795e84	ed012786-9b56-4575-821e-808d8b7e5d73	data_source	obis_oceanexpert	active
90f2055f-f3c2-47cc-a73c-efb18f43921c	ed012786-9b56-4575-821e-808d8b7e5d73	sync_date	2025-09-22	active
dfc11501-c02f-4caf-9096-469be473021d	50cf7216-e271-4ebc-ac4d-23566f026653	ocean_expert_id	19498	active
0dbd0dda-2d7b-48be-9829-c8989141501b	50cf7216-e271-4ebc-ac4d-23566f026653	data_source	obis_oceanexpert	active
8e3c7e33-4f5d-49de-86b1-1e726d178641	50cf7216-e271-4ebc-ac4d-23566f026653	sync_date	2025-09-22	active
ef8769c5-6410-49da-bb1f-79b5f6be3472	85fcf0e2-d821-4784-98ba-2402db3fb55f	ocean_expert_id	20888	active
b48c7681-659b-47bf-9d77-6b4e08e1c329	85fcf0e2-d821-4784-98ba-2402db3fb55f	data_source	obis_oceanexpert	active
c103db8f-6e10-4147-94c5-8c2e4d4b57ea	85fcf0e2-d821-4784-98ba-2402db3fb55f	sync_date	2025-09-22	active
6bab9c6c-1fae-4b0f-9069-9daff8943cd6	6dd01f72-a424-45d2-a833-25cdb99143ef	ocean_expert_id	19387	active
d47cfc82-bf1e-4106-8414-6bcbd13dc440	6dd01f72-a424-45d2-a833-25cdb99143ef	data_source	obis_oceanexpert	active
17347b63-8eee-419a-9827-a16fb767856f	6dd01f72-a424-45d2-a833-25cdb99143ef	sync_date	2025-09-22	active
e757e6c3-8ac4-4c68-ac78-38409573a0b4	6d091871-5558-47f4-9ba9-91a9b1454f9c	ocean_expert_id	18647	active
5a804aa6-344e-45bb-b7bc-db72aa0aa2e8	6d091871-5558-47f4-9ba9-91a9b1454f9c	data_source	obis_oceanexpert	active
fcf5bc78-7a20-4cd4-934e-692b4dbdddd8	6d091871-5558-47f4-9ba9-91a9b1454f9c	sync_date	2025-09-22	active
0c49a32c-0aba-4220-8c54-0693f77f0f6b	9d85f7e1-e1eb-4eb7-9d05-0dd34eaeff47	ocean_expert_id	6839	active
033f930f-1122-41f7-a08e-8b1248b2f97c	9d85f7e1-e1eb-4eb7-9d05-0dd34eaeff47	data_source	obis_oceanexpert	active
573bb8bb-c984-46ec-b2e1-51370febfa74	9d85f7e1-e1eb-4eb7-9d05-0dd34eaeff47	sync_date	2025-09-22	active
036c38d1-3000-4e73-bf52-6232fda34bf0	f1695411-1b0d-4a9b-b15d-101260a6386d	ocean_expert_id	23199	active
ef6f94de-569a-4d76-a690-3c52ea45f80c	f1695411-1b0d-4a9b-b15d-101260a6386d	data_source	obis_oceanexpert	active
1d59e827-a6a4-48b1-a5f0-794f93984170	f1695411-1b0d-4a9b-b15d-101260a6386d	sync_date	2025-09-22	active
0174c9ac-0a48-4eae-b0cc-f011a61b9ae4	b191e299-f7ac-4453-99a8-222f8f84e707	ocean_expert_id	19619	active
ebf692f2-c317-4fd7-8b4f-dfa2fd60c646	b191e299-f7ac-4453-99a8-222f8f84e707	data_source	obis_oceanexpert	active
1b9f8115-bb5c-4c85-bc77-f8bf192ab5fe	b191e299-f7ac-4453-99a8-222f8f84e707	sync_date	2025-09-22	active
e244c8f2-bf51-4b4b-91ea-44f9abc2097a	8e1f44a2-7307-4f93-b8bc-28a8f4392a8f	ocean_expert_id	20263	active
49b6ab6d-4a5d-44fe-9eb3-c4011ad6bbe5	8e1f44a2-7307-4f93-b8bc-28a8f4392a8f	data_source	obis_oceanexpert	active
5f3c314e-81be-4eb3-b2e8-92b63ace91ea	8e1f44a2-7307-4f93-b8bc-28a8f4392a8f	sync_date	2025-09-22	active
85241678-bb50-4a4c-8bf8-4cb56dc97e25	58b3f3bd-1eae-46d5-900e-11ca507b87fe	ocean_expert_id	19384	active
e77a061a-afac-46dd-a072-e1f3dcca153d	58b3f3bd-1eae-46d5-900e-11ca507b87fe	data_source	obis_oceanexpert	active
5d15e571-9648-49bf-b308-65c079c04f1f	58b3f3bd-1eae-46d5-900e-11ca507b87fe	sync_date	2025-09-22	active
6bf87333-d68b-40c2-86ab-6f575c9617eb	46f9cb4f-b4f3-4491-ac7d-bb14636337ad	ocean_expert_id	18015	active
71290708-59d0-47e2-966c-7407bcc1cdfe	46f9cb4f-b4f3-4491-ac7d-bb14636337ad	data_source	obis_oceanexpert	active
24500e32-2b38-4161-b94c-d5fdecb414f2	46f9cb4f-b4f3-4491-ac7d-bb14636337ad	sync_date	2025-09-22	active
58384242-e39f-4052-ae6f-861fcce968e4	ffe9a0f6-afae-481f-b815-213e5b44c6bb	ocean_expert_id	9622	active
9a58cc8b-d8d2-451a-b88c-8589a8d6b08b	ffe9a0f6-afae-481f-b815-213e5b44c6bb	data_source	obis_oceanexpert	active
007e26d2-8ff1-4022-a320-f626ca6bc8ad	ffe9a0f6-afae-481f-b815-213e5b44c6bb	sync_date	2025-09-22	active
247c897f-1e48-4b9f-98c0-2b8b6d7b1fcc	afa505c5-0691-4b6b-b2fc-fa1b57e751a2	ocean_expert_id	19608	active
f5983d2a-fef8-46be-a5d6-cbb14fa9fc81	afa505c5-0691-4b6b-b2fc-fa1b57e751a2	data_source	obis_oceanexpert	active
c99b7aad-0d40-449f-8ad8-b88b57735f2f	afa505c5-0691-4b6b-b2fc-fa1b57e751a2	sync_date	2025-09-22	active
3d91d3a8-b1ea-41fc-8abc-11b37f559b54	909d5101-5dc0-41a2-b6ce-d937af40f22e	ocean_expert_id	18092	active
4daff496-5f6a-4d73-9ac3-f6d8f490bc71	909d5101-5dc0-41a2-b6ce-d937af40f22e	data_source	obis_oceanexpert	active
1eb2c2c7-ec9b-4f04-bd5f-035ab3d2cdc5	909d5101-5dc0-41a2-b6ce-d937af40f22e	sync_date	2025-09-22	active
0dd53521-d996-4692-a06c-f45e37c675dc	c3e73526-c426-4dee-a47c-3b486aa8651c	ocean_expert_id	19388	active
7f359f55-0af0-43db-ad9a-bb9d221d3264	c3e73526-c426-4dee-a47c-3b486aa8651c	data_source	obis_oceanexpert	active
a24c6d64-65d6-4d4d-96f2-2a642c0d23ba	c3e73526-c426-4dee-a47c-3b486aa8651c	sync_date	2025-09-22	active
6ba46d11-5fed-4458-869b-d64bee915c28	5b8e8fa3-e48a-4782-b20a-84bf98f25fbd	ocean_expert_id	6444	active
d605caff-9299-4bed-998f-50841942788c	5b8e8fa3-e48a-4782-b20a-84bf98f25fbd	data_source	obis_oceanexpert	active
2d6b307b-ef5b-4a1f-b658-678a06444aeb	5b8e8fa3-e48a-4782-b20a-84bf98f25fbd	sync_date	2025-09-22	active
1a36d40d-1749-42b1-86ff-71d11a304e76	6d5131dc-c688-4b0f-8527-0cc2256973c2	ocean_expert_id	23196	active
118e848b-f768-4c40-8a17-bdc56f3f9edc	6d5131dc-c688-4b0f-8527-0cc2256973c2	data_source	obis_oceanexpert	active
dfb5c466-7b4a-41dc-a662-4fc80671088e	6d5131dc-c688-4b0f-8527-0cc2256973c2	sync_date	2025-09-22	active
4496e810-f659-4a99-a82f-34c7931d699f	488609bd-f95a-4c2c-8470-0b2f7c182f80	ocean_expert_id	10049	active
cbc89637-b1ec-4fd3-b7b1-7d581bd0a8b4	488609bd-f95a-4c2c-8470-0b2f7c182f80	data_source	obis_oceanexpert	active
dc02e6c2-b759-4648-b6aa-3731ac1c4e9d	488609bd-f95a-4c2c-8470-0b2f7c182f80	sync_date	2025-09-22	active
6c4d2217-413c-4feb-805f-5e7e06d84bbc	a5ad5928-e434-40de-b488-d35fd780af53	ocean_expert_id	19454	active
9906f4f7-a17d-4aaf-a129-e7225f30750c	a5ad5928-e434-40de-b488-d35fd780af53	data_source	obis_oceanexpert	active
a013df17-2a16-4f11-8362-079297de799f	a5ad5928-e434-40de-b488-d35fd780af53	sync_date	2025-09-22	active
696ae3fe-0bb4-4ffa-be5e-4b317498763f	6e73238d-12bd-4491-bd28-d2dfe6317b38	ocean_expert_id	20904	active
6896f76e-4417-430b-9f72-dc0a9f524bc7	6e73238d-12bd-4491-bd28-d2dfe6317b38	data_source	obis_oceanexpert	active
26acdeff-49e3-4cf4-83c0-0324a491cc48	6e73238d-12bd-4491-bd28-d2dfe6317b38	sync_date	2025-09-22	active
aba85594-e82b-43a2-9e02-d1a3fafdda01	41d2036a-5db3-4b98-9c7d-dd5b9282779b	ocean_expert_id	21889	active
ef8f03e0-e047-4bb7-89b0-5586fd887c2d	41d2036a-5db3-4b98-9c7d-dd5b9282779b	data_source	obis_oceanexpert	active
46a9f108-a84a-45b7-b886-8eadf7284167	41d2036a-5db3-4b98-9c7d-dd5b9282779b	sync_date	2025-09-22	active
53b5e762-212d-45b4-ae03-0f783ac05a8a	72d9bde2-e769-40b2-bec5-77ea05d23d15	ocean_expert_id	6909	active
f61ae84a-0b89-4df2-9325-eafb6e656f47	72d9bde2-e769-40b2-bec5-77ea05d23d15	data_source	obis_oceanexpert	active
9ce61164-7059-43cb-bf3d-90fa9e696ef5	72d9bde2-e769-40b2-bec5-77ea05d23d15	sync_date	2025-09-22	active
9af43f6b-938c-4e0c-8f54-2fda16d721ea	fbad0960-5aa7-4ef8-813d-0b7065a19739	ocean_expert_id	19458	active
02335905-b8cc-487a-bdea-483f4b429efc	fbad0960-5aa7-4ef8-813d-0b7065a19739	data_source	obis_oceanexpert	active
27b4f100-d7f1-42b2-808e-f0b8690b49b3	fbad0960-5aa7-4ef8-813d-0b7065a19739	sync_date	2025-09-22	active
6e36aaab-54cf-4679-9e93-2681154ba006	10b0d4ab-5e7d-43bb-9e87-5d2baf8f98ee	ocean_expert_id	11854	active
2296b6f3-6a86-482f-8937-848ddabcf1eb	10b0d4ab-5e7d-43bb-9e87-5d2baf8f98ee	data_source	obis_oceanexpert	active
87f76331-18c7-4d6a-87ff-a914e8ed564e	10b0d4ab-5e7d-43bb-9e87-5d2baf8f98ee	sync_date	2025-09-22	active
c2f2a070-af38-4178-8789-b54b9d6cbac0	3787a1ae-37b2-47b0-9268-230e936245b8	ocean_expert_id	6638	active
956ee72a-8709-443a-94d2-3948227416dc	3787a1ae-37b2-47b0-9268-230e936245b8	data_source	obis_oceanexpert	active
26901351-e304-41a5-8881-8728bc36c647	3787a1ae-37b2-47b0-9268-230e936245b8	sync_date	2025-09-22	active
a9a716ae-9976-42a9-8d1d-3ab1cb256f2c	94b92c30-177e-4153-b3c7-42ada07b5703	ocean_expert_id	19357	active
03f3edbb-7610-41a9-adda-3107edbe7b0d	94b92c30-177e-4153-b3c7-42ada07b5703	data_source	obis_oceanexpert	active
a225a142-450a-4098-b4a2-dca4ce34ad8c	94b92c30-177e-4153-b3c7-42ada07b5703	sync_date	2025-09-22	active
7bc273be-daa8-4b25-9593-d172b77c1b04	2635b358-7f08-4993-9778-d8e0effc64ec	ocean_expert_id	19591	active
b4382745-1c9d-418a-8aaf-788844ae1920	2635b358-7f08-4993-9778-d8e0effc64ec	data_source	obis_oceanexpert	active
18cd7a55-efe0-4b5a-b9da-d2cfde1c6769	2635b358-7f08-4993-9778-d8e0effc64ec	sync_date	2025-09-22	active
d008d0f2-51f5-44ee-9db2-578a5ab05fe6	a2aad2ef-dc6d-473f-8f36-a80f57226869	ocean_expert_id	19274	active
69cd1fba-d431-4584-9a02-9648feffe705	a2aad2ef-dc6d-473f-8f36-a80f57226869	data_source	obis_oceanexpert	active
099ff814-e414-44d0-8f6f-6a2cb2486477	a2aad2ef-dc6d-473f-8f36-a80f57226869	sync_date	2025-09-22	active
a3c7aa22-d1c6-41f7-ba6b-3670c588b2f3	cd4fe3d9-4bb8-4eb1-adf1-8d77d21b4d90	ocean_expert_id	21895	active
54a0435e-5711-443a-8e0e-be1239dacdca	cd4fe3d9-4bb8-4eb1-adf1-8d77d21b4d90	data_source	obis_oceanexpert	active
663e6108-b8f2-4944-bce6-ef6e782e07e4	cd4fe3d9-4bb8-4eb1-adf1-8d77d21b4d90	sync_date	2025-09-22	active
5257d8f7-f9ce-4214-a08b-11d91c15e373	5c53cb4a-d4ef-4ed4-ad1a-c1b26cc5b10a	ocean_expert_id	20688	active
54bcd74a-0649-47e6-9bb3-4d9852e44ae1	5c53cb4a-d4ef-4ed4-ad1a-c1b26cc5b10a	data_source	obis_oceanexpert	active
b677726c-537b-4ae4-956f-e2ae2e8736d0	5c53cb4a-d4ef-4ed4-ad1a-c1b26cc5b10a	sync_date	2025-09-22	active
ef34e3e5-a430-48c5-8c45-be848e016c87	23514126-0125-4b5b-8b8e-afabd2e718d6	ocean_expert_id	19314	active
f335650c-e6c6-4328-ab45-cfe4724fb06b	23514126-0125-4b5b-8b8e-afabd2e718d6	data_source	obis_oceanexpert	active
1cbd9beb-6ea3-401d-aeeb-2e3583f96931	23514126-0125-4b5b-8b8e-afabd2e718d6	sync_date	2025-09-22	active
80fd0e38-8553-4933-951f-f82cde81af86	7260de8c-8862-4d9d-9114-91b6e74e0799	ocean_expert_id	19421	active
d1b54bc3-e846-4f58-9ed7-9b9054cb39aa	7260de8c-8862-4d9d-9114-91b6e74e0799	data_source	obis_oceanexpert	active
df4046c9-c210-4274-9642-782ab74d543f	7260de8c-8862-4d9d-9114-91b6e74e0799	sync_date	2025-09-22	active
f610510e-b8c8-4171-9c98-80c40ac8f639	a907ca4e-8f41-47a1-aced-481293fbc5d9	ocean_expert_id	23198	active
c1ca7dd6-aea1-4fc6-abff-c3ba3a6165d4	a907ca4e-8f41-47a1-aced-481293fbc5d9	data_source	obis_oceanexpert	active
cb8a901b-957b-4921-b480-077ec2be6c2f	a907ca4e-8f41-47a1-aced-481293fbc5d9	sync_date	2025-09-22	active
85645a4b-e4af-451c-973c-e9fa887a000e	83295a28-507f-44ab-94e2-e4e34d5c6dd7	ocean_expert_id	19602	active
b68e11fb-3463-4dd5-9e02-3d982f297ef2	83295a28-507f-44ab-94e2-e4e34d5c6dd7	data_source	obis_oceanexpert	active
b7fc4994-45ae-4075-822d-20f67530037d	83295a28-507f-44ab-94e2-e4e34d5c6dd7	sync_date	2025-09-22	active
b695d918-d204-4f35-aa5e-fc7a35c34202	ed05a484-94e2-42a7-bc1d-8bb296bc236f	ocean_expert_id	18179	active
733c8c19-f0bb-4a54-9a7a-df275da8d663	ed05a484-94e2-42a7-bc1d-8bb296bc236f	data_source	obis_oceanexpert	active
3a8d6563-9328-4150-836c-b953abfe52da	ed05a484-94e2-42a7-bc1d-8bb296bc236f	sync_date	2025-09-22	active
e21843d0-622b-45d4-a557-9062e5a8a12a	fa671f6c-9f4c-4388-9b46-bf937fdac55e	ocean_expert_id	17413	active
ac12291d-0c46-4c24-97dc-2769419815a4	fa671f6c-9f4c-4388-9b46-bf937fdac55e	data_source	obis_oceanexpert	active
fc19d122-7678-470f-b700-c7d490b8947e	fa671f6c-9f4c-4388-9b46-bf937fdac55e	sync_date	2025-09-22	active
a7dd9033-3aa4-4492-82f7-e66b2f65945b	79b8f927-ac45-49e3-a334-18f00d1803dc	ocean_expert_id	20777	active
d126ded5-2091-46c1-8a88-6ea428410c5a	79b8f927-ac45-49e3-a334-18f00d1803dc	data_source	obis_oceanexpert	active
8bd2999e-d592-4c61-b553-3406e18295f4	79b8f927-ac45-49e3-a334-18f00d1803dc	sync_date	2025-09-22	active
0a98de96-77e5-4497-8974-5e5fe5af3983	ed0423cb-ddf1-488f-8f84-a82481f1cbd9	ocean_expert_id	19657	active
2a394760-45a9-442c-aa78-459d893927af	ed0423cb-ddf1-488f-8f84-a82481f1cbd9	data_source	obis_oceanexpert	active
6e75f8e2-7b47-459c-85c1-b65a2d712086	ed0423cb-ddf1-488f-8f84-a82481f1cbd9	sync_date	2025-09-22	active
0e4f84c5-772a-4c59-ac3f-cf5ecf3c951a	1ab918bf-0e1c-472b-abcf-8b3bc2bf13ea	ocean_expert_id	20869	active
11ab7d41-16e6-4790-9ef6-662b9f852a37	1ab918bf-0e1c-472b-abcf-8b3bc2bf13ea	data_source	obis_oceanexpert	active
06e59ab6-a3fa-4bcf-9026-3370dd9fce9d	1ab918bf-0e1c-472b-abcf-8b3bc2bf13ea	sync_date	2025-09-22	active
4aee7bfd-497f-4af6-aa60-00cc14aafdd8	946832e3-55ab-427f-9387-215486006b34	ocean_expert_id	19571	active
0eccdc01-5751-427f-8f10-768e7d16926a	946832e3-55ab-427f-9387-215486006b34	data_source	obis_oceanexpert	active
e7ab0751-c873-417b-b28b-d822a8a94925	946832e3-55ab-427f-9387-215486006b34	sync_date	2025-09-22	active
91dc38d3-396d-4431-89eb-26e5eb37e3df	e49ae6f8-c969-46ec-bd91-041b3f10e35c	ocean_expert_id	18892	active
252282f7-300c-4c8a-9934-53040fd107e3	e49ae6f8-c969-46ec-bd91-041b3f10e35c	data_source	obis_oceanexpert	active
54005985-7939-4704-bb7b-3e49f64bfd00	e49ae6f8-c969-46ec-bd91-041b3f10e35c	sync_date	2025-09-22	active
d7485847-313c-44cb-ad54-f31c350d870c	c6c56895-34ef-4d72-a81b-7c7edd0f7001	ocean_expert_id	7262	active
1192e162-e096-4c9f-9a80-85f7da4e5258	c6c56895-34ef-4d72-a81b-7c7edd0f7001	data_source	obis_oceanexpert	active
100ea15e-c53a-4389-8bb2-a5adc8807fc4	c6c56895-34ef-4d72-a81b-7c7edd0f7001	sync_date	2025-09-22	active
d68fd6f3-5a36-49e8-94a3-c10987d85c5a	8ac4554d-ae0a-4299-9cf7-16b8e34b498a	ocean_expert_id	12048	active
ecaf39fb-366a-414f-8cf9-f5f2ae0c2efd	8ac4554d-ae0a-4299-9cf7-16b8e34b498a	data_source	obis_oceanexpert	active
77d6c5e2-f0d3-454d-b80c-714cca319bb3	8ac4554d-ae0a-4299-9cf7-16b8e34b498a	sync_date	2025-09-22	active
f9a2c06d-2cf3-4e2a-b56c-dbe122f3cac3	48de3fb1-78e5-4d3c-9884-d23e311d355a	ocean_expert_id	19409	active
277e3849-a373-4478-9b7a-53c5b1ffcda1	48de3fb1-78e5-4d3c-9884-d23e311d355a	data_source	obis_oceanexpert	active
03a322cb-13eb-4d0e-8731-fcaf0e5f7bdf	48de3fb1-78e5-4d3c-9884-d23e311d355a	sync_date	2025-09-22	active
4a8de7fc-bd6a-4993-bf6e-b969992b1617	496de303-2fb9-40ca-af98-7827a51a7352	ocean_expert_id	19620	active
26ef0281-0521-4c0c-9cfc-f329f8c18374	496de303-2fb9-40ca-af98-7827a51a7352	data_source	obis_oceanexpert	active
a8a29a31-3e12-4ae8-b601-051bba7f71ec	496de303-2fb9-40ca-af98-7827a51a7352	sync_date	2025-09-22	active
f9e6e4a1-8c89-4f16-a05c-9cfa8106db70	33d16463-04d7-4cdf-9f48-a5b579ea0de0	ocean_expert_id	19425	active
3f51f10d-1aa9-4003-af9c-d59356d170c7	33d16463-04d7-4cdf-9f48-a5b579ea0de0	data_source	obis_oceanexpert	active
7ba7c974-7375-456c-b3e2-dd13042fe3c7	33d16463-04d7-4cdf-9f48-a5b579ea0de0	sync_date	2025-09-22	active
0cbac81f-a912-478b-8090-6941bb1d1233	662dbd69-398a-4b2b-8873-aff6f24df360	ocean_expert_id	13380	active
1d75dc2c-3ad7-42bd-b848-57dc81695d66	662dbd69-398a-4b2b-8873-aff6f24df360	data_source	obis_oceanexpert	active
b0f97d2f-5801-4158-b98f-ec2ae46b4062	662dbd69-398a-4b2b-8873-aff6f24df360	sync_date	2025-09-22	active
23a78a36-2989-41cb-aa1a-d006a4626e15	bee2a67b-338b-4933-9df6-56da7df3b524	ocean_expert_id	19289	active
e9ab0692-83be-42d1-b5d3-3d283be742d4	bee2a67b-338b-4933-9df6-56da7df3b524	data_source	obis_oceanexpert	active
ec029208-9487-4952-b892-75aa7f221dbb	bee2a67b-338b-4933-9df6-56da7df3b524	sync_date	2025-09-22	active
c0d4139c-1229-4590-ad31-2458e3dcf458	47c7b42f-04b8-4d67-9c22-414f3f9b96da	ocean_expert_id	19142	active
06796c09-a1c1-491c-9dcd-8b2193fa05da	47c7b42f-04b8-4d67-9c22-414f3f9b96da	data_source	obis_oceanexpert	active
659e812b-4447-4710-8fa7-98edaf14d3bb	47c7b42f-04b8-4d67-9c22-414f3f9b96da	sync_date	2025-09-22	active
b14e534f-b1b8-4495-8f20-7d83ecd2a6ea	64d3bbd4-a41a-4118-9b75-bf9a4248a1fe	ocean_expert_id	19296	active
35a79852-11dd-44d1-be15-2e9effde3d90	64d3bbd4-a41a-4118-9b75-bf9a4248a1fe	data_source	obis_oceanexpert	active
6aedffa6-8303-43e2-abb6-e8f493fb60a9	64d3bbd4-a41a-4118-9b75-bf9a4248a1fe	sync_date	2025-09-22	active
6f2a9290-87b3-432c-8d32-c63194d61ce7	c08fb08b-5f00-432c-a08a-e3a776d5397b	ocean_expert_id	9329	active
4a87f22d-2417-49bd-a925-cc0068f78599	c08fb08b-5f00-432c-a08a-e3a776d5397b	data_source	obis_oceanexpert	active
1f746118-a39d-42d2-bbdd-92df58612459	c08fb08b-5f00-432c-a08a-e3a776d5397b	sync_date	2025-09-22	active
3572d294-3a86-41ce-8752-91168996b047	b9aa7a4f-7705-4116-9b01-42d23853edae	ocean_expert_id	20900	active
b2a63d3e-d60c-455c-8089-3987290f11c0	b9aa7a4f-7705-4116-9b01-42d23853edae	data_source	obis_oceanexpert	active
5e8d4ae7-e5a0-42ad-adc6-6dccdf06b3f8	b9aa7a4f-7705-4116-9b01-42d23853edae	sync_date	2025-09-22	active
b23407ac-62fc-48a2-abeb-3591a3ec5eed	2494cf3d-c036-43e4-b61d-b83c719152ee	ocean_expert_id	18628	active
a572b0ef-6e00-48b7-9985-f88e2f20e980	2494cf3d-c036-43e4-b61d-b83c719152ee	data_source	obis_oceanexpert	active
ec630cff-9d83-44a9-851f-c32bd45b3973	2494cf3d-c036-43e4-b61d-b83c719152ee	sync_date	2025-09-22	active
8f5efbcb-4e0f-44be-8452-72ed3f311157	a31e2fc6-00f9-4ea9-9a02-88ad5d42fdbc	ocean_expert_id	12606	active
fe835e6b-a544-4643-926e-095ed250666d	a31e2fc6-00f9-4ea9-9a02-88ad5d42fdbc	data_source	obis_oceanexpert	active
a699b9c2-dcb6-4c2c-af60-bee2e1647d8a	a31e2fc6-00f9-4ea9-9a02-88ad5d42fdbc	sync_date	2025-09-22	active
430018bc-e2a1-4f02-a966-2ba40d953285	b3d572fb-d2da-4b44-a667-ae05ee60fec8	ocean_expert_id	19405	active
e06d2b63-a348-4751-ac2a-1884f3e8addf	b3d572fb-d2da-4b44-a667-ae05ee60fec8	data_source	obis_oceanexpert	active
d9b8148c-9e52-465b-8f47-ac1269c6e0d9	b3d572fb-d2da-4b44-a667-ae05ee60fec8	sync_date	2025-09-22	active
d6e45ae5-65c4-43c3-8bdf-26dab5314ff4	6aeca3bd-eb91-4e62-a62b-08d029464ca1	ocean_expert_id	19570	active
4f5b1def-8d35-485a-b2c3-10fb4ff1ff76	6aeca3bd-eb91-4e62-a62b-08d029464ca1	data_source	obis_oceanexpert	active
411dccb3-6c73-4df4-886c-ed9d0ce01180	6aeca3bd-eb91-4e62-a62b-08d029464ca1	sync_date	2025-09-22	active
5356a0d5-c2e8-4712-b7f0-4e8dd23a70f6	42802943-91da-496b-9304-fe05fba26dea	ocean_expert_id	18622	active
64956e72-0519-4d26-9df5-e74738d0d95e	42802943-91da-496b-9304-fe05fba26dea	data_source	obis_oceanexpert	active
5d0df62f-0922-40fa-92e8-f9a35b7c59f2	42802943-91da-496b-9304-fe05fba26dea	sync_date	2025-09-22	active
1efa0d77-17c3-4ec7-9a11-e557df924fca	b79969d3-8a32-47b2-ab85-3e037a3ebde4	ocean_expert_id	19286	active
9dc79a88-2ca0-406c-9de8-9b25cf3ac403	b79969d3-8a32-47b2-ab85-3e037a3ebde4	data_source	obis_oceanexpert	active
fa44370f-310c-4c9f-9400-79dda8de8403	b79969d3-8a32-47b2-ab85-3e037a3ebde4	sync_date	2025-09-22	active
0592899a-d285-4922-8f79-e0ea1fc06217	762a482a-fbf9-48c6-9323-78a43787cc82	ocean_expert_id	18052	active
6984e7e7-4217-4cd9-a79d-c62f3906e4af	762a482a-fbf9-48c6-9323-78a43787cc82	data_source	obis_oceanexpert	active
b1350e7f-a425-4ac5-a466-b3ff2dba6369	762a482a-fbf9-48c6-9323-78a43787cc82	sync_date	2025-09-22	active
3c2be982-1a9a-486f-bbc1-c8fc9df5a5e8	2e6f20ff-174d-471a-93ca-aa35c937217d	ocean_expert_id	19523	active
d461b93a-c33c-4074-962f-6bcbdcc50776	2e6f20ff-174d-471a-93ca-aa35c937217d	data_source	obis_oceanexpert	active
3fa3a8df-d7f1-499e-8c1b-2c9e9f7e3dfe	2e6f20ff-174d-471a-93ca-aa35c937217d	sync_date	2025-09-22	active
b02acec1-effa-47fe-84fc-722c1c715fb1	473e25d2-f6ee-428e-b5b5-c3a6a36c6859	ocean_expert_id	19501	active
516cb4d5-303d-4249-8a18-0bf6d55be79d	473e25d2-f6ee-428e-b5b5-c3a6a36c6859	data_source	obis_oceanexpert	active
ca37405c-b5b2-4772-904f-00c80896992e	473e25d2-f6ee-428e-b5b5-c3a6a36c6859	sync_date	2025-09-22	active
54c31a30-970b-4483-829c-c25d9b2a487f	56c4c1ab-1610-499e-9a73-48b4106b2020	ocean_expert_id	12401	active
2290ed17-cda5-4c60-86d1-3bb0e222fcb0	56c4c1ab-1610-499e-9a73-48b4106b2020	data_source	obis_oceanexpert	active
62148280-93db-4876-ad29-35e261f9ea2b	56c4c1ab-1610-499e-9a73-48b4106b2020	sync_date	2025-09-22	active
a2bb8064-4826-47b5-a7ce-f128823de71a	3a027de3-39cd-40ea-91a3-30051f39b8f2	ocean_expert_id	19451	active
ef921658-a718-45f6-b05b-e03f0aebdbc2	3a027de3-39cd-40ea-91a3-30051f39b8f2	data_source	obis_oceanexpert	active
aaaad57b-2c67-4db9-9acd-ba9cf2bff794	3a027de3-39cd-40ea-91a3-30051f39b8f2	sync_date	2025-09-22	active
969ac3fa-dfe9-433b-b542-6dbf5e4e9f39	5dcfaf5b-324f-42fe-994a-33446b036f5c	ocean_expert_id	7510	active
c696f03b-ffad-4db3-81f9-08af9ff26bd5	5dcfaf5b-324f-42fe-994a-33446b036f5c	data_source	obis_oceanexpert	active
85e109b9-7b55-478b-bd39-80ab3432ecfa	5dcfaf5b-324f-42fe-994a-33446b036f5c	sync_date	2025-09-22	active
5bbbc656-958c-4ac7-b3d7-210c61ef378a	85ee2140-7aa0-4c83-bf34-263ffc7a7192	ocean_expert_id	11285	active
c69a1387-a353-402f-978d-2cc67365f734	85ee2140-7aa0-4c83-bf34-263ffc7a7192	data_source	obis_oceanexpert	active
c68f6d9d-4215-4884-8a81-62399c7ff7eb	85ee2140-7aa0-4c83-bf34-263ffc7a7192	sync_date	2025-09-22	active
a7518a0d-8c60-4d9f-bf1d-b246d26e5e44	97b539c5-bc65-4737-9d7c-cbc95f819e0b	ocean_expert_id	19521	active
64186c89-76da-41b5-af5d-bd241bf21676	97b539c5-bc65-4737-9d7c-cbc95f819e0b	data_source	obis_oceanexpert	active
19f3da24-1839-4972-8465-ae5968e891e7	97b539c5-bc65-4737-9d7c-cbc95f819e0b	sync_date	2025-09-22	active
cc2635e2-9af7-4db3-af8d-fe2a363e7dbd	1e4f1796-a242-403e-ad9d-a634ba595c35	ocean_expert_id	20003	active
d2a8bfe1-51df-4d94-8b3f-e52cc34ca71e	1e4f1796-a242-403e-ad9d-a634ba595c35	data_source	obis_oceanexpert	active
9850bb04-d595-4933-ade9-c21b54706959	1e4f1796-a242-403e-ad9d-a634ba595c35	sync_date	2025-09-22	active
44c51396-2d21-4975-81c5-57be6a81fac9	c7f9bed8-88a8-495c-b6fa-91a0584cbc61	ocean_expert_id	20862	active
903a0bda-d403-4b72-b079-ea9e8279dc6f	c7f9bed8-88a8-495c-b6fa-91a0584cbc61	data_source	obis_oceanexpert	active
a1522b12-69d1-4a9a-91a1-87d4cf14363d	c7f9bed8-88a8-495c-b6fa-91a0584cbc61	sync_date	2025-09-22	active
25082144-b493-4051-8a7a-1839f656c7bc	e419466f-fa01-410e-9927-aa4adec6cc6c	ocean_expert_id	19676	active
2e028b2a-c573-47f2-9145-9f3d648f3f26	e419466f-fa01-410e-9927-aa4adec6cc6c	data_source	obis_oceanexpert	active
3b960068-a533-4a50-a940-aef2502852cd	e419466f-fa01-410e-9927-aa4adec6cc6c	sync_date	2025-09-22	active
70ce0116-5c40-4e09-b598-acd4d3b2a1f6	06a07584-f542-4afe-aeb5-b6473a741d99	ocean_expert_id	20810	active
0713dcde-0568-452d-8c76-323c72bc08ab	06a07584-f542-4afe-aeb5-b6473a741d99	data_source	obis_oceanexpert	active
a1663acb-8277-4340-a31d-4c828c883812	06a07584-f542-4afe-aeb5-b6473a741d99	sync_date	2025-09-22	active
794a4262-2daa-4049-b05a-74de5b97f167	1451af60-3395-44d3-a7ac-0c0d27d1e941	ocean_expert_id	20873	active
acb8dff3-f52c-47f2-af45-46d1627e30c3	1451af60-3395-44d3-a7ac-0c0d27d1e941	data_source	obis_oceanexpert	active
d681ba34-7587-4661-8d15-34c0c5636426	1451af60-3395-44d3-a7ac-0c0d27d1e941	sync_date	2025-09-22	active
0731d20b-916d-4105-90cd-cc73237d2d33	91866e0e-2d75-4f9d-9832-31a6bee7ab05	ocean_expert_id	19629	active
50361c78-5cbd-40c7-8fd2-ae005df9c582	91866e0e-2d75-4f9d-9832-31a6bee7ab05	data_source	obis_oceanexpert	active
5febe2a8-2eff-4dd9-9f30-c1726b35c4c2	91866e0e-2d75-4f9d-9832-31a6bee7ab05	sync_date	2025-09-22	active
2df97bc0-93e3-44aa-81ab-76e189cb604d	b0cfdfdb-da1c-4c7f-ae7b-7e97cc6e6ff0	ocean_expert_id	20950	active
60dbabb1-d0d8-4f5c-ad66-882336449fe1	b0cfdfdb-da1c-4c7f-ae7b-7e97cc6e6ff0	data_source	obis_oceanexpert	active
0a719651-d7b0-434a-b075-3f0755dc1afd	b0cfdfdb-da1c-4c7f-ae7b-7e97cc6e6ff0	sync_date	2025-09-22	active
6dbbac19-33d2-4ce3-a130-dc6d214307d2	0454d9bd-c0c6-4ccb-a0ff-93ea450caef0	ocean_expert_id	19436	active
faa3fc9c-d5dc-4a78-bcdf-436820dad371	0454d9bd-c0c6-4ccb-a0ff-93ea450caef0	data_source	obis_oceanexpert	active
ce3afd41-d022-4075-81b8-96ea866a4d5e	0454d9bd-c0c6-4ccb-a0ff-93ea450caef0	sync_date	2025-09-22	active
c3281a81-1617-4eda-b577-3931a5b457c1	2a37b414-184e-465b-9889-51dedbad61e0	ocean_expert_id	7684	active
e0cf6d74-5cce-4b31-9baa-a3838a4885d1	2a37b414-184e-465b-9889-51dedbad61e0	data_source	obis_oceanexpert	active
6b6ec1f7-53f5-4a27-8f3b-db67cc75e430	2a37b414-184e-465b-9889-51dedbad61e0	sync_date	2025-09-22	active
3c324f79-c318-49b7-8f16-9ab3dbc6a637	95ff4110-38f2-45ea-9590-7c4b98d42ed3	ocean_expert_id	13429	active
9c7aa8eb-a0b5-4f20-82df-2daad181f531	95ff4110-38f2-45ea-9590-7c4b98d42ed3	data_source	obis_oceanexpert	active
4b18a5b7-9ee3-4560-9bba-10f9b48d5c8a	95ff4110-38f2-45ea-9590-7c4b98d42ed3	sync_date	2025-09-22	active
dd9a346d-11db-44e4-a66d-b36c060d2d7f	8807331f-2acd-4ffb-a11a-ecf63932938a	ocean_expert_id	19496	active
c8a77b4c-f9ab-4879-b079-82028c6673b7	8807331f-2acd-4ffb-a11a-ecf63932938a	data_source	obis_oceanexpert	active
56a79827-2ae5-4d13-97ed-ca0eb3dae1be	8807331f-2acd-4ffb-a11a-ecf63932938a	sync_date	2025-09-22	active
fd8538e9-c0ef-45f7-b47d-ef0423b8c9d3	f9111607-a254-4e22-b446-4bc1bfd47e26	ocean_expert_id	19499	active
b308c3d5-0117-48e5-a312-7e937453bfcd	f9111607-a254-4e22-b446-4bc1bfd47e26	data_source	obis_oceanexpert	active
d3f9b7e0-2fda-4fa7-abc2-a3574d43a708	f9111607-a254-4e22-b446-4bc1bfd47e26	sync_date	2025-09-22	active
c34e069f-593d-46ca-986b-3275d326d969	7c0e278e-3d30-460b-b9d5-f01019e7e567	ocean_expert_id	19583	active
3556dcdc-4292-4261-864b-783d98e52834	7c0e278e-3d30-460b-b9d5-f01019e7e567	data_source	obis_oceanexpert	active
180eed5b-a8ea-4cbc-94e5-aebb8e8eb1e6	7c0e278e-3d30-460b-b9d5-f01019e7e567	sync_date	2025-09-22	active
9f8adf1d-d2d1-4df8-b347-3c398ac2560c	03fd422e-1128-426a-b018-5edc03f91bb6	ocean_expert_id	19563	active
344575ff-f1d6-40ce-af59-ae1be49253f6	03fd422e-1128-426a-b018-5edc03f91bb6	data_source	obis_oceanexpert	active
71544a11-923b-4344-90a0-3eedf2406400	03fd422e-1128-426a-b018-5edc03f91bb6	sync_date	2025-09-22	active
f0aed8b9-b484-4b41-87d1-e45d744fa494	cf982b50-f875-4821-9115-d3ab3cd534ae	ocean_expert_id	19611	active
ff4970e1-092c-4093-8378-ac7fc1fac450	cf982b50-f875-4821-9115-d3ab3cd534ae	data_source	obis_oceanexpert	active
86876da8-20a9-475b-98c7-7caae9ae5091	cf982b50-f875-4821-9115-d3ab3cd534ae	sync_date	2025-09-22	active
a61fbe63-174b-47fb-9ce1-e39a0f87fa0a	7b06fd53-2ccd-48a0-b9f7-d787524748d8	ocean_expert_id	21243	active
32011a5b-6815-415f-9da2-322e3b99d890	7b06fd53-2ccd-48a0-b9f7-d787524748d8	data_source	obis_oceanexpert	active
12707eef-bfd9-4b5a-a5e9-90c8d19ce3b0	7b06fd53-2ccd-48a0-b9f7-d787524748d8	sync_date	2025-09-22	active
59f9dd8e-bf6c-44b9-ba6c-8274edd8d683	ecc5ea65-f993-4aa6-8fa4-1ab289353b41	ocean_expert_id	23185	active
2b9bfb05-6677-4b61-9e06-c6e2ed652e5e	ecc5ea65-f993-4aa6-8fa4-1ab289353b41	data_source	obis_oceanexpert	active
551a0da7-8ad9-4187-b274-dc95fedac07e	ecc5ea65-f993-4aa6-8fa4-1ab289353b41	sync_date	2025-09-22	active
d10b2cfb-65a8-4146-99be-0e38fe21f9af	7436a13d-9f88-4db9-b5c7-e8606faeb723	ocean_expert_id	17611	active
02525ef1-5cf1-4e72-b78f-193ac1348062	7436a13d-9f88-4db9-b5c7-e8606faeb723	data_source	obis_oceanexpert	active
ad566759-21b9-454c-9957-4c942678f781	7436a13d-9f88-4db9-b5c7-e8606faeb723	sync_date	2025-09-22	active
a837c1ac-2e2c-44ec-a967-79256e6a8ad8	22c1fe0a-424a-4a44-8c63-d636552ba886	ocean_expert_id	19479	active
1d740a27-f5d9-4bc2-bc38-709326754866	22c1fe0a-424a-4a44-8c63-d636552ba886	data_source	obis_oceanexpert	active
c599a3f2-3d3a-4a5d-9823-91fb5369b4b8	22c1fe0a-424a-4a44-8c63-d636552ba886	sync_date	2025-09-22	active
e18d9522-c290-48e4-9e8f-9a312a6ae2ae	8a0c78a0-6e1d-4a12-9bbc-710156efb635	ocean_expert_id	19552	active
eb89d85b-bf1d-4d00-9859-d3c8638486f8	8a0c78a0-6e1d-4a12-9bbc-710156efb635	data_source	obis_oceanexpert	active
94dffe86-5f23-473e-8b56-960d8e58d118	8a0c78a0-6e1d-4a12-9bbc-710156efb635	sync_date	2025-09-22	active
57bf2dff-2d81-4d51-bbf8-e3e86b456c87	0752d200-4b76-48e7-bff3-76aa8e25a23a	ocean_expert_id	19475	active
32bc768f-0876-4252-bae2-41adf5f0ea34	0752d200-4b76-48e7-bff3-76aa8e25a23a	data_source	obis_oceanexpert	active
77268666-919c-411d-8985-02ad899ed399	0752d200-4b76-48e7-bff3-76aa8e25a23a	sync_date	2025-09-22	active
0b40f94a-3a20-45f8-9441-dcad2d661776	8e19eb22-322f-44ec-84e3-252063a113cf	ocean_expert_id	21896	active
a9cc48f2-3818-4afb-8ff3-5018d6c0a803	8e19eb22-322f-44ec-84e3-252063a113cf	data_source	obis_oceanexpert	active
64ae9313-c789-4f40-a338-937e44b8ad32	8e19eb22-322f-44ec-84e3-252063a113cf	sync_date	2025-09-22	active
4c584313-f82a-4afd-a4c8-8e4325a3189e	62488d62-4141-4611-a267-5eef4dfac40e	ocean_expert_id	8475	active
06891fd5-0faa-43f2-b9e4-1eee21eaa8f5	62488d62-4141-4611-a267-5eef4dfac40e	data_source	obis_oceanexpert	active
93ff654f-52a7-43dc-87d2-dc963507eb76	62488d62-4141-4611-a267-5eef4dfac40e	sync_date	2025-09-22	active
dc925b24-0bec-4a76-9724-5adb75a1531f	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	ocean_expert_id	11252	active
6fcb5a22-81d4-453f-b0ad-237dbdd89ca3	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	data_source	obis_oceanexpert	active
4f3226e2-3c8e-45fa-acfb-2256b96c9bb9	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	sync_date	2025-09-22	active
f9dbf50e-6c3d-4fc3-aceb-5c87b9585c4f	edc723c1-5850-4b0d-8336-441378903b91	ocean_expert_id	19174	active
96b1b427-c1b6-4dc8-9530-5b7afe6cdb27	edc723c1-5850-4b0d-8336-441378903b91	data_source	obis_oceanexpert	active
846c443a-f1fa-4712-8dae-11449a8d1392	edc723c1-5850-4b0d-8336-441378903b91	sync_date	2025-09-22	active
997733e9-1b35-4dd8-b7bf-5084d91f20c5	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	ocean_expert_id	8724	active
e26ac62e-ad2a-4061-ad4a-00c3facde030	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	data_source	obis_oceanexpert	active
7d0a42e6-bdd8-4ec1-b03d-8e9bcd86b14b	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	sync_date	2025-09-22	active
53b0a609-fb93-46f0-b8d7-195e6c7b851b	6ea78550-2cc0-465c-8624-3d18d8923e71	ocean_expert_id	19516	active
f01f27bc-e19f-4fad-8815-81b0b1e37620	6ea78550-2cc0-465c-8624-3d18d8923e71	data_source	obis_oceanexpert	active
9cf0763d-3b46-44c7-acc7-6f0416895995	6ea78550-2cc0-465c-8624-3d18d8923e71	sync_date	2025-09-22	active
227f3e96-78e8-4dc8-b386-d9b7d876b76a	713c12dd-e249-43b2-ae63-8a1778bde3d6	ocean_expert_id	20359	active
77d621c9-6776-4ccc-a51d-766a70ea9d44	713c12dd-e249-43b2-ae63-8a1778bde3d6	data_source	obis_oceanexpert	active
f46ba10b-7886-46e1-9681-6101e2791229	713c12dd-e249-43b2-ae63-8a1778bde3d6	sync_date	2025-09-22	active
e5c682c3-1c67-4263-a7bd-1a87b4d9ef4b	6807177e-d90f-455c-b50c-09a815a9b0fb	ocean_expert_id	19378	active
aa94215e-2439-47d3-8935-4c86c45218e2	6807177e-d90f-455c-b50c-09a815a9b0fb	data_source	obis_oceanexpert	active
41d37d34-8134-4434-8e7b-660d6292a7f0	6807177e-d90f-455c-b50c-09a815a9b0fb	sync_date	2025-09-22	active
a6cf8fd6-f12b-4f72-bcab-aea905fb23f8	64b55e5c-b41c-4b45-8286-fc183fc1e22b	ocean_expert_id	19423	active
95bd05ef-8f57-4cd2-9726-04a22fca9aa3	64b55e5c-b41c-4b45-8286-fc183fc1e22b	data_source	obis_oceanexpert	active
a214dfbf-4014-4b2a-a50f-6bc3ddf99fa2	64b55e5c-b41c-4b45-8286-fc183fc1e22b	sync_date	2025-09-22	active
cde6ca5c-513b-4454-ae98-9dca07046118	a075242f-cc8f-4715-aeee-67effbd099b0	ocean_expert_id	13750	active
ccae93cf-2ca2-4c0e-937f-7cd55e3b4240	a075242f-cc8f-4715-aeee-67effbd099b0	data_source	obis_oceanexpert	active
450786f2-eeab-411d-a761-b27fc84a24a4	a075242f-cc8f-4715-aeee-67effbd099b0	sync_date	2025-09-22	active
840f7718-685d-4384-9e00-cf8fdff6e8a4	984d9654-fed4-4692-9292-f9e4eb115a3f	ocean_expert_id	19713	active
ceff7ceb-c429-405c-85a6-d7f74df0e9ae	984d9654-fed4-4692-9292-f9e4eb115a3f	data_source	obis_oceanexpert	active
d2da002b-5eaf-4843-aba9-2cf0c56fe4da	984d9654-fed4-4692-9292-f9e4eb115a3f	sync_date	2025-09-22	active
3e392a02-206b-40c0-b33f-82422ff8d5bc	1b0cfdcd-04f2-4e67-a455-594cdf99925d	ocean_expert_id	13189	active
d376e61e-9576-41f7-976b-23c930a8e4e3	1b0cfdcd-04f2-4e67-a455-594cdf99925d	data_source	obis_oceanexpert	active
213458b2-5cdb-425a-84fc-f39607a1f042	1b0cfdcd-04f2-4e67-a455-594cdf99925d	sync_date	2025-09-22	active
b01c3e9b-3123-4189-ac0f-679de8e2a274	531735c5-33bc-4a17-9905-5cbb84d92027	ocean_expert_id	19542	active
7bfad8a5-1a9f-4bbe-8236-a8b2fc45bf45	531735c5-33bc-4a17-9905-5cbb84d92027	data_source	obis_oceanexpert	active
38ae243b-70ee-4863-b331-33eaf5773877	531735c5-33bc-4a17-9905-5cbb84d92027	sync_date	2025-09-22	active
4b2ce9de-fb8b-42c7-88f6-5c833be3e7d2	4cb9a9b0-e4f6-4b64-a1ae-cb455ee7a8fb	ocean_expert_id	22200	active
0a586a89-ca03-4308-bb42-993363a3958e	4cb9a9b0-e4f6-4b64-a1ae-cb455ee7a8fb	data_source	obis_oceanexpert	active
9c348227-6391-4b3b-ba39-28fd8d640fb5	4cb9a9b0-e4f6-4b64-a1ae-cb455ee7a8fb	sync_date	2025-09-22	active
5796a468-de9d-445e-8cc1-a7227c436aec	21d6bbfc-e133-4a04-9e16-5e37479de70b	ocean_expert_id	19544	active
62f11a69-30a2-4141-8ba4-3d69c116227e	21d6bbfc-e133-4a04-9e16-5e37479de70b	data_source	obis_oceanexpert	active
9ce7eb35-c3f4-400a-b4fb-e56cef3569a0	21d6bbfc-e133-4a04-9e16-5e37479de70b	sync_date	2025-09-22	active
61e06e46-d0d8-4d89-b8a0-c1488e06b82a	efb64a40-7d6e-484b-86de-63401ccc13ca	ocean_expert_id	6587	active
b9d117a8-4f48-4b27-8495-6e4097af31ed	efb64a40-7d6e-484b-86de-63401ccc13ca	data_source	obis_oceanexpert	active
8d48e8aa-8889-4821-b4a2-29f9ad025147	efb64a40-7d6e-484b-86de-63401ccc13ca	sync_date	2025-09-22	active
560c7b75-f74b-4e96-beb7-f500864cb181	4778b9bb-91a2-47ce-99d3-fa0265cb20ac	ocean_expert_id	19599	active
cc4453be-24f5-4aab-9e9f-fc56acb9c207	4778b9bb-91a2-47ce-99d3-fa0265cb20ac	data_source	obis_oceanexpert	active
26eb67ce-6fba-4e20-ae12-1f42d1b20600	4778b9bb-91a2-47ce-99d3-fa0265cb20ac	sync_date	2025-09-22	active
ca7dc940-17b7-47f7-b725-8434d16a9f73	1242c07b-ffab-4f55-b8ab-94bc4970f5d2	ocean_expert_id	20868	active
124b8150-83a4-4495-8431-ffb2e177a5de	1242c07b-ffab-4f55-b8ab-94bc4970f5d2	data_source	obis_oceanexpert	active
503526bb-a6c1-4359-8547-98ce4723ab19	1242c07b-ffab-4f55-b8ab-94bc4970f5d2	sync_date	2025-09-22	active
b8226649-a5f2-4933-a831-a35f5b1e97d9	c32577e8-2f21-4c34-a4ce-1641adacffd5	ocean_expert_id	19299	active
c9019700-6b4c-47e2-ac43-953e535d7f9e	c32577e8-2f21-4c34-a4ce-1641adacffd5	data_source	obis_oceanexpert	active
c5444cbd-cc96-470c-b502-dd1c721c81be	c32577e8-2f21-4c34-a4ce-1641adacffd5	sync_date	2025-09-22	active
440f9d09-0c09-4dbc-9eb0-828bcbbe6b89	0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	ocean_expert_id	20833	active
5fd345bf-fbc8-4e17-b66d-abd8f39a3e61	0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	data_source	obis_oceanexpert	active
422a6c4c-363d-47f0-bfa6-ef66717287e8	0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	sync_date	2025-09-22	active
e7b5c328-3c7f-4ded-94e9-376e3185c39e	91f28432-5f2f-4f95-8bb7-9005e785b327	ocean_expert_id	18533	active
4321fe5f-a336-4555-b47c-96b849300407	91f28432-5f2f-4f95-8bb7-9005e785b327	data_source	obis_oceanexpert	active
54c73cf4-7847-419b-9dbf-adfb6698c959	91f28432-5f2f-4f95-8bb7-9005e785b327	sync_date	2025-09-22	active
0e4af974-ebf9-487c-b1e8-63a471213159	eef94ec3-bca8-4b26-b6f3-9324d7f9799c	ocean_expert_id	19392	active
0577cc21-86d3-4242-bf89-7f2e2f2c0440	eef94ec3-bca8-4b26-b6f3-9324d7f9799c	data_source	obis_oceanexpert	active
2029c0b1-f52f-4d72-abcc-0965908e9f7d	eef94ec3-bca8-4b26-b6f3-9324d7f9799c	sync_date	2025-09-22	active
02473d03-062f-48b1-8f87-9737190b268f	db358bae-c6bd-4a7f-8726-4b217cf389f5	ocean_expert_id	20786	active
ceab3a2f-a1dd-4160-b1bd-5715ba0e0585	db358bae-c6bd-4a7f-8726-4b217cf389f5	data_source	obis_oceanexpert	active
11d6379a-f167-446b-8f75-2a3642c2a22b	db358bae-c6bd-4a7f-8726-4b217cf389f5	sync_date	2025-09-22	active
01be8e0d-6bac-4e09-bc27-274f7fd6cd89	d76ba351-d472-460f-8569-4a832ef633ac	ocean_expert_id	19607	active
fbaeb443-17ca-4fae-8763-2e9e36e13ca5	d76ba351-d472-460f-8569-4a832ef633ac	data_source	obis_oceanexpert	active
308bf503-260e-4044-855a-ed66cda2f024	d76ba351-d472-460f-8569-4a832ef633ac	sync_date	2025-09-22	active
4dc1a8ff-9a0c-4f19-8e32-33afea21c88e	b7f123f8-c806-4e09-9a6b-590332c6b8aa	ocean_expert_id	19434	active
0586067f-c513-4be0-b505-ca702aaae012	b7f123f8-c806-4e09-9a6b-590332c6b8aa	data_source	obis_oceanexpert	active
34274437-6a58-4704-b866-337694aafc44	b7f123f8-c806-4e09-9a6b-590332c6b8aa	sync_date	2025-09-22	active
0572a0f7-738b-4a4f-8d4e-88e5337875c0	c88cb4db-68fe-44f4-8057-37900c9bd8fd	ocean_expert_id	9605	active
d0ee53f7-a39a-4767-9cbb-412604f23ce5	c88cb4db-68fe-44f4-8057-37900c9bd8fd	data_source	obis_oceanexpert	active
386db8b9-a770-4c21-ac19-8e5b6f06a7ec	c88cb4db-68fe-44f4-8057-37900c9bd8fd	sync_date	2025-09-22	active
d9949378-6c26-47e0-a93f-89a2ef271745	8f98c818-40b2-42db-9121-4cc68b3bf2a8	ocean_expert_id	21871	active
a8e95653-d4af-41f4-914d-db9c733523ea	8f98c818-40b2-42db-9121-4cc68b3bf2a8	data_source	obis_oceanexpert	active
0e7f966a-752e-4894-b695-e9f0aef57443	8f98c818-40b2-42db-9121-4cc68b3bf2a8	sync_date	2025-09-22	active
cab1f874-1378-4e9c-a531-2742e184c59e	bb75c8dd-1dea-41b4-bc1d-725b29129e62	ocean_expert_id	5922	active
178924ad-cefa-4104-93ef-be8f9b42f7fe	bb75c8dd-1dea-41b4-bc1d-725b29129e62	data_source	obis_oceanexpert	active
81ab9857-2e6f-4aec-bd2c-b818e8464659	bb75c8dd-1dea-41b4-bc1d-725b29129e62	sync_date	2025-09-22	active
abe70699-0227-4615-a7a5-9f2b486d12b4	59a0abde-da3b-44f6-8c10-3314dbd3e158	ocean_expert_id	18450	active
7c918618-628c-43b8-9768-aca4ff0f3511	59a0abde-da3b-44f6-8c10-3314dbd3e158	data_source	obis_oceanexpert	active
066951b2-b96e-41b5-842d-8b08092278c8	59a0abde-da3b-44f6-8c10-3314dbd3e158	sync_date	2025-09-22	active
6362ac89-554e-4a08-83ed-e05ef4536a5f	bdc0848a-c777-49c3-ae3e-d2428c4465a6	ocean_expert_id	18451	active
7f568040-3f80-49b9-a1f1-b7aec590167a	bdc0848a-c777-49c3-ae3e-d2428c4465a6	data_source	obis_oceanexpert	active
257445c4-a8fa-4b97-8f50-a5520d81b431	bdc0848a-c777-49c3-ae3e-d2428c4465a6	sync_date	2025-09-22	active
5d94cac9-ff63-4ba8-9d71-cdf259de6cd5	e6d5c49e-e7c6-4f94-b0b7-8ef444eaeb9c	ocean_expert_id	21893	active
751f7bce-0dd9-4708-af28-c52f780b0622	e6d5c49e-e7c6-4f94-b0b7-8ef444eaeb9c	data_source	obis_oceanexpert	active
d1e49611-ae56-41cf-992b-32a6486117f6	e6d5c49e-e7c6-4f94-b0b7-8ef444eaeb9c	sync_date	2025-09-22	active
a9a9965e-61ac-4cf0-83b8-d3ae336e6a95	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	ocean_expert_id	5433	active
884212b5-921c-4cbb-858b-c07da74682de	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	data_source	obis_oceanexpert	active
8437b38f-7635-4f1a-a68c-07f1ef1abdf5	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	sync_date	2025-09-22	active
19c9ad68-892d-4fee-af14-8a5afb34f968	131aead9-4b5f-42c8-b1be-4efb65f27f85	ocean_expert_id	20808	active
1e3d6137-7b73-4abe-b162-876edd7a5e90	131aead9-4b5f-42c8-b1be-4efb65f27f85	data_source	obis_oceanexpert	active
910dfab7-6327-4462-a4a6-ea0162bb7bb7	131aead9-4b5f-42c8-b1be-4efb65f27f85	sync_date	2025-09-22	active
a6d1b5da-c3b6-466c-a6a5-5f3b626b1dd8	6656a424-96b6-48ce-a7ed-ac2c25236f3e	ocean_expert_id	11723	active
af2a9bb2-2182-4c55-b799-51abbc43446c	6656a424-96b6-48ce-a7ed-ac2c25236f3e	data_source	obis_oceanexpert	active
2083a00f-20b0-4f2b-bd25-5a5ff353c7c2	6656a424-96b6-48ce-a7ed-ac2c25236f3e	sync_date	2025-09-22	active
04897ee5-75c7-4f24-b3b2-660ee952af70	80e4933e-9e6d-4b53-afa6-65891c39b594	ocean_expert_id	19492	active
ad2b7f85-9dc5-43c9-b699-fda03183cc2f	80e4933e-9e6d-4b53-afa6-65891c39b594	data_source	obis_oceanexpert	active
3d3b19c1-3b67-4189-96cb-28d4fe28963b	80e4933e-9e6d-4b53-afa6-65891c39b594	sync_date	2025-09-22	active
76e23d2c-615a-4504-8558-aa79e0109657	a389d6aa-e9ba-4af1-a86e-6ec8dca6fbf4	ocean_expert_id	19438	active
814b6dde-1188-4e07-9194-05b8c55e38de	a389d6aa-e9ba-4af1-a86e-6ec8dca6fbf4	data_source	obis_oceanexpert	active
f4dbe34a-8721-4179-8e03-1cbd9302bee8	a389d6aa-e9ba-4af1-a86e-6ec8dca6fbf4	sync_date	2025-09-22	active
d8361c28-309e-45ca-bce5-75b6c59baddd	dafcfb4f-d7b8-45d3-9b61-e872659c975e	ocean_expert_id	19348	active
701d265b-2328-46cc-8661-03ac79c2d9d8	dafcfb4f-d7b8-45d3-9b61-e872659c975e	data_source	obis_oceanexpert	active
e2aaecdf-fc1e-49c7-a89b-8942100af622	dafcfb4f-d7b8-45d3-9b61-e872659c975e	sync_date	2025-09-22	active
c895f382-ee3a-420b-8d00-0cb941902bbc	ef5b612a-a6b9-48a5-8571-236f3dbea130	ocean_expert_id	19604	active
6edd7fac-7acb-4298-a4e2-b53a7950f5e5	ef5b612a-a6b9-48a5-8571-236f3dbea130	data_source	obis_oceanexpert	active
4bd6163e-d9d7-4a33-bf60-41e98b43168e	ef5b612a-a6b9-48a5-8571-236f3dbea130	sync_date	2025-09-22	active
a25d4ee3-5c97-40f6-8ca0-9be1ed1cbffa	bf21ee67-a54a-4795-a97e-c308d18eb12e	ocean_expert_id	19360	active
d09437e6-8ef7-4e1e-a9dd-2b5fa2be41dc	bf21ee67-a54a-4795-a97e-c308d18eb12e	data_source	obis_oceanexpert	active
9ff019b1-b11f-468e-99be-1d167fa03c96	bf21ee67-a54a-4795-a97e-c308d18eb12e	sync_date	2025-09-22	active
991a901c-0f69-4dad-b583-e2b9febedb1d	c177523f-2836-40b9-8f30-84692218550a	ocean_expert_id	20851	active
14dfd3f9-1d77-403d-b464-fcb0ddca4d83	c177523f-2836-40b9-8f30-84692218550a	data_source	obis_oceanexpert	active
4d34dbc2-9b51-479b-83da-01a9bf9deb2e	c177523f-2836-40b9-8f30-84692218550a	sync_date	2025-09-22	active
1bcb1db6-af5a-4458-893b-c19a798edeba	59e8c52c-1e3d-49c2-9070-83cacf6a95c9	ocean_expert_id	19368	active
d0ba3b68-b540-477e-8866-0a0f264b8788	59e8c52c-1e3d-49c2-9070-83cacf6a95c9	data_source	obis_oceanexpert	active
14fd31f3-6189-4578-96f7-4e0316185860	59e8c52c-1e3d-49c2-9070-83cacf6a95c9	sync_date	2025-09-22	active
c8e10191-0187-4051-b8a8-54f4910d2fc4	ed7bd8d8-ceb7-45b5-8cab-c28ea30fd2bb	ocean_expert_id	23200	active
300a2e90-7541-4257-8b2d-abbf39e2afe3	ed7bd8d8-ceb7-45b5-8cab-c28ea30fd2bb	data_source	obis_oceanexpert	active
4872c79c-65c2-4ab8-ada7-684bfbb3c230	ed7bd8d8-ceb7-45b5-8cab-c28ea30fd2bb	sync_date	2025-09-22	active
e3382025-7508-4ab1-85f6-c43832ab0e73	bc60400e-420e-4599-98d6-18b90fe187f9	ocean_expert_id	12090	active
6227a409-3e2e-463b-8b86-3de1687ba4d8	bc60400e-420e-4599-98d6-18b90fe187f9	data_source	obis_oceanexpert	active
43b0b09f-28c2-4967-b781-8c5aaa7cbd73	bc60400e-420e-4599-98d6-18b90fe187f9	sync_date	2025-09-22	active
53abecf9-f408-45f4-b182-f1b66b473904	c22f3f61-efb4-43c2-8b85-eff313c57d92	ocean_expert_id	19194	active
7040faf9-f322-4697-9dfc-c18d581e25ab	c22f3f61-efb4-43c2-8b85-eff313c57d92	data_source	obis_oceanexpert	active
d7732ca9-4f0b-4c3b-a93c-1417b9033e63	c22f3f61-efb4-43c2-8b85-eff313c57d92	sync_date	2025-09-22	active
41ef869c-6afc-463d-be92-a6ff7a600d30	e97f5314-0d0e-4acd-8135-2b38cab75330	ocean_expert_id	19508	active
daa351bb-7c94-4f7e-8b2f-7c114a87236d	e97f5314-0d0e-4acd-8135-2b38cab75330	data_source	obis_oceanexpert	active
cefc4374-d637-4a6f-aa85-9f93a07d921f	e97f5314-0d0e-4acd-8135-2b38cab75330	sync_date	2025-09-22	active
2081f00f-8a64-4400-acb0-ea33e1a23528	39ca8137-231e-497d-ae22-de66bc25d7a9	ocean_expert_id	19175	active
18f33f13-1d30-4f8f-aea2-b8df15e42388	39ca8137-231e-497d-ae22-de66bc25d7a9	data_source	obis_oceanexpert	active
0e5f666b-a0d4-48ad-814a-57eda30eb22e	39ca8137-231e-497d-ae22-de66bc25d7a9	sync_date	2025-09-22	active
d41dddd5-82a3-4ae1-a2c2-509e2b8926e0	350c9b99-8b67-4836-8aa0-3ff8e1046072	ocean_expert_id	20816	active
2e39af6d-2cc8-4830-810a-44ef7d890b59	350c9b99-8b67-4836-8aa0-3ff8e1046072	data_source	obis_oceanexpert	active
0417f72e-eaa3-403f-bd12-980f8ebcdb22	350c9b99-8b67-4836-8aa0-3ff8e1046072	sync_date	2025-09-22	active
d96f7237-00ab-44f2-ba3a-01057b4f1392	8d184328-c515-47b9-968c-105c21b20eea	ocean_expert_id	20876	active
c0bb2882-0a79-4fe2-86af-a45dfaf3fde4	8d184328-c515-47b9-968c-105c21b20eea	data_source	obis_oceanexpert	active
0b7b6c99-33bf-417d-90e9-1d2731030ddc	8d184328-c515-47b9-968c-105c21b20eea	sync_date	2025-09-22	active
144dcc42-7966-43ca-8ca1-e1aafc044d62	8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	ocean_expert_id	5374	active
09bd6d5e-930c-4efd-a01c-10554d95a2c9	8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	data_source	obis_oceanexpert	active
dddd9026-94e9-4f3d-b068-d662c4e7160f	8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	sync_date	2025-09-22	active
704b41a8-24a7-443f-91cc-59210a989f0d	3aef56bf-23cb-4135-ac0d-224a1d8545e5	ocean_expert_id	19306	active
a65b53c0-d413-4ca1-bc4f-b5c1d3d99950	3aef56bf-23cb-4135-ac0d-224a1d8545e5	data_source	obis_oceanexpert	active
acc5a772-8cab-4f30-8ec9-5fbe1af71d02	3aef56bf-23cb-4135-ac0d-224a1d8545e5	sync_date	2025-09-22	active
3b2de88a-e537-43ff-a7df-244383bc52fe	86610961-056c-4151-9c4e-3f6bb20c3832	ocean_expert_id	19495	active
54b82ab3-7e77-44a6-a436-b378373f9346	86610961-056c-4151-9c4e-3f6bb20c3832	data_source	obis_oceanexpert	active
8a1057db-c718-47e2-a409-233251d57567	86610961-056c-4151-9c4e-3f6bb20c3832	sync_date	2025-09-22	active
5d74d525-9af0-4700-a797-4d08225f1d49	e4478358-2dcf-4384-b600-08b0e0de1c95	ocean_expert_id	19402	active
183ef506-ed4b-4746-92ab-6a672bfdb028	e4478358-2dcf-4384-b600-08b0e0de1c95	data_source	obis_oceanexpert	active
512db937-c426-4ce7-828c-3ae3d56e8020	e4478358-2dcf-4384-b600-08b0e0de1c95	sync_date	2025-09-22	active
febf143b-6cf7-4c04-a646-0d7aaf0e1f30	b1da8b11-223d-4732-8017-3f719038dae0	ocean_expert_id	20895	active
03ec8359-407a-497e-a50b-3a4814de428d	b1da8b11-223d-4732-8017-3f719038dae0	data_source	obis_oceanexpert	active
6e91ac0e-78c2-433b-bc4b-aa29e80a1479	b1da8b11-223d-4732-8017-3f719038dae0	sync_date	2025-09-22	active
117d5519-8003-4cd3-bc8c-8b8cf0c2a542	d724cd5d-9e63-41bb-8e5d-73bb841f6cd5	ocean_expert_id	19099	active
b5bf1643-b327-4c23-8494-c2a2481ae773	d724cd5d-9e63-41bb-8e5d-73bb841f6cd5	data_source	obis_oceanexpert	active
30685faf-9f39-4df8-be8c-aead855392f3	d724cd5d-9e63-41bb-8e5d-73bb841f6cd5	sync_date	2025-09-22	active
6447fcd1-071f-495c-860e-7483587925b3	88075da4-0351-4e14-a7da-6114f0309775	ocean_expert_id	15748	active
bfbff3a2-daf2-476f-abe9-5170d854861b	88075da4-0351-4e14-a7da-6114f0309775	data_source	obis_oceanexpert	active
1f95fe99-e853-42a4-90ae-071696d92572	88075da4-0351-4e14-a7da-6114f0309775	sync_date	2025-09-22	active
cf913f4e-5d5a-4bcd-a13e-f23a27fafb48	46b0d887-58bf-4976-be93-cfe1f1bb40bc	ocean_expert_id	19582	active
7290e07d-0985-4cb9-bc84-c996c15543af	46b0d887-58bf-4976-be93-cfe1f1bb40bc	data_source	obis_oceanexpert	active
c7e2b34b-1e6f-4ba6-9272-86a19a742eca	46b0d887-58bf-4976-be93-cfe1f1bb40bc	sync_date	2025-09-22	active
1a2a224d-fa32-430e-a1cc-dfb0952d51ed	a0566913-b123-4db5-8795-c36dd15bfbd2	ocean_expert_id	18116	active
94fabd75-b783-4811-8e37-e36d569d73b3	a0566913-b123-4db5-8795-c36dd15bfbd2	data_source	obis_oceanexpert	active
014abf27-a917-4c51-afa9-3ccea5445ff5	a0566913-b123-4db5-8795-c36dd15bfbd2	sync_date	2025-09-22	active
bd7d0538-4791-4953-b1a5-b70064d6232d	d872e3e6-54fc-4a24-9c6f-c108d3d8696b	ocean_expert_id	19322	active
a7edc56d-b4b8-4274-bb2f-ce09b52a5365	d872e3e6-54fc-4a24-9c6f-c108d3d8696b	data_source	obis_oceanexpert	active
16755b31-27d0-4a97-969c-8a29072e83f1	d872e3e6-54fc-4a24-9c6f-c108d3d8696b	sync_date	2025-09-22	active
9d4d7f0a-ca0f-4ede-b525-ec61619d20bd	821f9831-8ab3-4015-8699-1493f2aa55bc	ocean_expert_id	9179	active
a661292f-b892-4565-8f4f-6c21114d8d08	821f9831-8ab3-4015-8699-1493f2aa55bc	data_source	obis_oceanexpert	active
bb36df61-1554-44db-90b9-94bc2b29f196	821f9831-8ab3-4015-8699-1493f2aa55bc	sync_date	2025-09-22	active
8abd3075-4247-4722-b779-6e711f28d1c5	a2984ea7-0216-4f24-92ed-735096343c7d	ocean_expert_id	18199	active
9709c017-0cd4-4f9c-9e19-47fa0400c70b	a2984ea7-0216-4f24-92ed-735096343c7d	data_source	obis_oceanexpert	active
4aaf36a1-982c-4037-afca-499a419e6826	a2984ea7-0216-4f24-92ed-735096343c7d	sync_date	2025-09-22	active
fa065092-5270-4de5-86f2-30990b51ca70	a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	ocean_expert_id	19513	active
015f4c19-b1b2-43f3-97aa-f3f47bb7ad2a	a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	data_source	obis_oceanexpert	active
e728c01e-9188-4dbc-b847-99a6c744356d	a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	sync_date	2025-09-22	active
279e81ad-8993-4da3-80b5-125437ce93dc	75ab8796-08cb-485d-b137-bdf246c84ad8	ocean_expert_id	19186	active
aa5e0385-ad8d-40f2-9bca-5ce23353203a	75ab8796-08cb-485d-b137-bdf246c84ad8	data_source	obis_oceanexpert	active
ba0710be-5161-4231-a86d-086554b82466	75ab8796-08cb-485d-b137-bdf246c84ad8	sync_date	2025-09-22	active
7e1c0ce2-b057-44de-a83d-a45b4091e782	2b07e482-a787-4499-9737-fa3e488f19e0	ocean_expert_id	19178	active
b366e6d6-cd08-44e5-95d6-5968bd33a141	2b07e482-a787-4499-9737-fa3e488f19e0	data_source	obis_oceanexpert	active
b9e1e055-74c8-4be2-b8bc-e43b573ceb89	2b07e482-a787-4499-9737-fa3e488f19e0	sync_date	2025-09-22	active
778df4a5-ea52-4d86-92e4-de78b082e412	63385ab9-f57a-4eae-a1ae-8212f114cc46	ocean_expert_id	19628	active
bb99f867-89c3-44e6-85d0-deb586665d6d	63385ab9-f57a-4eae-a1ae-8212f114cc46	data_source	obis_oceanexpert	active
71753c36-0051-4bb3-8f40-b025e5f3edea	63385ab9-f57a-4eae-a1ae-8212f114cc46	sync_date	2025-09-22	active
e542c0d2-cb3e-487e-9dd6-8cc0fbb55533	aee7e56c-06eb-476d-ac2f-f0faefcb2612	ocean_expert_id	10429	active
c2c65b0b-725b-47ed-b8f5-e7a24a69ee29	aee7e56c-06eb-476d-ac2f-f0faefcb2612	data_source	obis_oceanexpert	active
dee22fa7-8908-4971-85d7-5a1b57689c42	aee7e56c-06eb-476d-ac2f-f0faefcb2612	sync_date	2025-09-22	active
9a0cf1b8-e0c7-4fa2-82a0-2af17d86d10a	eb4bc51c-9225-4b28-960e-4123e11315b3	ocean_expert_id	10355	active
bf4ca213-04d1-405c-9333-d5f0f7fd954d	eb4bc51c-9225-4b28-960e-4123e11315b3	data_source	obis_oceanexpert	active
6bcbf050-9cc0-44b6-9a21-6d4d9478c6ae	eb4bc51c-9225-4b28-960e-4123e11315b3	sync_date	2025-09-22	active
21b1f7c7-2ccb-4901-928f-84fa7368ae4e	8da43065-d681-4a4d-9f4b-37bc6598d9dd	ocean_expert_id	20883	active
f827909d-3796-49e4-9e86-67371c37cbf4	8da43065-d681-4a4d-9f4b-37bc6598d9dd	data_source	obis_oceanexpert	active
32568429-2f22-4d6e-82da-cc3e08d3f92b	8da43065-d681-4a4d-9f4b-37bc6598d9dd	sync_date	2025-09-22	active
58682416-4b5d-43c6-a058-9d4e53219368	5a4618e8-aefc-4721-8adc-ff442928090d	ocean_expert_id	20838	active
038b051f-74e8-46a8-acf9-ac935d4145a2	5a4618e8-aefc-4721-8adc-ff442928090d	data_source	obis_oceanexpert	active
6a084ef7-3833-4893-877e-38e5e276f83b	5a4618e8-aefc-4721-8adc-ff442928090d	sync_date	2025-09-22	active
238fd145-22e4-4e77-bb14-7b2d06ecac7b	83f33156-eeb2-4d6a-8b2c-195098119758	ocean_expert_id	19545	active
04f806e3-1e0b-40e7-8f8b-16e7dd2d9213	83f33156-eeb2-4d6a-8b2c-195098119758	data_source	obis_oceanexpert	active
9a069524-c9d6-4cdf-b4af-cb4d9cfd09d3	83f33156-eeb2-4d6a-8b2c-195098119758	sync_date	2025-09-22	active
b2a9942e-669d-43d5-8d77-2e5248ac65d9	ea04f2bc-c054-4e92-bb94-dcb31404328c	ocean_expert_id	20781	active
2e625ff3-db84-455e-87be-f0a0de89e926	ea04f2bc-c054-4e92-bb94-dcb31404328c	data_source	obis_oceanexpert	active
eef98861-1f0f-4ded-a5ae-c642e2898a6b	ea04f2bc-c054-4e92-bb94-dcb31404328c	sync_date	2025-09-22	active
fb379204-6e2f-4ed1-9d06-a10a0a109ee9	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	ocean_expert_id	13238	active
27076cbf-29ad-4763-962e-2eb5c4127f92	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	data_source	obis_oceanexpert	active
3f715988-1123-4ecc-87d0-b42d0b944afa	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	sync_date	2025-09-22	active
74b387ee-1806-4dfe-8f12-6084eb0770fa	eff016a7-9f02-46a2-aa39-3d5960c14801	ocean_expert_id	19290	active
2d15a789-cdb8-4e80-aefa-b18dad6f1ffb	eff016a7-9f02-46a2-aa39-3d5960c14801	data_source	obis_oceanexpert	active
5005c370-3cdd-4960-b2b8-72cddcdcc932	eff016a7-9f02-46a2-aa39-3d5960c14801	sync_date	2025-09-22	active
f2f667c6-cc65-434e-be6f-c132bab70756	b21f79c7-e15a-4794-beff-f4c353903d02	ocean_expert_id	19193	active
920a32ab-3e0f-4300-88d1-def21b4cddee	b21f79c7-e15a-4794-beff-f4c353903d02	data_source	obis_oceanexpert	active
6e12cc6a-626f-4ecd-b469-75f3e2e8393a	b21f79c7-e15a-4794-beff-f4c353903d02	sync_date	2025-09-22	active
2559e75f-1c4e-4fde-be87-9a189c49cbae	1c002e91-1a9a-4f13-b514-fd11af8c32fd	ocean_expert_id	20049	active
550f7215-85c3-46a4-8d43-61facd6652c7	1c002e91-1a9a-4f13-b514-fd11af8c32fd	data_source	obis_oceanexpert	active
3c3e2b96-6d8b-43e0-8422-c8cdeae33ebb	1c002e91-1a9a-4f13-b514-fd11af8c32fd	sync_date	2025-09-22	active
5444ce65-bf6c-49ae-9c9f-b29fe6f856d5	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	ocean_expert_id	16002	active
6cb8dfd9-1198-458b-ad39-4aa01eccc4f0	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	data_source	obis_oceanexpert	active
69c20b0f-3c98-47c1-97a3-435feb227ca9	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	sync_date	2025-09-22	active
508aed7e-7301-4d41-bb56-5c48f9686d53	95df44c1-644f-437e-9c39-989caff18ee4	ocean_expert_id	19547	active
9765c3a5-e651-4278-b910-249a9666d23b	95df44c1-644f-437e-9c39-989caff18ee4	data_source	obis_oceanexpert	active
b8213e8e-75f4-4947-b1a7-0ac7f40efe0e	95df44c1-644f-437e-9c39-989caff18ee4	sync_date	2025-09-22	active
3e030fde-173d-47a6-9856-d85d673c8162	56bb757e-7427-4bf2-afdc-7669b7cb4afc	ocean_expert_id	18873	active
d02e3ab9-656d-4568-b6c7-585453ebbc3b	56bb757e-7427-4bf2-afdc-7669b7cb4afc	data_source	obis_oceanexpert	active
3e8286c8-bca6-4a54-b749-2998be2d6fb6	56bb757e-7427-4bf2-afdc-7669b7cb4afc	sync_date	2025-09-22	active
0d95afef-33b7-4758-946c-e6bb6e6630bc	5832257f-6aaf-4691-889b-d919e8a15159	ocean_expert_id	5413	active
7806355c-ef67-43cf-81fe-a8bf181f0cf8	5832257f-6aaf-4691-889b-d919e8a15159	data_source	obis_oceanexpert	active
6a785d08-fc46-4108-88dc-630d1d15bca2	5832257f-6aaf-4691-889b-d919e8a15159	sync_date	2025-09-22	active
c49bef01-692f-4f3a-901c-142150647223	3b779396-977e-48e6-9b33-9bc06991cbcc	ocean_expert_id	11745	active
28412473-eea4-460e-9c83-3dc191259935	3b779396-977e-48e6-9b33-9bc06991cbcc	data_source	obis_oceanexpert	active
c76aec43-56fe-443f-9890-b1e8126edd51	3b779396-977e-48e6-9b33-9bc06991cbcc	sync_date	2025-09-22	active
bfd4c7d8-d079-4023-95b2-f4733895150a	65195257-f380-42b6-8127-c150f31de68d	ocean_expert_id	20836	active
3004e730-80e4-484f-966f-9b28c31ee7a8	65195257-f380-42b6-8127-c150f31de68d	data_source	obis_oceanexpert	active
383da824-2b64-4e90-adc2-6a4fadb473b2	65195257-f380-42b6-8127-c150f31de68d	sync_date	2025-09-22	active
a618fdd0-e2ce-40c8-aafe-06e47fec164a	4842a628-3350-41c8-a922-53a20eb6d466	ocean_expert_id	19465	active
2d67b49f-9544-4c88-b9fd-b106634da9fa	4842a628-3350-41c8-a922-53a20eb6d466	data_source	obis_oceanexpert	active
37d25ff8-f37d-4401-9cf9-a28c30087c70	4842a628-3350-41c8-a922-53a20eb6d466	sync_date	2025-09-22	active
425c48d9-9c59-4e6b-8ecb-fe41ff4079dc	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	ocean_expert_id	18764	active
d3e3cfbf-f5a9-4782-a652-cd07544242e8	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	data_source	obis_oceanexpert	active
69fc7095-dd87-4cf3-a72a-c163261ca273	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	sync_date	2025-09-22	active
bedd1456-0655-46a4-b327-8d4da983d1a0	fc41f84f-3f3e-4a3b-b359-24f8b5f78d18	ocean_expert_id	19341	active
6f3524ee-6e17-4c98-9ceb-9f6f44318fc3	fc41f84f-3f3e-4a3b-b359-24f8b5f78d18	data_source	obis_oceanexpert	active
a5410dd4-4e07-4437-9623-074ad1d233cd	fc41f84f-3f3e-4a3b-b359-24f8b5f78d18	sync_date	2025-09-22	active
df826d77-9d3f-4669-8214-8d40acbf0c7b	3b6db43c-5d62-4098-a9c6-605909db5458	ocean_expert_id	19595	active
f8dd7533-df90-4dd4-b853-e16e65fa8a7b	3b6db43c-5d62-4098-a9c6-605909db5458	data_source	obis_oceanexpert	active
32b81ffa-2637-4aa9-a717-abadfd857ea2	3b6db43c-5d62-4098-a9c6-605909db5458	sync_date	2025-09-22	active
2548355d-57c5-4af1-b1d2-3f394314b59f	5dbf9540-1fec-4b79-a68a-0e39c1ce080f	ocean_expert_id	13293	active
8be0ef9b-145d-4f5c-b9c6-65a18b3ca31a	5dbf9540-1fec-4b79-a68a-0e39c1ce080f	data_source	obis_oceanexpert	active
37868d0a-c68f-4da7-a02b-174f9db69866	5dbf9540-1fec-4b79-a68a-0e39c1ce080f	sync_date	2025-09-22	active
ce753865-571b-47c0-8664-bfcc9d334bc1	8eac503f-e6d2-4c82-9e2f-e56768b39dce	ocean_expert_id	15920	active
acbeddf9-439e-486b-be46-61c661b7fc8c	8eac503f-e6d2-4c82-9e2f-e56768b39dce	data_source	obis_oceanexpert	active
0a095fdb-d56e-43af-a4db-f020137f82e3	8eac503f-e6d2-4c82-9e2f-e56768b39dce	sync_date	2025-09-22	active
fd04d886-25c4-45d7-82d3-8be8c8e2390b	48021ea1-c7ba-4304-bf41-3ac7411be99e	ocean_expert_id	18868	active
417e404d-5e7f-442a-bf90-d1683e297d7d	48021ea1-c7ba-4304-bf41-3ac7411be99e	data_source	obis_oceanexpert	active
000f3a59-ff60-4e4f-964d-ac3c363819f8	48021ea1-c7ba-4304-bf41-3ac7411be99e	sync_date	2025-09-22	active
effed722-fe04-4012-9831-8d69171111eb	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	ocean_expert_id	5591	active
49fd570b-d4c9-472f-8859-361e43300e7b	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	data_source	obis_oceanexpert	active
5b846f19-fe7d-414f-b510-6733678e5d77	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	sync_date	2025-09-22	active
cb519f47-11e3-418b-a17e-ae414de12937	86a164b6-9f2b-486a-b5c3-6435267a18c6	ocean_expert_id	19441	active
fd489dfc-0b2c-493f-a8cc-038b192326bd	86a164b6-9f2b-486a-b5c3-6435267a18c6	data_source	obis_oceanexpert	active
f45f7483-cb21-4c7c-ab59-36b8217cc826	86a164b6-9f2b-486a-b5c3-6435267a18c6	sync_date	2025-09-22	active
24abdfc8-4add-4fe3-a37d-c37e34c6a568	5c164465-cecd-4316-a815-cf15782ff02e	ocean_expert_id	19278	active
3189f44e-b085-48f0-ac1b-dd49042058ff	5c164465-cecd-4316-a815-cf15782ff02e	data_source	obis_oceanexpert	active
e012dfcc-c5bf-4998-bafb-537a9d8341cb	5c164465-cecd-4316-a815-cf15782ff02e	sync_date	2025-09-22	active
30826b55-7710-4550-a670-7a5412cf09db	39436356-5c3a-4585-908f-787060c070a0	ocean_expert_id	19612	active
f4f7e28f-4abf-4875-b887-cad0b97cb4f5	39436356-5c3a-4585-908f-787060c070a0	data_source	obis_oceanexpert	active
9ff21616-aa20-4817-89ac-654364110fa4	39436356-5c3a-4585-908f-787060c070a0	sync_date	2025-09-22	active
7a09b65d-e18b-4b0e-afdd-0cb7f1d37c6e	a4b0d8f0-748f-45b4-bc42-4df697153b3e	ocean_expert_id	20812	active
d725fd34-70a5-43b5-b415-b56dc7a27843	a4b0d8f0-748f-45b4-bc42-4df697153b3e	data_source	obis_oceanexpert	active
8b3ae00d-c494-45c7-9beb-508b6c56e7df	a4b0d8f0-748f-45b4-bc42-4df697153b3e	sync_date	2025-09-22	active
67c6c940-0b01-4036-978a-8d0248c85727	d780d7e8-a438-400e-bc62-fd2d5e8b1084	ocean_expert_id	20903	active
b267f931-e278-476a-ac70-6ba26bf679a5	d780d7e8-a438-400e-bc62-fd2d5e8b1084	data_source	obis_oceanexpert	active
0b7c9925-6b9f-45bd-b6fd-0686af40fa94	d780d7e8-a438-400e-bc62-fd2d5e8b1084	sync_date	2025-09-22	active
5e74f7bc-8502-40e4-803a-9868cbcdf98d	cae477f4-9d6d-45d3-bfc7-b5f10ad444f2	ocean_expert_id	19426	active
862fd401-b9e4-46ee-a635-ed7468d3b1a4	cae477f4-9d6d-45d3-bfc7-b5f10ad444f2	data_source	obis_oceanexpert	active
8d9a97bd-8b1e-4954-b77d-8f72c888c0b9	cae477f4-9d6d-45d3-bfc7-b5f10ad444f2	sync_date	2025-09-22	active
7713622f-6b7e-4625-8031-34cfa8f7f9f7	2c067a6e-ca86-4f79-af33-a945a4c36a22	ocean_expert_id	10992	active
d55557c8-7662-413b-b7e7-0b715343d1cc	2c067a6e-ca86-4f79-af33-a945a4c36a22	data_source	obis_oceanexpert	active
a64443b9-a497-43f2-86ea-a8646c3d0b3a	2c067a6e-ca86-4f79-af33-a945a4c36a22	sync_date	2025-09-22	active
4d20ec64-559c-4265-93d6-1dc51219e669	4a33f4a4-578c-428a-9c69-e8a5aa3ec214	ocean_expert_id	19524	active
c41ea06b-889b-4d23-bf08-815618b1178c	4a33f4a4-578c-428a-9c69-e8a5aa3ec214	data_source	obis_oceanexpert	active
29fa3a86-232d-4375-9732-5223820213f0	4a33f4a4-578c-428a-9c69-e8a5aa3ec214	sync_date	2025-09-22	active
07cfb198-6620-46a4-a37e-23373f00e188	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	ocean_expert_id	19313	active
08989b55-d72d-4e24-83fb-1579660e0e9b	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	data_source	obis_oceanexpert	active
e8f2681a-ec58-4545-8d9c-f9a74f131886	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	sync_date	2025-09-22	active
7c1bd492-0aad-4de3-bfe4-07787e972fb0	b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	ocean_expert_id	19195	active
6fb91946-e631-42b9-b9ec-11a999f096dc	b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	data_source	obis_oceanexpert	active
2ec725f5-0bd0-4068-8340-aaea4ea88656	b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	sync_date	2025-09-22	active
0502dc2d-e11b-48fd-b6fc-6b55a17f8def	efe098ee-f980-48fe-9967-a272a2089e34	ocean_expert_id	19596	active
bfd02f3f-e6ed-4ac5-ac43-a0ac80ef7d9d	efe098ee-f980-48fe-9967-a272a2089e34	data_source	obis_oceanexpert	active
ffbf2972-3ce0-49f0-b53d-5e9411b433f0	efe098ee-f980-48fe-9967-a272a2089e34	sync_date	2025-09-22	active
31c76902-39dd-4b42-8383-50083e835539	5bec3a86-6382-4904-8a0a-9431a935c98b	ocean_expert_id	21894	active
497cb177-1ab2-4158-97a2-e4e4699770ad	5bec3a86-6382-4904-8a0a-9431a935c98b	data_source	obis_oceanexpert	active
cf6a9de6-1e79-4cd4-9554-3f1b3d887ea6	5bec3a86-6382-4904-8a0a-9431a935c98b	sync_date	2025-09-22	active
2ebf5648-a57e-45b1-90ef-7438a2a69346	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	ocean_expert_id	13401	active
f7bfe7d0-a736-449e-9b10-f68c9853928f	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	data_source	obis_oceanexpert	active
2517bd65-e476-4559-ab28-96d240073926	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	sync_date	2025-09-22	active
4873cdf5-368a-4123-8ac8-9444874df61e	70f6ad5f-a716-491d-9fdf-b2d87bf73ba0	ocean_expert_id	19597	active
56dc9722-d985-451b-802f-6697a0bf7775	70f6ad5f-a716-491d-9fdf-b2d87bf73ba0	data_source	obis_oceanexpert	active
0be3da16-6c30-4411-9185-553739e050bd	70f6ad5f-a716-491d-9fdf-b2d87bf73ba0	sync_date	2025-09-22	active
4c7c7e84-5309-4cac-8abb-e971f41eb175	596933a1-a00e-44b1-b9a9-7c223faa26d4	ocean_expert_id	7901	active
2bb43618-40a7-4859-8212-c88e1b6a0c34	596933a1-a00e-44b1-b9a9-7c223faa26d4	data_source	obis_oceanexpert	active
666e3f7d-bb51-40c3-af5c-8717fbb1e6e1	596933a1-a00e-44b1-b9a9-7c223faa26d4	sync_date	2025-09-22	active
aea5fa85-4151-4012-a00b-1933aa498032	cdc3b737-dc61-47f2-a64c-41e14d86ebd9	ocean_expert_id	23062	active
a1359643-fb57-49b4-8adb-71bc9f34c941	cdc3b737-dc61-47f2-a64c-41e14d86ebd9	data_source	obis_oceanexpert	active
33c9e9ea-0653-4c94-bb00-b737b6ecd747	cdc3b737-dc61-47f2-a64c-41e14d86ebd9	sync_date	2025-09-22	active
e222b256-9fe1-482e-8f1f-fdbdcfe2f9c1	14ce4c73-d741-4244-8616-6692f081937e	ocean_expert_id	19404	active
d3ec51d8-40ba-456c-85cf-ab268551acaf	14ce4c73-d741-4244-8616-6692f081937e	data_source	obis_oceanexpert	active
f283398b-2061-4be3-b5dd-f213012b1762	14ce4c73-d741-4244-8616-6692f081937e	sync_date	2025-09-22	active
b4b2ed6f-180a-45f1-8951-ec833752a191	5606193d-7fd1-43be-994c-4f50d1d6e574	ocean_expert_id	13678	active
47605dfc-ebef-4552-ad77-2caffd6ea5e6	5606193d-7fd1-43be-994c-4f50d1d6e574	data_source	obis_oceanexpert	active
187e8ab7-0a4c-4c46-bc15-a56ca72db5b4	5606193d-7fd1-43be-994c-4f50d1d6e574	sync_date	2025-09-22	active
fdbcdb02-29a8-4c99-b7bc-2d031fcc4e29	99acce96-4964-4e91-a278-4041df40e9f6	ocean_expert_id	20842	active
fa9f52d1-e555-4d42-b59a-0800f4360c14	99acce96-4964-4e91-a278-4041df40e9f6	data_source	obis_oceanexpert	active
9fce3db4-f1f4-415a-ac0d-81e1eee5be63	99acce96-4964-4e91-a278-4041df40e9f6	sync_date	2025-09-22	active
84a2e3bb-a9cc-49b7-a3e9-a5cbaa1f078c	7f842dd9-aa48-44d8-8384-4101244729da	ocean_expert_id	19505	active
07f98250-a2d5-4bdf-a6dc-9d40341b3e53	7f842dd9-aa48-44d8-8384-4101244729da	data_source	obis_oceanexpert	active
5cfb5c3e-cfc7-49a1-a593-deeba13cdec5	7f842dd9-aa48-44d8-8384-4101244729da	sync_date	2025-09-22	active
84a149da-f058-45e4-9d4a-1bfba56e76e8	bd1d27e6-96cc-4a97-92bd-384228885c83	ocean_expert_id	20809	active
16f67332-cce7-4ae8-bf27-eed1c5701a00	bd1d27e6-96cc-4a97-92bd-384228885c83	data_source	obis_oceanexpert	active
d90d838c-aa81-4f36-afe4-d46489bce7c5	bd1d27e6-96cc-4a97-92bd-384228885c83	sync_date	2025-09-22	active
25cfdd40-d44e-4ddd-b0b5-530dc8be460b	e881e184-4253-4393-94b2-8ec4da61b63f	ocean_expert_id	19478	active
cc036e6c-71e8-4e7c-9f85-cb9aa6db5e4b	e881e184-4253-4393-94b2-8ec4da61b63f	data_source	obis_oceanexpert	active
7ff50bfa-3fd5-446d-9921-8f43c6ac69ca	e881e184-4253-4393-94b2-8ec4da61b63f	sync_date	2025-09-22	active
3df80e53-66c9-4d0a-a89f-b2b6b4cba8bb	e4df8c0d-98c5-4788-96b3-1c10c9d91209	ocean_expert_id	19600	active
e4781c9d-ae2d-4ccf-9511-53542deed23b	e4df8c0d-98c5-4788-96b3-1c10c9d91209	data_source	obis_oceanexpert	active
59465fd1-8392-46b8-818b-bc08b86a6949	e4df8c0d-98c5-4788-96b3-1c10c9d91209	sync_date	2025-09-22	active
bcc3b414-5029-4ebd-90ee-cd9f783d5220	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	ocean_expert_id	5358	active
e868ba21-ac10-4615-a944-d6c8b8e803b9	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	data_source	obis_oceanexpert	active
7e6bfb9f-3eae-4676-aaff-c8dad9a3b8ac	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	sync_date	2025-09-22	active
3daa4245-014f-4425-9950-e6f1bab9c1c4	04dc13a7-cad6-4295-97b6-5ba171cfc70f	ocean_expert_id	18297	active
eb2f234a-2ad3-405b-b757-77c4e63d4f36	04dc13a7-cad6-4295-97b6-5ba171cfc70f	data_source	obis_oceanexpert	active
a0edcfd7-9c0e-4bf7-b2ab-7b738fd0c150	04dc13a7-cad6-4295-97b6-5ba171cfc70f	sync_date	2025-09-22	active
c5e4ae52-64dd-4e77-bac1-b1a1940aec65	51ce9950-fab6-4e3b-a5b6-a545ec5f21f6	ocean_expert_id	19557	active
0a7a1f58-5111-48f0-9ee6-5f818399356f	51ce9950-fab6-4e3b-a5b6-a545ec5f21f6	data_source	obis_oceanexpert	active
702ab145-b1b9-4c0d-9aa5-dce70d89c7f4	51ce9950-fab6-4e3b-a5b6-a545ec5f21f6	sync_date	2025-09-22	active
496573d2-94b1-499f-ac3b-09c0711f59e8	3cb1ecc3-11b3-4fec-8462-0ad21bda2969	ocean_expert_id	20852	active
ea16d700-c92e-488a-a14d-073f5a2c1bf7	3cb1ecc3-11b3-4fec-8462-0ad21bda2969	data_source	obis_oceanexpert	active
cb2a3b4a-cca5-4777-920d-d66a79c271d5	3cb1ecc3-11b3-4fec-8462-0ad21bda2969	sync_date	2025-09-22	active
154288b0-92ec-40c7-9635-dbbc367aaad5	08261c43-f1a0-48ce-81fa-3a83731349b1	ocean_expert_id	5239	active
ec271754-7bfb-45a6-9432-e99d10998234	08261c43-f1a0-48ce-81fa-3a83731349b1	data_source	obis_oceanexpert	active
a9b1c2ce-3bea-4ca7-b3f1-b10b74ecc9c3	08261c43-f1a0-48ce-81fa-3a83731349b1	sync_date	2025-09-22	active
d5ccdc0c-bf33-44ba-8c88-a335256a611a	453386c3-3c95-4211-922c-6205eedf7506	ocean_expert_id	20806	active
6b6a815d-ffff-417f-849e-03e9d333915c	453386c3-3c95-4211-922c-6205eedf7506	data_source	obis_oceanexpert	active
3c4b34a9-ea5d-4617-890c-a8507cb720df	453386c3-3c95-4211-922c-6205eedf7506	sync_date	2025-09-22	active
ac0798f0-ac48-4e75-9f50-c45ecf02b470	c7508cda-2d43-465e-9433-814f0b71d4a1	ocean_expert_id	6466	active
6a95d1f7-3d3b-4735-aa13-35e579edff67	c7508cda-2d43-465e-9433-814f0b71d4a1	data_source	obis_oceanexpert	active
5fab9878-e4bc-4b77-b766-a28335dbdb3b	c7508cda-2d43-465e-9433-814f0b71d4a1	sync_date	2025-09-22	active
89944685-d36c-4cfb-a5a3-22f159dfb2c0	cf37b8d5-c6fe-456b-922d-70da288be1ab	ocean_expert_id	20840	active
3ee019e8-c3b8-46f9-812b-b65bab7b0d44	cf37b8d5-c6fe-456b-922d-70da288be1ab	data_source	obis_oceanexpert	active
1e4a85f2-1b7d-4087-aeb8-a2c68617db6b	cf37b8d5-c6fe-456b-922d-70da288be1ab	sync_date	2025-09-22	active
70e56602-2bae-4982-82ad-f49fe39068f3	d7588e22-a304-411e-9dd4-7b5afbd6d5d0	ocean_expert_id	20857	active
1051e594-f24b-42cb-a963-17f8c251e6df	d7588e22-a304-411e-9dd4-7b5afbd6d5d0	data_source	obis_oceanexpert	active
5bee5f8a-8d31-4be5-8733-bbf79e0b287a	d7588e22-a304-411e-9dd4-7b5afbd6d5d0	sync_date	2025-09-22	active
b8ba5f86-e860-4a74-a361-d54118c03c2c	0ba5eb77-b00a-4890-8527-af723e8c50eb	ocean_expert_id	7381	active
8fcea117-dec9-4bdc-ae18-2a9448e0bb02	0ba5eb77-b00a-4890-8527-af723e8c50eb	data_source	obis_oceanexpert	active
43b92ad3-f198-40a6-932f-2d4d9be8249d	0ba5eb77-b00a-4890-8527-af723e8c50eb	sync_date	2025-09-22	active
b2217c56-4c68-4cea-ba18-5eb579800a8b	ce9241f6-12bf-4e79-a45a-e1b3715efe61	ocean_expert_id	18917	active
a19ca575-61f4-4b21-a85f-1741778122be	ce9241f6-12bf-4e79-a45a-e1b3715efe61	data_source	obis_oceanexpert	active
a0e9b58c-33c6-4f0c-a7a4-6732ff247cef	ce9241f6-12bf-4e79-a45a-e1b3715efe61	sync_date	2025-09-22	active
673a5bd9-6b27-4196-b500-b32531c605ac	41c1add6-fb64-4b6e-9774-dc8bf78f285c	ocean_expert_id	19567	active
db9fa8f7-e9b9-4250-804c-707f14fea5a7	41c1add6-fb64-4b6e-9774-dc8bf78f285c	data_source	obis_oceanexpert	active
4e8ad05b-baeb-4062-bfcf-8c44062e4716	41c1add6-fb64-4b6e-9774-dc8bf78f285c	sync_date	2025-09-22	active
8716dd5a-0014-4942-a230-a09a1a3c0560	27d9eec0-70c2-41c8-b973-524a1fde24ad	ocean_expert_id	19287	active
550eddac-2f2e-4c60-a7e7-1a8d61ac1b10	27d9eec0-70c2-41c8-b973-524a1fde24ad	data_source	obis_oceanexpert	active
c3789607-f7d3-400d-93d1-abdd7e0e8ea1	27d9eec0-70c2-41c8-b973-524a1fde24ad	sync_date	2025-09-22	active
91b03beb-9b53-43c4-b2d8-50d4c9fc4cd7	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	ocean_expert_id	10171	active
4a20767b-4acb-41c4-aeb4-25404a615848	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	data_source	obis_oceanexpert	active
ed4cf5c6-be89-4652-879b-dad0c8dd7b4e	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	sync_date	2025-09-22	active
c2512174-3276-477e-9de1-8ee0ee0722f7	76c01c2d-3f19-427b-b102-c3e2c00ca822	ocean_expert_id	17779	active
698eb3ab-8243-4da8-b537-2945718df1e4	76c01c2d-3f19-427b-b102-c3e2c00ca822	data_source	obis_oceanexpert	active
6f5d59dd-cbd3-4684-85b6-70d6037507f4	76c01c2d-3f19-427b-b102-c3e2c00ca822	sync_date	2025-09-22	active
f4bfe356-6479-4bbe-af91-6c7e28b30607	2e9a7a6a-01c2-45bc-aa9c-4d46323456bb	ocean_expert_id	20086	active
5277d27e-197e-4550-9bf4-acbbe3b86e14	2e9a7a6a-01c2-45bc-aa9c-4d46323456bb	data_source	obis_oceanexpert	active
e793a456-a89a-4b8c-8c78-c2d9942f3d5e	2e9a7a6a-01c2-45bc-aa9c-4d46323456bb	sync_date	2025-09-22	active
6e64a275-8a86-40d4-ab76-884b3b83462b	a982727a-c8b0-4c06-bc58-522c2d67dbcc	ocean_expert_id	20863	active
c9c43c08-9e8a-4050-a4df-a9291b1270f0	a982727a-c8b0-4c06-bc58-522c2d67dbcc	data_source	obis_oceanexpert	active
e4de272a-2cee-4873-8952-20f7f6a2ae01	a982727a-c8b0-4c06-bc58-522c2d67dbcc	sync_date	2025-09-22	active
bd4fcfa4-476e-4f2e-9699-7a44bb22a7ce	90966ad9-4d11-4371-8e14-013a22b0a8a8	ocean_expert_id	4893	active
3abfee18-755b-446f-9818-6ef3ac548caa	90966ad9-4d11-4371-8e14-013a22b0a8a8	data_source	obis_oceanexpert	active
628de96f-9f0e-48a4-9791-f6e4c90948ab	90966ad9-4d11-4371-8e14-013a22b0a8a8	sync_date	2025-09-22	active
56b3e9e0-c736-438d-a212-a1ef7711a8b2	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	ocean_expert_id	7242	active
c60ca3d4-7332-4c23-ab43-55652c80097b	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	data_source	obis_oceanexpert	active
afdd3899-d359-42f1-9748-7a9e92357c83	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	sync_date	2025-09-22	active
4568beb9-1e3c-4545-9c11-7983ba3c6a73	50c2ccac-773d-4efb-a8ea-671b83a02cbf	ocean_expert_id	19506	active
ecfcb16b-b7c6-45f0-88f4-2c7095107d42	50c2ccac-773d-4efb-a8ea-671b83a02cbf	data_source	obis_oceanexpert	active
14ad6161-0b63-407b-a06d-3d9c47e3d4ef	50c2ccac-773d-4efb-a8ea-671b83a02cbf	sync_date	2025-09-22	active
d9c7858a-e4f0-4f0b-8e67-aba17c482f0a	7eb04b9d-202f-45d0-b49f-a67cc19307f5	ocean_expert_id	20848	active
57e3817f-fcfd-4060-a001-beb897e99fbe	7eb04b9d-202f-45d0-b49f-a67cc19307f5	data_source	obis_oceanexpert	active
4befafee-ef77-4a9f-ace5-e896c424d86d	7eb04b9d-202f-45d0-b49f-a67cc19307f5	sync_date	2025-09-22	active
8c237c10-2616-4b0e-bb13-32771c46e232	d4406f37-d9f9-4759-a2f4-8288a2ed7545	ocean_expert_id	20811	active
c315bc21-85e0-41a7-8307-986ea75070c1	d4406f37-d9f9-4759-a2f4-8288a2ed7545	data_source	obis_oceanexpert	active
5a1cb0ac-74b2-447e-9aa2-2d6d0f358797	d4406f37-d9f9-4759-a2f4-8288a2ed7545	sync_date	2025-09-22	active
0c4adb11-f11a-43ed-b402-2ca917098208	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	ocean_expert_id	13487	active
37dbc057-be1c-4d86-8624-aa32aa4e0a79	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	data_source	obis_oceanexpert	active
1e0ae8ef-ab0d-481d-bfa8-6deca2d28b31	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	sync_date	2025-09-22	active
f26be1d1-c67d-4f5a-a638-9c907b17f4b8	fd38eafe-608a-4b8b-ad35-0817f95f794f	ocean_expert_id	13587	active
9281a4aa-7ef9-4f2e-bca2-c3f5658337c2	fd38eafe-608a-4b8b-ad35-0817f95f794f	data_source	obis_oceanexpert	active
5646c5d5-0c74-4039-8b05-e28482c15392	fd38eafe-608a-4b8b-ad35-0817f95f794f	sync_date	2025-09-22	active
28e5bcce-e9ca-4d3a-b29b-97e99d95bd00	70395ad1-0a15-4b1a-b28a-8d6b9c211013	ocean_expert_id	19453	active
cc52db17-bddf-46a0-8f75-71c8ef701f00	70395ad1-0a15-4b1a-b28a-8d6b9c211013	data_source	obis_oceanexpert	active
500f6d72-873f-4534-820b-99307066b795	70395ad1-0a15-4b1a-b28a-8d6b9c211013	sync_date	2025-09-22	active
95d0d438-fea2-4a09-9fa9-b0e871619f95	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	ocean_expert_id	11804	active
612f3d08-6603-418f-bc3b-01c9eeb82aae	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	data_source	obis_oceanexpert	active
9fbb1d5c-030e-4554-9061-30ff78b5d2c3	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	sync_date	2025-09-22	active
92ef2e68-dc62-4e54-ad29-7b6424bcaac7	3b9842e9-2d1f-4b4a-8538-fbe9912851d9	ocean_expert_id	13221	active
d7f288ac-e4fe-42ac-a159-94098edad6f4	3b9842e9-2d1f-4b4a-8538-fbe9912851d9	data_source	obis_oceanexpert	active
48d2d80e-45db-4d88-8307-159837660f5a	3b9842e9-2d1f-4b4a-8538-fbe9912851d9	sync_date	2025-09-22	active
e510c789-beff-4840-81cd-2449e44d8f3e	71f64ffc-3a7e-43ae-a42f-5f2afe70971d	ocean_expert_id	20787	active
4e61be2d-3457-450d-896b-10557bb75cd7	71f64ffc-3a7e-43ae-a42f-5f2afe70971d	data_source	obis_oceanexpert	active
7972f12a-5136-4c9b-9498-6c01df9aed4b	71f64ffc-3a7e-43ae-a42f-5f2afe70971d	sync_date	2025-09-22	active
2a1b0b08-ceeb-4063-b42c-78740d9a24f5	c1b034ce-3854-429c-9422-ffb7dc34c61d	ocean_expert_id	20865	active
2d35668e-5369-4b31-88c3-921250f295eb	c1b034ce-3854-429c-9422-ffb7dc34c61d	data_source	obis_oceanexpert	active
f508d614-6423-4f1c-91aa-6424f9f0c1c7	c1b034ce-3854-429c-9422-ffb7dc34c61d	sync_date	2025-09-22	active
079f7386-28e2-4fba-b236-66e77cfe29eb	a4efb55b-125c-4e53-8520-c1d1657def53	ocean_expert_id	11426	active
d16065e3-8172-405c-a79b-56261348876a	a4efb55b-125c-4e53-8520-c1d1657def53	data_source	obis_oceanexpert	active
26c19791-d48f-4984-b69b-e4eb604bcaa2	a4efb55b-125c-4e53-8520-c1d1657def53	sync_date	2025-09-22	active
0a9568da-82f0-4766-87dc-dd5cb969b2d7	46d109f1-b3b5-4e07-9baf-b248212be5fe	ocean_expert_id	17039	active
7746a467-e3c0-45d2-b485-6f418812740a	46d109f1-b3b5-4e07-9baf-b248212be5fe	website	https://www.inbo.be	active
32ef00b6-6156-4d1c-8613-c9110be616d7	46d109f1-b3b5-4e07-9baf-b248212be5fe	phone	+32 2 525 02 00	active
619890e4-c2e3-4fad-bc9d-c51efa8a0920	46d109f1-b3b5-4e07-9baf-b248212be5fe	fax	+32 2 525 03 00	active
af77b466-575e-4ed0-802a-c19c8c6a6364	46d109f1-b3b5-4e07-9baf-b248212be5fe	country	Belgium	active
75a2e6b5-28f0-44cd-af01-ceb9b23ab7aa	46d109f1-b3b5-4e07-9baf-b248212be5fe	country_code	21	active
382928c6-14cc-4b58-811f-a05ff2d7a75b	46d109f1-b3b5-4e07-9baf-b248212be5fe	acronym	INBO	active
c971e3ef-a9f2-4a00-a8cb-81a38f01d072	46d109f1-b3b5-4e07-9baf-b248212be5fe	institution_type	Government	active
c56a7d62-b2aa-4bce-983d-612e539074d1	46d109f1-b3b5-4e07-9baf-b248212be5fe	activities	<p>The&nbsp;Research Institute for Nature and Forest (INBO)&nbsp;is the Flemish research and knowledge centre for nature and its sustainable management and use. INBO conducts research and supplies knowledge to all those who prepare or make the policies or are interested in them as a stakeholder.</p><p>Through its scientific research, INBO supports all agencies dealing with open space in the Flemish government, as well as in organisations involved in nature conservation, forestry, agriculture, hunting and fishery. INBO publishes its results as open data and provides data for international reporting. It participates in (inter)national research networks such as LTER, ALTER-Net, LifeWatch, …</p>	active
1d855e49-a4df-4808-acfc-513b8b85eba3	46d109f1-b3b5-4e07-9baf-b248212be5fe	ocean_expert_updated	2017-10-19T00:00:00+02:00	active
93f42467-6870-4b72-946e-79d02ab4fd7a	46d109f1-b3b5-4e07-9baf-b248212be5fe	data_source	obis_oceanexpert	active
c37a7ab6-bbc3-4d6c-864b-703b3e0a541c	46d109f1-b3b5-4e07-9baf-b248212be5fe	data_quality	Ocean Expert data	active
8413a2c0-beb7-4642-886c-5b0c7a6dcd6d	46d109f1-b3b5-4e07-9baf-b248212be5fe	sync_date	2025-09-22	active
465438c0-bb38-4ffc-8cb0-4026f1e9b960	88693b5e-94e7-4d47-acbc-5bd01eba1786	ocean_expert_id	11379	active
0d423807-2947-43b1-9690-c64d17d20288	88693b5e-94e7-4d47-acbc-5bd01eba1786	website	http://www.noaa.gov	active
47e99b7a-4269-4eec-8815-4eb0681ea851	88693b5e-94e7-4d47-acbc-5bd01eba1786	country	United States of America	active
1f01a235-69d7-4833-b8ac-5ea671aaf1cd	88693b5e-94e7-4d47-acbc-5bd01eba1786	country_code	223	active
3f681818-0b09-4914-9aca-0d1fffb93a40	88693b5e-94e7-4d47-acbc-5bd01eba1786	acronym	NOAA	active
8fff6046-eb73-408c-8f1b-6bbd99dfdb22	88693b5e-94e7-4d47-acbc-5bd01eba1786	institution_type	Government	active
91743df9-540b-4d83-adb6-1a0dc9439176	88693b5e-94e7-4d47-acbc-5bd01eba1786	ocean_expert_edmo_code	1433	active
82cfe5a7-c676-41fc-8cca-f7eed20f7057	88693b5e-94e7-4d47-acbc-5bd01eba1786	ocean_expert_updated	2018-08-22T00:00:00+02:00	active
892bd198-2045-49a8-9a29-935b150792e2	88693b5e-94e7-4d47-acbc-5bd01eba1786	data_source	obis_oceanexpert	active
db09dd51-fb09-4376-b68e-f634a5031665	88693b5e-94e7-4d47-acbc-5bd01eba1786	data_quality	Ocean Expert data	active
45df4424-c523-4a26-9893-2da9f6d61205	88693b5e-94e7-4d47-acbc-5bd01eba1786	sync_date	2025-09-22	active
f78967cd-1ef1-48f6-aa06-453133686bf0	4293c7dd-3b02-4e12-afef-e569b5df2618	ocean_expert_id	19196	active
b0189dd7-f250-459d-9d2d-bed6b248b597	4293c7dd-3b02-4e12-afef-e569b5df2618	website	http://www.dfo-mpo.gc.ca/	active
1fed3cfb-c280-4fbb-8f8b-58086f499b12	4293c7dd-3b02-4e12-afef-e569b5df2618	country	Canada	active
703bc3bc-4324-40cd-addd-f660e353f57e	4293c7dd-3b02-4e12-afef-e569b5df2618	country_code	39	active
4de14157-258c-4b01-87a4-7f16ae03306b	4293c7dd-3b02-4e12-afef-e569b5df2618	institution_type	Government	active
37c81532-da1f-4133-aa85-7b0b3dbe24f5	4293c7dd-3b02-4e12-afef-e569b5df2618	ocean_expert_updated	2018-06-29T00:00:00+02:00	active
1f5ca6f3-3319-4f0d-ac55-637665d9a28b	4293c7dd-3b02-4e12-afef-e569b5df2618	data_source	obis_oceanexpert	active
4b2c799b-fe42-4932-8202-f14d5a0c22dd	4293c7dd-3b02-4e12-afef-e569b5df2618	data_quality	Ocean Expert data	active
f90c69f7-78ba-4dcb-94fe-b2af112b6368	4293c7dd-3b02-4e12-afef-e569b5df2618	sync_date	2025-09-22	active
2e0dba78-1516-441d-89c8-7b7ed94f78ff	f234686a-2e28-4e40-83e9-e50af8375e59	ocean_expert_id	6860	active
c643e1e2-ab5f-4640-a01e-871dab0f9a30	f234686a-2e28-4e40-83e9-e50af8375e59	website	https://www.ioc.unesco.org/en	active
49d3af6d-e30a-414b-91ae-072a7d53f90f	f234686a-2e28-4e40-83e9-e50af8375e59	phone	+33 1 45 68 39 84	active
3875f775-56dc-4fb0-bfc5-49a13ebbf6ab	f234686a-2e28-4e40-83e9-e50af8375e59	fax	+33 1 45 68 58 12	active
50088bec-171c-47db-9ac1-fe59dce106f9	f234686a-2e28-4e40-83e9-e50af8375e59	country	France	active
49e1dd49-c769-4db3-ad1f-b996bc6dfa22	f234686a-2e28-4e40-83e9-e50af8375e59	country_code	74	active
666b49fc-115c-4f48-a354-4fa6624aeac4	f234686a-2e28-4e40-83e9-e50af8375e59	acronym	IOC	active
f95bd881-4d20-4c92-b18a-f0e4efb21509	f234686a-2e28-4e40-83e9-e50af8375e59	institution_type	International / Intergovernmental	active
5f4202a8-0f50-4f07-8493-60700de30aa9	a64192e5-d445-4165-9af6-6273a9ca7fe0	ocean_expert_updated	2018-08-14T00:00:00+02:00	active
b0e66f05-5184-40c5-a149-e25ed7a69460	f234686a-2e28-4e40-83e9-e50af8375e59	activities	The Intergovernmental Oceanographic Commission of UNESCO provides Member States of the United Nations with an essential mechanism for global co-operation in the study of the ocean.<br>The IOC assists governments to address their individual and collective ocean and coastal problems through the sharing of knowledge, information and technology and through the coordination of national programmes.	active
fd73a98e-982a-461d-84b9-7bfdeb7b7c82	f234686a-2e28-4e40-83e9-e50af8375e59	ocean_expert_updated	2024-07-17T00:00:00+02:00	active
5ad4711b-71af-4d49-ba78-55b47ca82aea	f234686a-2e28-4e40-83e9-e50af8375e59	data_source	obis_oceanexpert	active
6733d8a4-2c2d-4025-aac6-406153092533	f234686a-2e28-4e40-83e9-e50af8375e59	data_quality	Ocean Expert data	active
781f0769-4d0e-4192-9b50-87ca99685bed	f234686a-2e28-4e40-83e9-e50af8375e59	sync_date	2025-09-22	active
41692c2a-ca12-483f-b860-6b774065b0ce	de156325-2b12-4304-a79d-919ff71ad136	ocean_expert_id	19393	active
b2f102af-d777-4ad6-81c0-a75ab063f98b	de156325-2b12-4304-a79d-919ff71ad136	website	https://www.duke.edu/	active
c9c8a5f0-8f43-46ef-aa0a-cd84fa4c4448	de156325-2b12-4304-a79d-919ff71ad136	phone	(919) 684-8111	active
2c9ffbcf-ab10-4ece-839a-2b65bd39dea3	de156325-2b12-4304-a79d-919ff71ad136	country	United States of America	active
e3dd4029-124c-463a-9771-81a8d66bedb8	de156325-2b12-4304-a79d-919ff71ad136	country_code	223	active
a084f0bd-b510-4bdb-be9e-890f9bea3911	de156325-2b12-4304-a79d-919ff71ad136	institution_type	Academic	active
1d2ebe9b-0a12-4269-960b-e69202ccad16	de156325-2b12-4304-a79d-919ff71ad136	ocean_expert_updated	2018-08-07T00:00:00+02:00	active
618dfff6-5d16-4546-a463-2379747f69c1	de156325-2b12-4304-a79d-919ff71ad136	data_source	obis_oceanexpert	active
49816a60-662a-4d4a-9998-0840f68184ac	de156325-2b12-4304-a79d-919ff71ad136	data_quality	Ocean Expert data	active
de16e55d-c813-4f03-b0d4-f6d0970ac93a	de156325-2b12-4304-a79d-919ff71ad136	sync_date	2025-09-22	active
35c59e02-8b3d-48b1-a178-09fed61b4cb3	135cbcba-86fc-434f-b1fd-e9377b2e837d	ocean_expert_id	7489	active
29b436e3-149b-48f0-bcb1-6464a4f7229a	135cbcba-86fc-434f-b1fd-e9377b2e837d	website	https://www.niwa.co.nz/	active
0b6b4c6b-6d17-4c6d-ac96-8ecc9ca4f157	135cbcba-86fc-434f-b1fd-e9377b2e837d	email	enquiries@niwa.co.nz	active
e42e5dca-4c76-4bdb-a428-12cd633673ca	135cbcba-86fc-434f-b1fd-e9377b2e837d	phone	+64 9 375 2050	active
5ae450db-8dcf-4b28-84d2-20eebfc53a58	135cbcba-86fc-434f-b1fd-e9377b2e837d	fax	+64 7 856 0151	active
59492834-16d5-4807-a7e4-e6c28b994afa	135cbcba-86fc-434f-b1fd-e9377b2e837d	country	New Zealand	active
1f351e0a-dd46-4b51-8280-5fe13c6428a2	135cbcba-86fc-434f-b1fd-e9377b2e837d	country_code	154	active
92d03492-e6bc-4fc2-953c-3640fde1b557	135cbcba-86fc-434f-b1fd-e9377b2e837d	acronym	NIWA	active
8631b9af-6c92-4ba2-9113-84417febb8c6	135cbcba-86fc-434f-b1fd-e9377b2e837d	institution_type	Research	active
c62ff1e0-71f9-44f0-bf61-5f3a18f7e5c6	135cbcba-86fc-434f-b1fd-e9377b2e837d	activities	systematics and taxonomy of polychaete worms\vbiology and ecology of polychaete worms\vbiogeography\vfreshwater nereids\vinformation systems and metadatabaes.	active
84cb96cd-6f41-4302-81d8-62d442717cda	135cbcba-86fc-434f-b1fd-e9377b2e837d	ocean_expert_updated	2022-02-03T00:00:00+01:00	active
79dfa146-04dc-482a-a998-62584d90e212	135cbcba-86fc-434f-b1fd-e9377b2e837d	data_source	obis_oceanexpert	active
c4c38f78-872e-4a63-b163-67a5e44fe03d	135cbcba-86fc-434f-b1fd-e9377b2e837d	data_quality	Ocean Expert data	active
bb61e509-acbc-4766-9abd-75fca5d72a2b	135cbcba-86fc-434f-b1fd-e9377b2e837d	sync_date	2025-09-22	active
7cb9aec5-40b3-43cf-8c52-97d1749ae3dc	8c413eeb-cd86-460e-8200-7806e64cecd3	ocean_expert_id	14254	active
37a2eec3-487a-4d44-8156-936557e67746	8c413eeb-cd86-460e-8200-7806e64cecd3	country	Canada	active
b40bd8aa-8d78-4941-ac91-3c898730ed61	8c413eeb-cd86-460e-8200-7806e64cecd3	country_code	39	active
e15ad86d-9c1f-4522-bea2-cdae7a7fa4e1	8c413eeb-cd86-460e-8200-7806e64cecd3	institution_type	Academic	active
7f37346a-07ff-4466-b8ca-bbb3bf9f9469	8c413eeb-cd86-460e-8200-7806e64cecd3	ocean_expert_edmo_code	4180	active
7d58045b-5191-431d-bc5a-5d8dd96241a9	8c413eeb-cd86-460e-8200-7806e64cecd3	ocean_expert_updated	2018-06-29T00:00:00+02:00	active
80d0e475-d7f7-4a95-8be3-f9399bdf987c	8c413eeb-cd86-460e-8200-7806e64cecd3	data_source	obis_oceanexpert	active
b664eb2a-d4c4-46f8-b505-4bc19cc9da61	8c413eeb-cd86-460e-8200-7806e64cecd3	data_quality	Ocean Expert data	active
581abb9b-e58c-41e3-b231-c9c622f019fd	8c413eeb-cd86-460e-8200-7806e64cecd3	sync_date	2025-09-22	active
207777f3-c95b-4638-9aa2-9fe0f81763b7	a64192e5-d445-4165-9af6-6273a9ca7fe0	ocean_expert_id	6656	active
738ffd44-8e38-40c6-aea5-d97b50cf21f6	a64192e5-d445-4165-9af6-6273a9ca7fe0	website	http://www.uva.nl/en/shared-content/organisatiegids/en/university-of-amsterdam/faculties/faculty-of-science-fnwi/institute-for-biodiversity-and-ecosystem-dynamics/institute-for-biodiversity-and-ecosystem-dynamics.html	active
07742c16-18dd-41f6-9349-495e386becb6	a64192e5-d445-4165-9af6-6273a9ca7fe0	email	servicedesk-ac@uva.nl	active
f0b86b92-24fa-4f3d-9f4f-3af396d7dd42	a64192e5-d445-4165-9af6-6273a9ca7fe0	phone	+31 20 525 6635	active
5ea72bab-6140-4b6a-947f-221d3ab457b0	a64192e5-d445-4165-9af6-6273a9ca7fe0	fax	+31 20 525 7832	active
252af4f1-f0d2-4498-be9f-fffecb6fb07a	a64192e5-d445-4165-9af6-6273a9ca7fe0	country	Netherlands (Kingdom of the)	active
2e66767a-951d-4040-bcd7-b7a0697cab96	a64192e5-d445-4165-9af6-6273a9ca7fe0	country_code	151	active
56a106bc-26f8-41f0-bc02-3b871ff89d55	a64192e5-d445-4165-9af6-6273a9ca7fe0	acronym	IBED/ UvA	active
47896e21-8e12-49b5-82ee-4a0e465d30b3	a64192e5-d445-4165-9af6-6273a9ca7fe0	institution_type	Research	active
87b6d5fc-adfe-4aed-8e39-0d8786c5408f	a64192e5-d445-4165-9af6-6273a9ca7fe0	ocean_expert_edmo_code	2514	active
d97b2fbf-2691-41f5-a6a3-1ecda5fbe7ab	a64192e5-d445-4165-9af6-6273a9ca7fe0	activities	At the broadest level, the mission of the Institute for Biodiversity and Ecosystem Dynamics (IBED) is to increase our understanding of the diversity and dynamics of ecosystems from the level of molecules and genes to entire ecosystems.<br>Our aim is to unravel how ecosystems function in their full complexity, and how they change due to natural processes and human interference.<br>The focus in IBED lies on the study of two interlinked aspects:<br>(i) how do organisms interact with one another and with their abiotic environment, and<br>(ii) what are the dynamics that emerge from these interactions	active
d07ba09d-4215-46df-a3bd-1253b040cd31	a64192e5-d445-4165-9af6-6273a9ca7fe0	data_source	obis_oceanexpert	active
1a208e65-dbac-410b-bc7c-5d078818382d	a64192e5-d445-4165-9af6-6273a9ca7fe0	data_quality	Ocean Expert data	active
241b91fd-b672-4c73-9621-bedea1cd62cd	a64192e5-d445-4165-9af6-6273a9ca7fe0	sync_date	2025-09-22	active
cab96d20-e92e-4dc4-8128-d15e241752b5	90df177a-63af-44a9-bf2c-8a1d3623fb64	ocean_expert_id	5028	active
0e46380d-92a2-4dcb-8a11-1f5cce87bc95	90df177a-63af-44a9-bf2c-8a1d3623fb64	website	www.aad.gov.au/	active
169b18d2-1cfe-4e57-b8d0-a80f2adf1350	90df177a-63af-44a9-bf2c-8a1d3623fb64	phone	+61 3 6232 3209	active
ddddecc1-82e2-4e39-bd8b-85c9978bd7c7	90df177a-63af-44a9-bf2c-8a1d3623fb64	fax	+61 3 6232 3288	active
ea2dddde-89c7-46de-86e2-72d2676d5e39	90df177a-63af-44a9-bf2c-8a1d3623fb64	country	Australia	active
92add003-990b-4ce0-a4da-a0321b4fe4f2	90df177a-63af-44a9-bf2c-8a1d3623fb64	country_code	13	active
465ff35f-0551-4b99-8fda-cd9202467a81	90df177a-63af-44a9-bf2c-8a1d3623fb64	acronym	AAD	active
292d7ddc-c9a3-4f5b-9ce2-dee6103cf9af	90df177a-63af-44a9-bf2c-8a1d3623fb64	institution_type	Government	active
2a0dc424-03de-4900-ae1d-b24b8e7afd79	90df177a-63af-44a9-bf2c-8a1d3623fb64	activities	Administering Australia's wide-ranging activities in antarctic and subantarctic regions is the responsibility of the Australian Antarctic Division (AAD), a part of the Australian Government	active
fed31469-694c-443d-924e-cec1a01093fe	90df177a-63af-44a9-bf2c-8a1d3623fb64	ocean_expert_updated	2009-11-25T00:00:00+01:00	active
f61c501e-8a0b-42a8-b9a5-9f4fa459d304	90df177a-63af-44a9-bf2c-8a1d3623fb64	data_source	obis_oceanexpert	active
078806b5-7276-4283-a019-3aa1245fc9e4	90df177a-63af-44a9-bf2c-8a1d3623fb64	data_quality	Ocean Expert data	active
86e2b56e-645e-4279-9d31-b612b05fa79b	90df177a-63af-44a9-bf2c-8a1d3623fb64	sync_date	2025-09-22	active
8d43d7ca-1f13-4fdb-9103-60e0e280325b	a932f0a0-a551-407f-a812-9eda4c4eac9e	ocean_expert_id	15442	active
71a03bda-79a4-408f-840b-057abfcbc6bd	a932f0a0-a551-407f-a812-9eda4c4eac9e	phone	+61295147533	active
58307c89-62ff-4a8a-8c1e-c2872b60c103	a932f0a0-a551-407f-a812-9eda4c4eac9e	fax	+61293514119	active
a46c9ebc-6fa4-4cfc-befb-0603381db4af	a932f0a0-a551-407f-a812-9eda4c4eac9e	country	Australia	active
39686a8e-844a-443a-aed2-f2ff239c4859	a932f0a0-a551-407f-a812-9eda4c4eac9e	country_code	13	active
2ddda430-84a6-4fe2-bd52-86a519c224b7	a932f0a0-a551-407f-a812-9eda4c4eac9e	acronym	UTS	active
7265853d-f906-4ca3-a212-079eb423f51a	a932f0a0-a551-407f-a812-9eda4c4eac9e	institution_type	Academic	active
333ca55e-a183-4b41-a10c-07c2b20f0a4f	a932f0a0-a551-407f-a812-9eda4c4eac9e	ocean_expert_updated	2013-07-19T00:00:00+02:00	active
5770aa9c-5650-49ce-b136-c39cd3d118aa	a932f0a0-a551-407f-a812-9eda4c4eac9e	data_source	obis_oceanexpert	active
c1fa24b6-960d-4339-8ece-0e38e204a34c	a932f0a0-a551-407f-a812-9eda4c4eac9e	data_quality	Ocean Expert data	active
60221a37-345d-4d53-95a8-983957bac6fc	a932f0a0-a551-407f-a812-9eda4c4eac9e	sync_date	2025-09-22	active
772ddac6-8da9-4d65-b42c-95b16dda96dd	ba214d46-0090-43ad-8768-9558a6af5fcf	ocean_expert_id	19359	active
71b56b30-0d6b-43f6-8f13-e8891035d787	ba214d46-0090-43ad-8768-9558a6af5fcf	website	https://www.buwa.nl/en/	active
45788c65-7605-4321-beed-7e7fa3364645	ba214d46-0090-43ad-8768-9558a6af5fcf	email	info@buwa.nl	active
29f447de-72da-436f-ba75-a5bd468c1df8	ba214d46-0090-43ad-8768-9558a6af5fcf	country	Netherlands (Kingdom of the)	active
b66a8de4-788d-448e-9fdb-c472aaa96d23	ba214d46-0090-43ad-8768-9558a6af5fcf	country_code	151	active
a2b718ed-0737-4598-9fd0-45ac2b79f07a	ba214d46-0090-43ad-8768-9558a6af5fcf	institution_type	Private commercial	active
69d1d6f5-a927-4a39-95ec-f233b8b42eec	ba214d46-0090-43ad-8768-9558a6af5fcf	ocean_expert_updated	2020-07-20T00:00:00+02:00	active
3deb495d-9cad-48fe-8fd5-9c1951b534ee	ba214d46-0090-43ad-8768-9558a6af5fcf	data_source	obis_oceanexpert	active
5afb3bec-0aff-474f-8ce5-bd77ea7f604d	ba214d46-0090-43ad-8768-9558a6af5fcf	data_quality	Ocean Expert data	active
ac932ff7-a894-4053-8fe9-074ece3be692	ba214d46-0090-43ad-8768-9558a6af5fcf	sync_date	2025-09-22	active
8e6cba52-0f1f-4339-a5e2-1634da7034a1	b9f23216-9065-44f4-856e-a254a57c20e0	ocean_expert_id	19328	active
450cab09-2e60-4b1f-b315-3435bb83ea17	b9f23216-9065-44f4-856e-a254a57c20e0	website	https://www.ugent.be/	active
c3ff5502-c80b-437d-a651-da6110bdc814	b9f23216-9065-44f4-856e-a254a57c20e0	country	Belgium	active
785e88c7-6476-4cc1-8230-f965af6580be	b9f23216-9065-44f4-856e-a254a57c20e0	country_code	21	active
b6f51e07-3d42-4d75-a3ee-92b17b089ab8	b9f23216-9065-44f4-856e-a254a57c20e0	acronym	UGent	active
b62c6743-3250-4302-9135-82a2157395b7	b9f23216-9065-44f4-856e-a254a57c20e0	institution_type	Academic	active
7c053361-1419-41b7-b245-e3b1e124c31d	b9f23216-9065-44f4-856e-a254a57c20e0	ocean_expert_updated	2018-11-10T00:00:00+01:00	active
dbdbf054-4bab-4a0b-a8e3-57f17432ca1c	b9f23216-9065-44f4-856e-a254a57c20e0	data_source	obis_oceanexpert	active
e8548746-600d-46f0-bf56-640890505db1	b9f23216-9065-44f4-856e-a254a57c20e0	data_quality	Ocean Expert data	active
db1eddf9-8c02-49ca-a8e0-bc5e353556ef	b9f23216-9065-44f4-856e-a254a57c20e0	sync_date	2025-09-22	active
2772c504-7276-4538-8fe5-9ff915e89e5b	5837bbb0-db1e-4388-a7b4-6ec8dde4be45	ocean_expert_id	20324	active
152c113f-c265-4920-a576-6c9285c315f8	5837bbb0-db1e-4388-a7b4-6ec8dde4be45	website	https://www.imas.utas.edu.au	active
7b8c22aa-20df-46d2-affb-497f8ec5e8d0	5837bbb0-db1e-4388-a7b4-6ec8dde4be45	email	IMAS.admin@utas.edu.au	active
e6a1684f-2587-4020-865a-ce1f33136cbf	5837bbb0-db1e-4388-a7b4-6ec8dde4be45	country	Australia	active
e4d0cf7b-0630-48ee-a2cb-6ac57c769b7d	5837bbb0-db1e-4388-a7b4-6ec8dde4be45	country_code	13	active
867b68f4-9d2e-416e-a170-05ee1fb85265	5837bbb0-db1e-4388-a7b4-6ec8dde4be45	acronym	IMAS	active
ee9c51a0-9beb-439c-a8b5-c82aded78e7b	5837bbb0-db1e-4388-a7b4-6ec8dde4be45	institution_type	Academic	active
2f0db540-e01b-4eb8-9001-ef20730ec9c6	5837bbb0-db1e-4388-a7b4-6ec8dde4be45	ocean_expert_updated	2020-04-20T00:00:00+02:00	active
5f716d53-01a9-4876-935b-d6517d262767	5837bbb0-db1e-4388-a7b4-6ec8dde4be45	data_source	obis_oceanexpert	active
43ee5f47-24da-45c4-965f-0a942db88574	5837bbb0-db1e-4388-a7b4-6ec8dde4be45	data_quality	Ocean Expert data	active
3fdc44db-dd29-4fea-929d-258398078a1f	5837bbb0-db1e-4388-a7b4-6ec8dde4be45	sync_date	2025-09-22	active
61090611-bee1-48b2-9a58-ef0b737c89f7	6d65e611-1921-4a04-b457-71e01531975c	ocean_expert_id	18439	active
4d375d26-b3f6-4ebc-8fa5-e84a62d914db	6d65e611-1921-4a04-b457-71e01531975c	website	https://en.unesco.org/	active
eb275b96-0b11-497f-b112-37de4c604afe	6d65e611-1921-4a04-b457-71e01531975c	phone	+33 (0) 145683952	active
64cccb5b-11ef-4079-91ad-bc28b12bbe7b	6d65e611-1921-4a04-b457-71e01531975c	country	France	active
d91d3da0-adfb-4324-a394-a15e8748df85	6d65e611-1921-4a04-b457-71e01531975c	country_code	74	active
1d4c60a3-c304-406e-bfef-0e9d2703cf54	6d65e611-1921-4a04-b457-71e01531975c	institution_type	International / Intergovernmental	active
73af69a6-208c-44d4-a481-48394934ceec	6d65e611-1921-4a04-b457-71e01531975c	ocean_expert_updated	2020-06-15T00:00:00+02:00	active
0dc09ef2-0ee6-478b-886d-5740b0ebc965	6d65e611-1921-4a04-b457-71e01531975c	data_source	obis_oceanexpert	active
dd4dea59-d2a3-4b12-844e-dc353ae3b130	6d65e611-1921-4a04-b457-71e01531975c	data_quality	Ocean Expert data	active
069bc13c-331d-4a13-add0-3e06acc2105c	6d65e611-1921-4a04-b457-71e01531975c	sync_date	2025-09-22	active
00d428f2-247e-44c7-9b96-d625aefd138d	95af0725-7f7b-4d25-9331-c16f872ad683	ocean_expert_id	15643	active
8c9c8a5f-597c-4d29-a012-8f8fbe18ef78	95af0725-7f7b-4d25-9331-c16f872ad683	website	http://www.cebc.cnrs.fr	active
115727f4-544a-4afa-b92a-814a5f3a9db3	95af0725-7f7b-4d25-9331-c16f872ad683	email	guinet@cebc.cnrs.fr	active
95697b22-6170-49ac-9440-06439d67438b	95af0725-7f7b-4d25-9331-c16f872ad683	phone	 +33 5 49 09 67 43	active
4bb5726d-f627-4caf-a49f-42f8752295af	95af0725-7f7b-4d25-9331-c16f872ad683	fax	+33 5 49 09 65 26	active
51f5113c-979f-491a-a4c6-61e7e3c5ddb2	95af0725-7f7b-4d25-9331-c16f872ad683	country	France	active
c2cd102d-7574-4197-a945-8cb6185ff14c	95af0725-7f7b-4d25-9331-c16f872ad683	country_code	74	active
78c45de0-25e2-4b4d-84b3-a8075a3699d5	95af0725-7f7b-4d25-9331-c16f872ad683	acronym	CEBC	active
eabf0dab-dc0d-466a-92bb-dd1e1321f0d7	95af0725-7f7b-4d25-9331-c16f872ad683	institution_type	Academic	active
45c42754-cb73-443d-94aa-513f10a927ae	95af0725-7f7b-4d25-9331-c16f872ad683	activities	<h2><small>Des recherches interdisciplinaires sur l'écologie et l'évolution des vertébrés dans des milieux naturels et modifiés</small></h2><p><small>Les programmes de recherche portent sur l'étude de l'effet des variations, dans le temps et dans l'espace, des ressources disponibles. Aux variations d'origine naturelle, s'ajoutent également les variations du fait des changements climatiques et des activités anthropiques (agriculture, pêche...), sur les populations et communautés de vertébrés. Ces perspectives de recherche s'inscrivent également dans un but de gestion durable des ressources naturelles et de conservation de la biodiversité.&nbsp;</small></p><p><small>&nbsp;</small></p><p><small>Les chercheurs étudient différentes espèces de mammifères, oiseaux et reptiles, soit localement sur 50&nbsp;000 ha de plaines céréalières, soit en élevage sur les 10 hectares de forêts dont dispose le Centre, soit sur des sites plus lointains comme l’Afrique, l’Arctique et l’Antarctique. Le Centre mène en effet des études sur les prédateurs marins supérieurs des Terres Australes et Antarctiques Françaises (TAAF).</small></p>	active
388d0068-1c86-4fcf-a862-8bbea9d0ae28	95af0725-7f7b-4d25-9331-c16f872ad683	ocean_expert_updated	2020-07-27T00:00:00+02:00	active
449c5163-6793-4107-b7c4-cbec19215d78	95af0725-7f7b-4d25-9331-c16f872ad683	data_source	obis_oceanexpert	active
f60d21d6-cdd7-465e-8463-b0a9a5062713	95af0725-7f7b-4d25-9331-c16f872ad683	data_quality	Ocean Expert data	active
e6b3953f-898f-4efa-8e85-852d409b1461	95af0725-7f7b-4d25-9331-c16f872ad683	sync_date	2025-09-22	active
d5743627-1280-4ff6-9ed9-d561babeb29e	3c50b952-0f6a-404e-9a0d-0d5003959792	ocean_expert_id	18300	active
a344eed8-eb72-4608-bd90-aca78ee61de4	e4179653-bf67-4863-885a-005fe38d63e1	ocean_expert_id	9202	active
83cc62fa-af04-4860-9cbb-de575bdda5d8	e4179653-bf67-4863-885a-005fe38d63e1	phone	1-785-864-3062\v	active
ba84224a-50b6-43ff-a89a-72d20b55b513	e4179653-bf67-4863-885a-005fe38d63e1	fax	1-785-864-5321	active
eb6794b5-a545-4c4d-995a-50a1e28380b8	e4179653-bf67-4863-885a-005fe38d63e1	country	United States of America	active
59acdb52-8e91-4fe9-8084-03807b2a42c8	e4179653-bf67-4863-885a-005fe38d63e1	country_code	223	active
4742ec94-7110-4114-af63-648745792bfe	e4179653-bf67-4863-885a-005fe38d63e1	activities	Evolution of Anthozoa, Sea anemones - especially their taxonomy, reproduction, and symbioses coral natural history, reproduction, taxonomy, and systematics of sea anemones; evolution of cnidarians; co	active
35ad7544-ff90-40fe-82e8-60bd9865832b	e4179653-bf67-4863-885a-005fe38d63e1	data_source	obis_oceanexpert	active
59af7b77-7621-4ed2-87de-6fd88f42d2a2	e4179653-bf67-4863-885a-005fe38d63e1	data_quality	Ocean Expert data	active
97a85275-f3c5-4183-9a1f-f8e43fb01597	e4179653-bf67-4863-885a-005fe38d63e1	sync_date	2025-09-22	active
a3fbe5c2-9e6e-4517-aac8-e4fe738fa9b9	d96a1343-305f-4dd8-9065-dce0e486cb0d	ocean_expert_id	13321	active
61cff1c9-357d-4039-b097-72fe97ae0ffe	cf982b50-f875-4821-9115-d3ab3cd534ae	website	http://www.ecosystems.uni-kiel.de/en/welcome-page	active
0e024977-0a1a-40af-9777-b6dfac276680	cf982b50-f875-4821-9115-d3ab3cd534ae	email	office@ecology.uni-kiel.de	active
65eed668-ce1a-4fd6-ba30-edf6cbeb40d7	cf982b50-f875-4821-9115-d3ab3cd534ae	country	Germany	active
a1a4ed23-b1db-4d9c-9df7-f1966d46cd9e	cf982b50-f875-4821-9115-d3ab3cd534ae	country_code	82	active
eb51f30a-0c5b-440a-93cf-662042841cd4	cf982b50-f875-4821-9115-d3ab3cd534ae	acronym	ÖSF	active
e38e3038-0a8d-40ac-a2c0-1b194805329c	cf982b50-f875-4821-9115-d3ab3cd534ae	institution_type	Academic	active
65093d6f-19bd-400d-b52e-225255548dc8	cf982b50-f875-4821-9115-d3ab3cd534ae	ocean_expert_updated	2018-08-17T00:00:00+02:00	active
1477b810-25fa-4b73-8e3f-a5caed90f855	cf982b50-f875-4821-9115-d3ab3cd534ae	data_quality	Ocean Expert data	active
86933762-14a8-4521-9e9a-e2cbd987792d	7b06fd53-2ccd-48a0-b9f7-d787524748d8	website	https://www.dakshin.org/	active
bae0ffde-4c4b-4b76-8df4-8272113062a5	7b06fd53-2ccd-48a0-b9f7-d787524748d8	country	India	active
1376376b-86b3-4e23-9e7b-e3996a513fd7	7b06fd53-2ccd-48a0-b9f7-d787524748d8	country_code	100	active
0984db2f-7be2-4556-87dd-e897a8c7020d	7b06fd53-2ccd-48a0-b9f7-d787524748d8	institution_type	NGO	active
03e1cc27-a167-4d40-9fb9-7a05af0da50a	7b06fd53-2ccd-48a0-b9f7-d787524748d8	activities	<ul><li>Community wellbeing and environment&nbsp;</li><li>Biodiversity and resource monitoring&nbsp;</li><li>Communities and resource governance&nbsp;</li><li>Environmental education</li></ul>	active
8fcf12d4-c4e7-4d65-aec4-8c10fa0aa8df	7b06fd53-2ccd-48a0-b9f7-d787524748d8	ocean_expert_updated	2020-12-28T00:00:00+01:00	active
7892401c-a31d-467b-92ee-626c52f6d4ec	7b06fd53-2ccd-48a0-b9f7-d787524748d8	data_quality	Ocean Expert data	active
5c74df47-76ff-445f-8f18-7f6798b367dd	ecc5ea65-f993-4aa6-8fa4-1ab289353b41	country	Italy	active
75e41d7f-229d-475f-b897-8b2d6c5a83d5	ecc5ea65-f993-4aa6-8fa4-1ab289353b41	country_code	106	active
c1e58d50-97fb-4a24-8f9b-6d79dd061776	ecc5ea65-f993-4aa6-8fa4-1ab289353b41	institution_type	NGO	active
979696a4-b869-4da1-958b-0b2342c60747	ecc5ea65-f993-4aa6-8fa4-1ab289353b41	ocean_expert_updated	2023-02-02T00:00:00+01:00	active
08a29dcd-bd33-44fa-9532-c805e7960423	ecc5ea65-f993-4aa6-8fa4-1ab289353b41	data_quality	Ocean Expert data	active
b34d3d53-2c44-4f91-9ebf-9683c29055ae	7436a13d-9f88-4db9-b5c7-e8606faeb723	website	http://www.si.edu/	active
a07e158e-724b-41a0-ac4d-02c73a1397d9	7436a13d-9f88-4db9-b5c7-e8606faeb723	country	United States of America	active
eddec3ed-4543-4b7e-b492-2bfd21765e08	7436a13d-9f88-4db9-b5c7-e8606faeb723	country_code	223	active
31c46af2-61b4-47c7-9b38-e733565d8313	7436a13d-9f88-4db9-b5c7-e8606faeb723	acronym	SI	active
2a1cae8c-974e-4697-9d94-c33465c86376	7436a13d-9f88-4db9-b5c7-e8606faeb723	institution_type	Government	active
7fce8af3-5f2c-4ad9-b426-b7004f83c361	7436a13d-9f88-4db9-b5c7-e8606faeb723	ocean_expert_updated	2019-07-17T00:00:00+02:00	active
88f6ef3b-c8d3-4242-b639-570d8fd4f853	7436a13d-9f88-4db9-b5c7-e8606faeb723	data_quality	Ocean Expert data	active
8f638440-6b4c-46a3-86d9-44db90f7087c	22c1fe0a-424a-4a44-8c63-d636552ba886	website	https://www.dal.ca/faculty/management/sres.html	active
78b221c7-2f29-447b-97f4-6929a95cd449	22c1fe0a-424a-4a44-8c63-d636552ba886	phone	(902) 494-3632	active
a343a086-21ef-48af-b652-05046fa578eb	22c1fe0a-424a-4a44-8c63-d636552ba886	country	Canada	active
b1792be4-3b69-4062-914c-058498b75131	22c1fe0a-424a-4a44-8c63-d636552ba886	country_code	39	active
74b50300-12b8-4c02-bdab-80b45a0f4d57	22c1fe0a-424a-4a44-8c63-d636552ba886	acronym	DAL SRES	active
df7e0082-5492-4a9a-993b-4a2e5cc33e23	22c1fe0a-424a-4a44-8c63-d636552ba886	institution_type	Academic	active
02f0267d-cc34-4029-8484-296d2c11b507	22c1fe0a-424a-4a44-8c63-d636552ba886	ocean_expert_updated	2018-08-09T00:00:00+02:00	active
a8729c9f-6dc1-420c-aa01-6af4440a8151	22c1fe0a-424a-4a44-8c63-d636552ba886	data_quality	Ocean Expert data	active
12d5e0d0-434b-4979-b9bc-62239b7170a7	8a0c78a0-6e1d-4a12-9bbc-710156efb635	website	https://www.oist.jp/	active
924f7297-1d62-4b50-8321-df106abed445	8a0c78a0-6e1d-4a12-9bbc-710156efb635	phone	+81 98-966-8711	active
b5af5ef9-1ae4-44f0-b359-262bffeaadc0	8a0c78a0-6e1d-4a12-9bbc-710156efb635	country	Japan	active
63b13eff-1e74-44d7-9c03-14dfa095c2a9	8a0c78a0-6e1d-4a12-9bbc-710156efb635	country_code	108	active
7319c171-ad90-48fd-b22f-0e02e2484dbd	8a0c78a0-6e1d-4a12-9bbc-710156efb635	acronym	OIST	active
c04838b7-623a-453c-8698-29dd76a0cd7f	8a0c78a0-6e1d-4a12-9bbc-710156efb635	institution_type	Academic	active
f6065402-e449-4120-984f-a8a6c01b23b4	8a0c78a0-6e1d-4a12-9bbc-710156efb635	ocean_expert_edmo_code	3734	active
f3c5f130-ec61-4e23-86c9-b99400e08f6e	8a0c78a0-6e1d-4a12-9bbc-710156efb635	ocean_expert_updated	2018-08-13T00:00:00+02:00	active
be2cf920-66d8-4265-b10b-577ccb8c931f	8a0c78a0-6e1d-4a12-9bbc-710156efb635	data_quality	Ocean Expert data	active
86daef4f-8765-4e9f-9811-3e8c8e4eb643	0752d200-4b76-48e7-bff3-76aa8e25a23a	website	http://www.samuseum.sa.gov.au/research/biological-sciences/marine-invertebrates	active
6689c6cd-149b-4cae-9673-6ff219f18e24	0752d200-4b76-48e7-bff3-76aa8e25a23a	country	Australia	active
49fd14ec-c889-441e-b6be-c36d0eb396af	0752d200-4b76-48e7-bff3-76aa8e25a23a	country_code	13	active
39a4b554-04cf-4a09-85be-848c900802e0	0752d200-4b76-48e7-bff3-76aa8e25a23a	institution_type	Government	active
39abe80c-5c5c-4761-8419-ed12536aee78	0752d200-4b76-48e7-bff3-76aa8e25a23a	ocean_expert_updated	2018-08-09T00:00:00+02:00	active
f8b77955-b22e-4260-a8cf-d7702950ace8	0752d200-4b76-48e7-bff3-76aa8e25a23a	data_quality	Ocean Expert data	active
cf289ba9-0e0c-4f37-9e46-6959576c418c	8e19eb22-322f-44ec-84e3-252063a113cf	country	Japan	active
573bc450-e6cd-4d9b-b8fe-d5c210c1394d	8e19eb22-322f-44ec-84e3-252063a113cf	country_code	108	active
269ea33f-7434-47c2-b0cc-985b009851ec	8e19eb22-322f-44ec-84e3-252063a113cf	acronym	DORD	active
1beafe0d-bd5d-4ecd-a75d-eb1f22795a26	8e19eb22-322f-44ec-84e3-252063a113cf	institution_type	Private commercial	active
18bad7ef-2b3f-4eb2-90f2-8d5aa74d4ab6	8e19eb22-322f-44ec-84e3-252063a113cf	ocean_expert_updated	2021-06-05T00:00:00+02:00	active
c1b93fbd-981a-4598-bd69-92e5b9cefbab	8e19eb22-322f-44ec-84e3-252063a113cf	data_quality	Ocean Expert data	active
94d05742-f627-4c56-ae10-5a951000cc7a	62488d62-4141-4611-a267-5eef4dfac40e	website	http://www.sdmri.org/	active
f7fff8da-7fc7-4474-ba51-ad17837686ec	62488d62-4141-4611-a267-5eef4dfac40e	email	sdmri1@sancharnet.in	active
18a6deea-f61b-44a9-befd-742d46b545b5	62488d62-4141-4611-a267-5eef4dfac40e	phone	+ 91 - 461 - 2336487 / 2336488 / 2323007	active
81f1bb60-81c3-4838-bb25-ae88c6adc24d	62488d62-4141-4611-a267-5eef4dfac40e	fax	+91 461 325692	active
1c87df43-118d-48aa-9e2e-ad91d2770632	62488d62-4141-4611-a267-5eef4dfac40e	country	India	active
e2c5c0f6-e7ab-4e72-956a-352586e89fdf	62488d62-4141-4611-a267-5eef4dfac40e	country_code	100	active
c2cb1a56-22c8-4c93-9c35-dd6724bf59aa	62488d62-4141-4611-a267-5eef4dfac40e	acronym	SDMRI	active
c2e592bd-3068-49b6-913c-905c9851bc3f	62488d62-4141-4611-a267-5eef4dfac40e	institution_type	Research	active
36e4eb92-3573-49e3-8035-0c8cc27775a9	62488d62-4141-4611-a267-5eef4dfac40e	activities	\t\r\nSuganthi Devadason Marine Research Institute (SDMRI) is a non-governmental and non-profit Marine Research and Higher Education organization. The founders of SDMRI are well known personalities in the society. The Founder President of SDMRI, Mr. D.G. Rajan is an industrialist, administrator and social worker with various capacities in the society. SDMRI was established in 1998 under the Suganthi Devadason Trust (Reg. No. 290/1997) at Tuticorin, Tamil Nadu, India with the aim  \t\r\n• to meet out the research needs of marine and coastal   ecosystems in India;\r\n• to uplift the socio-economic conditions of coastal folk; and\r\n• to promote higher education for capacity building.	active
955183f9-c6c3-47a7-8969-0ad13d545294	62488d62-4141-4611-a267-5eef4dfac40e	ocean_expert_updated	2010-12-15T00:00:00+01:00	active
fa1755aa-91f9-422f-8fa5-72ef00ccf73f	62488d62-4141-4611-a267-5eef4dfac40e	data_quality	Ocean Expert data	active
5a1833df-010c-4707-9478-0431c8f6e09a	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	website	http://inos.umt.edu.my	active
685e80f5-70c8-4ea1-9fe1-50cf04831def	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	email	inos@umt.edu.my	active
b9095524-40ac-4d53-990b-886d8b245454	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	phone	+609-6683145/3195	active
758dc4e4-8932-459c-8b51-312545c5ce43	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	fax	+609-6692166	active
d00d9981-52d5-440f-b333-ccb96057e0b2	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	country	Malaysia	active
0a0abfad-ecc9-4621-91a7-dfee778fc5db	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	country_code	130	active
93a2b2af-abef-420a-b123-35639d1dca4e	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	acronym	INOS	active
4811a122-eaed-422b-afba-ddb86368bde8	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	institution_type	Research	active
391e9ca0-a007-4395-9c86-e6b96501ee43	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	activities	The Institute of Oceanography (INOS) is a premier center of excellence in Malaysia that focuses its activities on oceanic and marine related research and post-graduate training.\r\n\r\nINOS has a long and strong tradition in marine science and oceanographic research. The Institute of Oceanography and Environment (INOS), a research institute located under the banner of Universiti Malaysia Terengganu was awarded the Higher Institutions Centre of Excellence (HICoE). \r\n\r\nRecommended by the Intergovernmental Oceanographic Commission of UNESCO, the institute is accorded official status as a center of excellence by the Malaysian Government in April 2001.\r\n\r\nINOS aims to be a leading regional center of research, post-graduate studies as well as the reference center for marine and its related environment with special emphasis on the South China Sea and its related ecosystems.<br>||ADU|| ||Accredited ADU|| ||OTGA RTC||<br>	active
ecd46ee0-ae09-4f6f-bcb0-406506a61906	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	ocean_expert_updated	2025-05-09T00:00:00+02:00	active
8019ed3c-e1b6-41df-8bc2-bf4d5d86bda0	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	data_quality	Ocean Expert data	active
127c3f88-4f23-4606-a62d-fede31708f95	800cf29d-6348-4644-8584-20f8eeb2f68c	ocean_expert_id	8907	active
4dd51df8-b971-44dc-8e45-3b776f008fa0	800cf29d-6348-4644-8584-20f8eeb2f68c	data_quality	OBIS data only	active
4141dbf9-b07c-4b90-8d8c-c2e37b33eec9	edc723c1-5850-4b0d-8336-441378903b91	website	https://acer.acadiau.ca/contact-ua.html	active
c66c704c-b26b-48e1-97f9-c94597e70320	edc723c1-5850-4b0d-8336-441378903b91	email	leanna.mcdonald@acadiau.ca	active
e903e9f1-212f-4f46-999b-b4b6033e4494	edc723c1-5850-4b0d-8336-441378903b91	phone	1-902-585-1113	active
f3c533e3-897c-4832-a13b-c761e1c5fc8b	edc723c1-5850-4b0d-8336-441378903b91	country	Canada	active
d617182f-6420-47a0-a4e7-b8cee3e0bf9a	edc723c1-5850-4b0d-8336-441378903b91	country_code	39	active
70dae27d-094a-416c-8180-c90651b52536	edc723c1-5850-4b0d-8336-441378903b91	acronym	ACER	active
ecb0c860-5cc2-4383-8bc7-e7ccad578335	edc723c1-5850-4b0d-8336-441378903b91	institution_type	Academic	active
dac9e7b1-4378-4552-82ec-3512d38d6891	edc723c1-5850-4b0d-8336-441378903b91	ocean_expert_edmo_code	4561	active
0d131221-2055-4b66-b868-3983dfe0b770	edc723c1-5850-4b0d-8336-441378903b91	ocean_expert_updated	2018-06-28T00:00:00+02:00	active
dd363542-ffff-4d74-905c-711e04d8f887	edc723c1-5850-4b0d-8336-441378903b91	data_quality	Ocean Expert data	active
0713b8bc-732b-468a-b41e-35ca65de1bd9	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	website	http://fl.biology.usgs.gov/	active
fee68dc5-68de-4618-be2a-b9ca2c06bc15	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	phone	352-378-8181	active
481903d5-b712-4002-b92d-087e60442974	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	fax	352-378-4956 	active
d2b55615-b4fe-4b99-96da-fdd90f76bb46	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	country	United States of America	active
a50d6b01-dbe6-4c06-8eb0-6313995c197d	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	country_code	223	active
1119f682-6b25-4501-85c7-8413a8d84f6b	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	acronym	USGS	active
f3992668-2c6b-465c-81bf-e8065b82962d	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	institution_type	Government	active
3dbc7dd9-9f4c-48be-b55c-7d512b4f324b	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	activities	General biology, systematics, ecology, natural history, physiology, and zoogeography of freshwater and inshore marine fishes.	active
f37d578f-7e3c-4288-b699-4cd759d89a3f	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	ocean_expert_updated	2018-08-06T00:00:00+02:00	active
6536167b-327a-4c47-9df9-8794515c45f8	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	data_quality	Ocean Expert data	active
d9e37f46-6471-40d5-82a5-934fd9cc9ff3	6ea78550-2cc0-465c-8624-3d18d8923e71	website	https://www.psu.edu/	active
b71eb338-f358-46da-8ec4-58908d038b95	6ea78550-2cc0-465c-8624-3d18d8923e71	country	United States of America	active
4ce86053-305b-4732-9526-9141be2d2573	6ea78550-2cc0-465c-8624-3d18d8923e71	country_code	223	active
765cf4ef-004b-4992-9a85-cfb9f6b338ac	6ea78550-2cc0-465c-8624-3d18d8923e71	acronym	PennState	active
d6917959-61ab-460c-9e6f-03c31555e377	6ea78550-2cc0-465c-8624-3d18d8923e71	institution_type	Academic	active
305c6bf0-3d79-4874-a026-dafba1ee6692	6ea78550-2cc0-465c-8624-3d18d8923e71	ocean_expert_edmo_code	3605	active
7618b0ce-2c1f-4394-a0a3-5d8d6dabb139	6ea78550-2cc0-465c-8624-3d18d8923e71	ocean_expert_updated	2018-08-10T00:00:00+02:00	active
8fff2169-ee2b-4955-a3dc-6ed4da73a416	6ea78550-2cc0-465c-8624-3d18d8923e71	data_quality	Ocean Expert data	active
28136062-6bdd-4d30-9a3c-c2ca25ba0402	713c12dd-e249-43b2-ae63-8a1778bde3d6	website	https://www.ces.edu.co/	active
9a87b80d-1b3c-4a8f-a1a5-3c6aac7f5168	713c12dd-e249-43b2-ae63-8a1778bde3d6	email	lquan@ces.edu.co	active
a26c916b-cbb8-4481-a0c7-ea66ac208593	713c12dd-e249-43b2-ae63-8a1778bde3d6	phone	57(4) 4440555- ext. 1762	active
23deffbd-89aa-4a8d-9151-4cf1b801a110	713c12dd-e249-43b2-ae63-8a1778bde3d6	country	Colombia	active
c18622f9-25cb-4f4a-99ec-7843b8e8c73d	713c12dd-e249-43b2-ae63-8a1778bde3d6	country_code	48	active
36e4e69f-1b7f-45c1-8ffd-e462872e91de	713c12dd-e249-43b2-ae63-8a1778bde3d6	acronym	Universidad CES	active
d9c07825-fb93-4148-84b2-40f1e7d4b13c	713c12dd-e249-43b2-ae63-8a1778bde3d6	institution_type	Academic	active
e5e4279d-92f9-4b9d-9ff5-c239565ca350	713c12dd-e249-43b2-ae63-8a1778bde3d6	activities	Teacher/research about coastal marine ecosystems, specially about biodiversity and ecological interactions	active
8687fa83-5005-4d2b-841c-915ac77f6588	713c12dd-e249-43b2-ae63-8a1778bde3d6	ocean_expert_updated	2020-04-07T00:00:00+02:00	active
b3f18c16-6394-453f-8a7a-24911722f5e6	713c12dd-e249-43b2-ae63-8a1778bde3d6	data_quality	Ocean Expert data	active
970a6d74-8bb5-431d-bb9f-841a07feb827	6807177e-d90f-455c-b50c-09a815a9b0fb	website	http://invertebrates.uni.lodz.pl/en/	active
6bb48568-cf48-4f6e-9356-7263a097cb18	6807177e-d90f-455c-b50c-09a815a9b0fb	email	mariab@biol.uni.lodz.pl	active
fc18cb4d-e15d-43e9-9814-8abdcc1dbd9a	6807177e-d90f-455c-b50c-09a815a9b0fb	phone	+42 635-44-40	active
1afdfb39-5a7d-42d5-8ebb-eb55cb44bf61	6807177e-d90f-455c-b50c-09a815a9b0fb	country	Poland	active
f4fb39e8-21f9-4bbf-a614-3feff592e273	6807177e-d90f-455c-b50c-09a815a9b0fb	country_code	172	active
33d6f98f-c8df-4166-b8ca-77887ea8fdf3	6807177e-d90f-455c-b50c-09a815a9b0fb	institution_type	Academic	active
3734948e-7267-4786-a214-2cc4f2fd18ea	6807177e-d90f-455c-b50c-09a815a9b0fb	ocean_expert_updated	2018-08-06T00:00:00+02:00	active
2f15b60c-503e-4c36-88ad-66ad0f20cf7d	6807177e-d90f-455c-b50c-09a815a9b0fb	data_quality	Ocean Expert data	active
c2360485-94ab-4478-8927-b9b0e92b0ee0	64b55e5c-b41c-4b45-8286-fc183fc1e22b	website	http://izan.kiev.ua/eng/index.htm	active
0077bf89-6f71-4852-9233-307dad1c415f	64b55e5c-b41c-4b45-8286-fc183fc1e22b	email	iz@izan.kiev.ua	active
6cb416b3-8ac4-482c-8cb4-a55d6d5fbca2	64b55e5c-b41c-4b45-8286-fc183fc1e22b	phone	(38 044) 235-10-70	active
bb547a9b-2d3c-4ae5-a9fd-0c636472d3ef	64b55e5c-b41c-4b45-8286-fc183fc1e22b	fax	(38 044) 234-15-69	active
f19f8efb-a7ad-4cfd-94b3-3eb414806579	64b55e5c-b41c-4b45-8286-fc183fc1e22b	country	Ukraine	active
23b1f2fd-633c-4b44-8ba2-a5465c56cc90	64b55e5c-b41c-4b45-8286-fc183fc1e22b	country_code	220	active
22ac2e66-028a-4159-821f-22ccf0f7cdec	64b55e5c-b41c-4b45-8286-fc183fc1e22b	institution_type	Research	active
9094825c-a5ed-49ff-8fbd-28100022875a	64b55e5c-b41c-4b45-8286-fc183fc1e22b	ocean_expert_updated	2018-08-08T00:00:00+02:00	active
8c2eb14f-e018-420a-a887-2e492697d5b3	64b55e5c-b41c-4b45-8286-fc183fc1e22b	data_quality	Ocean Expert data	active
2840a50e-b226-4b57-9f80-7a9301e513b5	a075242f-cc8f-4715-aeee-67effbd099b0	website	www.noaa.gov	active
830bb7f7-3ce2-48ea-bb95-d95c7f0c9e38	a075242f-cc8f-4715-aeee-67effbd099b0	country	United States of America	active
bab29025-872b-48b0-bd56-d8633f77e8d7	a075242f-cc8f-4715-aeee-67effbd099b0	country_code	223	active
7e32a57e-599e-4741-afcd-f9d86c0b322c	a075242f-cc8f-4715-aeee-67effbd099b0	acronym	NOAA/NMFS	active
e7a438fb-6eec-4be9-a566-c8c7bff8cb94	a075242f-cc8f-4715-aeee-67effbd099b0	institution_type	Government	active
a2eaf181-d72f-438a-be6f-2ba4bcee52c2	a075242f-cc8f-4715-aeee-67effbd099b0	ocean_expert_updated	2011-09-14T00:00:00+02:00	active
7ebf7682-7f6a-4c91-a466-77ada2336606	a075242f-cc8f-4715-aeee-67effbd099b0	data_quality	Ocean Expert data	active
08e99c30-b674-4fce-9bea-fe041698ede3	984d9654-fed4-4692-9292-f9e4eb115a3f	website	https://www.aegean.gr/index.html	active
940befde-78d4-4f1f-8203-7ace986c129f	984d9654-fed4-4692-9292-f9e4eb115a3f	email	secr@env.aegean.gr	active
ef92821a-e317-4afd-94a4-88905f6f513a	984d9654-fed4-4692-9292-f9e4eb115a3f	country	Greece	active
b6299cb3-e76a-40f4-9a93-e747de824b42	984d9654-fed4-4692-9292-f9e4eb115a3f	country_code	85	active
2c35293c-657a-4df0-a4bc-9163097c83fe	984d9654-fed4-4692-9292-f9e4eb115a3f	institution_type	Academic	active
5c940a20-a496-4d2a-9ff6-dfbe80b6a59c	984d9654-fed4-4692-9292-f9e4eb115a3f	activities	Marine Euthrophication, Phytoplankton Ecology, Coastal Water, Quality, Ecotoxicology	active
fed34f36-6d37-413e-96ea-a1e882e97522	984d9654-fed4-4692-9292-f9e4eb115a3f	ocean_expert_updated	2022-03-08T00:00:00+01:00	active
0c60d18f-4c72-4190-adb8-9769631c28f5	984d9654-fed4-4692-9292-f9e4eb115a3f	data_quality	Ocean Expert data	active
da645146-2c94-4ca7-83ce-14b286f85dd9	1b0cfdcd-04f2-4e67-a455-594cdf99925d	website	http://iamc.objectis.net/	active
79e9fd8a-afa0-41f0-bc2b-c930ae051bfd	1b0cfdcd-04f2-4e67-a455-594cdf99925d	email	g.fenzi@iamc.cnr.it	active
16229c08-0944-4822-8bcb-d9a24a255bb3	1b0cfdcd-04f2-4e67-a455-594cdf99925d	phone	+39 0783 229015 	active
d4e96c5b-0cde-4ff7-8fa4-a27b049bf31a	1b0cfdcd-04f2-4e67-a455-594cdf99925d	fax	+39 0783 229135	active
8d9480e6-c162-465e-8a2e-e330294ea5ce	1b0cfdcd-04f2-4e67-a455-594cdf99925d	country	Italy	active
56fb48d6-b2be-49e6-b201-498a3cfa853e	1b0cfdcd-04f2-4e67-a455-594cdf99925d	country_code	106	active
73a05eb1-cbfa-4cbb-813d-d8703ed09996	1b0cfdcd-04f2-4e67-a455-594cdf99925d	acronym	IAMC-CNR	active
0177fb1f-ab88-4099-9a96-55921dcfd82d	1b0cfdcd-04f2-4e67-a455-594cdf99925d	institution_type	Government	active
b9cc652e-37a4-4db6-87d8-230fc9d89946	1b0cfdcd-04f2-4e67-a455-594cdf99925d	ocean_expert_edmo_code	155	active
8ff010c7-1bca-4e74-bedc-30bbc49ef9d8	1b0cfdcd-04f2-4e67-a455-594cdf99925d	ocean_expert_updated	2018-08-16T00:00:00+02:00	active
a98e5809-152b-4d63-8900-e886ee53a2f0	1b0cfdcd-04f2-4e67-a455-594cdf99925d	data_quality	Ocean Expert data	active
04e5a192-2cc4-486e-a49c-7488dc3f7d0b	531735c5-33bc-4a17-9905-5cbb84d92027	data_quality	OBIS data only	active
13a456d2-4cf0-4061-b298-beb917490508	4cb9a9b0-e4f6-4b64-a1ae-cb455ee7a8fb	website	https://www.universia.net/uy/universidades/universidad-zulia.01043.html	active
5019d32e-afa0-4f48-a1de-7c08646e69cf	4cb9a9b0-e4f6-4b64-a1ae-cb455ee7a8fb	country	Venezuela (Bolivarian Republic of)	active
2116f2b4-dc87-4091-8e6c-13427e854d55	4cb9a9b0-e4f6-4b64-a1ae-cb455ee7a8fb	country_code	229	active
bd0e3fad-4eb3-4bcc-892d-4b441b64f68f	4cb9a9b0-e4f6-4b64-a1ae-cb455ee7a8fb	acronym	LUZ	active
b85a72cc-3039-4209-a5c4-5906b7179462	4cb9a9b0-e4f6-4b64-a1ae-cb455ee7a8fb	institution_type	Academic	active
88f862e5-627c-4bf8-af76-389cd76be338	4cb9a9b0-e4f6-4b64-a1ae-cb455ee7a8fb	ocean_expert_updated	2021-10-08T00:00:00+02:00	active
33b962d1-883c-411b-a66f-a332067cd7bd	4cb9a9b0-e4f6-4b64-a1ae-cb455ee7a8fb	data_quality	Ocean Expert data	active
57c5405c-48f0-45aa-905b-9e5df42a6dad	21d6bbfc-e133-4a04-9e16-5e37479de70b	website	https://naturalhistory.novascotia.ca/	active
77ba12c3-9b17-47c6-bed6-997fb1dbeb64	21d6bbfc-e133-4a04-9e16-5e37479de70b	phone	+1 902-424-7353	active
1dfcf8fa-f5e6-4caf-adbe-82310767981c	21d6bbfc-e133-4a04-9e16-5e37479de70b	country	Canada	active
b87f287b-b113-4f27-a55d-c775da24e64e	21d6bbfc-e133-4a04-9e16-5e37479de70b	country_code	39	active
688aa329-cb1f-4d77-bfab-c1262746a30d	21d6bbfc-e133-4a04-9e16-5e37479de70b	institution_type	Government	active
aebc7cde-0506-4a2b-b186-cf016616a8d2	21d6bbfc-e133-4a04-9e16-5e37479de70b	ocean_expert_updated	2018-08-13T00:00:00+02:00	active
09253aaf-fdad-40ec-a7ef-7bf28f88f42c	21d6bbfc-e133-4a04-9e16-5e37479de70b	data_quality	Ocean Expert data	active
e2e51b49-a745-425e-8d45-e01823339fd4	efb64a40-7d6e-484b-86de-63401ccc13ca	website	http://wer.uqar.qc.ca/ismer	active
1838fda1-90eb-4b30-8732-23d2a1864934	efb64a40-7d6e-484b-86de-63401ccc13ca	phone	+1 418 724-1650	active
b8cc5e31-f9f2-424c-8fa9-be589f513189	efb64a40-7d6e-484b-86de-63401ccc13ca	fax	+1 418 724-1842	active
0d4f43f0-6659-4379-9d18-f95b8d18306b	efb64a40-7d6e-484b-86de-63401ccc13ca	country	Canada	active
66211f20-7296-48fa-ae68-d91e14fe63d9	efb64a40-7d6e-484b-86de-63401ccc13ca	country_code	39	active
57601031-f600-4620-a2ed-efaa915c22b3	efb64a40-7d6e-484b-86de-63401ccc13ca	acronym	ISMER	active
ff201103-6e80-4459-9186-8a996f412964	efb64a40-7d6e-484b-86de-63401ccc13ca	institution_type	Academic	active
df8f0129-ce24-456b-ada2-11bc7ea0d6e2	efb64a40-7d6e-484b-86de-63401ccc13ca	activities	The Institute is a research catalyst in the marine sciences field in Rimouski. Its contribution to the advancement of marine sciences is crucial.	active
736914cb-9322-4fb9-9437-9ad1d6915d9b	efb64a40-7d6e-484b-86de-63401ccc13ca	ocean_expert_updated	2009-09-18T00:00:00+02:00	active
27a6e1f8-3148-4c5b-9892-d51aecea5dd4	efb64a40-7d6e-484b-86de-63401ccc13ca	data_quality	Ocean Expert data	active
e7c7bad1-c833-4e6e-b9cb-91db17d18f81	4778b9bb-91a2-47ce-99d3-fa0265cb20ac	website	http://www.ecocentro.org.ar/	active
6ff8f483-5211-454b-8472-43b831c5160a	4778b9bb-91a2-47ce-99d3-fa0265cb20ac	email	mar@ecocentro.org.ar	active
10af81cc-aa0f-45a6-9dcf-b620a241e6f4	4778b9bb-91a2-47ce-99d3-fa0265cb20ac	phone	54 280 488-3173	active
b0a7c568-b2af-487f-93e3-4c586fe62ab8	4778b9bb-91a2-47ce-99d3-fa0265cb20ac	country	Argentina	active
7dab16d1-6379-40c2-a86c-92a272aad659	4778b9bb-91a2-47ce-99d3-fa0265cb20ac	country_code	10	active
105ff26b-8853-4606-a259-b04124e1d184	4778b9bb-91a2-47ce-99d3-fa0265cb20ac	institution_type	Private non-profit	active
b6bef826-b521-4d89-8592-bec7eababec1	4778b9bb-91a2-47ce-99d3-fa0265cb20ac	ocean_expert_updated	2018-08-17T00:00:00+02:00	active
fd487592-165e-42a2-89db-557369f60a72	4778b9bb-91a2-47ce-99d3-fa0265cb20ac	data_quality	Ocean Expert data	active
d167ef5b-e553-4cb0-aebf-7d531ce7f589	1242c07b-ffab-4f55-b8ab-94bc4970f5d2	website	https://meeuwig.org/	active
7d07ea14-7608-4ebb-b274-f6efe332ab1a	1242c07b-ffab-4f55-b8ab-94bc4970f5d2	email	cmarinefutures@gmail.com	active
f9316966-b431-4c9c-8760-35569e3d662f	1242c07b-ffab-4f55-b8ab-94bc4970f5d2	country	Australia	active
964423b0-a360-4d7e-972d-1fde2b8b2b3f	1242c07b-ffab-4f55-b8ab-94bc4970f5d2	country_code	13	active
dafe5be5-7a18-4b07-9a07-92038f1c5ac3	1242c07b-ffab-4f55-b8ab-94bc4970f5d2	institution_type	Research	active
4bfcac6f-f403-480f-84af-f8670c77eabf	1242c07b-ffab-4f55-b8ab-94bc4970f5d2	ocean_expert_updated	2020-07-27T00:00:00+02:00	active
50edfe3f-44c7-423f-a0a6-da2fe0bb0f73	1242c07b-ffab-4f55-b8ab-94bc4970f5d2	data_quality	Ocean Expert data	active
2388a2f9-2427-450a-900d-6d225a53e327	c32577e8-2f21-4c34-a4ce-1641adacffd5	website	https://www.chiba-muse.or.jp/NATURAL/english/introduction-e.htm	active
905b0fef-0237-4055-838c-d9d13cad8df8	c32577e8-2f21-4c34-a4ce-1641adacffd5	country	Japan	active
8f958438-df6b-4b9f-ac5f-bb6a8b0770d9	c32577e8-2f21-4c34-a4ce-1641adacffd5	country_code	108	active
25aa644e-2aa7-4451-9ef1-90c5007ff61f	c32577e8-2f21-4c34-a4ce-1641adacffd5	institution_type	Government	active
a06612c2-76b6-4041-b4e2-c4d10eb994f2	c32577e8-2f21-4c34-a4ce-1641adacffd5	ocean_expert_updated	2018-08-01T00:00:00+02:00	active
40aeab85-2a66-433e-850b-2f7bb7c1362b	c32577e8-2f21-4c34-a4ce-1641adacffd5	data_quality	Ocean Expert data	active
e613271a-9f78-4ec1-be6b-7a279df43506	0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	website	https://azuraco.com/	active
fbf8bb7c-b186-456c-9f7d-f100ed454b9b	0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	email	info@azuraco.com	active
9b74c174-efa5-4cac-9f7c-2fa3124130ee	0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	phone	+1 9729051416	active
53f0bb40-2229-4232-b2f9-f1232c3ca696	0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	country	United States of America	active
b3385c40-d657-4fee-8943-c84a05b3f976	0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	country_code	223	active
af47b59d-6a21-42ba-97cb-0e29c8eca4dd	0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	institution_type	Private commercial	active
5c0ddebd-6e52-4071-9952-fbd180fee082	0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	activities	Azura offers a variety of environmental consulting services focused on the research, conservation and management of protected species and habitats.	active
e1c21d8e-2770-4812-9fd0-4389fd1ea2f6	0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	ocean_expert_updated	2020-07-17T00:00:00+02:00	active
4422ef1e-8ced-4cf7-a48c-ceaac2a2c9ce	0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	data_quality	Ocean Expert data	active
0c4db586-c9fc-43e2-9ee0-4bc925f786c6	91f28432-5f2f-4f95-8bb7-9005e785b327	website	http://uees.me	active
72081085-a9ab-49be-ae3e-8461adb1a9ee	91f28432-5f2f-4f95-8bb7-9005e785b327	phone	+593 4283 56 30	active
ef729ccf-4945-4e34-977a-0bc70fe21025	91f28432-5f2f-4f95-8bb7-9005e785b327	country	Ecuador	active
dff72cd1-ffaa-49f6-b7d9-674694650419	91f28432-5f2f-4f95-8bb7-9005e785b327	country_code	63	active
891cd4f7-0138-4e6e-8f3b-d16ac8619015	91f28432-5f2f-4f95-8bb7-9005e785b327	acronym	UEES	active
cc3174cf-af41-429e-8899-f5789a363eda	91f28432-5f2f-4f95-8bb7-9005e785b327	institution_type	Academic	active
c5571178-e6cb-4a0d-a82f-4d3fec76cb05	91f28432-5f2f-4f95-8bb7-9005e785b327	activities	<p><b>Misión</b><br>Servir a la sociedad mediante la generación de entornos de aprendizaje para la formación integral de personas que, a través de la docencia, investigación&nbsp;y&nbsp;vinculación, contribuyan al desarrollo del país.</p><p><br><b>Visión</b><br>La UEES se visualiza como un centro de docencia, investigación&nbsp;y&nbsp;orientación que aporta alternativas para el desarrollo del país.</p>	active
30c877b6-13a0-42f7-a54a-ce1aaa9737b1	91f28432-5f2f-4f95-8bb7-9005e785b327	ocean_expert_updated	2018-01-26T00:00:00+01:00	active
e06aa4db-97b1-482b-943e-44d6be807435	91f28432-5f2f-4f95-8bb7-9005e785b327	data_quality	Ocean Expert data	active
453fdadf-5e40-4732-bc91-a981f2b05ccb	eef94ec3-bca8-4b26-b6f3-9324d7f9799c	website	https://www.dal.ca/faculty/science/biology.html	active
e1583fd7-d22d-4913-b1b8-7fe24d3412e9	eef94ec3-bca8-4b26-b6f3-9324d7f9799c	country	Canada	active
d616d05d-3fb1-4458-9bbc-5c3c8c24ebd1	eef94ec3-bca8-4b26-b6f3-9324d7f9799c	country_code	39	active
d2345a08-ad8e-4df8-b20c-875926f5574e	eef94ec3-bca8-4b26-b6f3-9324d7f9799c	institution_type	Academic	active
1b5a2666-108a-417c-8eb1-974009572ea5	eef94ec3-bca8-4b26-b6f3-9324d7f9799c	ocean_expert_edmo_code	4657	active
35a7fc2b-68d2-49a6-abf6-33ab5aa5a464	eef94ec3-bca8-4b26-b6f3-9324d7f9799c	ocean_expert_updated	2018-08-09T00:00:00+02:00	active
d3e52156-0c3f-40f0-b58c-f3d82740be40	eef94ec3-bca8-4b26-b6f3-9324d7f9799c	data_quality	Ocean Expert data	active
2124f0c4-df23-4277-9443-f9de5b9f5b72	db358bae-c6bd-4a7f-8726-4b217cf389f5	website	https://www.aquariumdeparis.com/	active
43eb15b7-a90e-43b4-89ed-493e73f7f536	db358bae-c6bd-4a7f-8726-4b217cf389f5	email	info@cineaqua.com	active
7bc62535-c70d-4dd4-8d5f-1a54090dd8e6	db358bae-c6bd-4a7f-8726-4b217cf389f5	country	France	active
153310ee-3363-4cc4-ab42-1e5019c7d54c	db358bae-c6bd-4a7f-8726-4b217cf389f5	country_code	74	active
76543585-fb28-440c-821f-a1183e781d0e	db358bae-c6bd-4a7f-8726-4b217cf389f5	institution_type	Private commercial	active
4b5ac4cb-ad57-4683-a6e4-be50da0d3887	db358bae-c6bd-4a7f-8726-4b217cf389f5	ocean_expert_updated	2020-06-19T00:00:00+02:00	active
23be9898-6a6a-4029-b88f-3956a76b9836	db358bae-c6bd-4a7f-8726-4b217cf389f5	data_quality	Ocean Expert data	active
d4aa7ac8-bfed-4055-afa5-29d760e232da	d76ba351-d472-460f-8569-4a832ef633ac	website	https://geo-tagdernatur.de/	active
b5f084c5-204e-4922-9495-6352bb4e37d7	d76ba351-d472-460f-8569-4a832ef633ac	email	info@geo-tagdernatur.de	active
369a191e-8dd1-4ecc-ab79-0f525da42d34	d76ba351-d472-460f-8569-4a832ef633ac	phone	040 22 866 275	active
7e223047-50db-4865-9046-4e66d038063d	d76ba351-d472-460f-8569-4a832ef633ac	country	Germany	active
cc96e146-e4ba-4ce4-b165-db4f007bbf37	d76ba351-d472-460f-8569-4a832ef633ac	country_code	82	active
8584d6a1-7020-4978-8a24-7d8e009e151e	d76ba351-d472-460f-8569-4a832ef633ac	institution_type	Private non-profit	active
0e2459fc-020e-4a25-91e0-1b59e5fff6ed	d76ba351-d472-460f-8569-4a832ef633ac	activities	<span>seit 2017 heisst der GEO-Tag der Artenvielfalt GEO-Tag der Natur.</span>	active
e032c9b2-5d0d-4c0a-9ebf-52b1d86767a5	d76ba351-d472-460f-8569-4a832ef633ac	ocean_expert_updated	2018-08-17T00:00:00+02:00	active
d6cfb040-5807-4aa0-856c-bb13c5f418d0	d76ba351-d472-460f-8569-4a832ef633ac	data_quality	Ocean Expert data	active
647d7136-1e68-4d81-a2b3-02e0210b6f4f	b7f123f8-c806-4e09-9a6b-590332c6b8aa	phone	++39 10 3538136	active
30a0ad15-a0b8-4cce-9485-17cc026cd386	b7f123f8-c806-4e09-9a6b-590332c6b8aa	country	Italy	active
063146c1-4988-42d5-87e3-a0b5db20de9e	b7f123f8-c806-4e09-9a6b-590332c6b8aa	country_code	106	active
8718fa1a-c1c5-4a03-ad8e-f4baae11a11e	b7f123f8-c806-4e09-9a6b-590332c6b8aa	acronym	DIPTERIS	active
d147480d-94c3-46b4-9973-7f1adc6fc687	b7f123f8-c806-4e09-9a6b-590332c6b8aa	institution_type	Academic	active
defb2e6c-b527-4b6a-96d7-8f27365e79fc	b7f123f8-c806-4e09-9a6b-590332c6b8aa	ocean_expert_updated	2018-08-08T00:00:00+02:00	active
f90f993f-8c74-4942-b352-4c82475cb47f	b7f123f8-c806-4e09-9a6b-590332c6b8aa	data_quality	Ocean Expert data	active
21c69380-4770-400c-b76b-159e6c586897	c88cb4db-68fe-44f4-8057-37900c9bd8fd	website	http://www.wcs.org/	active
2dd0f7dd-4f5b-4684-babc-d3b63fe2be2b	c88cb4db-68fe-44f4-8057-37900c9bd8fd	phone	(718) 220-5100	active
256aba7d-0204-432a-89c4-a00537f56dad	c88cb4db-68fe-44f4-8057-37900c9bd8fd	fax	(718) 265 3420\v	active
2c417f6e-159e-400b-9e40-53c76db65654	c88cb4db-68fe-44f4-8057-37900c9bd8fd	country	United States of America	active
da0d661c-b62c-4965-a07d-413703f4e88c	c88cb4db-68fe-44f4-8057-37900c9bd8fd	country_code	223	active
a0dc1e50-70ff-4577-81e5-91d05bb0f77c	c88cb4db-68fe-44f4-8057-37900c9bd8fd	acronym	WCS	active
8cc96db8-5cee-4877-b5f7-ecaccb18f181	c88cb4db-68fe-44f4-8057-37900c9bd8fd	institution_type	NGO	active
8fdaca4f-b12e-475e-b441-14e4bac5a79a	c88cb4db-68fe-44f4-8057-37900c9bd8fd	activities	The Wildlife Conservation Society saves wildlife and wild places worldwide. We do so through science, global conservation, education and the management of the world's largest system of urban wildlife parks, led by the flagship Bronx Zoo. Together these activities change attitudes towards nature and help people imagine wildlife and humans living in harmony. WCS is committed to this mission because it is essential to the integrity of life on Earth. 	active
84657f7e-c2be-4bf5-b188-190e0e013aa6	c88cb4db-68fe-44f4-8057-37900c9bd8fd	ocean_expert_updated	2010-05-28T00:00:00+02:00	active
6a18ab53-758a-4200-bacc-2caca5aced24	c88cb4db-68fe-44f4-8057-37900c9bd8fd	data_quality	Ocean Expert data	active
1fd6f80b-d70e-404b-8a1a-f5cd09172f17	8f98c818-40b2-42db-9121-4cc68b3bf2a8	website	https://www.unical.edu.ng/	active
b068c8d2-399a-4a6f-bc32-48b64e88f601	8f98c818-40b2-42db-9121-4cc68b3bf2a8	email	enquiries@unical.edu.ng	active
54c6bec0-51bf-436b-94d3-0b46f938a97f	8f98c818-40b2-42db-9121-4cc68b3bf2a8	phone	+2348036554789	active
8bed80ea-922b-4b07-a808-e38c824a1615	8f98c818-40b2-42db-9121-4cc68b3bf2a8	country	Nigeria	active
7107fead-42b7-4acb-a9dc-900ec007eda0	8f98c818-40b2-42db-9121-4cc68b3bf2a8	country_code	157	active
0dadc743-2c6d-4e21-8c25-0d19b534b7e2	8f98c818-40b2-42db-9121-4cc68b3bf2a8	acronym	UNICAL	active
a30a9e2b-2d30-4a18-a9bf-d333024a26c2	8f98c818-40b2-42db-9121-4cc68b3bf2a8	institution_type	Academic	active
da311cee-cdab-42de-93da-ea1d76ac1320	8f98c818-40b2-42db-9121-4cc68b3bf2a8	ocean_expert_updated	2021-06-18T00:00:00+02:00	active
ca866dc3-b7c6-4337-bea3-3acf841d1e2b	8f98c818-40b2-42db-9121-4cc68b3bf2a8	data_quality	Ocean Expert data	active
82de0797-c73e-4b09-bb3f-12269a68a08a	bb75c8dd-1dea-41b4-bc1d-725b29129e62	website	http://su.se/deep/english/	active
99416117-d570-4829-9643-8887643ec62c	bb75c8dd-1dea-41b4-bc1d-725b29129e62	email	ove.eriksson@su.se	active
218d2878-869e-4dfb-93d4-5d7010b4a240	bb75c8dd-1dea-41b4-bc1d-725b29129e62	phone	+46 816 1204	active
aa2346ee-1ec0-4912-87c2-86439331efb5	bb75c8dd-1dea-41b4-bc1d-725b29129e62	fax	+46 815 84 17	active
c6fc3a5d-6678-4eb2-aab5-07bc17a14d36	bb75c8dd-1dea-41b4-bc1d-725b29129e62	country	Sweden	active
2f7e1067-c367-453b-bb7d-1b96865af340	bb75c8dd-1dea-41b4-bc1d-725b29129e62	country_code	204	active
27a8e5db-0e12-4f63-9885-455ed58cf68a	bb75c8dd-1dea-41b4-bc1d-725b29129e62	institution_type	Academic	active
a648a94a-1ea4-4050-8d95-362e74a19a37	bb75c8dd-1dea-41b4-bc1d-725b29129e62	ocean_expert_edmo_code	623	active
3d9c0082-bfaf-477c-af78-32b1bb4ceb80	bb75c8dd-1dea-41b4-bc1d-725b29129e62	activities	Research and teaching in the Department of Systems Ecology at Stockholm University focuses on the study of ecosystems and on sustainable use of natural resources	active
6f00ec9c-e77c-480f-b92c-4a648cf34236	bb75c8dd-1dea-41b4-bc1d-725b29129e62	ocean_expert_updated	2022-12-08T00:00:00+01:00	active
0d64f341-0033-47ff-af63-2ef41bd40fd0	bb75c8dd-1dea-41b4-bc1d-725b29129e62	data_quality	Ocean Expert data	active
2641dcfe-dcdd-41d2-abe9-5cf73da4b193	59a0abde-da3b-44f6-8c10-3314dbd3e158	website	http://www.ecosur.mx/	active
84b329b0-5952-4b94-a16c-9ff464e3096f	59a0abde-da3b-44f6-8c10-3314dbd3e158	country	Mexico	active
34dddee2-8fec-4ce6-8e22-75b2b0aab188	59a0abde-da3b-44f6-8c10-3314dbd3e158	country_code	139	active
4ccd88c8-f27f-4e5d-9468-1b948d67b1f9	59a0abde-da3b-44f6-8c10-3314dbd3e158	acronym	ECOSUR	active
67a7772b-7128-4bd6-9f1a-6af0c54ee82c	59a0abde-da3b-44f6-8c10-3314dbd3e158	institution_type	Research	active
85f3f910-782f-4f33-a617-40b5c3766a59	59a0abde-da3b-44f6-8c10-3314dbd3e158	ocean_expert_updated	2017-02-02T00:00:00+01:00	active
cee0ec54-86c2-44fc-8561-01843db4617f	59a0abde-da3b-44f6-8c10-3314dbd3e158	data_quality	Ocean Expert data	active
332df420-6aa0-4828-96de-ff1497f19e0c	bdc0848a-c777-49c3-ae3e-d2428c4465a6	website	http://uay.unam.mx	active
eee8263d-eb29-4c72-8f20-7a3928a62ed5	bdc0848a-c777-49c3-ae3e-d2428c4465a6	email	karmen.galindo@ciencias.unam.mx	active
aaafa9d4-8c30-4062-9bf2-a7f3ec129487	bdc0848a-c777-49c3-ae3e-d2428c4465a6	phone	+52 5556233600	active
a0d391a1-6b38-454e-979e-b60a09c76e7e	bdc0848a-c777-49c3-ae3e-d2428c4465a6	fax	+52 5556162894	active
46f24b82-5cd8-4d47-b450-4c660fe894a4	bdc0848a-c777-49c3-ae3e-d2428c4465a6	country	Mexico	active
8c2fc55d-28fc-45ea-9742-100e13c27eeb	bdc0848a-c777-49c3-ae3e-d2428c4465a6	country_code	139	active
586072be-1998-46f2-afc3-35db833cd976	bdc0848a-c777-49c3-ae3e-d2428c4465a6	region	34	active
dcd9196f-780e-4381-9d7d-18c280d6dd83	bdc0848a-c777-49c3-ae3e-d2428c4465a6	acronym	UNAM UMDI Sisal	active
e05f191e-e64e-44cf-ae41-202c4927b8d3	bdc0848a-c777-49c3-ae3e-d2428c4465a6	institution_type	Academic	active
65e74b2f-5b63-4e49-9afe-b65fa89fc7f0	bdc0848a-c777-49c3-ae3e-d2428c4465a6	activities	<div><div></div></div> <div><div>Research on biodiversity of different taxonomic groups</div></div><br>	active
29a6460c-885b-44d8-89eb-79e3a80530c7	bdc0848a-c777-49c3-ae3e-d2428c4465a6	ocean_expert_updated	2018-08-17T00:00:00+02:00	active
056562d0-f908-4bbd-8321-d12ec22af25f	bdc0848a-c777-49c3-ae3e-d2428c4465a6	data_quality	Ocean Expert data	active
e1759258-ac5f-4187-a2af-619409fddc90	e6d5c49e-e7c6-4f94-b0b7-8ef444eaeb9c	country	Japan	active
dff7a6f9-a4cb-4539-a6e1-38dbeb5b801f	e6d5c49e-e7c6-4f94-b0b7-8ef444eaeb9c	country_code	108	active
9a9f9cc2-3648-48cf-a11e-b6dfd897d02e	e6d5c49e-e7c6-4f94-b0b7-8ef444eaeb9c	acronym	JOGMEC	active
3e21e7e9-6947-44bf-8891-6c4918fa232c	e6d5c49e-e7c6-4f94-b0b7-8ef444eaeb9c	institution_type	Government	active
f149b91e-17ac-4d45-b1bb-de8c2342fb4d	e6d5c49e-e7c6-4f94-b0b7-8ef444eaeb9c	ocean_expert_updated	2021-06-05T00:00:00+02:00	active
084a76e8-e405-40b8-801b-6eee72563313	e6d5c49e-e7c6-4f94-b0b7-8ef444eaeb9c	data_quality	Ocean Expert data	active
d78a1d7a-6acd-454a-9791-daaa26b8062a	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	website	http://www.cicimar.ipn.mx/oacis/	active
bafdf7c1-2fbc-4dd4-a36f-c256e3e7d498	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	email	robertico@icimar.cu	active
c1c7dc65-5d53-476f-86e3-e9b6ca7f4201	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	phone	(52+612)1234658, 1234734 y 1234666	active
42330357-b1bb-47c9-81bd-03b1ff9af3c0	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	fax	(52+612) 122-53-22 	active
301f6a2e-72fa-4c56-9bd9-5962245e4084	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	country	Mexico	active
6027ed07-f496-4674-a48f-65527b4f9b9a	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	country_code	139	active
d98ec095-17f2-4956-951b-5a3a425c02b5	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	acronym	CICIMAR-IPN	active
491b262f-ee93-4756-829a-efc5a08cdaf1	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	institution_type	Research	active
b5d118b5-0d88-4a46-9acf-394b7b48af0a	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	activities	Proporcionar servicios educativos de posgrado, desarrollar investigación científica y tecnológica tanto básica como aplicada, tendiente a la conservación y aprovechamiento de los recursos marinos para coadyuvar al desarrollo integral de México, así como contribuir a la difusión de la cultura científica y tecnológica dentro de la comunidad politécnica y de la sociedad en general. Para ello cuenta con una estructura y planta académica de excelencia en diversas disciplinas de las Ciencias Marinas y Pesqueras, con una infraestructura adecuada y con los servicios de apoyo requeridos para el cumplimiento de esta misión.	active
b2269061-b572-44fa-8253-9dc7178183b2	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	ocean_expert_updated	2019-09-09T00:00:00+02:00	active
814d6232-b4ea-4e16-a5f2-2ff634c2793c	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	data_quality	Ocean Expert data	active
574672bc-060b-4840-b26f-e6f8dcc3fc89	131aead9-4b5f-42c8-b1be-4efb65f27f85	website	https://www.asrcenergy.com	active
c9848aeb-c8bf-48ed-b314-ec4a5bde1c5d	131aead9-4b5f-42c8-b1be-4efb65f27f85	email	info@asrcenergy.com	active
abf83ca3-307f-4375-9408-fa5e965ceace	131aead9-4b5f-42c8-b1be-4efb65f27f85	phone	+1 (907) 339-6200	active
600de972-61e4-499c-9351-ac45c031b2b1	131aead9-4b5f-42c8-b1be-4efb65f27f85	country	United States of America	active
97f95607-e238-4b2f-9815-06c68c1906d9	131aead9-4b5f-42c8-b1be-4efb65f27f85	country_code	223	active
b0d5e97b-fc9f-41c4-b745-e67f9c514640	131aead9-4b5f-42c8-b1be-4efb65f27f85	acronym	AES	active
6df30711-621a-446f-bef0-268472d03b34	131aead9-4b5f-42c8-b1be-4efb65f27f85	institution_type	Private commercial	active
e4e10167-2466-4d36-a486-e4fea6b20c5d	131aead9-4b5f-42c8-b1be-4efb65f27f85	activities	<p><span>ASRC Energy Services (AES) is a subsidiary of&nbsp;<a target="_blank" rel="nofollow" href="http://www.asrc.com/">Arctic Slope Regional Corporation</a>&nbsp;(ASRC), the largest locally-owned and operated business in Alaska for more than three decades.</span></p><p><span>With more than 30 years of experience working in the world’s most challenging environments, AES has earned its reputation as the service provider of choice to the energy industry.</span></p>	active
ec6f5d84-b673-46cf-bf4e-8793618297f4	131aead9-4b5f-42c8-b1be-4efb65f27f85	ocean_expert_updated	2020-06-24T00:00:00+02:00	active
d373bb2c-8a1e-41c6-8278-4f1fda5880e6	131aead9-4b5f-42c8-b1be-4efb65f27f85	data_quality	Ocean Expert data	active
cd4b1fd4-51b2-4649-b6dd-f9b4f0526f45	6656a424-96b6-48ce-a7ed-ac2c25236f3e	website	http://cpps-int.org	active
96505880-578c-4ed7-a935-70c0ae478ba7	6656a424-96b6-48ce-a7ed-ac2c25236f3e	email	sgeneral@cpps-int.org	active
af2451f4-c511-4244-8884-1c9935811a5a	6656a424-96b6-48ce-a7ed-ac2c25236f3e	phone	+593 4 3714390	active
cb2fdf66-3ad1-46e3-a74f-7a2590b36515	6656a424-96b6-48ce-a7ed-ac2c25236f3e	fax	+593 4 222 1201	active
068f7c49-cfc0-431f-b3e9-f4ce87f64817	6656a424-96b6-48ce-a7ed-ac2c25236f3e	country	Ecuador	active
e770d964-dd13-4727-929d-6d23f026c713	6656a424-96b6-48ce-a7ed-ac2c25236f3e	country_code	63	active
96dfe981-967d-4965-9dca-44ff77a9c591	6656a424-96b6-48ce-a7ed-ac2c25236f3e	acronym	CPPS	active
799531a5-349a-4e6e-9167-413f2810b2bf	6656a424-96b6-48ce-a7ed-ac2c25236f3e	institution_type	International / Intergovernmental	active
7eeb018f-c5f3-45e3-93cf-ab4938d68454	6656a424-96b6-48ce-a7ed-ac2c25236f3e	activities	The Permanent Commission for the South Pacific (CPPS) is the appropriate Regional Maritime Organization responsible for the coordination of the maritime policies of its Member States: COLOMBIA, CHILE, ECUADOR and PERU. The Organization was established on 18 August 1952, as a result of "Declaration on the Maritime Zone" subscribed at Santiago by the Governments of Chile, Ecuador and Peru. Colombia joined the CPPS on 9 August, 1979.<br>||ADU||<br>	active
6038c49e-8534-4172-90ba-2bc23e06c39d	6656a424-96b6-48ce-a7ed-ac2c25236f3e	ocean_expert_updated	2020-03-20T00:00:00+01:00	active
dbfd27e7-249e-4352-8539-a2144d3485a3	6656a424-96b6-48ce-a7ed-ac2c25236f3e	data_quality	Ocean Expert data	active
e8fe8af2-a3c8-4397-b21c-6c18b6d82bf0	80e4933e-9e6d-4b53-afa6-65891c39b594	website	https://www.tepapa.govt.nz	active
558bfb4c-51a6-4676-963e-04e6740cf91b	80e4933e-9e6d-4b53-afa6-65891c39b594	phone	+64 (04) 381 7000	active
27434137-cdca-4029-876c-da745b2e55ec	80e4933e-9e6d-4b53-afa6-65891c39b594	country	New Zealand	active
9edbff94-c010-4568-930a-cb962efc17ca	80e4933e-9e6d-4b53-afa6-65891c39b594	country_code	154	active
90280f17-0d38-440d-8d2e-37a5b4b2961c	80e4933e-9e6d-4b53-afa6-65891c39b594	institution_type	Government	active
080ba840-403e-4810-8c86-bd84661ae51e	80e4933e-9e6d-4b53-afa6-65891c39b594	ocean_expert_updated	2018-08-09T00:00:00+02:00	active
435266bb-87cd-42bb-a2c6-f7d793bc8713	80e4933e-9e6d-4b53-afa6-65891c39b594	data_quality	Ocean Expert data	active
7910ecd6-73de-4533-afcd-6f385fbb8537	a389d6aa-e9ba-4af1-a86e-6ec8dca6fbf4	website	https://www.osnz.org.nz/	active
71b553d7-0e15-4d29-b1ab-59de822f7e15	a389d6aa-e9ba-4af1-a86e-6ec8dca6fbf4	country	New Zealand	active
b2afeb58-f64b-482e-8c2f-a74e8b16acc9	a389d6aa-e9ba-4af1-a86e-6ec8dca6fbf4	country_code	154	active
5ad7c457-c1f3-403f-9cdb-d8dfc7f6667d	a389d6aa-e9ba-4af1-a86e-6ec8dca6fbf4	acronym	Birds NZ	active
6df3a5ab-773f-4f5b-9a29-1d3821513547	a389d6aa-e9ba-4af1-a86e-6ec8dca6fbf4	institution_type	Private non-profit	active
22327143-74d0-4f4e-9d85-178aa67856a6	a389d6aa-e9ba-4af1-a86e-6ec8dca6fbf4	ocean_expert_updated	2018-08-08T00:00:00+02:00	active
70ff5cf1-a4a2-4016-b2ef-9a6d841e9731	a389d6aa-e9ba-4af1-a86e-6ec8dca6fbf4	data_quality	Ocean Expert data	active
19e85ab9-8be3-4809-9abd-b77e410630cd	dafcfb4f-d7b8-45d3-9b61-e872659c975e	website	http://www.uaco.unpa.edu.ar/	active
0c592f53-7714-41ad-93a1-07628df17265	dafcfb4f-d7b8-45d3-9b61-e872659c975e	country	Argentina	active
dc539bbe-5cee-4105-8744-cd4951a57950	dafcfb4f-d7b8-45d3-9b61-e872659c975e	country_code	10	active
82ec94ed-42c0-4c8d-9704-fc5ea9e3cefb	dafcfb4f-d7b8-45d3-9b61-e872659c975e	acronym	UNPA - UACO	active
ad92334e-4eb9-43c8-8665-6bf25970fe2e	dafcfb4f-d7b8-45d3-9b61-e872659c975e	institution_type	Academic	active
93fb35fa-99a4-4920-987c-936d45a47b78	dafcfb4f-d7b8-45d3-9b61-e872659c975e	ocean_expert_updated	2018-09-10T00:00:00+02:00	active
950e6444-b0c2-477a-b065-f5f190e733f9	dafcfb4f-d7b8-45d3-9b61-e872659c975e	data_quality	Ocean Expert data	active
5182bb79-739a-4cb7-98c0-413acbbaef5b	ef5b612a-a6b9-48a5-8571-236f3dbea130	website	http://www.patagonianatural.org	active
13627b57-3f92-4110-a599-ac241b7064de	ef5b612a-a6b9-48a5-8571-236f3dbea130	email	pnatural@patagonianatural.org	active
4338de7e-c283-4fa5-ad91-28f4fac0e8a6	ef5b612a-a6b9-48a5-8571-236f3dbea130	phone	+ 54 (0280) 4474363	active
415487cd-4ae7-47b1-9ca1-68fab23cc7c8	ef5b612a-a6b9-48a5-8571-236f3dbea130	country	Argentina	active
10069455-eea1-4a1a-96d6-6e397ac205f5	ef5b612a-a6b9-48a5-8571-236f3dbea130	country_code	10	active
5ea40690-ee6e-48fb-878f-b961d464e97b	ef5b612a-a6b9-48a5-8571-236f3dbea130	acronym	FPN	active
94db86a4-d4fb-43dd-af04-4683baac74bd	ef5b612a-a6b9-48a5-8571-236f3dbea130	institution_type	NGO	active
259ed6ff-7a1d-4850-a128-b647d501438e	ef5b612a-a6b9-48a5-8571-236f3dbea130	ocean_expert_updated	2018-08-17T00:00:00+02:00	active
768d7aec-f988-40ed-8748-b7afb28ed573	ef5b612a-a6b9-48a5-8571-236f3dbea130	data_quality	Ocean Expert data	active
2791ce7e-75a2-4fce-8197-18e5bb660774	bf21ee67-a54a-4795-a97e-c308d18eb12e	website	http://alaska.usgs.gov/	active
a9ed9e38-2ce3-4df2-8ed3-17e22dbae0fe	bf21ee67-a54a-4795-a97e-c308d18eb12e	phone	(907) 786-7000	active
f2857538-9f04-489f-b842-0c103936fe12	bf21ee67-a54a-4795-a97e-c308d18eb12e	fax	(907) 786-7020	active
907065a2-2e0f-41c9-9c35-289f89d01cd7	bf21ee67-a54a-4795-a97e-c308d18eb12e	country	United States of America	active
025f8155-e80b-4b7e-b39e-e527d5338981	bf21ee67-a54a-4795-a97e-c308d18eb12e	country_code	223	active
c92d42a5-2b77-4b87-abe7-b9a40e50963a	bf21ee67-a54a-4795-a97e-c308d18eb12e	institution_type	Government	active
ad364e48-fb9d-4ca4-8ce8-1924b8d2daa9	bf21ee67-a54a-4795-a97e-c308d18eb12e	ocean_expert_updated	2018-08-06T00:00:00+02:00	active
def02f11-2cf5-4b8e-84a2-29543bef17ff	bf21ee67-a54a-4795-a97e-c308d18eb12e	data_quality	Ocean Expert data	active
76d5bb90-56bc-4c4a-b60b-98d062101411	c177523f-2836-40b9-8f30-84692218550a	website	http://bluewhalestudy.org/	active
c3ad24dc-b7df-43f5-b9da-21898d2a091b	c177523f-2836-40b9-8f30-84692218550a	email	enquiries@bluewhalestudy.org	active
f55d6ef8-2af2-4a7c-bdbe-f551fc85e3a1	c177523f-2836-40b9-8f30-84692218550a	phone	+613 5529 5207	active
9cf6a557-febe-4647-a421-a4772ba37dd6	c177523f-2836-40b9-8f30-84692218550a	country	Australia	active
c4af9ac3-9b22-4d7f-9f98-8ec2ca961da4	c177523f-2836-40b9-8f30-84692218550a	country_code	13	active
95a12f33-f465-4201-b9de-393002d77593	c177523f-2836-40b9-8f30-84692218550a	acronym	BWS	active
043c687f-3ea7-449c-a99a-073d210b4819	c177523f-2836-40b9-8f30-84692218550a	institution_type	Research	active
5f16036c-65b6-496e-8e47-832fc455552e	c177523f-2836-40b9-8f30-84692218550a	activities	<p>BWS has conducted ecological research on blue whales and their upwelling habitats in southern Australia.&nbsp; We work in cooperation with local, state and federal governments, NGOs, universities, industry and other research institutions to pursue good conservation outcomes for blue whales.</p><p>Our current studies focus on photo-identification of blue whales, and on the distribution and ecology of the species throughout their upwelling habitat.</p>	active
9bd3cae2-dbc8-45d2-803a-255d75821ff2	c177523f-2836-40b9-8f30-84692218550a	ocean_expert_updated	2020-07-20T00:00:00+02:00	active
793d196d-0f94-4265-9cc2-50f70ee7c514	c177523f-2836-40b9-8f30-84692218550a	data_quality	Ocean Expert data	active
e4a9e84f-4d38-4e34-9c1a-4018c5f6095d	59e8c52c-1e3d-49c2-9070-83cacf6a95c9	website	https://www.inbo.be/	active
de68dc21-05bb-492a-be43-d39a097c6d6d	59e8c52c-1e3d-49c2-9070-83cacf6a95c9	phone	02 430 26 37	active
f76b5b7b-7542-4cd4-9dec-a7199d03f454	59e8c52c-1e3d-49c2-9070-83cacf6a95c9	country	Belgium	active
7692006f-a8b6-4375-be06-871c5f33c319	59e8c52c-1e3d-49c2-9070-83cacf6a95c9	country_code	21	active
0bc2b291-1fe4-42f7-bd8e-98ea721eb0f7	59e8c52c-1e3d-49c2-9070-83cacf6a95c9	institution_type	Government	active
699963d3-e2de-4440-97c5-02ca64fe87fe	59e8c52c-1e3d-49c2-9070-83cacf6a95c9	ocean_expert_updated	2018-09-10T00:00:00+02:00	active
e1ac3354-74de-450d-813c-64433673a226	59e8c52c-1e3d-49c2-9070-83cacf6a95c9	data_quality	Ocean Expert data	active
f5f436c7-6784-4555-aec5-b9c8ebaa980c	ed7bd8d8-ceb7-45b5-8cab-c28ea30fd2bb	website	https://en.uit.no/tmu	active
279034d3-5b56-4e83-931d-bb8df5e08fd6	ed7bd8d8-ceb7-45b5-8cab-c28ea30fd2bb	country	Norway	active
64a21d10-2c04-41b8-b39a-3a525e93b92c	ed7bd8d8-ceb7-45b5-8cab-c28ea30fd2bb	country_code	161	active
afabc11f-a234-4b7f-a291-0ddd6db9c4b8	ed7bd8d8-ceb7-45b5-8cab-c28ea30fd2bb	institution_type	Academic	active
9c6c2bf6-68ee-4106-b0f2-d86c5716fd1d	ed7bd8d8-ceb7-45b5-8cab-c28ea30fd2bb	ocean_expert_updated	2023-02-03T00:00:00+01:00	active
128daf5d-9467-4d11-b644-176ba5f519cb	ed7bd8d8-ceb7-45b5-8cab-c28ea30fd2bb	data_quality	Ocean Expert data	active
4c809b6e-6358-4bc9-b616-814a1636d21d	bc60400e-420e-4599-98d6-18b90fe187f9	website	http://www.ma.ieo.es/	active
65a6ed9a-d5bf-4c0c-bd1f-56d26b5560a7	bc60400e-420e-4599-98d6-18b90fe187f9	phone	+34 952 197 124	active
3349667a-cb48-4787-b3b1-f2cda3c6b422	bc60400e-420e-4599-98d6-18b90fe187f9	fax	+34 952 463 808 	active
d2388cf9-844b-4e05-9e1e-774bed16e112	bc60400e-420e-4599-98d6-18b90fe187f9	country	Spain	active
6f6c49c0-30c7-40c1-9e89-0a6b562050f3	bc60400e-420e-4599-98d6-18b90fe187f9	country_code	196	active
81f429d9-8504-49b4-b91f-34ef365b18d2	bc60400e-420e-4599-98d6-18b90fe187f9	acronym	IEO	active
e98ef10f-2204-4215-8cde-fe836de2b789	bc60400e-420e-4599-98d6-18b90fe187f9	institution_type	Government	active
85637981-6470-48ba-8a3d-112ceca78adc	bc60400e-420e-4599-98d6-18b90fe187f9	activities	El Centro Oceanográfico de Málaga, es uno de los 9 Centros Costeros que el Instituto Español de Oceanografía (IEO) tiene repartidos por el litoral peninsular e insular español. Además el IEO cuenta con una Sede central en Madrid, cinco plantas experimentales de acuicultura, doce estaciones mareográficas, una estación receptora de imágenes satélite y una flota de seis barcos oceanográficos de diverso tonelaje.	active
9fe94791-43da-46d6-ae53-7be40891b2e5	bc60400e-420e-4599-98d6-18b90fe187f9	ocean_expert_updated	2018-08-13T00:00:00+02:00	active
6bd72e54-cdcd-42f1-b6f1-9f2f82acbab8	bc60400e-420e-4599-98d6-18b90fe187f9	data_quality	Ocean Expert data	active
9046766d-b560-4de2-b909-c97b319a8b33	c22f3f61-efb4-43c2-8b85-eff313c57d92	website	http://www.peartas.gov.gr/	active
bdf14c65-f1ee-4c6b-8bb0-e97a6b410836	c22f3f61-efb4-43c2-8b85-eff313c57d92	email	daok@peartas.gov.gr	active
96bb72b4-ee66-435a-8a18-53784db4e479	c22f3f61-efb4-43c2-8b85-eff313c57d92	phone	2681364461	active
cd4752bb-b827-4523-8a8d-f85ae9f92f1a	c22f3f61-efb4-43c2-8b85-eff313c57d92	country	Greece	active
64f53bfe-db6e-42ad-ab8f-024e0a83ad81	c22f3f61-efb4-43c2-8b85-eff313c57d92	country_code	85	active
16491c24-685a-4ac9-8a57-18d483b6eadc	c22f3f61-efb4-43c2-8b85-eff313c57d92	institution_type	Government	active
e928fe4f-9070-4a38-bc39-d773d584c204	c22f3f61-efb4-43c2-8b85-eff313c57d92	ocean_expert_updated	2018-06-29T00:00:00+02:00	active
366c02ad-3cc7-40dc-b498-35ade5b4b0f4	c22f3f61-efb4-43c2-8b85-eff313c57d92	data_quality	Ocean Expert data	active
1228c2ec-4f8d-4368-b9aa-8f53e6ffd005	e97f5314-0d0e-4acd-8135-2b38cab75330	website	https://www.hartpury.ac.uk/	active
3bed0ef5-7cce-4c5b-b97d-1402e8e2bdf1	e97f5314-0d0e-4acd-8135-2b38cab75330	country	United Kingdom of Great Britain and Northern Ireland	active
b0d1583a-e9fe-4c1a-9782-93bfc1099421	e97f5314-0d0e-4acd-8135-2b38cab75330	country_code	222	active
6ffeb770-b22d-4424-9446-c0875af0c176	e97f5314-0d0e-4acd-8135-2b38cab75330	institution_type	Academic	active
9a148c0d-9896-4b59-87eb-b4e3d0fbd93a	e97f5314-0d0e-4acd-8135-2b38cab75330	ocean_expert_updated	2018-08-10T00:00:00+02:00	active
a1cf742a-a93a-443a-a85c-5e07ef6b79ff	e97f5314-0d0e-4acd-8135-2b38cab75330	data_quality	Ocean Expert data	active
c7a1ba63-b87e-4338-aceb-c5bcc082f172	39ca8137-231e-497d-ae22-de66bc25d7a9	website	http://biology.acadiau.ca/	active
9c3cec67-ff5c-4a07-baea-12cb03dd4a50	39ca8137-231e-497d-ae22-de66bc25d7a9	email	biology@acadiau.ca	active
945202a4-4d4d-48e6-a29b-abd7e44406c3	39ca8137-231e-497d-ae22-de66bc25d7a9	phone	(902) 585-1334	active
7d0c6f79-f38f-46b9-a31f-61dc3ab0c08c	39ca8137-231e-497d-ae22-de66bc25d7a9	fax	(902) 585-1059	active
e1fe9946-628d-4c1f-af6f-bc135076379d	39ca8137-231e-497d-ae22-de66bc25d7a9	country	Canada	active
972cbeb9-6ba7-412e-aa04-9696f1daee1b	39ca8137-231e-497d-ae22-de66bc25d7a9	country_code	39	active
31cdf352-fd61-46e1-959d-9f9926122d4b	39ca8137-231e-497d-ae22-de66bc25d7a9	institution_type	Academic	active
b699d093-1ada-41aa-a8f2-8a3a0aebe5e2	39ca8137-231e-497d-ae22-de66bc25d7a9	ocean_expert_edmo_code	4562	active
87ac2ff0-4cd2-4fec-9321-068a681414ca	39ca8137-231e-497d-ae22-de66bc25d7a9	ocean_expert_updated	2018-08-01T00:00:00+02:00	active
00bfa47c-e149-4fa8-8752-6a5ab05557e5	39ca8137-231e-497d-ae22-de66bc25d7a9	data_quality	Ocean Expert data	active
511b3b6a-4cd4-4e8b-a5f6-0a1c5938213a	350c9b99-8b67-4836-8aa0-3ff8e1046072	website	https://www.aucklandcouncil.govt.nz/	active
eeed3bfa-e35c-4ef3-924c-e18c243f333f	350c9b99-8b67-4836-8aa0-3ff8e1046072	phone	+64 9 301 0101	active
8db8eb04-ed18-4a6a-92b3-38a7aeba6ac7	350c9b99-8b67-4836-8aa0-3ff8e1046072	country	New Zealand	active
8bf65ee6-2ce6-4bc4-81e7-83af3966e5d7	350c9b99-8b67-4836-8aa0-3ff8e1046072	country_code	154	active
2c0d992e-4036-4697-9159-67ac92fe24f5	350c9b99-8b67-4836-8aa0-3ff8e1046072	institution_type	Government	active
561fe6a1-cd7a-4b04-9f1a-975caae16e96	350c9b99-8b67-4836-8aa0-3ff8e1046072	ocean_expert_updated	2020-06-25T00:00:00+02:00	active
6239f0d0-cb15-42d4-a325-d76979ff348d	350c9b99-8b67-4836-8aa0-3ff8e1046072	data_quality	Ocean Expert data	active
4c9f365f-eedb-4939-a8b6-969fc9cd5e67	8d184328-c515-47b9-968c-105c21b20eea	website	https://www.icrwhale.org/eng-index.html	active
5a3cfce1-8394-45cb-8c1d-d48c657400a8	8d184328-c515-47b9-968c-105c21b20eea	country	Japan	active
4dca0236-46bc-454b-9a02-86da3d013cb4	8d184328-c515-47b9-968c-105c21b20eea	country_code	108	active
43ffab2f-4c64-4c12-9b3d-aef4fd7206e3	8d184328-c515-47b9-968c-105c21b20eea	acronym	ICR	active
de2effe8-e237-4282-9b1f-b7ee2de52382	8d184328-c515-47b9-968c-105c21b20eea	institution_type	Research	active
4fffc73a-2ee9-43b3-ac20-6de903f8bfe7	8d184328-c515-47b9-968c-105c21b20eea	activities	Through whale research and sighting surveys we are collecting valuable biological data for whale resource assessment. We also study DNA of cetaceans netted as by-catch during fishing, and conduct research on cetacean and other marine mammal strandings.	active
8e64c89e-459d-4609-9167-b80e46851c97	8d184328-c515-47b9-968c-105c21b20eea	ocean_expert_updated	2020-07-30T00:00:00+02:00	active
d4d7569f-8ff1-464f-bead-e2e5b47f906a	8d184328-c515-47b9-968c-105c21b20eea	data_quality	Ocean Expert data	active
405ed723-b2e2-452c-9e24-fa5a62ef777c	8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	website	http://www.cadic-conicet.gob.ar	active
0c4a0037-94f9-4d32-9051-f816c50f12e4	8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	phone	+54 2901 422 310	active
0fa12fd0-8392-4c6e-b239-37822d4aeb98	8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	fax	+54 2901 430 644	active
13aeb767-1587-48d7-a1ba-a416a3a4a543	8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	country	Argentina	active
81a62d5e-c1b4-4b93-a996-7787c7db0418	8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	country_code	10	active
e2bf71a5-aada-4d2a-b275-ab8ac1defc33	8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	acronym	CADIC	active
da2174ca-d909-497a-832f-8fac178651a4	8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	institution_type	Government	active
8cdbc141-4307-4244-943f-ad07eb92797f	8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	ocean_expert_updated	2018-01-04T00:00:00+01:00	active
ac1dd5ce-f151-409e-a59d-1cfda5ee6fd0	8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	data_quality	Ocean Expert data	active
9e751dfa-1036-4b3c-b04e-c7eadca380e5	3aef56bf-23cb-4135-ac0d-224a1d8545e5	website	http://www.gnm.se/	active
5772ee49-8938-4af5-9b29-057be5f054f0	3aef56bf-23cb-4135-ac0d-224a1d8545e5	country	Sweden	active
1d6fcbf8-ceaf-4d47-9eec-ec11916593d2	3aef56bf-23cb-4135-ac0d-224a1d8545e5	country_code	204	active
74e7c195-1126-47f0-ac04-0f8069c7e05d	3aef56bf-23cb-4135-ac0d-224a1d8545e5	institution_type	Private non-profit	active
bd98d2ed-6066-4ad0-af21-afc950f56cc3	3aef56bf-23cb-4135-ac0d-224a1d8545e5	ocean_expert_updated	2018-08-01T00:00:00+02:00	active
bb724c3f-cdee-4858-8c1e-f438e22b366c	3aef56bf-23cb-4135-ac0d-224a1d8545e5	data_quality	Ocean Expert data	active
7fa75290-561a-479f-9c2f-e6c3b8554229	86610961-056c-4151-9c4e-3f6bb20c3832	website	www.geoscienze.unipd.it	active
b63682b2-43f3-4e73-82fe-daad75670faf	86610961-056c-4151-9c4e-3f6bb20c3832	email	geoscienze.direzione@unipd.it	active
1d67804e-7868-469a-98fd-7f7fd945784a	86610961-056c-4151-9c4e-3f6bb20c3832	phone	+39 0498279112	active
2b062b66-8fc8-4cb8-944e-8a3a92901061	86610961-056c-4151-9c4e-3f6bb20c3832	fax	+39 0498279134	active
5c5715f0-d955-410e-b2e6-83a3a507f08d	86610961-056c-4151-9c4e-3f6bb20c3832	country	Italy	active
e0bba360-0630-4416-ac72-6fdeba1ce5d3	86610961-056c-4151-9c4e-3f6bb20c3832	country_code	106	active
b1b680f3-1bbb-4779-be6d-f0560040db3a	86610961-056c-4151-9c4e-3f6bb20c3832	institution_type	Government	active
11512ee8-4da7-4ade-b5ff-1b5cb0de7a24	86610961-056c-4151-9c4e-3f6bb20c3832	ocean_expert_updated	2018-08-10T00:00:00+02:00	active
2b4cf555-55ce-4170-b6b8-c7d149daa241	86610961-056c-4151-9c4e-3f6bb20c3832	data_quality	Ocean Expert data	active
94470a84-10c0-484c-8572-f30fec2bbd55	e4478358-2dcf-4384-b600-08b0e0de1c95	website	https://ecologyaction.ca/	active
3e1553a6-139d-4f60-9759-448b5b437df0	e4478358-2dcf-4384-b600-08b0e0de1c95	country	Canada	active
662a0dea-bbb7-4078-a983-5de7d11db9bd	e4478358-2dcf-4384-b600-08b0e0de1c95	country_code	39	active
567ff468-04e9-4ac6-9076-951eae9ef677	e4478358-2dcf-4384-b600-08b0e0de1c95	institution_type	Private non-profit	active
e2a7bd7c-8aa7-49cf-8475-03f23814927f	e4478358-2dcf-4384-b600-08b0e0de1c95	ocean_expert_updated	2018-08-07T00:00:00+02:00	active
74074787-e692-45ea-a521-cba283a107e1	e4478358-2dcf-4384-b600-08b0e0de1c95	data_quality	Ocean Expert data	active
0bf2aab2-fc04-41a4-a9e0-e39e8a5561a5	b1da8b11-223d-4732-8017-3f719038dae0	website	https://www.csiro.au/en/Locations/Qld/St-Lucia	active
54b253e3-2542-4458-8283-380a9cf48367	b1da8b11-223d-4732-8017-3f719038dae0	country	Australia	active
3a7e4d89-5fe1-46ca-8c67-a0e38f1aac54	b1da8b11-223d-4732-8017-3f719038dae0	country_code	13	active
63eb8659-bf44-439c-a8ae-98ff52dca9ef	b1da8b11-223d-4732-8017-3f719038dae0	institution_type	Research	active
cef5f76c-23d0-4d7c-aade-c8c281cc4c3f	b1da8b11-223d-4732-8017-3f719038dae0	activities	The Queensland Bioscience Precinct is a state-of-the-art research facility based at the University of Queensland, housing more than 700 researchers.	active
4b026744-5b17-4e19-a109-fc0e1cd2e223	b1da8b11-223d-4732-8017-3f719038dae0	ocean_expert_updated	2020-10-29T00:00:00+01:00	active
d4bbe03a-47e8-4a3e-b0b2-34d59cccbe2e	b1da8b11-223d-4732-8017-3f719038dae0	data_quality	Ocean Expert data	active
96f69470-dde0-48dd-868b-813c9763f820	d724cd5d-9e63-41bb-8e5d-73bb841f6cd5	data_quality	OBIS data only	active
b9f09fde-b40a-4b54-b047-3bddd93066c8	88075da4-0351-4e14-a7da-6114f0309775	website	https://www.dal.ca/faculty/science/oceanography.html	active
c90d2795-2997-4f38-b54d-1eb10fc4d2a0	88075da4-0351-4e14-a7da-6114f0309775	country	Canada	active
86d94b79-c511-47a3-b5f8-d8e9d5399397	88075da4-0351-4e14-a7da-6114f0309775	country_code	39	active
94878189-3ad2-4ea5-a231-5e24f775fff3	88075da4-0351-4e14-a7da-6114f0309775	institution_type	Academic	active
26ffab6a-1075-47dd-866c-6c1aebf1c461	88075da4-0351-4e14-a7da-6114f0309775	ocean_expert_edmo_code	2279	active
97c44047-f7ae-4983-aecb-3a304edcf349	88075da4-0351-4e14-a7da-6114f0309775	ocean_expert_updated	2018-08-09T00:00:00+02:00	active
619b3033-dd3b-4a9b-a124-c6da7b162db4	88075da4-0351-4e14-a7da-6114f0309775	data_quality	Ocean Expert data	active
baca4de8-39a7-471f-9769-040d52fab991	46b0d887-58bf-4976-be93-cfe1f1bb40bc	website	https://www.naturalsciences.be/nl/science/collection_page/518	active
5b623c38-2560-4d34-bae3-fd98c1caaa15	46b0d887-58bf-4976-be93-cfe1f1bb40bc	email	patrick.semal@naturalsciences.be	active
b75c23ab-896e-440c-b765-38a2d948e1ae	46b0d887-58bf-4976-be93-cfe1f1bb40bc	phone	+32 (0)2 627 43 80	active
ce8f240f-e50f-4ad9-9278-3cbd9b0df778	46b0d887-58bf-4976-be93-cfe1f1bb40bc	country	Belgium	active
7719e41b-7bff-4479-a419-cf24d146f19e	46b0d887-58bf-4976-be93-cfe1f1bb40bc	country_code	21	active
3eb235cd-ccf3-45b0-acd5-cb6f99519447	46b0d887-58bf-4976-be93-cfe1f1bb40bc	institution_type	Government	active
d45ea388-60df-4ccf-a46b-cffb7acea252	46b0d887-58bf-4976-be93-cfe1f1bb40bc	ocean_expert_updated	2018-08-16T00:00:00+02:00	active
e30a98f7-6b4e-4863-b7b0-ed069204695a	46b0d887-58bf-4976-be93-cfe1f1bb40bc	data_quality	Ocean Expert data	active
5a84013f-a402-4841-9813-090bd562e360	a0566913-b123-4db5-8795-c36dd15bfbd2	website	http://www.ciesm.org/online/institutes/inst/Inst160.htm	active
9c46c185-a1e9-4abc-9b15-ee87d98ed2e6	a0566913-b123-4db5-8795-c36dd15bfbd2	email	ibmk@ibmk.org	active
8f958b4d-1066-4a8d-b6b9-74e1788a5ce4	a0566913-b123-4db5-8795-c36dd15bfbd2	phone	+ 382 32334570	active
8f28e53f-5e7c-40b2-aead-bc7d2c126d67	a0566913-b123-4db5-8795-c36dd15bfbd2	fax	+ 382 32334570	active
480cc404-365b-46a9-8b52-8a633bf5d670	a0566913-b123-4db5-8795-c36dd15bfbd2	country	Montenegro	active
c35001ea-4b2b-47a3-b948-38f0f4314bbe	a0566913-b123-4db5-8795-c36dd15bfbd2	country_code	240	active
d843bf47-6121-4761-9054-c3a624f95961	a0566913-b123-4db5-8795-c36dd15bfbd2	acronym	UoM, IMB	active
b11fced2-2467-4a3f-a6e4-741e6f9105bc	a0566913-b123-4db5-8795-c36dd15bfbd2	institution_type	Research	active
6d4bb472-a879-4c05-9edd-151b998788d6	a0566913-b123-4db5-8795-c36dd15bfbd2	activities	<span><span>Main sectors of research:<br></span>pelagic &amp; benthic communities, fisheries biology, aquaculture, environmental protection, sustainable development, neurohistology, neurophysiology, neurochemistry, behavioural studies, extraction and identification of bioactive compounds from marine organisms</span>	active
46fa0c41-2deb-4fd1-9ccb-573d1b17f192	a0566913-b123-4db5-8795-c36dd15bfbd2	ocean_expert_updated	2017-03-23T00:00:00+01:00	active
955d6d4b-a14f-46a6-8c27-16701f57c47a	a0566913-b123-4db5-8795-c36dd15bfbd2	data_quality	Ocean Expert data	active
254e1015-bb12-460c-b772-9776d94fceb9	d872e3e6-54fc-4a24-9c6f-c108d3d8696b	email	www.bg.ac.rs/en/	active
6ac46e71-a432-422e-8300-f070de8540ab	d872e3e6-54fc-4a24-9c6f-c108d3d8696b	country	Serbia	active
62c9a064-8ae9-4821-b51c-eabb978d1ef1	d872e3e6-54fc-4a24-9c6f-c108d3d8696b	country_code	236	active
09c4036a-74f2-42e5-82b6-48e3ea6f0c39	d872e3e6-54fc-4a24-9c6f-c108d3d8696b	institution_type	Academic	active
7e7f4a17-d34c-4503-baab-113be465a19e	d872e3e6-54fc-4a24-9c6f-c108d3d8696b	ocean_expert_updated	2018-08-02T00:00:00+02:00	active
0c83884b-85c1-4c89-bfb9-f2c48af0d432	d872e3e6-54fc-4a24-9c6f-c108d3d8696b	data_quality	Ocean Expert data	active
d2b4bfdd-8a0a-499b-8e94-0bca51c958f1	821f9831-8ab3-4015-8699-1493f2aa55bc	website	http://www.uni-hamburg.de/biologie/BioZ/zis/index_e.html	active
2e2c6c8f-0abd-49e1-9b4f-3d187f4ebb84	821f9831-8ab3-4015-8699-1493f2aa55bc	email	vorstand.biologie @ uni-hamburg.de	active
2adf93ab-1c4d-40d7-98b8-6d36e7ef43bd	821f9831-8ab3-4015-8699-1493f2aa55bc	phone	(+49) 40- 428.38.3880	active
add7a813-57e8-4257-9131-0ccd5b3d05bc	821f9831-8ab3-4015-8699-1493f2aa55bc	fax	(+49) +40- 428.38.3937	active
798351cf-98e0-4d46-abc6-dfd8c60e93da	821f9831-8ab3-4015-8699-1493f2aa55bc	country	Germany	active
f7b3b999-e915-47cb-9eef-451b48ce5399	821f9831-8ab3-4015-8699-1493f2aa55bc	country_code	82	active
bec510a5-bc9c-408d-8e6d-0123d233569b	821f9831-8ab3-4015-8699-1493f2aa55bc	acronym	ZIM	active
93b612c0-eeb0-4fe1-9573-292ba7f0ec1c	821f9831-8ab3-4015-8699-1493f2aa55bc	institution_type	Research	active
e160942c-3c4f-46dd-9a8f-c3d85a5bb040	821f9831-8ab3-4015-8699-1493f2aa55bc	ocean_expert_edmo_code	2316	active
be0d468e-253f-46bf-b87f-b01f886b90e8	821f9831-8ab3-4015-8699-1493f2aa55bc	activities	The Institute of Zoology consists of six divisions that offer a broad expertise in diverse areas of zoology, with a focus on evolutionary biology and ecology. Zoology at the University of Hamburg is represented by a young team of recently appointed professors, forming the backbone of a cutting-edge research environment.\r\nThe Institute of Zoology and the Zoological Museum are joined in a tight partnership, cooperating in both research and teaching.	active
db5ecee7-8ff7-4cff-a300-93e101137468	821f9831-8ab3-4015-8699-1493f2aa55bc	ocean_expert_updated	2013-07-03T00:00:00+02:00	active
548018b8-dfee-4c5e-a032-4de213cbac0a	821f9831-8ab3-4015-8699-1493f2aa55bc	data_quality	Ocean Expert data	active
7e1b5d6a-8cca-46fc-91d8-b93c37a62d2e	a2984ea7-0216-4f24-92ed-735096343c7d	website	https://www.anh.gov.co/	active
8a4cc136-6585-4b24-84a9-e3c0daaebc21	a2984ea7-0216-4f24-92ed-735096343c7d	email	info@anh.gov.co	active
7a6efea8-138d-42b0-83e8-decf04b60cb0	a2984ea7-0216-4f24-92ed-735096343c7d	phone	5715931717	active
4b851186-b261-489f-b5bd-d58fddb62929	a2984ea7-0216-4f24-92ed-735096343c7d	country	Colombia	active
5cd97f5f-57ad-4af0-a345-0e744d6b8c03	a2984ea7-0216-4f24-92ed-735096343c7d	country_code	48	active
9b06870e-19c1-46a7-8953-ca75ac4af621	a2984ea7-0216-4f24-92ed-735096343c7d	acronym	ANH	active
a2fc32fc-f1c5-480f-bccc-cc38115733c0	a2984ea7-0216-4f24-92ed-735096343c7d	institution_type	Government	active
c004f082-1955-47d7-8aa5-5bf8cd98da36	a2984ea7-0216-4f24-92ed-735096343c7d	activities	Promover el aprovechamiento óptimo y sostenible de los recursos hidrocarburíferos de Colombia, administrándolos integralmente y armonizando los intereses de la sociedad, el Estado y las empresas del sector	active
5d667958-e92a-47fa-923c-6a06681b7b33	a2984ea7-0216-4f24-92ed-735096343c7d	ocean_expert_updated	2020-06-19T00:00:00+02:00	active
8a20e9a4-34cb-4418-aeab-6863620ebc23	a2984ea7-0216-4f24-92ed-735096343c7d	data_quality	Ocean Expert data	active
57b7e359-3f63-42d1-96ed-4679dbfe6240	a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	website	https://www.latrobe.edu.au/lims	active
421978ca-ebcf-4ecb-83a0-9ca575474a7e	a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	email	limsenquiries@latrobe.edu.au	active
f9f5fe98-02c1-4941-aa9b-8ceb0e8b127e	a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	phone	+61 3 9479 2160	active
672af0ff-80d7-4c23-a9a7-acd30e8dcdfb	a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	country	Australia	active
c6235c4f-da84-4f34-accc-e0183416d219	a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	country_code	13	active
8a934714-95a5-4bf4-9fa0-aec4675bd731	a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	acronym	LIMS	active
fe9196ad-0c85-4883-bc64-566b490532c3	a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	institution_type	Academic	active
350ee7f9-74a0-4b57-9dfd-3c181b7fbed5	a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	ocean_expert_updated	2018-08-10T00:00:00+02:00	active
c113b797-9133-4876-9527-9a6d6ad21aff	a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	data_quality	Ocean Expert data	active
3b018d8f-8e19-4f4a-9dda-8f28f657cff0	75ab8796-08cb-485d-b137-bdf246c84ad8	website	http://www.acaphumberarm.com/	active
b587b386-8ae3-4fcf-ba4b-d01d417ea644	75ab8796-08cb-485d-b137-bdf246c84ad8	email	speddle@acaphumberarm.com	active
c8a42d01-68f8-404c-a0fb-4077c4ad98a4	75ab8796-08cb-485d-b137-bdf246c84ad8	phone	709.637.2883	active
cf30745e-9bc4-4127-b0b4-fed841ed9154	75ab8796-08cb-485d-b137-bdf246c84ad8	country	Canada	active
19800de7-b39e-4aa9-8b75-8dae44a6cf6e	75ab8796-08cb-485d-b137-bdf246c84ad8	country_code	39	active
262af3b9-1db0-4183-a2f5-50274d670a1e	75ab8796-08cb-485d-b137-bdf246c84ad8	institution_type	Private non-profit	active
6f0150a0-8a38-4005-919e-8c0cb2e08cc8	75ab8796-08cb-485d-b137-bdf246c84ad8	ocean_expert_edmo_code	4391	active
0706f962-6db0-4026-9666-0f5fc24d4091	75ab8796-08cb-485d-b137-bdf246c84ad8	ocean_expert_updated	2018-06-29T00:00:00+02:00	active
b0adaa0e-28df-49ac-98f2-d408ad594d48	75ab8796-08cb-485d-b137-bdf246c84ad8	data_quality	Ocean Expert data	active
e9c482bf-9f01-4c47-b29b-f781f4d06d4c	2b07e482-a787-4499-9737-fa3e488f19e0	website	https://www.eoceans.co/	active
f4f39760-39bc-4207-8747-9dfd14b9e2d5	2b07e482-a787-4499-9737-fa3e488f19e0	email	christine@eoceans.co	active
251705c7-a2d9-452b-a5f7-77f524932895	2b07e482-a787-4499-9737-fa3e488f19e0	country	Canada	active
62651c51-64f8-480d-a2b7-883cd93c39a0	2b07e482-a787-4499-9737-fa3e488f19e0	country_code	39	active
58a93771-8488-423d-85fa-71aee71f7f71	2b07e482-a787-4499-9737-fa3e488f19e0	institution_type	Private non-profit	active
16a66823-6bea-4d55-9218-2d31261ad647	2b07e482-a787-4499-9737-fa3e488f19e0	ocean_expert_updated	2018-06-28T00:00:00+02:00	active
ffb09737-bfe8-4312-864c-a4e18ef361ee	2b07e482-a787-4499-9737-fa3e488f19e0	data_quality	Ocean Expert data	active
8f6a370d-bd84-4685-993f-68fcb1568358	63385ab9-f57a-4eae-a1ae-8212f114cc46	country	Greece	active
61413ac6-69aa-4897-82de-b08786d6b87a	63385ab9-f57a-4eae-a1ae-8212f114cc46	country_code	85	active
0dc1cda2-1f78-440f-889f-4f07d5e164b5	63385ab9-f57a-4eae-a1ae-8212f114cc46	institution_type	Government	active
60d3fbcb-fca9-4016-9e5c-61b09d004f00	63385ab9-f57a-4eae-a1ae-8212f114cc46	ocean_expert_updated	2018-08-22T00:00:00+02:00	active
09e92eeb-2c17-4303-8a77-563525cf3d08	63385ab9-f57a-4eae-a1ae-8212f114cc46	data_quality	Ocean Expert data	active
91539512-de25-409e-a930-3ecc9f9930ca	aee7e56c-06eb-476d-ac2f-f0faefcb2612	website	https://niof-eg.com/#m-11-2021	active
fffcb056-c461-494f-ab67-0849f499cf0d	aee7e56c-06eb-476d-ac2f-f0faefcb2612	email	niof@niof.sci.eg	active
dbb1bc69-bae1-4354-adc2-7d97da9b0f94	aee7e56c-06eb-476d-ac2f-f0faefcb2612	phone	+20 4801 499 	active
7652ee60-5c39-4b18-84ef-b1e73b5d7567	aee7e56c-06eb-476d-ac2f-f0faefcb2612	fax	+20 4801 174 	active
1c1b5f19-8b73-48f5-882c-56fd52b1ec39	aee7e56c-06eb-476d-ac2f-f0faefcb2612	country	Egypt	active
ecd48743-1a0d-4c30-866f-048dc530c2a1	aee7e56c-06eb-476d-ac2f-f0faefcb2612	country_code	64	active
37119444-da29-40e4-b386-47e6b17786eb	aee7e56c-06eb-476d-ac2f-f0faefcb2612	acronym	NIOF	active
e7eda816-b811-49c6-b8e3-a97f7e0e5f14	aee7e56c-06eb-476d-ac2f-f0faefcb2612	institution_type	Government	active
fc29175b-68fa-451a-b865-e38b0cca94aa	aee7e56c-06eb-476d-ac2f-f0faefcb2612	activities	1-Fisheries Research<br>2-Geological &amp; Geophysical Marine Survey.\r\nBathymetry Study.\r\nShallow Seismic study\r\nSediment variation of sea bottom<br>3- Statistical studied.<br>4- Seismic Hazards.<br>5- Geotechnical Study (drilling, SPT, Liquefaction).<br>6- Ground Water.<br>7- Environment Impact Assessment - EIA<br>8-Hydrograpic Study.<br>9- Pollution Impact<br>10- Coastal Management <br><br>||NODC||<br><br><br><br>	active
16a1fdf9-30f1-4a10-9410-de4c2d69021a	aee7e56c-06eb-476d-ac2f-f0faefcb2612	ocean_expert_updated	2024-03-20T00:00:00+01:00	active
b60156f8-3e7a-43ef-ae2f-e15af959474c	aee7e56c-06eb-476d-ac2f-f0faefcb2612	data_quality	Ocean Expert data	active
893bd1ce-6f41-4284-97a9-3e4d5f2c7de0	eb4bc51c-9225-4b28-960e-4123e11315b3	website	http://www.univ-lome.tg	active
3c0f4982-d539-4b5f-a41e-f677a8f25063	eb4bc51c-9225-4b28-960e-4123e11315b3	email	direcoop_ul@yahoo.fr	active
b64dbbe1-bf3d-4c68-9fad-7def4c93e57c	eb4bc51c-9225-4b28-960e-4123e11315b3	phone	+228 22255094	active
1fc6a778-f3a2-4763-9129-7b8e76319cbd	eb4bc51c-9225-4b28-960e-4123e11315b3	country	Togo	active
dc2d24cc-258c-496c-bf51-323705a42070	eb4bc51c-9225-4b28-960e-4123e11315b3	country_code	210	active
b86e10eb-df26-4323-8f14-802e3b26be20	eb4bc51c-9225-4b28-960e-4123e11315b3	acronym	CGILE	active
b62e59cc-e7c6-45db-b1eb-0e93e3ddfabc	eb4bc51c-9225-4b28-960e-4123e11315b3	institution_type	Academic	active
a0d575d9-c8d7-4ea1-a06b-79a065ec5fa2	eb4bc51c-9225-4b28-960e-4123e11315b3	ocean_expert_updated	2024-03-15T00:00:00+01:00	active
8aaea3bd-dbb1-4ec1-923f-feb242cc281a	eb4bc51c-9225-4b28-960e-4123e11315b3	data_quality	Ocean Expert data	active
035da584-fa4b-4399-8cb2-b70abd0f1550	8da43065-d681-4a4d-9f4b-37bc6598d9dd	website	http://www-3.unipv.it/webcib/ibac.html	active
a4154f8d-4ac2-4fad-aff5-549081f3f3a2	8da43065-d681-4a4d-9f4b-37bc6598d9dd	email	cibra@unipv.it	active
0ba62382-367d-4e26-89a6-db129eefbcbd	8da43065-d681-4a4d-9f4b-37bc6598d9dd	country	Italy	active
a3c4979a-dd9a-44f4-9d69-fc66f335bc08	8da43065-d681-4a4d-9f4b-37bc6598d9dd	country_code	106	active
427c682e-bcde-4bff-82dc-b40c21ef4a92	5832257f-6aaf-4691-889b-d919e8a15159	phone	+53 33301104	active
d8c92877-8bc4-44a3-9e0f-ceb59d5cebef	8da43065-d681-4a4d-9f4b-37bc6598d9dd	institution_type	Academic	active
01d3dfe5-d5bf-4052-8888-69884800a79c	8da43065-d681-4a4d-9f4b-37bc6598d9dd	activities	Bioacoustics is a branch of zoology, strictly related to ethology, that investigates sound production and reception in animals, including man. Bioacoustics also concerns the organs of hearing and the sound producing apparatus as well as the physiological and neurophysiological processes by which sounds are produced and received. Finally it attempts to understand relationships between the features of the sounds an animal produces and the nature of the environment in which they are used and the functions they are designed to serve. Its development dates effectively from about 1950, when practical recording and analyzing methods became readily available to the scientific community	active
8ced9b7b-28c3-48a3-a994-3fe141fe57f0	8da43065-d681-4a4d-9f4b-37bc6598d9dd	ocean_expert_updated	2020-08-03T00:00:00+02:00	active
f7305d97-342e-4e4a-ac1a-29d38877a0a5	8da43065-d681-4a4d-9f4b-37bc6598d9dd	data_quality	Ocean Expert data	active
3c5c8e51-3c25-461d-b943-c00cf08635b9	5a4618e8-aefc-4721-8adc-ff442928090d	website	http://www.seaturtle.org/tracking/index.shtml?project_id=1091	active
ec549959-a19d-4a74-97c9-f27d31e9b40f	5a4618e8-aefc-4721-8adc-ff442928090d	country	Australia	active
9307d3c0-65eb-4d5a-a5a5-e9d1c0a0d930	5a4618e8-aefc-4721-8adc-ff442928090d	country_code	13	active
6475a26b-a72f-42b2-b96d-e0604e137770	5a4618e8-aefc-4721-8adc-ff442928090d	institution_type	NGO	active
a3686b12-c9e7-4160-afcb-b5ce48b2469f	5a4618e8-aefc-4721-8adc-ff442928090d	activities	his project is a partnership between CSIRO, the Bardi Jawi rangers and the Western Australian Department of Parks &amp; Wildlife.<br><br>The project aims to study the movement and feeding ecology of turtles, especially green turtles, in the Bardi Jawi Indigenous Protected Area, which is located in the Kimberley region of Western Australia. We are interested in where the turtles go, where they feed, and any other insights that we can obtain from the satellite tagged animals.<br><br>The turtles were captured and tagged in the Bardi Jawi Indigenous Protected Area, which was declared in 2013. This is managed for sustainable use of natural resources, including turtles (known as goorlil by the Bardi Jawi people)	active
f93ce891-56c9-4b60-812a-1ae5a31d7da0	5a4618e8-aefc-4721-8adc-ff442928090d	ocean_expert_updated	2020-07-17T00:00:00+02:00	active
1d963adc-08b6-4dee-aa82-276d86c6c733	5a4618e8-aefc-4721-8adc-ff442928090d	data_quality	Ocean Expert data	active
ef818844-f350-4577-bc0c-2c76e669686e	83f33156-eeb2-4d6a-8b2c-195098119758	website	http://nsis.chebucto.org/	active
4dbf02ad-5795-4750-ad34-ede66caede08	83f33156-eeb2-4d6a-8b2c-195098119758	email	nsis@chebucto.ns.ca	active
5f151e74-fd9e-4f72-8016-c550c4a144ce	83f33156-eeb2-4d6a-8b2c-195098119758	country	Canada	active
0cd6390b-69e7-4b73-a570-d8e0f8ed6c4a	83f33156-eeb2-4d6a-8b2c-195098119758	country_code	39	active
9da1cf85-d05f-4ac2-b587-33d955cde567	83f33156-eeb2-4d6a-8b2c-195098119758	acronym	NSIS	active
f893e6af-8ce8-469e-834d-252575666d90	83f33156-eeb2-4d6a-8b2c-195098119758	institution_type	Private non-profit	active
9cad5aac-e181-469e-98cb-f84cc4de4a85	83f33156-eeb2-4d6a-8b2c-195098119758	ocean_expert_updated	2018-08-13T00:00:00+02:00	active
43d7ad4d-e3a2-4979-a26b-5da85c9ecdb9	83f33156-eeb2-4d6a-8b2c-195098119758	data_quality	Ocean Expert data	active
38abad53-936b-4d6e-9d7e-71370a6a11ab	ea04f2bc-c054-4e92-bb94-dcb31404328c	website	http://www.phycology.ugent.be/	active
a4bdf1b5-4766-4d81-8e10-d518e18739a1	ea04f2bc-c054-4e92-bb94-dcb31404328c	phone	+32 9 264 85 00	active
6cfe8586-6be9-4d2b-b157-e8cbfcdfe083	ea04f2bc-c054-4e92-bb94-dcb31404328c	country	Belgium	active
f430a23b-e7cd-4bf3-9ae7-3165bd89d201	ea04f2bc-c054-4e92-bb94-dcb31404328c	country_code	21	active
c0486b48-903f-41b2-a9b9-196b8b243f1b	ea04f2bc-c054-4e92-bb94-dcb31404328c	institution_type	Academic	active
355839e5-90a4-4b4b-b81c-bd6716de468c	ea04f2bc-c054-4e92-bb94-dcb31404328c	activities	Our research focuses on genetics, diversity and distributions of marine macroalgae. We address questions ranging from descriptive taxonomy over ecological studies forecasting the distribution of species in relation to environmental change to genomics of selected green and brown seaweed species. A substantial part of our research involves a combination of fieldwork, culturing and manipulating seaweed strains to study their development (<i>Dictyota</i>), gamete development (<i>Ectocarpus</i>,&nbsp;<i>Ulva</i>) or morphogenesis and genomics (green seaweeds).	active
eb5e386f-a71e-4dc6-9647-0166b889c2e6	ea04f2bc-c054-4e92-bb94-dcb31404328c	ocean_expert_updated	2020-06-17T00:00:00+02:00	active
836a180b-81a8-4f3f-9b7c-df823a748a7e	ea04f2bc-c054-4e92-bb94-dcb31404328c	data_quality	Ocean Expert data	active
7270b6d5-7881-4d4a-b330-b7f8e6cc470d	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	website	http://iprc.soest.hawaii.edu/~belmadan	active
a60f10d3-a32d-46fb-bf95-6cc75262fde2	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	email	belmadan@hawaii.edu	active
869be452-0c05-460e-b259-c8a2d0aefb67	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	phone	+18089567114	active
11efd433-bf70-458f-b736-a56cec31d11f	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	fax	+18089569425	active
fb1bd471-9591-4ebb-b551-13a5d920d0b4	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	country	United States of America	active
011721b1-1a71-433f-a23c-07fd950655cd	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	country_code	223	active
81fed7af-0e7c-4099-8c33-0548137c1b41	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	acronym	UH	active
1a75c86b-d00a-424b-be8d-478ef8bc9b35	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	institution_type	Research	active
fd1032bc-d23a-4e30-bd94-9504abdbe573	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	ocean_expert_updated	2018-08-07T00:00:00+02:00	active
030c245b-541b-47ee-933d-1baba687befe	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	data_quality	Ocean Expert data	active
8d319678-d841-4f86-a011-c2565b2faf31	eff016a7-9f02-46a2-aa39-3d5960c14801	country	Italy	active
0482b603-7d8b-4641-8fe6-05c4ea72dcf3	eff016a7-9f02-46a2-aa39-3d5960c14801	country_code	106	active
031ea73b-9f28-4fb1-8ecd-061321082f4b	eff016a7-9f02-46a2-aa39-3d5960c14801	acronym	DEB	active
7aace952-ff8e-4c30-a371-eb5a7a497671	eff016a7-9f02-46a2-aa39-3d5960c14801	institution_type	Academic	active
c25da2b5-e9fa-4c2d-8703-da8b5ec83364	eff016a7-9f02-46a2-aa39-3d5960c14801	ocean_expert_updated	2018-08-01T00:00:00+02:00	active
f167f232-11d0-4f2f-ac9c-6e8a870a6e6e	eff016a7-9f02-46a2-aa39-3d5960c14801	data_quality	Ocean Expert data	active
059f380b-0d9f-4de0-94d2-c1f3b205f2df	b21f79c7-e15a-4794-beff-f4c353903d02	website	www.peaubleue.org	active
8e3fc1e5-8093-4b28-82cc-7130ad7df928	b21f79c7-e15a-4794-beff-f4c353903d02	email	bio.marine@wanadoo.fr	active
3170b28e-820d-4bc2-9778-481340f3a260	b21f79c7-e15a-4794-beff-f4c353903d02	phone	04 67 21 09 20	active
08502396-f268-4dd2-86f6-4b5f736d0825	b21f79c7-e15a-4794-beff-f4c353903d02	country	France	active
2270110a-ca9a-49c0-811c-36fe73535901	b21f79c7-e15a-4794-beff-f4c353903d02	country_code	74	active
18116928-1ad9-4723-b913-222ff3a35d58	b21f79c7-e15a-4794-beff-f4c353903d02	institution_type	Private non-profit	active
50a30f75-eb2e-4d56-8e95-88eb2be674cd	b21f79c7-e15a-4794-beff-f4c353903d02	ocean_expert_updated	2018-06-29T00:00:00+02:00	active
20b3d65b-ed46-4855-bf08-6e26951d0da1	b21f79c7-e15a-4794-beff-f4c353903d02	data_quality	Ocean Expert data	active
18eead5d-30f5-4aa1-bfec-f57b301c3a74	1c002e91-1a9a-4f13-b514-fd11af8c32fd	website	http://corpoguajira.gov.co/wp/	active
bc8c4ef9-b4de-4bbe-b9c3-4ddd81ee92c8	1c002e91-1a9a-4f13-b514-fd11af8c32fd	email	servicioalcliente@corpoguajira.gov.co	active
c6ab703d-6e07-418b-b0a7-5494588f51d7	1c002e91-1a9a-4f13-b514-fd11af8c32fd	phone	57 5 72886778	active
77dbb9d3-982c-4ccd-bf69-3b9d1d3ae92f	1c002e91-1a9a-4f13-b514-fd11af8c32fd	fax	57 5 7275125	active
15237dbf-0ca1-4e83-b542-66405ce041d5	1c002e91-1a9a-4f13-b514-fd11af8c32fd	country	Colombia	active
eb76bee0-c44d-4c82-8f4c-a2fb4f0c3359	1c002e91-1a9a-4f13-b514-fd11af8c32fd	country_code	48	active
d614f62e-06fe-4bc8-8ee5-1b29a1028285	1c002e91-1a9a-4f13-b514-fd11af8c32fd	acronym	CORPOGUAJIRA	active
31f47c8a-4c1f-490f-a64f-803d2cda2ece	1c002e91-1a9a-4f13-b514-fd11af8c32fd	institution_type	Government	active
5bc7f139-bbcf-4931-9d9a-04e8c643c781	1c002e91-1a9a-4f13-b514-fd11af8c32fd	activities	Environmental Regional Authority&nbsp;	active
fe93764c-e364-4481-ab28-6bc645b8e1ce	1c002e91-1a9a-4f13-b514-fd11af8c32fd	ocean_expert_updated	2020-08-05T00:00:00+02:00	active
10852fab-4249-4b68-9cf2-f21d17cc8e36	1c002e91-1a9a-4f13-b514-fd11af8c32fd	data_quality	Ocean Expert data	active
12633355-94d5-4bba-8c92-aa69c19a6844	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	website	http://programaecomar.com	active
60b09111-8cc5-48e9-9be7-50707dcb4d7a	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	email	ongprogramaecomar@yahoo.com	active
41b75059-a83b-4e51-bf35-301f2f0ba4ce	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	phone	1 809 532 9905	active
4002ea47-c3eb-4815-b88b-3f7c446ca803	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	country	Dominican Republic	active
4d9c10d4-0d4c-47b3-a2df-186cfdfd89df	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	country_code	61	active
8d637ec9-70b0-4269-b688-8a175b0d89ca	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	acronym	PROECOMAR	active
4e470e04-fa2d-416e-bef6-3ac9d7ca82e9	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	institution_type	Private non-profit	active
7b13730b-4f1e-4b10-8917-b3f0509973d4	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	activities	Main research lines of Programa EcoMar: environmental education and management, fisheries, coastal marine ecology and biodiversity and climate change	active
843c76d1-f7de-494b-a7e7-17fb346e0d5c	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	ocean_expert_updated	2014-03-22T00:00:00+01:00	active
dd142134-87b4-459d-9934-e875ce598c14	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	data_quality	Ocean Expert data	active
f5fa4c4d-c187-4571-abf3-ef70dc6c4d77	95df44c1-644f-437e-9c39-989caff18ee4	country	United States of America	active
6aa9d576-85af-4cb6-b1bb-adb7f5d2193b	95df44c1-644f-437e-9c39-989caff18ee4	country_code	223	active
9d1c6c9c-df00-4043-a640-b0b837b43e17	95df44c1-644f-437e-9c39-989caff18ee4	acronym	EWHALE	active
c58d537e-5f22-4d80-9d07-1e94fc2a8a45	95df44c1-644f-437e-9c39-989caff18ee4	institution_type	Research	active
610206a4-a140-4154-ae39-593070754b18	95df44c1-644f-437e-9c39-989caff18ee4	ocean_expert_updated	2020-08-12T00:00:00+02:00	active
5085bded-67e5-4f0f-91dc-24aa49e04cb1	95df44c1-644f-437e-9c39-989caff18ee4	data_quality	Ocean Expert data	active
cf5c01f4-1267-44cc-83b0-25ab217de753	56bb757e-7427-4bf2-afdc-7669b7cb4afc	website	https://bio.kuleuven.be/eeb/lbeg	active
912f9553-be5e-4181-8269-b0bd08b21965	56bb757e-7427-4bf2-afdc-7669b7cb4afc	email	henrik.christiansen@kuleuven.be	active
e71ad2a9-a2ea-426b-8c45-5db810d19454	56bb757e-7427-4bf2-afdc-7669b7cb4afc	phone	+32 16 37 66 92	active
4aead0e2-f520-4032-8229-5fbca7ae0535	56bb757e-7427-4bf2-afdc-7669b7cb4afc	fax	+32 16 3 24 575	active
6a6c95c0-b19d-49e1-9c2c-1af2fd101ce0	56bb757e-7427-4bf2-afdc-7669b7cb4afc	country	Belgium	active
8464a857-9e6f-4d6b-ba3e-d4695d1a9483	56bb757e-7427-4bf2-afdc-7669b7cb4afc	country_code	21	active
f41d6226-f9b9-4d3d-ae09-5f1877f16202	56bb757e-7427-4bf2-afdc-7669b7cb4afc	acronym	LBEG	active
40b46803-0137-4ff5-8255-b5dcf419a251	56bb757e-7427-4bf2-afdc-7669b7cb4afc	institution_type	Academic	active
2e7cced2-fc1e-4a6d-8891-ba7aa2394994	56bb757e-7427-4bf2-afdc-7669b7cb4afc	ocean_expert_edmo_code	425	active
90d8e686-3cb0-4bc4-bd7a-0e9821092d71	56bb757e-7427-4bf2-afdc-7669b7cb4afc	activities	Our&nbsp;<a target="_blank" rel="nofollow" href="https://bio.kuleuven.be/eeb/lbeg/research.html">Research</a>&nbsp;focuses on biodiversity, mostly vertebrates diversity, with special attention to evolutionary genetics and speciation, parasitology, molecular ecology, fish ecology and systematics, and bioarcheology. Whenever possible we use complementary approaches at the genomic, phenotypic, ecological and environmental level to support our findings. We manage a medium-throughput genotyping laboratory, have access to a genomics platform and do our bioinformatics in house. We organize the bachelor courses of genetics and archaeozoology. Master courses are taught in chordate diversity, comparative and functional anatomy of chordates, marine ecology, speciation and phylogenetics, bioinformatics (quantitative and evolutionary genetics), wildlife management and archaeozoology.<br>We cooperate with partners across Europe and North America, and in the Southern Hemisphere (projects all over Africa, in Ecuador and Vietnam). Our research has applications in sustainable development, nature conservation, water and wildlife management, human biology, fisheries and aquaculture.	active
adf2926f-940a-4df0-9645-40700a389f58	56bb757e-7427-4bf2-afdc-7669b7cb4afc	ocean_expert_updated	2018-08-08T00:00:00+02:00	active
be2e59ed-fa38-465c-b728-eb3758bdc067	56bb757e-7427-4bf2-afdc-7669b7cb4afc	data_quality	Ocean Expert data	active
de934e61-5ed4-4684-9732-7bd30e09afce	5832257f-6aaf-4691-889b-d919e8a15159	website	http://www.ciec.cu	active
b37bfc4e-7616-4833-bf45-234fa2d9f111	5832257f-6aaf-4691-889b-d919e8a15159	email	ciec@ciec.cu	active
d17b3320-9e8d-4f71-8df0-99171b60af99	5832257f-6aaf-4691-889b-d919e8a15159	fax	+53 33301151	active
1d4e4581-4096-4fc9-a700-59b41835f66e	5832257f-6aaf-4691-889b-d919e8a15159	country	Cuba	active
ed0c0a17-f752-44db-86a1-bf2638d377df	5832257f-6aaf-4691-889b-d919e8a15159	country_code	55	active
d5bc8582-f9bc-4246-a41f-ad2f6ca692cb	5832257f-6aaf-4691-889b-d919e8a15159	acronym	CIEC	active
ef16e537-8c5d-4fae-b8b4-0105a9404b6b	5832257f-6aaf-4691-889b-d919e8a15159	institution_type	Government	active
c2fc275f-bff7-4316-b9b8-6e3e8be577b7	5832257f-6aaf-4691-889b-d919e8a15159	activities	<span>El Centro de Investigaciones de Ecosistemas Costeros se encuentra ubicado en Cayo Coco, en la parte central del Archipiélago Sabana-Camagüey, al norte de la provincia de Ciego de Ávila, en el centro de Cuba.<br>Este cayo tiene un área aproximada de 370 km2 y constituye uno de los núcleos principales para el desarrollo del turismo en nuestro país debido a la gran belleza de muchos de sus recursos naturales, entre los que sobresalen, sus bosques, manglares, playas y su rica biodiversidad.</span>	active
391bc594-728a-4477-8eb4-1fbed13093cd	5832257f-6aaf-4691-889b-d919e8a15159	ocean_expert_updated	2017-04-26T00:00:00+02:00	active
2ca2a275-1c1e-427a-8129-9fcf144cd82c	5832257f-6aaf-4691-889b-d919e8a15159	data_quality	Ocean Expert data	active
9a4540e7-7aba-4eb6-a27a-ed1e4934efa5	3b779396-977e-48e6-9b33-9bc06991cbcc	website	http://www.acquariodigenova.it/jsp/index.jsp	active
57f8e6cd-8273-41e0-a6d8-66580f18cfe4	3b779396-977e-48e6-9b33-9bc06991cbcc	phone	+39 010 23451	active
0f9f419a-ea94-4691-87e0-f97b6386b1cf	3b779396-977e-48e6-9b33-9bc06991cbcc	fax	+39 010 256160	active
68c34f84-771f-48fa-9066-124265ea534a	3b779396-977e-48e6-9b33-9bc06991cbcc	country	Italy	active
807a130d-ddf2-4e45-bab9-51f558facb22	3b779396-977e-48e6-9b33-9bc06991cbcc	country_code	106	active
7a1b8f08-2084-485b-ae11-b4367d39fa5b	3b779396-977e-48e6-9b33-9bc06991cbcc	acronym	AdG	active
62da17f4-dfca-4e16-a98f-bc27b2dbf654	3b779396-977e-48e6-9b33-9bc06991cbcc	institution_type	Private commercial	active
2ae9e4b3-e4dc-4b72-90d0-ee3968c7af48	3b779396-977e-48e6-9b33-9bc06991cbcc	activities	Public Aquarium	active
5a73fe00-229d-4528-a778-d8ba2b50a447	3b779396-977e-48e6-9b33-9bc06991cbcc	ocean_expert_updated	2013-06-17T00:00:00+02:00	active
18043fd6-3154-4277-84ec-cc9f96c9e522	3b779396-977e-48e6-9b33-9bc06991cbcc	data_quality	Ocean Expert data	active
08a52488-0eaf-4fd4-a9e7-61b3539aeb68	65195257-f380-42b6-8127-c150f31de68d	website	https://www.marinelifealliance.org/satellitetracking/#	active
3932e4e4-407a-4c72-9cd3-97b24bb99cde	65195257-f380-42b6-8127-c150f31de68d	country	Bangladesh	active
a530b89b-3088-461a-ba5d-4854db7d5837	65195257-f380-42b6-8127-c150f31de68d	country_code	18	active
d35710fd-46d2-4b2d-b8e8-7f2a571bd5f8	65195257-f380-42b6-8127-c150f31de68d	institution_type	NGO	active
6ace103f-87c4-49ef-bdcd-dfd054062f69	65195257-f380-42b6-8127-c150f31de68d	activities	Satellite tracking conducted to study migration and foraging habitat of sea turtle nest on our coast. Satellite&nbsp;Tracking involves attaching on the sea turtle shell a&nbsp;Platform Terminal Transmitter (PTT) and getting the&nbsp;transmission data from ARGOS Satellite. Te PTT send&nbsp;message to satellite each time the turtle comes to the&nbsp;surface to breathe and the analyzed data sent to MLA&nbsp;researcher via satellite regarding the location of the&nbsp;tracked turtle. MLA attached total&nbsp;13 PTT satellite tags on Olive ridley at St. Martin Island,&nbsp;Teknaf-Cox’s Bazar beach, Sonadia and at oﬀshore&nbsp;location near Dholghata beach.	active
2ca0b622-b234-4421-a1f6-d14e9484cd85	65195257-f380-42b6-8127-c150f31de68d	ocean_expert_updated	2020-07-17T00:00:00+02:00	active
c9c2a733-885b-43f8-9707-56f5864d12e8	65195257-f380-42b6-8127-c150f31de68d	data_quality	Ocean Expert data	active
743bb9d1-f071-4d2c-a028-77883c19dd46	4842a628-3350-41c8-a922-53a20eb6d466	website	https://biology.queensu.ca/	active
8c0a8163-dbe1-4452-b415-2f829e9101e1	4842a628-3350-41c8-a922-53a20eb6d466	country	Canada	active
2842cd06-e29b-47ab-a950-d83cd0d9bfcd	4842a628-3350-41c8-a922-53a20eb6d466	country_code	39	active
1b9a7e8d-457c-4683-af6b-0bb1565ac25d	4842a628-3350-41c8-a922-53a20eb6d466	institution_type	Academic	active
2e9c78d5-f027-4289-9654-9143aa877859	4842a628-3350-41c8-a922-53a20eb6d466	ocean_expert_updated	2018-08-09T00:00:00+02:00	active
d41b45ae-c171-4ec6-a332-2873a6e76b45	4842a628-3350-41c8-a922-53a20eb6d466	data_quality	Ocean Expert data	active
d5002a82-257b-4ad1-a54a-1216debc90c8	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	website	www.cusat.ac.in	active
540d1383-b753-46b0-8fae-ff72917aa349	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	email	registrar@cusat.ac.in	active
966c53e3-1aa6-4e3d-9134-7fd7bcbf6f98	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	phone	+91 484 2577 290	active
a313936b-bda8-49a9-ad0d-fb9343628d40	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	fax	+91 484 2577 595	active
a870f2cc-7e83-42e4-8f17-bc02b2388c0e	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	country	India	active
b7a58e92-81d1-497d-a4c9-349a03cf3d1e	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	country_code	100	active
46c7fab7-a209-48e7-a406-cb8e11b66218	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	acronym	CUSAT	active
d20023f9-33f4-4b03-a508-2365721cff1a	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	institution_type	Government	active
680ff154-f90b-4644-9526-5c4e3d9e5201	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	ocean_expert_updated	2017-10-19T00:00:00+02:00	active
378bcaa3-8b52-403a-939d-6727975a514a	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	data_quality	Ocean Expert data	active
e14884d9-8ebf-436b-954f-70280a58f839	fc41f84f-3f3e-4a3b-b359-24f8b5f78d18	website	http://www.msutawi-tawi.edu.ph/	active
9b20a5b3-a26d-4ace-ae75-0a770d8d874a	fc41f84f-3f3e-4a3b-b359-24f8b5f78d18	country	Philippines	active
e71e52e0-f037-473e-9fb5-06617af51e8a	fc41f84f-3f3e-4a3b-b359-24f8b5f78d18	country_code	170	active
ad173230-fb7d-4048-bd35-d584eacdf0aa	fc41f84f-3f3e-4a3b-b359-24f8b5f78d18	institution_type	Academic	active
075eea85-7413-4696-bfc0-5417ae319fb3	fc41f84f-3f3e-4a3b-b359-24f8b5f78d18	ocean_expert_updated	2018-08-03T00:00:00+02:00	active
53d9e04c-3d3c-4732-858e-ae9c5bd79532	fc41f84f-3f3e-4a3b-b359-24f8b5f78d18	data_quality	Ocean Expert data	active
9fa77271-c314-44b4-98d3-c505611cc1b2	3b6db43c-5d62-4098-a9c6-605909db5458	country	United Kingdom of Great Britain and Northern Ireland	active
7c971936-c1a5-4b2d-97cb-4043fd0b5e71	3b6db43c-5d62-4098-a9c6-605909db5458	country_code	222	active
4de73a69-6b87-4df5-89b4-c22243472f29	3b6db43c-5d62-4098-a9c6-605909db5458	institution_type	Academic	active
87659a97-30f0-459f-826c-5324d7028fc3	3b6db43c-5d62-4098-a9c6-605909db5458	ocean_expert_updated	2018-08-16T00:00:00+02:00	active
57c707db-f2bc-4255-badd-4de52d443e81	3b6db43c-5d62-4098-a9c6-605909db5458	data_quality	Ocean Expert data	active
fadb0c47-f818-47f6-8e9e-541d76ba0087	5dbf9540-1fec-4b79-a68a-0e39c1ce080f	phone	12518612289	active
0a13ef8a-a027-48e1-93af-1f7911fe1a9a	5dbf9540-1fec-4b79-a68a-0e39c1ce080f	country	United States of America	active
164568a3-55c3-445e-a04f-463071e3c506	5dbf9540-1fec-4b79-a68a-0e39c1ce080f	country_code	223	active
566a7431-ba47-443a-84a4-321e9d413cec	5dbf9540-1fec-4b79-a68a-0e39c1ce080f	institution_type	Academic	active
08c95bad-c848-45bf-98df-0a1c1e5c333e	5dbf9540-1fec-4b79-a68a-0e39c1ce080f	activities	Coastal biological oceanography. Research activities focus on understanding the effects of climate variability on the magnitude and consequences of jellyfish blooms in heavily fished ecosystem.	active
cf700184-8894-4b61-bc74-04b380190dc4	5dbf9540-1fec-4b79-a68a-0e39c1ce080f	ocean_expert_updated	2011-05-02T00:00:00+02:00	active
5260269f-9d83-4c26-997f-660524282d00	5dbf9540-1fec-4b79-a68a-0e39c1ce080f	data_quality	Ocean Expert data	active
a7041449-381d-481b-bf26-bcc8c36865ab	8eac503f-e6d2-4c82-9e2f-e56768b39dce	data_quality	OBIS data only	active
ce5b9d5a-8a0e-451d-8127-be55a1944831	48021ea1-c7ba-4304-bf41-3ac7411be99e	website	http://www.uantof.cl/institutos/oceanologicas	active
bf4c9de1-1494-4e7f-b81a-1dbe5e41fc47	48021ea1-c7ba-4304-bf41-3ac7411be99e	email	pedro.echeveste@uantof.cl	active
4cdde48b-a078-4240-a65b-fa4a8f646db8	48021ea1-c7ba-4304-bf41-3ac7411be99e	phone	+56 552637867	active
f59873b2-cd9f-457d-b7a0-f726af6fb158	48021ea1-c7ba-4304-bf41-3ac7411be99e	country	Chile	active
8c885809-e561-45f7-9960-d61eb12411e3	48021ea1-c7ba-4304-bf41-3ac7411be99e	country_code	44	active
cbb7d9b9-31d7-4fc6-8039-55b30580cc9d	48021ea1-c7ba-4304-bf41-3ac7411be99e	acronym	UA	active
6590e5bc-e114-44f5-8f47-f3adb74f3fd6	48021ea1-c7ba-4304-bf41-3ac7411be99e	institution_type	Academic	active
b8ae01c4-d227-4591-a4ee-d47d5d1107f8	48021ea1-c7ba-4304-bf41-3ac7411be99e	activities	<div>Ecology, Population genetics and Evolution of coastal species.</div><div>Ecology and Biogeography of parasites of marine organisms.</div><div>Epidemiology in Aquaculture.</div><div>Population dynamics of fishery resources.</div><div>Modeling of Complex Systems.</div><div>Bento-pelagic coupling.</div><div>Sedimentology and Paleo-Oceanography.</div><div>Ecotoxicology and environmental pollution.</div>	active
583b5425-9c8b-4cfc-bc77-6480b112a357	48021ea1-c7ba-4304-bf41-3ac7411be99e	ocean_expert_updated	2017-12-31T00:00:00+01:00	active
f095d567-31a4-47b7-a7a7-9fbaaf79a85f	48021ea1-c7ba-4304-bf41-3ac7411be99e	data_quality	Ocean Expert data	active
72c08c41-a846-4177-8224-17a9ef923aea	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	website	http://nodc-benin.odinafrica.org	active
5cf06531-3cba-4745-876e-427be9b236e7	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	email	crhob_centre@yahoo.fr	active
d9196b7f-d653-4e67-96a7-248a901b0c76	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	phone	+ 229 21317586	active
abea1c2e-496c-4cc9-adb3-6b3f68c91a83	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	fax	+ 229 21323671	active
7d3ebc0c-dddb-486d-95d4-61bf59bf16be	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	country	Benin	active
7995cf5d-20c0-4107-a0cc-51987b6c5350	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	country_code	23	active
203965c2-cfad-46c8-b27c-2773ea7c0f7c	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	acronym	CNDO CRHOB	active
e2a06eae-860c-44a5-88ac-a4dd33755287	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	institution_type	Research	active
f75e58ac-cd17-4c29-923e-523cac032dc6	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	activities	Design, develop, coordinate, execute and control national programs for fisheries and ocean research.<br>Identify and define problems whose resolution requires action of research and training in the science of the sea and adjacent coastal areas.<br>Promote all technologies and all the features that contribute to development through the enhancement of the aquatic environment.<br>Centralise data, promote the exchange, publication and dissemination of fisheries and ocean research and make recommendations for these purposes.<br>Provide information and popularisation of science and technology in different social, cultural and professional circles concerned.<br>Participate in the development and implementation of regional and international fisheries and ocean research consistent with national development objectives.<br>Realise research, production, expertise or advice in its fields of competence for the benefit of external public or private partners.<br>||NODC||<br>	active
f30160c3-3532-4560-a629-be0ba9f40a24	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	ocean_expert_updated	2020-08-13T00:00:00+02:00	active
2fd9e772-168c-44a6-a699-8eb13a257297	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	data_quality	Ocean Expert data	active
aafe9bf5-73f4-4889-8102-35cb034902fe	86a164b6-9f2b-486a-b5c3-6435267a18c6	website	https://en.ug.edu.pl/uniwersytet/struktura_ug/faculty_oceanography_and_geography/institute_oceanography/division_marine_biology_and_ecology	active
5eca81d8-967d-47ae-a660-c3387001fb08	86a164b6-9f2b-486a-b5c3-6435267a18c6	country	Poland	active
8fbabd00-7753-427c-9ece-cbd8858d5bb7	86a164b6-9f2b-486a-b5c3-6435267a18c6	country_code	172	active
37604af2-9654-4fff-a7ad-52e96cce1cf6	86a164b6-9f2b-486a-b5c3-6435267a18c6	institution_type	Academic	active
d4995fff-2ecb-43f0-a3b8-bc45b08bbb88	86a164b6-9f2b-486a-b5c3-6435267a18c6	ocean_expert_updated	2018-08-08T00:00:00+02:00	active
62056836-155d-4ee4-afe0-f279a16a5f48	86a164b6-9f2b-486a-b5c3-6435267a18c6	data_quality	Ocean Expert data	active
8c2e8097-82ad-4b16-96a4-a75217791d40	5c164465-cecd-4316-a815-cf15782ff02e	data_quality	OBIS data only	active
07c7608c-d3bb-42d5-9412-baa299fc2643	39436356-5c3a-4585-908f-787060c070a0	website	https://www.rijkswaterstaat.nl/over-ons/onze-organisatie/organisatiestructuur/water-verkeer-en-leefomgeving/	active
9b095f11-6be8-46f6-9129-5019fe12a251	39436356-5c3a-4585-908f-787060c070a0	email	informatiepuntwvl@rws.nl	active
b1b53fe4-a849-44bf-8795-62ce9cd052e9	39436356-5c3a-4585-908f-787060c070a0	phone	088 797 71 02 	active
c62c6284-e404-4ed6-96eb-2ec97d78b097	39436356-5c3a-4585-908f-787060c070a0	country	Netherlands (Kingdom of the)	active
7b3ca834-2421-4c3d-9d29-751c4b2907f3	39436356-5c3a-4585-908f-787060c070a0	country_code	151	active
ff93bfd9-be3f-41a0-b236-c4c748bae4a8	39436356-5c3a-4585-908f-787060c070a0	acronym	RWS WVL	active
228ca5c3-4456-4489-b246-1778997c12e3	39436356-5c3a-4585-908f-787060c070a0	institution_type	Government	active
a5a2d9ed-46a6-4439-944b-ff5458822d00	39436356-5c3a-4585-908f-787060c070a0	ocean_expert_updated	2018-08-17T00:00:00+02:00	active
55b06af7-375c-4860-bc3d-08998f77806f	39436356-5c3a-4585-908f-787060c070a0	data_quality	Ocean Expert data	active
b1721d0d-cc08-4919-aac8-0fe630078e63	a4b0d8f0-748f-45b4-bc42-4df697153b3e	website	http://www.ketos.sicily.it	active
c78cd142-9846-4fc9-93f7-4b45d0d7bccb	a4b0d8f0-748f-45b4-bc42-4df697153b3e	email	info@ketos.sicily.it	active
8a561609-b11c-4a83-a372-652d2a0b5e0f	a4b0d8f0-748f-45b4-bc42-4df697153b3e	phone	 +39 3474086749	active
5bc54a22-f3be-4062-89c1-4cae45eb7164	a4b0d8f0-748f-45b4-bc42-4df697153b3e	country	Italy	active
be2051c6-2f15-4c90-9ede-7f656260999f	a4b0d8f0-748f-45b4-bc42-4df697153b3e	country_code	106	active
53101995-0edb-448a-a09e-b78ab7ba1192	a4b0d8f0-748f-45b4-bc42-4df697153b3e	institution_type	NGO	active
932815a3-68e1-40ff-84bc-8ff041008d1e	a4b0d8f0-748f-45b4-bc42-4df697153b3e	activities	<p>L’Associazione KETOS, è un ente culturale e scientifico senza scopi di lucro, costituito da ricercatori volontari. Nata dall’amore dei suoi fondatori nei confronti del mare e della Cetofauna che lo popola, mira ad approfondirne la conoscenza in ambito territoriale, stimolando l’interesse accademico nei loro confronti e promuovendone il rispetto e la tutela.</p><p>Le attività di ricerca della KETOS si svolgono nel Mar Mediterraneo meridionale e principalmente nel Mar Ionio occidentale, lungo le coste siciliane. Diversi, negli anni, sono stati i progetti di ricerca, di divulgazione e di educazione ambientale, svolti anche in collaborazione con enti pubblici e privati e con varie Università.</p><p>I risultati di studi condotti su differenti specie di Cetacei sono stati pubblicati in sede nazionale ed internazionale. I temi ecologici ed ambientali sono argomenti affrontati e trattati dalla KETOS costantemente, al fine di proseguire i suoi studi nel promulgare la conservazione della Cetofauna marina.</p>	active
c7c1c523-a5c7-41c1-8f24-2182d58b2990	a4b0d8f0-748f-45b4-bc42-4df697153b3e	ocean_expert_updated	2020-06-24T00:00:00+02:00	active
07c2523c-f47b-40cd-805b-2ce023489e67	a4b0d8f0-748f-45b4-bc42-4df697153b3e	data_quality	Ocean Expert data	active
ab1734a5-8bc7-498f-89d9-749618f0571b	d780d7e8-a438-400e-bc62-fd2d5e8b1084	website	https://www.dekamer.org.tr/index-eng.html	active
8dc6fb35-b621-4b1a-9c28-c98bccc1430c	d780d7e8-a438-400e-bc62-fd2d5e8b1084	email	dekamerturkey@gmail.com	active
6459138c-6328-4cbf-9816-2ccf19ebe3f9	d780d7e8-a438-400e-bc62-fd2d5e8b1084	phone	+90252 289 0077	active
3960a821-ebf8-4c3a-92c9-f8caf8c6338f	d780d7e8-a438-400e-bc62-fd2d5e8b1084	country	Türkiye	active
e4c5dac4-9561-4f56-8ade-0b5bbdf613a9	d780d7e8-a438-400e-bc62-fd2d5e8b1084	country_code	215	active
c93ba8c3-e3bc-483b-b18c-b1735e53ba30	d780d7e8-a438-400e-bc62-fd2d5e8b1084	acronym	DEKAMER	active
9fb43006-7ccf-4c33-a581-dcf196930d87	d780d7e8-a438-400e-bc62-fd2d5e8b1084	institution_type	Research	active
5e8c6911-af28-459f-9cab-c77bac4d8153	d780d7e8-a438-400e-bc62-fd2d5e8b1084	activities	<span>DEKAMER is carring out conservation projects and scientific studies on sea turtle nesting beaches beside rehabilitation studies.</span>	active
15408dac-898d-4851-a579-24b324a08f10	d780d7e8-a438-400e-bc62-fd2d5e8b1084	ocean_expert_updated	2020-08-10T00:00:00+02:00	active
0487db8e-29a0-407e-9d65-4b0999352d16	d780d7e8-a438-400e-bc62-fd2d5e8b1084	data_quality	Ocean Expert data	active
a2078529-f55d-4b75-a3c4-07bfa00d1b37	cae477f4-9d6d-45d3-bfc7-b5f10ad444f2	website	http://kintama.com/	active
ab1fa875-e9db-45c7-b5ad-8b637152e5fc	cae477f4-9d6d-45d3-bfc7-b5f10ad444f2	email	info@kintama.com	active
208b2875-e1b3-4e28-a507-21386c675b9a	cae477f4-9d6d-45d3-bfc7-b5f10ad444f2	phone	+1-250-729-2600	active
d81318ac-1e0e-4225-8e3a-f8d7f4e8a9f1	cae477f4-9d6d-45d3-bfc7-b5f10ad444f2	country	Canada	active
72cfc93d-74ac-441f-a4fb-d4fc29d6855f	cae477f4-9d6d-45d3-bfc7-b5f10ad444f2	country_code	39	active
8416388e-7e12-474d-90ef-ea6010f03fd4	cae477f4-9d6d-45d3-bfc7-b5f10ad444f2	institution_type	Research	active
9f460f1a-3629-4d3a-8d51-598125c987f7	cae477f4-9d6d-45d3-bfc7-b5f10ad444f2	ocean_expert_updated	2018-08-08T00:00:00+02:00	active
1b8d8caa-cce0-4287-968e-1af74ac73fa0	cae477f4-9d6d-45d3-bfc7-b5f10ad444f2	data_quality	Ocean Expert data	active
857db37b-8325-4845-8559-4fc49bbe4793	2c067a6e-ca86-4f79-af33-a945a4c36a22	website	http://www.cmfri.org.in	active
152cdf65-254d-43e9-93d1-e68d4898e4c3	2c067a6e-ca86-4f79-af33-a945a4c36a22	email	director.cmfri@icar.gov.in	active
80cba353-c4d7-4244-938a-2a578dc9f5cc	2c067a6e-ca86-4f79-af33-a945a4c36a22	country	India	active
946a5a95-d598-407f-aed2-6d7da14d1552	2c067a6e-ca86-4f79-af33-a945a4c36a22	country_code	100	active
ce228b9a-ac4a-4031-a898-b94736072523	2c067a6e-ca86-4f79-af33-a945a4c36a22	acronym	CMFRI	active
0daf7786-ee79-4e07-b8be-3b3b6ecfbabc	2c067a6e-ca86-4f79-af33-a945a4c36a22	institution_type	Government	active
2fe054d2-f8b1-4750-a75b-604df2ff270b	2c067a6e-ca86-4f79-af33-a945a4c36a22	activities	Marine Fisheries Research	active
fff2d176-47dd-4db6-a04c-727383108f33	2c067a6e-ca86-4f79-af33-a945a4c36a22	ocean_expert_updated	2023-12-07T00:00:00+01:00	active
bd63be70-f0dd-44e3-bf3f-71930d48421a	2c067a6e-ca86-4f79-af33-a945a4c36a22	data_quality	Ocean Expert data	active
5c70d7f7-33e7-40c3-a135-b85a29e1da31	4a33f4a4-578c-428a-9c69-e8a5aa3ec214	website	https://ocean.ru/en/index.php?option=com_k2&view=item&id=78:laboratory-of-plankton-communities-structure-and-dynamics&Itemid=142	active
b7f60ea4-b264-433b-b35d-b9faea44e382	4a33f4a4-578c-428a-9c69-e8a5aa3ec214	email	alv@ocean.ru	active
85a9a7b9-c331-4a07-afb2-b3b305af8346	4a33f4a4-578c-428a-9c69-e8a5aa3ec214	country	Russian Federation	active
375caa63-3383-4a81-9426-0b54a3c385cd	4a33f4a4-578c-428a-9c69-e8a5aa3ec214	country_code	178	active
8394e55f-1e3c-4b13-936e-027f4e27ee5b	4a33f4a4-578c-428a-9c69-e8a5aa3ec214	acronym	IORAS	active
d6e9f036-35ea-44bd-b6ec-b4e62ddca9fd	4a33f4a4-578c-428a-9c69-e8a5aa3ec214	institution_type	Research	active
3a0ce58c-03b3-4581-af27-e8484f0f63a2	4a33f4a4-578c-428a-9c69-e8a5aa3ec214	ocean_expert_updated	2018-08-13T00:00:00+02:00	active
ec2cb8f1-a68c-47a2-a74e-09531d7532d6	4a33f4a4-578c-428a-9c69-e8a5aa3ec214	data_quality	Ocean Expert data	active
b0b12436-da04-4e04-aaa2-d08baf0efbf0	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	website	https://www.wmu.se/	active
b25e3efc-5ee3-4b7b-8d7c-0598f3390d52	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	email	info@wmu.se	active
47b1a4c9-2fef-47c0-a8ac-6a7bc539a318	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	phone	+46 40 35 63 00	active
ad5f2726-b44f-469a-a2b2-960fa0903b96	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	fax	+46 40 35 63 10	active
a7aab517-2f74-4d0d-b7fc-d93fb7a1a77e	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	country	Sweden	active
81b74ab3-4e17-4a55-8dd7-3a7477913c03	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	country_code	204	active
4a823cb6-2692-4814-bf93-8faf376a0f64	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	acronym	WMU	active
7bc39e12-aa6b-4195-a4b5-d4c9ea5c5fca	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	institution_type	Academic	active
1726b81b-3c14-45e5-9040-556f64048569	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	activities	<p>The World Maritime University (WMU) in Malmö, Sweden is a postgraduate maritime university founded in 1983 by the International Maritime Organization (IMO), a specialized agency of the United Nations.&nbsp;</p><p>The aim of WMU is to further enhance the objectives and goals of IMO and IMO member States around the world through education, research, and capacity building to ensure safe, secure, and efficient shipping on clean oceans.&nbsp;WMU is truly an organization by and for the international maritime community.&nbsp;</p><p>The University operates on the basis of a Charter adopted by the IMO Assembly, and is accountable to the IMO Secretary-General, Council and Assembly, and to an international Board of Governors composed of representatives of some 50 different governmental, industry, labour and educational bodies. The University presents its annual report and budget to the IMO Council and also reports to the biennial session of the IMO Assembly. WMU receives the status, privileges and immunities of a UN institution in Sweden, and WMU degrees are recognized by the Swedish Ministry of Education and Research.</p>	active
7e73369c-6c72-424c-8541-381ca7033dc1	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	ocean_expert_updated	2018-08-02T00:00:00+02:00	active
41b959ef-34d8-4873-9177-c8b0e77ed828	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	data_quality	Ocean Expert data	active
a5e7af0d-0ce0-432b-bd4a-015836299a91	b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	website	www.artoo.co.uk	active
4debc9fb-a88a-4557-9c58-8bb095bd3543	b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	email	enquires@artoo.co.uk	active
8e99fe27-878e-4934-a56a-ed0dfa1d30a8	b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	phone	+44 (0) 23 8082 9763	active
71fc5c6f-ac56-4697-9fb3-f006776d31d6	b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	fax	+44 (0) 23 8063 5000	active
0ad9c92f-9fc9-455c-b4e0-e7a7e1e89653	b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	country	United Kingdom of Great Britain and Northern Ireland	active
83ccde54-5d4b-495b-9d6d-a316711ad6ed	b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	country_code	222	active
19ac0f07-a734-401f-bd22-3c65df8aab8c	b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	institution_type	Private commercial	active
45c5608b-290b-4b6f-a801-b5a380e02525	b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	ocean_expert_updated	2018-06-29T00:00:00+02:00	active
5a6177d1-b8d4-4d46-a861-7659257de298	b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	data_quality	Ocean Expert data	active
41775f94-8f3c-4755-ada2-1236ee8a4641	efe098ee-f980-48fe-9967-a272a2089e34	website	http://discoverblue.org/	active
d2ba35b8-e238-4d50-a10a-c51fafbb3a64	efe098ee-f980-48fe-9967-a272a2089e34	email	info@discoverblue.org	active
ff8b2920-118c-46ca-bc8f-6fa0a620fd44	efe098ee-f980-48fe-9967-a272a2089e34	phone	050-3657-2664	active
1d961f9b-4657-4197-8593-0c20164fdd1a	efe098ee-f980-48fe-9967-a272a2089e34	country	Japan	active
5c037413-0602-4c58-8869-457220b00822	efe098ee-f980-48fe-9967-a272a2089e34	country_code	108	active
05bc4b78-1e36-4aa8-ae7d-112a5295268f	efe098ee-f980-48fe-9967-a272a2089e34	institution_type	Private non-profit	active
7e606756-9bc5-4442-b013-c461c0bc6a41	efe098ee-f980-48fe-9967-a272a2089e34	ocean_expert_updated	2018-08-17T00:00:00+02:00	active
dd6cfaf7-1716-4dd6-99c3-ff8a4bc5754e	efe098ee-f980-48fe-9967-a272a2089e34	data_quality	Ocean Expert data	active
9ad85e31-5483-44ca-a413-7bd4379de22d	5bec3a86-6382-4904-8a0a-9431a935c98b	country	Russian Federation	active
38e5e0af-e7d4-4df0-83f6-e9d0fe2cf0ab	5bec3a86-6382-4904-8a0a-9431a935c98b	country_code	178	active
15d0489d-d322-4d99-b318-2669924ab364	5bec3a86-6382-4904-8a0a-9431a935c98b	institution_type	Government	active
99768992-1434-4ad3-84b9-62b3ecc264ee	5bec3a86-6382-4904-8a0a-9431a935c98b	ocean_expert_updated	2021-06-05T00:00:00+02:00	active
443cd5bc-ce24-4663-84da-9841d75b3922	5bec3a86-6382-4904-8a0a-9431a935c98b	data_quality	Ocean Expert data	active
47d30cb1-8481-47d6-8ddb-cc2dc466af12	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	website	http://ola.icmyl.unam.mx	active
c14e5fb2-f075-4c03-99b4-80622b9215b4	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	email	cgreen@ola.icmyl.unam.mx	active
7fbf01b3-c342-4f75-a298-53a1d17ab94b	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	phone	52 669 9852845	active
529f370c-732f-41cb-95b4-1390bba9228e	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	fax	52 669 9813362	active
65963655-662f-4408-9c95-d3c4da205b08	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	country	Mexico	active
29156803-5a6f-4612-857b-73cc0d2f2e0b	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	country_code	139	active
4ac1efeb-8d22-45ce-bc7e-57babebf55de	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	acronym	UNAM	active
bc3b2595-6a14-496c-bd98-d5e74cc83cd5	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	institution_type	Academic	active
9a1486eb-9495-4b96-acab-a78c98169c4e	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	activities	The Institute for Marine Sciences and Limnology is an academic institution dealing on several marine and limnological aspects on the field of biology, chemistry, physics and geology.	active
c1e86822-c808-4acf-b704-39da0c9242e2	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	ocean_expert_updated	2018-08-17T00:00:00+02:00	active
f896473d-239b-46d2-8955-2063227076d5	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	data_quality	Ocean Expert data	active
c6bd818c-990b-4a31-9539-5446a48a57e7	70f6ad5f-a716-491d-9fdf-b2d87bf73ba0	website	https://www.univie.ac.at/en/	active
509d544a-c8f2-42e6-9892-7b1246be7187	70f6ad5f-a716-491d-9fdf-b2d87bf73ba0	country	Austria	active
21099e15-8d8c-4b55-9e99-c55002c1320d	70f6ad5f-a716-491d-9fdf-b2d87bf73ba0	country_code	14	active
db640c55-ffb7-4051-871a-17e234da2f03	70f6ad5f-a716-491d-9fdf-b2d87bf73ba0	institution_type	Academic	active
9a17ff2a-731f-4255-a249-b1f112e774bd	70f6ad5f-a716-491d-9fdf-b2d87bf73ba0	ocean_expert_updated	2018-08-17T00:00:00+02:00	active
16191a7a-50c3-4b4e-a668-81b90ce5d383	70f6ad5f-a716-491d-9fdf-b2d87bf73ba0	data_quality	Ocean Expert data	active
e7d2d094-d962-4e8e-adfa-87a3fb8834fd	596933a1-a00e-44b1-b9a9-7c223faa26d4	website	http://www.ansp.org/	active
4d6d2f37-1d18-437b-80d3-bd7aa270af67	596933a1-a00e-44b1-b9a9-7c223faa26d4	phone	215-299-1000 	active
3e1a9e6e-dc09-4229-9e11-69c24f1d2d2c	596933a1-a00e-44b1-b9a9-7c223faa26d4	fax	1-215-299-1079	active
feb2a1c9-fbad-42f1-a810-e7bb6a513d1b	596933a1-a00e-44b1-b9a9-7c223faa26d4	country	United States of America	active
81c35413-f731-49dd-a3df-d09669947a03	596933a1-a00e-44b1-b9a9-7c223faa26d4	country_code	223	active
a4fa7ce9-4042-450e-92b7-87e7acc77fe6	596933a1-a00e-44b1-b9a9-7c223faa26d4	acronym	ANSP	active
6d47e2df-c37a-432e-bba5-4a68f765576b	596933a1-a00e-44b1-b9a9-7c223faa26d4	institution_type	Research	active
eec78acf-88bf-4399-bbda-f2a731ac5c9d	596933a1-a00e-44b1-b9a9-7c223faa26d4	activities	The Academy of Natural Sciences, established in 1812, is the oldest natural science research institution and museum in the Americas. It's recognized internationally for its vast collections, research, exhibits, and educational programs. The Academy’s collection of over 17 million cataloged natural history specimens and artifacts is among the ten largest in the United States.	active
18e77f57-afd0-4d2d-b987-03094f1de9c6	596933a1-a00e-44b1-b9a9-7c223faa26d4	ocean_expert_updated	2010-05-18T00:00:00+02:00	active
dc20ce6c-e128-48c8-bfb4-e0bbddfdb58b	596933a1-a00e-44b1-b9a9-7c223faa26d4	data_quality	Ocean Expert data	active
c8ce6808-5acd-4451-8cc7-b306b2042fcd	cdc3b737-dc61-47f2-a64c-41e14d86ebd9	website	https://www.harvard.edu/	active
3d843c60-3a33-4bf0-8208-e00004badf2b	cdc3b737-dc61-47f2-a64c-41e14d86ebd9	country	United States of America	active
bfee1477-07d3-49d5-95ba-66cdfd753ba3	cdc3b737-dc61-47f2-a64c-41e14d86ebd9	country_code	223	active
b9bbd19a-3e3e-4213-9315-c70f8dab2a8a	cdc3b737-dc61-47f2-a64c-41e14d86ebd9	institution_type	Academic	active
9b922199-a736-4d5a-882b-3a53622f02c5	cdc3b737-dc61-47f2-a64c-41e14d86ebd9	ocean_expert_updated	2022-12-07T00:00:00+01:00	active
a83a73b1-6f4a-453d-8e91-cce26f8dd10d	cdc3b737-dc61-47f2-a64c-41e14d86ebd9	data_quality	Ocean Expert data	active
cb43e418-5882-4862-895e-bb11dabdb68a	14ce4c73-d741-4244-8616-6692f081937e	website	https://www.encana.com/	active
7bcc3da3-a9c5-4c15-8786-f4e4e8cb7571	14ce4c73-d741-4244-8616-6692f081937e	country	Canada	active
380bcc91-b77e-4838-8038-afe0e65c6a2e	14ce4c73-d741-4244-8616-6692f081937e	country_code	39	active
7f7966d6-b0aa-45fe-ad39-43cb71b97f8b	14ce4c73-d741-4244-8616-6692f081937e	institution_type	Private commercial	active
06777031-ae79-4897-8363-6a4f80e971ad	14ce4c73-d741-4244-8616-6692f081937e	ocean_expert_updated	2018-08-07T00:00:00+02:00	active
df8aae23-5508-49d3-b2a8-ebf857023d0b	14ce4c73-d741-4244-8616-6692f081937e	data_quality	Ocean Expert data	active
a79f5298-8c75-4d58-84d2-3c435781df90	5606193d-7fd1-43be-994c-4f50d1d6e574	website	www.uni.no	active
2c4f3284-2106-4925-ac26-4cec090d4574	5606193d-7fd1-43be-994c-4f50d1d6e574	email	post@uni.no	active
e8ce8bba-d1f6-4f66-9892-4a1bc2d6b3a6	5606193d-7fd1-43be-994c-4f50d1d6e574	phone	+4755 584975	active
47f6dbae-0a46-45d7-8e3c-bb4937da4893	5606193d-7fd1-43be-994c-4f50d1d6e574	country	Norway	active
5234c24f-e49a-44c4-a8f3-76eb05f06c62	5606193d-7fd1-43be-994c-4f50d1d6e574	country_code	161	active
caa2b650-c536-42ad-b13d-bfd2b60385cf	5606193d-7fd1-43be-994c-4f50d1d6e574	institution_type	Research	active
896a5f8c-5c75-4b44-ae25-2368f6a820a2	5606193d-7fd1-43be-994c-4f50d1d6e574	activities	large research institution, all disciplines	active
f420a953-c4b9-411a-bdc3-1768370b5c11	5606193d-7fd1-43be-994c-4f50d1d6e574	ocean_expert_updated	2011-09-09T00:00:00+02:00	active
40f2aeb8-118e-44c2-857d-d4ac38864d7c	5606193d-7fd1-43be-994c-4f50d1d6e574	data_quality	Ocean Expert data	active
02764870-9cb9-4f3b-b5b1-556569580bc4	99acce96-4964-4e91-a278-4041df40e9f6	website	https://bccm.belspo.be/about-us/bccm-ulc	active
2c507984-b4bf-44b3-aafc-6f7a02b3eebe	99acce96-4964-4e91-a278-4041df40e9f6	email	bccm.ulc@uliege.be	active
fd586346-f3fb-40a3-b603-71240af1d58f	99acce96-4964-4e91-a278-4041df40e9f6	phone	+32-(0)4-366 33 87	active
37947b54-355b-449e-9f0a-26e1a8b9a9d7	99acce96-4964-4e91-a278-4041df40e9f6	country	Belgium	active
55a57ae8-b10e-42ba-af73-a8d128a935f1	99acce96-4964-4e91-a278-4041df40e9f6	country_code	21	active
b7232e31-c84f-4c81-b9d9-b97ea01a8770	99acce96-4964-4e91-a278-4041df40e9f6	institution_type	Academic	active
69fb3e6c-f50e-428f-b406-49a7bfe098bb	99acce96-4964-4e91-a278-4041df40e9f6	activities	<p><small><b>BCCM/ULC is a small and dedicated public collection, currently containing one of the largest collections of documented (sub)polar cyanobacteria worldwide.</b></small></p><h2><small><b>The BCCM/ULC collection is hosted by the research unit InBios -&nbsp;</b></small><a target="_blank" rel="nofollow" href="http://labos.ulg.ac.be/cip/"><small><b>Centre for Protein Engineering</b></small></a><small><b>&nbsp;(the Unit) of the&nbsp;</b></small><a target="_blank" rel="nofollow" href="http://www.uliege.be/"><small><b>University of Liège</b></small></a><small><b>. The host Unit is very active in research projects concerning the cyanobacterial diversity, biogeography, and ecophysiology, with a focus on polar biotopes. The used approach is polyphasic, including the isolation of strains and culture-independent methods (Amplicon sequencing of the 16S rRNA gene, metagenomics, comparative genomics). The participation to field expeditions in the Antarctic and Arctic has enabled to collect samples from many polar locations. Furthermore, bloom-forming and toxin-producing cyanobacterial communities in Belgian lakes are studied. Moreover, taxonomic research is carried out by the host Unit to improve the classification of the cyanobacterial phylum. It is based on a polyphasic approach combining the morphological and molecular characterizations of the strains.</b></small><br></h2>	active
dcd54177-8a25-4681-b897-162b02da8803	99acce96-4964-4e91-a278-4041df40e9f6	ocean_expert_updated	2020-07-17T00:00:00+02:00	active
d9173c3d-a95c-4534-8749-d454ee37078a	99acce96-4964-4e91-a278-4041df40e9f6	data_quality	Ocean Expert data	active
265e6c5d-f8cc-4594-be4a-246e077c9fbd	7f842dd9-aa48-44d8-8384-4101244729da	country	United States of America	active
8f80d9a3-6b9d-4a5e-a525-0c2eebd6c84e	7f842dd9-aa48-44d8-8384-4101244729da	country_code	223	active
98d48887-4248-40b0-884b-92594e993d94	7f842dd9-aa48-44d8-8384-4101244729da	institution_type	Private non-profit	active
c2eaae56-daba-4873-a229-9e8107911379	7f842dd9-aa48-44d8-8384-4101244729da	ocean_expert_updated	2018-08-10T00:00:00+02:00	active
9deea76b-69be-4b16-8b5c-ed64b32c1feb	7f842dd9-aa48-44d8-8384-4101244729da	data_quality	Ocean Expert data	active
fe495f95-b77c-411e-a9f2-763e10187d99	bd1d27e6-96cc-4a97-92bd-384228885c83	website	https://associationchene.com	active
69d5f686-ea2d-49dc-bb9f-371611d0b692	bd1d27e6-96cc-4a97-92bd-384228885c83	email	cliniquechene@orange.fr	active
aa3af47e-77d3-4862-be74-9ae72498841d	bd1d27e6-96cc-4a97-92bd-384228885c83	phone	+33 2 35 96 06 54	active
6c223102-3465-4e96-8cdc-bc1306595d40	bd1d27e6-96cc-4a97-92bd-384228885c83	country	France	active
35d8f562-b69a-4b9f-83ff-bbc9989e47d3	bd1d27e6-96cc-4a97-92bd-384228885c83	country_code	74	active
fa4e3f67-5fc0-468b-92e2-b9d6a5ba051b	bd1d27e6-96cc-4a97-92bd-384228885c83	institution_type	Private commercial	active
375b29b1-de50-4b34-bd9e-35795fa0ecf3	bd1d27e6-96cc-4a97-92bd-384228885c83	activities	L’association CHENE – Centre d’Hébergement et d’Etude sur la Nature et l’Environnement&nbsp;<span>– agit depuis 1980 pour le respect et la défense de la faune sauvage. Ce nom a été donné en écho au chêne millénaire d’Allouville-Bellefosse, arbre patrimoine, situé à 2km de l’association. C’est une association loi 1901, agréée au titre de l’article L141-1 du code de l’environnement et membre fondateur de la fédération France Nature Environnement de Normandie</span>	active
a2866e2b-d6a4-47e1-8fc6-d770b7b2d60d	bd1d27e6-96cc-4a97-92bd-384228885c83	ocean_expert_updated	2020-06-24T00:00:00+02:00	active
9591e842-1590-4124-8894-3abda47ac257	bd1d27e6-96cc-4a97-92bd-384228885c83	data_quality	Ocean Expert data	active
bb6012ee-0661-49bc-a26a-dcadd0438b1e	e881e184-4253-4393-94b2-8ec4da61b63f	website	http://www.seasearch.org.uk/	active
1e9031bf-670d-4766-aaf9-a2770f68efd2	e881e184-4253-4393-94b2-8ec4da61b63f	email	info@seasearch.org.uk	active
98da0581-cd56-4094-88ad-073b04909d42	e881e184-4253-4393-94b2-8ec4da61b63f	phone	07776 142096	active
f7463750-dc21-49c8-a433-4f3d3b342ff6	e881e184-4253-4393-94b2-8ec4da61b63f	country	United Kingdom of Great Britain and Northern Ireland	active
e9bcbf7d-2611-4395-88b3-f45bd705b159	e881e184-4253-4393-94b2-8ec4da61b63f	country_code	222	active
b97398eb-a7f3-42f6-a188-4346ac6f981e	e881e184-4253-4393-94b2-8ec4da61b63f	institution_type	Research	active
91a6a188-b0f6-420b-91a2-f6c72d6c4a32	e881e184-4253-4393-94b2-8ec4da61b63f	ocean_expert_updated	2018-08-09T00:00:00+02:00	active
a7018b1a-814b-4ab0-9a59-b2460187b874	e881e184-4253-4393-94b2-8ec4da61b63f	data_quality	Ocean Expert data	active
251f4b10-c0e5-41fe-99fe-69e048f22bf0	e4df8c0d-98c5-4788-96b3-1c10c9d91209	country	Canada	active
32e65ac8-4926-4465-b3ed-79ed7350bb8f	e4df8c0d-98c5-4788-96b3-1c10c9d91209	country_code	39	active
dffc52b4-ca14-41cc-b48f-3ac4f7ed49a1	e4df8c0d-98c5-4788-96b3-1c10c9d91209	institution_type	Government	active
e9629b34-caae-4ccd-b9e0-a81a1d5fb0fe	e4df8c0d-98c5-4788-96b3-1c10c9d91209	activities	now closed	active
40bfb20a-4c16-49f8-9798-147949d2a296	e4df8c0d-98c5-4788-96b3-1c10c9d91209	ocean_expert_updated	2018-08-17T00:00:00+02:00	active
9d0fd318-5a40-429e-a8a3-8165383abd0e	e4df8c0d-98c5-4788-96b3-1c10c9d91209	data_quality	Ocean Expert data	active
1bf1ec65-2ebc-4811-b37f-e4d3dbbad9e5	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	website	http://www.obs-banyuls.fr/	active
fdcab401-985c-406e-82e8-d08a20ad9cb3	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	email	accueil@obs-banyuls.fr	active
a58e317d-3d92-4281-8488-426e19e24e84	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	phone	+33 4 68 88 73 73	active
61864f99-1e66-4af0-8b9a-aa02d068d0b1	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	fax	+33 0 68 887395	active
22ca6ffb-d926-44a0-9a7c-b7093f091a7f	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	country	France	active
f058f66d-46c4-4fc5-8415-fb093101bbe3	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	country_code	74	active
854b441f-ec1d-4d69-a815-cddbbbe4c1e5	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	acronym	CNRS - OOB	active
5f57fd78-4369-41d0-934c-c5dcdd72a792	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	institution_type	Academic	active
8cf477bf-c169-4504-86f6-cee79fe6a8c2	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	activities	Le Centre de recherche en biodiversité et biotechnologies marines verra le jour d’ici 2014 au sein du Laboratoire Arago dirigé par le Professeur Philippe Lebaron. Ce projet de 11 millions d'euros H.T. sera financé par les Laboratoires Pierre Fabre, l'Etat, la Région, le Département, la Communauté des communes, la Commune de Banyuls, l'Université Pierre et Marie Curie-UPMC, l'Université de Perpignan, le CNRS et l'Institut National des Sciences de l'Univers.<br>Ce projet original de partenariat public privé regroupera des activités de recherche, de formation et de diffusion des connaissances scientifiques dans le domaine de la biodiversité marine et de l’écologie..	active
13e10068-78eb-46d4-b813-88306d2f3299	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	ocean_expert_updated	2017-10-25T00:00:00+02:00	active
af4f3363-9e64-43dc-867b-28f53bcb8c5a	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	data_quality	Ocean Expert data	active
2886e2b4-dab3-4986-8c22-b283a17d211d	76bac861-e7d0-44fe-b34d-fed4e5b5d665	ocean_expert_id	13684	active
a6b7fc38-a8e9-4565-bf3c-eb85cb5fdbb0	76bac861-e7d0-44fe-b34d-fed4e5b5d665	website	www.ird.fr	active
d435dbc3-6a77-4a73-a2d9-c871bb9b3cd0	76bac861-e7d0-44fe-b34d-fed4e5b5d665	phone	33 2 98 22 4394	active
e2f7fa7d-0b3b-4173-b86a-64b0c0d5de69	76bac861-e7d0-44fe-b34d-fed4e5b5d665	country	France	active
11875dea-7e3e-4aad-ad26-4390f612be94	76bac861-e7d0-44fe-b34d-fed4e5b5d665	country_code	74	active
4e4b8ae7-d5ea-465e-8691-11fe8e36135c	76bac861-e7d0-44fe-b34d-fed4e5b5d665	acronym	IRD	active
705557ed-5760-4779-9ba6-24718c351aac	76bac861-e7d0-44fe-b34d-fed4e5b5d665	institution_type	Government	active
4cb2fe6f-adaa-462b-a145-ad1055ba5633	76bac861-e7d0-44fe-b34d-fed4e5b5d665	activities	The IRD is a unique institution in the landscape of European research for development. Its task is to conduct research in the South, for the South, with the South.\r\n\r\nIts researchers are working on issues of major global importance today: global warming, emerging diseases, biodiversity, access to water, migration, poverty, world hunger. The teaching and training they provide empowers and enables Southern scientific communities.	active
8238947d-0f98-4de4-9562-7885e2ce77f8	76bac861-e7d0-44fe-b34d-fed4e5b5d665	ocean_expert_updated	2011-09-09T00:00:00+02:00	active
664e0851-31e9-47c9-9792-5b270fbe8b0b	76bac861-e7d0-44fe-b34d-fed4e5b5d665	data_quality	Ocean Expert data	active
dd1ef24d-472a-4717-a1e4-3f92b58ae1da	04dc13a7-cad6-4295-97b6-5ba171cfc70f	website	http://www.ird.fr/	active
48912ec9-77a3-4d9c-9641-63f725b78228	04dc13a7-cad6-4295-97b6-5ba171cfc70f	email	cecile.dupouy@ird.fr	active
3c7eaab5-674a-4999-b99b-f7d547d27db3	04dc13a7-cad6-4295-97b6-5ba171cfc70f	phone	687 26 07 29	active
691d4326-8cfd-4a5f-b013-0ad5b3af5377	04dc13a7-cad6-4295-97b6-5ba171cfc70f	fax	687 26 43 26	active
850e251f-27ff-48bc-80c3-ef8ddb8328df	04dc13a7-cad6-4295-97b6-5ba171cfc70f	country	France	active
b25ce7e1-4cc6-44c3-93d5-e746499cbeae	04dc13a7-cad6-4295-97b6-5ba171cfc70f	country_code	74	active
4c5b671d-19d3-4bf0-b764-0617620d2dea	04dc13a7-cad6-4295-97b6-5ba171cfc70f	acronym	IRD	active
c019ffb4-e4ce-4b17-8a6f-1f2366539edf	04dc13a7-cad6-4295-97b6-5ba171cfc70f	institution_type	Government	active
39a14239-4e80-4803-8879-09f3c9c002e6	04dc13a7-cad6-4295-97b6-5ba171cfc70f	activities	The IRD (Institut de recherche pour le développement) is a French research organisation, original and unique on the European development research scene. Emphasizing interdisciplinarity, the IRD has focused its research for over 65 years on the relationship between man and its environment, in Africa, Mediterranean, Latin America, Asia and the French tropical overseas territories.  Its research, training and innovation activities are intended to contribute to the social, economic and cultural development of southern countries.\n	active
6859463f-8623-40af-99b1-c04ce26a72ee	04dc13a7-cad6-4295-97b6-5ba171cfc70f	ocean_expert_updated	2016-07-25T00:00:00+02:00	active
4de4c528-2f8b-458c-812c-f45cf975e822	04dc13a7-cad6-4295-97b6-5ba171cfc70f	data_quality	Ocean Expert data	active
4b4f47e5-7ebe-46ed-8916-e84a27f39045	51ce9950-fab6-4e3b-a5b6-a545ec5f21f6	website	https://unc.nc	active
529a56c0-aaa5-45c6-8304-618fddbebb14	51ce9950-fab6-4e3b-a5b6-a545ec5f21f6	country	New Caledonia	active
dbf92f49-c878-4ac4-afaf-271398e24273	51ce9950-fab6-4e3b-a5b6-a545ec5f21f6	country_code	153	active
b88b0298-c8c0-49b9-9b84-0852a74ace69	51ce9950-fab6-4e3b-a5b6-a545ec5f21f6	institution_type	Academic	active
938bb9cf-9c62-4214-99c0-4419bbdeda33	51ce9950-fab6-4e3b-a5b6-a545ec5f21f6	ocean_expert_updated	2018-08-13T00:00:00+02:00	active
2ddea410-a809-4bce-b2f2-99da47190693	51ce9950-fab6-4e3b-a5b6-a545ec5f21f6	data_quality	Ocean Expert data	active
41a72311-cb9c-4d0c-bc1e-927d5c722c9f	3cb1ecc3-11b3-4fec-8462-0ad21bda2969	website	https://www.bmt.org	active
349972a2-f1d2-465d-87e9-97962c3cb085	3cb1ecc3-11b3-4fec-8462-0ad21bda2969	email	defence-security@bmtglobal.com	active
947f6fb8-b9f8-4fe0-9073-2420d18f3710	3cb1ecc3-11b3-4fec-8462-0ad21bda2969	phone	+61 8 8614 3402	active
e17e093d-ffb3-4e5c-bffe-09382ee60261	3cb1ecc3-11b3-4fec-8462-0ad21bda2969	country	Australia	active
fa0f8154-488a-474f-bb7e-2b10e2bec49c	3cb1ecc3-11b3-4fec-8462-0ad21bda2969	country_code	13	active
28158d33-f75c-40fd-b202-c27e36cff99b	3cb1ecc3-11b3-4fec-8462-0ad21bda2969	institution_type	Private non-profit	active
f89e6302-2dc1-4a71-84ce-9d24ad3d8673	3cb1ecc3-11b3-4fec-8462-0ad21bda2969	activities	<span>We support clients at every stage of the project lifecycle with a wide range of high-quality products and services, all backed by our expertise across sectors, geographies and disciplines<br><br></span><p>BMT provides engineering and scientific services and solutions to industry, commerce, policy makers, regulators and public sector operators.</p><br>	active
458eec2e-547e-4974-ac3e-123accbbb45d	3cb1ecc3-11b3-4fec-8462-0ad21bda2969	ocean_expert_updated	2020-07-20T00:00:00+02:00	active
c82d135f-e638-41d8-aa5f-0a31cd016bbe	3cb1ecc3-11b3-4fec-8462-0ad21bda2969	data_quality	Ocean Expert data	active
a83e1b67-2bc8-455c-9e30-83ace3a5db51	08261c43-f1a0-48ce-81fa-3a83731349b1	website	http://www.cawthron.org.nz	active
7a66f435-491a-4e10-899d-1e25f968a59e	08261c43-f1a0-48ce-81fa-3a83731349b1	email	info@cawthron.org.nz	active
8d024789-68e6-4591-a7e0-302be0771254	08261c43-f1a0-48ce-81fa-3a83731349b1	phone	+64 3548 2319	active
a0f445cf-d4f7-41a1-9f74-22498dbd8962	08261c43-f1a0-48ce-81fa-3a83731349b1	fax	+64 3 546 9464	active
83d53de1-c857-4870-be81-4c30326fdb4a	08261c43-f1a0-48ce-81fa-3a83731349b1	country	New Zealand	active
0b53dcc7-c126-4255-864c-aeabda517c70	08261c43-f1a0-48ce-81fa-3a83731349b1	country_code	154	active
d0b26b84-b854-4730-b66a-d44bde5c32a9	08261c43-f1a0-48ce-81fa-3a83731349b1	institution_type	Research	active
356808c1-a9de-4990-87e7-ea1ccc0bedc8	08261c43-f1a0-48ce-81fa-3a83731349b1	activities	<p>Cawthron Institute is New Zealand's largest independent science organisation, offering a broad spectrum of services to help protect the environment and support sustainable development of primary industries.</p><p>Based in the Nelson region, we work with regional councils, government departments, major industries, private companies, and other research organisations throughout New Zealand and around the world.&nbsp;</p><p>Cawthron is a diverse organisation employing almost 200 scientists, laboratory technicians, researchers and specialist staff from more than 20 different countries.</p>	active
1b6cd10f-0549-4e89-b6f3-583b997dc7b2	08261c43-f1a0-48ce-81fa-3a83731349b1	ocean_expert_updated	2020-07-22T00:00:00+02:00	active
1e255507-dbbc-422e-9233-12ce3121975f	08261c43-f1a0-48ce-81fa-3a83731349b1	data_quality	Ocean Expert data	active
dac8959c-cdaa-45f1-a2b3-612d4ff56497	453386c3-3c95-4211-922c-6205eedf7506	website	https://www.asu.edu/	active
09ef9295-bd90-4d70-b6b7-93b2ccdc5a58	453386c3-3c95-4211-922c-6205eedf7506	phone	+1 (855) 278-5080	active
9fa2c75a-1b1a-45b8-8dc8-992c82ec02b5	453386c3-3c95-4211-922c-6205eedf7506	country	United States of America	active
5609f70e-912a-4a1b-820a-cd70ba659ce0	453386c3-3c95-4211-922c-6205eedf7506	country_code	223	active
6ade04cc-a099-4eb7-a47c-b302be91c7fd	453386c3-3c95-4211-922c-6205eedf7506	acronym	ASU	active
d324a7be-c8f7-4e62-87ff-e8f8985c5216	453386c3-3c95-4211-922c-6205eedf7506	institution_type	Academic	active
2bfbc8d2-1d32-495f-9bf6-cf89428567e4	453386c3-3c95-4211-922c-6205eedf7506	ocean_expert_updated	2020-06-23T00:00:00+02:00	active
dc8ccbcf-cef3-43c8-b99d-d2d6a8f3b33e	453386c3-3c95-4211-922c-6205eedf7506	data_quality	Ocean Expert data	active
d379f426-ac12-4ff5-960e-936e7ca881de	c7508cda-2d43-465e-9433-814f0b71d4a1	website	https://www-marine.stanford.edu/	active
e4b489e4-4e0e-4d57-96b4-1c10e33898f9	c7508cda-2d43-465e-9433-814f0b71d4a1	phone	(831) 655-6200	active
c0f5ecae-1b14-4bf0-88cf-c188f958c0e7	c7508cda-2d43-465e-9433-814f0b71d4a1	fax	(831) 375-0793 	active
d3037bab-9b02-4251-9e0a-6f27a17292eb	c7508cda-2d43-465e-9433-814f0b71d4a1	country	United States of America	active
d4437ab1-bd86-4392-ba89-ff0091f233e8	c7508cda-2d43-465e-9433-814f0b71d4a1	country_code	223	active
087c3322-4bc9-404c-bf3a-aa6005e1dcff	c7508cda-2d43-465e-9433-814f0b71d4a1	acronym	HMS	active
2c3ae47e-842a-4b78-a3d1-3158a8f9ba60	c7508cda-2d43-465e-9433-814f0b71d4a1	institution_type	Academic	active
840a04d1-19b9-4570-b106-b6228be3df6b	27d9eec0-70c2-41c8-b973-524a1fde24ad	country	Canada	active
0eb03911-c7b9-4b6f-bb54-0ca25177b9cb	27d9eec0-70c2-41c8-b973-524a1fde24ad	country_code	39	active
769b8136-cfe8-440a-b8c9-93d8de906703	c7508cda-2d43-465e-9433-814f0b71d4a1	activities	Aerial Image of Hopkins Marine StationThe Hopkins Marine Station, located 90 miles from the main University campus in Pacific Grove, was founded in 1892 as the first marine laboratory on the west coast of North America. The modern laboratory facilities on the 11-acre campus on Cabrillo Point house ten faculty, all members of the Department of Biology. The Miller Library has a collection of literature in marine science. The Hopkins faculty offers undergraduate and graduate courses in biology which focus on the marine realm and involve topics including oceanography, environmental and comparative physiology, molecular evolution, biomechanics, cellular biology, conservation biology, and neurobiology and behavior. Most courses have laboratory sections that exploit the potential of working with readily available marine plants and animals. Small class sizes encourage close student-faculty interactions. Undergraduates have opportunities to carry out research projects with Hopkins faculty during the academic year or summer months. Courses  are offered in Winter, Spring, and Summer quarters. Summer classes are open to non-Stanford students.	active
35fc0ab7-20e1-469b-ae3e-9fb610902801	c7508cda-2d43-465e-9433-814f0b71d4a1	ocean_expert_updated	2022-04-11T00:00:00+02:00	active
d1deb768-8ca2-4f72-9512-3d6346efb9fc	c7508cda-2d43-465e-9433-814f0b71d4a1	data_quality	Ocean Expert data	active
33e9b64f-dee2-482c-aa4c-744d9e9a9804	cf37b8d5-c6fe-456b-922d-70da288be1ab	country	Australia	active
6550ae99-6e23-4f70-b070-3a78e9a2de28	cf37b8d5-c6fe-456b-922d-70da288be1ab	country_code	13	active
75502f1e-ff97-43e3-8241-b52fc08117fe	cf37b8d5-c6fe-456b-922d-70da288be1ab	institution_type	NGO	active
1be59fa6-76ea-47f3-ab07-f9a26500cd92	cf37b8d5-c6fe-456b-922d-70da288be1ab	activities	<p>t’s officially the 2012 flatback nesting season and AusTurtle are doing their thing for sea turtle research on Bare Sand Island.</p><p>A large population of flatback sea turtles nest at Bare Sand Island during the winter months. During this time, researchers gather data on the nesting turtles to estimate population size, monitor abundance and to determine any threats to survival.</p><p>As well flatbacks, the waters around Bare Sand Island support significant numbers of foraging green and hawksbill turtles. Both species are vulnerable to extinction under Australian classification (EPBC Act 1999). Green turtles are internationally classified as endangered and hawksbill turtles are critically endangered internationally (IUCN Red List).</p><p>The Austurtle research commenced in 1996 and is supported by Charles Darwin University. The research project is run by Dr Michael Guinea</p>	active
ee3d5827-4361-4267-98f5-6be43e2a0eae	cf37b8d5-c6fe-456b-922d-70da288be1ab	ocean_expert_updated	2020-07-30T00:00:00+02:00	active
850db6f3-3709-44be-8221-55705d87d7ed	cf37b8d5-c6fe-456b-922d-70da288be1ab	data_quality	Ocean Expert data	active
4e0b83de-cd86-4212-b6c7-75dd2787159b	d7588e22-a304-411e-9dd4-7b5afbd6d5d0	website	https://www.canterburymuseum.com/	active
e7e1bcec-f8b3-4b10-98f6-43863f01d218	d7588e22-a304-411e-9dd4-7b5afbd6d5d0	phone	+64 3 366 5000 	active
2caff4fa-e27c-4d40-900d-a445c9d462cb	d7588e22-a304-411e-9dd4-7b5afbd6d5d0	country	New Zealand	active
53dbfd58-f4f9-4b63-a63f-c3cce1a3bed8	d7588e22-a304-411e-9dd4-7b5afbd6d5d0	country_code	154	active
c15016a0-1632-437f-b496-6c7a60462d4b	d7588e22-a304-411e-9dd4-7b5afbd6d5d0	institution_type	Private non-profit	active
9843da9b-f058-4d16-8c57-f78a694a9277	d7588e22-a304-411e-9dd4-7b5afbd6d5d0	activities	Visit and explore New Zealand's rich cultural and natural heritage. Learn about the past, present and future of Canterbury.	active
13c4260d-960b-4339-ba64-f9ddcc7f9439	d7588e22-a304-411e-9dd4-7b5afbd6d5d0	ocean_expert_updated	2020-07-22T00:00:00+02:00	active
933aff16-0cad-4ba5-8b71-f9d56e264091	d7588e22-a304-411e-9dd4-7b5afbd6d5d0	data_quality	Ocean Expert data	active
1b79785e-bce5-48ae-be4b-cd8b55a480a3	0ba5eb77-b00a-4890-8527-af723e8c50eb	website	http://www.mta.ca/faculty/science/bio/BIOSITE/index.html	active
3c0fbfea-57ef-44c5-aeb7-2f712a2be77b	0ba5eb77-b00a-4890-8527-af723e8c50eb	phone	+1 506-364-2500	active
8c5b5936-ba55-4a8b-af84-2d084cf2c8a5	0ba5eb77-b00a-4890-8527-af723e8c50eb	fax	+1 506-364-2505	active
e8074f63-71ed-4b86-a389-b3ec0d58358d	0ba5eb77-b00a-4890-8527-af723e8c50eb	country	Canada	active
c281de4d-75d0-4d62-8794-d43358d1ab51	0ba5eb77-b00a-4890-8527-af723e8c50eb	country_code	39	active
60b86d1a-94c3-42da-93bf-aa9581ae1ed0	0ba5eb77-b00a-4890-8527-af723e8c50eb	acronym	MTA	active
8116b6cc-00c9-403b-927a-3e9b4651cda7	0ba5eb77-b00a-4890-8527-af723e8c50eb	institution_type	Academic	active
ef0cb1c3-ca3e-4d30-92ce-e88a6d4aa75f	0ba5eb77-b00a-4890-8527-af723e8c50eb	ocean_expert_updated	2018-08-14T00:00:00+02:00	active
eb03dcb8-af99-4969-8f14-ad5715ced634	0ba5eb77-b00a-4890-8527-af723e8c50eb	data_quality	Ocean Expert data	active
a9bdd0c8-e8da-4bf8-afce-5bcbcc527e47	ce9241f6-12bf-4e79-a45a-e1b3715efe61	website	http://www.dtu.dk	active
9f8ab956-2c65-4b58-8c78-f9b9ae1d5b11	ce9241f6-12bf-4e79-a45a-e1b3715efe61	email	dtu@dtu.dk	active
a0e9dfa1-616b-4d52-bbeb-cca58359745f	ce9241f6-12bf-4e79-a45a-e1b3715efe61	phone	+45 45 25 25 25	active
7d69e851-43aa-40b5-902f-2e7b2921adcd	ce9241f6-12bf-4e79-a45a-e1b3715efe61	fax	+45 88 17 99	active
df42c26b-d09e-4c48-84bc-f8340957e4e5	ce9241f6-12bf-4e79-a45a-e1b3715efe61	country	Denmark	active
ac80b017-e2e9-4b25-9c26-90e6036680b5	ce9241f6-12bf-4e79-a45a-e1b3715efe61	country_code	58	active
b75188b0-5740-46d0-be3b-a440393d9284	ce9241f6-12bf-4e79-a45a-e1b3715efe61	acronym	DTU	active
8f45575b-5ea3-44a0-b12d-abc3261e2505	ce9241f6-12bf-4e79-a45a-e1b3715efe61	institution_type	Government	active
a30b9b38-ddea-46a9-920f-2c65c2d7d15f	ce9241f6-12bf-4e79-a45a-e1b3715efe61	ocean_expert_updated	2025-01-14T00:00:00+01:00	active
eaff389e-51ce-479a-b30b-93f5f0f6ff64	ce9241f6-12bf-4e79-a45a-e1b3715efe61	data_quality	Ocean Expert data	active
1099c3b2-0aee-4f1f-af5c-64c635cbaccf	41c1add6-fb64-4b6e-9774-dc8bf78f285c	website	https://www.mta.ca/	active
36235098-02e3-4d30-b2e3-3106d7c759ec	41c1add6-fb64-4b6e-9774-dc8bf78f285c	country	Canada	active
56cc63da-3970-49c7-9976-1824ce856b24	41c1add6-fb64-4b6e-9774-dc8bf78f285c	country_code	39	active
d4304dd6-438c-4b83-a27b-dc25b277e33d	41c1add6-fb64-4b6e-9774-dc8bf78f285c	acronym	MtA	active
f6e29e17-877c-4e20-8efb-f7be78dcc4c2	41c1add6-fb64-4b6e-9774-dc8bf78f285c	institution_type	Academic	active
a6b44989-1069-442a-853e-05b713176fcf	41c1add6-fb64-4b6e-9774-dc8bf78f285c	ocean_expert_updated	2018-08-14T00:00:00+02:00	active
58310530-39a5-463a-8928-0ed7b6b7e69c	41c1add6-fb64-4b6e-9774-dc8bf78f285c	data_quality	Ocean Expert data	active
f3b6703c-1c1e-4b24-875c-88ce95e05fcc	27d9eec0-70c2-41c8-b973-524a1fde24ad	institution_type	Academic	active
88e59771-d7c6-4e88-a3ad-9a0855b1188d	27d9eec0-70c2-41c8-b973-524a1fde24ad	ocean_expert_edmo_code	4385	active
2d8f3dd3-e2a0-4f75-b2c3-94b0217c1474	27d9eec0-70c2-41c8-b973-524a1fde24ad	ocean_expert_updated	2018-08-01T00:00:00+02:00	active
05a3bfb7-4482-4b69-903e-c088ec526585	27d9eec0-70c2-41c8-b973-524a1fde24ad	data_quality	Ocean Expert data	active
c2eaf2ea-8069-47a4-95a6-2078a03a5f02	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	website	https://www.iode.org	active
9f79f7c3-8831-438f-b796-7e7411d5866f	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	email	info@iode.org	active
cc6e6dbf-fe28-4d88-b997-ce643b80e41d	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	country	Belgium	active
cd957733-29e8-4fbd-a369-daa0bd5de1e2	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	country_code	21	active
e9d624af-5e03-4754-91f2-87f16d14e831	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	region	102	active
c45733b4-db0b-4a92-a963-851fec7223d4	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	acronym	IODE	active
4afa60e3-3acb-4e26-8c5e-59fdae7632ec	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	institution_type	International / Intergovernmental	active
d2240c5e-137d-4aac-9b6b-a45894671642	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	activities	The programme "International Oceanographic Data and Information Exchange" (IODE) of the "<a target="_blank" rel="nofollow" href="http://ioc-unesco.org">Intergovernmental Oceanographic Commission" (IOC)</a> of <a target="_blank" rel="nofollow" href="http://www.unesco.org">UNESCO</a>\r\n was established in 1961.<br>Its purpose is to enhance marine research, \r\nexploitation and development, by facilitating the exchange of \r\noceanographic data and information between participating Member States, \r\nand by meeting the needs of users for data and information products.<br><br><br><br>||OTGA RTC||	active
89095786-03d0-4386-b978-f295d04eb1f7	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	ocean_expert_updated	2025-05-09T00:00:00+02:00	active
aec2564f-cf46-4be2-bed3-faf337c94a16	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	data_quality	Ocean Expert data	active
729973c2-6635-4c0a-b29b-0c657ec96950	76c01c2d-3f19-427b-b102-c3e2c00ca822	website	http://www.issha.org/index.php	active
76f71c93-455a-4463-80ea-a07e524f8905	76c01c2d-3f19-427b-b102-c3e2c00ca822	email	h.enevoldsen@unesco.org	active
c119380a-89a4-47ea-8a97-0d01918d2bf3	76c01c2d-3f19-427b-b102-c3e2c00ca822	country	Denmark	active
639d4ed7-a559-4ace-b947-03ae4bf1dc29	76c01c2d-3f19-427b-b102-c3e2c00ca822	country_code	58	active
6125905d-3fba-46e5-8d2b-487dc828ee9e	76c01c2d-3f19-427b-b102-c3e2c00ca822	acronym	ISSHA	active
08622941-d43a-4062-8f2e-63c6ff401125	76c01c2d-3f19-427b-b102-c3e2c00ca822	institution_type	NGO	active
72044ecd-7471-400e-a75c-378d956a3d8a	76c01c2d-3f19-427b-b102-c3e2c00ca822	activities	<span>The International Society for the Study of Harmful Algae (ISSHA) was founded in 1997, in response to a request from the Intergovernmental Oceanographic Commission (IOC) of UNESCO for an international programme o­n harmful algae. The Society is affiliated to the ICSU family of organizations as a constituent part of the International Union of Biological Sciences (IUBS) through the International Association of Biological Oceanography (IABO). The overall mandate of the Society is to promote and foster research and training programs o­n harmful algae, and to co-sponsor meetings o­n this topic at the national, regional, and international level.<br></span><br>For more information, contact any of the&nbsp;<a target="_blank" rel="nofollow" href="http://www.issha.org/Contact-us">officers of ISSHA</a><br>	active
84bccfab-cf07-4e71-8c41-832bcf3f5599	76c01c2d-3f19-427b-b102-c3e2c00ca822	ocean_expert_updated	2017-06-12T00:00:00+02:00	active
1e5c0298-b9fe-4fd2-b594-2abf2f2d681e	76c01c2d-3f19-427b-b102-c3e2c00ca822	data_quality	Ocean Expert data	active
7276b4b7-934d-499a-b691-669f5384be5d	2e9a7a6a-01c2-45bc-aa9c-4d46323456bb	website	https://www.nio.org/departments/regional-centers/csirnio-rc-kochi	active
a7b311ac-c24e-490a-a4f8-6772170c8459	2e9a7a6a-01c2-45bc-aa9c-4d46323456bb	country	India	active
3413200e-f59d-4c9d-b89e-3010d022d6fa	2e9a7a6a-01c2-45bc-aa9c-4d46323456bb	country_code	100	active
63d4754f-4839-48a8-9330-1c61ad2f6328	2e9a7a6a-01c2-45bc-aa9c-4d46323456bb	acronym	CSIR-NIO	active
b62e7315-5331-46bb-b78e-619bfdde7a65	2e9a7a6a-01c2-45bc-aa9c-4d46323456bb	institution_type	Research	active
51d59d00-f7ed-4140-898a-d3b281010620	2e9a7a6a-01c2-45bc-aa9c-4d46323456bb	ocean_expert_updated	2020-04-22T00:00:00+02:00	active
b60fa758-163c-4a15-901b-43748531a669	2e9a7a6a-01c2-45bc-aa9c-4d46323456bb	data_quality	Ocean Expert data	active
710e71ed-9081-465c-a915-7e896c4cd95e	a982727a-c8b0-4c06-bc58-522c2d67dbcc	website	https://www.turtle.ky	active
ed3a9b26-0f2d-4c5b-9b40-d28ed6ab42e8	a982727a-c8b0-4c06-bc58-522c2d67dbcc	email	 info@turtle.ky	active
87e0f85e-584b-4b59-bbc2-1e966f3573fb	a982727a-c8b0-4c06-bc58-522c2d67dbcc	phone	 +1345949-3894	active
bb9365ea-4d45-4050-9ec7-6314cd2950de	a982727a-c8b0-4c06-bc58-522c2d67dbcc	country	Cayman Islands	active
8fb1b6a7-e579-4ed7-96b0-672609c1bd14	a982727a-c8b0-4c06-bc58-522c2d67dbcc	country_code	41	active
befec7fd-0842-4855-92ca-59b03a5aee5b	a982727a-c8b0-4c06-bc58-522c2d67dbcc	institution_type	NGO	active
6a8fb101-c1bc-4331-9f94-1edb0f9b65a3	a982727a-c8b0-4c06-bc58-522c2d67dbcc	activities	<span>Cayman's largest land-based tourist attraction, Cayman Turtle Centre: Island Wildlife Encounter hosts more than 200,000 visitors each year. Educational, cultural and entertainment programmes are consistently being created and updated to enhance the experience that can only be found at our world-renowned attraction</span>	active
a2134fb5-3815-4874-9cca-a765b6814d66	a982727a-c8b0-4c06-bc58-522c2d67dbcc	ocean_expert_updated	2020-07-22T00:00:00+02:00	active
ca0b42e3-48f0-4886-b4c7-4be747bc7e18	a982727a-c8b0-4c06-bc58-522c2d67dbcc	data_quality	Ocean Expert data	active
523e5ad9-a566-4998-881d-5ec45b013efe	90966ad9-4d11-4371-8e14-013a22b0a8a8	website	http://www.sevin.ru/menues1/index_eng.html	active
2560f38c-8425-4450-a932-6d3db1eec8a4	90966ad9-4d11-4371-8e14-013a22b0a8a8	email	admin@sevin.ru	active
cc12462c-bfe2-4c4e-924d-8574602e3f26	90966ad9-4d11-4371-8e14-013a22b0a8a8	phone	952-40-17 /  / 7 (095)	active
62f596c1-903e-4d35-9679-ad37a999e599	90966ad9-4d11-4371-8e14-013a22b0a8a8	fax	(7-495) 954-55-34	active
31565039-30f5-4798-95d0-7a81fa26922c	90966ad9-4d11-4371-8e14-013a22b0a8a8	country	Russian Federation	active
d1b973f2-89ee-4241-b5a7-d78c5f8cedac	90966ad9-4d11-4371-8e14-013a22b0a8a8	country_code	178	active
04eadd8e-ca80-47fd-ba26-c389bd122022	90966ad9-4d11-4371-8e14-013a22b0a8a8	institution_type	Research	active
c184178b-b2aa-45e2-9b3f-e48a2eec5540	90966ad9-4d11-4371-8e14-013a22b0a8a8	ocean_expert_edmo_code	1851	active
50362fa8-1dac-4719-9cfa-f031d7d0e04d	90966ad9-4d11-4371-8e14-013a22b0a8a8	activities	Mete choice, parental care and evolution of behaviour in cichlid fishes (Teleostei: Cichlidae).	active
5076b8a7-6e84-439b-987b-9530f8d93426	90966ad9-4d11-4371-8e14-013a22b0a8a8	ocean_expert_updated	2013-07-04T00:00:00+02:00	active
1706bb64-e622-4bae-b454-c13f77c6c529	90966ad9-4d11-4371-8e14-013a22b0a8a8	data_quality	Ocean Expert data	active
89a0a45d-51c4-4802-a88c-7dc4a6587526	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	website	http://www.gacc.com/dnr/Bay/	active
a3f0f148-15c3-449e-a0f6-ff9c83da56ab	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	phone	 [410]9748487	active
5af80f51-9622-4395-9a4b-b51f4a95c51b	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	fax	[410]9742957	active
723a343f-5018-4fbc-9520-ddb4668ddef6	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	country	United States of America	active
58669d1d-56c8-484a-b0f7-c621c93c57dd	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	country_code	223	active
d4c53c8b-8941-4493-b182-e0105fb9d265	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	acronym	MD DNR	active
f6c35d94-e146-446e-bb0f-9ef6aa69c9bf	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	institution_type	Government	active
591563e9-9d44-42cf-a728-39b3a363fea1	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	activities	Extensive water quality monitoring in Eastern US, both with automatic sampling equipment (ISCO's) and hand collection, familiar with the most current models of YSI and Hydrolab multi-parameter water q	active
7c2dcadf-1432-41c2-b491-bdc31e58a88c	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	ocean_expert_updated	2018-09-10T00:00:00+02:00	active
a3d584aa-ac17-4a01-ab86-b73067f07291	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	data_quality	Ocean Expert data	active
0b3db589-74e7-40af-944f-51fcb2a94e42	50c2ccac-773d-4efb-a8ea-671b83a02cbf	website	https://wfsc.tamu.edu/	active
a5d50ded-40f7-4bc7-969d-647d5ff6cd71	50c2ccac-773d-4efb-a8ea-671b83a02cbf	phone	(979) 845-5777	active
a6f9338f-9f33-4a5d-8fb0-2854e13c33cd	50c2ccac-773d-4efb-a8ea-671b83a02cbf	country	United States of America	active
0cc57b88-a509-46b9-b305-4814384d63c7	50c2ccac-773d-4efb-a8ea-671b83a02cbf	country_code	223	active
85557ffa-9c86-466c-86bb-bdbf9a80edad	50c2ccac-773d-4efb-a8ea-671b83a02cbf	institution_type	Academic	active
c1c4c474-b11f-4f2a-bb5d-457e10a13e70	50c2ccac-773d-4efb-a8ea-671b83a02cbf	ocean_expert_updated	2018-08-23T00:00:00+02:00	active
8a9a3185-ac04-4699-9e46-acaefe3c9751	50c2ccac-773d-4efb-a8ea-671b83a02cbf	data_quality	Ocean Expert data	active
f8d9430a-ff12-46bb-9db0-454c43f37fb0	7eb04b9d-202f-45d0-b49f-a67cc19307f5	email	biommar@uniandes.edu.co	active
03a7af2a-447b-4d7b-b86a-0ec0b2b7e8de	7eb04b9d-202f-45d0-b49f-a67cc19307f5	phone	+57133949493756	active
406295e9-b816-4bb6-9a5d-8cc57c59a2cf	7eb04b9d-202f-45d0-b49f-a67cc19307f5	country	Colombia	active
733c1d3e-5089-47b9-b3e8-d6a51a4b30cc	7eb04b9d-202f-45d0-b49f-a67cc19307f5	country_code	48	active
4aa8fcb1-9e3f-4df3-a6de-d18e136603ad	7eb04b9d-202f-45d0-b49f-a67cc19307f5	acronym	BIOMMAR	active
4acc7ba6-5d6d-4cc4-8847-8524746896d1	7eb04b9d-202f-45d0-b49f-a67cc19307f5	institution_type	Academic	active
4d581e3d-8c9d-491a-a2c0-bea70e87b3d5	7eb04b9d-202f-45d0-b49f-a67cc19307f5	activities	Our interests are centered in the interaction between ecology and evolution, particularly of coral reef invertebrates such as octocorals, black corals, corals and sponges (and their symbionts). We are focusing on bridging phenotypic plasticity and ecological speciation as well as finding underlying adaptations to environmental conditions (including rising seawater temperature) and/or specialist symbionts in populations of coral reef organisms. However, we are doing a great effort to transfer our knowledge and research to the regions and local communities from the areas we have been working in the last few years. In addition, we have a number of synergies and funded projects on marine conservation biology, socioecological systems, octocoral systematics and community ecology. We follow an integrative biology approach including strong field, lab and computational components in our research.	active
924f85a6-f5ab-4acf-9a56-772291c28e39	7eb04b9d-202f-45d0-b49f-a67cc19307f5	ocean_expert_updated	2020-07-20T00:00:00+02:00	active
40928b5e-b641-4ba6-b78a-18892b359eab	7eb04b9d-202f-45d0-b49f-a67cc19307f5	data_quality	Ocean Expert data	active
a33a71d9-2d7b-4fea-abf6-e92185fdd184	d4406f37-d9f9-4759-a2f4-8288a2ed7545	website	http://www.associaciocetacea.org	active
c665bb6c-d1bc-4a8f-9ab3-fad0d6e97286	d4406f37-d9f9-4759-a2f4-8288a2ed7545	email	info@associaciocetacea.org	active
bea8e543-bc09-4dda-be23-9c5db4a395c4	d4406f37-d9f9-4759-a2f4-8288a2ed7545	country	Spain	active
96120729-53d8-40a7-86ef-97e167eec4fa	d4406f37-d9f9-4759-a2f4-8288a2ed7545	country_code	196	active
0168a473-f4f3-459f-baf9-2cd359ecf16e	d4406f37-d9f9-4759-a2f4-8288a2ed7545	institution_type	NGO	active
2295e247-7cb0-4d9e-94ea-a1b7b09b0e1b	d4406f37-d9f9-4759-a2f4-8288a2ed7545	activities	<span>We focus on the development of activities and studies that allow us to achieve the goals we set in our foundation. To do this we have created three separate areas, all working in a coordinated manner to develop education, training conservation and research campaigns and projects.</span>	active
b24a590f-e0f2-4fec-bd05-d1c0eb276897	d4406f37-d9f9-4759-a2f4-8288a2ed7545	ocean_expert_updated	2020-06-24T00:00:00+02:00	active
c336df19-443d-4def-a9f3-60e91e5de452	d4406f37-d9f9-4759-a2f4-8288a2ed7545	data_quality	Ocean Expert data	active
d319e147-38d8-4b92-b7c7-426d8544dc44	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	website	https://www.bu.edu/bump/	active
8399228b-472e-4989-83a3-034d309bb28c	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	email	lesk@bu.edu	active
99502448-4ca7-44c5-b16a-aa742e15549a	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	phone	617-358-4961	active
ce19b723-8ca6-499e-a418-2e6470b7b7c2	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	fax	617-353-6340	active
83b2629c-2bc3-4761-89be-7d9ea913c61e	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	country	United States of America	active
b3f434ba-0e1b-4bd4-8f60-c91e1de8f14d	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	country_code	223	active
03c39bb0-3168-4fd3-bb2f-01a1af82f6a5	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	acronym	BUMP	active
8c8c641f-51a6-49af-9ff0-dbf1ed051a43	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	institution_type	Academic	active
214e3a02-a63f-45aa-add1-72d207ee1974	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	ocean_expert_updated	2018-08-09T00:00:00+02:00	active
0bf750d9-1295-46b3-956b-700d685e6ff5	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	data_quality	Ocean Expert data	active
8c326563-191f-403a-ab37-cab2c85ed248	fd38eafe-608a-4b8b-ad35-0817f95f794f	phone	001 703-341-2481	active
95fb518f-281b-4f9e-8cd6-f92953698fb3	fd38eafe-608a-4b8b-ad35-0817f95f794f	fax	001 703-892-0826	active
161dd9cf-791f-4fbd-8c34-baf2cdc9725d	fd38eafe-608a-4b8b-ad35-0817f95f794f	country	United States of America	active
10bb4a2b-07ad-47a6-9e91-54d6a8a4e9d1	fd38eafe-608a-4b8b-ad35-0817f95f794f	country_code	223	active
d8e24516-e2e5-4cd5-8c0a-ef3b32b3d8cb	fd38eafe-608a-4b8b-ad35-0817f95f794f	acronym	CI/GMD	active
d998f4b8-609c-4de2-835d-12db3b334971	fd38eafe-608a-4b8b-ad35-0817f95f794f	institution_type	NGO	active
ad335439-3ef5-4f9e-af7b-825ecf91f092	fd38eafe-608a-4b8b-ad35-0817f95f794f	ocean_expert_updated	2011-07-05T00:00:00+02:00	active
40b532f1-c43b-4e70-8779-f3dfdc43a86b	fd38eafe-608a-4b8b-ad35-0817f95f794f	data_quality	Ocean Expert data	active
dc46f219-6baf-48c8-9cdd-b45008e1e7ca	70395ad1-0a15-4b1a-b28a-8d6b9c211013	website	https://blbra.ca/	active
8d2cae3b-946f-4c99-8cc4-2f05e3f3bb1d	70395ad1-0a15-4b1a-b28a-8d6b9c211013	email	contact@blbra.ca	active
046b594e-4e21-433e-b905-6928c1f8fa84	70395ad1-0a15-4b1a-b28a-8d6b9c211013	country	Canada	active
2aef09d4-7a42-4c05-99a8-ea0e0bb4e7b4	70395ad1-0a15-4b1a-b28a-8d6b9c211013	country_code	39	active
62a2e064-3f9f-4bd0-a848-6718f7a62dfc	70395ad1-0a15-4b1a-b28a-8d6b9c211013	acronym	BLCBRA	active
fbc12ada-0368-4b8a-ba14-a3d7e7f0dc1b	70395ad1-0a15-4b1a-b28a-8d6b9c211013	institution_type	NGO	active
17d61b5b-7626-4be9-807f-6b5f4fab847e	70395ad1-0a15-4b1a-b28a-8d6b9c211013	ocean_expert_updated	2018-08-09T00:00:00+02:00	active
1ee5d337-b586-412a-b757-431268b53730	70395ad1-0a15-4b1a-b28a-8d6b9c211013	data_quality	Ocean Expert data	active
8960b71d-364e-4ef2-884a-1a6e8d366d49	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	website	www.fish.kagoshima-u.ac.jp/e_kuffhp.html	active
8afdd07c-a72c-4a2b-afdb-63532910e5c4	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	email	dean@fish.kagoshima-u.ac.jp	active
a1c1f0ad-ef2d-4cb6-abf8-5bfaa66db56c	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	phone	099-286-4111	active
ecc9fade-6369-4a25-9233-cf890354f64a	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	fax	099-286-4015	active
69055737-4d86-4fa6-9b1a-1ecd277b998b	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	country	Japan	active
413b57f5-c4b0-4086-afd7-99b40809e2ac	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	country_code	108	active
7eee5e00-35b8-4373-bb53-3ae40257f02c	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	institution_type	Academic	active
6334009b-4bdf-45e9-a531-ce376b269e1e	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	activities	Fisheries education and research	active
9f41179b-f0a5-40f8-a9d6-c777f35d6fde	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	ocean_expert_updated	2009-11-30T00:00:00+01:00	active
7c363869-bd04-4c5f-9cd3-c963a7ac9583	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	data_quality	Ocean Expert data	active
87aedc97-3042-40fa-a180-23660c9511dd	3b9842e9-2d1f-4b4a-8538-fbe9912851d9	website	https://www.uwo.ca/biology/	active
7e456125-3a83-41e0-9db1-04951d8f0219	3b9842e9-2d1f-4b4a-8538-fbe9912851d9	country	Canada	active
dac97935-1e01-44b8-bac2-4b65f8ae67d3	3b9842e9-2d1f-4b4a-8538-fbe9912851d9	country_code	39	active
e72f2012-71c8-43a0-b674-f346bcbd3680	3b9842e9-2d1f-4b4a-8538-fbe9912851d9	acronym	UWO	active
65684135-3c64-4e67-9ce8-405957ea0bb7	3b9842e9-2d1f-4b4a-8538-fbe9912851d9	institution_type	Academic	active
e1e5fe85-1414-4081-a8c3-6d76c2bbd858	3b9842e9-2d1f-4b4a-8538-fbe9912851d9	ocean_expert_updated	2018-08-09T00:00:00+02:00	active
0d50434f-5b1c-426d-bbf3-a4221d5652a3	3b9842e9-2d1f-4b4a-8538-fbe9912851d9	data_quality	Ocean Expert data	active
ad9eb5a2-81a4-4cb4-b0b9-e99f6057655b	71f64ffc-3a7e-43ae-a42f-5f2afe70971d	website	http://www.aquariumofpacific.org/	active
fc8841db-56f1-4389-8a55-587e4242e7c1	71f64ffc-3a7e-43ae-a42f-5f2afe70971d	email	aquariumofpacific@lbaop.org	active
95ba3f61-a5af-4b28-958a-ce815c2cc3a3	71f64ffc-3a7e-43ae-a42f-5f2afe70971d	phone	+1 (562) 590-3100	active
871e65f4-a3bf-48b0-9ef0-a92e3f28efca	71f64ffc-3a7e-43ae-a42f-5f2afe70971d	country	United States of America	active
166542ba-6a29-4bc2-a3aa-86a23d1b50df	71f64ffc-3a7e-43ae-a42f-5f2afe70971d	country_code	223	active
a42a1da3-c209-4753-8b21-4831e1270e37	71f64ffc-3a7e-43ae-a42f-5f2afe70971d	institution_type	Private commercial	active
cd42f240-1132-4e02-bb99-2da7433fd464	71f64ffc-3a7e-43ae-a42f-5f2afe70971d	activities	<h2>Southern California’s Largest Aquarium</h2><p>The Aquarium of the Pacific’s mission is to instill a sense of wonder, respect, and stewardship for the Pacific Ocean, its inhabitants, and ecosystems. Our vision is to create an aquarium dedicated to conserving and building Natural Capital (Nature and Nature’s services) by building Social Capital (the interactions between and among peoples). The Aquarium of the Pacific has redefined the modern aquarium. It is a community gathering place where diverse cultures and the arts are celebrated and a place where important topics facing our planet and our ocean are explored by scientists, policymakers, and stakeholders in the search for sustainable solutions. It has taken a bold new approach in the future of aquariums with the opening of its Pacific Visions wing.</p>	active
4fc757d1-3122-42d7-bff6-d045f20d673b	71f64ffc-3a7e-43ae-a42f-5f2afe70971d	ocean_expert_updated	2020-06-19T00:00:00+02:00	active
1c87bdde-1344-4d34-89cb-8a18ca9863f1	71f64ffc-3a7e-43ae-a42f-5f2afe70971d	data_quality	Ocean Expert data	active
5e83c6b7-00c2-4b32-9728-dd87717b91b4	c1b034ce-3854-429c-9422-ffb7dc34c61d	website	https://www.inrae.fr/	active
24fe4dab-c11c-4a13-ae8d-e0a41a1d4372	c1b034ce-3854-429c-9422-ffb7dc34c61d	email	contact-institut@inrea.fr	active
2bef4fb6-5649-4d35-95c6-1d553bbbfc32	c1b034ce-3854-429c-9422-ffb7dc34c61d	phone	+33 1 42 75 90 00	active
b1e9e0d2-c867-45ee-a850-be605bae43f3	c1b034ce-3854-429c-9422-ffb7dc34c61d	country	France	active
14073f55-0d03-415c-a901-634b3e1b3a58	c1b034ce-3854-429c-9422-ffb7dc34c61d	country_code	74	active
7912fdad-2ae7-47f3-a2da-570b31f17d69	c1b034ce-3854-429c-9422-ffb7dc34c61d	acronym	IRSTEA	active
077d1424-3aa8-42c0-8b8b-f5d6c5e87551	c1b034ce-3854-429c-9422-ffb7dc34c61d	institution_type	Research	active
3534ca34-d86a-4311-859e-268b48bb7adb	c1b034ce-3854-429c-9422-ffb7dc34c61d	ocean_expert_updated	2020-07-24T00:00:00+02:00	active
12d8735f-7b56-45dd-9258-9c074f2be3ac	c1b034ce-3854-429c-9422-ffb7dc34c61d	data_quality	Ocean Expert data	active
be5f57b1-a490-4d86-a846-69ac6c228079	a4efb55b-125c-4e53-8520-c1d1657def53	website	http://www.wii.gov.in	active
2fc77f1b-d355-4174-814b-76fcdf860c38	a4efb55b-125c-4e53-8520-c1d1657def53	email	wii@wii.gov.in	active
546baf54-2303-464c-8135-7a8b301e784d	a4efb55b-125c-4e53-8520-c1d1657def53	phone	+911352640112-115	active
cc09c948-f4d5-4fa0-9d42-d638129ee719	a4efb55b-125c-4e53-8520-c1d1657def53	fax	+911352640117	active
6325c96e-2111-4c13-a6fc-2d2d5751cf65	a4efb55b-125c-4e53-8520-c1d1657def53	country	India	active
f07bf534-cc0b-434f-be85-eec8fc9efe05	a4efb55b-125c-4e53-8520-c1d1657def53	country_code	100	active
f419d433-7e95-4e57-9f5b-676ec4face85	a4efb55b-125c-4e53-8520-c1d1657def53	acronym	WII	active
75005ea3-2f8b-4039-941c-c023aaca65c9	a4efb55b-125c-4e53-8520-c1d1657def53	institution_type	Government	active
8e0a2bd3-45f9-4009-b8b0-18a7b3402d68	a4efb55b-125c-4e53-8520-c1d1657def53	activities	Research and Development on Wildlife Conservation\r\nCapacity Building of Protected Area Managers and Frontline Staffs\r\nConsultancy on Wildlife Conservation and Protected Area\r\nEducation and Awareness on Environmental Conservation	active
91032cfd-2963-42f1-8d9b-28e2b722c4fb	a4efb55b-125c-4e53-8520-c1d1657def53	ocean_expert_updated	2010-12-17T00:00:00+01:00	active
3b982f18-1b05-4b1e-a070-a32837d88111	a4efb55b-125c-4e53-8520-c1d1657def53	data_quality	Ocean Expert data	active
\.


--
-- Data for Name: group_extra_revision; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.group_extra_revision (id, group_id, key, value, state, revision_id, continuity_id, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: group_revision; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.group_revision (id, name, title, description, created, state, revision_id, continuity_id, expired_id, revision_timestamp, expired_timestamp, current, type, approval_status, image_url, is_organization) FROM stdin;
\.


--
-- Data for Name: member; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.member (id, group_id, table_id, state, table_name, capacity) FROM stdin;
1dcfdac1-c3d1-42e4-9957-129c80306ad3	6a0220c4-d2c2-4453-99ae-f89ca5907538	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
4e8370c2-4abd-4e89-8e73-3abe04ef9c13	564d4b37-c5a3-4a4a-8585-acaacf0134b3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
7be2b239-bb6e-4d2b-82aa-be8b3a113523	365ac034-63ba-4116-b87f-8bd8c34e6b40	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
827441fa-30fa-4dcc-8506-54e6a8648a80	6bab9702-e011-417e-aa58-2adedd1d0a72	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
f3b5fe6b-6d14-492b-8082-3038cf2818dc	3e117d1c-778e-4aca-9b34-b294399a2947	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
898a52a5-b2d1-481d-a7a7-c86c43358586	55650f16-ddc3-4321-a692-f71569ac5472	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
0b09597d-2565-4018-8e89-b5d0a4e44225	c2a5adb7-d4eb-45d8-bb4c-d967b2dc1b0b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
5faed446-29b1-4648-9e25-125b3b64feb2	5df18ad4-0207-4834-a1a6-1942c73dcb33	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
59a76ee8-d5f5-4e6e-8392-98e7a5564b75	e45382da-08cb-4943-a10a-66c1707c10a5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
f9dcf6e8-83c2-4b6d-ae6d-e88cec14e108	d771a5b4-dcf5-4a11-b566-1f07cfc00e43	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
58c64d13-8802-4e1a-ad5b-07512028fb0d	2e58e60a-3874-43d6-94c5-c2cce73fe7ad	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
ea7758b7-268d-44d6-b8a4-e3dc1584b9ae	afbabc3f-3452-4a94-a729-0bf5de4bb667	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
6aac08f4-8faf-4fdb-9901-2ebededc3b6a	e7b5ae11-6c1f-42b6-b054-68b878b7f357	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
5728526d-9462-4fac-a2b9-d26ca47ea03c	3b7600e8-0c2f-4bda-9c19-02bc6b215254	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
1e289648-c0f9-448b-b339-49d82d9847a0	52bd6a8e-a044-480d-8c86-9aeb135dd4f7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
dd987306-0f60-4c1a-bb75-ea0451849756	f3c05b89-ae29-4798-b851-3f847333d9eb	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f65f740d-0a55-469e-a804-cd2005938d8c	0e9ea7d9-b300-44a1-aea5-e1e0b9fd9644	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
33426db4-00a7-4e6b-801e-d043fb9fb22e	6dfb3459-5fdd-487c-a001-1e63d3318100	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
817e3772-d753-4c69-91b2-b0bdbc9269ae	75876ec7-e686-4240-a1ce-2a9cdf5929ee	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0a86fad1-53ee-4547-ab29-e0848eaa3f7c	293b388d-43d1-41b9-874f-3594204df05c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
417830a8-daf7-49a9-b8a1-600cf05b6768	d4543bd1-9877-4ca6-b088-6811839e3991	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f48bd93c-84ed-4bf6-a283-006912a99ec5	a390a520-185a-498f-b7e1-1f3955bcc910	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4def3f11-a315-4e47-be9e-7f45800d7cb0	a28f25a4-fea1-4e38-9f10-10dfeffe6910	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2ff3bbd1-a213-4a80-9041-e898d213bb81	2be97b83-283e-4bd3-906a-67b3a393c11e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
99aae51c-15be-4369-82e7-88092bd450c8	264f6298-0e34-43a8-bf68-b28a235fbc8e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d67fb90f-ed6e-44e7-9b9d-1f19c62cf0cc	8dc59986-db13-4f28-8e67-a935b692e707	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
18b08555-072f-4247-930a-02cb0773cf38	ff8aa929-7052-48b5-b09d-18cdb9c7a0dc	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
77245d22-3d82-44b9-84a5-f84ccc09400f	3a427c28-8873-4307-87d9-e9adbe837138	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a6dbde5a-8e1b-465d-aeae-87c14d0b2563	3a4aa10f-a20e-4dc7-b841-554397287ff7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0adda659-6054-42d9-a7d1-0d48ab1542cc	e641c794-b901-4796-8f84-1c560bed38ee	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
145dcf21-d2e3-4568-8cc7-4b4dbf37e896	95785cd3-73db-4b63-939a-436a66050fab	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6ef73d05-076a-4dc0-ae6c-247d9638171d	bacaf6cf-7a04-447d-9e0a-c60078e8fb8c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1d5e7bed-9cda-480d-b284-d45ea49397cc	9897699d-0fd1-4ad4-8358-eccee53d8384	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
cee6217f-150a-4d5c-9972-688016b5138e	6810f491-2ccf-49fe-92c0-0ccdb7b214fb	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
bea0e298-1575-4ffa-a22d-c91e32ea550f	1b8c14b9-2b90-4d42-9c90-b78d5c1c1177	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1bdbc577-5987-4341-aee1-65ea7182c5ac	b05309c2-88ee-45c5-9bc8-a71f5ec8b9d7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f703abb5-ecf1-4cde-87d3-7d06a27d93b2	2ae535d8-068b-4da4-8c87-5f587fa81715	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ad026eae-a0a3-474d-a822-1e354f607593	06ea9a4a-38e1-4eae-a9e8-dde613cc96c4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
42b50339-ccad-43c3-ac34-b0b90f8240ed	fe44c029-cb97-41a9-99e7-2dcfc88f187c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1c40fc2a-59d0-4c89-b444-90c3d0c265e5	7e174027-29cb-4598-81bd-e70d298243e7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
23fb3169-1d67-4d50-a1ba-4ad51c2a917d	da452a4a-f160-4367-9289-1fdcc49e87ee	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
75d81d4a-471c-4e0a-bdb1-4c7a9989d555	6482c50d-b486-4dfd-9a3b-71b0f551db2b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
66492963-bb6e-414d-9f1f-1bdceb7f986a	be1c91b6-bd6a-4374-a097-d8974586b1c3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d98aee98-29ed-4d8b-ad4c-79e4b5e1148a	275c6efa-aabf-4f30-972a-a1a5bdf4a526	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
eac46aa7-1e2d-4a30-8c24-86bd6be9aafc	0c4a0415-9ef9-4b50-9f55-33e10dac20ef	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4fe80d5c-bff1-451b-a115-a840097f04b5	a2b5f56d-0cd5-415f-b839-726896209e41	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a4dd5f4d-2c1f-4e12-bc4f-617b19bc45e8	ea8f768b-9884-459b-8895-68489faa3d1d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
56be4e83-33e1-46ed-ae54-231338680e7c	b06998dc-2511-4456-a560-7a34acd5b9ad	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
f9452e8d-996c-4116-b3f8-189ef253e72d	ad23811c-45d9-46cb-9322-c0f2e04c5f7f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
badd5939-2cef-4640-a9c5-3bd041a12851	c5c65e91-5a2b-4dc8-9cdc-cac9a3189282	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
9c82bef1-71d6-4fac-9956-92e591681f8b	ad7a11ef-329f-4473-9805-f238e56456c3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
36fe65e3-0bad-4643-9976-42bdba40b0e9	e4d56021-ff07-409c-a434-2aabe55e55ee	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
342d5df7-9683-4319-9d99-b22e52eec475	a05350f5-edc6-4bda-b485-1ff5d6698e72	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
3d9f4454-9bb1-4b36-82ea-c9889943c9fd	1b6795b6-16dd-48e6-9f07-eea472ec3a69	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
a91a4f41-2a8e-4ffa-a750-4cb3ad002850	90dc8b01-a056-4c45-b582-1d2f85486fae	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
6f5d094d-fa65-45ee-b644-72c169e9d1a9	6696572f-aaac-4cd9-8005-77b2014c89ae	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
f7e8597f-9f41-4d6a-8219-6bfa7da4c04f	2987cc44-b92d-4309-913c-54cba1ac777b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
37718c93-ce3a-450a-91a1-8dc0a5fe14d3	903f707f-3fd9-4309-bc2a-9a45f4f8930d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
aee3782c-91ac-4401-b98a-c4f54fc55fa6	42710998-0d40-4076-aadb-7c8b2373a937	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
205441a5-1270-47e1-a97a-fa59881875db	0489b1f3-df5e-46ef-83e4-4337b9efa016	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
d16b16fb-4f84-4ab6-9bf8-0f7651f4530d	1c9bdc15-f881-4f56-b6e6-83a8871ba956	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
9435d80c-dd71-4998-81e1-441d2a7b6999	cc21fcd3-f085-4ded-b8aa-21f89b5ada4c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
7192f437-3834-4fb0-a2c3-307750b731b0	2b63abfc-d39d-41ba-bbbe-0648c9b1fd87	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
f0e61341-55a7-4ecd-af62-184c4f2b98f9	7a423a6a-2a56-4969-93dd-2c21bd4ac1ab	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
28a5b735-ac99-4995-b10f-57dbe7322bbc	f575884b-0a5f-4e59-a764-eb9ebfff8340	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
f928653e-453f-4f5a-9fcc-f5c9589a04c3	2e573b25-7383-4777-be3d-af71c9b771d9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
a72e9ea0-88f3-4e60-ae15-a0a101a6e8a1	32b6fa33-c5c0-45b1-9080-dcdb64cd9da4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
897dff7b-ff86-476d-807c-afff7d87e556	e8c40209-a18d-4905-8b54-daec5e04a402	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
e005c243-6cca-42a9-9b64-f04f58a9aa42	dd2f9ef7-1908-495a-ab74-247ff7379be9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
e8684747-faeb-4644-aa46-eca34111451f	2ecc04f6-b7ba-43ee-8548-adeea0ffc171	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
3cb44c92-23b5-41f7-b115-bb9a28f63e98	697bfd7d-15e1-4b83-b0ee-8f926acc42a4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
84d465b8-cd4d-4260-a721-bf4a0810132f	aa0a925a-1639-4470-9778-36c809078650	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
81d74d63-fd38-46ad-8edd-bc4881037071	5028ad30-1eb0-4305-9e8f-11a2e64c8050	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3f59d020-18e1-4483-a01d-0b77842ee686	76bac861-e7d0-44fe-b34d-fed4e5b5d665	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c1d84f08-fba4-488b-bd95-27233f1ce9a0	1f25906e-abaf-4d80-bb52-cca85e0e6826	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
fae57c9f-c20f-4033-9a26-20211888063d	0f5bcf48-2536-4eda-9890-b90979e67f23	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1a5e2957-b128-4604-9178-552368ec6c3d	a92d9cbc-1892-4083-9eb1-8b606b96d53f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2547c3b7-6b42-424d-b244-89e476797b7f	fdacd702-3d20-4ec8-9b78-9fb5e58aed85	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3a5db886-55c3-4b4e-be6e-0d9b442080cb	c6e40c34-af79-49ad-b264-215a7412b267	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b7fd9ab3-f5aa-470b-ad7f-a8d82692547f	3d11c74f-6f73-447f-b26e-1b5f1dedd827	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ce1cde37-511e-4064-b1fd-510093016c64	e092d59e-78d0-4a96-ab2c-780b96c2dc7e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2a4a5df1-b2b2-44dd-a42c-c2d480d536a5	68211384-c996-4cea-b513-640245865f3f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8849399f-ca56-4138-8d08-40715891f21e	0d792c5d-4fae-4bba-a304-ca301be2df70	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
91da49a7-57cf-4c5b-9e9d-b2d96fc7e91f	b73c7e06-2936-4b03-97a0-be42125a5587	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
62db835f-d9fc-4684-b1c5-bafd0bcc4b6a	841fb472-2474-434f-8f23-b46aeb320c24	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d9a565b5-5cdd-4b8b-b182-98f1fe20a4a7	b2f11608-d736-4228-b023-ea890e70f458	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f04f5263-b3ab-4ad1-bcdf-9edbbb9e6938	ce45ea14-e92e-4cde-88e1-0975b5230c88	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7ffe5cf0-e931-45a1-98d2-753f817b3038	bdf364aa-7c2d-4ebe-9e23-32d53d165765	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
38968378-aaaa-4bc0-8c77-ec7dbeb2a838	0b98dbfe-c3c3-4c9a-8ef0-748ca63df702	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
cda3fb31-fd64-43ef-9e25-20c95f1aaf49	51fdd65d-819f-4f04-bdca-61c977ecc5b1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0fbdd4dc-7fba-4fb7-9d1d-a275a10a9b86	798c1858-ec4b-4995-8153-e4757954f0db	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
267d5e4f-c8e2-416e-9ba4-b66a47a8da53	85103d1a-32b9-432b-9477-17d798863fd8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4969529e-aa9b-407c-8d12-1dae2a233786	31decf3a-eca7-48bd-a0df-4e5ad6184b84	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
35e7f0b2-9556-4afc-ae90-91dd65cdb110	febe0919-ebae-4143-b13b-2d16c3be7b7a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
626d12c8-131a-44c6-8dd3-d98770f133ac	2be3f8c6-0305-40ce-a886-e16fe1d5b866	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
af9c7154-1af6-415a-9957-11bf6a559c24	90524ed2-5832-4d0e-93bd-8199dbab28e6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6252ede9-14a0-4a71-9252-5ce97c9ecd0d	10302fdc-b9d1-48c2-adaf-9db10247c965	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
bf324e6b-d02c-439b-ae34-b7d3ec635df3	f79362d0-ac5f-4f3e-adf2-40dd62c1750e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8cbffd2b-aae3-467f-849c-8aef9bc0aab8	f310ae60-2665-486c-aa2f-79087f0eb160	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b5c48a8a-9ada-4f5f-9e2c-17cfc2493e50	eb9da7c3-1e8d-4ee9-832c-094feca3b764	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3b232b20-2ee4-434d-a9cf-10146d417271	e36390bf-7bf5-401c-9416-563eb9764b71	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a018bb6f-585e-4a47-8df2-0dca54d8d811	a33882e2-da54-4760-918d-959fad0c885a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9fc64a07-3e3b-47af-862a-541bf7061d56	13553e47-6461-4b99-b3a3-f08668a89c46	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
59f8a577-b06d-4bc5-a413-a4b6e23c361c	0dcf8d2c-cc1f-4fdc-b642-5a65f9829fb3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d2e4e9f8-7358-44c2-b76f-b10e0fec0cf4	592a4f7e-3dd2-4979-a5cd-9444de39a3e5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c53e2494-b89b-40df-b2ae-a02a849a042d	fb9a34d1-2e3e-4b0b-b7e5-4811b5582a5f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
90ac22ee-daf3-4cb5-ad62-5219bd71d32d	c5ea1454-5a27-4f68-8751-b719b1f22e91	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7b8ae035-ab54-4ca0-9c6c-69599db5575c	25c465b1-11ab-48f5-9171-0c9daad96682	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c14ab6a0-e90b-4533-8571-746d08664150	b457f063-800f-455a-888a-af4961e486e8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8b773ab6-72c4-4a42-8eac-04b90c238c21	667c0d64-27f9-4851-8fb6-87d460d543f5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
73fe24b0-ba1a-427d-8fea-5a4a5bc79017	59bbd82d-d9d2-4744-bfb5-be609e893aea	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ad5ec8a6-9de2-40b3-886c-1443a0c0500b	be0878c0-57b1-4f4d-8bc9-90383a35f8c7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
511ca577-b2b9-4914-9ebd-1827382bc7c9	c2fea925-2541-450f-aa6b-88db3659c6b5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e74cfff6-6f5c-4ea2-8712-339fb848ea6f	60d230ea-04bb-4bf0-bc31-931986c6f8ad	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9e5aecb3-6ef1-4c7e-b37c-de6e12c57215	e928747c-cbc0-45c3-ac29-7d50ffd9a540	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4603bfe4-effc-41da-8587-7571d6843f73	5154fc27-ad82-44e9-a9a0-54880a290a81	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
efbb6f63-9540-43dc-87b6-e54dff0f7478	d96a1343-305f-4dd8-9065-dce0e486cb0d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a14adc95-4729-41e3-a940-5d97eb3f7ac1	5d3f93d2-b551-478e-98f6-be5325aab839	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
fc8919b9-4d59-47ce-86f3-a0149b15bf17	6a9bb29b-626b-4adc-80f3-c0d5e8bf1541	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e4367793-969b-4b7e-a563-a95dd12910a7	61865196-9996-4c6b-9f95-e56b48656f79	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
95b9669e-0fd1-49d7-99da-db47186900c3	cfe2357b-8494-4915-a4af-e5e78f9a2d0e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5a0f1b73-6e57-49f0-82aa-11d3c4bdefad	88783a78-f253-4f14-9c47-75ec6af444eb	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6d315032-3a32-46ab-9c35-bfb41cdc5338	d2765fce-1dc3-4a5d-8bf2-498ab4dca5c1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
599c8555-8544-46fa-89a9-f705e66d597e	eba18a36-8bf8-465e-ac22-faf91d8842c1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
52fb62f5-1b7c-433e-8ba7-e64063d6ca53	bcf08a4d-30c6-48f7-abd7-8c9ec80bfdb8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
20343ce1-b69d-4be4-9a55-87753e1933d6	6fe6381f-bb07-424d-a851-195f25b6f6d9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d36351f6-5281-4993-b687-7578cb593c33	fc266a55-849b-4d77-a3ae-6c87be229e74	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e9094eaa-1ba1-41e0-9ed3-4fc68e46cb05	baf6eb4a-004f-46e0-93b0-33ddb3b5c062	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2572e455-a2d2-495b-9e5f-d955157e4866	d5869af9-6e98-4c5d-827d-5c05ebbb06c1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
18add2b3-5d24-4fcd-a91e-c25503e0c731	5ad2c0af-ffc4-4cb9-b191-bbe63620020d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0b02a243-0d13-490b-9fcf-d37380566615	6222c029-d926-4655-9dbb-2ab5bb2f935d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9e5ea98c-7cc1-444f-b588-ec345634d223	e054b50c-c05a-4962-91a6-adad139afe90	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e7daf6a8-9ec4-4f94-9b68-d1bcc9c4c19a	95d7dd4e-f07e-4ebe-9559-801d52a42ea1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
26038f61-a1db-4e65-9bcc-462979e123fa	cb9b615b-33aa-495a-a565-fd98a0b307f6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
aeb47b70-aff2-4eb4-a4d2-155bfd0cbc78	2538a5d4-9f12-4d90-894f-1b269da5ac0b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5f6ea0b6-ea50-4756-8b37-43beb8b3f450	2c60df9f-d7e2-4d5c-a18b-860da9bfad32	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b87319b9-f526-4402-a4c2-1b3353ba642b	d5b9d5ec-1686-43ba-92bc-7fa793c225e4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c88ae817-2f4c-4fff-b343-1edb670ce73b	29ddffca-2484-4ede-9e6d-6f7e11895bfd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1a9de559-9fbc-436f-8164-b67dbbeceefe	dfa67296-40ed-4632-ac81-54a869dbfb97	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
40f123e3-8d78-45de-ab3a-d47a8a9d3389	3c50b952-0f6a-404e-9a0d-0d5003959792	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
55b991b2-19e0-4543-aade-edf61d554120	05787a9d-bc52-4e47-8ac8-b7dad21abfd3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c87b5cf6-fa27-4569-b840-237962bba9f8	02aca92a-1742-40f0-bd6d-13a6c385ae8e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
154057be-4c7c-417b-b6c4-0b7e242c3eee	0af463d7-be40-46b8-ae06-de54d1c501a7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9b9042be-503f-4590-a14c-9f613568d012	970491c8-f9c6-494d-bafe-6f50dee92d35	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e7ef19e4-1eec-4f3a-9f94-06dedfe555e4	e915a1fb-c859-448d-8b03-143524fa4bb7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d3163eed-80c4-4c0f-b83d-0e544cb7de06	b5c3662c-af5e-4f83-977b-344869ac4ddd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
77353617-e752-4264-a222-75721739ba04	5ade6690-8569-4f9f-b076-2f3483b83196	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
057d9ebb-1668-4997-bce5-8edfec7830ff	7bac9cb3-5240-43ec-9090-75f596724d84	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0de05eb1-cd1e-4851-b0c8-b4076dd6b5c2	d0b92a8f-0c1a-46c8-a1a7-7c1aa2535ab1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
af466f19-3b4d-4c2c-b851-2968dfb21862	a3b95820-ea5c-48d8-bcf3-383a602205f6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
04149cfd-6e3b-43ff-bcc8-4b4aed16ead8	6b693b05-3dae-4e77-b27b-39e85055d903	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
851974f5-5259-46d0-9070-d3125b8f6bd6	a427377b-8b01-46a4-993e-066e3b60877c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6af1c463-9d85-483d-86de-c2d376e37f99	dba4cd0d-0b05-45e1-9786-c7ac5306f342	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3e1a6532-26d3-4018-b936-1a1dbf0c6614	70ec09c1-9d93-475d-ac96-2b89bae385ab	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a4c16f34-130c-4c41-b9fd-2310183b772a	7450d9d6-b6a8-4888-988c-841eb76b3217	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6dd0ca40-f5a1-49de-83cd-4dccadb3d573	97da71e8-2ef4-4130-9ef7-7a6093e2cfa6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
75f928af-b134-428c-a3ef-0d708ca71535	4efd84fb-5e9d-4720-a609-200cb1029874	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6f694318-d0b9-4285-8a4d-fb4184bac4e7	eec99556-493c-4cb8-a936-fca189a62cae	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e7bb5bb1-8db5-4e7c-820e-8a3f17dc8c21	33c501a0-0d47-4b52-ab11-0521c8ed1149	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e1f7dc54-2e8a-4ae7-8377-86ef53cc00e5	4861c99c-6b53-4674-8134-78f0dfa0cd45	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ffb8dddd-9705-48b4-80c6-4501fc1858e6	9de9e83a-dd8b-408f-a194-90e9945d13e3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8645949c-be24-466b-85d9-0ccc4f4076a5	c2400946-5534-4cf5-b5af-2f84beea12b3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6ca602e7-1d86-4b5f-9479-cfb613ce79a6	16c09054-fef9-498b-93ba-e758ec693db0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
71b47def-7ad1-4b47-b753-41da6e96d155	98b88afe-c722-46cb-94ef-16d9c0bad789	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7a62c81c-93f5-4cb3-98cf-5d877c5fa883	f95cc150-edd8-4c05-9993-e85d4818f643	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8f51406f-3dde-4380-aefc-02274e51bec8	e4f66786-d8a0-41bd-a73d-6007f356a245	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
946c7562-7de7-4cda-aaa6-5ac00f32cf1f	cc724260-7325-4707-b8f2-24989b4b6b04	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e402dc5f-9261-4338-89a2-ff1fc3f15cbd	247d7f49-f4eb-4992-8266-566b930bfd93	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1bead795-91ed-454a-8fd5-dd11ea014446	86859ff8-d542-4199-96f3-5643a144b409	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d53f6be1-a79b-48f5-a045-6387d435a3bb	d265acf8-05f0-40ef-893f-54fda0e6e435	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9a201864-e2e3-45e3-9fd2-ccbe774c02d9	9e150867-6f43-4b7d-96e0-3bd895916154	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b96bd783-411e-429e-ab05-793de25d056e	5f4afc28-fddd-470e-9b95-8a994031d8f3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ffdf64cf-aa62-468f-af77-c67f82d40835	b73ebe41-513e-40b0-aaf6-db43312af36d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e98bb508-f2e7-4716-883f-9da1a57c643b	8f56f7d5-1936-4492-8451-c957075738b0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b497e759-ac82-4988-9134-b95915697c10	7db51825-df14-4cb3-8bb5-c3f2f6a7eb5a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0f5071ef-6e05-44a2-b8a3-47a5df168769	a25d5eaf-775e-4d23-a215-c7c6c8447365	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a4d68fbb-11ab-4090-9251-af1269d49025	eb5171b4-dcb3-48e4-a3dd-8bb7d3a99c5b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
bdc6fd7a-1424-4e92-ae2d-2758306a6423	ab4fc39b-575d-4421-9ec0-8e8cd90cadeb	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e32c214d-bf8e-4ef9-a302-3ec848650dcc	750c7541-d48a-4f99-8f6c-2775a02b0572	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
26c71680-78d9-46ee-9151-7c78a5f4f78e	8c7473b5-a75b-4e6e-b1dd-3a06a296b656	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7e397522-9b40-4a06-9e1e-2a0d15e35dd8	7d6c7a83-5ae8-4cdc-b96f-ad40114917ca	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e61bcb78-aadb-49fb-8e55-4623c45aa8e6	b6700fd3-827c-4560-9366-e8fad31cccf3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
aee77397-62d4-439c-a683-70c5010b50ac	53f56e02-066f-45a9-8d29-ba7c19567d47	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2c13bbe0-b51a-4c70-9ea7-e428c9f04a2d	b1943950-4d4c-4b47-9ee4-d287b4d97863	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e9dd1a5d-ae0d-46e5-a04a-8849527b7fdd	a69bda88-d70a-45e3-9405-b2bf6749d7a3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
58555f31-7aa1-4d2a-b4b3-3ac6f0610bd5	23561cf1-9650-45d8-b728-9b7d3ec0e512	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
85c7c11b-207d-4068-93db-1dc0e5b01340	d69a857b-28c0-4d05-aa49-af58910b8731	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a758e109-0ca0-4e64-9039-68a68298b55b	6aa22741-c9e7-466a-80e3-b1795f322c3a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ba721b67-965d-40d5-a22f-368b3ddbdc47	787a1240-3ed9-4cb0-9e3e-6718c2f5c710	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
bf57e489-ab82-45a2-afd8-2d8ce539e317	437da419-407c-41dd-a578-14154a75617f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3c7aa01e-e9f5-4f76-84e4-07321b49f783	4b73dd5c-401b-48d9-8cf9-d327566524d6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9317f0a4-1c1c-4c64-a320-cfd63bb9a1b6	96b1c050-93a4-4ac0-8050-2471bb072d66	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0ff03a44-ee6c-4976-a3fd-50d7374fdd01	896bf7f3-ff8c-4a5a-a064-e44dc6fe2e06	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
df81c685-74e0-4d02-a012-50dc1451db50	800cf29d-6348-4644-8584-20f8eeb2f68c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c2b170ee-9118-4ebe-ae2e-c0c76fd23f39	0b8d19bb-d4a2-48a4-88c6-edf90b2a6793	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
089744ec-ea4b-4ac0-b1b8-1d5f144ce4e1	695cf72a-771d-4ae1-bd07-707bf4147ea8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a859cc8e-690e-47ad-973c-8e8d2a03c506	64408501-8ded-4236-b0a5-e4cc1fad2987	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ed592f31-5d5c-41bf-a278-c69e8da2e76f	5140454a-8995-46ef-b886-89a28020afbd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
04fb5c93-987f-4b76-ad08-94279dfeda57	e55040d3-0f68-484d-9b8a-0d437de16e0c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ad2c43c1-6f58-4dec-893a-12fa33735254	0e481ec9-4c62-4a03-a1e3-e52fd7e17a35	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f59c563e-04d0-4fe3-9be7-21b2e7b3876f	d6a9c63b-7de9-4876-b619-97274fddf870	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9a0bbc72-596f-4aaa-ae80-f159901bae02	3043933b-6f03-460b-a889-f93e8115fb4a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4d93416e-830e-4d08-b039-f8a77fd45d8d	d4d01d14-725a-40a0-96f0-a48acbc0be97	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c4043210-3057-457a-8279-95005fa4a2da	94cbac79-581a-4546-b820-f38d651f2250	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e72c217b-a674-40e3-88d2-56402dab6e4d	6c046ca7-3a9d-4914-9e99-7c712510762f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
293f53ba-6a15-4bec-bc74-81dbbabb9205	ec3ae82c-2467-4ccf-a1de-8da8c76f7ff1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f55cee6b-71be-4dc7-af4e-1731b364e609	5edc05dd-7b0e-4e73-8d3c-866f00563324	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2ece91b2-9ba2-4a8e-873a-e7f8f433fb6b	11758483-b1ff-4869-b808-7bef397d68b9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0c13f8e1-986f-421f-a6d7-a4ee17d3cc3e	78e0b382-6a4a-4b5d-be80-4816ae16c03d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
bbdd349a-b27f-4c1a-a5d7-fbbb48a91de7	7a8c235e-d4cc-44df-a8d8-79cfade6dadd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2dafe360-c67b-4abe-b74f-d79a01795db6	2d23e7f7-8ff0-40c8-af6e-71908729ea59	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
cb650fbf-d936-49c5-b31c-c6e2aa83629d	6dbd818e-9ec6-4a49-9ec7-403161a3daff	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
978830cf-e057-48c1-8e03-c718b06b1170	2b52d11f-0b8a-4189-84b3-28d5a6bedd4e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0eb0384a-4144-40c5-9a83-3e719194de86	e1c1b14f-d7d9-4341-93ef-b4e958cfeef5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
49f761ce-74ea-4586-815c-b020332796f8	f33c3fdb-fb5a-4423-9853-6de85c21eaf7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5baa3174-a140-4b66-a966-c0234f8149dc	8208125a-decf-4f71-9ee5-cabc48336ee8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f12dec7c-7561-4cd2-8592-8b3e3ab1d2bf	4950329a-ec0d-45f2-8728-16e312f54480	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
409cf7b4-0920-4541-9344-4769a4459a26	c4c09832-10d1-4b07-baf9-9dbafbf8039e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2c240b7c-2c0f-493b-818f-7a69e349179c	4c737d42-3faa-4c48-8946-0bc77f024ecd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
dac4c60d-ea1f-4215-9802-61770402019e	d004b51b-2ed5-4a73-893c-358861e80bed	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5af6efd1-ffbc-4c36-9296-4d24ba239cd3	dfb7a014-0e42-4e48-83aa-bc26cc28f163	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
858b2c8d-b508-4e92-a91e-b71e6cebd76a	a4cb7546-84c4-4d48-be51-07acdfd0c52d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1d812ea8-84c4-4f3f-8c8c-d53c1de73378	8e802012-99d8-4029-b6d2-3aab7d633045	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e6d27a8b-8963-493c-ae76-6fa6cd9837ea	b3873ace-2e25-4610-be44-677538dccf32	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
61142a23-1358-40f7-977f-43f887b83a41	a563a3d3-0e3c-4fc8-895b-6c022c853670	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f0f571a9-456a-46e9-8f42-f820e23a320e	7924147f-5b51-49c0-a1e7-3c52d0b7f8a8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
cb1d4fac-98cf-46d3-9b14-dedf7ca09ac6	033d95ac-20c8-4586-89ac-6d417d20cd5a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
cebe1b7b-0dbe-493f-8237-a890243a16cb	0675a51b-6cc9-4cd6-bc0a-fc74fe13751a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3644a8a2-5ff1-43aa-b327-3b511eb9872c	d38658b9-6bd5-4b0b-969f-63aeff3e2132	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
65a99376-dde2-457f-a794-6900b9c8ee3c	54bb88ce-067f-4742-a38f-d9de6aa67991	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
646b3bd2-c274-4670-b172-59754e1d6e54	167b8f8d-d89e-4f9c-905b-25c67d1a792b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
18ccdb27-6131-477d-867a-113a54fcbb0f	2fdf01ab-1278-49db-9f8c-223c8d61d0ec	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
110319e4-9cb1-4cd3-a575-ae080ccf90cc	32c00f85-c3ca-4872-8d94-61ec822f042e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c76946dd-4bb2-4de5-b7c4-9e06514aad30	8518d6b4-e106-469b-9cb8-06abe0fc2b55	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2defcfe4-04e7-4ed1-b06c-b751718bf20a	800762c8-d262-4992-9683-fb5f1aff2c1c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ef48b3dc-6d45-4c6e-bce5-9ffb9d31d0a6	7274e8ed-e151-45ae-9d36-bdd1aaaa3c02	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
97d736a7-443d-49b4-9571-42d8277c40a8	52d7435b-c1ee-45e1-8c37-109eb4d7c6ff	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4d7dced4-db88-43e8-980c-4cf2dff2f2a0	9473a245-2c00-459a-a9a4-5101643f96c5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ce854404-3e2a-4456-a77f-e188e8821bda	bce4dbd9-6032-4046-a7c6-2763e2b9b65a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
54165cea-3d88-4744-94b1-ca66df984e95	7ea7c6d8-b190-41ba-9220-cb2afa26aedd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5ac0376d-377d-41bd-a249-ba72b0b4efa4	859c1ca6-f244-4ec6-9fd4-9f4ff789e1b9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
fa945ce4-f8a8-404e-a014-155607340cfc	6e6209ae-9722-4618-997e-574bd8bf9232	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
dfba9364-96f9-4171-884b-52fbbe1c9b76	e907c070-e714-4cbd-9452-fd9835d754c0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6bc6ed7a-7f77-4d24-9902-dc6a2afd7799	50a6b81f-aa28-4c82-9701-3dcf237eb676	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2ad7a376-0340-4a75-971e-f9c481e26140	cae19eda-cf6e-410f-8def-2f9f4f547a81	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
da9cc87b-4429-4246-91a1-76c80d2c3980	5cddb6d0-4ad6-4f7c-a5f8-b62b744538c1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
665825b4-323f-4662-a740-9b398da392a3	e7291ef6-c93c-4d32-a3bf-56e5bfbbbe59	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
df3a65e6-0912-40d6-9cb7-21e8750f6d59	a16dd315-42e4-4265-82a1-cca335347a61	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
929444de-b4bf-4f58-b163-62cab53cb83d	c7a3397f-16f3-490b-aee6-40f0128b047a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5f4dcdef-bfdf-40ac-8fcc-a2bf265c6404	fb6ac69a-97ba-41aa-8393-6899331e54d9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3a629596-9b18-404b-a1e0-4c944ab2f625	91b32882-1919-4ea9-b8d1-6a1a234b6d54	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3905a97a-d717-4123-b386-27f9c0f69fd0	13d92eaf-54e6-4030-917d-92f07ed3ac15	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1c72bbbc-8b17-4490-90c6-0f58c144a466	f677b5bc-4d9a-4e3c-8581-81e6b7cb4543	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
bc454ec7-d034-446d-98d1-c9875e942118	ec093b2d-a8cc-4cac-942a-382e052740d7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4a6d2575-efa1-436b-abda-5bf114729986	c596f9de-a718-4452-a72e-6114b4df376a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2828bf3c-6eac-4f22-b5c8-5f0bee2f7fcb	aa3f2b1d-0c60-4683-b34b-72a697014c06	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ec63c458-0d71-4d16-92e1-1cff2948b570	e4b9e642-5e3c-477d-8beb-d7d0695f1529	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8d2f28b5-28d8-41ad-98f0-ad178d8b5444	214d4414-7bd0-4e93-8880-29ce5f7f8a4c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ee2c996e-3d02-48d3-b273-05f55643fc6c	824218af-abd6-494d-8516-df3976f15036	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
56b055f8-ba76-4cc3-8d57-82cd23382cfe	82afeb70-c1a1-4f44-abbc-e4011fbd6fe1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6baded24-61c0-4328-8a0e-950991f8a1a6	3a8c7ba9-7568-4ae5-af84-8774a9d68c84	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6894e33c-3090-4472-bcbd-902a5829d886	ac23012e-f084-4e91-a387-ab2710215700	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
78a3a3eb-3dd5-475f-8be0-4f326d609cf6	f6e30ff9-73a7-4d8d-aa0f-394fec886cc4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d19664ba-c140-4c83-8af4-3be271d6792f	3d13dcc2-f9e2-4ea6-8927-3fdc64f2599e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ce2b4709-0424-4621-bb0f-9b5e95656e42	a6f164ab-e1f5-4685-81ec-e307c1005059	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
26b8d45c-722f-49d4-a0a6-7e847a0f909e	03a65aa1-ef3b-4ba2-b55a-f9e1309350c5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1b62e5c9-6c3b-4020-be0e-4a4673d7910b	981ece61-8d8d-49b3-aa77-5604c05b25a5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e24cac8e-a970-4845-b46c-3a475d0bb842	fb7d769c-25af-491e-82d7-2814bb44adfa	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
90d71f6c-ff0e-4e7f-a25d-3738ed9c2916	e8af040b-6c07-471b-8f38-e2e2c2a3618a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1b208e2e-9c70-45ff-b377-7b621c79e960	89d0ab20-89d1-4def-b62c-5bdb334ba91c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7872040f-847c-4fd1-8a26-80cb650cc4aa	30262bfe-a8cc-4358-842c-d6f2215dbc27	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1646b5d4-0b1b-4e77-bd55-1f6145dcc736	871ab2eb-b6e4-4d17-82e4-a0d19dc00734	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
fac7c66c-d63c-4db1-9ae2-890ca4535d30	9bcaadda-82db-4337-969b-f20c2fd6df9f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6d9172bb-f6ca-497a-b962-1beefca79bac	54ad8d42-a77e-4ba9-9086-5616f5b1bfa3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ec94bb00-84e4-4fb6-83a7-8d6b6c8f7f8a	802e6fa7-dcfa-47ae-8fba-fc82384781ce	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
408995e8-1e0a-4079-81ce-281391d6eb60	d381c204-7ca8-4c47-9009-da41186d3ddb	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ccc4461c-f92a-4184-9417-08c17b3cc7c7	bb4dca58-991a-4bf6-9b45-58773ebfc74b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0adafb3f-572d-4803-ac17-59795f6bf2a8	28edba86-d7b0-4680-aeae-76a6ea1fb665	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
509c7ce1-aae6-424e-b9c4-cd746fa886c4	1525c747-c4f0-4722-b9ff-f1b3110c4722	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4c54296c-7adb-4bbe-8a6b-646569409fe9	2266f8b8-d21c-4396-b121-38a6d0d10904	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
aa7eba2f-9fda-4054-8589-a680140a5aaa	266b5bf5-ff83-4884-99d1-e57d24c62938	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4f9a3e85-f1aa-43db-9dc8-bda30839a419	b8d845b9-9dba-47e7-ba82-21c73c3a4a40	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4ca8eb94-e189-47f8-9133-a8de536b07e6	8b9956e9-9b6c-4d3b-af4e-9794dc16e045	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
700849c6-5dd8-4187-b6ea-518abfa2cf10	db4af8aa-7de7-4549-bbd2-2279e29221c1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a72c6c6d-e53e-4b53-ac8c-e03eca32db5c	275f4e71-3c27-4493-8557-264bf2bdc573	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
dcb77cd6-7e3c-42cc-97e4-386f96f69664	1f14f01f-988f-4b30-be8a-30f5affec66d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5345e59e-8abb-42eb-b3c0-6652801679ed	25f14782-5f5b-4fdc-815b-5ab6361eb4b7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7a421d65-2dd4-47c9-ba64-aae34fb75f48	70de0a28-cbe6-48a6-ad7f-c5f865d95e57	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1b3f1532-7724-444e-a35f-fcd3593670f8	bf870d7f-9771-4ec4-bec4-96a93ac48db4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e4639687-d013-40fe-9a0a-b911d747bad4	52311b2d-544b-4fc9-8f50-a2bc46dd021e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f1446156-e091-4ed5-8433-2be8494ad8c6	686eebff-1ae4-4ffc-aa82-b4e57d6bc878	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a4060013-fb71-4a53-9761-8a90c3e29598	4a747e3c-d413-407b-9b33-0971c3e1c715	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1aa47146-ef3a-42e3-999e-1524a960241b	42dc3aa1-6da8-423f-8661-36a18ac5f228	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f1c8d47a-f796-4407-972a-76d5a5b9806c	a07368ee-ae2d-4f0b-a5ef-2fe499d50916	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7293c90d-70e7-4b68-8a7b-ad59ffd440b4	b2b51546-3b53-4352-a662-cc01be4e15e4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2f7bcd72-20fd-471f-8187-54c2cffb4532	0c646368-381c-4755-9662-208f7beefec2	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8c264361-eacb-4969-a84e-dabc607c6e28	8181c435-3025-4586-b923-06bbd11d74a8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e620ffe2-fd39-428e-b295-844c5471b6a8	b49c0d7a-ab4e-49da-8740-966a1e3bf988	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
70366a3b-74c3-4392-a1e8-c8bf6bfa773e	4d85c067-dd49-4389-9b5d-d7f2f7c9619a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e69c36d0-cd04-441e-a4a9-2725c02ba22a	0b4bdd41-6d09-4acc-8686-f19daa04ca80	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
37ad2448-77ff-4419-bd05-9d5868fe9f3f	a3e2256d-8325-43aa-80fc-2609c4773bed	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ae3c053f-c564-4bd6-b5dd-edbae8ad7437	2110e2c1-1004-4df9-939d-59c145d8863a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ce876520-6574-400e-a63e-5b00d3d7fa67	14f7ee4f-e08e-4a46-b871-4986f878734c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
423029f6-4a37-437e-b0e4-fecf6a0e29e4	a07e42c6-9d8c-41a9-a584-a7ab36182661	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
cf6ca774-b4d2-449e-a5ed-5ab90887e23e	10c56773-42dd-48ac-b112-7f93635f77f5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
199ee106-1d50-405c-aafb-7e927ae320b3	22afadf4-defa-4dc5-84d6-43753cb4b6a6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3a4363d3-d78e-419f-94e2-36394816b6fe	b36f3a08-c0f3-4113-9701-8be7a96c6994	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
30485086-d595-4591-a453-3739d4b6bbe4	97030076-b67c-4297-82da-9719f19f627d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9a5a2efc-52c6-4aa0-84c8-d68be68b930b	7392a5b0-980d-4fad-b474-87508f4764a7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ea8d21d4-c8ea-4210-8269-832dbcf15159	1faa8adc-06fa-4d42-9ac1-29d184df23dd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
fb1817ef-8ff9-4aba-a518-d541618198a0	d56c7b0b-6ae9-468c-ac9d-9376fc21da16	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
bc7d5cc9-cb39-47f8-8c4e-85e5c9ef78ab	b7d6f9fd-961c-43da-96d7-2a96958f52a5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8fa2a4de-70c4-4451-8681-fcdc9361ceeb	0a48dceb-ee1b-4a15-bdf8-f0600922140b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
44f4931d-de97-4d88-8a1f-e1d6793f3107	3b6e7d4d-aeca-4ed8-84b0-341a127c6961	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ac7f1809-8163-4103-97b8-3ff2694be428	57cfc1e2-015b-4305-9a9c-c8d4e97edb7e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
657e947b-b8b9-4569-b0e5-a49fffe05630	95b31416-1012-4b3c-866a-cef324346386	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
13f161c2-9273-4970-a02f-8dd5ad2ba634	0d67c71d-6211-4e72-be4c-524bfc6a1d08	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0bda745f-be7c-4052-9297-f86b7f8d1c37	9b5a030b-4fba-40a2-b1f3-28c105710dde	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5f9bfabd-c79d-401b-98fe-bbc61e4d670e	8703524f-c585-4ce8-b585-7332c5a7d9dd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
55e3df26-644f-4e17-992f-93a40b08f37e	e828a308-7500-47c6-8e7a-708cc0a8ee24	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
475841c9-78d4-463f-aa77-5396d0ca7870	98cbc4d9-113f-421b-ae1e-93940b14b0a9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
991cbe65-6bdb-4409-9f39-e946a21022f1	331e4a28-5a0d-40c9-9156-8d069ed07e7e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c4e39085-c351-4304-98ef-54222b63690b	90e12cca-89b1-4682-846b-4ec3604123d8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
62889277-0e2e-41ca-a701-74357e8e5d4d	3d9e9d8c-def3-4e2d-b37d-92ac91094c61	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3bf711c0-e6d6-49ed-953e-90139f5ccc8a	dd32ba32-b24a-4022-b3e0-3370ac3b64b4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b2533c1d-2413-4971-9ebb-17971d2d3566	fd57bbc8-c10b-43ef-a0e7-1a11c34d3c6a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a16e840d-309f-4de3-b693-61f9dbf4e3d7	26a7a9c1-1a70-49f8-82ab-e7502f538b12	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
24175d50-e34f-412b-85f4-c7e40eb63f8d	1a25085b-990b-4a54-90dc-edf8b1bb5187	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5f578b2f-6396-4386-83aa-dbea4b0886d9	9a7fcc54-154a-4fc7-b1a6-5a82bed8d016	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
787af499-e926-4bf9-9e7a-bae8631ddbf4	5dee680a-6ac8-42b5-80ea-37bc20b6753a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
86585592-5eb9-41b7-badb-8bb5edb56100	95f850a5-917a-42ff-8394-c0b03f115000	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e2f044e2-4f5a-485d-9a0b-5efc615330e6	8b115d2c-b78f-48c1-91c7-98361c0cb9b2	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9b794402-57c9-4e89-9022-801a295d2491	a7227e00-5b28-4afc-b42c-01a3faf61b3e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
50d6578f-bd6a-4e86-9fa6-fd40986705a3	fda51120-160d-4ce7-901b-30b7bc880320	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9463e880-9e93-4363-b61a-4108c36e8376	72ecf145-6884-41d5-bd1e-da35039b930f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
059abe50-4096-4025-836a-c07119398047	38ec64ce-f8b3-4ccd-a4e2-da3375ea1b87	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0f5d0234-93e0-4cc0-8299-48798b6ebb1e	a54646d7-acb9-4ea3-9343-f89998f264a4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
706b2c96-a7b5-47a5-a756-9ce06f637cfe	14653056-8541-41d0-a2b3-734760b78a49	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b846ad20-e18e-49f4-bfed-7c1c84bf8b41	0a6d885d-16e2-4e6c-8f78-909e76e77498	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
73721cc2-f269-4c22-aad3-5c7e499c17e3	c1353b20-43a4-48db-afce-c235c0d21698	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2085083c-ca96-400a-b32d-b32d575cb638	45cb320e-e6b7-4bb6-b7cb-5f26f82bdeaf	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b47b5c90-6e66-4ce3-80c8-0b4fbe99e923	ce4fb67b-6511-4f4c-aa81-2c5420fc2ea6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
edf3a751-df0d-401d-a722-42de7e5bfc4c	0ba72d15-bf93-4054-b617-295cea604bb5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
943ed08c-8d05-401c-b1a6-a23998bb9a5c	7c34f5c0-445b-459a-bd5e-22f96833cd2c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
bbc721dc-cf5c-44b2-99ce-edf200feab10	e3f190a8-f874-4276-84fb-f858a25bbefc	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
03dbe4cb-825c-4d4c-9480-9f27f97eab4a	578dd6fa-f3e7-4b1f-98c0-9707a0943ba8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1c84cc50-16ab-4540-842c-0b922bfc33fd	5a985427-7f22-46d7-bd22-aeddc7ad3e10	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7eb0a9c8-f712-4c1b-972d-40ae66615218	3670b7bd-946d-4ef5-81a5-7b096970fffc	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
46b0d474-ac43-40c6-ab1e-36623b0e3f46	f677db11-cdfc-4368-9ce0-121944ca84a1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
be2c410d-a1a1-4425-bad9-4abd33902ed3	d7e650cc-411b-407f-955a-b6613b4c90bb	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5299f247-4c11-4d77-ba61-58259161ea96	a8d5729e-7683-4bed-97ba-41d0e3be5256	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
576e0487-0aac-4337-9452-7951fc24c903	8a296a60-bfde-49d2-97fe-fcd2324f0bdd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6f1657df-0dfb-4685-9045-4f226a8c9d87	1d23733b-3ed4-4ed6-8b3f-fae276fedec8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
899fa648-13b5-4911-b45d-b33f93cc7b7f	3e1fb479-298b-4eff-941a-f310e8d3d577	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d14edbd1-3818-471a-b2ed-0d5208d80efd	14d675a7-d1f2-49ea-9a1e-162eb685c77a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5feebdc1-d64b-444d-bfa8-59d9af5fe9cf	39a98f06-6b1a-4992-9a3b-d9bb8a8e4b6e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c2f188db-085b-4dc5-a530-5f6c8a1601b3	9db06246-8fe2-4beb-a72b-955c2c4b900a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4bfa8e9e-e14f-412b-be41-a7dd9109833b	f94f0237-b7ba-4017-8822-ee1f639aa822	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ca711078-af6c-45a8-962e-53f40512de22	18766a0e-02b1-4822-a081-482843b09fbd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
10b7a03c-167b-4a79-bb25-87e92166b834	cc0710f8-adae-4cd6-a2e7-4c7952cbf434	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0e904194-c75f-4c94-9884-fb87dfa847f9	8a6b18a8-42f3-4dab-ad4c-d955e42f45da	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4b60d421-3d46-4980-9708-49a729c5d7c7	5c3cc68d-d631-48bc-b014-21ccf3575b4b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f8f440d9-5ed8-436b-bfc9-51370df3cb6a	71f19e42-5d5f-4e60-b210-d7ace05fa1ce	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
968aab4f-8578-40af-a92d-bd4f3ceb5dd6	cd0f0ebf-9da5-4c2c-b659-5c38c2110585	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e63ed2f9-d8f5-4ea4-9bad-51d5b1ff214e	957e2ff4-5c75-4e3f-bab1-475aa7a49bce	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8d8a2e6a-84bf-46ea-b26d-da7df44a93f6	22350a3c-c83e-45f2-adc5-9808b43af107	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0b5febbc-c8f0-4c69-b200-b8ea9995ec6f	0a6bdabd-17d3-46b8-b8b7-2acbdafadd4f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c6277a65-1faa-466a-8643-2f143ebe825d	a9d14ae5-3e72-4fd6-aa83-df22c98f88f0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f5501ec7-4541-4069-a437-417f9507c1ca	790f7f15-d509-4411-9793-6109e8d44ae6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
aae56f12-be2c-468a-88ac-1e72d4b67f04	56b34daf-4f9b-4903-bcb5-141dd7e57416	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
167b9aa9-098c-4285-ae92-45acc46cdcb4	319ddbdb-0b65-49af-a139-b2442cabc7fe	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f6bde2f8-f963-4b60-8d11-936801bd8f7a	d8330346-9980-462b-bbfd-68c0f11b5d29	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
59b5c748-aa0b-45cf-8583-d0462896f64c	1cd90651-b3f0-4fad-ab76-be61c5594c3d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
739e8e94-f635-4c77-8939-08ebacb0d92f	ebaf77ce-93bf-4735-a41f-d26a9a678c16	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
11d9a0a5-baae-4fa0-905b-4714f9c2a7b1	7c943458-177c-489a-911a-c25531396c79	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b1067892-ec38-439b-b1d7-0ce43c81b22b	55aa18f2-1792-4a23-93dc-ebda8ee05769	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
af693ebf-2297-4650-9e5b-8d87d2074852	33a71dd7-05c3-4b7c-bb9d-4bc5c73bbba4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
09e41fb4-c5b3-422c-ac89-30bd227009c8	4e23aad2-247e-41df-a8b8-359b9157fd62	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
caff2914-aefa-47ac-8b24-8188009f7113	15ccbbcb-4b8e-4b97-8297-c486593f7a76	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5be76e3a-8874-4a30-b537-e8c00ccf625a	781f9b8e-bdce-4400-9519-2c072a788345	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
425e8e57-e4cd-440f-9628-c5fcc2494a11	06976510-431b-47ad-95c5-b0205ec11367	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
cc99d26a-fd3f-4ba1-9407-128d76f53a86	bc254a05-5330-4808-b9df-905609fb2f95	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d2e2e9ef-0baf-4bde-a01b-02ca57e28e39	273eda46-d046-4410-8132-10e776acdb86	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
fc9f1cc5-f766-45b7-bce9-ba4c4fcba0ac	e076a784-c13a-4875-8260-7db7edc1ace3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
001f7976-5df9-45b4-b1c6-65d4279aebb2	c0f0cc1b-3957-481e-bd3a-2ce18a3485a9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
080833ea-3696-445f-9106-5199c076bcf8	2fb53a11-bc7b-4382-9103-4169636ce0c8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
94c1a22a-75af-47f1-ad3a-a0b99053bb7f	3161c47e-40d4-476f-aa67-af91613c6b05	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f5da3888-8920-4d27-a522-8cc1b3ff17cc	7daf6658-d28d-4996-ae3a-d1bc3a588624	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4b825267-745c-4d7c-817d-72868f3eda59	e030f2f2-bc17-4bfc-b79f-0766cc77c538	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
52234343-9317-4eba-95aa-38562b0961bf	c47dcbae-9ede-452b-96ce-a36b2f7c1502	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4ba0dde5-3bfe-4789-9908-d42b7ce04a15	8c04baba-b920-4a37-bb07-6abf7073447c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5a59221b-56f0-4c6a-b0f5-0d8a3cb48bc6	5f584f24-3c78-470b-ae63-730e55531cad	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d0f51069-9a82-4f95-ab7f-0e53b882f6ca	7e4b70fe-a40d-49e4-a6b1-8bc5cf7060ca	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
06909e62-0e53-4e4d-88c5-3047c2969b5f	4091fe33-4ada-430a-a7af-29988307eb8b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4d4339a8-cdcb-40e7-b750-bc0cde957d5d	9534a9bd-538e-449b-8d38-a11bbb125157	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
beec75b8-d842-49e6-8c67-3ae05891bd00	ea1b9a7d-6bc9-4e7b-a203-f9675c718e12	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c5950410-905d-4264-bedc-227313181182	5e2a5f0e-4bae-4ee6-a1f6-a83b7fc05983	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7c8b1994-74df-4b30-b7c3-8013fd30224b	1c6b0c0c-f86d-4b92-b65b-75c21042fb8e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e34a9b31-b624-47fa-ae55-eb15b715ca47	38cf0810-99e0-4ea4-a6b7-87103db5bd51	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e3d5161d-693d-44c4-afa7-60dbb2dc3f3e	95a7fa73-5bb4-46c3-ac72-e9555e97a129	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d2fed85b-9a34-4db6-b34e-b128e731bfee	896717b9-05b3-4b2b-8a38-22371e16353a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
51268f61-6d37-43c3-a72d-6ea3a9e8da68	2f740479-94fc-4f47-823e-76f41a10a7b9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c1adb36e-1d20-40fe-a8d5-dc72fe30847d	320c32cf-8bde-428e-a241-5a1a1ebc923a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f8cd5545-6252-47e4-b147-2049eb5bb924	a4e695b8-5b32-41d2-9f6a-729f9e7d8861	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
058fcdab-bd39-408b-87a4-0d729163171c	76444f19-f085-4f64-b58c-831be1b301c5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e7332496-0e81-4fe1-8f21-a3bfdc594058	26d3f977-6e82-4581-b1c6-c5cf1ae82370	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e592e74d-61a0-4407-8078-a3a1f68f8deb	31724b87-bf0c-4298-80eb-e24291b984fa	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f681ae58-32f1-4f61-a183-f07ddb8a7348	77d6ca18-7168-43d0-9972-4975c20cc79a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
bbd72aaa-82b0-4629-b9bf-6d03e1c70fd7	ea3a236c-45d7-4c32-919a-c10da2dd7860	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6ae39128-82cf-4ccc-8aec-5cdca36fcc19	0e2c5d11-b457-4591-a6fd-ccdca7c374e7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8f00c782-d5d5-497a-a5b2-9bfca761e3fb	59466127-5c6e-43ad-853f-d9e1a37ec452	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
934ff338-5edd-4ac8-b59c-18730521fd46	1e64082e-1d09-4520-91e2-6ddf17f84332	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9cec8fca-924e-41d1-93d8-a79189e5d627	21bf7239-177e-4a8a-9680-51331a64e26e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
61d781ad-8534-4f3b-89e3-ac9b72f97e14	38755801-6e78-4e0a-94af-c7791e702f6e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
75024640-af51-4c2d-b765-83f7dbd9a063	7912a981-e5a0-4975-b53d-30830d129ca1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8cb26a5e-4ba9-4a88-bce4-edf2f784438c	b0992960-4c48-45f3-9e16-c1f1bad299f6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f751431b-6fac-4574-aba6-e9e4843ac122	bf0c1ec5-ac35-47ff-a6a8-5f84795bfd02	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
53191784-3e38-41cc-b2c5-7a856e64be5f	baba4053-fb2e-4edb-be66-944cfc931bd2	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c3c6add0-9b33-4b07-aa10-f949be444de7	e7c382c7-84b1-40bd-af9c-b7933c66bfbe	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
16817737-f457-44c0-858c-97f73ab77da1	b8049a5b-f24a-43a6-8262-504a5173708d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
feec72a6-5116-459d-9268-8bdb692d0aa7	c199db40-ff32-499e-9257-ae6c8007bc94	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f56260ad-29fb-4884-9870-d59a1531c05d	0cff2f7b-0fe9-4942-a56a-51fc4135d432	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
611aae71-9bf3-4865-b354-79cc959f03b5	081bdd5a-3455-4cf1-9ed9-ddd146a2d170	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9f2fd641-21a0-4715-be57-0375e17c0aa3	a5b41d40-894b-4eb5-80ca-122ebdf7ff39	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0f6f2fee-c438-452c-81f6-63b6bdbd6941	2f7e4c19-87d1-4268-af7d-c6cb5fa8d769	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b5f29acd-d6ba-4b41-b0e3-006d806e30d2	6cfd8035-e247-4504-971b-caadee81763b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
75c085cb-dbd7-46a7-8904-a961e0e694b5	e73a8255-71d5-41f9-933b-a18e901e3615	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f1358c8c-0b3a-436f-8b17-d075beb029d0	c1b5e8af-b036-40dc-a2bc-d1c42ae78ae3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c6139ea4-0882-4ca6-b89a-f5fa54423e84	05204486-dab3-42ed-9ec0-1403a353a042	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
03a3c5f9-987c-41f1-a50c-c950928aa13d	6b76c48f-efa2-448a-af46-c3d5f6d4665d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ace7db25-8011-4f2e-9ca5-846f7fe9e67c	f8fe8f1e-6d61-4f83-8bf3-471a5bc6fb26	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d19e2f6e-bf66-44a8-b3eb-a6ebde45f800	ed012786-9b56-4575-821e-808d8b7e5d73	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a6848898-dc72-4e61-86b1-ac57dce0bed2	50cf7216-e271-4ebc-ac4d-23566f026653	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c6e8f3b8-03ce-47f1-9065-05ea59570d3a	85fcf0e2-d821-4784-98ba-2402db3fb55f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c4b94093-9edb-43bb-88d6-32238c7ff55c	6dd01f72-a424-45d2-a833-25cdb99143ef	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c548534a-e522-4f24-bf49-08ee7871efca	6d091871-5558-47f4-9ba9-91a9b1454f9c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
dcb04beb-eb80-4b99-9578-93724b5795e0	9d85f7e1-e1eb-4eb7-9d05-0dd34eaeff47	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1f7db862-e677-4607-9ab6-d2db15a9c819	f1695411-1b0d-4a9b-b15d-101260a6386d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
acda9d7d-a87d-4a55-9db1-dbd4ddab88a5	b191e299-f7ac-4453-99a8-222f8f84e707	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2e717271-5b63-489c-8f67-5aafea138e66	8e1f44a2-7307-4f93-b8bc-28a8f4392a8f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
75b2b364-901e-4867-8941-d2e77b33db41	58b3f3bd-1eae-46d5-900e-11ca507b87fe	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3264bffd-096f-4112-8085-f039afc6de4d	46f9cb4f-b4f3-4491-ac7d-bb14636337ad	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
210a7f0a-2ce4-4f98-9019-20164cbb705a	ffe9a0f6-afae-481f-b815-213e5b44c6bb	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
98f257d9-9f40-49af-a684-039690d578df	afa505c5-0691-4b6b-b2fc-fa1b57e751a2	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c8a941d7-f806-40a9-94ef-f3f9e2c54393	909d5101-5dc0-41a2-b6ce-d937af40f22e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d2f49ccb-b829-4c1b-a2d0-4d900b6e76a1	c3e73526-c426-4dee-a47c-3b486aa8651c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
cf80590f-05ce-42e0-93cc-30e9be901d82	5b8e8fa3-e48a-4782-b20a-84bf98f25fbd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7d6108d9-f36f-4a47-83ab-6d1d3d039b1e	6d5131dc-c688-4b0f-8527-0cc2256973c2	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1b42e904-5bf0-4c46-9f47-07076ae05d18	488609bd-f95a-4c2c-8470-0b2f7c182f80	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1df77843-fdc2-4b33-ab40-e32e5dcd25f7	a5ad5928-e434-40de-b488-d35fd780af53	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5ae4e026-0be9-4cdc-ab97-65f607cc56d3	6e73238d-12bd-4491-bd28-d2dfe6317b38	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
468c2707-7189-4380-9868-78c2aeda3bb8	41d2036a-5db3-4b98-9c7d-dd5b9282779b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
92bf9a39-a8ab-4929-ac30-b26a4a0da187	72d9bde2-e769-40b2-bec5-77ea05d23d15	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a7e0730a-7373-4fa0-a36a-0d701d0d8f13	fbad0960-5aa7-4ef8-813d-0b7065a19739	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b49cf918-8318-499d-9508-89c68b47e857	10b0d4ab-5e7d-43bb-9e87-5d2baf8f98ee	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0bcd8e96-18f3-4c75-9591-9c7c3da8915f	3787a1ae-37b2-47b0-9268-230e936245b8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
358ae456-9b2c-4873-8062-932ac7488040	94b92c30-177e-4153-b3c7-42ada07b5703	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7f1ecd68-99e6-4b21-93f2-ebe658d62184	a2aad2ef-dc6d-473f-8f36-a80f57226869	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9991a40f-cafa-4b2a-b945-2a587896f08e	cd4fe3d9-4bb8-4eb1-adf1-8d77d21b4d90	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
910dc9a2-a356-4ee1-b7c9-d5a6cd90864a	5c53cb4a-d4ef-4ed4-ad1a-c1b26cc5b10a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
fc2aa28f-6e20-466d-b81f-bc83fea71d80	23514126-0125-4b5b-8b8e-afabd2e718d6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ced47bbf-e66a-4747-b075-d0c73521cdfb	7260de8c-8862-4d9d-9114-91b6e74e0799	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
acd3aeb6-a971-4360-bd3e-a00618aa3364	a907ca4e-8f41-47a1-aced-481293fbc5d9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3730b33e-aae6-4b41-a57e-afc2010038e8	83295a28-507f-44ab-94e2-e4e34d5c6dd7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0610fd8c-a2cf-428b-b8d3-6a05f1fa7563	ed05a484-94e2-42a7-bc1d-8bb296bc236f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3509f586-f520-4de6-abd6-520aa1d95c70	fa671f6c-9f4c-4388-9b46-bf937fdac55e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
cb4174eb-d1ef-4555-8372-4f80550c1f91	79b8f927-ac45-49e3-a334-18f00d1803dc	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c1ac2c03-4858-45b1-a281-09cecf776a93	ed0423cb-ddf1-488f-8f84-a82481f1cbd9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
61ed057e-339f-464b-871c-a02c01c0c01f	1ab918bf-0e1c-472b-abcf-8b3bc2bf13ea	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3d8b1712-9e17-463b-9858-08e1cb8f5244	946832e3-55ab-427f-9387-215486006b34	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
bd10fb56-bd91-4a26-bb23-d2b7b7ab8f53	e49ae6f8-c969-46ec-bd91-041b3f10e35c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d9498c23-1a46-4381-b62c-362e558fb948	8ac4554d-ae0a-4299-9cf7-16b8e34b498a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3412b5e3-b143-4372-b634-c7765a68f924	48de3fb1-78e5-4d3c-9884-d23e311d355a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5ee0a3cc-0861-4aa2-92e3-267dc1dcc690	496de303-2fb9-40ca-af98-7827a51a7352	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
201585dc-e962-43ae-84ac-e72632d02f8a	33d16463-04d7-4cdf-9f48-a5b579ea0de0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
96d78846-fb36-4bf2-afa9-dccb9694aa71	662dbd69-398a-4b2b-8873-aff6f24df360	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
fe04f56b-5820-4767-aee9-c61eea94ebcb	bee2a67b-338b-4933-9df6-56da7df3b524	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
01e9f5cb-1fe1-422f-8ccf-a167bda19f4a	47c7b42f-04b8-4d67-9c22-414f3f9b96da	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3b499439-c011-4c52-a248-a0c7b9b49e6b	64d3bbd4-a41a-4118-9b75-bf9a4248a1fe	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
44b9884e-98d8-4016-82d0-8b481bc8efc7	c08fb08b-5f00-432c-a08a-e3a776d5397b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
12fe9fec-82d5-459d-982b-d02abef03b33	b9aa7a4f-7705-4116-9b01-42d23853edae	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ec635ba8-871e-448c-ba15-b04e872cc7c5	2494cf3d-c036-43e4-b61d-b83c719152ee	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c2c78045-bc31-401d-8145-438f54e6e323	a31e2fc6-00f9-4ea9-9a02-88ad5d42fdbc	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6d9b7307-4ba0-4593-a389-96a89bdf2562	b3d572fb-d2da-4b44-a667-ae05ee60fec8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f3a2bd19-8cf1-4353-8c5a-f3ce36867914	6aeca3bd-eb91-4e62-a62b-08d029464ca1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
94c74dcf-3353-49dd-8298-a6d77425d8cb	42802943-91da-496b-9304-fe05fba26dea	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ac4022d0-1185-45f5-aadf-597321d806cc	b79969d3-8a32-47b2-ab85-3e037a3ebde4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
98e37b9d-fb52-465d-8b98-b953c3f395e6	762a482a-fbf9-48c6-9323-78a43787cc82	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b14c7291-aa04-4ae9-9d68-ad505f228cc0	2e6f20ff-174d-471a-93ca-aa35c937217d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4b4601d7-e837-4504-afbc-48999920e158	473e25d2-f6ee-428e-b5b5-c3a6a36c6859	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2d1fffce-a15b-4aac-b36f-57642d8fb427	56c4c1ab-1610-499e-9a73-48b4106b2020	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
aa4969b1-82b6-4877-ba7e-8ba0d46a045b	3a027de3-39cd-40ea-91a3-30051f39b8f2	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
004995c7-db68-4385-9232-4d4435b4547e	5dcfaf5b-324f-42fe-994a-33446b036f5c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
35ffa0a1-2662-48d3-98ac-65f341cc0898	85ee2140-7aa0-4c83-bf34-263ffc7a7192	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c43144ad-d10d-4f74-863f-eb2f06a992ab	97b539c5-bc65-4737-9d7c-cbc95f819e0b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
521e220c-fb77-4581-bca4-26a0efd9953d	1e4f1796-a242-403e-ad9d-a634ba595c35	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
61e5287a-3a06-4430-a380-de4c4ca17ddb	c7f9bed8-88a8-495c-b6fa-91a0584cbc61	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d476e1d4-758c-4f40-bf0d-777a515ec389	e419466f-fa01-410e-9927-aa4adec6cc6c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
cf67292a-7c29-4cc3-b641-3f42dd4503e0	06a07584-f542-4afe-aeb5-b6473a741d99	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
048a24a2-212f-4521-825b-a88f2e80f6c8	1451af60-3395-44d3-a7ac-0c0d27d1e941	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
38c3e0ad-1d8f-44f8-9e0a-9619caed1ae5	91866e0e-2d75-4f9d-9832-31a6bee7ab05	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9b622d17-2b1d-400a-95ea-1c18ce5a1340	b0cfdfdb-da1c-4c7f-ae7b-7e97cc6e6ff0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b7d25018-71bb-4882-8c0a-e704e36be3ab	0454d9bd-c0c6-4ccb-a0ff-93ea450caef0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
34aed9d8-21a8-4a11-967a-bb72ea2de136	2a37b414-184e-465b-9889-51dedbad61e0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e3e41a9c-0df3-455f-befd-fee3b42e88f6	8807331f-2acd-4ffb-a11a-ecf63932938a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7a950a0a-9770-4c2d-a6f0-4740ebf6c036	f9111607-a254-4e22-b446-4bc1bfd47e26	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
923f7fe4-6752-4411-b6c8-53728253e5a1	7c0e278e-3d30-460b-b9d5-f01019e7e567	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d1f60400-104a-4a6e-8708-479061f9b675	03fd422e-1128-426a-b018-5edc03f91bb6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
52da75fc-f553-4510-9b50-5dfcf3d47f3f	cf982b50-f875-4821-9115-d3ab3cd534ae	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
239727bf-452e-4970-bac3-42b8a6472284	7b06fd53-2ccd-48a0-b9f7-d787524748d8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
60b9f47c-db6a-4095-b8d9-dd9962b4548e	ecc5ea65-f993-4aa6-8fa4-1ab289353b41	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4d3e0317-98f7-4c35-ada9-7bac8c065b98	7436a13d-9f88-4db9-b5c7-e8606faeb723	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0d874494-dcd3-431f-b2e3-32dde0cdb72c	22c1fe0a-424a-4a44-8c63-d636552ba886	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
aa369db3-942c-4a02-91bd-ed4b9ae88701	8a0c78a0-6e1d-4a12-9bbc-710156efb635	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
64be03b7-1ebb-4f07-ab4f-dd81beb315c3	0752d200-4b76-48e7-bff3-76aa8e25a23a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
752d8383-f96d-41ad-82a8-545aed969883	8e19eb22-322f-44ec-84e3-252063a113cf	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
62b3b890-20ae-4a66-b7c4-b421e4297585	62488d62-4141-4611-a267-5eef4dfac40e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8ddda736-a2ee-447b-b6fb-2b417ec54174	cea814d6-2e0a-4214-9c39-3fe730ca7cd5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e68b3e0d-e288-4a2c-b7f4-fb76304e48a1	b35a224c-cc89-4e8b-a6f4-c5fe5bbc4d98	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0aa0c355-da20-4c84-b71a-f84b78e8ead3	6ea78550-2cc0-465c-8624-3d18d8923e71	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9d9157bb-e223-47a0-97b8-0a2fc39af941	713c12dd-e249-43b2-ae63-8a1778bde3d6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
eff988c4-ca48-487f-9d83-94164ea468a3	6807177e-d90f-455c-b50c-09a815a9b0fb	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f9a17b23-0998-4b2f-a8c8-f2bedddbf137	64b55e5c-b41c-4b45-8286-fc183fc1e22b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7533d657-2deb-4b03-b297-5eb1d46cb9d4	a075242f-cc8f-4715-aeee-67effbd099b0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c46d87da-10e7-417b-a4a1-5d98ac89aac8	984d9654-fed4-4692-9292-f9e4eb115a3f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
12194c99-c919-4ff9-b785-612743c7b4d4	1b0cfdcd-04f2-4e67-a455-594cdf99925d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
60856bbf-1067-4368-b458-2e0ac91bb85d	531735c5-33bc-4a17-9905-5cbb84d92027	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7571d0fc-22f8-4e5b-8946-a334c4708407	4cb9a9b0-e4f6-4b64-a1ae-cb455ee7a8fb	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
9f0edbfe-5e27-4d6b-b791-b52fcaf15f8d	21d6bbfc-e133-4a04-9e16-5e37479de70b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e78d93e5-3ca6-4620-a4d7-208f6cdd03d7	efb64a40-7d6e-484b-86de-63401ccc13ca	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c3b5a6fe-9562-49b7-8caa-054b12332ca9	4778b9bb-91a2-47ce-99d3-fa0265cb20ac	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b1415de2-0f72-493a-afcb-3521ff9bf622	1242c07b-ffab-4f55-b8ab-94bc4970f5d2	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8fa94984-47c8-451f-9e71-e1a826ac6200	c32577e8-2f21-4c34-a4ce-1641adacffd5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
22b4b4cd-d2e5-45c6-9001-6a31366ba49e	0a3ac918-bbe4-4a04-a43b-6f6421bf4f31	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0e7add6c-1e8b-4ea4-84e1-d1bd9405b677	91f28432-5f2f-4f95-8bb7-9005e785b327	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
342fba29-ca0d-4310-96a6-db35905be73d	eef94ec3-bca8-4b26-b6f3-9324d7f9799c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5bc0f1d9-f973-4076-be16-a54cc973585e	db358bae-c6bd-4a7f-8726-4b217cf389f5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
73856262-e239-4fd9-953f-d3f9176dd557	d76ba351-d472-460f-8569-4a832ef633ac	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
887dc7e8-61d7-4a6c-b7a2-896dc9d7e191	b7f123f8-c806-4e09-9a6b-590332c6b8aa	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f45131ac-6009-471d-a433-2e6b34c518ba	c88cb4db-68fe-44f4-8057-37900c9bd8fd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4a89ad7f-534b-4171-940c-2456e496d9d8	8f98c818-40b2-42db-9121-4cc68b3bf2a8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8094dd00-988c-47e8-9ea4-da2088ec2230	bb75c8dd-1dea-41b4-bc1d-725b29129e62	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
fa76ee26-cb60-4885-ab1f-581a9baee48c	59a0abde-da3b-44f6-8c10-3314dbd3e158	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
fee120c7-b2f6-4f93-8061-f8f84383f7f0	bdc0848a-c777-49c3-ae3e-d2428c4465a6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
44589f67-2d8d-4d4a-93d6-7b9ee3961aad	e6d5c49e-e7c6-4f94-b0b7-8ef444eaeb9c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8c64ae6d-f83f-4b32-b409-e90020203f40	71a6fd6c-6b99-4659-ab81-4a6330f6a6cc	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
18100f7a-5e2b-40d7-b27d-60b2c63f59f3	131aead9-4b5f-42c8-b1be-4efb65f27f85	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
72d07af7-f54d-46da-bf5a-0b4efc889f58	6656a424-96b6-48ce-a7ed-ac2c25236f3e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b655e32e-c89b-44f1-be54-795a331f6f54	80e4933e-9e6d-4b53-afa6-65891c39b594	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5ac12dec-ec8c-47be-b69f-e393af92af81	a389d6aa-e9ba-4af1-a86e-6ec8dca6fbf4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e1486b39-0131-44ba-ab1d-66eb3fd2920d	dafcfb4f-d7b8-45d3-9b61-e872659c975e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6119877e-6101-43d8-81fd-14662ceed68d	bf21ee67-a54a-4795-a97e-c308d18eb12e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2cb30cc5-435c-4e97-958c-5f4b27db06ab	c177523f-2836-40b9-8f30-84692218550a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8a8b8829-537c-4755-b5d9-6443e64eefe5	59e8c52c-1e3d-49c2-9070-83cacf6a95c9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1a2b18c6-b213-424a-ab24-9faa52cbb227	ed7bd8d8-ceb7-45b5-8cab-c28ea30fd2bb	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
cd65d838-b952-4e5f-b96c-c1f4cea9d6f9	bc60400e-420e-4599-98d6-18b90fe187f9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1f45dd0f-5355-4aef-b41d-8a16c1e05e6a	c22f3f61-efb4-43c2-8b85-eff313c57d92	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2639bc5f-f232-4fa1-b5bb-89e6ea00b9e1	e97f5314-0d0e-4acd-8135-2b38cab75330	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
12b4cb5f-98b3-4072-9f2e-bb7a4fc58b4f	39ca8137-231e-497d-ae22-de66bc25d7a9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5559a5ee-6e65-4559-91c0-8073e01c3846	350c9b99-8b67-4836-8aa0-3ff8e1046072	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b546a7ff-e544-4ae7-a601-e2c04d29fa8d	8d184328-c515-47b9-968c-105c21b20eea	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
38f03bd5-4f44-4798-a747-075da80cd27a	8a3cc30f-e23b-4ace-b8c8-3085f2da93b3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4f787e93-14ae-4339-a7f4-61075e45003a	3aef56bf-23cb-4135-ac0d-224a1d8545e5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0cc636fb-de83-47bb-98a6-54a97ffe4178	86610961-056c-4151-9c4e-3f6bb20c3832	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0f604292-2b9b-4558-9e84-7754e7ee7ed7	e4478358-2dcf-4384-b600-08b0e0de1c95	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e9a82772-e1c2-4f27-9066-f87260a73eba	d724cd5d-9e63-41bb-8e5d-73bb841f6cd5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0474bdfa-0421-4883-8c3e-77916f38f490	88075da4-0351-4e14-a7da-6114f0309775	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
645b2e08-56a6-4ae3-bea0-190bf62dda45	46b0d887-58bf-4976-be93-cfe1f1bb40bc	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
156b9362-f5c1-4eab-8587-62c948ffabbf	a0566913-b123-4db5-8795-c36dd15bfbd2	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
66813018-ff26-4844-9ca3-44cdfe09b871	d872e3e6-54fc-4a24-9c6f-c108d3d8696b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
be0cf035-8859-4f6a-995e-51cb61320efc	821f9831-8ab3-4015-8699-1493f2aa55bc	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1891c7f3-6280-401d-a4e7-a10e62069d36	a2984ea7-0216-4f24-92ed-735096343c7d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e714ec0a-7f01-495d-977c-1a1b1002cfdb	a8d5e6fe-8ab3-4857-ac59-0ae07738dde8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
94a9e580-d03a-4d9c-b84a-b954e9b6ec8f	75ab8796-08cb-485d-b137-bdf246c84ad8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f8ebb28a-3898-4595-8c46-47f4174abf18	2b07e482-a787-4499-9737-fa3e488f19e0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
643a458d-63da-4490-ae79-d36802f9b902	63385ab9-f57a-4eae-a1ae-8212f114cc46	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d98d1f7f-98a5-4801-8a45-2192f1299c41	aee7e56c-06eb-476d-ac2f-f0faefcb2612	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5eb4eda9-87ff-45d2-8a73-51804bc750dc	eb4bc51c-9225-4b28-960e-4123e11315b3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6629c8f5-b02f-4b8c-a786-5e9ba4ee77c6	8da43065-d681-4a4d-9f4b-37bc6598d9dd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
22bec464-52ea-43c9-b5b3-029d94953192	5a4618e8-aefc-4721-8adc-ff442928090d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8a8bdc11-57b4-4417-9b54-1e8bbf3da5e7	83f33156-eeb2-4d6a-8b2c-195098119758	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2481a719-3b91-4818-9bbd-bc60498a914c	ea04f2bc-c054-4e92-bb94-dcb31404328c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0a994824-b030-4797-a62a-6f719321091f	cadb9055-fee2-4ff0-b0ca-8bac2bdf0fad	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f67129a5-a24e-4b2f-8f80-44dc49e4a8f7	eff016a7-9f02-46a2-aa39-3d5960c14801	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a48267f4-0af7-48dd-b43a-04c1474dd61d	b21f79c7-e15a-4794-beff-f4c353903d02	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e359ba7b-5209-4db1-82a6-1b7b4525e687	1c002e91-1a9a-4f13-b514-fd11af8c32fd	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0bcd9d14-7216-4127-af33-96a2629d593d	8c1caaf9-06f2-4808-82ac-f5d495bd19f5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
50356fdf-c2f4-4a16-abdf-f92adb13ec79	95df44c1-644f-437e-9c39-989caff18ee4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1d9f7278-af54-40e2-b81f-d13dfe27d6ca	56bb757e-7427-4bf2-afdc-7669b7cb4afc	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d4eb1d5e-50fb-4ba8-aad5-bc41123ab7b8	5832257f-6aaf-4691-889b-d919e8a15159	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8a438041-00c0-4e05-a95f-05f6a0705fa7	3b779396-977e-48e6-9b33-9bc06991cbcc	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b8726829-c8d4-412c-bb0a-7fcc547498d2	65195257-f380-42b6-8127-c150f31de68d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e86b0bf7-894f-45fc-96af-bd58c1dc6f60	4842a628-3350-41c8-a922-53a20eb6d466	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ccc21b05-eba5-423a-9d25-89d95d929419	743f2f5f-4505-4ce5-b7f4-bbf026f091b7	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c458fe43-3aac-4a2c-8fbe-1d814d948172	fc41f84f-3f3e-4a3b-b359-24f8b5f78d18	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
03b1d3e0-a2ea-4cab-89a1-1d3dbdac166b	3b6db43c-5d62-4098-a9c6-605909db5458	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ba019474-5d2f-4382-89c3-43efb588d50c	5dbf9540-1fec-4b79-a68a-0e39c1ce080f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
14651bad-2881-4ebf-874a-b42e5b96ba53	8eac503f-e6d2-4c82-9e2f-e56768b39dce	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6b33c95f-f079-47e4-927e-9e0400186455	d3c8a85d-280a-4946-a3cd-2b6cdff818d3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3afe840d-110d-4f9b-bb08-212b21b9f48b	86a164b6-9f2b-486a-b5c3-6435267a18c6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5b186871-7b5c-470f-8dc9-37bc69b7a144	5c164465-cecd-4316-a815-cf15782ff02e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e0262153-42f6-45aa-9ea9-d172ef4597d7	39436356-5c3a-4585-908f-787060c070a0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b6125fd0-3b0d-48d6-9600-aa58cd466d13	a4b0d8f0-748f-45b4-bc42-4df697153b3e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
71cf016c-bdc9-4549-8ba6-1d29155b29fe	d780d7e8-a438-400e-bc62-fd2d5e8b1084	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
00205623-25e1-440b-bd7e-6569f36fecec	cae477f4-9d6d-45d3-bfc7-b5f10ad444f2	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
133127eb-f627-46de-beab-e036be6b8c96	2c067a6e-ca86-4f79-af33-a945a4c36a22	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1b3391fb-cd58-42c5-8dc9-0b79cb28cee0	4a33f4a4-578c-428a-9c69-e8a5aa3ec214	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
80a99177-10b7-4a8a-bd84-dbfecd0b3c2e	47dbcc5a-cbea-4dab-89b3-c6593167ec4c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0e662fb1-977c-4116-9f2f-5fd545531242	b7002a26-912e-4d4d-b1bb-c5dd5e7bdb3d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f0d48989-bb2b-40d1-8a66-b3a0ea8e2b91	efe098ee-f980-48fe-9967-a272a2089e34	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
b1fb7b91-f4fc-4031-a249-d88db5ec084e	5bec3a86-6382-4904-8a0a-9431a935c98b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
436f534b-2bfb-4fed-ac27-c37afc9c0cc1	e52dd3be-fefa-4a0e-ac20-d4d3e3e54add	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c3c5bfc4-a687-4413-8e1c-9b055ce63a33	2ccff11d-cf6e-47e9-b39a-db4e7faf84ee	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
7a575621-fabc-4750-962b-64836443fbad	46d109f1-b3b5-4e07-9baf-b248212be5fe	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
59a79395-56cf-4f37-a3ad-3f960dba1b3a	88693b5e-94e7-4d47-acbc-5bd01eba1786	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
240653f3-bc4c-4e08-8b2d-4764a554aaef	4293c7dd-3b02-4e12-afef-e569b5df2618	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
0c150770-e72e-4e9a-af27-93ed200a4195	f234686a-2e28-4e40-83e9-e50af8375e59	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
22eca9b6-aa46-4229-a697-296167be6551	de156325-2b12-4304-a79d-919ff71ad136	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
a93fad0a-704d-4210-b296-59ead0437d38	135cbcba-86fc-434f-b1fd-e9377b2e837d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
723d11b1-43b7-4e2b-8301-a810b90134a5	8c413eeb-cd86-460e-8200-7806e64cecd3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
4d295ad0-1979-46a7-9c04-2e7ac48fa209	a64192e5-d445-4165-9af6-6273a9ca7fe0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
fce4bd8b-fe24-4a6f-9dd3-3d6bfd640793	596933a1-a00e-44b1-b9a9-7c223faa26d4	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3f85b42e-ddf0-4e75-b220-1d5f9f29a52b	cdc3b737-dc61-47f2-a64c-41e14d86ebd9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a8d6b22e-61b5-48f7-92af-acb4bf78dc7d	14ce4c73-d741-4244-8616-6692f081937e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8d6a4687-8d9f-469d-82c1-484cdc22727d	5606193d-7fd1-43be-994c-4f50d1d6e574	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f25698ac-923f-4c7d-b2c7-487d13076d8b	99acce96-4964-4e91-a278-4041df40e9f6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0d9949e9-0a70-4d94-81de-3c91aedc3455	7f842dd9-aa48-44d8-8384-4101244729da	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0ce70bb6-482f-4ca7-abc0-20d608b1e534	bd1d27e6-96cc-4a97-92bd-384228885c83	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d534c51d-be61-4987-a35c-5582a8be878d	e881e184-4253-4393-94b2-8ec4da61b63f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
cb9bd302-055e-4f46-8522-a7141136bba3	e4df8c0d-98c5-4788-96b3-1c10c9d91209	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0ba2474a-a2b1-4951-be91-e54b72f56095	5cf9a03f-7e66-48af-9327-2dc4f39e7c01	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c01f5920-c1cc-4d47-8f74-a41c6a74cc02	04dc13a7-cad6-4295-97b6-5ba171cfc70f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
116b257f-77f5-4f17-8ab1-73b512d03dd7	51ce9950-fab6-4e3b-a5b6-a545ec5f21f6	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a39dd9b9-2774-46e2-9c66-50ddb4f454a3	3cb1ecc3-11b3-4fec-8462-0ad21bda2969	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5af2e7ab-04b0-427e-a7c9-da7d9342a0e8	08261c43-f1a0-48ce-81fa-3a83731349b1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6ca8b918-d7ef-43ba-a6a3-3adca6cd746a	453386c3-3c95-4211-922c-6205eedf7506	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a172b722-394d-4308-9804-7a460face066	c7508cda-2d43-465e-9433-814f0b71d4a1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7125d6a4-ac87-47b9-a0f3-84e51b54075c	cf37b8d5-c6fe-456b-922d-70da288be1ab	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
aa3f8299-535c-4a06-995e-35ef21f0a2c9	d7588e22-a304-411e-9dd4-7b5afbd6d5d0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6196b80d-c336-4f5c-b371-830da065d13b	0ba5eb77-b00a-4890-8527-af723e8c50eb	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3cc9e1c9-e184-46cb-b067-a6cdf2e2707e	ce9241f6-12bf-4e79-a45a-e1b3715efe61	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
495a9c16-f790-4e11-90f8-dff69a18b7fe	41c1add6-fb64-4b6e-9774-dc8bf78f285c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
37ebd733-9098-438d-b0f6-aad2ffca40ce	27d9eec0-70c2-41c8-b973-524a1fde24ad	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
7d07050d-bf9d-472e-8ba7-c4754f26110e	1cf3c0ed-c3ff-42f9-a1ca-05d9df9083f8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
107d5476-798a-4eef-ab6c-4cba4fb1664c	76c01c2d-3f19-427b-b102-c3e2c00ca822	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f3559a7d-e26b-4868-aca6-a689240b9a41	2e9a7a6a-01c2-45bc-aa9c-4d46323456bb	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d69917dc-94e1-4722-a255-6a0735f98077	a982727a-c8b0-4c06-bc58-522c2d67dbcc	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
add27090-618b-492f-9ec2-e3c7b57312a7	90966ad9-4d11-4371-8e14-013a22b0a8a8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
46e0d3ea-f39d-40af-b82f-74a3d9d3d7f8	6bd94a35-d4e4-48e8-9fc9-728df5ebdd0b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
253cbcf3-ce95-43b6-8f05-9933236ad2f9	50c2ccac-773d-4efb-a8ea-671b83a02cbf	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
57809c25-7030-4ab1-87cb-44c9655bb3a7	7eb04b9d-202f-45d0-b49f-a67cc19307f5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
ac76238a-fde8-4af4-ab70-17504b781d6b	d4406f37-d9f9-4759-a2f4-8288a2ed7545	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e7307aeb-c935-4ea4-a402-94041840bb3b	141a5e0a-4c66-4a5e-b027-72c7a3dee8ac	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
18f6fb3e-0df1-4494-ad4b-f459a89d6099	fd38eafe-608a-4b8b-ad35-0817f95f794f	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
c1d584df-2790-4848-8bd5-3f168c5debd7	5bc76a2a-8d9b-45a2-940a-eb5832c12b08	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
0584fe92-ed30-426c-b330-87803c7fb969	3b9842e9-2d1f-4b4a-8538-fbe9912851d9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
eba2f598-166c-4560-8a13-f05f06286b0f	71f64ffc-3a7e-43ae-a42f-5f2afe70971d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
43431752-a767-421d-b504-2b93e5b30e29	c1b034ce-3854-429c-9422-ffb7dc34c61d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a442a905-1a7e-466c-ba68-b9f58bf723c2	a4efb55b-125c-4e53-8520-c1d1657def53	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
08d43945-fff0-4aa0-8a09-a6a8df0026fc	90df177a-63af-44a9-bf2c-8a1d3623fb64	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
a263fb07-69c7-4e70-a657-e5ac94dc746f	a932f0a0-a551-407f-a812-9eda4c4eac9e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
7a29aae3-03d3-44f8-86b0-2b7e83fc3a16	ba214d46-0090-43ad-8768-9558a6af5fcf	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
d3ac2d17-2f93-4873-9c04-4a843fb57a6b	b9f23216-9065-44f4-856e-a254a57c20e0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
2fe8733c-16aa-4294-9c88-fa3caa6ca7ea	5837bbb0-db1e-4388-a7b4-6ec8dde4be45	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
d1073117-5d1e-450f-ac09-3cb2f623c17e	6d65e611-1921-4a04-b457-71e01531975c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
ffeb8a98-b10a-46ab-8331-56170e71bdc0	95af0725-7f7b-4d25-9331-c16f872ad683	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
56f350fc-11f0-4a57-9cc5-fe45d99bd8bb	39e5a7fa-96cb-4c1b-b05d-825db0801594	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
5b399012-2c26-45f8-97d0-3e726ff66d94	ef095ef5-d3a6-446b-beb5-eae3e3066aff	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
53c0f4b5-0d27-4d94-a084-12b4d17da181	0b58fb0f-aa97-46ae-b245-ebf99e354c26	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3f2995fb-4862-40f2-b599-6f42863f49aa	b317dc0d-8a62-4185-b81f-58f8ce10f677	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8ab6d6a3-f81e-4f8f-a33d-b6541593e808	abf49f90-3508-4a79-8291-7285b2f35eaf	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8128f816-3f15-4592-8cdc-14f690082a2c	b21517fa-4431-4711-beb2-a92639c62ea5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
fea0719e-5b97-42f6-b671-c34c5b73abbf	e4315c27-31f4-4e8c-acc7-8a43755e1370	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3a901d41-5b5c-4090-967b-e357ac19f8ba	784ccd58-c05b-407c-88cf-dc302be8050d	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
86b4f647-d761-4c90-a9db-eb9cfb0bdfce	65ae22f8-78da-48de-b395-ef8a054117f5	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
fb415261-f15d-40e3-8311-0f68a79c9865	14301816-4f12-486b-8f7c-06a95ed5011b	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
a1a524dd-fc21-4736-9b70-10c3226ac01a	e4179653-bf67-4863-885a-005fe38d63e1	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
c9c1f5d5-b8f9-4d00-8861-12f0f92a5b1c	7dac64a8-dbeb-4200-9ddc-3cce519d268c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
3767bf19-8c67-4e00-9223-a0a47a3e2cdb	041a8159-b1a2-4b4e-984e-dfa10a7183b8	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
24ec01a8-ee14-4e46-8a8c-ba2109cf9a85	ae9514c5-f98e-467d-9971-3a710a0eb8f9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
8ec3b7e0-a914-4c88-a51a-327f37f5885b	c0724b90-69b6-4cd1-997e-e5b34f96d23a	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
78ac254b-0b43-4cba-b9e5-6420534e37a5	5f755450-77f2-4464-92eb-2603af8bb620	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
e5396969-9a94-460d-aaf9-6fdfcd5abcb4	f3f82d23-b44c-4229-b616-e7fa7419cafa	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
4c71ec40-9ede-44e3-bf72-a95686a5d4d0	a97a215d-523e-4f91-8367-44d18fefd38c	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
1647a9e0-6c33-4d59-9e6b-cdfa22a57505	65488a08-d482-4264-a0c2-f8bd06ef4a4e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
56f9d547-c1e6-4c7b-b64c-0ccea58a3540	2635b358-7f08-4993-9778-d8e0effc64ec	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
bdaf1fdd-abfd-4d42-b1ab-421a8a1b7722	c6c56895-34ef-4d72-a81b-7c7edd0f7001	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
6d4e702f-7016-4e41-9517-7764ddf28041	95ff4110-38f2-45ea-9590-7c4b98d42ed3	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
2d6ed3bb-4dc9-4f80-899f-804620744980	edc723c1-5850-4b0d-8336-441378903b91	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
495a5d56-1e22-4b50-a4c9-b7219f83a7f5	ef5b612a-a6b9-48a5-8571-236f3dbea130	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
d0173549-944b-4c7e-97a2-1d7259f1e806	b1da8b11-223d-4732-8017-3f719038dae0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
fdb61ece-4c67-45e7-a2d0-7b6fa1253bd7	48021ea1-c7ba-4304-bf41-3ac7411be99e	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
f84e3fc0-9a60-47f2-a83d-86af6e70c912	70f6ad5f-a716-491d-9fdf-b2d87bf73ba0	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
956d0ece-c194-4e53-991e-8d2146da0d1b	70395ad1-0a15-4b1a-b28a-8d6b9c211013	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	deleted	user	admin
555b2fb5-a43a-481e-a5d7-8f7da0f7568a	2e573b25-7383-4777-be3d-af71c9b771d9	de37ad6d-002f-47fc-913e-58ff407296e0	deleted	package	organization
0c02c55e-de1a-40ed-a363-54c17f025730	2e573b25-7383-4777-be3d-af71c9b771d9	a9a3eae6-cb4a-4b36-8043-79511cb15571	deleted	package	organization
71c1ec14-5d02-489b-9be3-2f558a750531	2e573b25-7383-4777-be3d-af71c9b771d9	f76126e1-3772-4d15-bf64-d48962df77e7	deleted	package	organization
b5a7c8e3-a18b-4576-80df-7a4ea24e9a2a	2e573b25-7383-4777-be3d-af71c9b771d9	554881bd-aaad-4f06-9fc5-0940b3bc90dd	deleted	package	organization
c7afd0dd-be66-4f41-a4bd-9eca488f876c	2e573b25-7383-4777-be3d-af71c9b771d9	0c5925a7-be8b-48b3-b58d-25bad96b58ba	deleted	package	organization
c1bd79d4-c3fd-4bf5-be8b-25af4c18d359	2e573b25-7383-4777-be3d-af71c9b771d9	0586194d-3acc-47f5-a9dd-ffd6dad8dc80	active	package	organization
885797c4-1f32-4899-8d28-05ab5807383c	2e573b25-7383-4777-be3d-af71c9b771d9	4a1e1de9-4100-4716-903e-21da4bcd4ece	active	package	organization
9f9b3a7e-9484-4088-ada8-0f9ecb6ed4cc	e83539a2-a0bc-49c3-8502-f0eff7de87b9	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	active	user	admin
4bcb5b25-05b1-4fad-95f8-786c04aa1057	e83539a2-a0bc-49c3-8502-f0eff7de87b9	95b1c645-ddc0-4cb7-8198-803bdf78d109	active	package	organization
8ffb5151-d9ee-4326-b3d5-3f484d2d49cb	e83539a2-a0bc-49c3-8502-f0eff7de87b9	d1af5e43-a9ac-4266-8797-61774039d9ce	active	package	organization
68868e37-8350-4f9a-a151-50c6935a83ba	e83539a2-a0bc-49c3-8502-f0eff7de87b9	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	active	package	organization
52839dc3-d2a5-4aad-8d36-d96cb3576645	e83539a2-a0bc-49c3-8502-f0eff7de87b9	ff2a7a56-333b-477f-b51d-0cea766e2065	active	package	organization
ed95b765-407d-4456-a5f7-8828ebe81d80	e83539a2-a0bc-49c3-8502-f0eff7de87b9	9811ed68-164d-413d-bb38-4a43985b7f27	active	package	organization
e0c3de90-e938-419f-9c1e-ab46c4e6b366	e83539a2-a0bc-49c3-8502-f0eff7de87b9	1d0e3358-195f-49a7-bf1c-8f91634952f0	active	package	organization
1e80dbe4-33b8-471b-8db5-858f0e7741f1	e83539a2-a0bc-49c3-8502-f0eff7de87b9	3d6d1f15-9ade-4d65-8e4d-7c47ff3ec391	active	package	organization
5c418696-f4d2-471b-8b54-fb4f52d72419	e83539a2-a0bc-49c3-8502-f0eff7de87b9	0f0df252-0d80-42f0-9438-3d7f056c3f62	active	package	organization
fa325ded-c1e7-4c6f-85e2-1687ac8f80b4	e83539a2-a0bc-49c3-8502-f0eff7de87b9	c2cf9f76-94bc-4ac3-a031-3c7d049a8332	active	package	organization
d9ad622a-d2d0-467e-9493-d47a5ee54a59	e83539a2-a0bc-49c3-8502-f0eff7de87b9	6b81344e-8b2b-43c6-9d3c-7cbc34f9eb33	active	package	organization
33863178-f0c6-4b95-be3e-85f53f807c17	e83539a2-a0bc-49c3-8502-f0eff7de87b9	83bb0f87-8e4c-4f34-bc3a-83abbc2432d5	active	package	organization
6bfcac4c-adf9-4c4b-b1bf-ae03484abcde	e83539a2-a0bc-49c3-8502-f0eff7de87b9	2d1f79c3-6ad1-424a-a6e2-48cb405e11bf	active	package	organization
11fbda14-ae71-4220-b04b-051404a9c703	e83539a2-a0bc-49c3-8502-f0eff7de87b9	6632bcda-d909-4a34-9f2d-9bec1d3198dd	active	package	organization
250a7ec5-1db2-4ae3-9cb3-dbabb4a7f0a3	e83539a2-a0bc-49c3-8502-f0eff7de87b9	746a8dda-4152-43e5-bd24-9ddba814be52	active	package	organization
9f95590c-4674-4a71-95ef-3d72984e8bab	e83539a2-a0bc-49c3-8502-f0eff7de87b9	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497	active	package	organization
25d1254f-75f6-4e3d-852c-e5e15097a599	e83539a2-a0bc-49c3-8502-f0eff7de87b9	23709528-2e6b-48f8-a412-3b93612b80c6	active	package	organization
30a3d33f-6f65-41d1-8d0a-2861bce18207	e83539a2-a0bc-49c3-8502-f0eff7de87b9	8cfb4d21-ca59-4e78-a48b-9d0bdadf15c6	active	package	organization
06af2bfe-c784-4fe3-b7df-afa229f8044d	e83539a2-a0bc-49c3-8502-f0eff7de87b9	d9f6dd4f-f254-4e96-a466-1654a4b06449	active	package	organization
897c9c81-9d04-4193-808e-766e255fd10f	e83539a2-a0bc-49c3-8502-f0eff7de87b9	55991d34-aa45-4ea7-a977-c70fbba37890	active	package	organization
d2299fe6-9d5e-4520-a78d-a5a31143ef40	e83539a2-a0bc-49c3-8502-f0eff7de87b9	028ab429-14fe-491a-a255-c2f7e80c7f4c	active	package	organization
432cc66e-9ab1-40ab-a4b0-8789c36c9be8	e83539a2-a0bc-49c3-8502-f0eff7de87b9	3b773a9f-1bc6-43de-b357-02adfb275230	active	package	organization
9cde89d2-d9e0-463b-82d4-2aa431cf1632	e83539a2-a0bc-49c3-8502-f0eff7de87b9	e7fd1d07-886e-4140-b09c-168d019d22c0	active	package	organization
9fb5877d-63ec-40dc-89c7-323dc7df4cb9	e83539a2-a0bc-49c3-8502-f0eff7de87b9	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	active	package	organization
8d123e07-bd10-4683-8cf5-1551ce51f2d4	e83539a2-a0bc-49c3-8502-f0eff7de87b9	fbf63ee1-5ffe-41ee-9732-a47889ed8e69	active	package	organization
d9b7186a-2102-483f-9291-0f1ecca6c159	e83539a2-a0bc-49c3-8502-f0eff7de87b9	8dc24d5d-aaa6-498c-b204-2317dec0460e	active	package	organization
0717e2d4-9a60-479a-93b4-78f20c2721e9	e83539a2-a0bc-49c3-8502-f0eff7de87b9	31dc8a44-e9b7-44e8-821a-5c602b7c1d00	active	package	organization
d9fe5be7-f7b9-4335-aeaf-6de33c8ee584	e83539a2-a0bc-49c3-8502-f0eff7de87b9	4571b411-cc4e-408a-8fc0-4454f5694fd0	active	package	organization
3edb5c75-df6d-44ec-8340-b9ff1e6054d1	e83539a2-a0bc-49c3-8502-f0eff7de87b9	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	active	package	organization
349671e4-0a72-4006-932c-8fce720df8c6	e83539a2-a0bc-49c3-8502-f0eff7de87b9	02312a9e-957d-4546-b477-34f40c752534	active	package	organization
24462ad6-1291-4f66-a71b-3a1a50a164b1	e83539a2-a0bc-49c3-8502-f0eff7de87b9	7591d5e4-f147-46ac-81d4-458e33ba5ddc	active	package	organization
2e6c7146-d077-422e-9c91-11c8cc069264	e83539a2-a0bc-49c3-8502-f0eff7de87b9	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2	active	package	organization
5c82df26-f3fd-4fa7-a0d5-56f86af62501	e83539a2-a0bc-49c3-8502-f0eff7de87b9	ad269608-4984-404e-8263-d093d89d404c	active	package	organization
04a21799-24d2-4e07-9fdc-214c7d40733b	e83539a2-a0bc-49c3-8502-f0eff7de87b9	703c1db6-eeb8-40a6-b42b-f784b690c669	active	package	organization
95051b3b-72fa-4be3-bcb9-db9931db83bb	e83539a2-a0bc-49c3-8502-f0eff7de87b9	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd	active	package	organization
\.


--
-- Data for Name: member_revision; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.member_revision (id, table_id, group_id, state, revision_id, continuity_id, expired_id, revision_timestamp, expired_timestamp, current, table_name, capacity) FROM stdin;
\.


--
-- Data for Name: package; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.package (id, name, title, version, url, notes, author, author_email, maintainer, maintainer_email, state, license_id, type, owner_org, private, metadata_modified, creator_user_id, metadata_created, plugin_data) FROM stdin;
de37ad6d-002f-47fc-913e-58ff407296e0	de37ad6d-002f-47fc-913e-58ff407296e0	OBIS: Incorporation of eDNA data	1.0	https://doi.org/10.5281/zenodo.11464531	<p>The Ocean Biodiversity Information System (OBIS) is an international initiative for open biodiversity science. Although OBIS primarily known for their data aggregation platforms, OBIS represents vibrant communities who are very engaged in developing the necessary standards and practices to make biodiversity observations FAIR, regardless of the data type. Matt will give an overview of OBIS, including context for how it relates to the United States. He will discuss the benefits of using the ready-made standards and platforms for publishing and share the resources that are available for learning how to publish. There will be a special focus on publishing metabarcoding/eDNA data.</p>	\N	\N	\N	\N	deleted	notspecified	dataset	2e573b25-7383-4777-be3d-af71c9b771d9	f	2025-09-22 18:13:53.309137	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 18:13:53.309131	\N
a9a3eae6-cb4a-4b36-8043-79511cb15571	obis-incorporation-of-edna-data-1	OBIS: Incorporation of eDNA data	1.0	https://doi.org/10.5281/zenodo.11464531	<p>The Ocean Biodiversity Information System (OBIS) is an international initiative for open biodiversity science. Although OBIS primarily known for their data aggregation platforms, OBIS represents vibrant communities who are very engaged in developing the necessary standards and practices to make biodiversity observations FAIR, regardless of the data type. Matt will give an overview of OBIS, including context for how it relates to the United States. He will discuss the benefits of using the ready-made standards and platforms for publishing and share the resources that are available for learning how to publish. There will be a special focus on publishing metabarcoding/eDNA data.</p>	\N	\N	Steve Formel	steve@formeldataservices.com	deleted	cc-by	dataset	2e573b25-7383-4777-be3d-af71c9b771d9	f	2025-09-22 21:40:21.583071	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 18:22:58.55719	\N
f76126e1-3772-4d15-bf64-d48962df77e7	f76126e1-3772-4d15-bf64-d48962df77e7	OBIS: Incorporation of eDNA data	1.0	https://doi.org/10.5281/zenodo.11464531	<p>The Ocean Biodiversity Information System (OBIS) is an international initiative for open biodiversity science. Although OBIS primarily known for their data aggregation platforms, OBIS represents vibrant communities who are very engaged in developing the necessary standards and practices to make biodiversity observations FAIR, regardless of the data type. Matt will give an overview of OBIS, including context for how it relates to the United States. He will discuss the benefits of using the ready-made standards and platforms for publishing and share the resources that are available for learning how to publish. There will be a special focus on publishing metabarcoding/eDNA data.</p>	\N	\N	Steve Formel	steve@formeldataservices.com	deleted	cc-by	dataset	2e573b25-7383-4777-be3d-af71c9b771d9	f	2025-09-23 13:43:27.188976	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-22 21:46:54.040634	\N
c2cf9f76-94bc-4ac3-a031-3c7d049a8332	h3_indicators	H3_indicators	v0.7	https://doi.org/10.5281/zenodo.15113967	Notebooks and documentation about computing H3 biodiversity indicators.	\N	\N	\N	\N	active	cc-zero	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:34.916107	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:34.916102	\N
6b81344e-8b2b-43c6-9d3c-7cbc34f9eb33	hackinglimno2025	HackingLimno2025	v1.0	https://doi.org/10.5281/zenodo.15924033	The Global Ocean Observing System (GOOS), with NOAA's U.S. Integrated Ocean Observing System (IOOS) as part of it, uses Biological and Ecological Essential Ocean Variables (BioEco EOVs) to standardize ocean observing data from communities like the Marine Biodiversity Observation Network (MBON). The GOOS Biology and BioEco Variables focus on the abundance and distribution of key aquatic organisms. Using predefined lists of species, one can query biological occurrence data from the Ocean Biodiversity Information System (OBIS) and the Global Biodiversity Information Facility (GBIF). After querying, users can analyze OBIS and GBIF occurrence data to study the abundance and distribution of these BioEco Variables. This occurrence data can then be combined with gridded and tabular environmental data served by ERDDAP to further analyze into products (e.g. species distribution models). In this workshop we will demonstrate the tools and techniques for assessing ecosystem health using this open science framework.	\N	\N	\N	\N	active	cc-zero	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:36.036896	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:36.036891	\N
83bb0f87-8e4c-4f34-bc3a-83abbc2432d5	mangroveobs_v10	Mangroveobs_v1.0	Mangroveobs	https://doi.org/10.5281/zenodo.15836332	<p>This contains the R script used for acquiring, curating and analysing observation data of major true mangrove species for the article "A critical appraisal of occurrence data in OBIS and GBIF databases: a case study on true mangrove species" (DOI: 10.5343/bms.2024.0022).<br><br>8 Jul 2025: A R file (Mangroveobs_GBIFOBIS.R) is added.</p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:37.204237	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:37.204232	\N
2d1f79c3-6ad1-424a-a6e2-48cb405e11bf	dasco-workflow-for-downscaling-alien-species-check	DASCO workflow for downscaling alien species checklists using occurrence records	v1.0.1	https://doi.org/10.5281/zenodo.5841930	<p>The DASCO workflow has been designed to integrate regional checklists of alien species occurrences and occurrence records provided by GBIF and OBIS to identify coordinate-based occurrences of alien populations. It can therefore be used to downscale information available in regional checklists and to re-allocate species occurrences to any spatial categorisation, which is provided by the user.</p>\n<p>The DASCO workflow is written in R and open access. The workflow is described together with a global case study&nbsp; in a peer-reviewed publication (see below) together with a manual.</p>\n<p>When using any components of the workflow, please cite the following publication:</p>\n<p>Seebens H, Kaplan E (2022) DASCO: A workflow to downscale alien species checklists using occurrence records and to re-allocate species distributions across realms. NeoBiota 74: 75-91. <span><a href="https://doi.org/10.3897/neobiota.74.81082" target="_blank" rel="noopener">https://doi.org/10.3897/neobiota.74.81082</a></span></p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:38.337544	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:38.337538	\N
55991d34-aa45-4ea7-a977-c70fbba37890	temperature-effects-on-the-distribution-of-aragoni	Temperature effects on the distribution of aragonitic and calcite-secreting epifaunal bivalves	1.0	https://doi.org/10.5281/zenodo.5494452	<p>This dataset contains the necessary data and code to reproduce the analyses shown in the manuscript "Temperature effects on the distribution of aragonitic and calcite-secreting epifaunal bivalves".</p>\n<p>To prepare the OBIS data from the original download for the analysis, using R, it is necessary to 1. deposit the files in the "data" folder in the R working directory, 2. run the script "worms_prepare.R", 3. run the script "obis_data_prepare.R".</p>\n<p>To directly run the analyses with the cleaned data set, proceed from 1. with the R scripts corresponding to the figures shown in the manuscript.</p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:47.459012	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:47.459007	\N
028ab429-14fe-491a-a255-c2f7e80c7f4c	occurrence-record-dataset-from-depth-matters-for-m	Occurrence Record Dataset from "Depth Matters for Marine Biodiversity"	1.0	https://doi.org/10.5281/zenodo.16739002	<p>This is the final occurrence record dataset produced for the manuscript "Depth Matters for Marine Biodiversity". Detailed methods for the creation of the dataset, below, have been excerpted from Appendix I: Extended Methods. Detailed citations for the occurrence datasets from which these data were derived can also be foud in Appedix I of the manuscript.</p>\n<p><span>We first assembled a list of all recognized species of fishes from the orders Scombiformes</span><span> (Betancur-R et al., 2017)</span><span>, Gadiformes, and Beloniformes by accessing FishBase</span><span> (Boettiger et al., 2012; Froese &amp; Pauly, 2017)</span><span> and the Ocean Biodiversity Information System (OBIS; </span><span>OBIS, 2022; Provoost &amp; Bosch, 2019)</span><span> through queries in R</span><span> (R Core Team, 2021)</span><span>. Species were considered Atlantic if their FishBase distribution or occurrence records on OBIS included any area within the Atlantic or Mediterranean major fishing regions as defined by the Food and Agriculture Organization of the United Nations (FAO Regions 21, 27, 31, 34, 37, 41, 47, and 48;</span><span> FAO, 2020)</span><span>. The database query script can be found on the project code repository (</span><a href="https://github.com/hannahlowens/3DFishRichness/blob/main/1_OccurrenceSearch.R"><span>https://github.com/hannahlowens/3DFishRichness/blob/main/1_OccurrenceSearch.R</span></a><span>). We then curated the list of names to resolve discrepancies in taxonomy and known distributions through comparison with the Eschmeyer Catalog of Fishes</span><span> (Eschmeyer &amp; Fricke, 2015)</span><span>&nbsp;, accessed in September of 2020, as our ultimate taxonomic authority. The resulting list of species was then mapped onto the Global Biodiversity Information Facility&rsquo;s backbone taxonomy</span><span> (Chamberlain et al., 2021; GBIF.org, 2020a)</span><span> to ensure taxonomic concurrence across databases (Supplementary Table 1). The final taxonomic list was used to download occurrence records from OBIS</span><span> (OBIS, 2022)</span><span> and GBIF</span><span> (GBIF.org, 2020b)</span><span> in R through <em>robis</em></span><span> (Provoost &amp; Bosch, 2019)</span><span> and <em>occCite</em></span><span> (Owens et al., 2021)</span><span>. </span></p>\n<p><span><span>&nbsp;</span>For each species, duplicate points were removed from two- and three-dimensional species occurrence datasets separately, and inaccurate depth records were removed from 3D datasets (all records with and without depth information were retained for the 2D dataset). Depth records were based on the &ldquo;depth&rdquo; field in both the GBIF and OBIS datasets, which define the field as &ldquo;depth below the surface in meters&rdquo;. We chose this value over incorporating information from &ldquo;minimumDepthInMeters&rdquo; and &ldquo;maximumDepthInMeters&rdquo; because more records contained information from the &ldquo;depth&rdquo; field than either of the two other fields (although when these fields were both supplied, &ldquo;depth&rdquo; appears to have been often, but not always, derived by calculated the mean between minimum and maximum depth). We also initially included the &ldquo;depthAccuracy&rdquo; field from both datasets but did not ultimately use this field as it was not complete enough to be useful. Instead, we determined depth inaccuracy based on extreme statistical outliers (values greater than 2 or less than -2 when occurrence depths were centered and scaled), depths that exceeded bathymetry at occurrence coordinates, and occurrence depths far outside known depth ranges obtained from FishBase, Eschmeyer&rsquo;s Catalog of Fishes, and/or congeneric depth ranges in the dataset. Once the resulting data were mapped and curated to remove records with putatively spurious coordinates, under-sampled regions and species were augmented with data from publicly available digital museum collection databases not served through OBIS or GBIF, as well as a literature search. Finally, for datasets with more than 20 points remaining after data curation, occurrence data were downsampled to the resolution of the environmental data; that is, to 1 point per 1 degree grid cell in the 2D dataset, and to one point per depth slice per 1 degree grid cell in the 3D dataset. </span></p>\n<p>&nbsp;</p>\n<p>References:</p>\n<p>Betancur-R, R., Wiley, E. O., Arratia, G., Acero, A., Bailly, N., Miya, M., Lecointre, G., &amp; Ort&iacute;, G. (2017). Phylogenetic classification of bony fishes. <em>BMC Evolutionary Biology</em>, <em>17</em>(1), 162. <a href="https://doi.org/10.1186/s12862-017-0958-3">https://doi.org/10.1186/s12862-017-0958-3</a></p>\n<p>Boettiger, C., Lang, D. T., &amp; Wainwright, P. C. (2012). rfishbase: exploring, manipulating and visualizing FishBase data from R. <em>Journal of Fish Biology</em>, <em>81</em>(6), 2030&ndash;2039. <a href="https://doi.org/10.1111/j.1095-8649.2012.03464.x">https://doi.org/10.1111/j.1095-8649.2012.03464.x</a></p>\n<p>Chamberlain, S., Barve, V., McGlinn, D., Oldoni, D., Desmet, P., Geffert, L., &amp; Ram, K. (2021). <em>rgbif: Interface to the Global Biodiversity Information Facility API</em>. <a href="https://CRAN.R-project.org/package=rgbif">https://CRAN.R-project.org/package=rgbif</a></p>\n<p>Eschmeyer, &amp; Fricke, W. N. &amp;. (2015). Taxonomic checklist of fish species listed in the CITES Appendices and EC Regulation 338/97 (Elasmobranchii, Actinopteri, Coelacanthi, and Dipneusti, except the genus Hippocampus). <em>Catalog of Fishes, Electronic Version</em>. Accessed September, 2020. <a href="https://www.calacademy.org/scientists/projects/eschmeyers-catalog-of-fishes">https://www.calacademy.org/scientists/projects/eschmeyers-catalog-of-fishes</a></p>\n<p>FAO. (2020). <em>FAO Major Fishing Areas</em>. United Nations Fisheries and Aquaculture Division. <a href="https://www.fao.org/fishery/en/collection/area">https://www.fao.org/fishery/en/collection/area</a></p>\n<p>Froese, R., &amp; Pauly, D. (2017). <em>FishBase</em>. Accessed September, 2022. www.fishbase.org</p>\n<p>GBIF.org. (2020a). <em>GBIF Backbone Taxonomy</em>. Accessed September, 2020. GBIF.org</p>\n<p>GBIF.org. (2020b). <em>GBIF Occurrence Download</em>. Accessed November, 2020. <a href="https://doi.org/10.15468">https://doi.org/10.15468</a></p>\n<p>OBIS. (2020). <em>Ocean Biodiversity Information System. Intergovernmental Oceanographic Commission of UNESCO</em>. Accessed November, 2020. www.obis.org</p>\n<p>Owens, H. L., Merow, C., Maitner, B. S., Kass, J. M., Barve, V., &amp; Guralnick, R. P. (2021). occCite: Tools for querying and managing large biodiversity occurrence datasets. <em>Ecography</em>, <em>44</em>(8), 1228&ndash;1235. <a href="https://doi.org/10.1111/ecog.05618">https://doi.org/10.1111/ecog.05618</a></p>\n<p>Provoost, P., &amp; Bosch, S. (2019). <em>robis: R Client to access data from the OBIS API</em>. <a href="https://cran.r-project.org/package=robis">https://cran.r-project.org/package=robis</a></p>\n<p>R Core Team. (2021). <em>R: A Language and Environment for Statistical Computing</em>. <a href="https://www.R-project.org/">https://www.R-project.org/</a></p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:48.586176	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:48.58617	\N
554881bd-aaad-4f06-9fc5-0940b3bc90dd	554881bd-aaad-4f06-9fc5-0940b3bc90dd	OBIS: Incorporation of eDNA data	1.0	https://doi.org/10.5281/zenodo.11464531	<p>The Ocean Biodiversity Information System (OBIS) is an international initiative for open biodiversity science. Although OBIS primarily known for their data aggregation platforms, OBIS represents vibrant communities who are very engaged in developing the necessary standards and practices to make biodiversity observations FAIR, regardless of the data type. Matt will give an overview of OBIS, including context for how it relates to the United States. He will discuss the benefits of using the ready-made standards and platforms for publishing and share the resources that are available for learning how to publish. There will be a special focus on publishing metabarcoding/eDNA data.</p>	\N	\N	Steve Formel	steve@formeldataservices.com	deleted	cc-by	dataset	2e573b25-7383-4777-be3d-af71c9b771d9	f	2025-09-23 14:15:36.347754	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 14:05:16.267241	\N
ff2a7a56-333b-477f-b51d-0cea766e2065	iobisobistools-version-009	iobis/obistools: version 0.0.9	v0.0.9	https://doi.org/10.5281/zenodo.3338213	<p>Fixes the OBIS API URLs.</p>	\N	\N	\N	\N	active	other-open	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:29.423483	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:29.423479	\N
0c5925a7-be8b-48b3-b58d-25bad96b58ba	0c5925a7-be8b-48b3-b58d-25bad96b58ba	OBIS: Incorporation of eDNA data	1.0	https://doi.org/10.5281/zenodo.11464531	<p>The Ocean Biodiversity Information System (OBIS) is an international initiative for open biodiversity science. Although OBIS primarily known for their data aggregation platforms, OBIS represents vibrant communities who are very engaged in developing the necessary standards and practices to make biodiversity observations FAIR, regardless of the data type. Matt will give an overview of OBIS, including context for how it relates to the United States. He will discuss the benefits of using the ready-made standards and platforms for publishing and share the resources that are available for learning how to publish. There will be a special focus on publishing metabarcoding/eDNA data.</p>	\N	\N	\N	\N	deleted	notspecified	dataset	2e573b25-7383-4777-be3d-af71c9b771d9	f	2025-09-23 14:41:35.167837	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 14:23:37.406457	\N
4a1e1de9-4100-4716-903e-21da4bcd4ece	manual-test	Manual Test	1.0	https://eovmetadata.obis.org	Thie is a manual Test.\r\n\r\n## Heading Test\r\nThe say that you _can_ use  **Markdown**\r\n\r\n- is it true?\r\n- or not?	\N	\N	Steve Formel	steve@formeldataservices.com	active	cc-zero	dataset	2e573b25-7383-4777-be3d-af71c9b771d9	f	2025-09-25 18:51:41.851503	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-25 18:50:20.727488	\N
9811ed68-164d-413d-bb38-4a43985b7f27	lumii-syslabobis-schemaextractor-v24	LUMII-Syslab/OBIS-SchemaExtractor: V2.4	V2.4	https://doi.org/10.5281/zenodo.11109585	OBIS Schema Extractor	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:30.464483	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:30.464478	\N
0586194d-3acc-47f5-a9dd-ffd6dad8dc80	obis-incorporation-of-edna-data	OBIS: Incorporation of eDNA data	1.0	https://doi.org/10.5281/zenodo.11464531	<p>The Ocean Biodiversity Information System (OBIS) is an international initiative for open biodiversity science. Although OBIS primarily known for their data aggregation platforms, OBIS represents vibrant communities who are very engaged in developing the necessary standards and practices to make biodiversity observations FAIR, regardless of the data type. Matt will give an overview of OBIS, including context for how it relates to the United States. He will discuss the benefits of using the ready-made standards and platforms for publishing and share the resources that are available for learning how to publish. There will be a special focus on publishing metabarcoding/eDNA data.</p>	\N	\N	Steve Formel	steve@formeldataservices.com	active	cc-nc	dataset	2e573b25-7383-4777-be3d-af71c9b771d9	f	2025-09-25 18:55:17.407174	7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	2025-09-23 14:51:38.168773	\N
95b1c645-ddc0-4cb7-8198-803bdf78d109	species-distribution-models-under-future-climate-s	Species distribution models under future climate scenarios	1.0	https://doi.org/10.5281/zenodo.1254293	<p>ATLAS work package 3 presentation at ATLAS 3rd General Assembly.</p>\n\n<p>&nbsp;</p>\n\n<p>Climate change is already a reality which is affecting marine species and habitats, although the nature and extent of species responses are still unclear (Pereira et al., 2010). The changes will affect even the most isolated ecosystems in earth, such as the deep-sea ecosystems. Recent works have warned about a possible fast acidification of the deep ocean in the next three decades which could seriously threat the survival of cold-water coral species (Perez et al., 2018). Furthermore, a growing number of fish species are shifting in mean latitude, depth or both (Perry et al., 2005). In this context, to identify species vulnerability to climate change as well as predict the most possible response to future scenarios is a key step in order to preserve this species for the future. In this work we have analysed how climate change will affect the distribution of 12 different deep-sea species (6 cold-water coral species and 6 fishes) using Species Distribution Models (SDMs). These models are correlative approaches which combine discrete distribution data and full spatial coverage of environmental information to explain and predict patterns of distribution (Elith and Leathwick, 2009). To build the models we have used the Ocean Biogeographic Information System (OBIS) database to download presence records of the 12 species and a set of terrain (static in time) and environmental layers (for present and future scenarios). The models for the 12 species showed an excellent or good performance according to the values of AUC and kappa. Depth was the most important variable in 11 of the 12 analysed species although environmental variables such as temperature, aragonite/calcite concentration, pH and the export flux of Particle Organic Carbon (POC) to seafloor were also important for most of the species. The other two terrain variables (slope and BPI) show none or very low contribution values for most of the models. Temperature and occasionally POC flux were the second most important variable for the fish species whereas aragonite (scleractinians) or calcite (gorgonians) concentration replace POC flux in coral species. The pH was also important for the gorgonians species but not for the scleractinians. MaxEnt results predict that the fish species including in our analyses could expand their distribution range to higher latitudes or deeper depths towards the year 2100. Coral species and especially gorgonians are according to our models the most vulnerable species to climate change in North Atlantic Ocean, with severe habitat loss in the 3 studies species. Lophelia pertusa also will suffer an important habitat loss according to our models. Because of possible biases in the presence records, uncertainties in the future climate scenarios, lack of important explanatory variables and coarse resolution caution must be exercised when interpreting these results.</p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:07:51.549228	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:07:51.549222	\N
1d0e3358-195f-49a7-bf1c-8f91634952f0	ulises-rosasobisdat-first-release	Ulises-Rosas/OBISdat: First release	v.1.0	https://doi.org/10.5281/zenodo.3378317	:globe_with_meridians: Wrapper for OBIS API	\N	\N	\N	\N	active	other-open	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:31.525376	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:31.525371	\N
d1af5e43-a9ac-4266-8797-61774039d9ce	supplementary-materials-for-glossa-a-user-friendly	Supplementary materials for "GLOSSA: a user-friendly R Shiny application for Bayesian machine learning analysis of marine species distribution"	1.0	https://doi.org/10.5281/zenodo.17177436	<p>This repository provides the supplementary code and data for the three worked examples presented in the manuscript "<em>GLOSSA: a user-friendly R Shiny application for Bayesian machine learning analysis of marine species distribution</em>". The GLOSSA website can be accessed at <a href="https://imares-group.github.io/glossa/">https://imares-group.github.io/glossa/</a>.&nbsp;Occurrence data for&nbsp;<em>Thunnus albacares</em> are available from OBIS (<a href="https://obis.org/taxon/127027">https://obis.org/taxon/127027</a>), for <em>Caretta caretta</em> from GBIF (<a href="https://doi.org/10.15468/dl.es7562">https://doi.org/10.15468/dl.es7562</a>), and for <em>Siganus luridus </em>from the GreekMarineICAS geodataset (<a href="https://doi.org/10.25607/t2smha">https://doi.org/10.25607/t2smha</a>).</p>	\N	\N	\N	\N	active	notspecified	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:26.969442	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:26.969437	\N
a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	qgis-map-and-r-code-accompanying-publication-on-th	QGIS Map and R code accompanying publication "On the paradox of thriving cold-water coral reefs in the food-limited deep sea".	1.0	https://doi.org/10.5281/zenodo.7825749	<p>QGIS map of Figure 3B-D, enabling to turn on/off layers for better visibility. To display the map in QGIS, open file &#39;CWC_Fig3.qgz&#39;; layers are stored in zip folder &#39;world_map.zip&#39; (if they do not open automatically, repair data source in QGIS by choosing the directory of the &#39;world_map.zip&#39; folder.</p>\n\n<p>R Code to plot Figures 4 &amp; 5, and code to download and clean obis data for cold-water corals.</p>\n\n<p>Please cite the original publication; citation will be added here upon acceptance of the Article.</p>\n\n<p>&nbsp;</p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:28.256655	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:28.25665	\N
3d6d1f15-9ade-4d65-8e4d-7c47ff3ec391	lumii-syslabdata-shape-server-schemas24-formattool	LUMII-Syslab/data-shape-server: Schemas24 format/toolset	v0.2.1	https://doi.org/10.5281/zenodo.11069027	<p>A version compatible with Schemas24 toolset (including releases of OBIS Schema Explorer and ViziQuer)</p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:32.630777	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:32.630771	\N
0f0df252-0d80-42f0-9438-3d7f056c3f62	iobisrobis-robis-2110	iobis/robis: robis 2.11.0	v2.11.0	https://doi.org/10.5281/zenodo.6969395	R client for the OBIS API	\N	\N	\N	\N	active	other-open	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:33.810561	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:33.810556	\N
6632bcda-d909-4a34-9f2d-9bec1d3198dd	biogeography-of-the-worlds-worst-invasive-species-	Biogeography of the world's worst invasive species has spatially-biased knowledge gaps but is predictable	1.0	https://doi.org/10.5281/zenodo.7036564	<p>The world's "100 worst invasive species" were listed in 2000. The list is taxonomically diverse and often cited (typically for single-species studies), and its species are frequently reported in global biodiversity databases. We acted on the principle that these notorious species should be well-reported to help answer two questions about global biogeography of invasive species (i.e., not just their invaded ranges): (1) "how are data distributed globally?" and (2) "what predicts diversity?" We collected location data for each of the 100 species from multiple databases; 95 had sufficient data for analyses. For question (1), we mapped global species richness and cumulative occurrences since 2000 in (0.5 degree)<sup>2</sup> grids. For question (2) we compared alternative regression models representing non-exclusive hypotheses for geography (i.e., spatial autocorrelation), sampling effort, climate, and anthropocentric effects.</p>\n<p>Reported locations of the invasive species were spatially-biased, leaving large gaps on multiple continents. Accordingly, species richness was best explained by both anthropocentric effects not often used in biogeographic models (Government Effectiveness, Voice &amp; Accountability, human population size) and typical natural factors (climate, geography; R<sup>2</sup> = 0.87). Cumulative occurrence was strongly related to anthropocentric effects (R<sup>2</sup> = 0.62). We extract five lessons for invasive species biogeography; foremost is the importance of anthropocentric measures for understanding invasive species diversity patterns and large lacunae in their known global distributions. Despite those knowledge gaps, advanced models here predict well the biogeography of the world's worst invasive species for much of the world.</p>	\N	\N	\N	\N	active	mit-license	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:39.796212	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:39.796207	\N
746a8dda-4152-43e5-bd24-9ddba814be52	coordinates-and-checklists-of-alien-species-popula	Coordinates and checklists of alien species populations as obtained from the DASCO workflow and the SInAS data set	SInAS 2.5	https://doi.org/10.5281/zenodo.10054162	<p>This data set contains coordinate records of alien (i.e., non-native) species populations worldwide and aggregated checklists of alien species for individual regions. The regions consists of non-overlapping polygons representing countries, sub-national or coastal marine ecoregions.&nbsp;</p><p>The data set was produced by applying the DASCO workflow (https://doi.org/10.5281/zenodo.5841930) using the SInAS database (version 2.5; https://doi.org/10.5281/zenodo.10038256). The workflow imports checklists of alien species such as those stored in SInAS, and extracts coordinates for the alien regions (according to SInAS) from GBIF and OBIS. After cleaning and thinning the coordinates, the workflow exports a list of coordinates of alien populations for all species included in SInAS and with records on GBIF or OBIS.</p><p>These files are part of a manuscript published in the journal Neobiota, where the workflow is described in detail (Seebens &amp; Kaplan 2022, https://doi.org/10.3897/neobiota.74.81082).</p><p>DASCO_AlienCoordinates_SInAS_2.5.gz contains the coordinates of alien populations.</p><p>DASCO_AlienRegions_SInAS_2.5.csv contains the checklists of alien species per region. Note that this only includes species with GBIF and OBIS records. For more comprehensive checklists, other databases such as those listed here (https://doi.org/10.5281/zenodo.10038256) should be consulted.</p><p>OBIS_SpeciesKeys_SInAS_2.5.csv contains the species keys from OBIS.</p><p>GBIF_SpeciesKeys_SInAS_2.5.csv contains the species keys from GBIF.</p><p>DASCO_TaxonHabitats_SInAS_2.5.csv contains habitat information for individual species if available from WoRMS, Fishbase or Sealifebase (used to identify marine species).</p><p>The file DASCO_ListOriginalGBIFData_keys_SInAS_2.5.csv contains the DOIs of the originally downloaded files from GBIF, which provides the basis for the generation of the GBIF part (ie. the DASCO workflow was applied to these data sets from GBIF). Note that OBIS does not provide a DOI for downloads, and thus we cannot provide this.</p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:41.796668	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:41.796663	\N
edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497	global-open-access-benthic-pelagic-datasets-30m-br	Global, open-access benthic & pelagic datasets (30m+) - Bridges and Howell (2025)	1.0	https://doi.org/10.5281/zenodo.15487410	<p>All global records with record depths of 30 m and deeper were downloaded from the Ocean Biodiversity Information System (OBIS). Following methods described in Bridges and Howell (2025), data were segregated into benthic and pelagic datasets using advanced statistical techniques. For the full methodology, please see Bridges and Howell (2025). For the code to rerun the segregation pipeline on new datasets, please see: https://github.com/ameliabridges/Bridges-Howell_OA_repo_pipeline.&nbsp;</p>\n<p>Datasets are available as separate CSV files, or TIFF files where the total number of records are binned into 1x1degree cells.&nbsp;</p>\n<p>Bridges, A.E.H. and Howell, K.L. 2025. Prioritisation of ocean biodiversity data collection to deliver a sustainable ocean. Nature Communications Earth and Environment, 6. DOI: 10.1038/s43247-025-02442-7</p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:43.113222	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:43.113216	\N
23709528-2e6b-48f8-a412-3b93612b80c6	bige-onto-rdf-dataset	BiGe-Onto RDF dataset	v1.0.0	https://doi.org/10.5281/zenodo.3235548	<p>RDF dataset generated by the BiGe-Onto project. It contains approximately 4.3M of triplets extracted from different data sets belonging to <a href="https://obis.org/">OBIS</a> and <a href="https://www.gbif.org/">GBIF</a>. It also contains information on oceanographic campaigns of the Argentine initiative <a href="http://www.pampazul.gob.ar/">Pampa Azul</a></p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:44.204985	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:44.20498	\N
8cfb4d21-ca59-4e78-a48b-9d0bdadf15c6	height-and-density-data-for-marine-animal-forest-f	Height and density data for marine animal forest forming species	1.0	https://doi.org/10.5281/zenodo.15276467	<p>Data file (.csv) of values of height and density for marine animal forest (MAF) forming species collected from the literature. Fields are for discrete observations:</p>\n<table>\n<tbody>\n<tr>\n<td>Species</td>\n<td>Species name</td>\n</tr>\n<tr>\n<td>Santavy</td>\n<td>\n<p>Morphology class using categories in&nbsp;</p>\n<p><span>Santavy DL, Lee A. Courtney, William S. Fisher, Robert L. Quarles, Stephen J. Jordan (2013) Estimating surface area of sponges and gorgonians as indicators of habitat availability on Caribbean coral reefs. Hydrobiologia 707:1-16. <span>https://doi.org/10.1007/s10750-012-1359-7</span><br></span></p>\n</td>\n</tr>\n<tr>\n<td>Height</td>\n<td>Mean colony height (cm)</td>\n</tr>\n<tr>\n<td>Density</td>\n<td>Mean colony density m-2</td>\n</tr>\n<tr>\n<td>Btemp</td>\n<td>Average bottom temperature for species based on OBIS records (K)</td>\n</tr>\n<tr>\n<td>Depth</td>\n<td>Average depth for species based on OBIS records (m)</td>\n</tr>\n<tr>\n<td>Phylum</td>\n<td>Taxonomy</td>\n</tr>\n<tr>\n<td>Class</td>\n<td>Taxonomy</td>\n</tr>\n<tr>\n<td>Order</td>\n<td>Taxonomy</td>\n</tr>\n<tr>\n<td>Family</td>\n<td>Taxonomy</td>\n</tr>\n<tr>\n<td>Genus</td>\n<td>Taxonomy</td>\n</tr>\n<tr>\n<td>Source</td>\n<td>Publication source for data</td>\n</tr>\n<tr>\n<td>Title</td>\n<td>Publication title</td>\n</tr>\n<tr>\n<td>DOI/link</td>\n<td>DOI for source data</td>\n</tr>\n</tbody>\n</table>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:45.203057	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:45.203052	\N
d9f6dd4f-f254-4e96-a466-1654a4b06449	supplementary-material-for-the-preprint-glossa-a-u	Supplementary material for the preprint "GLOSSA: a user-friendly R Shiny application for Bayesian machine learning analysis of marine species distribution"	1.0	https://doi.org/10.5281/zenodo.13833556	<p>In this repository we present the code and data for the case studies in "GLOSSA: a user-friendly R Shiny application for Bayesian machine learning analysis of marine species distribution". The GLOSSA website can be accessed at https://jmestret.github.io/glossa/. Occurrence data for <em>Thunnus albacares</em> was obtained from the OBIS database (https://obis.org/taxon/127027), for&nbsp;<em>Caretta caretta</em> from GBIF (https://doi.org/10.15468/dl.es7562), and for <em>Siganus luridus </em>from the GreekMarineICAS geodataset (https://doi.org/10.25607/t2smha), created as part of the ALAS (Aliens in the Aegean &ndash; A Sea Under Siege) project.</p>	\N	\N	\N	\N	active	mit-license	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:46.34374	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:46.343735	\N
3b773a9f-1bc6-43de-b357-02adfb275230	zoobase-a-global-synthesis-of-marine-zooplankton-s	ZooBase: A global synthesis of marine zooplankton species occurrences.	1.0	https://doi.org/10.5281/zenodo.5101349	<p><em><strong>Description of the methods used to implement the present ZooBase dataset (extarct from Section A.2 from the Methods of Benedetti et al., 2021).</strong></em></p>\n\n<p>A new dataset of global zooplankton species occurrences was compiled in a comparable fashion to that put together for phytoplankton (Righetti et al., 2020). Prior to retrieving the occurrence data online, we first identified the phyla (Order/Class/Family) that comprise the bulk of extant oceanic zooplankton communities: Copelata (i.e. appendicularians), Ctenophora, Cubozoa (i.e. box jellyfish), Euphausiidae (i.e. krill), Foraminifera, Gymnosomata (i.e. sea angels, pteropods), Hydrozoa (i.e. jellyfish), Hyperiidea (i.e. amphipods), Myodocopina (i.e. ostracods), Mysidae (i.e. small pelagic shrimps resembling krill), Neocopepoda, Podonidae and <em>Penilia</em> <em>avirostris</em> (i.e. cladocerans), Sagittoidea (i.e. chaetognaths), Scyphozoa (i.e. jellyfish), Thaliacea (i.e. salps, doliolids and pyrosomes), Thecosomata (i.e. pteropods), and four families of pelagic Polychaeta (i.e. worms) that are often found in the zooplankton and whose species are known to display holoplanktonic lifecycles (Tomopteridae, Alciopidae, Lopadorrhynchidae, Typhloscolecidae). The presence data associated with species belonging to these groups were retrieved from OBIS and GBIF between the 12/04/2018 and the 18/04/2018 using online queries via the R packages RPostgreSQL, robis and rgbif. Since the Neocopepoda infra-class comprise several thousands of benthic and parasitic taxa (https://copepodes.obs-banyuls.fr/en/), a preliminary selection of the non-parasitic planktonic species had to be carried out prior to the online downloading using the species list of Razouls et al. (https://copepodes.obs-banyuls.fr/en/) as a reference. The spatial distributions of the groups cited above were first inspected using GBIF&rsquo;s and OBIS&rsquo;s online mapping tools to evaluate the potential number of overlapping observations between the two databases. As a result of their relatively low contributions to total observations/diversity, and very high overlap between databases, the occurrences of Cladocera and Polychaeta were retrieved from OBIS only (which usually harbours more occurrences). On top of the data collected from OBIS and GBIF, the copepod occurrences from Cornils et al. (2018) and the pteropod occurrences from the MAREDAT initiative (Buitenhuis et al., 2013) were added to the dataset. We discarded records that: (i) presented at least one missing spatial coordinate, (ii) were associated with an incomplete sampling date (d/m/y), (iii) were associated with a year of collection older than 1800, (iv) were not associated with any sampling depth, (v) were not identified down to the species level. Occurrences associated with grid cells shallower than 10m were removed (bathymetry data from ETOPOv1 at a 15min resolution, downloaded using the &#39;marmap&#39; R package). Finally, every species name was then carefully examined and compared to the taxonomic reference list of the World Register of Marine Species (WoRMS; <a href="http://www.marinespecies.org">http://www.marinespecies.org</a>) for all taxa. The AphiaID and the Status were retreived from WoRMS based on the ScientificName. To remove the duplicate occurrences due to the highly overlapping source archives (GBIF and OBIS), a unique occurrenceID was given to each record based on rounded spatial coordinates (closest 0.1&deg;x0.1&deg;), rounded depth layer (10m depth layers), month and year of the occurrence and the acccpted species name (e.g., AphiaID).</p>\n\n<p><strong>This project has received funding from the European Union&rsquo;s Horizon 2020 research and innovation programme under grant agreement No 862923. This output reflects only the author&rsquo;s view, and the European Union cannot be held responsible for any use that may be made of the information contained therein.</strong></p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:49.695097	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:49.695091	\N
e7fd1d07-886e-4140-b09c-168d019d22c0	deep-sea-amphipod-data-from-the-north-atlantic	Deep-Sea Amphipod Data from the North Atlantic	1.0	https://doi.org/10.5281/zenodo.15610736	<p>The dataset contains records of Amphipoda occurrences retrieved from the Ocean Biodiversity Information System (OBIS) (<a href="https://obis.org/" target="_new" rel="noopener">https://obis.org/</a>). It comprises both the unprocessed data as initially downloaded and a refined subset tailored for species distribution modeling. The refinement process involved spatial, temporal, and data quality filtering to enhance the reliability of deep-sea benthic amphipod representation in the North Atlantic. Accompanying metadata and licensing information are provided in a separate document.</p>\n<p>Bathymetric information was acquired from the General Bathymetric Chart of the Oceans (GEBCO) (<a href="https://www.gebco.net/data-products/gridded-bathymetry-data" target="_new" rel="noopener">https://www.gebco.net/data-products/gridded-bathymetry-data</a>), with applicable usage terms included.</p>\n<p>Environmental variables used in modeling were sourced from the Bio-ORACLE project (<a href="https://bio-oracle.org/downloads-to-email.php" target="_new" rel="noopener">https://bio-oracle.org/downloads-to-email.php</a>) and are distributed under the GNU General Public License.</p>\n<p>&nbsp;</p>	\N	\N	\N	\N	active	notspecified	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:50.744773	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:50.744768	\N
3a22025a-fa37-4d87-bf9b-ebf9622c6e60	projections-of-spatial-distributions-of-suitable-e	Projections of spatial distributions of suitable environmental conditions for key Baltic Sea zooplankton species - Data	1.0	https://doi.org/10.5281/zenodo.10951348	<p>This repository contains seven occurrences dataset which represent the station where the species have been identified, ranging from 2000 to 2020. The environmental projections for the period 2010-2020, as well as future projection on two horizons: from 2040 to 2050 and from 2090 to 2100 on two different scenarios: SSP245 and SSP585. The occurrences have been exctracted from OBIS (https://obis.org) and the environmental projections from Bio-ORACLE (https://bio-oracle.org).</p>\n<p>&nbsp;</p>\n<p>Occurrences datasets:&nbsp;</p>\n<ul>\n<li><em>Temora longicornis</em></li>\n<li><em>Centropages hamatus</em></li>\n<li><em>Limnocalanus macrurus macrurus</em></li>\n<li><em>Evadne nordmanni</em></li>\n<li><em>Acartia tonsa</em></li>\n<li><em>Acartia longiremis</em></li>\n<li><em>Acartia bifilosa</em></li>\n</ul>\n<p>&nbsp;</p>\n<p>Projections:</p>\n<ul>\n<li>Projection Baseline 2010-2020</li>\n<li>Projection 2040-2050 SSP245</li>\n<li>Projection 2090-2100 SSP245</li>\n<li>Projection 2040-2050 SSP585</li>\n<li>Projection 2090-2100 SSP585</li>\n</ul>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:51.864391	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:51.864386	\N
fbf63ee1-5ffe-41ee-9732-a47889ed8e69	data-for-species-distribution-modelling-of-benthic	Data for "Species Distribution Modelling of Benthic Amphipod Crustaceans in the Deep North Atlantic Under Climate Change"	1	https://doi.org/10.5281/zenodo.15396200	<p>This dataset is based on occurrence data from the <strong>Ocean Biodiversity Information System (OBIS)</strong> (<a href="https://obis.org/" target="_new" rel="noopener">https://obis.org/</a>), originally downloaded using the OBIS Mapper tool. It includes both the raw occurrence data as initially extracted, as well as the filtered version used for species distribution modeling. The filtering steps included spatial, temporal, and quality checks to ensure accurate representation of benthic amphipod distributions in the deep North Atlantic. Additionally, the metadata, including their licenses, is included in a separate file.</p>\n<p>Bathymetry data was sourced from <strong>GEBCO</strong> (<a href="https://www.gebco.net/data-products/gridded-bathymetry-data" target="_new" rel="noopener">https://www.gebco.net/data-products/gridded-bathymetry-data</a>) and includes the terms of use.</p>\n<p>Environmental modeling layers were obtained from <strong>Bio-ORACLE</strong> (<a href="https://bio-oracle.org/downloads-to-email.php" target="_new" rel="noopener">https://bio-oracle.org/downloads-to-email.php</a>) and are included under the GNU General Public License.</p>	\N	\N	\N	\N	active	notspecified	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:53.028039	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:53.028034	\N
8dc24d5d-aaa6-498c-b204-2317dec0460e	untitled-dataset	Untitled Dataset	2	https://doi.org/10.5061/dryad.fj6q573q3	Aim The development of approaches to predict the distribution and\n potential expansion of invasive species is still an open challenge. Here\n our goal is to improve the modelling procedure for marine invaders by\n coupling Species Distribution Models (SDMs) with an analysis of their\n univariate niche dynamics. In particular, we tested for the first time\n whether choosing model predictors among the stable niche dimensions was\n effective in improving predictions of invasive species expansion. Location\n Mediterranean Sea Taxon Dusky spinefoot, Siganus luridus. Methods We\n analysed the univariate niche dynamics for S. luridus across its native\n and invaded ranges, by applying a standardized framework that allowed the\n identification of cases of niche stability or shift. We compared\n inter-range transferability of SDMs fitted with different combinations of\n labile or stable predictors. Finally, we evaluated interactions in SDM\n settings (calibration area, model technique and predictors set) on models’\n predictive ability, using independent data from the most recent phase of\n invasion. Results We detected a pattern of niche stability for several\n variables, especially salinity and bathymetry, which positively influenced\n model inter-ranges transferability: when the models calibrated in the\n native range include only stable niche axes, predictive ability is\n improved. We also identified a shift toward lower surface temperatures in\n the introduced range, which were almost never experienced by the species\n before invasion. The model calibrated within the combined ranges was the\n most ecologically congruent. Also, models calibrated in the invaded range\n allowed a correct prediction of range expansion, with the predicted\n suitable areas only slightly underestimated. Main conclusions We provide\n the first evidence that using conserved predictors in SDMs improves\n inter-range projections of expanding invasive species. Variable selection,\n calibration area and modelling technique all matter when modelling\n invasive species, with important interaction effects. We provide\n guidelines on how to improve SDMs applications in biological invasion\n research.	\N	\N	\N	\N	active	\N	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:54.032315	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:54.032309	\N
d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd	fig-2-in-climate-driven-diversity-changes-of-medit	Fig. 2 in Climate-driven diversity changes of Mediterranean echinoids over the last 6 Ma	1.0	https://doi.org/10.5281/zenodo.12197246	Fig. 2. Current distribution by depth of shelf-preferring/exclusive echinoid genera that still live or lived in Mediterranean during the late Cenozoic. Data are expressed in percentage of the centennial bathymetric records collected by OBIS (https://obis.org).	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:57:07.33081	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:57:07.330804	\N
31dc8a44-e9b7-44e8-821a-5c602b7c1d00	depth-latitude-and-lifespan-dataset-and-r-code-for	Depth, Latitude, and Lifespan: Dataset and R Code for Allometric Scaling Analysis in Marine Fishes	1.0	https://doi.org/10.5281/zenodo.16791361	<p>This dataset contains compiled body size (total length, weight) and maximum longevity data for marine fish species, along with their associated depth and latitudinal distribution ranges, used in the study <em>&ldquo;Depth, Latitude, and Lifespan: Exploring Allometric Scaling of Body Size and Maximum Longevity in Marine Fishes.&rdquo;</em> Data were sourced from FishBase, OBIS, and supplementary literature between March and July 2025.</p>\n<p>The dataset includes:</p>\n<ul>\n<li>\n<p><strong>Raw data</strong> extracted from public databases and literature</p>\n</li>\n<li>\n<p><strong>Cleaned dataset</strong> for statistical analysis</p>\n</li>\n<li>\n<p><strong>R scripts</strong> for data processing, model fitting, and figure generation</p>\n</li>\n<li>\n<p>Metadata describing species taxonomy, sampling coverage, and environmental parameters</p>\n</li>\n</ul>\n<p>All analyses were conducted in R (version 4.3), and the provided code reproduces all statistical results and figures in the manuscript. The dataset is shared to promote transparency and reproducibility, and may be reused for related studies on fish allometry, biogeography, and life history strategies.</p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:55.045227	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:55.045221	\N
4571b411-cc4e-408a-8fc0-4454f5694fd0	enhancing-georeferenced-biodiversity-inventories-a	Enhancing georeferenced biodiversity inventories: automated information extraction from literature records reveal the gaps	1.0	https://doi.org/10.5281/zenodo.6770200	<p>Data and code supplement to our article revised submission to PeerJ.</p>\n\n<p>&nbsp;</p>\n\n<p>The file is compressed using standard&nbsp;zip.&nbsp;The uncompressed size is about 50 GB. There is a readme.md in the archive, which explains the structure of the contents.</p>\n\n<p>&nbsp;</p>\n\n<p>Abstract:</p>\n\n<p>We use natural language processing (NLP) to retrieve location data for cheilostome bryozoan species (text-mined occurrences [TMO]) in an automated procedure. We compare these results with data combined from two major public databases (DB): the Ocean Biogeographic Information System (OBIS), and the Global Biodiversity Information Facility (GBIF). Using DB and TMO data separately and in combination, we present latitudinal species richness curves using standard estimators (Chao2 and the Jackknife) and range-through approaches. Our combined DB and TMO species richness curves quantitatively document a bimodal global latitudinal diversity gradient for extant cheilostomes for the first time, with peaks in the temperate zones. 79% of the georeferenced species we retrieved from TMO (N = 1408) and DB (N = 4549) are non-overlapping. Despite clear indications that global location data compiled for cheilostomes should be improved with concerted effort, our study supports the view that many marine latitudinal species richness patterns deviate from the canonical latitudinal diversity gradient (LDG). Moreover, combining online biodiversity databases with automated information retrieval from the published literature is a promising avenue for expanding taxon-location datasets.</p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:56.92	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:56.919994	\N
4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	a-set-of-six-databases-used-in-a-study-of-the-biog	A set of six databases used in a study of the biogeography of Greater Caribbean reef fishes entitled:  Comparing biodiversity databases: Greater Caribbean reef-fishes as a case study                                   Iliana Chollett1, D. Ross Robertson2  1 Sea Cottage, Louisburgh, Co. Mayo, Ireland 2 Smithsonian Tropical Research Institute, Balboa, Panamá	1.0	https://doi.org/10.5281/zenodo.3606645	<p><strong>A set of six databases used in a study of the biogeography of Greater Caribbean reef fishes entitled:</strong></p>\n\n<p><strong><em>&nbsp;</em></strong></p>\n\n<p><strong><em>Comparing biodiversity databases: Greater Caribbean reef-fishes as a case study</em></strong></p>\n\n<p>&nbsp;</p>\n\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Iliana Chollett, D. Ross Robertson</p>\n\n<p><strong>&nbsp;</strong></p>\n\n<p><strong>&nbsp;</strong></p>\n\n<p><strong>Database Authors: D Ross Robertson and Ernesto Pe&ntilde;a, Smithsonian Tropical Research Institute, Panam&aacute;</strong></p>\n\n<p><strong>&nbsp;</strong></p>\n\n<p>This set of six databases contains georeferenced location records from six sources as described below.These six sources provided georeferenced records of occurrence of fishes found in the Greater Caribbean study area (6-33<sup>0</sup> N, 57-100<sup>0</sup> W). Each occurrence record consists of a species name and associated latitude and longitude. Databases included in the comparisons made here are from five major online aggregators. Since their content overlaps to some extent, and OBIS, iDigBio and FishNet collaborate with GBIF, their data might be expected to produce similar biogeographic patterns. STRI includes a curated compendium of data from those five aggregators, enriched with data from many additional sources.</p>\n\n<p>&nbsp;</p>\n\n<p>Only reef-associated fish species were included in the present analysis. These mostly represent demersal species known to occur on hard bottoms (coral, rock and oyster substrata), but also include species living on rubble, sand and vegetated bottoms within and around the immediate fringes of reefs, and pelagic species regularly found on reefs. All exotic and non-resident species and species other than reef-associated fishes were excluded from all databases prior to comparisons. Non-residents were defined as otherwise widespread species only rarely seen in the study area. Shore-fishes, including what are generally regarded as reef fishes, include those found in the waters of continental and insular shelves, i.e. between 0-200m. Reef-fish assemblages dominated by shallow-water taxa extend down to that depth in the study area (Baldwin <em>et al.</em> 2018). We used the shelf edge as a breakpoint and excluded records in areas deeper than 200m, identifying those areas using the General Bathymetric Chart of the Oceans (Kapoor, 1981; GEBCO Compilation Group, 2019).</p>\n\n<p>&nbsp;</p>\n\n<p>Before the analyses, for all databases, duplicate records were deleted. Subsequently, records in the Pacific or on land were deleted. We used the Global Self-consistent, Hierarchical, High-resolution Geography Database (Wessel &amp; Smith, 1996) to identify these areas. The spatial distribution of species-records in each database is shown in Figure 1 of the publication.</p>\n\n<p><strong>&nbsp;</strong></p>\n\n<p><strong>Global Biodiversity Information Facility </strong>(GBIF, https://www.gbif.org/): GBIF is an international network and research infrastructure aimed at providing open access to data about all types of life on earth. GBIF works through participant nodes using common standards and open-source tools that enable them to share information. Data from among the 49,000+ datasets hosted by GBIF that were used here range from those on museum specimens collected since the 18th century, to published scientific checklists, to curated&nbsp; local checklists produced by trained science sources such as the Atlantic and Gulf Rapid Assessment Program (https://www.agrra.org/),to geotagged smartphone photos (that act as vouchers allowing verification) shared by amateur and scientific naturalists through iNaturalist (https://www.inaturalist.org/), to unvouchered, unverified and unverifiable observation records from untrained divers such as those contributing to DiveBoard (http://www.diveboard.com). GBIF data are standardized in Darwin Core format. GBIF data were obtained from a polygon of the region of study and subject to taxonomic review and selection after downloading. GBIF data were obtained from a polygon of the study area and subject to taxonomic review after downloading (accessed through the GBIF portal, https://www.gbif.org/, on or about 2019-05-19).</p>\n\n<p>&nbsp;</p>\n\n<p><strong>Ocean Biogeographic Information System</strong> (OBIS,&nbsp; <a href="https://obis.org/">https://obis.org/</a>): OBIS is a global open-access data and information clearing-house on marine biodiversity (OBIS, 2019) that was adopted as a project of the Intergovernmental Oceanographic Data and Information Exchange of the Intergovernmental Commission of UNESCO . Its range of sources is similar to that of GBIF. OBIS hosts data from organizations or programs that join it as one of 13 &ldquo;nodes&rdquo;, and harvest the data from the IPT (Integrated Publishing Toolkit), where providers publish their data. The IPT is developed and maintained by the GBIF, and OBIS is a major contributor of marine data to GBIF. Data are standardized in Darwin Core format. OBIS data were obtained for the region of study by downloading data on each family, then retaining only data inside the study area, which were then subject to taxonomic review and selection (accessed through the OBIS portal, https://obis.org/, on or about 2019-05-19).</p>\n\n<p>&nbsp;</p>\n\n<p><strong>Integrated Digitized Biocollections</strong> (iDigBio, https://portal.idigbio.org/portal/search): iDigBio is sponsored by the a US National Science Foundation and run by the University of Florida that provides digital data from public, non-federal, US collections. Data are standardized in a Darwin Core format, and provided &ldquo;as is&rdquo;. IDigBio joined the GBIF network in 2017. IDigBio records were downloaded from a polygon of the region of study and subject to taxonomic review and selection (accessed through the iDigBio portal, https://portal.idigbio.org/portal/search, on or about 2019-05-19).</p>\n\n<p>&nbsp;</p>\n\n<p><strong>FishNet2 </strong>(http://www.fishnet2.net/): FishNet2 is a collaborative effort that aggregates data on fish collections around the world to share and distribute data on specimen holdings from ~75 museums, universities and other institutions. FishNet2 distributes data in Darwin Core, and data are provided &ldquo;as is&rdquo;. FishNet2 is part of the network VerNet, which has contributed to GBIF since 2013 and became part of IDigBio in 2016. While FishNet2 has made substantial efforts to georeference location-record data it hosts, many hosted records still lack georeferencing. FishNet2 data were obtained from a polygon of the study area and subject to taxonomic review after downloading (accessed through the Fishnet2 Portal, www.fishnet2.org, 2019-05-19).</p>\n\n<p>&nbsp;</p>\n\n<p><strong>FishBase</strong> (<a href="http://www.fishbase.org/">http://www.fishbase.org</a>): FishBase is a global biodiversity information system supervise by a consortium of nine non-USA international institutions, and hosts data on fin fishes and elasmobranchs&nbsp; (Froese &amp; Pauly, 2009). Information presented in FishBase is extracted from the scientific literature, reports and museum or aggregator (GBIF) databases, and standardized by a team of specialists. Data from Fishbase were downloaded for the following ecosystems: Caribbean Sea, Gulf of Mexico, Southeast U.S. Continental Shelf, Atlantic Ocean, Sargasso Sea and Bermuda, and subject to taxonomic review and selection after downloading (2019-05-19).</p>\n\n<p>&nbsp;</p>\n\n<p><strong>Smithsonian Tropical Research Institute</strong> (STRI; <a href="https://biogeodb.stri.si.edu/caribbean/en/pages">https://biogeodb.stri.si.edu/caribbean/en/pages</a>): The STRI database was compiled by DRR and Ernesto Pe&ntilde;a at STRI&rsquo;s Naos Marine Laboratory, and represents about 15 years accumulation of curated data (see below) from the following sources:&nbsp; data downloaded at roughly two year intervals from the five aggregators; data from online databases of various museums that supply aggregators (data directly downloaded from a museum sometimes differs from that available in an aggregator from the same museum), including the Swedish Museum of Natural History, the American Museum of Natural History, the Natural History Museum of Denmark, the Gulf Coast Research Laboratory, the Colombian Museum of Natural Marine History, the United States National Museum, and the United States Geological Survey; data from national aggregators of Colombia (Sistema de Informaci&oacute;n Sobre Biodiversidad de Colombia (https://sibcolombia.net/), and&nbsp; Sistema de Informaci&oacute;n Ambiental Marina de Colombia, https://siam.invemar.org.co/), Mexico (La Comisi&oacute;n Nacional para el Conocimiento y Uso de la Biodiversidad, CONABIO;&nbsp;&nbsp; http://www.conabio.gob.mx/informacion/gis/), and Costa Rica (Museo de Zoologia de la Universidad de Costa Rica, http://museo.biologia.ucr.ac.cr/); verified (by DRR) underwater photographs of fishes taken at known locations; peer reviewed publications containing location information (species descriptions; taxonomic revisions of species, genera and families; regional and local checklists); fisheries reports; digital tagging data for species such as elasmobranchs; diving surveys and collections of local faunas by DRR (e.g. Robertson et al. 2019). In addition selected data from two sources that collect species lists at sites scattered throughout the Greater Caribbean are incorporated: from the Atlantic and Gulf Rapid Reef Assessment program (AGRRA, https://www.agrra.org/: Kramer &amp; Lang, 2003) and from trained citizen scientists who contribute data on fishes to the Reef Environmental Education Foundation&rsquo;s database (REEF: Pattengill-Semmens &amp; Semmens, 2003). The bibliographic module (https://biogeodb.stri.si.edu/caribbean/en/library) of Robertson &amp; VanTassel (2019) contains ~1700 publications linked to species names, among them the publications from which location data were extracted.</p>\n\n<p>&nbsp;</p>\n\n<p>Data from the aggregators is presented &ldquo;as is&rdquo; and the aggregators themselves do not do data curation. Duplicates (and occasionally triplicates and quaduplicates) of the same museum record often are included from multiple sources (e.g. the original museum source, derivative checklists, an aggregator), sometimes with slightly different georeferenced coordinates. Data available in one year may subsequently disappear from an aggregator, and different data may be available for the same species under different names (e.g. the old and new names when a species is reassigned to another genus). Errors, sometimes large errors (Robertson, 2008), are common in aggregator data, from museums as well as other sources, and longstanding errors can seem to take on a perpetual existence. For example the damselfish <em>Abudefduf saxatilis </em>is a common and widespread inhabitant of tropical reefs on both sides of the Atlantic, but does not naturally occur outside that ocean. Despite the fact that its taxonomic status and range were resolved ~30 y ago (e.g. see Allen, 1991) museum data presented by the all five aggregators that contributed to the multi-source database used in this study currently (December 10, 2019) show large numbers of records of this species throughout the entire tropical Indo-Pacific, as well as across its native range in the Atlantic. Since many of the databases accumulating on aggregators are derivative (lists derived from records and from other derivative lists) it will become increasingly difficult to eliminate such errors as corrections to data in primary sources do not automatically propagate through the chain of usage by different databases. Due to increasing limitations on resources for taxonomic work, museums themselves have difficulty dealing with errors in specimen identity and location, and old specimens become unidentifiable, specimens never get returned when loaned out, or simply vanish, and entire collections can get destroyed by hurricanes or fires, or get dumped when museums close or experience a major change in mission. Georeferenced location data on fish distributions in the neotropics (and presumably most other areas) hosted by aggregators, particularly GBIF and OBIS, which take data from a broad range of source types, might best be described as messy, and the significant potential for errors in location records and an inability to verify records always needs to be taken into account when incorporating data from aggregators, primary museum sources, and analog sources.</p>\n\n<p>&nbsp;</p>\n\n<p>Data considered for inclusion in the STRI database were screened as follows to exclude questionable records.&nbsp; Data from two databases hosted by OBIS and GBIF were excluded entirely due to lack of reliability: BioGoMx (https://www.gulfbase.org/project/biodiversity-gulf-mexico-biogomx-database) and Diveboard (http://www.diveboard.com).&nbsp; The only REEF data used were from &ldquo;expert&rdquo; REEF recorders on readily identifiable species that are unlikely to be confused with similar species (e.g. data for some genera of sparids, gerreids, labrisomids and gobies that include various sympatric species with very similar appearances, were not used).&nbsp; After data from aggregators and museum sources were combined into a single database duplicate records were filtered out by rounding all records to three decimal places and eliminating duplicates, a process that inevitably deleted some valid records as well as duplicates. The sizes of the databases and abundance of such duplicates precluded individual manual exclusion. Finally, all location data for each species were revised by DRR by examining the distribution of its georeferenced coordinates overlayed on a digital map of the current known distribution range of that species (for such range information see Carpenter &amp; De Angelis, 2002; Ebert <em>et al.</em>, 2013; Last <em>et al.</em>, 2016; Robertson &amp; Van Tassell, 2019; IUCN Redlist species accounts for most species considered here: https://www.iucnredlist.org/search). Such revision took into account any recent modifications to taxonomy and distributions due to new data and new publications, or as a result of discussions between DRR and experts in the taxonomy of particular species or genera. Source information of many individual questionable records provided by aggregators with the hosted data was inspected to try and assess their validity. Records thought likely to be erroneous were deleted. Those included inexplicable records lacking adequate documentation located well outside the known distribution range, and records in unlikely habitats (e.g. on land for marine species; in deep water for shallow-water species). This revision process reduced the number of records by about 30%.</p>\n\n<p>&nbsp;</p>\n\n<p>Data from the five individual aggregator databases that are used in the comparisons described here were all downloaded from their online portals during May, 2019. However, data from those five aggregators that were incorporated in the STRI database were downloaded in March 2017, with data from other sources described above added to the STRI database intermittently between then and May 2019, when the entire dataset was curated as described above. Hence the five individual aggregator databases analyzed in this study undoubtedly contain data not included in the version of the STRI database used in the present analyses.</p>\n\n<p>&nbsp;</p>\n\n<p><strong>Acknowledgements</strong></p>\n\n<p>&nbsp;</p>\n\n<p>Data acquisition and construction of the STRI database was supported by funds from STRI, the Smithsonian Marine Science Network, the Smithsonian Publications Fund, the Smithsonian&rsquo;s Deep Reef Observation Project, the National Geographic Society, the IUCN Red List program, the Harte Research Institute, and CONABIO. We thank REEF and AGRRA for supplying species-location records, various people for taxonomic and location-record information used to construct that database (principal among them C Baldwin, S Brandl, K Conway B Frable, T Menut, T Munroe, R Robins, L Tornabene, J Van Tassell and B Victor), and hundreds of citizen-scientist submarine photographers whose images (see <a href="https://biogeodb.stri.si.edu/caribbean/en/contributors/citizen_scientists">https://biogeodb.stri.si.edu/caribbean/en/contributors/citizen_scientists</a>) acted as vouchers for location records.</p>\n\n<p>&nbsp;</p>\n\n<p><strong>References</strong></p>\n\n<p><strong>&nbsp;</strong></p>\n\n<p>Allen, G.R. (1991) <em>Damselfishes of the World</em>. Mergus, Melle, 271 p.</p>\n\n<p>Baldwin, C.C., Tornabene, L. &amp; Robertson, D.R. (2018) Below the mesophotic. <em>Scientific Reports</em>, 8, 4920.</p>\n\n<p>Carpenter, K.E. (Ed) (2002) <em>The living marine resources of the Western Central Atlantic.</em> Vols 1-3, FAO, Rome, 2127 p.</p>\n\n<p>Ebert, D.A., Fowler, S., Compagno, L. (2013) <em>Sharks of the World: a fully illustrated guide</em>. Wild Nature Press, Plymouth. 528 p.</p>\n\n<p>GEBCO Compilation Group (2019) GEBCO 2019 Grid (doi:10.5285/836f016a-33be-6ddc-e053-6c86abc0788e).</p>\n\n<p>Kapoor, D.C. (1981) General bathymetric chart of the oceans (GEBCO). <em>Marine Geodesy</em>, 5, 73&ndash;80.</p>\n\n<p>Kramer, P.R. &amp; Lang, J.C. (2003) Appendix one: The Atlantic and Gulf Rapid Reef Assessment (AGRRA) Protocols: Former Version 2. 2. <em>Atoll Research Bulletin</em>, 496, 611&ndash;624.</p>\n\n<p>Last, P. R., White, W.A., de Carvalho, M.R., S&eacute;ret, B., Stehmann, F.W., &amp; Naylor, J.P. (2016). <em>Rays of the World</em>. CSIRO, Clayton. 790 p.</p>\n\n<p>Pattengill-Semmens, C.V. &amp; Semmens, B.X. (2003) <em>Conservation and management applications of the reef volunteer fish monitoring program</em>. <em>Coastal Monitoring through Partnerships: Proceedings of the Fifth Symposium on the Environmental Monitoring and Assessment Program (EMAP) Pensacola Beach, FL, U.S.A., April 24&ndash;27, 2001</em> (ed. by B.D. Melzian), V. Engle), M. McAlister), S. Sandhu), and L.K. Eads), pp. 43&ndash;50. Springer Netherlands, Dordrecht.</p>\n\n<p>Robertson, D. R. (2008) Global biogeographic databases on marine fishes: caveat emptor. <em>Diversity and Distributions, 14<strong>,</strong> 891-892</em></p>\n\n<p>Robertson, D.R,, Dominguez-Dominguez, O., Lopez Arollo, Y.M., Moreno Mendoza. R., Simoes, N. (2019) Reef-associated fishes from the offshore reefs of western Campeche Bank, Mexico, with a discussion of mangroves and seagrass beds as nursery habitats. <em>Zookeys </em>843: 71-115. <a href="https://doi.org/10.3897/zookeys.843.33873">https://doi.org/10.3897/zookeys.843.33873</a></p>\n\n<p>Robertson, D.R &amp; Van Tassell, J. (2019) Shorefishes of the Greater Caribbean: online information system. Version 2.0. <em>Smithsonian Tropical Research Institute, Balboa, Panam&aacute;</em>. <a href="https://biogeodb.stri.si.edu/caribbean/en/pages">https://biogeodb.stri.si.edu/caribbean/en/pages</a>.</p>\n\n<p>Wessel, P. &amp; Smith, W.H.F. (1996) A global, self-consistent, hierarchical, high-resolution shoreline database. <em>Journal of Geophysical Research: Solid Earth</em>, 101, 8741&ndash;8743.</p>	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:56:58.131342	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:56:58.131336	\N
02312a9e-957d-4546-b477-34f40c752534	figure-12-in-historical-review-of-the-computerizat	Figure 12 in Historical review of the computerization of the MNHN Fish Collection and its collaboration with FishBase	1.0	https://doi.org/10.5281/zenodo.12713667	Figure 12. – MNHN-FishBase collaboration and dataflow since 1999. A: Data flow from 1999 to 2002; (1): checking taxonomic data uses FishBase-ECoF and GICIM; (2): data flow from GICIM to FishBase; and (3): from FishBase to GBIF, OBIS and FishNet. B: Dataflow since 2002; (4): direct link from GICIM to GBIF, OBIS and FishNet; (5): link from GBIF to FishBase; and (6): Taxonomic workflow, checking taxonomic data from FishBase-GICIM-ECoF to WORMS. [An additional link could be added from FishBase to COL, but it is independent from GICIM.]	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:57:01.807036	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:57:01.807029	\N
7591d5e4-f147-46ac-81d4-458e33ba5ddc	figure-7-in-deep-sea-corals-from-the-seamounts-of-	FIGURE 7 in Deep-sea corals from the seamounts of Central and Southwest Indian Ridges	1.0	https://doi.org/10.5281/zenodo.15219322	FIGURE 7. The geographic distribution for each of the six coral species in the CIR and SWIR using the Ocean Biogeographic Information System (OBIS) and WoRMS 2024.	\N	\N	\N	\N	active	notspecified	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:57:02.850076	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:57:02.850071	\N
dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2	figure-32-in-black-corals-anthozoa-antipatharia-fr	FIGURE 32 in Black Corals (Anthozoa: Antipatharia) from the Southwestern Atlantic	1.0	https://doi.org/10.5281/zenodo.3529008	FIGURE 32. Geographic distribution of Stylopathes adinocrada Opresko, 2006. Yellow circles: records extracted from the literature (Opresko, 2006) and based on Ocean Biogeographic Information System (OBIS). Red circle: record made in the present work.	\N	\N	\N	\N	active	notspecified	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:57:04.064107	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:57:04.064103	\N
ad269608-4984-404e-8263-d093d89d404c	figure-2-in-new-laonice-species-polychaeta-spionid	FIGURE 2 in New Laonice species (Polychaeta: Spionidae) from western and northern Australia	1.0	https://doi.org/10.5281/zenodo.207908	FIGURE 2. Bathymetric distribution of Australian Laonice species. L. hermaphroditica data based on the depth of Morton Bay, L. bassensis data from Blake &amp; Kudenov 1978, L. weddellia data from OBIS (http://www.obis.org.au/)	\N	\N	\N	\N	active	notspecified	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:57:05.168948	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:57:05.168943	\N
703c1db6-eeb8-40a6-b42b-f784b690c669	f-i-g-u-r-e-2-in-second-world-record-for-barathron	F I G U R E 2 in Second world record for Barathronus roulei Nielsen, 2019 (Ophidiiformes, Bythitidae), from the Porcupine Bank (Northeast Atlantic)	1.0	https://doi.org/10.5281/zenodo.17004178	F I G U R E 2 Location of Barathronus roulei on Porcupine Bank (red triangle). Also shown is the location of records of Atlantic Barathronus species (GBIF. org, 2023; OBIS, 2023).	\N	\N	\N	\N	active	cc-by-4.0	dataset	e83539a2-a0bc-49c3-8502-f0eff7de87b9	f	2025-09-25 21:57:06.250011	70b75831-ff72-4599-aa51-9617f9251ce8	2025-09-25 21:57:06.250005	\N
\.


--
-- Data for Name: package_extra; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.package_extra (id, key, value, state, package_id) FROM stdin;
82e90033-51c6-40a0-8319-997669c4f89a	update_frequency	never	active	de37ad6d-002f-47fc-913e-58ff407296e0
dd11cf81-d5a1-4926-8661-f6d9951f14bd	product_type	["derived_dataset"]	active	de37ad6d-002f-47fc-913e-58ff407296e0
0cecf226-2ada-4a4a-bfa8-dbbbffc98db2	publication_date	2024-06-04	active	de37ad6d-002f-47fc-913e-58ff407296e0
cde1a48a-c242-4318-b227-00ab68e4806b	zenodo_record_id	11464531	active	de37ad6d-002f-47fc-913e-58ff407296e0
22132ab3-49f9-4358-81fa-e7edfa74a354	doi	10.5281/zenodo.11464531	active	de37ad6d-002f-47fc-913e-58ff407296e0
deebfc2d-2eab-4781-b142-b51046156298	contributing_organizations	[]	active	de37ad6d-002f-47fc-913e-58ff407296e0
d563fc97-59a9-4869-91d9-645bdda11066	source	zenodo	active	de37ad6d-002f-47fc-913e-58ff407296e0
1fd91a5e-0b0b-4c48-8ff9-57ecc5340595	update_frequency	never	active	a9a3eae6-cb4a-4b36-8043-79511cb15571
224c63d3-0641-46a4-8ad6-40224777c400	contributing_organizations	[]	active	a9a3eae6-cb4a-4b36-8043-79511cb15571
610bb997-a04c-4db0-a0d7-773a1fbb5317	contributing_organizations	[]	active	0586194d-3acc-47f5-a9dd-ffd6dad8dc80
3060628e-23c1-43f3-a9a9-254d3411aed4	authors	[{"affiliation": "National Oceanic and Atmospheric Administration", "email": "", "name": "Biddle, Mathew"}, {"affiliation": "United States Geological Survey", "email": "", "name": "Formel, Stephen"}]	active	a9a3eae6-cb4a-4b36-8043-79511cb15571
32ebee3d-2959-49d0-9800-61b333fc9741	product_type	["report"]	active	a9a3eae6-cb4a-4b36-8043-79511cb15571
b7a89bf4-8426-4e01-85f8-22b14144d9f0	contributing_organizations	[]	active	f76126e1-3772-4d15-bf64-d48962df77e7
dff44a15-3d77-4eb2-806b-3ecfb195a7db	update_frequency	never	active	f76126e1-3772-4d15-bf64-d48962df77e7
317fa18b-74e6-4dbf-8373-4fd8b868fa94	authors	[{"affiliation": "National Oceanic and Atmospheric Administration", "email": "", "name": "Biddle, Mathew"}, {"affiliation": "OBIS Secretariat", "email": "steve@formeldataservices.com", "name": "Formel, Stephen"}]	active	f76126e1-3772-4d15-bf64-d48962df77e7
3584f0f7-0cf5-44a2-952b-d8d3e71ee0c9	product_type	["presentation"]	active	f76126e1-3772-4d15-bf64-d48962df77e7
5532cbc6-7465-415b-89cf-d6edd66e76b3	contributing_organizations	[]	active	554881bd-aaad-4f06-9fc5-0940b3bc90dd
6a33aee4-bdf0-40c6-a4d1-787d9f754b4c	update_frequency	never	active	554881bd-aaad-4f06-9fc5-0940b3bc90dd
09339f7c-90e3-4b5e-82d0-113b7d500d6c	authors	[{"affiliation": "National Oceanic and Atmospheric Administration", "email": "", "name": "Biddle, Mathew"}, {"affiliation": "United States Geological Survey", "email": "steve@formeldataservices.com", "name": "Formel, Stephen"}]	active	554881bd-aaad-4f06-9fc5-0940b3bc90dd
7f8bb9f7-5645-46e3-a163-0fb67ecfb360	product_type	["presentation"]	active	554881bd-aaad-4f06-9fc5-0940b3bc90dd
4b6edd0e-dfd1-49a5-9de5-a409f7fe3f09	product_type	["derived_dataset"]	active	0c5925a7-be8b-48b3-b58d-25bad96b58ba
119afd33-ca12-496f-8edb-2a38d3ebe02f	update_frequency	never	active	0c5925a7-be8b-48b3-b58d-25bad96b58ba
5134f809-2e81-45ff-a743-47694f5fb8b7	doi	10.5281/zenodo.11464531	active	0c5925a7-be8b-48b3-b58d-25bad96b58ba
2193d7ed-dd46-4de1-abcc-2c5e4346ae73	authors	[{"affiliation": "National Oceanic and Atmospheric Administration", "email": "", "name": "Biddle, Mathew"}, {"affiliation": "United States Geological Survey", "email": "", "name": "Formel, Stephen"}]	active	0c5925a7-be8b-48b3-b58d-25bad96b58ba
a09c55f1-7a0f-4085-a558-cf50782a46ca	contributing_organizations	[]	active	0c5925a7-be8b-48b3-b58d-25bad96b58ba
b171e12b-a9f3-4d36-ad42-ed26fce848da	source	zenodo	active	0c5925a7-be8b-48b3-b58d-25bad96b58ba
e40a3636-3cb2-4b38-875d-54dee7b9af32	zenodo_record_id	11464531	active	0c5925a7-be8b-48b3-b58d-25bad96b58ba
18c48429-b674-4b78-b8a1-d3244768a7e3	publication_date	2024-06-04	active	0c5925a7-be8b-48b3-b58d-25bad96b58ba
7502997d-51c1-46cc-8a83-ba1c6a821ca7	update_frequency	never	active	0586194d-3acc-47f5-a9dd-ffd6dad8dc80
40c57a16-a114-4bfe-b906-5e91cf019dc2	product_type	["presentation"]	active	0586194d-3acc-47f5-a9dd-ffd6dad8dc80
d33ebe6c-ff73-4fbf-af20-67ea87a52b4e	authors	[{"affiliation": "National Oceanic and Atmospheric Administration", "email": "", "name": "Biddle, Mathew"}, {"affiliation": "United States Geological Survey", "email": "steve@formeldataservices.com", "name": "Formel, Stephen"}]	active	0586194d-3acc-47f5-a9dd-ffd6dad8dc80
89dc37f4-dd95-47dd-ae24-a17a753c59be	contributing_organizations	[]	active	4a1e1de9-4100-4716-903e-21da4bcd4ece
7301bc6a-b986-463b-9975-d94dbd69c90e	authors	[{"affiliation": "", "email": "s.principe@unesco.org", "name": "Silas Principe"}]	active	4a1e1de9-4100-4716-903e-21da4bcd4ece
e33fd156-be6c-45d0-9b6b-fc872cae1fae	product_type	["map", "model", "dashboard"]	active	4a1e1de9-4100-4716-903e-21da4bcd4ece
b5b8571b-2cfa-43bc-b9ef-636d2009a5b9	update_frequency	monthly	active	4a1e1de9-4100-4716-903e-21da4bcd4ece
8589a47f-8b0e-4696-a5e4-c9619e3a9108	doi	10.5281/zenodo.1254293	active	95b1c645-ddc0-4cb7-8198-803bdf78d109
6b0b8784-bf49-43d0-8eb8-ffa6784b1136	source	zenodo	active	95b1c645-ddc0-4cb7-8198-803bdf78d109
f67db444-1724-4a54-a389-d3d7bf275c16	zenodo_record_id	1254293	active	95b1c645-ddc0-4cb7-8198-803bdf78d109
1f54e2b0-a0bf-4dd8-aa58-44685d63fa28	contributing_organizations	[]	active	95b1c645-ddc0-4cb7-8198-803bdf78d109
83ed8e46-8851-4b9d-9879-379efd0cdca1	doi	10.5281/zenodo.11069027	active	3d6d1f15-9ade-4d65-8e4d-7c47ff3ec391
75baa4c2-ef6a-44bf-b46c-67acba3a9d72	source	zenodo	active	3d6d1f15-9ade-4d65-8e4d-7c47ff3ec391
7b07d42a-d70d-4e80-9987-6cffd3254c8f	zenodo_record_id	11069027	active	3d6d1f15-9ade-4d65-8e4d-7c47ff3ec391
ad46b1cb-17b7-4e9d-9702-e62c1fc2804f	contributing_organizations	[]	active	3d6d1f15-9ade-4d65-8e4d-7c47ff3ec391
15c30786-c092-4e8b-a790-df88c3059c2b	authors	[{"affiliation": "LU Matem\\u0101tikas un inform\\u0101tikas instit\\u016bts", "email": "", "name": "Grasmanis, Mikus"}, {"affiliation": "", "email": "", "name": "LeldeLace"}, {"affiliation": "LU Matem\\u0101tikas un inform\\u0101tikas instit\\u016bts", "email": "", "name": "K\\u0101rlis \\u010cer\\u0101ns"}, {"affiliation": "", "email": "", "name": "Uldis Boj\\u0101rs"}]	active	3d6d1f15-9ade-4d65-8e4d-7c47ff3ec391
aebcfc6c-6ff9-44a0-a9da-b35de4eedb52	product_type	["model"]	active	3d6d1f15-9ade-4d65-8e4d-7c47ff3ec391
47f237bb-5791-4e14-9fed-da93ecd2dc92	authors	[{"affiliation": "IMAR, Universidade dos A\\u00e7ores, Marine and Environmental Sciences Centre (MARE), Universidade dos A\\u00e7ores, Departamento de Oceanografia e Pesca", "email": "", "name": "Gonz\\u00e1lez-Irusta, Jos\\u00e9 Manuel"}, {"affiliation": "IMAR, Universidade dos A\\u00e7ores, Marine and Environmental Sciences Centre (MARE), Universidade dos A\\u00e7ores, Departamento de Oceanografia e Pesca", "email": "", "name": "Dom\\u00ednguez-Carri\\u00f3, Carlos"}, {"affiliation": "IMAR, Universidade dos A\\u00e7ores, Marine and Environmental Sciences Centre (MARE), Universidade dos A\\u00e7ores, Departamento de Oceanografia e Pesca", "email": "", "name": "Carreiro-Silva, Marina"}, {"affiliation": "IMAR, Universidade dos A\\u00e7ores, Marine and Environmental Sciences Centre (MARE), Universidade dos A\\u00e7ores, Departamento de Oceanografia e Pesca", "email": "", "name": "Morato, Telmo"}]	active	95b1c645-ddc0-4cb7-8198-803bdf78d109
f4512147-cee0-420e-a38a-4c5ff4a94972	product_type	["derived_dataset"]	active	95b1c645-ddc0-4cb7-8198-803bdf78d109
fe619f0f-dcf3-48d3-8819-8a1ae8b6c018	publication_date	2018-05-28	active	95b1c645-ddc0-4cb7-8198-803bdf78d109
f86ee6ec-1c73-41d5-9d31-e56819c88d22	update_frequency	never	active	95b1c645-ddc0-4cb7-8198-803bdf78d109
d820fa29-d24b-46c7-978a-0c06726d5914	doi	10.5281/zenodo.17177436	active	d1af5e43-a9ac-4266-8797-61774039d9ce
fc7e9c9d-1505-4dcc-be7a-4d6ed04c7be1	source	zenodo	active	d1af5e43-a9ac-4266-8797-61774039d9ce
fbc81e8c-44fc-4229-abdd-d175d3f59b51	zenodo_record_id	17177436	active	d1af5e43-a9ac-4266-8797-61774039d9ce
93689c12-57fb-4cdd-b1a0-f34c71f5853f	contributing_organizations	[]	active	d1af5e43-a9ac-4266-8797-61774039d9ce
c195d9b8-4cb6-43ba-9f47-e639a6cbbfd1	authors	[{"affiliation": "", "email": "", "name": "Mestre-Tom\\u00e1s, Jorge"}, {"affiliation": "", "email": "", "name": "Fuster-Alonso, Alba"}, {"affiliation": "", "email": "", "name": "Bellido, Jos\\u00e9 M."}, {"affiliation": "", "email": "", "name": "Coll, Marta"}]	active	d1af5e43-a9ac-4266-8797-61774039d9ce
fc16d4fa-bd68-45f8-926b-85b5875ab449	product_type	["derived_dataset"]	active	d1af5e43-a9ac-4266-8797-61774039d9ce
caba4ae7-0d0a-40fb-b74f-735688b13b0f	publication_date	2025-09-22	active	d1af5e43-a9ac-4266-8797-61774039d9ce
db27b93f-6910-4e38-8941-1a2c6bf3bb0a	update_frequency	never	active	d1af5e43-a9ac-4266-8797-61774039d9ce
abe22293-4301-4550-a5c7-f857e29a4041	doi	10.5281/zenodo.7825749	active	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2
1f367db1-77e4-412a-a0b3-96626264104b	source	zenodo	active	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2
a389b9da-65bf-4080-900a-5883334fe151	zenodo_record_id	7825749	active	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2
96ace52d-46e4-4e50-b3ec-3a4e6bc8f71a	contributing_organizations	[]	active	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2
9fbd0e43-31f7-4132-a141-2b5828e156ed	authors	[{"affiliation": "Greenland Climate Research Centre, Greenland Institute of Natural Resources, Nuuk, Greenland", "email": "", "name": "Maier, SR"}]	active	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2
b344ccab-d952-4039-9478-7ff2d5f82b92	product_type	["derived_dataset"]	active	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2
ea8a20de-5eb6-45d7-83ee-9ce686898eaa	publication_date	2022-09-20	active	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2
89454e9f-09bf-4818-aa90-4ac4b3baf326	update_frequency	never	active	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2
532f88c6-809d-45fc-b712-76a1fd199ba6	doi	10.5281/zenodo.3338213	active	ff2a7a56-333b-477f-b51d-0cea766e2065
f266484b-a3c7-4eac-93a4-ca1741ac0f26	source	zenodo	active	ff2a7a56-333b-477f-b51d-0cea766e2065
67bd0ba5-1ec7-419d-b04a-d84ab20f17a0	zenodo_record_id	3338213	active	ff2a7a56-333b-477f-b51d-0cea766e2065
5058fd86-c619-4a8d-923d-ae6a97c86383	contributing_organizations	[]	active	ff2a7a56-333b-477f-b51d-0cea766e2065
5d1155d8-c913-4af8-a050-ad42496c8957	authors	[{"affiliation": "", "email": "", "name": "Samuel"}, {"affiliation": "UNESCO", "email": "", "name": "Pieter Provoost"}, {"affiliation": "UNESCO-IOC/OBIS", "email": "", "name": "Ward Appeltans"}]	active	ff2a7a56-333b-477f-b51d-0cea766e2065
c5e6bda9-f847-44ec-9289-5d1b4d40c5ce	product_type	["model"]	active	ff2a7a56-333b-477f-b51d-0cea766e2065
b87687d4-d5ec-444e-a172-185688c576ec	publication_date	2019-07-16	active	ff2a7a56-333b-477f-b51d-0cea766e2065
0b52fdd7-2324-4e5d-b4d8-fc4f968bf3f7	update_frequency	never	active	ff2a7a56-333b-477f-b51d-0cea766e2065
05179aa1-5ec2-478d-a788-87a9e0b14592	doi	10.5281/zenodo.11109585	active	9811ed68-164d-413d-bb38-4a43985b7f27
90a4405c-272c-437a-873c-9a34884a06d6	source	zenodo	active	9811ed68-164d-413d-bb38-4a43985b7f27
200691e8-9efc-4888-8947-0e46df8bf73e	zenodo_record_id	11109585	active	9811ed68-164d-413d-bb38-4a43985b7f27
c7f55f19-7b8e-42da-85ac-73f3f601de30	contributing_organizations	[]	active	9811ed68-164d-413d-bb38-4a43985b7f27
6b426b7f-9739-4a0d-82cc-21fbe9ee247f	authors	[{"affiliation": "", "email": "", "name": "aigaromane"}, {"affiliation": "", "email": "", "name": "Mikus Grasmanis"}, {"affiliation": "LU Matem\\u0101tikas un inform\\u0101tikas instit\\u016bts", "email": "", "name": "K\\u0101rlis \\u010cer\\u0101ns"}]	active	9811ed68-164d-413d-bb38-4a43985b7f27
229c511a-fe16-455a-8a2c-3c6bb7966f64	product_type	["model"]	active	9811ed68-164d-413d-bb38-4a43985b7f27
040a418f-2421-4445-8572-be3d1367b8da	publication_date	2024-05-03	active	9811ed68-164d-413d-bb38-4a43985b7f27
25b86259-b35b-4392-aa72-b45fed34950f	update_frequency	never	active	9811ed68-164d-413d-bb38-4a43985b7f27
c553055f-bb30-4708-9ae4-c6aba8b1e7f9	doi	10.5281/zenodo.3378317	active	1d0e3358-195f-49a7-bf1c-8f91634952f0
2f0c95ee-9e63-4615-a550-70c18e79390a	source	zenodo	active	1d0e3358-195f-49a7-bf1c-8f91634952f0
f1de6a8f-54c7-4987-91dc-7d4ebddf526f	zenodo_record_id	3378317	active	1d0e3358-195f-49a7-bf1c-8f91634952f0
c75fa1b7-b202-47b3-bd75-1ab221ba0fb3	contributing_organizations	[]	active	1d0e3358-195f-49a7-bf1c-8f91634952f0
df610539-92aa-40b1-a4ac-e5e7a676e2f8	authors	[{"affiliation": "", "email": "", "name": "U. Rosas-Puchuri"}]	active	1d0e3358-195f-49a7-bf1c-8f91634952f0
2e3c78be-3063-439d-8711-6e5865174b5f	product_type	["model"]	active	1d0e3358-195f-49a7-bf1c-8f91634952f0
163879ed-baf1-45c6-b2b8-c3ec37a54b3f	publication_date	2019-08-27	active	1d0e3358-195f-49a7-bf1c-8f91634952f0
3549e7f2-de09-4082-bf31-9ca8b1caa5c8	update_frequency	never	active	1d0e3358-195f-49a7-bf1c-8f91634952f0
28f9354c-6dba-4477-aca0-9441b7375213	publication_date	2024-04-25	active	3d6d1f15-9ade-4d65-8e4d-7c47ff3ec391
383d9b2b-3904-428b-a736-a43b2db62eb9	update_frequency	never	active	3d6d1f15-9ade-4d65-8e4d-7c47ff3ec391
8c84606b-14c2-4a5b-8402-dacf9fa57161	doi	10.5281/zenodo.6969395	active	0f0df252-0d80-42f0-9438-3d7f056c3f62
35eef83d-6912-4bce-b9fa-fe2d86c04f05	source	zenodo	active	0f0df252-0d80-42f0-9438-3d7f056c3f62
c7924c69-9303-44ca-8547-e99219bd388d	zenodo_record_id	6969395	active	0f0df252-0d80-42f0-9438-3d7f056c3f62
415c6054-50c1-4d45-810d-4dc96d0a82f6	contributing_organizations	[]	active	0f0df252-0d80-42f0-9438-3d7f056c3f62
17a3e631-77ad-444b-ad41-a4d99f8c8d4c	authors	[{"affiliation": "UNESCO", "email": "", "name": "Pieter Provoost"}, {"affiliation": "", "email": "", "name": "Samuel Bosch"}, {"affiliation": "", "email": "", "name": "Ben Best"}]	active	0f0df252-0d80-42f0-9438-3d7f056c3f62
b721e232-afd0-446a-ab89-c2f96e265c42	product_type	["model"]	active	0f0df252-0d80-42f0-9438-3d7f056c3f62
739ccde1-7cc4-4a9f-9392-08089e37243b	publication_date	2022-08-06	active	0f0df252-0d80-42f0-9438-3d7f056c3f62
cb40652e-f094-43cc-b719-df192fce37a7	update_frequency	never	active	0f0df252-0d80-42f0-9438-3d7f056c3f62
d7f7e1ce-9f8c-4399-82e8-503e30725f10	doi	10.5281/zenodo.15113967	active	c2cf9f76-94bc-4ac3-a031-3c7d049a8332
fbeeb8cf-dd94-4296-82b8-e8f26a0a5c46	source	zenodo	active	c2cf9f76-94bc-4ac3-a031-3c7d049a8332
a607bc49-2ba4-43b0-99ea-72eecf638b90	zenodo_record_id	15113967	active	c2cf9f76-94bc-4ac3-a031-3c7d049a8332
abb7ff75-7909-48b9-9f6c-b697aec219aa	contributing_organizations	[]	active	c2cf9f76-94bc-4ac3-a031-3c7d049a8332
fa0a9ac6-a858-4b39-87d6-8366a195bc4c	authors	[{"affiliation": "", "email": "", "name": "Biddle, Mathew"}, {"affiliation": "", "email": "", "name": "Brenskelle, Laura"}, {"affiliation": "", "email": "", "name": "Diorio, Mimi"}]	active	c2cf9f76-94bc-4ac3-a031-3c7d049a8332
a9a74a45-4d6a-49e9-810d-ac42c17edeb0	product_type	["model"]	active	c2cf9f76-94bc-4ac3-a031-3c7d049a8332
538ff765-d898-437f-83d5-17812c4399fe	publication_date	2025-03-31	active	c2cf9f76-94bc-4ac3-a031-3c7d049a8332
926d6a2b-898f-4f44-88ed-8e8a65277b44	update_frequency	never	active	c2cf9f76-94bc-4ac3-a031-3c7d049a8332
57a9752b-36b6-4aee-8173-2493f99d2884	doi	10.5281/zenodo.15924033	active	6b81344e-8b2b-43c6-9d3c-7cbc34f9eb33
6cc8c964-8ad7-4d66-bc24-351f3ec373d6	source	zenodo	active	6b81344e-8b2b-43c6-9d3c-7cbc34f9eb33
44740b1e-ea82-48b2-9f19-c28498fb7b07	zenodo_record_id	15924033	active	6b81344e-8b2b-43c6-9d3c-7cbc34f9eb33
61cb4049-6892-4f70-b883-8348edd27333	contributing_organizations	[]	active	6b81344e-8b2b-43c6-9d3c-7cbc34f9eb33
fdf9384a-50c5-4bcd-bfaa-26b9885feaa8	authors	[{"affiliation": "", "email": "", "name": "Murray, Tylar"}, {"affiliation": "", "email": "", "name": "Biddle, Mathew"}, {"affiliation": "", "email": "", "name": "Rumman, Mehraz"}]	active	6b81344e-8b2b-43c6-9d3c-7cbc34f9eb33
c8a48938-20a3-4f9c-8a76-a231ecd7bc6a	product_type	["model"]	active	6b81344e-8b2b-43c6-9d3c-7cbc34f9eb33
92c29d2c-ddc3-412f-b4dc-21c378f9c9b2	publication_date	2025-07-15	active	6b81344e-8b2b-43c6-9d3c-7cbc34f9eb33
8ca951d4-b864-43e5-b84a-3ae50554bdb6	update_frequency	never	active	6b81344e-8b2b-43c6-9d3c-7cbc34f9eb33
5a679e07-d114-42ac-b4a1-612fda51f474	doi	10.5281/zenodo.15836332	active	83bb0f87-8e4c-4f34-bc3a-83abbc2432d5
04d91947-490e-4c3b-80c3-a5d8e6263c4e	source	zenodo	active	83bb0f87-8e4c-4f34-bc3a-83abbc2432d5
c940071a-fd7c-460d-9464-3b165699a6df	zenodo_record_id	15836332	active	83bb0f87-8e4c-4f34-bc3a-83abbc2432d5
940289af-2b6e-49b2-af68-9b84b4e9c06c	contributing_organizations	[]	active	83bb0f87-8e4c-4f34-bc3a-83abbc2432d5
a6074047-558a-442c-a005-69eeb56a5751	authors	[{"affiliation": "", "email": "", "name": "CCYCheung"}]	active	83bb0f87-8e4c-4f34-bc3a-83abbc2432d5
ecc02304-2d11-4758-bf5c-9d471fa1d010	product_type	["model"]	active	83bb0f87-8e4c-4f34-bc3a-83abbc2432d5
7cfbbbee-9680-4eb8-af23-671b9780031b	publication_date	2025-07-08	active	83bb0f87-8e4c-4f34-bc3a-83abbc2432d5
4b5c7d1e-9ffa-4468-86e7-9eb564398e11	update_frequency	never	active	83bb0f87-8e4c-4f34-bc3a-83abbc2432d5
2fb88801-0ac7-4f8f-84af-d8212396e186	doi	10.5281/zenodo.5841930	active	2d1f79c3-6ad1-424a-a6e2-48cb405e11bf
6166c4f2-99d6-4487-881b-9fb4303ae31d	source	zenodo	active	2d1f79c3-6ad1-424a-a6e2-48cb405e11bf
7941613f-8ea5-4b46-b593-8ef82626bb74	zenodo_record_id	5841930	active	2d1f79c3-6ad1-424a-a6e2-48cb405e11bf
527d1cac-1f49-49ae-84b4-305b6a1370ea	contributing_organizations	[]	active	2d1f79c3-6ad1-424a-a6e2-48cb405e11bf
75df57d5-0bb2-482b-84cc-0515fa53dbca	authors	[{"affiliation": "", "email": "", "name": "Hanno Seebens"}, {"affiliation": "", "email": "", "name": "Ekin Kaplan"}]	active	2d1f79c3-6ad1-424a-a6e2-48cb405e11bf
fcb0645d-01b2-455d-840a-cfd75837eeea	product_type	["model"]	active	2d1f79c3-6ad1-424a-a6e2-48cb405e11bf
76180caf-c0d4-4a14-bbe6-6b02a2f11a1b	publication_date	2022-01-12	active	2d1f79c3-6ad1-424a-a6e2-48cb405e11bf
d2406e61-338d-4c07-b70d-70bd3c4f9d2b	update_frequency	never	active	2d1f79c3-6ad1-424a-a6e2-48cb405e11bf
88c6f787-e414-4f96-b2d7-a4b9e97ed0e2	doi	10.5281/zenodo.7036564	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd
9aab2b01-c8d3-4245-8bbd-6267d06cf636	source	zenodo	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd
b11538b9-9c0a-41cf-8b07-d7c2862b2ead	zenodo_record_id	7036564	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd
c4569dcb-0054-4efe-8ce6-95bb8d2bbb48	contributing_organizations	[]	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd
9655ffb5-a03d-4c66-85d2-7399293321fd	update_frequency	never	active	d9f6dd4f-f254-4e96-a466-1654a4b06449
44d10a82-9283-4e5c-81ce-26a23d0db6b7	doi	10.5281/zenodo.5494452	active	55991d34-aa45-4ea7-a977-c70fbba37890
3f40a697-5c16-4f92-8ff5-9bbad34c096f	source	zenodo	active	55991d34-aa45-4ea7-a977-c70fbba37890
9b1be47e-72b6-43a3-b497-7c63213ff1d9	zenodo_record_id	5494452	active	55991d34-aa45-4ea7-a977-c70fbba37890
3f2474f1-dfe3-4d18-9a75-42f069709126	contributing_organizations	[]	active	55991d34-aa45-4ea7-a977-c70fbba37890
711a1eb7-d860-42e4-b4fd-7cb382b04193	source	zenodo	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2
26813e84-b2df-4074-b16d-fe4aa313457b	authors	[{"affiliation": "University of Central Florida", "email": "", "name": "Jenkins, David"}, {"affiliation": "University of Central Florida", "email": "", "name": "Bevan, Hannah"}, {"affiliation": "University of Central Florida", "email": "", "name": "Chen, Wei"}, {"affiliation": "University of Central Florida", "email": "", "name": "Hart, Jacob"}, {"affiliation": "University of Central Florida", "email": "", "name": "Lindsay, Amanda"}, {"affiliation": "University of Central Florida", "email": "", "name": "Macamo, Laura"}, {"affiliation": "University of Central Florida", "email": "", "name": "Negash, Mekail"}, {"affiliation": "University of Florida", "email": "", "name": "Ohyama, Leo"}, {"affiliation": "University of Central Florida", "email": "", "name": "Pandolfi, Alessandra"}, {"affiliation": "University of Central Florida", "email": "", "name": "Zaragoza, George"}]	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd
6bfe757d-df49-492d-bff7-52649bb7e4a4	product_type	["model"]	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd
7d2f02fe-da06-47d5-aa75-f50d2801643f	publication_date	2024-02-29	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd
f6b4b0ae-fd8d-4921-8e22-58eb2204f3b0	update_frequency	never	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd
a5e46d36-414d-4368-8ff9-fb5582512f7b	doi	10.5281/zenodo.10054162	active	746a8dda-4152-43e5-bd24-9ddba814be52
e0af2386-bba9-4eea-a58c-3d6c981eae98	source	zenodo	active	746a8dda-4152-43e5-bd24-9ddba814be52
788f7689-55e3-491e-81ef-52206d979dbc	zenodo_record_id	10054162	active	746a8dda-4152-43e5-bd24-9ddba814be52
2ef8d9e9-869a-4ca3-8e53-12aa245b960b	contributing_organizations	[]	active	746a8dda-4152-43e5-bd24-9ddba814be52
327b81dc-b58d-435c-bc05-d44286a59901	authors	[{"affiliation": "Senckenberg, Frankfurt, Germany", "email": "", "name": "Seebens, Hanno"}]	active	746a8dda-4152-43e5-bd24-9ddba814be52
a21961c6-a9dd-4589-a74d-97603d38e631	product_type	["derived_dataset"]	active	746a8dda-4152-43e5-bd24-9ddba814be52
d0a0daef-f387-4364-8506-0a22195fbdf7	publication_date	2023-10-31	active	746a8dda-4152-43e5-bd24-9ddba814be52
42e487a9-b4b2-4071-aabc-991b5dc6c51f	update_frequency	never	active	746a8dda-4152-43e5-bd24-9ddba814be52
064be409-2f81-4e14-84ab-b585805f2af1	doi	10.5281/zenodo.15487410	active	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497
b95335bc-30f7-4e9c-8ccb-64bfa0189cb3	source	zenodo	active	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497
a9011c86-6f20-42f2-b17b-56fca952dc0c	zenodo_record_id	15487410	active	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497
d8fee2dd-047d-49b9-b152-0f0066890340	contributing_organizations	[]	active	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497
a2c08cc9-621c-44a8-863b-3983b7cba603	authors	[{"affiliation": "University of Plymouth", "email": "", "name": "Bridges, Amelia"}, {"affiliation": "University of Plymouth", "email": "", "name": "Howell, Kerry"}]	active	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497
113f5c69-9e55-4dc8-85dd-ea6ced73cde6	product_type	["derived_dataset"]	active	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497
f6ef0aaa-8e45-484d-a857-a67ea833f6db	publication_date	2025-05-27	active	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497
0f3122d6-f667-4378-beef-b59b5c1adaef	update_frequency	never	active	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497
24e3fff8-8284-4ffa-9173-60d1a8d865b6	doi	10.5281/zenodo.3235548	active	23709528-2e6b-48f8-a412-3b93612b80c6
42a4c186-fc27-4d2d-9418-241bf92129c5	source	zenodo	active	23709528-2e6b-48f8-a412-3b93612b80c6
640338a8-b0f4-4746-acdd-c352094bf1e2	zenodo_record_id	3235548	active	23709528-2e6b-48f8-a412-3b93612b80c6
cab1e998-cf7d-4a22-93d9-31627dd83ca1	contributing_organizations	[]	active	23709528-2e6b-48f8-a412-3b93612b80c6
46e9333d-6fc9-4f35-bde3-8398bafa6b3b	authors	[{"affiliation": "CESIMAR-CENPAT-CONICET", "email": "", "name": "Marcos daniel zarate"}]	active	23709528-2e6b-48f8-a412-3b93612b80c6
4d3ab2cf-77b4-4196-bbc3-5a5dfb68a055	product_type	["derived_dataset"]	active	23709528-2e6b-48f8-a412-3b93612b80c6
c9c7af5a-8236-4f09-b1eb-832781126ce8	publication_date	2018-12-02	active	23709528-2e6b-48f8-a412-3b93612b80c6
dcc11f6f-285e-41cc-bdc1-efd10d7ceeaa	update_frequency	never	active	23709528-2e6b-48f8-a412-3b93612b80c6
61fb4279-c932-43a0-956c-88158919a7cb	doi	10.5281/zenodo.15276467	active	8cfb4d21-ca59-4e78-a48b-9d0bdadf15c6
01864b0d-4e60-415b-ba69-3ee45b9a8f9c	source	zenodo	active	8cfb4d21-ca59-4e78-a48b-9d0bdadf15c6
47cd2f8c-3773-45d3-8998-3978fa05c76d	zenodo_record_id	15276467	active	8cfb4d21-ca59-4e78-a48b-9d0bdadf15c6
65466df7-0628-475c-bf6f-3a38383455d1	contributing_organizations	[]	active	8cfb4d21-ca59-4e78-a48b-9d0bdadf15c6
22458d24-ae0a-485f-9eb6-ff04fe7e689a	authors	[{"affiliation": "Ollscoil na Gaillimhe \\u2013 University of Galway", "email": "", "name": "Ferreira, Jessica Afonso"}, {"affiliation": "Ollscoil na Gaillimhe \\u2013 University of Galway", "email": "", "name": "Johnson, Mark Peter"}]	active	8cfb4d21-ca59-4e78-a48b-9d0bdadf15c6
76b1752f-eaef-430a-877b-52e87403b6a0	product_type	["derived_dataset"]	active	8cfb4d21-ca59-4e78-a48b-9d0bdadf15c6
6a6a24a2-85fc-43ed-9ee5-9d0c3a7698c2	publication_date	2025-04-24	active	8cfb4d21-ca59-4e78-a48b-9d0bdadf15c6
4cba205a-9967-4ad3-b7f4-0e1370c5931e	update_frequency	never	active	8cfb4d21-ca59-4e78-a48b-9d0bdadf15c6
5dc27e54-9901-44c6-b3a1-0111669126ca	doi	10.5281/zenodo.13833556	active	d9f6dd4f-f254-4e96-a466-1654a4b06449
7b28e831-1732-4f63-84d5-d05e33ef5c2f	source	zenodo	active	d9f6dd4f-f254-4e96-a466-1654a4b06449
6cd3907c-85ce-4a56-97ef-ce4cd1bdff23	zenodo_record_id	13833556	active	d9f6dd4f-f254-4e96-a466-1654a4b06449
76e979ac-5272-47aa-974e-1dd277ecafbb	contributing_organizations	[]	active	d9f6dd4f-f254-4e96-a466-1654a4b06449
2d3b277f-dc85-4cad-a1ff-db490de2061a	authors	[{"affiliation": "Institut de Ci\\u00e8ncies del Mar", "email": "", "name": "Mestre-Tom\\u00e1s, Jorge"}, {"affiliation": "Institut de Ci\\u00e8ncies del Mar", "email": "", "name": "Fuster-Alonso, Alba"}, {"affiliation": "Instituto Espa\\u00f1ol de Oceanograf\\u00eda", "email": "", "name": "Bellido, Jos\\u00e9 M."}, {"affiliation": "Institut de Ci\\u00e8ncies del Mar", "email": "", "name": "Coll, Marta"}]	active	d9f6dd4f-f254-4e96-a466-1654a4b06449
00b0aba7-9713-4005-a526-777122cfd443	product_type	["derived_dataset"]	active	d9f6dd4f-f254-4e96-a466-1654a4b06449
15a408cd-220a-469e-9e6a-e63150f0584a	publication_date	2024-09-24	active	d9f6dd4f-f254-4e96-a466-1654a4b06449
137a9f59-4699-477b-a890-5dbb5f4bc6fd	authors	[{"affiliation": "Friedrich-Alexander University Erlangen-N\\u00fcrnberg", "email": "", "name": "Eichenseer, Kilian"}, {"affiliation": "University of Plymouth", "email": "", "name": "Balthasar, Uwe"}, {"affiliation": "University of Plymouth", "email": "", "name": "Smart, Christopher W."}, {"affiliation": "Friedrich-Alexander University Erlangen-N\\u00fcrnberg", "email": "", "name": "Kiessling, Wolfgang"}]	active	55991d34-aa45-4ea7-a977-c70fbba37890
4a300280-2689-4200-8d0c-a46831a44a49	product_type	["derived_dataset"]	active	55991d34-aa45-4ea7-a977-c70fbba37890
14b669f3-1610-42eb-b45e-79fdfb5933e0	publication_date	2021-09-09	active	55991d34-aa45-4ea7-a977-c70fbba37890
a84cb95f-5b0b-4866-a4bb-328deaa6094a	update_frequency	never	active	55991d34-aa45-4ea7-a977-c70fbba37890
43c65109-5142-424c-8878-41c063225f2f	doi	10.5281/zenodo.16739002	active	028ab429-14fe-491a-a255-c2f7e80c7f4c
ac3cfef6-2b4c-425a-8b60-b5f6cebc9078	source	zenodo	active	028ab429-14fe-491a-a255-c2f7e80c7f4c
c10cc081-af2c-4ec7-99e5-b460a7942cfc	zenodo_record_id	16739002	active	028ab429-14fe-491a-a255-c2f7e80c7f4c
fcf439e9-1a7a-4ab2-b77e-40827399a8b9	contributing_organizations	[]	active	028ab429-14fe-491a-a255-c2f7e80c7f4c
7c94c773-63c7-4674-b8f6-52dd452ae743	authors	[{"affiliation": "University of Copenhagen", "email": "", "name": "Owens, Hannah"}]	active	028ab429-14fe-491a-a255-c2f7e80c7f4c
e5f805d8-73bc-4a90-a098-37d865ccb976	product_type	["derived_dataset"]	active	028ab429-14fe-491a-a255-c2f7e80c7f4c
b14758cf-9fa0-448a-a1ae-8e37f9651ca7	publication_date	2025-08-04	active	028ab429-14fe-491a-a255-c2f7e80c7f4c
462c5c5f-c356-4d12-8573-4324523e8f12	update_frequency	never	active	028ab429-14fe-491a-a255-c2f7e80c7f4c
c93c0fe5-14c0-49ed-87ef-70c036b8c656	doi	10.5281/zenodo.5101349	active	3b773a9f-1bc6-43de-b357-02adfb275230
a8333344-1208-42ae-826c-86e3c52bb78b	source	zenodo	active	3b773a9f-1bc6-43de-b357-02adfb275230
486aff24-cb73-414d-a0af-dda63f7358f8	zenodo_record_id	5101349	active	3b773a9f-1bc6-43de-b357-02adfb275230
972344b2-0836-46ca-ad56-d12922afa546	contributing_organizations	[]	active	3b773a9f-1bc6-43de-b357-02adfb275230
e9054329-40cd-4a93-b813-99c1c3c15673	authors	[{"affiliation": "Environmental Physics, Institute of Biogeochemistry and Pollutant Dynamics, ETH Z\\u00fcrich, Universit\\u00e4tstrasse 16, 8092 Z\\u00fcrich, Switzerland.", "email": "", "name": "Fabio Benedetti"}, {"affiliation": "Environmental Physics, Institute of Biogeochemistry and Pollutant Dynamics, ETH Z\\u00fcrich, Universit\\u00e4tstrasse 16, 8092 Z\\u00fcrich, Switzerland.", "email": "", "name": "Meike Vogt"}, {"affiliation": "Environmental Physics, Institute of Biogeochemistry and Pollutant Dynamics, ETH Z\\u00fcrich, Universit\\u00e4tstrasse 16, 8092 Z\\u00fcrich, Switzerland.", "email": "", "name": "Urs Hofmann-Elizondo"}, {"affiliation": "Dynamic Macroecology, Landscape Dynamics, Swiss Federal Research Institute WSL, 8903 Birmensdorf, Switzerland.", "email": "", "name": "Damiano Righetti"}, {"affiliation": "Dynamic Macroecology, Landscape Dynamics, Swiss Federal Research Institute WSL, 8903 Birmensdorf, Switzerland.", "email": "", "name": "Niklaus E. Zimmermann"}, {"affiliation": "Environmental Physics, Institute of Biogeochemistry and Pollutant Dynamics, ETH Z\\u00fcrich, Universit\\u00e4tstrasse 16, 8092 Z\\u00fcrich, Switzerland.", "email": "", "name": "Nicolas Gruber"}]	active	3b773a9f-1bc6-43de-b357-02adfb275230
d19e6f7a-b489-4dca-9683-f6b1933966e9	product_type	["derived_dataset"]	active	3b773a9f-1bc6-43de-b357-02adfb275230
8441260a-0fd3-498d-8165-cb2f8e4fd0d7	publication_date	2021-07-14	active	3b773a9f-1bc6-43de-b357-02adfb275230
69942d0e-fe00-4a33-90c3-86c417fe44ea	update_frequency	never	active	3b773a9f-1bc6-43de-b357-02adfb275230
ee150cd4-36c0-4382-93d1-379284a70160	doi	10.5281/zenodo.15610736	active	e7fd1d07-886e-4140-b09c-168d019d22c0
2feaca7a-158c-4257-a8f6-9b26d14ebeab	source	zenodo	active	e7fd1d07-886e-4140-b09c-168d019d22c0
cfa38d52-0085-4342-9714-a8e6dd8fe7d4	zenodo_record_id	15610736	active	e7fd1d07-886e-4140-b09c-168d019d22c0
fbabf4ef-64fc-4db9-b6d0-117aed8c217c	contributing_organizations	[]	active	e7fd1d07-886e-4140-b09c-168d019d22c0
83af7456-c2d4-4821-993d-8bf60be815d3	authors	[{"affiliation": "", "email": "", "name": "Anonymous"}]	active	e7fd1d07-886e-4140-b09c-168d019d22c0
5576ad66-69b5-45a2-a652-981473a2567b	product_type	["derived_dataset"]	active	e7fd1d07-886e-4140-b09c-168d019d22c0
2fe93013-a8f6-4d9e-b3f2-799031b3c241	publication_date	2025-06-06	active	e7fd1d07-886e-4140-b09c-168d019d22c0
d0a280c4-c22f-416b-90c4-28af6dfcb36d	update_frequency	never	active	e7fd1d07-886e-4140-b09c-168d019d22c0
c0e46ad6-fb5c-453f-a85e-556ef3e7b058	doi	10.5281/zenodo.10951348	active	3a22025a-fa37-4d87-bf9b-ebf9622c6e60
d5673a18-d0f3-4945-a1f7-c905ba00edd4	source	zenodo	active	3a22025a-fa37-4d87-bf9b-ebf9622c6e60
e7108fc0-8065-4b79-ba33-6175c564356f	zenodo_record_id	10951348	active	3a22025a-fa37-4d87-bf9b-ebf9622c6e60
4fea4ed4-f343-4b4e-a5f8-88dbcb47432b	contributing_organizations	[]	active	3a22025a-fa37-4d87-bf9b-ebf9622c6e60
3e75c6a5-8b7d-45ef-a272-a69090e7374b	authors	[{"affiliation": "", "email": "", "name": "Serandour, Baptiste"}]	active	3a22025a-fa37-4d87-bf9b-ebf9622c6e60
d3d8d14c-9bb1-4141-92e4-d60205047583	product_type	["derived_dataset"]	active	3a22025a-fa37-4d87-bf9b-ebf9622c6e60
86ac6077-2f1e-4305-b550-9430db6dacae	publication_date	2024-04-12	active	3a22025a-fa37-4d87-bf9b-ebf9622c6e60
8784e90c-94a6-4a54-9a1c-c992d339edf3	update_frequency	never	active	3a22025a-fa37-4d87-bf9b-ebf9622c6e60
b7cc6ca7-ab42-4259-a4a5-c078d0efca46	doi	10.5281/zenodo.15396200	active	fbf63ee1-5ffe-41ee-9732-a47889ed8e69
7250d3db-5ba2-4347-8b4d-f20d8402afca	source	zenodo	active	fbf63ee1-5ffe-41ee-9732-a47889ed8e69
040b135a-7bb3-4e1d-a1ce-c2a78efb72e7	zenodo_record_id	15396200	active	fbf63ee1-5ffe-41ee-9732-a47889ed8e69
45da8459-7815-416a-966e-5693ff29c5c0	contributing_organizations	[]	active	fbf63ee1-5ffe-41ee-9732-a47889ed8e69
01968824-a569-4872-b26f-9580aa0b8cc8	product_type	["derived_dataset"]	active	7591d5e4-f147-46ac-81d4-458e33ba5ddc
dbc6781e-6daf-4815-9b6d-a877454f8554	publication_date	2025-04-09	active	7591d5e4-f147-46ac-81d4-458e33ba5ddc
381fe83c-2c0b-4970-aff6-fac614131c9a	update_frequency	never	active	7591d5e4-f147-46ac-81d4-458e33ba5ddc
e260f470-5a92-4df6-aa78-3964c1e9b78a	doi	10.5281/zenodo.3529008	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2
7057d2ca-9653-4682-a379-14ad029ef389	authors	[{"affiliation": "Institute of Marine Ecosystem and Fishery Science, University of Hamburg", "email": "", "name": "K\\u00fcrzel, Karlotta"}, {"affiliation": "", "email": "", "name": "Hammock, Craig"}, {"affiliation": "The Arctic University Museum of Norway, UiT The Arctic University of Norway, Troms\\u00f8, Norway", "email": "", "name": "Pitusi, Vanessa"}, {"affiliation": "Institute of Marine Ecosystem and Fishery Science, University of Hamburg", "email": "", "name": "Brix, Saskia"}, {"affiliation": "Institute of Marine Ecosystem and Fishery Science, University of Hamburg", "email": "", "name": "L\\u00f6rz, Anne-Nina"}]	active	fbf63ee1-5ffe-41ee-9732-a47889ed8e69
f878f26b-7148-40cb-a778-faed4aaa7929	product_type	["derived_dataset"]	active	fbf63ee1-5ffe-41ee-9732-a47889ed8e69
161b930d-df03-4e2c-945d-15fa93854c94	publication_date	2025-06-05	active	fbf63ee1-5ffe-41ee-9732-a47889ed8e69
667b8c2e-bcf6-4765-9336-6086671a70dd	update_frequency	never	active	fbf63ee1-5ffe-41ee-9732-a47889ed8e69
6e4a885c-597b-4f19-a72c-3deb3d3c5976	doi	10.5061/dryad.fj6q573q3	active	8dc24d5d-aaa6-498c-b204-2317dec0460e
5c188fb1-c39b-481b-b334-a42022f22cd3	product_type	["derived_dataset"]	active	8dc24d5d-aaa6-498c-b204-2317dec0460e
1d6be7a1-54e3-42e2-b938-082fc9d5b2bd	update_frequency	never	active	8dc24d5d-aaa6-498c-b204-2317dec0460e
8ced73b9-b9e8-4f4a-8e19-7fa540aeba71	source	datacite	active	8dc24d5d-aaa6-498c-b204-2317dec0460e
3416be71-ad51-4410-9950-fe86d86507d8	contributing_organizations	[]	active	8dc24d5d-aaa6-498c-b204-2317dec0460e
f30c4e47-f86c-462b-bb23-8468cc9bb3c3	doi	10.5281/zenodo.16791361	active	31dc8a44-e9b7-44e8-821a-5c602b7c1d00
c81016ef-c1c8-4f2d-ba1c-8cc1ad7d537d	source	zenodo	active	31dc8a44-e9b7-44e8-821a-5c602b7c1d00
2d864820-f3e6-45b2-95bb-b5ac5f31bcc1	zenodo_record_id	16791361	active	31dc8a44-e9b7-44e8-821a-5c602b7c1d00
f9073f3e-253c-42cb-9ed9-1796a249307c	contributing_organizations	[]	active	31dc8a44-e9b7-44e8-821a-5c602b7c1d00
ed822114-655e-4351-8bab-992337f8b8e0	authors	[{"affiliation": "University of Auckland", "email": "", "name": "li, longyu"}]	active	31dc8a44-e9b7-44e8-821a-5c602b7c1d00
6f8848bf-b2d4-45d5-aa87-0cbd0f5a3706	product_type	["derived_dataset"]	active	31dc8a44-e9b7-44e8-821a-5c602b7c1d00
652a1a2c-1f59-4b5e-b11e-9da161058bb9	publication_date	2025-08-11	active	31dc8a44-e9b7-44e8-821a-5c602b7c1d00
60020a9e-a4bc-4188-84fc-5494c46f8738	update_frequency	never	active	31dc8a44-e9b7-44e8-821a-5c602b7c1d00
3762fc57-bd44-40a8-bb0c-6ede54683124	doi	10.5281/zenodo.6770200	active	4571b411-cc4e-408a-8fc0-4454f5694fd0
46124e07-3bd8-4e2a-a7b4-0f2ba255ac22	source	zenodo	active	4571b411-cc4e-408a-8fc0-4454f5694fd0
0871aadd-03eb-4de1-a1c6-e66b8a0a8870	zenodo_record_id	6770200	active	4571b411-cc4e-408a-8fc0-4454f5694fd0
8be11abf-cc72-4ed8-ab28-af4658917097	contributing_organizations	[]	active	4571b411-cc4e-408a-8fc0-4454f5694fd0
f7108b59-e913-4223-8f0e-394bbff5c06b	authors	[{"affiliation": "LMU M\\u00fcnich", "email": "", "name": "Kopperud, Bj\\u00f8rn Tore"}, {"affiliation": "Chicago Field Museum", "email": "", "name": "Lidgard, Scott"}, {"affiliation": "University of Oslo", "email": "", "name": "Liow, Lee Hsiang"}]	active	4571b411-cc4e-408a-8fc0-4454f5694fd0
27fa0976-3d4f-4e6d-982e-7cf54360ab2e	product_type	["derived_dataset"]	active	4571b411-cc4e-408a-8fc0-4454f5694fd0
8f9efcaf-79e4-4d44-86d4-eda549392b57	publication_date	2022-06-28	active	4571b411-cc4e-408a-8fc0-4454f5694fd0
f5228aed-bfa5-4da9-9791-4e16aa8ed099	update_frequency	never	active	4571b411-cc4e-408a-8fc0-4454f5694fd0
3fd7860d-bf9a-4af0-8ae9-96c253b7dfec	doi	10.5281/zenodo.3606645	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8
d49586ab-0336-4d98-8ffa-0a3495537d67	source	zenodo	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8
3ba03ede-8aea-4c47-9473-9c60e670017e	zenodo_record_id	3606645	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8
0a484d8f-1c52-4713-a08c-90dc1751f66f	contributing_organizations	[]	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8
a87047b5-ad3c-467b-bf85-12282357e41f	authors	[{"affiliation": "Smithsonian Tropical Research Institute", "email": "", "name": "Robertson, D Ross"}, {"affiliation": "Smithsonian Tropical Research Institute", "email": "", "name": "Pe\\u00f1a, Ernesto"}]	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8
bdd003a6-2719-44e0-b6fb-00fd8e38ae1e	product_type	["derived_dataset"]	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8
9277bf31-154b-45e0-ab17-9203192ebfc3	publication_date	2020-01-13	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8
a874a9fa-09fb-4fc2-8c24-00d0a9cbaa23	update_frequency	never	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8
caa5cda9-968f-44d2-9b1e-7cb2db7a0749	doi	10.5281/zenodo.12713667	active	02312a9e-957d-4546-b477-34f40c752534
613c8bf4-5513-4d51-af57-b47e1436467a	source	zenodo	active	02312a9e-957d-4546-b477-34f40c752534
55fdbf42-dde3-4461-a57c-67926634b7f0	zenodo_record_id	12713667	active	02312a9e-957d-4546-b477-34f40c752534
67f69a5e-66e3-4f8d-b009-eada2c330cda	contributing_organizations	[]	active	02312a9e-957d-4546-b477-34f40c752534
7a645afd-954f-4b83-9640-0eb1b4064659	authors	[{"affiliation": "", "email": "", "name": "Pruvost, Patrice"}, {"affiliation": "", "email": "", "name": "Causse, Romain"}, {"affiliation": "", "email": "", "name": "Bailly, Nicolas"}]	active	02312a9e-957d-4546-b477-34f40c752534
1df2a224-783d-479c-9ddc-376d1217eb90	product_type	["derived_dataset"]	active	02312a9e-957d-4546-b477-34f40c752534
a24b9aad-692e-4a97-a212-4ae802a6be94	publication_date	2023-04-20	active	02312a9e-957d-4546-b477-34f40c752534
47201ee4-7591-4120-a9d8-3471e5f03bf8	update_frequency	never	active	02312a9e-957d-4546-b477-34f40c752534
19a6d6ca-21d4-4041-a5a6-9538d8377d74	doi	10.5281/zenodo.15219322	active	7591d5e4-f147-46ac-81d4-458e33ba5ddc
1dbf5181-76fd-47fb-a475-e96f6aff8460	source	zenodo	active	7591d5e4-f147-46ac-81d4-458e33ba5ddc
fa4923cd-daf6-4901-963b-62a46aa2a354	zenodo_record_id	15219322	active	7591d5e4-f147-46ac-81d4-458e33ba5ddc
9d5dbc88-9628-406b-bc7d-c4225d2af821	contributing_organizations	[]	active	7591d5e4-f147-46ac-81d4-458e33ba5ddc
5e11c20d-80a4-4fd7-9619-572ca2ee3e1a	authors	[{"affiliation": "", "email": "", "name": "Periasamy, Rengaiyan"}, {"affiliation": "", "email": "", "name": "Kurian, Palayil John"}, {"affiliation": "", "email": "", "name": "Ingole, Baban"}]	active	7591d5e4-f147-46ac-81d4-458e33ba5ddc
9f24720f-fcea-4275-9043-1758b914c057	zenodo_record_id	3529008	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2
a8790a90-5b41-48cd-9e5d-3fbc73a36ee7	contributing_organizations	[]	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2
ef052dd9-a06d-4c7c-8fc1-6f62da783e54	authors	[{"affiliation": "", "email": "", "name": "Lima, Manuela M."}, {"affiliation": "", "email": "", "name": "Cordeiro, Ralf T. S."}, {"affiliation": "", "email": "", "name": "Perez, Carlos D."}]	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2
e6fea688-2654-4e39-af1e-58d6ab20d0e5	product_type	["derived_dataset"]	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2
de934f72-f061-4e6c-8ebe-88e1a4682021	publication_date	2019-11-05	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2
bd89168e-46c3-49fa-abf1-8bdc7f1a704e	update_frequency	never	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2
aac5d5fb-9324-44c3-97a8-f0bd29a00743	doi	10.5281/zenodo.207908	active	ad269608-4984-404e-8263-d093d89d404c
c481ea91-3025-41e7-a230-8458587a4c83	source	zenodo	active	ad269608-4984-404e-8263-d093d89d404c
9cd58143-c944-4a32-8e87-2d4a651de2b8	zenodo_record_id	207908	active	ad269608-4984-404e-8263-d093d89d404c
22cad422-a2e3-4b5c-89ad-8f0f2a063928	contributing_organizations	[]	active	ad269608-4984-404e-8263-d093d89d404c
ea5f2d19-eea1-4680-bc03-0d26d4c62370	authors	[{"affiliation": "", "email": "", "name": "Greaves, Elizabeth"}, {"affiliation": "", "email": "", "name": "Wilson, Robin"}]	active	ad269608-4984-404e-8263-d093d89d404c
94d0a515-f01a-48fd-8c9c-ec22c445fba6	product_type	["derived_dataset"]	active	ad269608-4984-404e-8263-d093d89d404c
9c9e0c10-fc4d-41a4-9c42-34580032ad9e	publication_date	2011-12-31	active	ad269608-4984-404e-8263-d093d89d404c
d77fd662-75a1-4acf-ba66-690d780d9bbe	update_frequency	never	active	ad269608-4984-404e-8263-d093d89d404c
85115dbb-9922-45d4-80e8-73b98f0e9a31	doi	10.5281/zenodo.17004178	active	703c1db6-eeb8-40a6-b42b-f784b690c669
d1acb0df-17ef-4a15-b50d-d3ca99924e50	source	zenodo	active	703c1db6-eeb8-40a6-b42b-f784b690c669
842eef4f-3fc9-47c7-8b02-68e060d78abd	zenodo_record_id	17004178	active	703c1db6-eeb8-40a6-b42b-f784b690c669
dbe41130-d9b9-46d3-a229-7b90273ad1e3	contributing_organizations	[]	active	703c1db6-eeb8-40a6-b42b-f784b690c669
df34560a-5178-466c-917e-b552ef5076fa	authors	[{"affiliation": "Grupo de Estudo do Medio Mari\\u00f1o (GEMM), Ribeira, Spain", "email": "", "name": "Ba\\u00f1\\u00f3n, Rafael"}, {"affiliation": "Departamento de Bioqu\\u00edmica, Xen\\u00e9tica e Inmunolox\\u00eda, Facultade de Biolox\\u00eda, Universidade de Vigo, Vigo, Spain & Centro de Investigaci\\u00f3n Mari\\u00f1a, Universidade de Vigo, Vigo, Spain", "email": "", "name": "Carlos, Alejandro de"}, {"affiliation": "Centro de Apoyo Cient\\u00edfico y Tecnol\\u00f3gico a la Investigaci\\u00f3n (CACTI), Universidade de Vigo- Campus Lagoas Marcosende, Vigo, Spain", "email": "", "name": "Comesa\\u00f1a, Sebasti\\u00e1n"}, {"affiliation": "Departamento de Anatom\\u00eda, Produci\\u00f3n Animal e Ciencias Cl\\u00ednicas Veterinarias, Hospital Veterinario Universitario Rof Codina, Facultade de Veterinaria, Universidade de Santiago de Compostela, Lugo, Spain", "email": "", "name": "V\\u00e1zquez, Jos\\u00e9 Daniel Barreiro"}, {"affiliation": "Centro Oceanogr\\u00e1fico de C\\u00e1diz, Instituto Espa\\u00f1ol de Oceanograf\\u00eda, Consejo Superior de Investigaciones Cient\\u00edficas, C\\u00e1diz, Spain", "email": "", "name": "Bald\\u00f3, Francisco"}]	active	703c1db6-eeb8-40a6-b42b-f784b690c669
f5e93e6e-8adb-4cd8-9885-592dc4a1cfb2	product_type	["derived_dataset"]	active	703c1db6-eeb8-40a6-b42b-f784b690c669
58866060-7181-4b32-a386-fec3198d5472	publication_date	2024-07-19	active	703c1db6-eeb8-40a6-b42b-f784b690c669
14df41bf-66a2-4bae-b691-d9c2e427480d	update_frequency	never	active	703c1db6-eeb8-40a6-b42b-f784b690c669
c5c7a4de-1d72-464d-b2f3-09ebff6a8075	doi	10.5281/zenodo.12197246	active	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd
775943a5-628c-4373-9740-3348eee27a74	source	zenodo	active	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd
c368e6dc-1b7d-46b8-9a60-f2059f624c00	zenodo_record_id	12197246	active	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd
91b6408c-624a-48bc-b563-b44a895edeae	contributing_organizations	[]	active	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd
14b25182-ace6-4353-b151-85a5755fb1d2	authors	[{"affiliation": "", "email": "", "name": "Borghi, Enrico"}, {"affiliation": "", "email": "", "name": "Garilli, Vittorio"}]	active	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd
127f7585-8418-45de-9570-2d47b25b9691	product_type	["derived_dataset"]	active	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd
0151f5d3-bf52-4ac5-8ca5-cf55938fac30	publication_date	2022-12-07	active	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd
314ef90f-eda3-4874-89d2-b32e73790a47	update_frequency	never	active	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd
\.


--
-- Data for Name: package_extra_revision; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.package_extra_revision (id, key, value, revision_id, state, package_id, continuity_id, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: package_member; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.package_member (package_id, user_id, capacity, modified) FROM stdin;
\.


--
-- Data for Name: package_relationship; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.package_relationship (id, subject_package_id, object_package_id, type, comment, state) FROM stdin;
\.


--
-- Data for Name: package_relationship_revision; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.package_relationship_revision (id, subject_package_id, object_package_id, type, comment, revision_id, continuity_id, state, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: package_revision; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.package_revision (id, name, title, version, url, notes, author, author_email, maintainer, maintainer_email, revision_id, state, continuity_id, license_id, expired_id, revision_timestamp, expired_timestamp, current, type, owner_org, private, metadata_modified, creator_user_id, metadata_created) FROM stdin;
\.


--
-- Data for Name: package_tag; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.package_tag (id, state, package_id, tag_id) FROM stdin;
05198f3f-00ee-4441-9b1b-efc1bead8577	active	0586194d-3acc-47f5-a9dd-ffd6dad8dc80	a5f96dab-c377-44f9-aba9-b0401f9db977
e357fc44-89e5-4daf-825f-46834a92396f	active	4a1e1de9-4100-4716-903e-21da4bcd4ece	0159f1b2-b713-4ced-9546-9c1c378caf48
c3297981-468d-4061-bc02-a73b41a12352	active	0586194d-3acc-47f5-a9dd-ffd6dad8dc80	3244189d-3bf4-4fd5-930f-97aa0aa42aee
02076947-c616-4f88-8f39-f60f49bde5ce	active	c2cf9f76-94bc-4ac3-a031-3c7d049a8332	30c433b8-26a5-4da6-907c-8f813bda73f2
86880525-5a21-4eaf-8d15-8a49b9015a78	active	c2cf9f76-94bc-4ac3-a031-3c7d049a8332	1d958f3f-f118-4941-85c7-c7fa94b21d3e
6d971f34-7dd1-4323-ac4f-45ce204b6c6b	active	c2cf9f76-94bc-4ac3-a031-3c7d049a8332	27d12f04-538c-4593-a38d-3986a9b81d48
f7611ac1-5915-4f73-9e49-a704c7684268	active	c2cf9f76-94bc-4ac3-a031-3c7d049a8332	ed7563cd-9528-46f9-b5e4-0a934d030194
ac1ca22d-1bff-4b9d-ae0a-8c6b7e7ce7b5	active	c2cf9f76-94bc-4ac3-a031-3c7d049a8332	a5f96dab-c377-44f9-aba9-b0401f9db977
d38f76ce-5525-4849-aa86-e6fe6dc7a7e6	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd	03141d45-aa6f-441a-b371-2e7724eeae99
a9f96ea9-b459-4b68-a222-ad48d62c3d91	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd	32cf4d4b-f0cb-416d-87dd-b13520895872
90d00aff-2d37-48bb-8130-9968abba97be	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd	f365da55-b5bf-4ff2-9d83-b67113fe9304
8842bad9-071d-4fcc-b2c6-8be5b26f7f65	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd	dd5228d2-cf07-4ed6-8079-e29db5a1e33c
29f77af4-3c13-4d7e-addb-6d6df1cf9c4d	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd	669c85f1-cfcb-4069-beb3-edfecc0ec3a7
5783df54-c916-40b3-b56c-216f0aedfb0f	active	6632bcda-d909-4a34-9f2d-9bec1d3198dd	56a06202-2178-43ab-ae1c-86c0607cf37a
b42406f3-6c09-4c7a-b641-5a5fa310a1ba	active	746a8dda-4152-43e5-bd24-9ddba814be52	0ed80532-a11f-4028-9e9f-ef7834ad7b2e
6544933c-3348-4c7e-a44f-29e92990eeda	active	746a8dda-4152-43e5-bd24-9ddba814be52	5a6c671e-7c1d-4936-9c8d-8b4561469744
d3f3de47-6a53-49ec-8680-df750eb42e5f	active	746a8dda-4152-43e5-bd24-9ddba814be52	e4c98b17-c2be-40a4-af36-d5b8fe1f2932
8e455cfd-edc0-47a1-9f14-120c9b6d9c02	active	746a8dda-4152-43e5-bd24-9ddba814be52	8f730b91-cdaa-4f06-b12d-03d2dafa3273
499c1131-bfed-459b-bcc0-1a8809fe250c	active	746a8dda-4152-43e5-bd24-9ddba814be52	1227bd6b-03ce-4e11-bc8a-7bfddcc09062
1cd95acc-516a-4839-bda7-650afe3b0a77	active	746a8dda-4152-43e5-bd24-9ddba814be52	532d49f4-32a4-4c12-8028-b80542ef593f
bf9577a6-860c-4964-a387-98366d004e24	active	746a8dda-4152-43e5-bd24-9ddba814be52	2e90f34a-c2d8-4e40-bc0e-582c59b04587
49e0a0c3-b6ba-4570-a377-5390f165ba34	active	746a8dda-4152-43e5-bd24-9ddba814be52	d5f7fbba-ac1b-4aa2-9f88-66ba9d73ce9b
7a5ae95d-c9a2-4533-951a-876f20a82907	active	746a8dda-4152-43e5-bd24-9ddba814be52	1bed76b7-542b-4a6e-a924-c5ce45a91940
b0738df7-cc29-47d8-80be-94790bcd60ba	active	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497	89197a03-4f44-4db4-8209-18af811685f0
4ac7322f-b059-4495-aadd-50db08ca56e3	active	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497	96b05030-a1ec-4878-9f6c-3d2bce4abb81
d926fef0-9cb1-4e21-aff6-91174181d262	active	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497	27d12f04-538c-4593-a38d-3986a9b81d48
c3aa66e2-ee11-4a92-9fde-5bc2dc2708ae	active	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497	0a023013-d069-44ec-bca9-dab57a74d9a4
6bc4a967-d035-4604-a695-ff5ef1c477bd	active	23709528-2e6b-48f8-a412-3b93612b80c6	b39ee9b4-400d-41d3-afc1-a170cc13e6da
de4061e5-438b-449b-a1ad-e8cbca6ab59d	active	23709528-2e6b-48f8-a412-3b93612b80c6	27d12f04-538c-4593-a38d-3986a9b81d48
efcd9901-cfae-4d09-a7e2-6c4cd2bd14b8	active	23709528-2e6b-48f8-a412-3b93612b80c6	171fbfe6-d8a2-41cc-b6a6-849b6c64fb26
6d67fae6-5962-454f-809d-fc16fbf1a0d0	active	23709528-2e6b-48f8-a412-3b93612b80c6	2c5fe425-45c7-4d12-ac7d-66ac33b7628b
a3b31542-120c-42bc-a235-3565564da500	active	55991d34-aa45-4ea7-a977-c70fbba37890	0d1f7733-cb88-43e4-a022-619a8cbba323
f90595e5-0b03-4710-b66a-b9b9437b31d1	active	55991d34-aa45-4ea7-a977-c70fbba37890	586b72a4-f2de-4c94-ae52-7909fdad09e9
41921fb3-2fc7-467f-a968-7146da6bf75a	active	55991d34-aa45-4ea7-a977-c70fbba37890	5c7136bf-f04f-4016-923f-bd0bc90b02bf
3f2f5649-68b8-4ca9-89a3-207b3bb3b6ee	active	55991d34-aa45-4ea7-a977-c70fbba37890	9c9f582a-3aa2-4f0b-be86-b4d0f5d1260f
5b86e06b-1746-472d-b25c-4826ec00d68c	active	55991d34-aa45-4ea7-a977-c70fbba37890	5d3e605e-3855-42ad-b7cd-0f7e7dcd7d9c
7c06148e-fa69-4caf-90bd-303cc5b34775	active	028ab429-14fe-491a-a255-c2f7e80c7f4c	586b72a4-f2de-4c94-ae52-7909fdad09e9
531324f0-2101-42e3-a094-3856130087da	active	028ab429-14fe-491a-a255-c2f7e80c7f4c	9a008508-1e31-4b33-9b21-b5840632044f
c796687f-f75c-4e53-a72b-927ba67587f8	active	028ab429-14fe-491a-a255-c2f7e80c7f4c	0d1f7733-cb88-43e4-a022-619a8cbba323
56a79830-41dd-44ac-bda6-7eb17aa219c2	active	3b773a9f-1bc6-43de-b357-02adfb275230	d48023f5-4b59-443a-9fa0-0690c3c052b4
3bfb1117-e52f-40b6-aa4e-ecfd715427b2	active	3b773a9f-1bc6-43de-b357-02adfb275230	368c1ea5-da30-42c4-aec6-0d8b2b032470
44ec1ab2-ecbd-4b22-9999-fe5893d450a1	active	3b773a9f-1bc6-43de-b357-02adfb275230	eded63d7-bffb-4f3a-be84-ea603b53e132
4b50baf8-f416-429a-97bd-d5a69782ceda	active	3b773a9f-1bc6-43de-b357-02adfb275230	89197a03-4f44-4db4-8209-18af811685f0
eb6afaf2-4246-470b-b442-384075f9716d	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	3d1c650b-5eba-4f88-9590-5a3b8d9546af
4dbab8f9-0c4e-465b-b3a0-79b5c76099f1	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	a3fe06eb-733b-4a22-a5e0-eabd6b04cfca
6d13206c-5386-4226-a4e5-8f6cc0fe1a72	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	ed7563cd-9528-46f9-b5e4-0a934d030194
8b467157-05b9-4877-bbaf-df6babe97d11	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	8ae65551-8eec-4e5f-9942-77e8a676bc84
d4f9f133-b919-419e-9bc5-0771245e8a9b	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	8fc40057-d6c5-4e71-88a0-2ee659c57d9a
f2a98454-49d1-43a4-99c8-2adb9fdcb537	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	9af375b2-cd33-4d25-936e-e993b57ab8d0
779b882a-1e08-46f8-a042-3c6f40face18	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	93c3af83-06f6-4a93-8f6b-9779c588925d
41fb0d87-3237-420e-b991-ad00823ec117	active	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	0d1f7733-cb88-43e4-a022-619a8cbba323
ff1e5a84-9a07-4e2f-873c-9bd23fbf5d8f	active	02312a9e-957d-4546-b477-34f40c752534	89197a03-4f44-4db4-8209-18af811685f0
91d4ea55-19e0-4cbc-ac9b-560a17078425	active	02312a9e-957d-4546-b477-34f40c752534	43acc468-ecd9-43c5-b37b-d67c9b4d1f6c
b6fa825d-118a-4735-b1d7-c5baeb2cec46	active	7591d5e4-f147-46ac-81d4-458e33ba5ddc	89197a03-4f44-4db4-8209-18af811685f0
34e5f90f-bbdd-43ca-b79f-417ee0ca589c	active	7591d5e4-f147-46ac-81d4-458e33ba5ddc	43acc468-ecd9-43c5-b37b-d67c9b4d1f6c
572ae156-9c1a-4da2-ab01-76bb6d9adbbf	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2	89197a03-4f44-4db4-8209-18af811685f0
e1a5d4a4-f2df-4c60-be40-b37ddd01b5d0	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2	10f2d2e9-74f7-4823-8971-c5ce4d5a197b
49974ac5-2207-4e58-875b-dc7f90a59abf	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2	43acc468-ecd9-43c5-b37b-d67c9b4d1f6c
ab246262-201c-4594-af85-d89087388d65	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2	15241933-fae7-4d64-952f-64098af3f1ac
49470131-f36b-4795-b607-8ed7a487cb91	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2	7163e392-fa74-4992-a1aa-19bec76837be
cdc27df6-6a4a-4605-b95a-be58643b9bd4	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2	8921b5e4-e4e6-4b42-be5f-96fa62d2acb0
ea1a1900-1574-4265-9b13-0f5add6dcbca	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2	cbe01f6f-45f5-4fb8-a559-a4920f474f18
9515decb-a5bb-4aea-9103-edd7a609c5bb	active	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2	7421371d-2a58-4c15-a9b3-7c8b62d273c8
c33740ef-70a2-4710-8a43-dea1a02f346f	active	ad269608-4984-404e-8263-d093d89d404c	89197a03-4f44-4db4-8209-18af811685f0
8be5791b-d60f-4fe9-9f8e-b998a48340e9	active	ad269608-4984-404e-8263-d093d89d404c	1bfe3b61-45e9-43da-a1e7-669c58d712f9
83a40102-4700-46c2-a225-76378670664d	active	ad269608-4984-404e-8263-d093d89d404c	70012db6-884a-4e6f-8f4f-838ea7e8510b
72a82317-e516-4f7c-89d2-aaa88b95e6a8	active	ad269608-4984-404e-8263-d093d89d404c	83203b1d-1472-433a-b66f-975d33a6bbc5
5593ec50-f5cc-4bf5-9135-5c39218e0636	active	ad269608-4984-404e-8263-d093d89d404c	8921b5e4-e4e6-4b42-be5f-96fa62d2acb0
17343ccc-8eed-4fa1-8839-b5abc299687c	active	ad269608-4984-404e-8263-d093d89d404c	43acc468-ecd9-43c5-b37b-d67c9b4d1f6c
8e887f22-478f-4e00-a015-27c08cce603e	active	ad269608-4984-404e-8263-d093d89d404c	a774b60f-3505-4110-9391-4a69ee530af7
24592e5f-0bad-4b8f-8db2-08d6dca687c7	active	ad269608-4984-404e-8263-d093d89d404c	cff3e323-06dc-4834-be60-d710f89be324
78c6d5b3-a037-476b-8531-2b427fd0a969	active	703c1db6-eeb8-40a6-b42b-f784b690c669	89197a03-4f44-4db4-8209-18af811685f0
98ddd7ee-b95c-4e67-a027-bd3fe5794aa3	active	703c1db6-eeb8-40a6-b42b-f784b690c669	43acc468-ecd9-43c5-b37b-d67c9b4d1f6c
332a88dc-aaa4-41a3-849e-1364c07e1ba6	active	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd	89197a03-4f44-4db4-8209-18af811685f0
d0cd198c-088a-4013-8601-e37de63208d0	active	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd	43acc468-ecd9-43c5-b37b-d67c9b4d1f6c
\.


--
-- Data for Name: package_tag_revision; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.package_tag_revision (id, revision_id, state, package_id, tag_id, continuity_id, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.rating (id, user_id, user_ip_address, rating, created, package_id) FROM stdin;
\.


--
-- Data for Name: resource; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.resource (id, url, format, description, "position", hash, state, extras, name, resource_type, mimetype, mimetype_inner, size, last_modified, cache_url, cache_last_updated, webstore_url, webstore_last_updated, created, url_type, package_id, metadata_modified) FROM stdin;
b8b4caee-0105-4186-a844-e6684e22e88c	https://zenodo.org/api/records/11464531/files/eDNA OBIS-USA .pdf/content		File size: 3361060 bytes	0		active	\N	eDNA OBIS-USA .pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-22 18:13:53.315754	\N	de37ad6d-002f-47fc-913e-58ff407296e0	2025-09-22 18:13:53.302586
add70136-83ec-43eb-9c65-2e2374a45d07	https://zenodo.org/record/17177436	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:26.970487	\N	d1af5e43-a9ac-4266-8797-61774039d9ce	2025-09-25 21:56:26.967305
320e40fd-8bf0-4c82-930c-116210d0205f	https://zenodo.org/record/17177436/files/Caretta_caretta.zip	ZIP	Download from Zenodo. File size: 576607876 bytes	1		active	\N	Caretta_caretta.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:26.970491	\N	d1af5e43-a9ac-4266-8797-61774039d9ce	2025-09-25 21:56:26.96745
c1f9c503-bdf8-4419-966a-a1c32ce29407	https://zenodo.org/record/	HTML	View this dataset on Zenodo	0		deleted	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-22 18:33:32.617032	\N	a9a3eae6-cb4a-4b36-8043-79511cb15571	2025-09-22 18:33:32.6087
f048fafa-75f4-4954-97c5-fe733259606e	https://zenodo.org/record//files/eDNA OBIS-USA .pdf	PDF	Download from Zenodo. File size: 3361060 bytes	0		deleted	\N	eDNA OBIS-USA .pdf	\N	application/pdf	\N	\N	\N	\N	\N	\N	\N	2025-09-22 18:33:32.617037	\N	a9a3eae6-cb4a-4b36-8043-79511cb15571	2025-09-22 18:33:32.608868
c830fe30-4dd6-4de5-9fe4-c613c4bc5f63	https://zenodo.org/record/11464531	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-22 18:45:13.935599	\N	a9a3eae6-cb4a-4b36-8043-79511cb15571	2025-09-22 18:45:13.924729
20393fe2-66ed-4972-a36a-67c94c267d6c	https://zenodo.org/record/11464531/files/eDNA OBIS-USA .pdf	PDF	Download from Zenodo. File size: 3361060 bytes	1		active	\N	eDNA OBIS-USA .pdf	\N	application/pdf	\N	\N	\N	\N	\N	\N	\N	2025-09-22 18:45:13.935603	\N	a9a3eae6-cb4a-4b36-8043-79511cb15571	2025-09-22 18:45:13.9249
1e8d3b5b-63f1-4c29-a8c6-199478349fe3	https://zenodo.org/record/11464531	HTML	View this dataset on Zenodo	0		deleted	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-22 21:46:54.042247	\N	f76126e1-3772-4d15-bf64-d48962df77e7	2025-09-22 21:46:54.033427
38e89d87-ac50-4ab4-9738-5248900e134d	https://zenodo.org/record/11464531/files/eDNA OBIS-USA .pdf	PDF	Download from Zenodo	0		deleted	\N	eDNA OBIS-USA .pdf	\N	\N	\N	3361060	\N	\N	\N	\N	\N	2025-09-22 21:46:54.042251	\N	f76126e1-3772-4d15-bf64-d48962df77e7	2025-09-22 21:46:54.033618
72b692cc-ae28-47fa-915a-d7c1538e46b9	https://zenodo.org/record/11464531	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-22 21:58:26.456162	\N	f76126e1-3772-4d15-bf64-d48962df77e7	2025-09-22 21:58:26.444474
726964fe-374b-42f2-8096-a994936fc8fc	https://zenodo.org/record/11464531/files/eDNA OBIS-USA .pdf	PDF	Download from Zenodo\nFile size: 3361060 bytes	1		active	\N	eDNA OBIS-USA .pdf	\N	application/pdf	\N	\N	\N	\N	\N	\N	\N	2025-09-22 21:58:26.456167	\N	f76126e1-3772-4d15-bf64-d48962df77e7	2025-09-22 21:58:26.444656
3a61f015-5de9-4457-8ddd-6bed00aa09b7	https://zenodo.org/record/11464531	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-23 14:05:16.269074	\N	554881bd-aaad-4f06-9fc5-0940b3bc90dd	2025-09-23 14:05:16.261844
add28eba-6d3a-410c-8052-e6ea0a7fe1fb	https://zenodo.org/record/11464531/files/eDNA OBIS-USA .pdf	PDF	Download from Zenodo. File size: 3361060 bytes	1		active	\N	eDNA OBIS-USA .pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-23 14:05:16.269078	\N	554881bd-aaad-4f06-9fc5-0940b3bc90dd	2025-09-23 14:05:16.262019
bee956d0-7bee-4333-b914-e65d8312d9a3	https://zenodo.org/record/11464531/files/eDNA OBIS-USA .pdf	PDF	Download from Zenodo. File size: 3361060 bytes	0		deleted	\N	eDNA OBIS-USA .pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-23 14:23:37.408416	\N	0c5925a7-be8b-48b3-b58d-25bad96b58ba	2025-09-23 14:23:37.402353
c605c1eb-3b06-4ad6-9795-039c369b9b1a	https://zenodo.org/record/11464531	HTML	View this dataset on Zenodo	0		deleted	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-23 14:23:37.408412	\N	0c5925a7-be8b-48b3-b58d-25bad96b58ba	2025-09-23 14:23:37.402137
06f627e8-0284-439e-8aee-447dc012d310	https://zenodo.org/record/11464531	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-23 14:41:35.196339	\N	0c5925a7-be8b-48b3-b58d-25bad96b58ba	2025-09-23 14:41:35.184769
74dd1c4e-3f6d-46d4-acbe-43b51bcef76d	https://zenodo.org/record/11464531/files/eDNA OBIS-USA .pdf	PDF	Download from Zenodo. File size: 3361060 bytes	1		active	\N	eDNA OBIS-USA .pdf	\N	application/pdf	\N	\N	\N	\N	\N	\N	\N	2025-09-23 14:41:35.196343	\N	0c5925a7-be8b-48b3-b58d-25bad96b58ba	2025-09-23 14:41:35.185144
7c8ff3d4-9b4f-4e5f-bec9-8b5e4cbd60f5	https://github.com/iobis/mpaeu_sdm		Some notes about it.	0		active	{"datastore_active": false}	GitHub	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 18:51:41.650323		4a1e1de9-4100-4716-903e-21da4bcd4ece	2025-09-25 18:51:41.8573
f7b4e00b-b52d-4f8b-a4a4-3e26e0a2a4bd	https://zenodo.org/record/1254293	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:07:51.555328	\N	95b1c645-ddc0-4cb7-8198-803bdf78d109	2025-09-25 21:07:51.544003
b1ac7f9f-dbc4-43e1-9938-7ba0d9182497	https://zenodo.org/record/1254293/files/González-Irusta J  et al. Species distribution models under future climate scenarios.pdf	PDF	Download from Zenodo. File size: 3812288 bytes	1		active	\N	González-Irusta J  et al. Species distribution models under future climate scenarios.pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:07:51.555332	\N	95b1c645-ddc0-4cb7-8198-803bdf78d109	2025-09-25 21:07:51.544174
559e4cb6-15b3-49a1-bbc4-32328fc8b8fb	https://zenodo.org/record/11464531/files/eDNA OBIS-USA .pdf	PDF	Download from Zenodo. File size: 3361060 bytes	0		deleted	\N	eDNA OBIS-USA .pdf	\N	application/pdf	\N	\N	\N	\N	\N	\N	\N	2025-09-25 17:52:28.972167	\N	0586194d-3acc-47f5-a9dd-ffd6dad8dc80	2025-09-25 17:52:28.959937
fa7b3257-4ba4-4372-a8f7-e3311c6c3345	https://zenodo.org/record/11464531	HTML	View this dataset on Zenodo	0		deleted	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 17:52:28.972138	\N	0586194d-3acc-47f5-a9dd-ffd6dad8dc80	2025-09-25 17:52:28.959759
422d05ab-ff27-43a2-8a47-4a23cbc59b5c	https://zenodo.org/record/11464531	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 17:56:45.63063	\N	0586194d-3acc-47f5-a9dd-ffd6dad8dc80	2025-09-25 17:56:45.621399
35aa2ac0-60a7-404c-b305-f56c21bc1855	https://zenodo.org/record/11464531/files/eDNA OBIS-USA .pdf	PDF	Download from Zenodo. File size: 3361060 bytes	1		active	\N	eDNA OBIS-USA .pdf	\N	application/pdf	\N	\N	\N	\N	\N	\N	\N	2025-09-25 17:56:45.630634	\N	0586194d-3acc-47f5-a9dd-ffd6dad8dc80	2025-09-25 17:56:45.621564
89fbe0b2-0c74-4e62-924f-4bcb9d0eb618	https://zenodo.org/record/1254293/files/VIDEO José Gonzalez-Irusta Species distribution models under future climate scenarios.mp4	MP4	Download from Zenodo. File size: 1122727773 bytes	2		active	\N	VIDEO José Gonzalez-Irusta Species distribution models under future climate scenarios.mp4	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:07:51.555334	\N	95b1c645-ddc0-4cb7-8198-803bdf78d109	2025-09-25 21:07:51.544307
6f64859c-682a-4e97-b5b5-b889a66afcb4	https://zenodo.org/record/17177436/files/LICENSE.md	text/markdown	Download from Zenodo. File size: 1097 bytes	2		active	\N	LICENSE.md	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:26.970493	\N	d1af5e43-a9ac-4266-8797-61774039d9ce	2025-09-25 21:56:26.967574
652b0d10-8205-4278-aa55-b23f39fe4afe	https://zenodo.org/record/17177436/files/Thunnus_albacares.zip	ZIP	Download from Zenodo. File size: 2706758665 bytes	3		active	\N	Thunnus_albacares.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:26.970494	\N	d1af5e43-a9ac-4266-8797-61774039d9ce	2025-09-25 21:56:26.967711
93aa220e-8f70-4186-9f86-2f0f4665d286	https://zenodo.org/record/17177436/files/README.md	text/markdown	Download from Zenodo. File size: 5726 bytes	4		active	\N	README.md	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:26.970496	\N	d1af5e43-a9ac-4266-8797-61774039d9ce	2025-09-25 21:56:26.967876
32807e67-ef24-4658-a120-e5ca74964078	https://zenodo.org/record/17177436/files/Siganus_luridus.zip	ZIP	Download from Zenodo. File size: 607950154 bytes	5		active	\N	Siganus_luridus.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:26.970498	\N	d1af5e43-a9ac-4266-8797-61774039d9ce	2025-09-25 21:56:26.968001
a1f6991c-ae84-462f-9870-dd4495d92154	https://zenodo.org/record/7825749	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.257991	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.252786
040ead9a-f7f3-4054-9a8e-b7a6e95f0aab	https://zenodo.org/record/7825749/files/enapu_env.csv	CSV	Download from Zenodo. File size: 4018 bytes	1		active	\N	enapu_env.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.257995	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.252937
431dcc70-4407-4347-925c-f20be56c359e	https://zenodo.org/record/7825749/files/enaro_env.csv	CSV	Download from Zenodo. File size: 230914 bytes	2		active	\N	enaro_env.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.257997	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.253063
f48e989c-dd1a-4770-948e-8526bdff0474	https://zenodo.org/record/7825749/files/Figure4.R		Download from Zenodo. File size: 3459 bytes	3		active	\N	Figure4.R	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.257998	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.253182
5b9c74aa-ba4e-4d54-a1c4-c058e2b24c2b	https://zenodo.org/record/7825749/files/enapr_env.csv	CSV	Download from Zenodo. File size: 66387 bytes	4		active	\N	enapr_env.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.258	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.253302
e7a48637-fb66-4ea4-8594-b4dd15fe33c8	https://zenodo.org/record/7825749/files/global_env.csv	CSV	Download from Zenodo. File size: 901519271 bytes	5		active	\N	global_env.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.258002	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.253423
f07f78bf-2c3d-4001-8cbb-0ad94f431c4a	https://zenodo.org/record/7825749/files/gondu_env.csv	CSV	Download from Zenodo. File size: 93469 bytes	6		active	\N	gondu_env.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.258004	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.25354
2dbeb56e-9437-432b-8560-2aee15f9397b	https://zenodo.org/record/7825749/files/madca_env.csv	CSV	Download from Zenodo. File size: 29922 bytes	7		active	\N	madca_env.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.258006	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.253657
a02dde8e-93ad-4e6c-b635-f97e71a3b6b9	https://zenodo.org/record/7825749/files/CWC_Fig3.qgz		Download from Zenodo. File size: 20821 bytes	8		active	\N	CWC_Fig3.qgz	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.258007	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.253825
92072d9b-bda8-4244-bbb3-6c3976647a0a	https://zenodo.org/record/7825749/files/solva_env.csv	CSV	Download from Zenodo. File size: 776600 bytes	9		active	\N	solva_env.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.258009	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.253952
2f1fbba5-800e-42f8-801c-e8718c73204c	https://zenodo.org/record/7825749/files/1_OBIS_download_clean.R		Download from Zenodo. File size: 10242 bytes	10		active	\N	1_OBIS_download_clean.R	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.258011	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.254068
3f353680-291d-467a-86d7-7a22fb43cfb9	https://zenodo.org/record/7825749/files/2_OBIS_CWC_Datasets.xlsx	XLSX	Download from Zenodo. File size: 50535 bytes	11		active	\N	2_OBIS_CWC_Datasets.xlsx	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.258013	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.254185
482d0d42-a43e-4ec0-a680-193d81c13c08	https://zenodo.org/record/7825749/files/Data_Figure4.txt	TXT	Download from Zenodo. File size: 6698 bytes	12		active	\N	Data_Figure4.txt	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.258014	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.254304
e085c825-33ab-4791-a72e-5096dc77ad7a	https://zenodo.org/record/7825749/files/world_map.zip	ZIP	Download from Zenodo. File size: 103445453 bytes	13		active	\N	world_map.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.258016	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.254422
a01c4051-1f33-4791-9bba-991b9bd9598b	https://zenodo.org/record/7825749/files/Figure5.R		Download from Zenodo. File size: 5371 bytes	14		active	\N	Figure5.R	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.258018	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.254538
437175a0-7f0b-49e4-a11d-7faa98085bac	https://zenodo.org/record/7825749/files/despe_env.csv	CSV	Download from Zenodo. File size: 1143252 bytes	15		active	\N	despe_env.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.25802	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.254655
767214ae-b2cc-46f5-b717-fefdd8370152	https://zenodo.org/record/7825749/files/madoc_env.csv	CSV	Download from Zenodo. File size: 194929 bytes	16		active	\N	madoc_env.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:28.258021	\N	a0085fa2-0a82-4b41-bc5c-bfc1377df3e2	2025-09-25 21:56:28.254825
310fa15e-1fac-4e90-8ddb-837c422cb29b	https://zenodo.org/record/3338213	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:29.42412	\N	ff2a7a56-333b-477f-b51d-0cea766e2065	2025-09-25 21:56:29.422077
5b8131c0-5caa-4543-aa42-541e124e72fd	https://zenodo.org/record/3338213/files/iobis/obistools-v0.0.9.zip	ZIP	Download from Zenodo. File size: 2505324 bytes	1		active	\N	iobis/obistools-v0.0.9.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:29.424123	\N	ff2a7a56-333b-477f-b51d-0cea766e2065	2025-09-25 21:56:29.42224
8e57bfda-a697-461f-a119-f3a846ab2875	https://zenodo.org/record/11109585	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:30.465309	\N	9811ed68-164d-413d-bb38-4a43985b7f27	2025-09-25 21:56:30.46279
a44b6be1-6e08-49d2-b7e0-cae5376a135f	https://zenodo.org/record/11109585/files/LUMII-Syslab/OBIS-SchemaExtractor-V2.4.zip	ZIP	Download from Zenodo. File size: 54861315 bytes	1		active	\N	LUMII-Syslab/OBIS-SchemaExtractor-V2.4.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:30.465313	\N	9811ed68-164d-413d-bb38-4a43985b7f27	2025-09-25 21:56:30.462978
326a7a22-89bf-43a1-b287-a54a46b2f5ba	https://zenodo.org/record/3378317	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:31.526121	\N	1d0e3358-195f-49a7-bf1c-8f91634952f0	2025-09-25 21:56:31.523463
128a7f7a-4b35-4b45-8b4c-24ba1ed9e742	https://zenodo.org/record/3378317/files/Ulises-Rosas/OBISdat-v.1.0.zip	ZIP	Download from Zenodo. File size: 9695 bytes	1		active	\N	Ulises-Rosas/OBISdat-v.1.0.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:31.526124	\N	1d0e3358-195f-49a7-bf1c-8f91634952f0	2025-09-25 21:56:31.523618
949aac8c-edea-40fa-8f51-bceb6d898661	https://zenodo.org/record/11069027	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:32.631939	\N	3d6d1f15-9ade-4d65-8e4d-7c47ff3ec391	2025-09-25 21:56:32.628475
494ed26b-4899-4e4a-bbdc-d1dde249dbc7	https://zenodo.org/record/11069027/files/LUMII-Syslab/data-shape-server-v0.2.1.zip	ZIP	Download from Zenodo. File size: 336955 bytes	1		active	\N	LUMII-Syslab/data-shape-server-v0.2.1.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:32.631944	\N	3d6d1f15-9ade-4d65-8e4d-7c47ff3ec391	2025-09-25 21:56:32.628649
0526a4ea-1a7e-4867-b43b-8ff3763050f0	https://zenodo.org/record/6969395	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:33.81141	\N	0f0df252-0d80-42f0-9438-3d7f056c3f62	2025-09-25 21:56:33.809057
97f026f3-791a-4cf7-8c22-280e8ea499e7	https://zenodo.org/record/6969395/files/iobis/robis-v2.11.0.zip	ZIP	Download from Zenodo. File size: 222217 bytes	1		active	\N	iobis/robis-v2.11.0.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:33.811413	\N	0f0df252-0d80-42f0-9438-3d7f056c3f62	2025-09-25 21:56:33.809211
1b1c0488-6360-4619-9be8-818e25f180bb	https://zenodo.org/record/15113967	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:34.920049	\N	c2cf9f76-94bc-4ac3-a031-3c7d049a8332	2025-09-25 21:56:34.906634
5c8b4949-9544-4f05-b8da-07a68b21ff04	https://zenodo.org/record/15113967/files/NOAA-GIS4Ocean/H3_indicators-v0.7.zip	ZIP	Download from Zenodo. File size: 65834795 bytes	1		active	\N	NOAA-GIS4Ocean/H3_indicators-v0.7.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:34.920053	\N	c2cf9f76-94bc-4ac3-a031-3c7d049a8332	2025-09-25 21:56:34.906845
f75bef21-1695-48a7-86fd-5f2c4b429515	https://zenodo.org/record/15924033	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:36.037573	\N	6b81344e-8b2b-43c6-9d3c-7cbc34f9eb33	2025-09-25 21:56:36.035187
05d46ca9-355b-430e-a7c5-469d89187609	https://zenodo.org/record/15924033/files/marinebon/HackingLimno2025-v1.0.zip	ZIP	Download from Zenodo. File size: 920093 bytes	1		active	\N	marinebon/HackingLimno2025-v1.0.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:36.037577	\N	6b81344e-8b2b-43c6-9d3c-7cbc34f9eb33	2025-09-25 21:56:36.035367
1a2110d1-840d-4df1-bc29-db97b5ad0cdf	https://zenodo.org/record/15836332	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:37.204982	\N	83bb0f87-8e4c-4f34-bc3a-83abbc2432d5	2025-09-25 21:56:37.202454
26b625c8-709d-4b4e-a48f-d447470a1721	https://zenodo.org/record/15836332/files/Mangroven/Mangroveobs_GBIFOBIS-Mangroveobs.zip	ZIP	Download from Zenodo. File size: 6246 bytes	1		active	\N	Mangroven/Mangroveobs_GBIFOBIS-Mangroveobs.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:37.204986	\N	83bb0f87-8e4c-4f34-bc3a-83abbc2432d5	2025-09-25 21:56:37.202652
8f6a51c6-4ab9-4cbd-ac84-98811047b9e9	https://zenodo.org/record/5841930	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:38.33829	\N	2d1f79c3-6ad1-424a-a6e2-48cb405e11bf	2025-09-25 21:56:38.33585
43c34de7-5238-4f6d-9d74-8a2dfdc6547d	https://zenodo.org/record/5841930/files/hseebens/DASCOworkflow-v1.0.1.zip	ZIP	Download from Zenodo. File size: 52861008 bytes	1		active	\N	hseebens/DASCOworkflow-v1.0.1.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:38.338294	\N	2d1f79c3-6ad1-424a-a6e2-48cb405e11bf	2025-09-25 21:56:38.336036
de45df26-012a-46ac-8e47-624b76458de2	https://zenodo.org/record/7036564	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:39.79842	\N	6632bcda-d909-4a34-9f2d-9bec1d3198dd	2025-09-25 21:56:39.78835
f5c67bf6-c655-4a58-b901-c7c4f6ad9dce	https://zenodo.org/record/7036564/files/GBIF_data_processing_code_Feb_22.R		Download from Zenodo. File size: 4590 bytes	1		active	\N	GBIF_data_processing_code_Feb_22.R	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:39.798424	\N	6632bcda-d909-4a34-9f2d-9bec1d3198dd	2025-09-25 21:56:39.788524
6aeb5f16-ddec-40e9-a878-ae2324396f14	https://zenodo.org/record/7036564/files/combine_spp_data_Jul_22.R		Download from Zenodo. File size: 10661 bytes	2		active	\N	combine_spp_data_Jul_22.R	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:39.798426	\N	6632bcda-d909-4a34-9f2d-9bec1d3198dd	2025-09-25 21:56:39.788707
a0bcdbfb-e44c-45d3-ba0e-da039fe67901	https://zenodo.org/record/7036564/files/allspecies_regressions_Feb24.R		Download from Zenodo. File size: 41348 bytes	3		active	\N	allspecies_regressions_Feb24.R	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:39.798428	\N	6632bcda-d909-4a34-9f2d-9bec1d3198dd	2025-09-25 21:56:39.788875
257caf00-01ee-4c26-aac2-633ad35ee210	https://zenodo.org/record/7036564/files/per_species_code_Feb_22.R		Download from Zenodo. File size: 8035 bytes	4		active	\N	per_species_code_Feb_22.R	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:39.79843	\N	6632bcda-d909-4a34-9f2d-9bec1d3198dd	2025-09-25 21:56:39.789021
544e45d3-47b5-463f-9f87-74f07f290c5d	https://zenodo.org/record/10054162	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:41.799547	\N	746a8dda-4152-43e5-bd24-9ddba814be52	2025-09-25 21:56:41.785428
c93df234-1e67-43e1-926c-54d52468d9b2	https://zenodo.org/record/10054162/files/DASCO_AlienRegions_SInAS_2.5.csv	CSV	Download from Zenodo. File size: 5465135 bytes	1		active	\N	DASCO_AlienRegions_SInAS_2.5.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:41.799551	\N	746a8dda-4152-43e5-bd24-9ddba814be52	2025-09-25 21:56:41.785611
2e8d65d7-8633-4a12-a65b-b34966e1c41a	https://zenodo.org/record/10054162/files/DASCO_AlienCoordinates_SInAS_2.5.gz	application/x-troff-man	Download from Zenodo. File size: 482595699 bytes	2		active	\N	DASCO_AlienCoordinates_SInAS_2.5.gz	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:41.799553	\N	746a8dda-4152-43e5-bd24-9ddba814be52	2025-09-25 21:56:41.78583
c413f9fc-6a00-4504-841e-6a4de7969830	https://zenodo.org/record/10054162/files/GBIF_SpeciesKeys_SInAS_2.5.csv	CSV	Download from Zenodo. File size: 3632446 bytes	3		active	\N	GBIF_SpeciesKeys_SInAS_2.5.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:41.799555	\N	746a8dda-4152-43e5-bd24-9ddba814be52	2025-09-25 21:56:41.786041
00406e7e-017e-4e2a-9d61-301ab4b753d1	https://zenodo.org/record/10054162/files/DASCO_TaxonHabitats_SInAS_2.5.csv	CSV	Download from Zenodo. File size: 1083956 bytes	4		active	\N	DASCO_TaxonHabitats_SInAS_2.5.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:41.799556	\N	746a8dda-4152-43e5-bd24-9ddba814be52	2025-09-25 21:56:41.786181
c99a3c04-a4d7-4847-b7f9-57c80d69b18d	https://zenodo.org/record/10054162/files/OBIS_SpeciesKeys_SInAS_2.5.csv	CSV	Download from Zenodo. File size: 221097 bytes	5		active	\N	OBIS_SpeciesKeys_SInAS_2.5.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:41.799558	\N	746a8dda-4152-43e5-bd24-9ddba814be52	2025-09-25 21:56:41.78631
49813b11-c239-4515-997f-4f6e62eccb66	https://zenodo.org/record/10054162/files/DASCO_ListOriginalGBIFData_keys_SInAS_2.5.xlsx	XLSX	Download from Zenodo. File size: 11027 bytes	6		active	\N	DASCO_ListOriginalGBIFData_keys_SInAS_2.5.xlsx	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:41.79956	\N	746a8dda-4152-43e5-bd24-9ddba814be52	2025-09-25 21:56:41.786435
acb8f064-9c2d-4916-a0f0-80d13b14fe6a	https://zenodo.org/record/15487410	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:43.115026	\N	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497	2025-09-25 21:56:43.106318
f64937e5-167d-46c3-a172-e5fb278a3994	https://zenodo.org/record/15487410/files/AllPelagicRecords_TaxonID2_Global_FINAL.csv	CSV	Download from Zenodo. File size: 1506839630 bytes	1		active	\N	AllPelagicRecords_TaxonID2_Global_FINAL.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:43.11503	\N	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497	2025-09-25 21:56:43.106494
122916dc-2e9b-434c-95b2-3b9942b00b09	https://zenodo.org/record/15487410/files/AllPelagicRecords_TaxonID2_Global_1deg_FINAL.tif	TIFF	Download from Zenodo. File size: 56239 bytes	2		active	\N	AllPelagicRecords_TaxonID2_Global_1deg_FINAL.tif	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:43.115032	\N	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497	2025-09-25 21:56:43.106644
73a3ec3b-7ed6-4723-be54-66827b67fadb	https://zenodo.org/record/15487410/files/AllBenthicRecords_TaxonID2_Global_1deg_FINAL.tif	TIFF	Download from Zenodo. File size: 41185 bytes	3		active	\N	AllBenthicRecords_TaxonID2_Global_1deg_FINAL.tif	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:43.115034	\N	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497	2025-09-25 21:56:43.106855
3f372d98-40a7-472c-b4b9-71bdffbf7b07	https://zenodo.org/record/15487410/files/AllBenthicRecords_TaxonID2_Global_FINAL.csv	CSV	Download from Zenodo. File size: 3228644328 bytes	4		active	\N	AllBenthicRecords_TaxonID2_Global_FINAL.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:43.115036	\N	edd5f6c1-7bdb-44bf-8e10-9ca5c0d05497	2025-09-25 21:56:43.107015
03cfc4e0-c0ed-4536-b6cc-70a2621c95b9	https://zenodo.org/record/3235548	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:44.206463	\N	23709528-2e6b-48f8-a412-3b93612b80c6	2025-09-25 21:56:44.19909
b002c3e3-6d89-4111-b907-8d5d796c9495	https://zenodo.org/record/3235548/files/BiGe-Onto-dump.trig	application/trig	Download from Zenodo. File size: 647574051 bytes	1		active	\N	BiGe-Onto-dump.trig	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:44.206467	\N	23709528-2e6b-48f8-a412-3b93612b80c6	2025-09-25 21:56:44.199265
2e9f3ece-4ec1-49cf-8654-86682e6f893d	https://zenodo.org/record/15276467	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:45.203729	\N	8cfb4d21-ca59-4e78-a48b-9d0bdadf15c6	2025-09-25 21:56:45.201442
f7c2a9f8-fe5a-48dd-906b-b3f1c0a229fd	https://zenodo.org/record/15276467/files/Height_density data_v2.csv	CSV	Download from Zenodo. File size: 84112 bytes	1		active	\N	Height_density data_v2.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:45.20376	\N	8cfb4d21-ca59-4e78-a48b-9d0bdadf15c6	2025-09-25 21:56:45.201596
54386245-52d0-4c39-86e1-53bb844b53ff	https://zenodo.org/record/13833556	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:46.344696	\N	d9f6dd4f-f254-4e96-a466-1654a4b06449	2025-09-25 21:56:46.341142
23a6eb56-3c1e-4dd2-a196-70c399d94241	https://zenodo.org/record/13833556/files/Thunnus_albacares.zip	ZIP	Download from Zenodo. File size: 2121906249 bytes	1		active	\N	Thunnus_albacares.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:46.344701	\N	d9f6dd4f-f254-4e96-a466-1654a4b06449	2025-09-25 21:56:46.341316
3bf17a86-1f78-4572-ba08-1cc1ca3f448b	https://zenodo.org/record/13833556/files/Siganus_luridus.zip	ZIP	Download from Zenodo. File size: 599134001 bytes	2		active	\N	Siganus_luridus.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:46.344703	\N	d9f6dd4f-f254-4e96-a466-1654a4b06449	2025-09-25 21:56:46.341468
f1f64987-7f3e-4415-8270-aedae3f9e3cb	https://zenodo.org/record/13833556/files/LICENSE.md	text/markdown	Download from Zenodo. File size: 1097 bytes	3		active	\N	LICENSE.md	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:46.344705	\N	d9f6dd4f-f254-4e96-a466-1654a4b06449	2025-09-25 21:56:46.341614
4ef38a1e-be58-4956-844a-4675a055fdb7	https://zenodo.org/record/13833556/files/Caretta_caretta.zip	ZIP	Download from Zenodo. File size: 574176243 bytes	4		active	\N	Caretta_caretta.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:46.344707	\N	d9f6dd4f-f254-4e96-a466-1654a4b06449	2025-09-25 21:56:46.341818
0c39a5c0-b102-426c-ac39-8e37dc18f930	https://zenodo.org/record/13833556/files/README.md	text/markdown	Download from Zenodo. File size: 5025 bytes	5		active	\N	README.md	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:46.344709	\N	d9f6dd4f-f254-4e96-a466-1654a4b06449	2025-09-25 21:56:46.342
90783f11-90fe-484f-b000-b1d20db0c2c7	https://zenodo.org/record/5494452	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:47.460569	\N	55991d34-aa45-4ea7-a977-c70fbba37890	2025-09-25 21:56:47.452002
8d593e9a-4141-4730-a894-1a1dc7258fb7	https://zenodo.org/record/5494452/files/code.7z		Download from Zenodo. File size: 18950 bytes	1		active	\N	code.7z	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:47.460572	\N	55991d34-aa45-4ea7-a977-c70fbba37890	2025-09-25 21:56:47.452218
bbeb1b2e-46e2-4836-a389-501a3ca1ab8d	https://zenodo.org/record/5494452/files/data.7z		Download from Zenodo. File size: 350351018 bytes	2		active	\N	data.7z	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:47.460575	\N	55991d34-aa45-4ea7-a977-c70fbba37890	2025-09-25 21:56:47.452358
1ba452c7-452e-480b-843e-dc76a6f77e22	https://zenodo.org/record/16739002	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:48.58934	\N	028ab429-14fe-491a-a255-c2f7e80c7f4c	2025-09-25 21:56:48.580499
dbfed4c7-727c-4f2b-adf8-8768d893f05c	https://zenodo.org/record/16739002/files/FinalOccurrenceDataset.zip	ZIP	Download from Zenodo. File size: 29456072 bytes	1		active	\N	FinalOccurrenceDataset.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:48.589345	\N	028ab429-14fe-491a-a255-c2f7e80c7f4c	2025-09-25 21:56:48.580708
2b47150e-016a-4043-a569-8dd6f13a4ab4	https://zenodo.org/record/5101349	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:49.697116	\N	3b773a9f-1bc6-43de-b357-02adfb275230	2025-09-25 21:56:49.68959
0caad89d-2900-4dbb-b42d-56d9cfd6ee14	https://zenodo.org/record/5101349/files/ZooBase_Benedetti_et_al._Nat.Comms.2021_final_Zenodo_columns_descriptors.docx	DOCX	Download from Zenodo. File size: 2964292 bytes	1		active	\N	ZooBase_Benedetti_et_al._Nat.Comms.2021_final_Zenodo_columns_descriptors.docx	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:49.69712	\N	3b773a9f-1bc6-43de-b357-02adfb275230	2025-09-25 21:56:49.689786
59213db2-7d5e-43fe-806a-2b619cae65b9	https://zenodo.org/record/5101349/files/ZooBase_Benedetti_et_al._Nat.Comms.2021_final_Zenodo.txt	TXT	Download from Zenodo. File size: 622713907 bytes	2		active	\N	ZooBase_Benedetti_et_al._Nat.Comms.2021_final_Zenodo.txt	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:49.697122	\N	3b773a9f-1bc6-43de-b357-02adfb275230	2025-09-25 21:56:49.68993
2f1f8f76-263a-4ba2-8fe5-94e0fad4be83	https://zenodo.org/record/15610736	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:50.745854	\N	e7fd1d07-886e-4140-b09c-168d019d22c0	2025-09-25 21:56:50.741478
521dcab6-5d5c-4931-9f48-62d1cf162673	https://zenodo.org/record/15610736/files/BIOORACLE_Present day_2010_2020_depthmean.zip	ZIP	Download from Zenodo. File size: 5702919690 bytes	1		active	\N	BIOORACLE_Present day_2010_2020_depthmean.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:50.745858	\N	e7fd1d07-886e-4140-b09c-168d019d22c0	2025-09-25 21:56:50.741658
a2ce376e-a19d-470d-af20-8472d6a2afb4	https://zenodo.org/record/15610736/files/BIOORACLE_Present day_2000-2010_meandepth.zip	ZIP	Download from Zenodo. File size: 2520050767 bytes	2		active	\N	BIOORACLE_Present day_2000-2010_meandepth.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:50.74586	\N	e7fd1d07-886e-4140-b09c-168d019d22c0	2025-09-25 21:56:50.741861
22d53eb9-a459-4e77-8463-79541ce85f26	https://zenodo.org/record/15610736/files/citations.html	HTML	Download from Zenodo. File size: 216000 bytes	3		active	\N	citations.html	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:50.745862	\N	e7fd1d07-886e-4140-b09c-168d019d22c0	2025-09-25 21:56:50.742011
700c26cc-a278-4aae-be86-74ba924a5313	https://zenodo.org/record/15610736/files/GEBCO_Grid_terms_of_use.pdf	PDF	Download from Zenodo. File size: 145503 bytes	4		active	\N	GEBCO_Grid_terms_of_use.pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:50.745864	\N	e7fd1d07-886e-4140-b09c-168d019d22c0	2025-09-25 21:56:50.742158
770f85b0-814a-45c0-8079-1704b54e9be9	https://zenodo.org/record/15610736/files/gebco_2024_n80.0_s56.0_w-45.0_e45.0.tif	TIFF	Download from Zenodo. File size: 249118356 bytes	5		active	\N	gebco_2024_n80.0_s56.0_w-45.0_e45.0.tif	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:50.745866	\N	e7fd1d07-886e-4140-b09c-168d019d22c0	2025-09-25 21:56:50.742302
f4027a6d-f6cd-4fec-8011-8424e187bc29	https://zenodo.org/record/15610736/files/Occurrence.csv	CSV	Download from Zenodo. File size: 846147171 bytes	6		active	\N	Occurrence.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:50.745868	\N	e7fd1d07-886e-4140-b09c-168d019d22c0	2025-09-25 21:56:50.742445
34b61aa1-1f71-4406-8ac8-645fa063cb7b	https://zenodo.org/record/15610736/files/BIOORACLE_2050-2060_meandepth .zip	ZIP	Download from Zenodo. File size: 8991774880 bytes	7		active	\N	BIOORACLE_2050-2060_meandepth .zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:50.74587	\N	e7fd1d07-886e-4140-b09c-168d019d22c0	2025-09-25 21:56:50.742587
07cb10e1-6016-4a0b-adff-df4afdfdd8de	https://zenodo.org/record/15610736/files/BIOORACLE_2090-2100_meandepth .zip	ZIP	Download from Zenodo. File size: 8954593112 bytes	8		active	\N	BIOORACLE_2090-2100_meandepth .zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:50.745872	\N	e7fd1d07-886e-4140-b09c-168d019d22c0	2025-09-25 21:56:50.742788
a056350f-53b7-4b20-b39d-147f9dceefbc	https://zenodo.org/record/15610736/files/Cleaned_PA_Amphi_Dataset.csv	CSV	Download from Zenodo. File size: 13111076 bytes	9		active	\N	Cleaned_PA_Amphi_Dataset.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:50.745874	\N	e7fd1d07-886e-4140-b09c-168d019d22c0	2025-09-25 21:56:50.742946
6a78fcd8-ec8a-4d67-8c9b-7a17d01d21a7	https://zenodo.org/record/10951348	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:51.865904	\N	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	2025-09-25 21:56:51.86088
0b96b395-4b27-464a-89de-a8f1cdc2ac1f	https://zenodo.org/record/10951348/files/baseline_laea.grd		Download from Zenodo. File size: 2739 bytes	1		active	\N	baseline_laea.grd	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:51.865907	\N	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	2025-09-25 21:56:51.861043
4db7633e-7365-4769-87c6-4776991a58a4	https://zenodo.org/record/10951348/files/Projection_ssp245_2090_laea.grd		Download from Zenodo. File size: 2708 bytes	2		active	\N	Projection_ssp245_2090_laea.grd	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:51.865909	\N	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	2025-09-25 21:56:51.861177
dbeece54-b507-4f57-841a-dc1847cd7cfb	https://zenodo.org/record/10951348/files/occurrences_Acartia.Acanthacartia.bifilosa_laea		Download from Zenodo. File size: 1155 bytes	3		active	\N	occurrences_Acartia.Acanthacartia.bifilosa_laea	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:51.865911	\N	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	2025-09-25 21:56:51.861303
ee027c2f-d8b7-4451-9c0b-153584ffda5d	https://zenodo.org/record/10951348/files/occurrences_Temora.longicornis_laea		Download from Zenodo. File size: 20342 bytes	4		active	\N	occurrences_Temora.longicornis_laea	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:51.865913	\N	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	2025-09-25 21:56:51.861428
2af3052f-680e-4e44-8065-43444ec155f0	https://zenodo.org/record/10951348/files/occurrences_Acartia.Acartiura.longiremis_laea		Download from Zenodo. File size: 2116 bytes	5		active	\N	occurrences_Acartia.Acartiura.longiremis_laea	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:51.865915	\N	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	2025-09-25 21:56:51.861553
5e362358-c4e5-4369-a040-d3231e95ac23	https://zenodo.org/record/10951348/files/Projection_ssp585_2050_laea.grd		Download from Zenodo. File size: 2686 bytes	6		active	\N	Projection_ssp585_2050_laea.grd	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:51.865916	\N	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	2025-09-25 21:56:51.861687
1b5e76a8-15af-4c17-9b3d-04ae57c7c292	https://zenodo.org/record/10951348/files/Projection_ssp585_2090_laea.grd		Download from Zenodo. File size: 2668 bytes	7		active	\N	Projection_ssp585_2090_laea.grd	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:51.865918	\N	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	2025-09-25 21:56:51.861858
e6563362-db68-42b7-b08a-e4f61304fe6e	https://zenodo.org/record/10951348/files/occurrences_Limnocalanus.macrurus.macrurus_laea		Download from Zenodo. File size: 1030 bytes	8		active	\N	occurrences_Limnocalanus.macrurus.macrurus_laea	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:51.86592	\N	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	2025-09-25 21:56:51.861988
59d137a2-6170-4358-ad94-174f41322537	https://zenodo.org/record/10951348/files/occurrences_Centropages.hamatus_laea		Download from Zenodo. File size: 10304 bytes	9		active	\N	occurrences_Centropages.hamatus_laea	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:51.865922	\N	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	2025-09-25 21:56:51.862112
2e5145c4-cfaa-46e9-9e59-e82531b7b90c	https://zenodo.org/record/10951348/files/Projection_ssp245_2050_laea.grd		Download from Zenodo. File size: 2706 bytes	10		active	\N	Projection_ssp245_2050_laea.grd	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:51.865923	\N	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	2025-09-25 21:56:51.862235
c2a719ca-16c4-4149-8d8c-aa6c271481ee	https://zenodo.org/record/10951348/files/occurrences_Acartia.Acanthacartia.tonsa_laea		Download from Zenodo. File size: 1025 bytes	11		active	\N	occurrences_Acartia.Acanthacartia.tonsa_laea	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:51.865925	\N	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	2025-09-25 21:56:51.862359
0ec13191-0e06-4bb0-b7eb-ca28d1c1a932	https://zenodo.org/record/10951348/files/occurrences_Evadne.nordmanni_laea		Download from Zenodo. File size: 2696 bytes	12		active	\N	occurrences_Evadne.nordmanni_laea	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:51.865927	\N	3a22025a-fa37-4d87-bf9b-ebf9622c6e60	2025-09-25 21:56:51.862481
813f5227-d668-4a27-8f5b-99e3ba6c93b5	https://zenodo.org/record/15396200	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:53.029161	\N	fbf63ee1-5ffe-41ee-9732-a47889ed8e69	2025-09-25 21:56:53.024644
7065afe8-7e0f-4d82-820c-2fc23ba349ef	https://zenodo.org/record/15396200/files/citations.html	HTML	Download from Zenodo. File size: 216000 bytes	1		active	\N	citations.html	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:53.029164	\N	fbf63ee1-5ffe-41ee-9732-a47889ed8e69	2025-09-25 21:56:53.024867
c1f58484-a67f-4acc-9583-f4a579a49d18	https://zenodo.org/record/15396200/files/Cleaned_PA_Amphi_Dataset_forzenodo.csv	CSV	Download from Zenodo. File size: 57184247 bytes	2		active	\N	Cleaned_PA_Amphi_Dataset_forzenodo.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:53.029166	\N	fbf63ee1-5ffe-41ee-9732-a47889ed8e69	2025-09-25 21:56:53.025021
e6af6e1c-42d6-4190-ad1c-f6700bdbeaa6	https://zenodo.org/record/15396200/files/Occurrence.csv	CSV	Download from Zenodo. File size: 846147171 bytes	3		active	\N	Occurrence.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:53.029168	\N	fbf63ee1-5ffe-41ee-9732-a47889ed8e69	2025-09-25 21:56:53.025168
bdabaf63-44d3-4c5f-bffa-021be447dc3c	https://zenodo.org/record/15396200/files/gebco_2024_n80.0_s56.0_w-45.0_e45.0.tif	TIFF	Download from Zenodo. File size: 249691068 bytes	4		active	\N	gebco_2024_n80.0_s56.0_w-45.0_e45.0.tif	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:53.02917	\N	fbf63ee1-5ffe-41ee-9732-a47889ed8e69	2025-09-25 21:56:53.025312
16c1ece1-a416-45bd-a2dc-6b8885f2df55	https://zenodo.org/record/15396200/files/2050-2060_meandepth.zip	ZIP	Download from Zenodo. File size: 9014591392 bytes	5		active	\N	2050-2060_meandepth.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:53.029172	\N	fbf63ee1-5ffe-41ee-9732-a47889ed8e69	2025-09-25 21:56:53.025456
b75d0124-4302-42ae-92f2-267b62756965	https://zenodo.org/record/15396200/files/2090-2100_meandepth.zip	ZIP	Download from Zenodo. File size: 8967362088 bytes	6		active	\N	2090-2100_meandepth.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:53.029174	\N	fbf63ee1-5ffe-41ee-9732-a47889ed8e69	2025-09-25 21:56:53.025599
31417946-7828-4252-82fb-c6d2ffe65d67	https://zenodo.org/record/15396200/files/present day_2010-2020_meandepth.zip	ZIP	Download from Zenodo. File size: 5711143266 bytes	7		active	\N	present day_2010-2020_meandepth.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:53.029176	\N	fbf63ee1-5ffe-41ee-9732-a47889ed8e69	2025-09-25 21:56:53.025805
7508dd76-72ed-4671-8bdd-2a4792541185	https://zenodo.org/record/15396200/files/Present day_2000-2010_meandepth.zip	ZIP	Download from Zenodo. File size: 2522935100 bytes	8		active	\N	Present day_2000-2010_meandepth.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:53.029178	\N	fbf63ee1-5ffe-41ee-9732-a47889ed8e69	2025-09-25 21:56:53.025993
65af5aa6-40da-48a5-bb20-c468fbb10b19	https://zenodo.org/record/15396200/files/GEBCO_Grid_terms_of_use.pdf	PDF	Download from Zenodo. File size: 145503 bytes	9		active	\N	GEBCO_Grid_terms_of_use.pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:53.02918	\N	fbf63ee1-5ffe-41ee-9732-a47889ed8e69	2025-09-25 21:56:53.026123
4f2e9205-0f4e-4c20-9c04-375df52b7be2	https://zenodo.org/record/16791361	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:55.046189	\N	31dc8a44-e9b7-44e8-821a-5c602b7c1d00	2025-09-25 21:56:55.043098
fc67052d-239f-487b-afc4-41ccf4de1675	https://zenodo.org/record/16791361/files/marine_fish_allometry_with_latitude.csv	CSV	Download from Zenodo. File size: 30628 bytes	1		active	\N	marine_fish_allometry_with_latitude.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:55.046193	\N	31dc8a44-e9b7-44e8-821a-5c602b7c1d00	2025-09-25 21:56:55.043272
0005956f-c99a-4c80-ba3e-ca5b8feabc60	https://zenodo.org/record/16791361/files/marine_fish_allometry_with_latitude_and_weight.csv	CSV	Download from Zenodo. File size: 37392 bytes	2		active	\N	marine_fish_allometry_with_latitude_and_weight.csv	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:55.046195	\N	31dc8a44-e9b7-44e8-821a-5c602b7c1d00	2025-09-25 21:56:55.043424
fd8e5fa1-4b0f-4c51-835f-c0776391f047	https://zenodo.org/record/16791361/files/异速生长.Rmd		Download from Zenodo. File size: 49634 bytes	3		active	\N	异速生长.Rmd	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:55.046197	\N	31dc8a44-e9b7-44e8-821a-5c602b7c1d00	2025-09-25 21:56:55.043566
1f77f438-5542-4592-9863-f2e8ae5bc974	https://zenodo.org/record/6770200	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:56.921047	\N	4571b411-cc4e-408a-8fc0-4454f5694fd0	2025-09-25 21:56:56.917861
0fd9577a-fe0d-4d33-a1b7-c6c88dce7886	https://zenodo.org/record/6770200/files/locations_supplement_28jun2022.zip	ZIP	Download from Zenodo. File size: 2481339919 bytes	1		active	\N	locations_supplement_28jun2022.zip	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:56.921051	\N	4571b411-cc4e-408a-8fc0-4454f5694fd0	2025-09-25 21:56:56.918037
7535c160-6200-498d-a25a-86d07c6caa0c	https://zenodo.org/record/6770200/files/locations_supplement.tar.lz4		Download from Zenodo. File size: 4135017130 bytes	2		active	\N	locations_supplement.tar.lz4	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:56.921054	\N	4571b411-cc4e-408a-8fc0-4454f5694fd0	2025-09-25 21:56:56.918187
ce40f00e-6dca-4c7e-9152-0bcea73ffe03	https://zenodo.org/record/3606645	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:58.135027	\N	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	2025-09-25 21:56:58.120934
c02dc525-637c-4b35-95c1-46d6f83ee4f1	https://zenodo.org/record/3606645/files/GBIF.txt	TXT	Download from Zenodo. File size: 27529411 bytes	1		active	\N	GBIF.txt	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:58.135031	\N	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	2025-09-25 21:56:58.121115
5df92438-71d4-48c6-92f9-ee596d15ac82	https://zenodo.org/record/3606645/files/STRI.txt	TXT	Download from Zenodo. File size: 10789696 bytes	2		active	\N	STRI.txt	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:58.135034	\N	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	2025-09-25 21:56:58.121268
7408bcf9-57e5-46aa-af91-c06eb83408df	https://zenodo.org/record/3606645/files/iDigBio.txt	TXT	Download from Zenodo. File size: 3760230 bytes	3		active	\N	iDigBio.txt	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:58.135036	\N	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	2025-09-25 21:56:58.121415
c1c7bbaa-46a4-4491-ae11-d18411be6846	https://zenodo.org/record/3606645/files/FNet.txt	TXT	Download from Zenodo. File size: 2941252 bytes	4		active	\N	FNet.txt	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:58.135037	\N	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	2025-09-25 21:56:58.12156
60e96882-eb30-4ef7-b636-421debaebdc5	https://zenodo.org/record/3606645/files/FBase.txt	TXT	Download from Zenodo. File size: 159804 bytes	5		active	\N	FBase.txt	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:58.135039	\N	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	2025-09-25 21:56:58.121744
2e12c3f9-06a2-40cf-b15c-be7c138c756b	https://zenodo.org/record/3606645/files/OBIS.txt	TXT	Download from Zenodo. File size: 8722611 bytes	6		active	\N	OBIS.txt	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:56:58.135041	\N	4f871f0d-6c3f-42e4-8bf0-7659a82f40c8	2025-09-25 21:56:58.121915
f640ebc9-ca5e-48f0-8f47-216d8c687d54	https://zenodo.org/record/12713667	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:57:01.808413	\N	02312a9e-957d-4546-b477-34f40c752534	2025-09-25 21:57:01.802367
89dfd8de-2b9e-4ceb-95d7-03870a752939	https://zenodo.org/record/12713667/files/figure.png	PNG	Download from Zenodo. File size: 2353755 bytes	1		active	\N	figure.png	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:57:01.808417	\N	02312a9e-957d-4546-b477-34f40c752534	2025-09-25 21:57:01.802581
268be7ab-c4e8-401e-8713-e4b7dfb94447	https://zenodo.org/record/15219322	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:57:02.851072	\N	7591d5e4-f147-46ac-81d4-458e33ba5ddc	2025-09-25 21:57:02.845881
17702058-6b64-4909-8f02-03c39742a233	https://zenodo.org/record/15219322/files/figure.png	PNG	Download from Zenodo. File size: 7753090 bytes	1		active	\N	figure.png	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:57:02.851075	\N	7591d5e4-f147-46ac-81d4-458e33ba5ddc	2025-09-25 21:57:02.846077
08e7bc66-7515-4164-8eb4-3fd25803114e	https://zenodo.org/record/3529008	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:57:04.066186	\N	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2	2025-09-25 21:57:04.05325
7b7b5dc3-f8b1-443a-ab0a-962f1c200508	https://zenodo.org/record/3529008/files/figure.png	PNG	Download from Zenodo. File size: 3720576 bytes	1		active	\N	figure.png	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:57:04.066191	\N	dca67f24-1c5d-45ea-b5ab-82afb1f0f6c2	2025-09-25 21:57:04.053447
9ed61a53-ae10-42ad-983d-6c19ae8396bd	https://zenodo.org/record/207908	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:57:05.170636	\N	ad269608-4984-404e-8263-d093d89d404c	2025-09-25 21:57:05.159802
dc68ead8-e5d2-49a1-a15f-0cfda40c77e0	https://zenodo.org/record/207908/files/figure.png	PNG	Download from Zenodo. File size: 152848 bytes	1		active	\N	figure.png	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:57:05.170639	\N	ad269608-4984-404e-8263-d093d89d404c	2025-09-25 21:57:05.159998
bc588c77-9ba6-4f64-8d3e-6fee2cd9541c	https://zenodo.org/record/17004178	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:57:06.250833	\N	703c1db6-eeb8-40a6-b42b-f784b690c669	2025-09-25 21:57:06.245706
0162764f-c4c6-47c9-b857-4c69cc577ff3	https://zenodo.org/record/17004178/files/figure.png	PNG	Download from Zenodo. File size: 1470954 bytes	1		active	\N	figure.png	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:57:06.250837	\N	703c1db6-eeb8-40a6-b42b-f784b690c669	2025-09-25 21:57:06.245973
83fe90bc-737d-4917-ab44-f0914dca7e4e	https://zenodo.org/record/12197246	HTML	View this dataset on Zenodo	0		active	\N	Zenodo Record	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:57:07.331662	\N	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd	2025-09-25 21:57:07.325948
02cd4603-5330-449d-a6df-e44dcd35a4b8	https://zenodo.org/record/12197246/files/figure.png	PNG	Download from Zenodo. File size: 130881 bytes	1		active	\N	figure.png	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:57:07.331666	\N	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd	2025-09-25 21:57:07.326202
f9256f12-bfc0-41e6-8500-b3be47cdff37	https://zenodo.org/record/12197246/files/figure.svg	SVG	Download from Zenodo. File size: 535334 bytes	2		active	\N	figure.svg	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 21:57:07.331668	\N	d5b7d01d-8d8f-45e3-b05a-1e97d3f774bd	2025-09-25 21:57:07.326418
\.


--
-- Data for Name: resource_revision; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.resource_revision (id, url, format, description, "position", revision_id, hash, state, continuity_id, extras, expired_id, revision_timestamp, expired_timestamp, current, name, resource_type, mimetype, mimetype_inner, size, last_modified, cache_url, cache_last_updated, webstore_url, webstore_last_updated, created, url_type, package_id) FROM stdin;
\.


--
-- Data for Name: resource_view; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.resource_view (id, resource_id, title, description, view_type, "order", config) FROM stdin;
49c8d2b2-dff5-4d70-a7fe-12752b8c0269	89dfd8de-2b9e-4ceb-95d7-03870a752939	Image		image_view	0	\N
425aa442-ce82-42e3-a282-c20426d73d4e	17702058-6b64-4909-8f02-03c39742a233	Image		image_view	0	\N
cb245b67-3b3c-40da-a1e1-54bece4d9496	7b7b5dc3-f8b1-443a-ab0a-962f1c200508	Image		image_view	0	\N
afde93b7-cc5e-4d6e-90a4-aded9e45d5a7	dc68ead8-e5d2-49a1-a15f-0cfda40c77e0	Image		image_view	0	\N
d4a6cf53-4806-4b89-b076-dc6182705409	0162764f-c4c6-47c9-b857-4c69cc577ff3	Image		image_view	0	\N
66603748-c987-4b3b-a68a-7c418410c392	02cd4603-5330-449d-a6df-e44dcd35a4b8	Image		image_view	0	\N
\.


--
-- Data for Name: revision; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.revision (id, "timestamp", author, message, state, approved_timestamp) FROM stdin;
\.


--
-- Data for Name: system_info; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.system_info (id, key, value, state) FROM stdin;
1	ckan.homepage_style	1	active
2	ckan.site_about	# About the OBIS Data Products Catalog\r\n\r\n## Discover OBIS-mediated Information Products\r\n\r\nThe OBIS Data Products Catalog helps you find and access information products built from OBIS-mediated marine biodiversity data. As our network has grown, we've found that it was challenging to keep track of all the amazing products that have been created from OBIS-mediated data.  This metadata catalog helps users find and access those products.\r\n\r\n## What's in the Catalog\r\n\r\nOur catalog includes diverse products created from OBIS-mediated data:\r\n\r\n- Maps\r\n- Models\r\n- Dashboards\r\n- Data visualizations  \r\n- Inforgraphics\r\n- Derived datasets (e.g. improved for a specific purpose)\r\n- Reports\r\n- Training Materials\r\n\r\nEach product includes detailed metadata about data sources, methods, authors, and how to access or cite the work.\r\n\r\n## Easy Import and Discovery\r\n\r\nThe catalog streamlines adding new products through automated import from research repositories like Zenodo and DataCite. Simply provide a DOI and the system extracts relevant metadata, making it easy for researchers to share their work and for others to discover it.\r\n\r\nProducts are connected to the broader ocean data ecosystem, enabling discovery across multiple platforms and supporting integration with assessment and reporting workflows.\r\n\r\n## Community Effort\r\n\r\nThis catalog emerged from collaboration between marine biodiversity researchers worldwide as part of the OBIS2030 initiative. OBIS nodes and partner organizations contribute products and help ensure the catalog serves both global and regional needs.\r\n\r\n## Get Started\r\n\r\nBrowse existing products, contribute your own work, or contact us to learn more about using the catalog for your research or decision-making needs.	active
3	ckan.site_custom_css		active
4	ckan.site_description		active
5	ckan.site_intro_text		active
6	ckan.site_logo	/base/images/ckan-logo.png	active
7	ckan.site_title	CKAN	active
8	ckan.theme	css/main	active
9	ckan.config_update	1758633200.1988552	active
\.


--
-- Data for Name: system_info_revision; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.system_info_revision (id, key, value, revision_id, continuity_id, state, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.tag (id, name, vocabulary_id) FROM stdin;
a5f96dab-c377-44f9-aba9-b0401f9db977	IOOS	\N
0159f1b2-b713-4ced-9546-9c1c378caf48	Other Tag	\N
3244189d-3bf4-4fd5-930f-97aa0aa42aee	eDNA	\N
1d958f3f-f118-4941-85c7-c7fa94b21d3e	H3	\N
ed7563cd-9528-46f9-b5e4-0a934d030194	biodiversity	\N
27d12f04-538c-4593-a38d-3986a9b81d48	OBIS	\N
30c433b8-26a5-4da6-907c-8f813bda73f2	NMS	\N
f365da55-b5bf-4ff2-9d83-b67113fe9304	species richness	\N
32cf4d4b-f0cb-416d-87dd-b13520895872	occurrences	\N
dd5228d2-cf07-4ed6-8079-e29db5a1e33c	Geography	\N
56a06202-2178-43ab-ae1c-86c0607cf37a	Climate	\N
03141d45-aa6f-441a-b371-2e7724eeae99	Human population	\N
669c85f1-cfcb-4069-beb3-edfecc0ec3a7	Government Effectiveness	\N
e4c98b17-c2be-40a4-af36-d5b8fe1f2932	alien	\N
2e90f34a-c2d8-4e40-bc0e-582c59b04587	invasive	\N
1227bd6b-03ce-4e11-bc8a-7bfddcc09062	non-native	\N
d5f7fbba-ac1b-4aa2-9f88-66ba9d73ce9b	species	\N
532d49f4-32a4-4c12-8028-b80542ef593f	taxa	\N
1bed76b7-542b-4a6e-a924-c5ce45a91940	global	\N
0ed80532-a11f-4028-9e9f-ef7834ad7b2e	down-scaling	\N
8f730b91-cdaa-4f06-b12d-03d2dafa3273	checklists	\N
5a6c671e-7c1d-4936-9c8d-8b4561469744	workflow	\N
89197a03-4f44-4db4-8209-18af811685f0	Biodiversity	\N
96b05030-a1ec-4878-9f6c-3d2bce4abb81	Open-access	\N
0a023013-d069-44ec-bca9-dab57a74d9a4	Big data	\N
171fbfe6-d8a2-41cc-b6a6-849b6c64fb26	GBIF	\N
2c5fe425-45c7-4d12-ac7d-66ac33b7628b	PAMPA AZUL	\N
b39ee9b4-400d-41d3-afc1-a170cc13e6da	BIGEONTO	\N
5d3e605e-3855-42ad-b7cd-0f7e7dcd7d9c	skeletal mineralogy	\N
5c7136bf-f04f-4016-923f-bd0bc90b02bf	bivalves	\N
586b72a4-f2de-4c94-ae52-7909fdad09e9	macroecology	\N
9c9f582a-3aa2-4f0b-be86-b4d0f5d1260f	Bayesian hierarchical regression	\N
0d1f7733-cb88-43e4-a022-619a8cbba323	biogeography	\N
9a008508-1e31-4b33-9b21-b5840632044f	ichthyology	\N
d48023f5-4b59-443a-9fa0-0690c3c052b4	Zooplankton	\N
368c1ea5-da30-42c4-aec6-0d8b2b032470	Global Ocean	\N
eded63d7-bffb-4f3a-be84-ea603b53e132	Niche Modelling	\N
8ae65551-8eec-4e5f-9942-77e8a676bc84	Beta diversity	\N
8fc40057-d6c5-4e71-88a0-2ee659c57d9a	bioregion	\N
9af375b2-cd33-4d25-936e-e993b57ab8d0	completeness	\N
3d1c650b-5eba-4f88-9590-5a3b8d9546af	data quality	\N
93c3af83-06f6-4a93-8f6b-9779c588925d	global aggregators	\N
a3fe06eb-733b-4a22-a5e0-eabd6b04cfca	spatial biases	\N
43acc468-ecd9-43c5-b37b-d67c9b4d1f6c	Taxonomy	\N
8921b5e4-e4e6-4b42-be5f-96fa62d2acb0	Animalia	\N
15241933-fae7-4d64-952f-64098af3f1ac	Cnidaria	\N
cbe01f6f-45f5-4fb8-a559-a4920f474f18	Anthozoa	\N
7163e392-fa74-4992-a1aa-19bec76837be	Antipatharia	\N
10f2d2e9-74f7-4823-8971-c5ce4d5a197b	Stylopathidae	\N
7421371d-2a58-4c15-a9b3-7c8b62d273c8	Stylopathes	\N
1bfe3b61-45e9-43da-a1e7-669c58d712f9	Annelida	\N
cff3e323-06dc-4834-be60-d710f89be324	Polychaeta	\N
a774b60f-3505-4110-9391-4a69ee530af7	Spionida	\N
83203b1d-1472-433a-b66f-975d33a6bbc5	Spionidae	\N
70012db6-884a-4e6f-8f4f-838ea7e8510b	Laonice	\N
\.


--
-- Data for Name: task_status; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.task_status (id, entity_id, entity_type, task_type, key, value, state, error, last_updated) FROM stdin;
\.


--
-- Data for Name: term_translation; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.term_translation (term, term_translation, lang_code) FROM stdin;
\.


--
-- Data for Name: tracking_raw; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.tracking_raw (user_key, url, tracking_type, access_timestamp) FROM stdin;
\.


--
-- Data for Name: tracking_summary; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.tracking_summary (url, package_id, tracking_type, count, running_total, recent_views, tracking_date) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public."user" (id, name, apikey, created, about, password, fullname, email, reset_key, sysadmin, activity_streams_email_notifications, state, plugin_extras, image_url, last_active) FROM stdin;
70b75831-ff72-4599-aa51-9617f9251ce8	default	f7b4bd82-0112-45f4-86e5-87cdfa563cc1	2025-09-22 05:57:22.451884	\N	$pbkdf2-sha512$25000$pFTqPQeglNIa4zxHiHHu3Q$dn1v28Nqb9NWx.4c.R5N8drpYdv3GiaGFbYHySCw2GLqeKjTtQD5OQRr2kas6VpBOkX2v1MIkNAu2vQHTXtrAQ	\N	\N	\N	t	f	active	\N	\N	\N
7bb4a315-c5c4-4b53-8bc1-8cb9180a278e	ckan_admin	\N	2025-09-22 13:41:13.172152	\N	$pbkdf2-sha512$25000$dU5pLcUYY0xpbc15D4Hw/g$0SJd4xmljRKy9jkXp0xhmAzgisXJzdrfB92yDokeSxli5Rtlu7bnlxN1nvlhGS/GGWWx/iwrP6TkbjWVv4jgRg	\N	your_email@example.com	\N	t	f	active	\N	\N	2025-09-25 21:04:48.141981
\.


--
-- Data for Name: user_following_dataset; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.user_following_dataset (follower_id, object_id, datetime) FROM stdin;
\.


--
-- Data for Name: user_following_group; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.user_following_group (follower_id, object_id, datetime) FROM stdin;
\.


--
-- Data for Name: user_following_user; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.user_following_user (follower_id, object_id, datetime) FROM stdin;
\.


--
-- Data for Name: vocabulary; Type: TABLE DATA; Schema: public; Owner: ckan
--

COPY public.vocabulary (id, name) FROM stdin;
\.


--
-- Name: system_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ckan
--

SELECT pg_catalog.setval('public.system_info_id_seq', 9, true);


--
-- Name: activity_detail activity_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.activity_detail
    ADD CONSTRAINT activity_detail_pkey PRIMARY KEY (id);


--
-- Name: activity activity_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT activity_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: api_token api_token_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.api_token
    ADD CONSTRAINT api_token_pkey PRIMARY KEY (id);


--
-- Name: dashboard dashboard_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT dashboard_pkey PRIMARY KEY (user_id);


--
-- Name: group_extra group_extra_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.group_extra
    ADD CONSTRAINT group_extra_pkey PRIMARY KEY (id);


--
-- Name: group_extra_revision group_extra_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.group_extra_revision
    ADD CONSTRAINT group_extra_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: group group_name_key; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_name_key UNIQUE (name);


--
-- Name: group group_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);


--
-- Name: group_revision group_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.group_revision
    ADD CONSTRAINT group_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: member member_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- Name: member_revision member_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.member_revision
    ADD CONSTRAINT member_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: package_extra package_extra_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_extra
    ADD CONSTRAINT package_extra_pkey PRIMARY KEY (id);


--
-- Name: package_extra_revision package_extra_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_extra_revision
    ADD CONSTRAINT package_extra_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: package_member package_member_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_member
    ADD CONSTRAINT package_member_pkey PRIMARY KEY (package_id, user_id);


--
-- Name: package package_name_key; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package
    ADD CONSTRAINT package_name_key UNIQUE (name);


--
-- Name: package package_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package
    ADD CONSTRAINT package_pkey PRIMARY KEY (id);


--
-- Name: package_relationship package_relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_relationship
    ADD CONSTRAINT package_relationship_pkey PRIMARY KEY (id);


--
-- Name: package_relationship_revision package_relationship_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: package_revision package_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_revision
    ADD CONSTRAINT package_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: package_tag package_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_tag
    ADD CONSTRAINT package_tag_pkey PRIMARY KEY (id);


--
-- Name: package_tag_revision package_tag_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_tag_revision
    ADD CONSTRAINT package_tag_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: rating rating_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_pkey PRIMARY KEY (id);


--
-- Name: resource resource_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (id);


--
-- Name: resource_revision resource_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.resource_revision
    ADD CONSTRAINT resource_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: resource_view resource_view_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.resource_view
    ADD CONSTRAINT resource_view_pkey PRIMARY KEY (id);


--
-- Name: revision revision_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.revision
    ADD CONSTRAINT revision_pkey PRIMARY KEY (id);


--
-- Name: system_info system_info_key_key; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.system_info
    ADD CONSTRAINT system_info_key_key UNIQUE (key);


--
-- Name: system_info system_info_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.system_info
    ADD CONSTRAINT system_info_pkey PRIMARY KEY (id);


--
-- Name: system_info_revision system_info_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.system_info_revision
    ADD CONSTRAINT system_info_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: tag tag_name_vocabulary_id_key; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_name_vocabulary_id_key UNIQUE (name, vocabulary_id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: task_status task_status_entity_id_task_type_key_key; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.task_status
    ADD CONSTRAINT task_status_entity_id_task_type_key_key UNIQUE (entity_id, task_type, key);


--
-- Name: task_status task_status_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.task_status
    ADD CONSTRAINT task_status_pkey PRIMARY KEY (id);


--
-- Name: user_following_dataset user_following_dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.user_following_dataset
    ADD CONSTRAINT user_following_dataset_pkey PRIMARY KEY (follower_id, object_id);


--
-- Name: user_following_group user_following_group_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.user_following_group
    ADD CONSTRAINT user_following_group_pkey PRIMARY KEY (follower_id, object_id);


--
-- Name: user_following_user user_following_user_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.user_following_user
    ADD CONSTRAINT user_following_user_pkey PRIMARY KEY (follower_id, object_id);


--
-- Name: user user_name_key; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_name_key UNIQUE (name);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: vocabulary vocabulary_name_key; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.vocabulary
    ADD CONSTRAINT vocabulary_name_key UNIQUE (name);


--
-- Name: vocabulary vocabulary_pkey; Type: CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.vocabulary
    ADD CONSTRAINT vocabulary_pkey PRIMARY KEY (id);


--
-- Name: idx_activity_detail_activity_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_activity_detail_activity_id ON public.activity_detail USING btree (activity_id);


--
-- Name: idx_activity_object_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_activity_object_id ON public.activity USING btree (object_id, "timestamp");


--
-- Name: idx_activity_user_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_activity_user_id ON public.activity USING btree (user_id, "timestamp");


--
-- Name: idx_extra_grp_id_pkg_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_extra_grp_id_pkg_id ON public.member USING btree (group_id, table_id);


--
-- Name: idx_extra_id_pkg_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_extra_id_pkg_id ON public.package_extra USING btree (id, package_id);


--
-- Name: idx_extra_pkg_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_extra_pkg_id ON public.package_extra USING btree (package_id);


--
-- Name: idx_group_current; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_group_current ON public.group_revision USING btree (current);


--
-- Name: idx_group_extra_current; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_group_extra_current ON public.group_extra_revision USING btree (current);


--
-- Name: idx_group_extra_group_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_group_extra_group_id ON public.group_extra USING btree (group_id);


--
-- Name: idx_group_extra_period; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_group_extra_period ON public.group_extra_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_group_extra_period_group; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_group_extra_period_group ON public.group_extra_revision USING btree (revision_timestamp, expired_timestamp, group_id);


--
-- Name: idx_group_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_group_id ON public."group" USING btree (id);


--
-- Name: idx_group_name; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_group_name ON public."group" USING btree (name);


--
-- Name: idx_group_period; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_group_period ON public.group_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_group_pkg_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_group_pkg_id ON public.member USING btree (table_id);


--
-- Name: idx_member_continuity_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_member_continuity_id ON public.member_revision USING btree (continuity_id);


--
-- Name: idx_only_one_active_email; Type: INDEX; Schema: public; Owner: ckan
--

CREATE UNIQUE INDEX idx_only_one_active_email ON public."user" USING btree (email, state) WHERE (state = 'active'::text);


--
-- Name: idx_package_continuity_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_continuity_id ON public.package_revision USING btree (continuity_id);


--
-- Name: idx_package_creator_user_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_creator_user_id ON public.package USING btree (creator_user_id);


--
-- Name: idx_package_current; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_current ON public.package_revision USING btree (current);


--
-- Name: idx_package_extra_continuity_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_extra_continuity_id ON public.package_extra_revision USING btree (continuity_id);


--
-- Name: idx_package_extra_current; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_extra_current ON public.package_extra_revision USING btree (current);


--
-- Name: idx_package_extra_package_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_extra_package_id ON public.package_extra_revision USING btree (package_id, current);


--
-- Name: idx_package_extra_period; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_extra_period ON public.package_extra_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_package_extra_period_package; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_extra_period_package ON public.package_extra_revision USING btree (revision_timestamp, expired_timestamp, package_id);


--
-- Name: idx_package_extra_rev_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_extra_rev_id ON public.package_extra_revision USING btree (revision_id);


--
-- Name: idx_package_group_current; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_group_current ON public.member_revision USING btree (current);


--
-- Name: idx_package_group_group_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_group_group_id ON public.member USING btree (group_id);


--
-- Name: idx_package_group_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_group_id ON public.member USING btree (id);


--
-- Name: idx_package_group_period_package_group; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_group_period_package_group ON public.member_revision USING btree (revision_timestamp, expired_timestamp, table_id, group_id);


--
-- Name: idx_package_group_pkg_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_group_pkg_id ON public.member USING btree (table_id);


--
-- Name: idx_package_group_pkg_id_group_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_group_pkg_id_group_id ON public.member USING btree (group_id, table_id);


--
-- Name: idx_package_period; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_period ON public.package_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_package_relationship_current; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_relationship_current ON public.package_relationship_revision USING btree (current);


--
-- Name: idx_package_resource_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_resource_id ON public.resource USING btree (id);


--
-- Name: idx_package_resource_package_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_resource_package_id ON public.resource USING btree (package_id);


--
-- Name: idx_package_resource_rev_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_resource_rev_id ON public.resource_revision USING btree (revision_id);


--
-- Name: idx_package_resource_url; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_resource_url ON public.resource USING btree (url);


--
-- Name: idx_package_tag_continuity_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_tag_continuity_id ON public.package_tag_revision USING btree (continuity_id);


--
-- Name: idx_package_tag_current; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_tag_current ON public.package_tag_revision USING btree (current);


--
-- Name: idx_package_tag_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_tag_id ON public.package_tag USING btree (id);


--
-- Name: idx_package_tag_pkg_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_tag_pkg_id ON public.package_tag USING btree (package_id);


--
-- Name: idx_package_tag_pkg_id_tag_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_tag_pkg_id_tag_id ON public.package_tag USING btree (tag_id, package_id);


--
-- Name: idx_package_tag_revision_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_tag_revision_id ON public.package_tag_revision USING btree (id);


--
-- Name: idx_package_tag_revision_pkg_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_tag_revision_pkg_id ON public.package_tag_revision USING btree (package_id);


--
-- Name: idx_package_tag_revision_pkg_id_tag_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_tag_revision_pkg_id_tag_id ON public.package_tag_revision USING btree (tag_id, package_id);


--
-- Name: idx_package_tag_revision_rev_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_tag_revision_rev_id ON public.package_tag_revision USING btree (revision_id);


--
-- Name: idx_package_tag_revision_tag_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_tag_revision_tag_id ON public.package_tag_revision USING btree (tag_id);


--
-- Name: idx_package_tag_tag_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_package_tag_tag_id ON public.package_tag USING btree (tag_id);


--
-- Name: idx_period_package_relationship; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_period_package_relationship ON public.package_relationship_revision USING btree (revision_timestamp, expired_timestamp, object_package_id, subject_package_id);


--
-- Name: idx_period_package_tag; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_period_package_tag ON public.package_tag_revision USING btree (revision_timestamp, expired_timestamp, package_id, tag_id);


--
-- Name: idx_pkg_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_pkg_id ON public.package USING btree (id);


--
-- Name: idx_pkg_lname; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_pkg_lname ON public.package USING btree (lower((name)::text));


--
-- Name: idx_pkg_name; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_pkg_name ON public.package USING btree (name);


--
-- Name: idx_pkg_revision_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_pkg_revision_id ON public.package_revision USING btree (id);


--
-- Name: idx_pkg_revision_name; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_pkg_revision_name ON public.package_revision USING btree (name);


--
-- Name: idx_pkg_revision_rev_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_pkg_revision_rev_id ON public.package_revision USING btree (revision_id);


--
-- Name: idx_pkg_sid; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_pkg_sid ON public.package USING btree (id, state);


--
-- Name: idx_pkg_slname; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_pkg_slname ON public.package USING btree (lower((name)::text), state);


--
-- Name: idx_pkg_sname; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_pkg_sname ON public.package USING btree (name, state);


--
-- Name: idx_pkg_stitle; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_pkg_stitle ON public.package USING btree (title, state);


--
-- Name: idx_pkg_suname; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_pkg_suname ON public.package USING btree (upper((name)::text), state);


--
-- Name: idx_pkg_title; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_pkg_title ON public.package USING btree (title);


--
-- Name: idx_pkg_uname; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_pkg_uname ON public.package USING btree (upper((name)::text));


--
-- Name: idx_rating_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_rating_id ON public.rating USING btree (id);


--
-- Name: idx_rating_package_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_rating_package_id ON public.rating USING btree (package_id);


--
-- Name: idx_rating_user_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_rating_user_id ON public.rating USING btree (user_id);


--
-- Name: idx_resource_continuity_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_resource_continuity_id ON public.resource_revision USING btree (continuity_id);


--
-- Name: idx_resource_current; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_resource_current ON public.resource_revision USING btree (current);


--
-- Name: idx_resource_period; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_resource_period ON public.resource_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_rev_state; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_rev_state ON public.revision USING btree (state);


--
-- Name: idx_revision_author; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_revision_author ON public.revision USING btree (author);


--
-- Name: idx_tag_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_tag_id ON public.tag USING btree (id);


--
-- Name: idx_tag_name; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_tag_name ON public.tag USING btree (name);


--
-- Name: idx_user_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_user_id ON public."user" USING btree (id);


--
-- Name: idx_user_name; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_user_name ON public."user" USING btree (name);


--
-- Name: idx_user_name_index; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_user_name_index ON public."user" USING btree ((
CASE
    WHEN ((fullname IS NULL) OR (fullname = ''::text)) THEN name
    ELSE fullname
END));


--
-- Name: idx_view_resource_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX idx_view_resource_id ON public.resource_view USING btree (resource_id);


--
-- Name: term; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX term ON public.term_translation USING btree (term);


--
-- Name: term_lang; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX term_lang ON public.term_translation USING btree (term, lang_code);


--
-- Name: tracking_raw_access_timestamp; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX tracking_raw_access_timestamp ON public.tracking_raw USING btree (access_timestamp);


--
-- Name: tracking_raw_url; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX tracking_raw_url ON public.tracking_raw USING btree (url);


--
-- Name: tracking_raw_user_key; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX tracking_raw_user_key ON public.tracking_raw USING btree (user_key);


--
-- Name: tracking_summary_date; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX tracking_summary_date ON public.tracking_summary USING btree (tracking_date);


--
-- Name: tracking_summary_package_id; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX tracking_summary_package_id ON public.tracking_summary USING btree (package_id);


--
-- Name: tracking_summary_url; Type: INDEX; Schema: public; Owner: ckan
--

CREATE INDEX tracking_summary_url ON public.tracking_summary USING btree (url);


--
-- Name: activity_detail activity_detail_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.activity_detail
    ADD CONSTRAINT activity_detail_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activity(id);


--
-- Name: api_token api_token_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.api_token
    ADD CONSTRAINT api_token_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: dashboard dashboard_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT dashboard_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_extra group_extra_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.group_extra
    ADD CONSTRAINT group_extra_group_id_fkey FOREIGN KEY (group_id) REFERENCES public."group"(id);


--
-- Name: group_extra_revision group_extra_revision_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.group_extra_revision
    ADD CONSTRAINT group_extra_revision_group_id_fkey FOREIGN KEY (group_id) REFERENCES public."group"(id);


--
-- Name: group_extra_revision group_extra_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.group_extra_revision
    ADD CONSTRAINT group_extra_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: group_revision group_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.group_revision
    ADD CONSTRAINT group_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: member member_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_group_id_fkey FOREIGN KEY (group_id) REFERENCES public."group"(id);


--
-- Name: member_revision member_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.member_revision
    ADD CONSTRAINT member_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_extra package_extra_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_extra
    ADD CONSTRAINT package_extra_package_id_fkey FOREIGN KEY (package_id) REFERENCES public.package(id);


--
-- Name: package_extra_revision package_extra_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_extra_revision
    ADD CONSTRAINT package_extra_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_member package_member_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_member
    ADD CONSTRAINT package_member_package_id_fkey FOREIGN KEY (package_id) REFERENCES public.package(id);


--
-- Name: package_member package_member_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_member
    ADD CONSTRAINT package_member_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: package_relationship package_relationship_object_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_relationship
    ADD CONSTRAINT package_relationship_object_package_id_fkey FOREIGN KEY (object_package_id) REFERENCES public.package(id);


--
-- Name: package_relationship_revision package_relationship_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES public.package_relationship(id);


--
-- Name: package_relationship_revision package_relationship_revision_object_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_object_package_id_fkey FOREIGN KEY (object_package_id) REFERENCES public.package(id);


--
-- Name: package_relationship_revision package_relationship_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_relationship_revision package_relationship_revision_subject_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_subject_package_id_fkey FOREIGN KEY (subject_package_id) REFERENCES public.package(id);


--
-- Name: package_relationship package_relationship_subject_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_relationship
    ADD CONSTRAINT package_relationship_subject_package_id_fkey FOREIGN KEY (subject_package_id) REFERENCES public.package(id);


--
-- Name: package_revision package_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_revision
    ADD CONSTRAINT package_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_tag package_tag_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_tag
    ADD CONSTRAINT package_tag_package_id_fkey FOREIGN KEY (package_id) REFERENCES public.package(id);


--
-- Name: package_tag_revision package_tag_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_tag_revision
    ADD CONSTRAINT package_tag_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: package_tag_revision package_tag_revision_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_tag_revision
    ADD CONSTRAINT package_tag_revision_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: package_tag package_tag_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.package_tag
    ADD CONSTRAINT package_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: rating rating_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_package_id_fkey FOREIGN KEY (package_id) REFERENCES public.package(id);


--
-- Name: rating rating_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: resource_revision resource_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.resource_revision
    ADD CONSTRAINT resource_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: resource_view resource_view_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.resource_view
    ADD CONSTRAINT resource_view_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.resource(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: system_info_revision system_info_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.system_info_revision
    ADD CONSTRAINT system_info_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES public.system_info(id);


--
-- Name: system_info_revision system_info_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.system_info_revision
    ADD CONSTRAINT system_info_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revision(id);


--
-- Name: tag tag_vocabulary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_vocabulary_id_fkey FOREIGN KEY (vocabulary_id) REFERENCES public.vocabulary(id);


--
-- Name: user_following_dataset user_following_dataset_follower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.user_following_dataset
    ADD CONSTRAINT user_following_dataset_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_dataset user_following_dataset_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.user_following_dataset
    ADD CONSTRAINT user_following_dataset_object_id_fkey FOREIGN KEY (object_id) REFERENCES public.package(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_group user_following_group_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.user_following_group
    ADD CONSTRAINT user_following_group_group_id_fkey FOREIGN KEY (object_id) REFERENCES public."group"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_group user_following_group_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.user_following_group
    ADD CONSTRAINT user_following_group_user_id_fkey FOREIGN KEY (follower_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_user user_following_user_follower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.user_following_user
    ADD CONSTRAINT user_following_user_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_user user_following_user_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ckan
--

ALTER TABLE ONLY public.user_following_user
    ADD CONSTRAINT user_following_user_object_id_fkey FOREIGN KEY (object_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

