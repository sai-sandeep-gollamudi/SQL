--derived columns
select [FirstName] +' '+ [LastName] + '-' +[PersonType] as 
[Person Title] from Person.Person;

select BusinessEntityID,
VacationHours,
SickLeaveHours,
VacationHours + SickLeaveHours as [Total Time Off]
from HumanResources.Employee
where SalariedFlag = 0
order by [Total Time Off];


Select BusinessEntityID,
Rate,
(Rate * 40) * PayFrequency as [Amount Per Paycheck]
from HumanResources.EmployeePayHistory
order by [Amount Per Paycheck] desc;


select BusinessEntityID,
VacationHours,
SickLeaveHours,
(VacationHours + SickLeaveHours ) /8.0 as [Total Days Off]
from HumanResources.Employee
where SalariedFlag = 0
order by [Total Days Off];