select d.name as department, e.name as Employee,
e.salary from Department d inner join (
    select *,
    rank() over(partition by departmentId order by salary desc) as salrank
    from Employee
) e on e.departmentId=d.id
where e.salrank = 1;

---
select p.product_name,p.product_id,
o.order_id,o.order_date from 
Products p inner join 
(
    select *,
    rank() over(partition by product_id order by order_date desc) as recent
    from Orders
) o
on p.product_id = o.product_id
where o.recent = 1
order by p.product_name,p.product_id,o.order_id;

select p.product_name, p.product_id,
o.order_id, o.order_date from Products p inner join
Orders o on p.product_id = o.product_id
where o.order_date = (select max(t.order_date) from Orders t where t.product_id = p.product_id)
order by p.product_name,p.product_id,o.order_id;

---
select c.name as customer_name, c.customer_id,
o.order_id, o.order_date from Customers c inner join
(
    select *,
    rank() over(partition by customer_id order by order_date desc) as recent
    from Orders
) o on c.customer_id = o.customer_id 
where o.recent<4
order by c.name,c.customer_id,o.order_date desc;

---
select transaction_id from (
    select *,
    rank() over(partition by cast(day as date) order by amount desc) as highest_amount
    from Transactions
) t
where t.highest_amount = 1
order by transaction_id;