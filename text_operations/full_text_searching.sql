-- FULL TEXT SEARCHING (with gcpd)

-- looking at tsvector and lexemes it generates:
SELECT case_id, crime_location FROM cases WHERE case_id BETWEEN 1 AND 10;
SELECT to_tsvector('english', crime_location) FROM cases WHERE case_id BETWEEN 1 AND 10;

SELECT 'Batman rocks' @@ 'rock' AS test;
SELECT 'Batman rocks' @@ 'rock' AS test;
SELECT 'Batman rocks' @@ 'batman' AS test;
SELECT 'Batman rocks' @@ 'superman' AS test;

SELECT case_id, crime_location FROM cases WHERE to_tsvector('english',crime_location) @@ to_tsquery('english','harbor');
SELECT case_id, crime_location FROM cases WHERE to_tsvector('english',crime_location) @@ to_tsquery('english','tower');

SELECT case_id, title, crime_location FROM cases WHERE to_tsvector('english',crime_location ||' '||title) @@ to_tsquery('english','murder');

SELECT case_id, title FROM cases WHERE to_tsvector('english',title) @@ to_tsquery('english','murder');
SELECT case_id, title, description FROM cases WHERE to_tsvector('english',title||' '||description) @@ to_tsquery('english','murder');
SELECT case_id, title, description FROM cases WHERE to_tsvector('english',coalesce(title,'')||' '||coalesce(description,'')) @@ to_tsquery('english','murder');

SELECT to_tsquery('english','murder & dock');  -- switch & (and) to |(or)
SELECT case_id, title, crime_location, description FROM cases WHERE to_tsvector('english',coalesce(title,'')||' '||coalesce(crime_location,'') ||' '||coalesce(description,'')) @@ to_tsquery('english','murder & dock');
SELECT case_id, title, crime_location, description FROM cases WHERE to_tsvector('english',coalesce(title,'')||' '||coalesce(crime_location,'') ||' '||coalesce(description,'')) @@ to_tsquery('english','murder | dock');

-- indexing text
	-- can index functions (i.e., lower(field))
	-- CREATE INDEX officers_idx_lowercaserank ON officers USING btree (lower(rank::text) COLLATE pg_catalog."default");
	
-- switch to bugs_311
EXPLAIN ANALYZE SELECT id, summary FROM defects WHERE summary ILIKE '%concept%';

CREATE INDEX defects_fti_summary ON defects USING gin (to_tsvector('english',summary::text));

SELECT id, summary FROM defects WHERE to_tsvector('english',summary) @@ to_tsquery('english','concept');


ALTER TABLE defects ADD COLUMN vector_summary tsvector;

CREATE INDEX defects_fti_vector_summary ON defects USING gin (vector_summary);

CREATE TRIGGER defects_vector_update 
BEFORE INSERT OR UPDATE ON defects
FOR EACH ROW EXECUTE PROCEDURE
tsvector_update_trigger(vector_summary, 'pg_catalog.english', summary);
	
UPDATE defects SET summary = summary;

SELECT id, vector_summary FROM defects WHERE id > 600;

INSERT INTO defects(summary,details,created_at,updated_at) 
	VALUES('Conceptual Example with Postgres','This is just an example of text searching',now(),now());

SELECT id, summary FROM defects WHERE vector_summary @@ to_tsquery('english','concept');
SELECT id, summary FROM defects WHERE vector_summary @@ to_tsquery('english','concept:*');	











