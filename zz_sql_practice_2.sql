--problem 10
select machine_id,
Round(sum(
    Case
    When activity_type = 'start' then timestamp*-1
    Else timestamp
    End 
)*1.0/(select count(Distinct process_id)),3) as processing_time
from Activity
group by machine_id;

--problem 11
Select e.name,b.bonus from 
Employee e left join Bonus b on
e.empId = b.empId
where b.bonus<1000 or b.bonus is null;

--problem 12
select s.student_id,s.student_name,
su.subject_name,
isnull(e.attended_exams,0) as attended_exams
from Students s cross join
Subjects su left join
(
    select student_id,
    subject_name,
    count(*) as attended_exams
    from Examinations
    group by student_id,subject_name
) e
on s.student_id = e.student_id and su.subject_name = e.subject_name
order by s.student_id,su.subject_name;


--problem 13
select name from Employee e inner join
(select managerId,count(managerId) as manager_count from employee group by managerId) c
on e.id = c.managerId
where c.manager_count >=5;

--problem 14
select s.user_id,
isnull(c.confirmation_rate,0.00) as confirmation_rate from
Signups s left join
(
    select user_id,round(sum(
        case
            when action ='confirmed' then 1
            else 0
        end
    )*1.0/count(*),2) as confirmation_rate
    from Confirmations
    group by user_id
) c
on s.user_id = c.user_id;

--problem 14
select * from Cinema 
where id%2 != 0 and description!='boring'
order by rating desc;

--problem 15
select p.product_id,
isnull(round(sum(p.price * u.units *1.0)/sum(u.units),2),0) as average_price
from Prices p inner join
UnitsSold u on
p.product_id = u.product_id and
(u.purchase_date between p.start_date and p.end_date)
group by p.product_id