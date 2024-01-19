with temp as(
    select log_id,
    row_number() over(order by log_id) as row_num
    from Logs
)

select min(log_id) as start_id,
max(log_id) as end_id
from temp t
group by (log_id-row_num)


---
with practice as (
    select *,
    datediff(day,visit_date,coalesce(lead(visit_date) over(partition by user_id order by visit_date) ,   '2021-01-01')) as diff from UserVisits
)

select user_id, max(diff) as biggest_window
from practice p
group by p.user_id
