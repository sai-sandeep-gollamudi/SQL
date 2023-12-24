---
select * from Patients where conditions like '% DIAB1%' or 
conditions like 'DIAB1%';

---
delete p2 from Person p1,
Person p2
where p2.id>p1.id and p1.email=p2.email;
