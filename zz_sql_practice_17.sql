---
select day,emp_id, sum(t_time) as total_time from
(
    select event_day as day, emp_id,
    (out_time-in_time) as t_time
    from employees
) t
group by day, emp_id
order by 1;

---
select e.left_operand, e.operator,
e.right_operand,
case
when e.operator = '=' and var1.value = var2.value then 'true'
when e.operator = '<' and var1.value < var2.value then 'true'
when e.operator = '>' and var1.value > var2.value then 'true'
else 'false'
end as value
from expressions e inner join
variables var1 on e.left_operand = var1.name
inner join variables var2 on e.right_operand = var2.name

---
with points as(
    select *,
    (
        case
        when host_goals>guest_goals then 3
        when host_goals=guest_goals then 1
        else 0
        end
    ) as host_team_points,
    (
        case
        when host_goals<guest_goals then 3
        when host_goals=guest_goals then 1
        else 0
        end
    ) as guest_team_points
    from Matches
)

select t.team_id,t.team_name,
sum(
    case
    when t.team_id = p.host_team then p.host_team_points
    when t.team_id = p.guest_team then p.guest_team_points
    else 0
    end
) as num_points
from Teams t left join
points p on 
t.team_id = p.host_team or t.team_id=p.guest_team
group by t.team_id
order by 3 desc, 1;

---
with volume as(
    select product_id,
    (width*length*height) as volume
    from products
)

select w.name as warehouse_name,sum(w.units*v.volume) as volume
from Warehouse w  inner join volume v on
w.product_id = v.product_id
group by w.name;

---
select round(sum(
    case
    when order_date = customer_pref_delivery_date then 1 
    else 0
    end
)*100.0/count(*),2) as immediate_percentage from Delivery;

---
select sale_date,sum(changedvalues) as diff from(
    select *,
    (
        case
        when fruit='apples' then sold_num
        else -sold_num
        end
    ) as changedvalues
    from sales
) t
group by sale_date;