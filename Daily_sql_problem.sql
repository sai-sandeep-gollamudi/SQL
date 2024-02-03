--- 01/30/2024---

with temp as(
    select candidateId,
    count(candidateId) over(partition by candidateId) as total_count
    from Vote
)

select name from Candidate where
id in (select top 1 CandidateId from temp order by total_count desc)

--or

select name from Candidate where id in
(
   select top 1 candidateId from Vote
   group by candidateId
   order by count(*) desc
)

---01/31/2024---

with temp as(
    select *,
    row_number() over(partition by company order by salary) as rank_no,
    count(*) over(partition by company) as count_no
    from Employee
)

select id,company,salary from temp
where rank_no = (count_no/2) + 1
or (count_no%2 = 0 and rank_no = count_no/2)

---02/01/2024----
select d.dept_name,
isnull(count(student_id),0) as student_number from
Department d left join Student s on
s.dept_id = d.dept_id
group by d.dept_name
order by 2 desc, d.dept_name asc;

---02/02---
select round(
    case
    when (select count(*) from (select distinct requester_id,accepter_id from RequestAccepted)r) !=0
       and  (select count(*) from (select distinct sender_id,send_to_id from FriendRequest)s)!=0
       then (select count(*) from (select distinct requester_id,accepter_id from RequestAccepted)r)*1.0 /
       (select count(*) from (select distinct sender_id,send_to_id from FriendRequest)s)
    else 0.00
    end,
    2
) as accept_rate


-- with temp as(
--     select distinct s.sender_id,s.send_to_id,
--     r.requester_id,r.accepter_id from
--     FriendRequest s left join RequestAccepted r on
--     s.sender_id=r.requester_id and
--     s.send_to_id = r.accepter_id
-- )

-- select
-- case
-- when count(accepter_id)!=0 and count(sender_id)!=0 then round(count(accepter_id)*1.0/count(sender_id),2)
-- else 0.00
-- end as accept_rate from temp
