-- Building a trigger for automatically handling logic for inserted tasks
-- (one possibility; we will see other [some would say 'better'] ways later in semester)

-- Step 1: create a trigger function that updates the user table
CREATE FUNCTION update_completed() RETURNS TRIGGER AS $$
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
	$$ LANGUAGE plpgsql;
	-- used $$ as delimiters b/c needed '' inside sequence eval

-- Step 2: call that trigger function whenever a task is updated
CREATE TRIGGER increment_completed_count
AFTER INSERT ON tasks
EXECUTE PROCEDURE update_completed();