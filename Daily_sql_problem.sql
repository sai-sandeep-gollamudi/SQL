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

