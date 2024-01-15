with temp as (
    select e.employee_id,e.experience_years,
    p.project_id from Employee e inner join
    Project p on e.employee_id = p.employee_id
)

select m.project_id, m.employee_id from temp m
where m.experience_years = (select max(experience_years) from temp t where t.project_id=m.project_id)

----
with temp as (
    select customer_id, product_id,
    count(order_id) as orders_count,
    rank() over(partition by customer_id order by count(order_id) desc) as order_rank
    from Orders
    group by customer_id, product_id
)

select t.customer_id, t.product_id,
p.product_name from temp t inner join
Products p on
t.product_id = p.product_id
where t.order_rank = 1
