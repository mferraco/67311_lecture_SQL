-- UNION and UNION ALL

SELECT name FROM heroes UNION SELECT name FROM marvel;

SELECT name, power FROM heroes UNION SELECT name, power FROM marvel;

SELECT name FROM heroes UNION ALL SELECT name FROM marvel; -- faster than UNION

-- SELECT name, power FROM heroes UNION ALL SELECT name, power FROM marvel;

SELECT * FROM heroes UNION SELECT * FROM marvel;

SELECT name FROM heroes UNION SELECT name, power FROM marvel; -- fail b/c wrong num of cols

SELECT hero_id, name FROM heroes UNION SELECT name, power FROM marvel; -- fail b/c mismatched data types

SELECT power, name FROM heroes UNION SELECT name, power FROM marvel; -- works, even if makes no sense


-- INTERSECT and INTERSECT ALL

SELECT name FROM heroes INTERSECT SELECT name FROM marvel;

SELECT name, power FROM heroes INTERSECT SELECT name, power FROM marvel;

SELECT name FROM heroes INTERSECT ALL SELECT name FROM marvel; -- faster than INTERSECT

SELECT name FROM marvel INTERSECT SELECT name FROM dc;


-- EXCEPT and combos

SELECT name FROM heroes EXCEPT SELECT name FROM marvel;

SELECT name, power FROM heroes EXCEPT SELECT name, power FROM marvel;

SELECT name FROM marvel EXCEPT SELECT name FROM heroes; -- order matters

SELECT name FROM heroes EXCEPT SELECT name FROM marvel EXCEPT SELECT name FROM dc;
