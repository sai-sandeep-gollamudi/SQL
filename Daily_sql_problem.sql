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

---