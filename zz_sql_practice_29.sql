with temp_table as(
    select *,
    row_number() over(order by s.dateVal) - dense_rank() over(partition by s.result order by s.dateVal) as r
    from (
        select success_date as dateVal,
        'succeeded' as result
        from Succeeded
        where year(success_date)='2019'
        union all
        select fail_date,
        'failed' as result
        from Failed
        where year(fail_date)='2019'
    ) s
)

select result as period_state,
min(dateVal) as start_date,
max(dateVal) as end_date from temp_table
group by result,r
order by 2
