---
select * from Patients where conditions like '% DIAB1%' or 
conditions like 'DIAB1%';

---
delete p2 from Person p1,
Person p2
where p2.id>p1.id and p1.email=p2.email;


# Write your MySQL query statement below
select distinct viewer_id as id from(
select 
viewer_id,
count(*) as ct
from (select distinct * from views where author_id != viewer_id)p
group by viewer_id, view_date
)t where t.ct>1 order by t.viewer_id
