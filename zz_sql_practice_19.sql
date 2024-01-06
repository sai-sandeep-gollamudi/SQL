select Email from person
group by Email having count(Email)>1;

---
select actor_id,director_id
from ActorDirector
group by actor_id,director_id
having count(*) > 2;

---
select date_id, make_name,
count(distinct lead_id) as unique_leads,
count(distinct partner_id) as unique_partners from 
DailySales
group by date_id, make_name;

---
select title from content 
where content_id in (select content_id from TvProgram where month(program_date)=06 and year(program_date)=2020) and
Kids_content='Y' and content_type='Movies';
