-- Demo with names database (dump file in names.sql)
-- Using trigrams to find similar words

-- first install extension 'pg_trgm' to get access to trigrams functionality
CREATE EXTENSION IF NOT EXISTS pg_trgm;


-- what is a trigram?  see it broken down into units
SELECT show_trgm('Anne');
SELECT show_trgm('William');


-- using trigrams to find the degree of similarity
SELECT name, SIMILARITY(name, 'william') AS "Similar" FROM names ORDER BY "Similar" DESC;
SELECT name, SIMILARITY(name, 'william') AS "Similar" FROM names WHERE SIMILARITY(name, 'william') > 0 ORDER BY "Similar" DESC;
SELECT name, ROUND(SIMILARITY(name, 'william')::numeric,3) AS "Similar" FROM names WHERE SIMILARITY(name, 'william') > 0 ORDER BY "Similar" DESC;


-- much more useful to have this in stored procedure to use over and over again...
-- creating a function to display all names similar to a particular name
-- using SQL instead of PL/pgSQL:
CREATE OR REPLACE FUNCTION find_similar_names(param_name varchar(255)) RETURNS SETOF text AS $$
	SELECT CONCAT(names.name, ' => ', ROUND(SIMILARITY(names.name, $1)::numeric,3)) AS "Similar" 
	FROM names 
	WHERE SIMILARITY(names.name, $1) > 0 
	ORDER BY SIMILARITY(names.name, $1) DESC;
	$$ LANGUAGE sql;


-- creating another function to display similarity all names similar to a particular name
-- at a given minimum level desired degree of similarity (using PL/pgSQL):
CREATE OR REPLACE FUNCTION find_similiar_by_degree(param_name varchar(255), desired_degree float) 
	RETURNS TABLE (sim_name varchar(255),sim numeric) AS $$
	DECLARE
		target_name VARCHAR(255);
		degree_of_sim float;
	BEGIN
		target_name = param_name;
		degree_of_sim = desired_degree;
		RETURN QUERY
		SELECT name, ROUND(SIMILARITY(names.name, target_name)::numeric,3) AS "Similar" 
		FROM names 
		WHERE SIMILARITY(names.name, target_name) > degree_of_sim 
		ORDER BY "Similar" DESC;
	END;
	$$ LANGUAGE plpgsql;


