-- Demo with names database (dump file in names.sql)
-- Using the names table with variety of names to find close, but not exact, matches

-- Finding variations on William
SELECT name FROM names WHERE name LIKE 'w%';
SELECT name FROM names WHERE name ILIKE 'w%';
SELECT name FROM names WHERE name ~* '^w';

-- EXPLAIN ANALYZE SELECT name FROM names WHERE name LIKE 'W%';
-- EXPLAIN ANALYZE SELECT name FROM names WHERE name ILIKE 'w%';
-- EXPLAIN ANALYZE SELECT name FROM names WHERE name ~* '^w';

SELECT name FROM PEOPLE WHERE name ~* '^a'; 
	-- issue of lots of bogus results if just want 'Ann' and variations


-- first install extension 'fuzzystrmatch' to get access to functionality
CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;


-- using LEVENSHTEIN function to find typos (use lower b/c case switch counts as sub)
SELECT name FROM names WHERE name ILIKE 'w%';
SELECT name, LEVENSHTEIN(lower(name),'william') FROM names WHERE name ILIKE 'w%' ORDER BY name; 
SELECT name FROM names WHERE LEVENSHTEIN(lower(name),'william') < 2;
SELECT name FROM names WHERE LEVENSHTEIN(lower(name),'william') < 3;
SELECT name FROM names WHERE LEVENSHTEIN(lower(name),'william') < 4;
SELECT name FROM names WHERE LEVENSHTEIN(lower(name),'will') < 3;
SELECT name FROM names WHERE LEVENSHTEIN(lower(name),'will') < 4;
SELECT name FROM names WHERE LEVENSHTEIN(lower(name),'will') < 5;

-- other interesting examples
SELECT name FROM names WHERE LEVENSHTEIN(lower(name),'brian') < 3;
SELECT name FROM names WHERE LEVENSHTEIN(lower(name),'brian') < 4;
SELECT name FROM names WHERE LEVENSHTEIN(lower(name),'brian') < 5;

-- using SOUNDEX function to find sounds like
SELECT SOUNDEX('william');
SELECT SOUNDEX('will');
SELECT SOUNDEX('bill');
SELECT name FROM names WHERE SOUNDEX(name) = SOUNDEX('will');
SELECT name FROM names WHERE SOUNDEX(name) = SOUNDEX('william');
SELECT name FROM names WHERE SOUNDEX(name) = SOUNDEX('an');
SELECT name FROM names WHERE SOUNDEX(name) = SOUNDEX('louis');
SELECT name FROM names WHERE SOUNDEX(name) = SOUNDEX('jeff');
SELECT SOUNDEX('jeff');
SELECT SOUNDEX('geoff');
SELECT SOUNDEX('larry');
SELECT SOUNDEX('harry');
SELECT SOUNDEX('terry');
SELECT SOUNDEX('terrie');
SELECT name FROM names WHERE SOUNDEX(name) = SOUNDEX('rob');
SELECT name FROM names WHERE SOUNDEX(name) = SOUNDEX('bob');

-- combining these two functions works fine...
SELECT SOUNDEX('rob');
SELECT SOUNDEX('bob');
SELECT name, LEVENSHTEIN(lower(name),'rob') FROM names WHERE name ILIKE 'r%' OR name ILIKE 'b%' ORDER BY name; 
-- SELECT name, LEVENSHTEIN(lower(name),'rob') FROM names WHERE name ~* '^[br]' ORDER BY name;  -- (less typing)
SELECT name FROM names WHERE LEVENSHTEIN(SOUNDEX(name), SOUNDEX('rob')) < 2 ORDER BY name;
SELECT name FROM names WHERE LEVENSHTEIN(SOUNDEX(name), SOUNDEX('rob')) < 2 AND name ~* '^[br]' ORDER BY name;


-- introducing DMETAPHONE (double metaphone)
SELECT DMETAPHONE('william');
SELECT DMETAPHONE('will');
SELECT DMETAPHONE('bill');
SELECT DMETAPHONE('rob');

-- comparing with soundex
SELECT name FROM names WHERE SOUNDEX(name) = SOUNDEX('rob');
SELECT name FROM names WHERE DMETAPHONE(name) = DMETAPHONE('rob');
	-- no real difference

SELECT name FROM names WHERE SOUNDEX(name) = SOUNDEX('an');
SELECT name FROM names WHERE DMETAPHONE(name) = DMETAPHONE('an');
	-- solved the 'Anne' issue earlier

SELECT name FROM names WHERE LEVENSHTEIN(SOUNDEX(name), SOUNDEX('rob')) < 2 ORDER BY name;
SELECT name FROM names WHERE LEVENSHTEIN(DMETAPHONE(name), DMETAPHONE('rob')) < 2 ORDER BY name;
	-- Jeff, Davy, etc, so a better solution

SELECT name FROM names WHERE SOUNDEX(name) = SOUNDEX('jeff');
SELECT name FROM names WHERE DMETAPHONE(name) = DMETAPHONE('jeff');
-- solved the 'Jeff' issue earlier

SELECT name FROM names WHERE SOUNDEX(name) = SOUNDEX('larry');
SELECT name FROM names WHERE DMETAPHONE(name) = DMETAPHONE('larry');
	-- is this thing broken already?
	-- no, not yet at least
SELECT name FROM names WHERE LEVENSHTEIN(DMETAPHONE(name), DMETAPHONE('larry')) < 2;
SELECT DMETAPHONE('larry');
SELECT DMETAPHONE('harry');
SELECT DMETAPHONE('marie');


-- what is each of the following doing?  Which is best?  Is there a better way? (food for thought if you have time)
SELECT name FROM names WHERE LEVENSHTEIN(SUBSTRING(DMETAPHONE(name) from 2 for 4), DMETAPHONE('larry')) < 2;
SELECT name FROM names WHERE LEVENSHTEIN(SUBSTRING(DMETAPHONE(name) from 1 for 4), DMETAPHONE('larry')) < 2;
SELECT name FROM names WHERE SUBSTRING(DMETAPHONE(name) from 1 for 1) = SUBSTRING(DMETAPHONE('larry') from 1 for 1);
SELECT name FROM names WHERE SUBSTRING(DMETAPHONE(name) from 2 for 4) = SUBSTRING(DMETAPHONE('larry') from 2 for 4);
SELECT name FROM names WHERE DMETAPHONE(SUBSTRING(name from 2 for 4)) = DMETAPHONE(SUBSTRING('larry' from 2 for 4));