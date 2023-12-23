select top 1 requester_id as id,count(requester_id) as num from (
    select requester_id, accepter_id from RequestAccepted 
    union
    select accepter_id as requester_id, requester_id as accepter_id from 
    RequestAccepted
)t
group by requester_id
order by count(requester_id) desc;

---
