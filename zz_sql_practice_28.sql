with temp as(
    select from_id as person1,
    to_id as person2,
    duration from Calls
    where from_id<to_id
    Union all
    select to_id,
    from_id, duration from Calls
    where from_id>to_id
)

select person1, person2,
count(*) as call_count,
sum(duration) as total_duration
from temp
group by person1,person2;

---
with temp as(
    select o.customer_id, left(o.order_date,7) as derived_date,
    sum(o.quantity*p.price) as total_cost_permonth
    from orders o inner join product p
    on p.product_id=o.product_id
    group by o.customer_id,left(o.order_date,7)
    having left(o.order_date,7) in ('2020-06','2020-07')
    and sum(o.quantity*p.price)>=100
)

select distinct t.customer_id,c.name from temp t inner join
Customers c on t.customer_id=c.customer_id
group by t.customer_id,c.name
having count(*)=2;

-----
with call_details as (
    select caller_id as caller,
    duration from calls
    union all
    select callee_id, duration from calls
),
person_details as (
    select p.id,p.phone_number,
    c.name,c.country_code from Person p
    inner join Country c on 
    left(p.phone_number,3)=c.country_code
)

select distinct t.name as country from (
    select c.caller,c.duration,
    p.id,p.name,
    sum(c.duration) over(partition by p.name) as country_total,
    sum(c.duration) over() as global_total,
    count(c.caller) over(partition by p.name) as country_caller_count,
    count(c.caller) over() as caller_count
    from call_details c inner join
    person_details p on c.caller=p.id
) t where (t.country_total/t.country_caller_count) > (t.global_total/t.caller_count);

----
with task_idtable as (
    select task_id, subtasks_count as id from Tasks
    union all
    select task_id, (id-1) as id from task_idtable
    where (id-1)>0
)
-- select * from task_idtable;
select task_id,id as subtask_id from task_idtable 
except
select task_id,subtask_id from Executed
