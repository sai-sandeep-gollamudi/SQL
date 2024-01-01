---
select user_id,max(time_stamp) as last_stamp
from logins
where year(time_stamp) = 2020
group by user_id;

---
select distinct player_id,
first_value(event_date) over(partition by player_id order by event_date) as first_login
from Activity;

---
select top 1 customer_number from Orders
group by customer_number
order by count(customer_number) desc;