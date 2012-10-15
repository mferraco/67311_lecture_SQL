-- Building a trigger for automatically handling logic for inserted tasks
-- (one possibility; we will see other [some would say 'better'] ways later in semester)

-- Step 1: create a trigger function that updates the user table
CREATE FUNCTION update_created() RETURNS TRIGGER AS $$
	DECLARE
		uid INTEGER;
		last_task INTEGER;
	BEGIN
		last_task = (SELECT currval(pg_get_serial_sequence('tasks', 'task_id')));
		uid = (SELECT created_by FROM tasks WHERE task_id = last_task);
		UPDATE users SET tasks_created = (tasks_created + 1) WHERE user_id = uid;
	  RETURN NULL;
	END;
	$$ LANGUAGE plpgsql;
	-- used $$ as delimiters b/c needed '' inside sequence eval

-- Step 2: call that trigger function whenever a new task is inserted
CREATE TRIGGER increment_created_count
AFTER INSERT ON tasks
EXECUTE PROCEDURE update_created();


