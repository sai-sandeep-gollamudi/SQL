with temp as (
    select *,
    max(score) over(partition by exam_id) as max_score,
    min(score) over(partition by exam_id) as min_score,
    count(exam_id) over(partition by student_id) as count_val
    from Exam
)

select distinct t.student_id,s.student_name from
temp t inner join student s on
t.student_id = s.student_id
where t.student_id not in (
    select student_id from temp where
    score=max_score or score=min_score
)


---
with temp as(
    select customer_id,
    sum(case when product_name='A' then 1 else 0 end) over(partition by customer_id) as A_purchasecount,
    sum(case when product_name='B' then 1 else 0 end) over(partition by customer_id) as B_purchasecount,
    sum(case when product_name='C' then 1 else 0 end) over(partition by customer_id) as C_purchasecount
    from Orders
)

select distinct c.customer_id, c.customer_name from 
Customers c left join temp on
c.customer_id=temp.customer_id
where temp.A_purchasecount > 0 and
temp.B_purchasecount > 0 and 
temp.C_purchasecount = 0
order by customer_id;
