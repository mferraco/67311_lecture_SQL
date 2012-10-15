
CREATE TABLE domains (
    domain_id SERIAL PRIMARY KEY,
    name character varying(255) NOT NULL,
    active boolean DEFAULT true
);


CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	first_name character varying(255) NOT NULL,
	last_name character varying(255) NOT NULL,
	email character varying(255),
	password_digest character varying(255),
	role character varying(255) DEFAULT 'member'::character varying,
	active boolean DEFAULT true,
	tasks_created integer DEFAULT 0,
	tasks_completed integer DEFAULT 0,
	CHECK (tasks_created >= 0),
	CHECK (tasks_completed >= 0),
	CONSTRAINT check_first_name CHECK (first_name ~* '^[a-z]+$'),
	CONSTRAINT check_last_name CHECK (last_name ~* '^([a-z]|\s)+$'),
	CONSTRAINT check_email CHECK (email ~* '^[\w]([^@\s,;]+)@(([a-z0-9.-]+\.)+(com|edu|org|net))$'),
	CONSTRAINT check_role CHECK (role ~* '^(admin|member)$')
);


CREATE TABLE projects (
	project_id SERIAL PRIMARY KEY,
	name character varying(255) NOT NULL,
	description text,
	start_date date DEFAULT current_date,
	end_date date,
	domain_id integer,
	manager_id integer,
	CONSTRAINT projects_domain_id_fk FOREIGN KEY (domain_id)
	REFERENCES domains (domain_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT projects_manager_id_fk FOREIGN KEY (manager_id)
	REFERENCES users (user_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CHECK (end_date > start_date)
);


CREATE TABLE tasks (
	task_id SERIAL PRIMARY KEY,
	name character varying(255),
	due_on date,
	project_id integer NOT NULL,
	created_by integer NOT NULL,
	created_on date DEFAULT current_date, 
	completed boolean DEFAULT false,
	completed_by integer,
	completed_on date,
	priority integer,
	CONSTRAINT tasks_project_id_fk FOREIGN KEY (project_id)
	REFERENCES projects (project_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CHECK (priority BETWEEN 1 AND 4)
);


CREATE TABLE assignments (
	project_id integer NOT NULL,
	user_id integer NOT NULL,
	active boolean DEFAULT true,
	PRIMARY KEY (project_id, user_id),
	CONSTRAINT assignments_project_id_fk FOREIGN KEY (project_id)
	REFERENCES projects (project_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT assignments_user_id_fk FOREIGN KEY (user_id)
	REFERENCES users (user_id) ON DELETE RESTRICT ON UPDATE CASCADE
);




