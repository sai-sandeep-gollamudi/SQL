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