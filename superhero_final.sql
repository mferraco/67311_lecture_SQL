--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
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
-- Name: dc; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE dc (
    hero_id integer NOT NULL,
    name character varying(50),
    power character varying(255),
    active boolean DEFAULT true
);


ALTER TABLE public.dc OWNER TO profh;

--
-- Name: dc_hero_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE dc_hero_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dc_hero_id_seq OWNER TO profh;

--
-- Name: dc_hero_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE dc_hero_id_seq OWNED BY dc.hero_id;


--
-- Name: dc_hero_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('dc_hero_id_seq', 7, true);


--
-- Name: heroes; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE heroes (
    hero_id integer NOT NULL,
    name character varying(50),
    power character varying(255),
    active boolean DEFAULT true
);


ALTER TABLE public.heroes OWNER TO profh;

--
-- Name: heroes_hero_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE heroes_hero_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.heroes_hero_id_seq OWNER TO profh;

--
-- Name: heroes_hero_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE heroes_hero_id_seq OWNED BY heroes.hero_id;


--
-- Name: heroes_hero_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('heroes_hero_id_seq', 14, true);


--
-- Name: identities; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE identities (
    hero_id integer NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.identities OWNER TO profh;

--
-- Name: junk; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE junk (
    id integer NOT NULL,
    age integer
);


ALTER TABLE public.junk OWNER TO profh;

--
-- Name: junk_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE junk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.junk_id_seq OWNER TO profh;

--
-- Name: junk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE junk_id_seq OWNED BY junk.id;


--
-- Name: junk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('junk_id_seq', 9, true);


--
-- Name: marvel; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE marvel (
    hero_id integer NOT NULL,
    name character varying(50),
    power character varying(255),
    active boolean DEFAULT true
);


ALTER TABLE public.marvel OWNER TO profh;

--
-- Name: marvel_clone; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE marvel_clone (
)
INHERITS (marvel);


ALTER TABLE public.marvel_clone OWNER TO profh;

--
-- Name: marvel_hero_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE marvel_hero_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.marvel_hero_id_seq OWNER TO profh;

--
-- Name: marvel_hero_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE marvel_hero_id_seq OWNED BY marvel.hero_id;


--
-- Name: marvel_hero_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('marvel_hero_id_seq', 10, true);


--
-- Name: people; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE people (
    person_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    height integer,
    weight integer,
    is_male boolean,
    active boolean DEFAULT true,
    email character varying(50)
);


ALTER TABLE public.people OWNER TO profh;

--
-- Name: people_person_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE people_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_person_id_seq OWNER TO profh;

--
-- Name: people_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE people_person_id_seq OWNED BY people.person_id;


--
-- Name: people_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('people_person_id_seq', 15, true);


--
-- Name: victories; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE victories (
    id integer NOT NULL,
    hero_id integer NOT NULL,
    major integer DEFAULT 0,
    minor integer DEFAULT 0,
    for_month date NOT NULL
);


ALTER TABLE public.victories OWNER TO profh;

--
-- Name: victories_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE victories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.victories_id_seq OWNER TO profh;

--
-- Name: victories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE victories_id_seq OWNED BY victories.id;


--
-- Name: victories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('victories_id_seq', 24, true);


--
-- Name: hero_id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY dc ALTER COLUMN hero_id SET DEFAULT nextval('dc_hero_id_seq'::regclass);


--
-- Name: hero_id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY heroes ALTER COLUMN hero_id SET DEFAULT nextval('heroes_hero_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY junk ALTER COLUMN id SET DEFAULT nextval('junk_id_seq'::regclass);


--
-- Name: hero_id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY marvel ALTER COLUMN hero_id SET DEFAULT nextval('marvel_hero_id_seq'::regclass);


--
-- Name: hero_id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY marvel_clone ALTER COLUMN hero_id SET DEFAULT nextval('marvel_hero_id_seq'::regclass);


--
-- Name: active; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY marvel_clone ALTER COLUMN active SET DEFAULT true;


--
-- Name: person_id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY people ALTER COLUMN person_id SET DEFAULT nextval('people_person_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY victories ALTER COLUMN id SET DEFAULT nextval('victories_id_seq'::regclass);


--
-- Data for Name: dc; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY dc (hero_id, name, power, active) FROM stdin;
1	Batman	None - just totally awesome	t
2	Superman	Flies; great strength; xray vision	t
3	Green Lantern	Power ring creates solid constructs based on will; flies	t
4	Hawkeye	None, but exceptional archer; keen eyesight	t
5	Wonder Woman	Enhanced strength; various weapons	t
6	Angel	Teleportation; mind control	t
7	Aquaman	Breathes underwater; communicates with marine life	t
\.


--
-- Data for Name: heroes; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY heroes (hero_id, name, power, active) FROM stdin;
1	Batman	None - just totally awesome	t
2	Superman	flys; great strength; xray vision	t
3	Green Lantern	Power ring creates solid constructs based on will	t
4	Wolverine	Healing factor; adamantium skelton; retractable claws	t
5	Spiderman	Spider senses; web-slinging	t
6	Nightcrawler	Teleportation; superhuman agility	t
7	Wonder Woman	Enhanced strength; various weapons	t
8	Storm	Control of weather; flys	t
9	Shadowcat	Can phase between solid objects	t
10	Angel	Has wings; flys	t
11	Archangel	Has wings; flys; shoots projectiles from wings	t
12	Colossus	Superhuman strength; body can turn into solid metal	t
13	Aquaman	Breathes underwater; communicates with marine life	t
14	The Tick	nigh-invulnerable	t
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY identities (hero_id, person_id) FROM stdin;
2	1
3	2
3	3
3	4
1	6
4	7
6	8
11	15
8	10
9	13
10	15
5	11
14	9
\.


--
-- Data for Name: junk; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY junk (id, age) FROM stdin;
7	13
8	14
9	14
\.


--
-- Data for Name: marvel; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY marvel (hero_id, name, power, active) FROM stdin;
1	Spiderman	Spider senses; web-slinging	t
2	Wolverine	Healing factor; adamantium skelton; retractable claws	t
3	Nightcrawler	Teleportation; superhuman agility	t
4	Storm	Control of weather; flies	t
5	Shadowcat	Can phase through solid objects	t
6	Angel	Has wings; flies	t
7	Archangel	Has wings; flies; shoots projectiles from wings	t
8	Colossus	Superhuman strength; body can turn into solid metal	t
9	Hawkeye	None, but exceptional archer; keen eyesight	t
\.


--
-- Data for Name: marvel_clone; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY marvel_clone (hero_id, name, power, active) FROM stdin;
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY people (person_id, first_name, last_name, height, weight, is_male, active, email) FROM stdin;
3	Guy	Gardner	72	194	t	t	\N
4	Kyle	Rayner	73	209	t	t	\N
7	Logan	\N	68	195	t	t	\N
8	Kurt	Wagner	68	165	t	t	\N
14	Elizabeth	Braddock	68	165	f	t	\N
9	Larry	Heimann	76	230	t	t	profh@cmu.edu
6	Bruce	Wayne	75	230	t	t	bruce@wayne.net
11	Peter	Parker	70	180	t	t	ppaker@gmail.com
1	Clark	Kent	76	225	t	t	clarkk@yahoo.com
15	Warren	Worthington	72	190	t	t	flyboy@gmail.com
12	Anna Marie	\N	67	160	f	t	rogue99@gmail.com
2	Hal	Jordan	71	189	t	t	glearth@yahoo.com
5	Dick	Greyson	69	168	t	t	dick@wayne.net
10	Ororo	Munroe	71	180	f	t	stormy@gmail.com
13	Kitty	Pryde	66	155	f	t	kpryde@yahoo.com
\.


--
-- Data for Name: victories; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY victories (id, hero_id, major, minor, for_month) FROM stdin;
1	1	1	23	2012-01-01
2	1	2	16	2012-02-01
3	1	1	35	2012-03-01
4	1	0	17	2012-04-01
5	1	1	24	2012-05-01
6	1	0	12	2012-06-01
7	1	3	42	2012-07-01
8	1	1	19	2012-08-01
9	2	0	2	2012-01-01
10	2	1	1	2012-02-01
12	2	0	0	2012-04-01
13	2	1	3	2012-05-01
14	2	0	0	2012-06-01
15	2	0	0	2012-07-01
16	2	1	4	2012-08-01
11	2	0	3	2012-03-01
17	5	1	12	2012-01-01
19	5	0	29	2012-03-01
20	5	2	8	2012-04-01
21	5	1	17	2012-05-01
22	5	0	26	2012-06-01
23	5	1	20	2012-07-01
24	5	1	16	2012-08-01
18	5	1	18	2012-02-01
\.


--
-- Name: dc_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY dc
    ADD CONSTRAINT dc_pkey PRIMARY KEY (hero_id);


--
-- Name: heroes_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY heroes
    ADD CONSTRAINT heroes_pkey PRIMARY KEY (hero_id);


--
-- Name: identities_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (hero_id, person_id);


--
-- Name: junk_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY junk
    ADD CONSTRAINT junk_pkey PRIMARY KEY (id);


--
-- Name: marvel_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY marvel
    ADD CONSTRAINT marvel_pkey PRIMARY KEY (hero_id);


--
-- Name: people_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (person_id);


--
-- Name: victories_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY victories
    ADD CONSTRAINT victories_pkey PRIMARY KEY (id);


--
-- Name: hero_fk; Type: FK CONSTRAINT; Schema: public; Owner: profh
--

ALTER TABLE ONLY victories
    ADD CONSTRAINT hero_fk FOREIGN KEY (hero_id) REFERENCES heroes(hero_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: profh
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM profh;
GRANT ALL ON SCHEMA public TO profh;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

