---
select d.name as Department,e.name as Employee,e.salary from 
employee e inner join department d on
e.departmentId = d.id inner join
(
    select id,
    dense_rank() over(partition by departmentId order by salary desc) as sal_ran
    from Employee
) t
on t.id = e.id
where t.sal_ran<4;

---
select user_id, concat(upper(substring(name,1,1)), lower(substring(name,2,len(name)))) as name from users
order by user_id;

---
select user_id,name, mail
from users where
mail like '[a-zA-Z]%@leetcode.com'
and left(mail,len(mail)-13) not like '%[^0-9a-zA-Z-._]%';

---
select product_id,year as first_year,
    quantity,price
    from(
        select *,
        rank() over(partition by product_id order by year) as rnk
        from Sales
) t
where t.rnk=1
