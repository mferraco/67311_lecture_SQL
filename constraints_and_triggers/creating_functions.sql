-- finding which procedural languages your version of postgres has available
-- SELECT lanname FROM pg_language;



-- function to increment the tasks_created field in users
CREATE OR REPLACE FUNCTION basic_update_created_count(user_id integer) 
	RETURNS void AS
	'UPDATE users SET tasks_created = (tasks_created + 1) WHERE user_id = $1;' 
	LANGUAGE 'sql';

-- run this function with:
-- SELECT update_created_count(12);




-- function to increment the tasks_completed field in users
CREATE OR REPLACE FUNCTION basic_update_completed_count(user_id integer) 
	RETURNS void AS
	'UPDATE users SET tasks_completed = (tasks_completed + 1) WHERE user_id = $1;'
	LANGUAGE 'sql';

-- run this function with:
-- SELECT update_completed_count(12);
