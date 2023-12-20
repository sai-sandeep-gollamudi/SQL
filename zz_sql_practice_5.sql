--
select m.employee_id,m.name, count(e.employee_id) as reports_count,
Round(sum(e.age)/(count(e.employee_id)*1.0),0) as average_age from Employees m inner join Employees e on
m.employee_id = e.reports_to
group by m.employee_id,m.name
order by m.employee_id;

--
select employee_id, department_id
from (
    select *,count(employee_id) over(partition by employee_id) as emp_count
    from employee
) t
where emp_count = 1 or
primary_flag = 'Y';

--
select *, 
case 
when (x+y)>z and (y+z)>x and (z+x)>y then 'Yes'
else 'No'
end as triangle from
triangle;

--
select distinct num as Consecutivenum
from (
      select *,
	  lag(num,1) over(order by id) as prev_num_val,
	  lead(num,1) over(order by id) as next_num_val
	  from logs
) t
where num = prev_num_val and num = next_num_val;

--
select distinct p.product_id,
isnull(t.price,10) as price from
Products P left join
(
select distinct product_id, 
first_value(new_price) over(partition by product_id order by change_date desc)
as price from Products
where change_date <= '2019-08-16'
) t on
p.product_id = t.product_id;


