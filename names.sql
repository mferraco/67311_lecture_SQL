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


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;


--
-- Name: names; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE names (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.names OWNER TO profh;

--
-- Name: names_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE names_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.names_id_seq OWNER TO profh;

--
-- Name: names_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE names_id_seq OWNED BY names.id;


--
-- Name: names_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('names_id_seq', 105, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY names ALTER COLUMN id SET DEFAULT nextval('names_id_seq'::regclass);



--
-- Data for Name: names; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY names (id, name) FROM stdin;
1	Ann
2	Anne
3	An
4	Andy
5	Anthony
6	Louis
7	Lewis
8	Gordon
9	Jordan
10	Will
11	Willie
12	Willy
13	Billy
14	William
15	Tom
16	Tommy
17	Fred
18	Thomas
19	Tomas
20	Tomis
21	Lawrence
22	Laurence
23	Laurent
24	Laurenitis
25	Bill
26	Bob
27	Rob
28	Robert
29	Robbie
30	Robby
31	Rocky
32	Randy
33	John
34	Jon
35	Jonathan
36	Jonathon
37	Jonnie
38	Johnny
39	Charles
40	Charlie
41	Chas
42	Willem
43	Willaim
44	Brain
45	Jeff
46	Geoff
47	Wiliam
48	Annie
49	Brian
50	Bobby
51	Bobbie
52	Boobie
53	Larry
54	Harry
55	Barry
56	Terry
57	Terrie
58	Gary
59	Grant
60	Ted
61	Ned
62	Mike
63	Mikey
64	Michael
65	Micheal
66	Michelle
67	Michaela
69	Michele
70	Matt
71	Matthew
72	Garrett
73	Garett
74	Garet
75	Jeria
76	Jerry
77	Jimmy
78	James
79	Janet
80	Marie
81	Maria
82	Megan
83	Meghan
84	Amy
85	Shannon
86	Sharon
87	Shanon
88	Dominic
89	Doug
90	David
91	Dave
92	Davy
93	Dom
94	Don
95	Donald
96	Alex
97	Alexander
98	Alec
99	Alexandera
100	Dylan
101	Dillon
102	Sheila
103	Allan
104	Alan
105	Allen
\.

--
-- Name: names_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY names
    ADD CONSTRAINT names_pkey PRIMARY KEY (id);


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

