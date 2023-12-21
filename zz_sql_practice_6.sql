--
with temp as (
    select person_name, sum(weight) over(order by turn) as total_weight
    from Queue
)

select top 1 person_name from temp where total_weight <= 1000
order by total_weight desc;

--
select 'High Salary' as category,
sum(case
    when income > 50000 then 1
    else 0
    end
) as accounts_count from Accounts

union

select 'Average Salary' as category,
sum(case
    when income >=20000 and income<=50000 then 1
    else 0
    end
) as accounts_count from Accounts 

union

select 'Low Salary' as category,
sum(case
    when income < 20000 then 1
    else 0
    end 
) as accounts_count from Accounts 

--
select employee_id from Employees where
salary<30000 and manager_id not in (select employee_id from Employees)
order by employee_id;

--
declare @temp int 
set @temp = (select max(id) from Seat)

select (
    case
       when id%2!=0 and id!=@temp then id+1
       when id%2!=0 and id=@temp then id
       else id-1
    end
) as id, student
from Seat
order by id;
