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

--
-- Name: basic_update_completed_count(integer); Type: FUNCTION; Schema: public; Owner: arbeit
--

CREATE FUNCTION basic_update_completed_count(user_id integer) RETURNS void
    LANGUAGE sql
    AS $_$UPDATE users SET tasks_completed = (tasks_completed + 1) WHERE user_id = $1;$_$;


ALTER FUNCTION public.basic_update_completed_count(user_id integer) OWNER TO arbeit;

--
-- Name: basic_update_created_count(integer); Type: FUNCTION; Schema: public; Owner: arbeit
--

CREATE FUNCTION basic_update_created_count(user_id integer) RETURNS void
    LANGUAGE sql
    AS $_$UPDATE users SET tasks_created = (tasks_created + 1) WHERE user_id = $1;$_$;


ALTER FUNCTION public.basic_update_created_count(user_id integer) OWNER TO arbeit;

--
-- Name: update_completed(); Type: FUNCTION; Schema: public; Owner: arbeit
--

CREATE FUNCTION update_completed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		uid INTEGER;
		last_task INTEGER;
	BEGIN
		last_task = (SELECT task_id FROM tasks LIMIT 1 OFFSET(SELECT COUNT(*) FROM tasks) - 1);
		-- not ideal way to do this b/c of concurrency issues, but would work with transaction
		uid = (SELECT completed_by FROM tasks WHERE task_id = last_task);
		UPDATE users SET tasks_completed = (tasks_completed + 1) WHERE user_id = uid;
	  RETURN NULL;
	END;
	$$;


ALTER FUNCTION public.update_completed() OWNER TO arbeit;

--
-- Name: update_created(); Type: FUNCTION; Schema: public; Owner: arbeit
--

CREATE FUNCTION update_created() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		uid INTEGER;
		last_task INTEGER;
	BEGIN
		last_task = (SELECT currval(pg_get_serial_sequence('tasks', 'task_id')));
		uid = (SELECT created_by FROM tasks WHERE task_id = last_task);
		UPDATE users SET tasks_created = (tasks_created + 1) WHERE user_id = uid;
	  RETURN NULL;
	END;
	$$;


ALTER FUNCTION public.update_created() OWNER TO arbeit;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: assignments; Type: TABLE; Schema: public; Owner: arbeit; Tablespace: 
--

CREATE TABLE assignments (
    project_id integer NOT NULL,
    user_id integer NOT NULL,
    active boolean DEFAULT true
);


ALTER TABLE public.assignments OWNER TO arbeit;

--
-- Name: domains; Type: TABLE; Schema: public; Owner: arbeit; Tablespace: 
--

CREATE TABLE domains (
    domain_id integer NOT NULL,
    name character varying(255) NOT NULL,
    active boolean DEFAULT true
);


ALTER TABLE public.domains OWNER TO arbeit;

--
-- Name: domains_domain_id_seq; Type: SEQUENCE; Schema: public; Owner: arbeit
--

CREATE SEQUENCE domains_domain_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.domains_domain_id_seq OWNER TO arbeit;

--
-- Name: domains_domain_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arbeit
--

ALTER SEQUENCE domains_domain_id_seq OWNED BY domains.domain_id;


--
-- Name: domains_domain_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arbeit
--

SELECT pg_catalog.setval('domains_domain_id_seq', 3, true);


--
-- Name: projects; Type: TABLE; Schema: public; Owner: arbeit; Tablespace: 
--

CREATE TABLE projects (
    project_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    start_date date DEFAULT ('now'::text)::date,
    end_date date,
    domain_id integer,
    manager_id integer,
    CONSTRAINT projects_check CHECK ((end_date > start_date))
);


ALTER TABLE public.projects OWNER TO arbeit;

--
-- Name: projects_project_id_seq; Type: SEQUENCE; Schema: public; Owner: arbeit
--

CREATE SEQUENCE projects_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_project_id_seq OWNER TO arbeit;

--
-- Name: projects_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arbeit
--

ALTER SEQUENCE projects_project_id_seq OWNED BY projects.project_id;


--
-- Name: projects_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arbeit
--

SELECT pg_catalog.setval('projects_project_id_seq', 4, true);


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: arbeit; Tablespace: 
--

CREATE TABLE tasks (
    task_id integer NOT NULL,
    name character varying(255),
    due_on date,
    project_id integer NOT NULL,
    created_by integer NOT NULL,
    created_on date DEFAULT ('now'::text)::date,
    completed boolean DEFAULT false,
    completed_by integer,
    completed_on date,
    priority integer,
    CONSTRAINT tasks_priority_check CHECK (((priority >= 1) AND (priority <= 4)))
);


ALTER TABLE public.tasks OWNER TO arbeit;

--
-- Name: tasks_task_id_seq; Type: SEQUENCE; Schema: public; Owner: arbeit
--

CREATE SEQUENCE tasks_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_task_id_seq OWNER TO arbeit;

--
-- Name: tasks_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arbeit
--

ALTER SEQUENCE tasks_task_id_seq OWNED BY tasks.task_id;


--
-- Name: tasks_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arbeit
--

SELECT pg_catalog.setval('tasks_task_id_seq', 17, true);


--
-- Name: users; Type: TABLE; Schema: public; Owner: arbeit; Tablespace: 
--

CREATE TABLE users (
    user_id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255),
    password_digest character varying(255),
    role character varying(255) DEFAULT 'member'::character varying,
    active boolean DEFAULT true,
    tasks_created integer DEFAULT 0,
    tasks_completed integer DEFAULT 0,
    CONSTRAINT check_email CHECK (((email)::text ~* '^[\w]([^@\s,;]+)@(([a-z0-9.-]+\.)+(com|edu|org|net))$'::text)),
    CONSTRAINT check_first_name CHECK (((first_name)::text ~* '^[a-z]+$'::text)),
    CONSTRAINT check_last_name CHECK (((last_name)::text ~* '^([a-z]|\s)+$'::text)),
    CONSTRAINT check_role CHECK (((role)::text ~* '^(admin|member)$'::text)),
    CONSTRAINT users_tasks_completed_check CHECK ((tasks_completed >= 0)),
    CONSTRAINT users_tasks_created_check CHECK ((tasks_created >= 0))
);


ALTER TABLE public.users OWNER TO arbeit;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: arbeit
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO arbeit;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arbeit
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arbeit
--

SELECT pg_catalog.setval('users_user_id_seq', 17, true);


--
-- Name: domain_id; Type: DEFAULT; Schema: public; Owner: arbeit
--

ALTER TABLE ONLY domains ALTER COLUMN domain_id SET DEFAULT nextval('domains_domain_id_seq'::regclass);


--
-- Name: project_id; Type: DEFAULT; Schema: public; Owner: arbeit
--

ALTER TABLE ONLY projects ALTER COLUMN project_id SET DEFAULT nextval('projects_project_id_seq'::regclass);


--
-- Name: task_id; Type: DEFAULT; Schema: public; Owner: arbeit
--

ALTER TABLE ONLY tasks ALTER COLUMN task_id SET DEFAULT nextval('tasks_task_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: arbeit
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Data for Name: assignments; Type: TABLE DATA; Schema: public; Owner: arbeit
--

COPY assignments (project_id, user_id, active) FROM stdin;
1	1	t
2	1	t
3	1	t
4	1	t
3	2	t
3	3	t
4	4	t
3	5	t
4	6	t
2	7	t
3	8	t
2	9	t
3	10	t
3	11	t
4	12	t
1	13	t
1	14	t
3	15	t
2	16	t
2	17	t
\.


--
-- Data for Name: domains; Type: TABLE DATA; Schema: public; Owner: arbeit
--

COPY domains (domain_id, name, active) FROM stdin;
1	Academic	t
2	Personal	t
3	Software	t
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: arbeit
--

COPY projects (project_id, name, description, start_date, end_date, domain_id, manager_id) FROM stdin;
1	Arbeit	A most glorious project that will bring fame and honor to all those who are associated with it.  This project will also be a rich blessing to all who use it properly.	2012-07-09	2013-03-09	3	1
2	BookManager	A most glorious project that will bring fame and honor to all those who are associated with it.  This project will also be a rich blessing to all who use it properly.	2012-05-09	2013-01-09	3	1
3	ChoreTracker	A most glorious project that will bring fame and honor to all those who are associated with it.  This project will also be a rich blessing to all who use it properly.	2012-08-09	2013-01-09	2	1
4	Proverbs	A most glorious project that will bring fame and honor to all those who are associated with it.  This project will also be a rich blessing to all who use it properly.	2012-06-09	2013-02-09	3	1
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: arbeit
--

COPY tasks (task_id, name, due_on, project_id, created_by, created_on, completed, completed_by, completed_on, priority) FROM stdin;
1	Security checking	2012-09-30	4	7	2012-09-25	t	9	2012-10-02	3
2	Add authorization	2012-09-29	3	6	2012-09-23	f	\N	\N	2
3	Unit testing	2012-10-15	3	14	2012-10-03	f	\N	\N	1
6	Wireframing	2012-10-05	4	7	2012-10-02	t	9	2012-10-06	2
7	User testing	2012-09-29	3	13	2012-09-25	t	13	2012-09-28	1
8	Modify controllers	2012-09-29	1	1	2012-09-22	f	\N	\N	3
11	Wireframing	2012-09-28	4	7	2012-09-25	f	\N	\N	1
12	Validate models	2012-10-28	4	15	2012-09-28	f	\N	\N	3
13	Unit testing	2012-09-30	3	6	2012-09-27	f	\N	\N	1
14	Add relationships	2012-10-18	4	15	2012-09-30	f	\N	\N	2
16	User testing	2012-10-04	3	11	2012-09-24	t	13	2012-10-04	1
4	Create stylesheets	2012-09-26	1	14	2012-09-24	t	17	2012-09-25	1
9	Add authorization	2012-10-24	1	14	2012-09-30	f	\N	\N	2
15	Data modelling	2012-10-16	1	14	2012-10-03	f	\N	\N	1
10	Add authorization	2012-10-18	2	1	2012-10-07	t	1	2012-10-08	3
5	Requirements analysis	2012-10-06	3	14	2012-10-05	t	1	2012-10-06	2
17	AB testing	2012-10-28	1	1	2012-10-15	f	\N	\N	2
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: arbeit
--

COPY users (user_id, first_name, last_name, email, password_digest, role, active, tasks_created, tasks_completed) FROM stdin;
2	Kiley	Ritchie	kiley.ritchie@example.com	$2a$10$6uMQT315XcVDm9gwvt0N7ezZpbpmw44FYDnbmP/M4cAlLVwUvE1cS	member	t	0	0
3	Maxine	Batz	maxine.batz@example.com	$2a$10$EdeCeiQTvAvoRDCezyZLt.TzLwoXyRB/aJkVnHoPmJqremSjzpzJ6	member	t	0	0
4	Bernadine	Schumm	bernadine.schumm@example.com	$2a$10$eAx7zmJJf.Es70ce0hw8ru8jyKnKdfGtG2vNikvZDsER6nHVu/m2O	member	t	0	0
5	Janelle	Goodwin	janelle.goodwin@example.com	$2a$10$tCo49hhFCcWU0n24oIaaZeFfHSatqFEMGe5Ict7/v6PtNjo2aCbau	member	t	0	0
8	Tristin	Mann	tristin.mann@example.com	$2a$10$O0.c9DEgp7nFd9sJJn4zve23S7R9zVZa8Dag9E9nxB9/4xr1XOY6q	member	t	0	0
10	Trevion	Hirthe	trevion.hirthe@example.com	$2a$10$h5kRY9D1H4.fCYKSELg5/.I7xwr7pv2ilIqUlFDWrnsiPqZJxOAU.	member	t	0	0
12	Jerrod	VonRueden	jerrod.vonrueden@example.com	$2a$10$b4XKuI08pEO9rs6TNaq15ukHR1CSyxfuPckX8mNTsdICTpF7yDcpu	member	t	0	0
16	Douglas	Bauch	douglas.bauch@example.com	$2a$10$EFJL8vDctmZ6CVfyLFF19u/Y34ozfTxtIE4f1fsMCskULwHTDCH0W	member	t	0	0
6	Jessy	Davis	jessy.davis@example.com	$2a$10$izRmBwu0KbjR7GnrYiYRi.ZD.YBWdvnGIB.l.weM9EdBrzBTOIShC	member	t	2	0
7	Alisha	Brekke	alisha.brekke@example.com	$2a$10$AEIC4GOjH2EfVgjGAdfbe.bVbr4SG5UDhvn5AVmNwiLerxS5CTy3S	member	t	3	0
11	Alejandrin	Heaney	alejandrin.heaney@example.com	$2a$10$HdDiLIA39PdSeVaxXkHIcuezUMjbGdn1VRMmRc/3YAcUBDzUZA1qS	member	t	1	0
14	Audrey	Waelchi	audrey.waelchi@example.com	$2a$10$3M6zScUR4BBVJl51ZluqteYVJTQGlw3xfLekR/zXdoCsItBHwQNRS	member	t	5	0
15	Tod	Hayes	tod.hayes@example.com	$2a$10$OPiUngRL9Tctkaw5WH4Pg.dAAHmndeVraXsh.3sSB/VCyOPlq3kAe	member	t	2	0
9	Alberto	Gutkowski	alberto.gutkowski@example.com	$2a$10$G8M61EcJ0bCxWdfxY4NBJ.3xKvHKLTIBLtdm7jgXKiCsG0G8ZSUhy	member	t	0	2
13	Mose	Thompson	mose.thompson@example.com	$2a$10$sLIHt1tcXRAjEgw9m1T.s.zrMl8mX88xVcPDKNOkxv51ML8ka4T7i	member	t	1	2
17	Lucie	Welch	lucie.welch@example.com	$2a$10$qRtuRlV1LTkX8nILzKsJKOLzwibcflvP31Wy/LodKCyypDwLZJYzS	member	t	0	1
1	Professor	Heimann	profh@cmu.edu	$2a$10$ql2wHuEbPYU.V.lbgZSJuu7M9hoXzRfcqYJ4b2VMsFv8PC9gmQSre	admin	t	3	2
\.


--
-- Name: assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: arbeit; Tablespace: 
--

ALTER TABLE ONLY assignments
    ADD CONSTRAINT assignments_pkey PRIMARY KEY (project_id, user_id);


--
-- Name: domains_pkey; Type: CONSTRAINT; Schema: public; Owner: arbeit; Tablespace: 
--

ALTER TABLE ONLY domains
    ADD CONSTRAINT domains_pkey PRIMARY KEY (domain_id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: arbeit; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project_id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: arbeit; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (task_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: arbeit; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: increment_completed_count; Type: TRIGGER; Schema: public; Owner: arbeit
--

CREATE TRIGGER increment_completed_count AFTER INSERT ON tasks FOR EACH STATEMENT EXECUTE PROCEDURE update_completed();


--
-- Name: increment_created_count; Type: TRIGGER; Schema: public; Owner: arbeit
--

CREATE TRIGGER increment_created_count AFTER INSERT ON tasks FOR EACH STATEMENT EXECUTE PROCEDURE update_created();


--
-- Name: assignments_project_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: arbeit
--

ALTER TABLE ONLY assignments
    ADD CONSTRAINT assignments_project_id_fk FOREIGN KEY (project_id) REFERENCES projects(project_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: assignments_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: arbeit
--

ALTER TABLE ONLY assignments
    ADD CONSTRAINT assignments_user_id_fk FOREIGN KEY (user_id) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: projects_domain_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: arbeit
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_domain_id_fk FOREIGN KEY (domain_id) REFERENCES domains(domain_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: projects_manager_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: arbeit
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_manager_id_fk FOREIGN KEY (manager_id) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tasks_project_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: arbeit
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_project_id_fk FOREIGN KEY (project_id) REFERENCES projects(project_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: public; Type: ACL; Schema: -; Owner: profh
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM profh;
GRANT ALL ON SCHEMA public TO profh;
GRANT ALL ON SCHEMA public TO arbeit;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

