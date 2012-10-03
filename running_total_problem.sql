-- PROBLEM: Find the major victories for hero_id = 1 (Batman) each month as 
-- well as a running total of his major victories year to date (YTD)


-- SOLUTION 1: using self joins
	-- Step 1: join each 'month' record with previous 'month' records (self-joins)
SELECT *
FROM victories v JOIN victories v1 ON (v.for_month>=v1.for_month) 
WHERE v.hero_id = 1
ORDER BY v.for_month;

	-- Step 2: group by month (and major) in order to aggregate
SELECT to_char(v.for_month,'Month YYYY') AS "Month", 
v.major AS "Victories", 
SUM(v1.major) AS "YTD"
FROM victories v JOIN victories v1 
ON (v.for_month>=v1.for_month) 
WHERE v.hero_id = 1 AND v1.hero_id = 1
GROUP BY v.for_month, v.major 
ORDER BY v.for_month;


-- SOLUTION 2: using a correlated subquery in SELECT clause
SELECT to_char(v.for_month,'Month YYYY') AS "Month"
	, v.major AS "Victories"
	, (SELECT SUM(major) FROM victories v1 WHERE v.for_month>=v1.for_month AND v1.hero_id=1) AS "YTD"
FROM victories v  
WHERE v.hero_id = 1 
ORDER BY v.for_month;


	-- experiment by asking what will happen when we drop the column alias
	
	-- Bottom line is that solution 1 will typically execute slightly faster 
	-- but solution 2 is more intuitive