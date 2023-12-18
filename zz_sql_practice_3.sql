--problem 16
select p.project_id,
Round(Avg(e.experience_years*1.0),2) as average_years from
Project p inner join Employee e on
p.employee_id = e.employee_id
group by p.project_id;

--problem 17
/* using variable
declare @total int
set @total = (select count(*) from users)

select c.contest_id,
round((count(*)*100.0)/@total,2) as 'percentage' from
Register c left join Users u on
u.user_id = c.user_id
group by c.contest_id
order by 2 desc, 1 */

select c.contest_id,
round((count(*)*100.0)/(select count(*) from Users),2) as 'percentage'
from Register c left join
Users u on c.user_id = u.user_id
group by c.contest_id
order by 2 desc,1

--problem 18
select query_name,
Round(Sum(rating/(position*1.0))/count(*),2) as quality,
Round((Sum(
        Case
        When rating < 3 then 1
        else 0
        end
)*100.0)/(count(*))
,2) as poor_query_percentage from
Queries group by query_name
having query_name is not null;
