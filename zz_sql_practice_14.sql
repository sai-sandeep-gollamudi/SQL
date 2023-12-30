---
select customer_id from Customers
where year = 2021 and revenue > 0;

---
select name as Customers from customers where id not in (select customerId from orders);

---
select employee_id, salary as bonus from employees where 
employee_id%2!=0 and name not like 'M%'
union
select employee_id, 0 as bonus from employees where
employee_id%2=0 or name like 'M%' order by employee_id;