select distinct a.seat_id from 
cinema a join cinema b on
abs(a.seat_id - b.seat_id) = 1 and 
a.free=1 and b.free=1
order by a.seat_id;

---
select product_id, 
'store1' as store,
store1 as price from Products
where store1 is not Null

Union

select product_id,
'store2' as store,
store2 as price from Products
where store2 is not Null

Union

select product_id,
'store3' as store,
store3 as price from Products
where store3 is not Null

---
select min(distance) as shortest from
(
    select a.x as a,b.x as b,
    abs(a.x-b.x) as distance
    from Point a inner join Point b
    on a.x != b.x
)t

---
select employee_id from Employees where
employee_id not in (select employee_id from Salaries)

Union

select employee_id from Salaries where
employee_id not in (select employee_id from Employees)

---
with friends as(
    select user2_id as friend from Friendship where user1_id=1
    union
    select user1_id from Friendship where user2_id=1
)

select distinct page_id as recommended_page
from Likes where
user_id in (select * from friends) and
page_id not in (select page_id from likes where user_id=1)
