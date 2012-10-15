--
-- Data for Name: domains; Type: TABLE DATA; Schema: public; Owner: arbeit
--

COPY domains (domain_id, name, active) FROM stdin;
1	Academic	t
2	Personal	t
3	Software	t
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
1	Professor	Heimann	profh@cmu.edu	$2a$10$ql2wHuEbPYU.V.lbgZSJuu7M9hoXzRfcqYJ4b2VMsFv8PC9gmQSre	admin	t	2	2
9	Alberto	Gutkowski	alberto.gutkowski@example.com	$2a$10$G8M61EcJ0bCxWdfxY4NBJ.3xKvHKLTIBLtdm7jgXKiCsG0G8ZSUhy	member	t	0	2
13	Mose	Thompson	mose.thompson@example.com	$2a$10$sLIHt1tcXRAjEgw9m1T.s.zrMl8mX88xVcPDKNOkxv51ML8ka4T7i	member	t	1	2
17	Lucie	Welch	lucie.welch@example.com	$2a$10$qRtuRlV1LTkX8nILzKsJKOLzwibcflvP31Wy/LodKCyypDwLZJYzS	member	t	0	1
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

COPY tasks (task_id, name, project_id, created_by, completed, completed_by, priority, created_on, completed_on, due_on) FROM stdin;
1	Security checking	4	7	t	9	3	2012-09-25	2012-10-02	2012-09-30
2	Add authorization	3	6	f	\N	2	2012-09-23	\N	2012-09-29
3	Unit testing	3	14	f	\N	1	2012-10-03	\N	2012-10-15
6	Wireframing	4	7	t	9	2	2012-10-02	2012-10-06	2012-10-05
7	User testing	3	13	t	13	1	2012-09-25	2012-09-28	2012-09-29
8	Modify controllers	1	1	f	\N	3	2012-09-22	\N	2012-09-29
11	Wireframing	4	7	f	\N	1	2012-09-25	\N	2012-09-28
12	Validate models	4	15	f	\N	3	2012-09-28	\N	2012-10-28
13	Unit testing	3	6	f	\N	1	2012-09-27	\N	2012-09-30
14	Add relationships	4	15	f	\N	2	2012-09-30	\N	2012-10-18
16	User testing	3	11	t	13	1	2012-09-24	2012-10-04	2012-10-04
4	Create stylesheets	1	14	t	17	1	2012-09-24	2012-09-25	2012-09-26
9	Add authorization	1	14	f	\N	2	2012-09-30	\N	2012-10-24
15	Data modelling	1	14	f	\N	1	2012-10-03	\N	2012-10-16
10	Add authorization	2	1	t	1	3	2012-10-07	2012-10-08	2012-10-18
5	Requirements analysis	3	14	t	1	2	2012-10-05	2012-10-06	2012-10-06
\.

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
-- Handle sequences
--
SELECT pg_catalog.setval('domains_domain_id_seq', 3, true);
SELECT pg_catalog.setval('projects_project_id_seq', 4, true);
SELECT pg_catalog.setval('tasks_task_id_seq', 16, true);
SELECT pg_catalog.setval('users_user_id_seq', 17, true);

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: arbeit
--

ALTER TABLE ONLY domains ALTER COLUMN domain_id SET DEFAULT nextval('domains_domain_id_seq'::regclass);

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: arbeit
--

ALTER TABLE ONLY projects ALTER COLUMN project_id SET DEFAULT nextval('projects_project_id_seq'::regclass);

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: arbeit
--

ALTER TABLE ONLY tasks ALTER COLUMN task_id SET DEFAULT nextval('tasks_task_id_seq'::regclass);

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: arbeit
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM arbeit;
GRANT ALL ON SCHEMA public TO arbeit;
GRANT ALL ON SCHEMA public TO PUBLIC;

--
-- PostgreSQL database dump complete
--
