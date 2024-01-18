--
-- PostgreSQL database dump
--

-- Dumped from database version 10.21 (Debian 10.21-1.pgdg90+1)
-- Dumped by pg_dump version 10.21 (Debian 10.21-1.pgdg90+1)

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: sessions
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO sessions;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: sessions
--

CREATE TABLE public.clients (
    name character varying NOT NULL,
    client_hash_id character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.clients OWNER TO sessions;

--
-- Name: coaches; Type: TABLE; Schema: public; Owner: sessions
--

CREATE TABLE public.coaches (
    name character varying NOT NULL,
    coach_hash_id character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.coaches OWNER TO sessions;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: sessions
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO sessions;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: sessions
--

CREATE TABLE public.sessions (
    id bigint NOT NULL,
    start timestamp without time zone NOT NULL,
    duration integer NOT NULL,
    coach_hash_id character varying NOT NULL,
    client_hash_id character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO sessions;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: sessions
--

CREATE SEQUENCE public.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO sessions;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sessions
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: sessions
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: sessions
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2024-01-11 19:28:38.980098	2024-01-11 19:28:38.980098
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: sessions
--

COPY public.clients (name, client_hash_id, created_at, updated_at) FROM stdin;
mary	b1RTrhfcr43h	2024-01-11 19:28:38.958243	2024-01-11 19:28:38.958243
patricia	agDJbAqa1FZD	2024-01-11 19:28:38.959649	2024-01-11 19:28:38.959649
jennifer	z5k4iLYW6KqX	2024-01-11 19:28:38.960871	2024-01-11 19:28:38.960871
linda	6EdhSZHVkMzB	2024-01-11 19:28:38.962133	2024-01-11 19:28:38.962133
elizabeth	tR9PxWmfWrp2	2024-01-11 19:28:38.963279	2024-01-11 19:28:38.963279
barbara	Zz8vmzdsXj9e	2024-01-11 19:28:38.964439	2024-01-11 19:28:38.964439
susan	9DSkGrV43UhA	2024-01-11 19:28:38.965528	2024-01-11 19:28:38.965528
jessica	13KxaxvAwueA	2024-01-11 19:28:38.966645	2024-01-11 19:28:38.966645
sarah	QvyK3bbhvovt	2024-01-11 19:28:38.967851	2024-01-11 19:28:38.967851
karen	vunGFjWb7VYC	2024-01-11 19:28:38.969099	2024-01-11 19:28:38.969099
\.


--
-- Data for Name: coaches; Type: TABLE DATA; Schema: public; Owner: sessions
--

COPY public.coaches (name, coach_hash_id, created_at, updated_at) FROM stdin;
robert	oToTcMNXomu4	2024-01-11 19:28:38.940697	2024-01-11 19:28:38.940697
james	r2wzkL2kyerf	2024-01-11 19:28:38.942292	2024-01-11 19:28:38.942292
john	Yk2SeVCK6d5A	2024-01-11 19:28:38.943393	2024-01-11 19:28:38.943393
michael	7snoRvFUD4wr	2024-01-11 19:28:38.944594	2024-01-11 19:28:38.944594
william	ETkA4m1P5z6D	2024-01-11 19:28:38.945712	2024-01-11 19:28:38.945712
david	fEVVEcL32MVi	2024-01-11 19:28:38.947004	2024-01-11 19:28:38.947004
richard	KuMV1yvxgqQG	2024-01-11 19:28:38.948263	2024-01-11 19:28:38.948263
charles	KGfP7L5TeW39	2024-01-11 19:28:38.94949	2024-01-11 19:28:38.94949
joseph	j3ZAhvYx8cz5	2024-01-11 19:28:38.95062	2024-01-11 19:28:38.95062
thomas	Jd7dBwikx6gh	2024-01-11 19:28:38.951928	2024-01-11 19:28:38.951928
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: sessions
--

COPY public.schema_migrations (version) FROM stdin;
20240111192038
20240118151558
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: sessions
--

COPY public.sessions (id, start, duration, coach_hash_id, client_hash_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sessions
--

SELECT pg_catalog.setval('public.sessions_id_seq', 3, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: sessions
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: sessions
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (client_hash_id);


--
-- Name: coaches coaches_pkey; Type: CONSTRAINT; Schema: public; Owner: sessions
--

ALTER TABLE ONLY public.coaches
    ADD CONSTRAINT coaches_pkey PRIMARY KEY (coach_hash_id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: sessions
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: sessions
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: index_clients_on_client_hash_id; Type: INDEX; Schema: public; Owner: sessions
--

CREATE UNIQUE INDEX index_clients_on_client_hash_id ON public.clients USING btree (client_hash_id);


--
-- Name: index_coaches_on_coach_hash_id; Type: INDEX; Schema: public; Owner: sessions
--

CREATE UNIQUE INDEX index_coaches_on_coach_hash_id ON public.coaches USING btree (coach_hash_id);


--
-- Name: sessions fk_rails_2306a7245a; Type: FK CONSTRAINT; Schema: public; Owner: sessions
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_rails_2306a7245a FOREIGN KEY (client_hash_id) REFERENCES public.clients(client_hash_id);


--
-- Name: sessions fk_rails_84dfaabdb5; Type: FK CONSTRAINT; Schema: public; Owner: sessions
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_rails_84dfaabdb5 FOREIGN KEY (coach_hash_id) REFERENCES public.coaches(coach_hash_id);


--
-- PostgreSQL database dump complete
--

