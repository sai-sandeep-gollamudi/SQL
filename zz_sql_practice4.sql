select teacher_id, count(distinct subject_id) as cnt from Teacher
group by teacher_id;

select activity_date as 'day',
count(distinct user_id) as active_users from Activity
group by activity_date
having activity_date between dateadd(day,-29,'2019-07-27') and '2019-07-27';

select s.product_id,s.year as first_year,s.quantity,s.price from Sales s inner join 
(select product_id, min(year) as first_year from sales
group by product_id
) sq on s.product_id = sq.product_id and s.year = sq.first_year;

select class from Courses group by class
having count(*) >=5;

select user_id, count(follower_id) as followers_count from
Followers group by user_id;

select max(num) as num from(
    select top 1 num,count(*) as num_count from MyNumbers
    group by num having count(*) = 1 order by num desc
) t

select m.employee_id,m.name, count(e.employee_id) as reports_count,
round(avg(e.age)*1.00,0) as average_age from Employees m inner join Employees e on
m.employee_id = e.reports_to
group by m.employee_id,m.name;