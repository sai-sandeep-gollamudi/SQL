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
