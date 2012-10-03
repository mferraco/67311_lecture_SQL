-- GROUP BY vs ORDER BY; Refining GROUP BY
SELECT project_id, reporter_id, resolver_id FROM defects ORDER BY project_id;

SELECT project_id, COUNT(*) FROM defects GROUP BY project_id;

SELECT project_id, COUNT(*) FROM defects GROUP BY project_id ORDER BY project_id;

SELECT project_id, reporter_id, COUNT(*) FROM defects GROUP BY project_id, reporter_id ORDER BY project_id, reporter_id;
-- SELECT project_id, reporter_id, COUNT(*) FROM defects GROUP BY project_id ORDER BY project_id, reporter_id; -- fails
-- SELECT project_id, COUNT(*) FROM defects WHERE reporter_id = 13 GROUP BY project_id ORDER BY project_id;




SELECT project_id, reporter_id, resolver_id, COUNT(*) FROM defects GROUP BY project_id, reporter_id, resolver_id ORDER BY project_id, reporter_id, resolver_id;

SELECT ranking, reporter_id, resolver_id FROM defects d JOIN severities s ON d.severity_id = s.id WHERE d.project_id = 4 ORDER BY ranking;

SELECT resolver_id, (SELECT ROUND(AVG(s1.ranking),2) from defects d1, severities s1 where d1.severity_id=s1.id and d1.resolver_id=d.resolver_id) AS "Avg Ranking" FROM defects d JOIN severities s ON d.severity_id = s.id WHERE d.project_id = 4 GROUP BY resolver_id ORDER BY resolver_id;
