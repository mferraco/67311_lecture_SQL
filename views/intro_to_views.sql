-- spreadsheet-like display
select cases.title, crimes.name, solved, batman_involved, first_name, last_name, rank, 
	start_date, end_date, units.name 
from (crimes join cases using (crime_id)) 
	full join (
		(officers left join assignments using(officer_id) left join units using (unit_id))
	) using (case_id) 
order by title;


-- getting all values
select * 
from (crimes join cases using (crime_id)) 
	full join (
		(officers left join assignments using(officer_id) left join units using (unit_id))
		) using (case_id) 
order by title, last_name, first_name;

