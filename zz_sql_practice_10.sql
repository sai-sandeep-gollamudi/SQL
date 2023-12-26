---
select max(salary) as SecondHighestSalary from
Employee where
salary<(select Max(salary) from employee);

---
select sell_date,count(*) as num_sold,
string_agg(product, ',') within group (order by product) as products
from (select distinct * from Activities) t
group by sell_date
order by sell_date;

----
select sell_date,count(*) as num_sold,
string_agg(product, ',') within group (order by product) as products
from (select distinct * from Activities) t
group by sell_date
order by sell_date;

----
select p.product_name, sum(o.unit) as unit
from products p inner join 
(select * from orders where year(order_date)=2020 and month(order_date)=2)o on
p.product_id = o.product_id
group by p.product_name
having sum(o.unit)>=100;
