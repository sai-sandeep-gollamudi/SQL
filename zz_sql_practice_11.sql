---
select left(datefromparts(year(trans_date),month(trans_date),01),7) as 'month',
country,
(count(*)) as trans_count,
(
    sum(
        case
        when state='approved' then 1
        else 0
        end
    )
) as approved_count,
sum(amount) as trans_total_amount,
sum(
    case
    when state = 'approved' then (amount)
    else 0
    end
) as approved_total_amount
from Transactions
group by country,year(trans_date),month(trans_date);

---
with temp_table as(
    select distinct customer_id, order_date,customer_pref_delivery_date ,
    rank() over(partition by customer_id order by order_date) as rank_no
    from Delivery
)

select 
round(sum(
           case 
           when order_date = customer_pref_delivery_date then 1
           else 0
           end
        )*100.0/count(customer_id),2) as immediate_percentage from temp_table
where rank_no=1
