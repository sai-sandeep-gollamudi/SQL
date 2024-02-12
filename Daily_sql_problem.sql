--- 01/30/2024---

with temp as(
    select candidateId,
    count(candidateId) over(partition by candidateId) as total_count
    from Vote
)

select name from Candidate where
id in (select top 1 CandidateId from temp order by total_count desc)

--or

select name from Candidate where id in
(
   select top 1 candidateId from Vote
   group by candidateId
   order by count(*) desc
)

---01/31/2024---

with temp as(
    select *,
    row_number() over(partition by company order by salary) as rank_no,
    count(*) over(partition by company) as count_no
    from Employee
)

select id,company,salary from temp
where rank_no = (count_no/2) + 1
or (count_no%2 = 0 and rank_no = count_no/2)

---02/01/2024----
select d.dept_name,
isnull(count(student_id),0) as student_number from
Department d left join Student s on
s.dept_id = d.dept_id
group by d.dept_name
order by 2 desc, d.dept_name asc;

---02/02---
select round(
    case
    when (select count(*) from (select distinct requester_id,accepter_id from RequestAccepted)r) !=0
       and  (select count(*) from (select distinct sender_id,send_to_id from FriendRequest)s)!=0
       then (select count(*) from (select distinct requester_id,accepter_id from RequestAccepted)r)*1.0 /
       (select count(*) from (select distinct sender_id,send_to_id from FriendRequest)s)
    else 0.00
    end,
    2
) as accept_rate


-- with temp as(
--     select distinct s.sender_id,s.send_to_id,
--     r.requester_id,r.accepter_id from
--     FriendRequest s left join RequestAccepted r on
--     s.sender_id=r.requester_id and
--     s.send_to_id = r.accepter_id
-- )

-- select
-- case
-- when count(accepter_id)!=0 and count(sender_id)!=0 then round(count(accepter_id)*1.0/count(sender_id),2)
-- else 0.00
-- end as accept_rate from temp

---02/03---
select followee as follower,
count(*) as num from Follow
group by followee
having followee in (select follower from Follow)
order by followed

---02/04---
select product_id,
sum(quantity) as total_quantity
from Sales
group by product_id

---02/05---
with temp as(
    select seller_id,
    sum(price) as total_price from Sales
    group by seller_id
)

select seller_id
from temp where
total_price = (select Max(total_price) from temp)

---02/06---
select distinct buyer_id from (
    select buyer_id from Sales where
    product_id in (select product_id from Product where product_name = 'S8')
)t where buyer_id not in (select buyer_id from Sales where product_id in(
    select product_id from Product where product_name = 'iPhone'
))

---02/07---
select t.project_id 
from(
    select project_id, count(*) as count_no,
    rank() over(order by count(*) desc) as rank_no
    from Project
    group by project_id
) t
where rank_no=1;

---02/08---
with temp as (
    select book_id,sum(quantity) as total_quantity
    from Orders
    where dispatch_date >= '2018-06-23'
    group by book_id
)

select b.book_id,b.name from Books b left join
temp t on
b.book_id = t.book_id
where isnull(t.total_quantity,0) < 10
and b.available_from < '2019-05-23';

---02/09---
with temp as (
    select user_id, min(activity_date) as first_login
    from Traffic
    where activity='login'
    group by user_id
)

select first_login as login_date, 
count(user_id) as user_count
from temp
group by first_login
having first_login >= '2019-04-01'

---02/10---
select extra as report_reason,
count(distinct post_id) as report_count
from Actions
where action_date='2019-07-04' and
action='report'
group by extra;

---02/11---
select u.user_id as buyer_id,
u.join_date,
sum(
    case
    when year(o.order_date) = 2019 then 1
    else 0
    end
)as orders_in_2019
from Users u left join Orders o on
u.user_id = o.buyer_id
group by u.user_id, u.join_date;
