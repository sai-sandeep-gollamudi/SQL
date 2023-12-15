--SQL Pratice 
--SQL 50 - Day 1

--Problem 1
select product_id from Products where low_fats = 'Y' and recyclable='Y';

--Problem 2
select name from Customer where referee_id != 2 or referee_id is Null;

--Problem 3
Select name,population,area from World
where area>=3000000 or population>=25000000;

--Problem 4
select distinct author_id as id from Views
where author_id = viewer_id
order by author_id;

--Problem 5
select tweet_id from Tweets
where len(content)>15;

--Problem 6
Select U.unique_id,E.name from
Employees E left join EmployeeUNI U on
E.id = U.id;

--Problem 7
Select P.Product_name, S.year,S.price
from Product P inner join Sales S
on S.product_id = P.product_id;

--Problem 8
Select customer_id, count(visit_id) as count_no_trans from Visits
where visit_id not in (select visit_id from Transactions)
group by customer_id;

--Problem 9
Select t2.id as Id from Weather t1 inner join
Weather t2 on DateDiff(day,t1.recordDate,t2.recordDate) = 1
where t1.temperature < t2.temperature;
