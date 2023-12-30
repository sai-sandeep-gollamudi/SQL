---
with temp as (
    select *,
    rank() over(partition by student_id order by grade desc,course_id asc) as grade_rank
    from Enrollments
)

select student_id, course_id, grade
from temp where
grade_rank = 1
order by student_id;

---
select p.firstName,p.lastName,
a.city, a.state from 
Person p left join 
Address a on p.personId=a.personId;

---
select seller_name from Seller
where seller_id not in
(select seller_id from Orders where year(sale_date)=2020)
order by seller_name;

---
select u.name, isnull(r.travelled_distance,0) as travelled_distance
from Users u left join (
    select user_id,sum(distance) as travelled_distance 
    from Rides group by user_id
) r on
u.id = r.user_id
order by 2 desc, 1 asc;

---
select name from Salesperson where 
sales_id not in(
    select sales_id from orders where com_id=(select com_id from company where name='RED')
)
