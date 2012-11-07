-- Building a trigger for automatically handling logic for inserted tasks
-- (one possibility; we will see other [some would say 'better'] ways later in semester)

CREATE OR REPLACE FUNCTION post_new_project(d_id integer, proj_name varchar(255)) RETURNS void AS $$
	DECLARE
		domain_id INTEGER;
		project_name VARCHAR(255);
	BEGIN
		domain_id = $1;
		project_name = $2;
		IF (SELECT name FROM domains WHERE id = domain_id) IS NULL THEN
			RAISE EXCEPTION 'Domain is not valid';
		END IF;
		INSERT INTO projects(name, created_at, updated_at) VALUES(project_name, current_date, current_date);
	  RETURN NULL;
	END;
	$$ LANGUAGE plpgsql;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
-- Same as above with less whitespace...	
CREATE OR REPLACE FUNCTION post_new_project(d_id integer, proj_name varchar(255)) RETURNS void AS $$
DECLARE
domain_id INTEGER;
project_name VARCHAR(255);
BEGIN
domain_id = $1;
project_name = $2;
IF (SELECT domains.name FROM domains WHERE id = domain_id) IS NULL THEN
RAISE EXCEPTION 'Domain is not valid';
END IF;
INSERT INTO projects(name, created_at, updated_at) VALUES(project_name, current_date, current_date);
END;
$$ LANGUAGE plpgsql;