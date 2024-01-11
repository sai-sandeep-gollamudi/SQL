with temp as (
    select Wimbledon as winner from Championships

    Union all

    select Fr_open from Championships

    Union all

    select US_open from Championships

    Union all

    select Au_open from Championships
)

select p.player_id, p.player_name,
count(t.winner) as grand_slams_count from
Players p inner join temp t on 
p.player_id = t.winner
group by p.player_id,p.player_name

---
select player_id,
event_date,
sum(games_played) over(partition by player_id order by event_date) as games_played_so_far
from Activity
order by player_id,event_date

---
select distinct account_id from LogInfo where 
account_id in (
    select (
        case
        when t1.login>=t2.logout and t1.logout<=t2.login then t1.account_id
        when t1.login<=t2.logout and t1.logout>=t2.login then t1.account_id
        else Null
        end
    ) as account from LogInfo t1 inner join LogInfo t2 on
    t1.account_id = t2.account_id and t1.ip_address!=t2.ip_address
)

---
select id, name from Students where
department_id not in (select id from Departments);

---
select id, name from Students where
department_id not in (select id from Departments);

---
select distinct player_id,
first_value(device_id) over(partition by player_id order by event_date) as device_id
from Activity
