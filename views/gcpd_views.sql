-- simple views

create view officer_assignments_view as 
	select * from officers left join assignments using (officer_id);
	
	select * from officer_assignments_view;
	select case_id, first_name, last_name from officer_assignments_view where rank ~* 'captain';
	
	
-- need to specify fields because ambiguous field names; must differentiate
create view officer_units_view as 
	select officers.officer_id, officers.first_name, officers.last_name, officers.rank, 
		officers.joined_gcpd_on, officers.active AS "active officer", 
		units.unit_id, units.name, units.active AS "active unit"
	from officers left join units using (unit_id);
	
	select * from officer_units_view;
	select officer_id, first_name, last_name from officer_units_view where "active officer" = true;
	select officer_id, first_name, last_name from officer_units_view where name ~* 'major';
	

-- can join views 
select * from officer_assignments_view join officer_units_view using (officer_id);
  -- discuss problem with creating new views of joined views...


-- grand view won't work b/c of ambiguous fields, so ...
create view officer_assignments_cases_view as 
	select cases.case_id, cases.title, cases.solved, cases.batman_involved, crimes.crime_id, crimes.name AS "crime name", 
		officers.officer_id, officers.first_name, officers.last_name, officers.rank, 
		officers.joined_gcpd_on, officers.active AS "active officer", 
		units.unit_id, units.name AS "unit name", units.active AS "active unit"
	from (crimes join cases using (crime_id)) full join ((officers left join assignments using(officer_id) left join units using (unit_id))) using (case_id) order by title, last_name, first_name;
	
	