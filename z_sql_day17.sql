CREATE TABLE #PersonData
(
	   BusinessEntityID INT
      ,Title VARCHAR(8)
      ,FirstName VARCHAR(50)
      ,MiddleName VARCHAR(50)
      ,LastName VARCHAR(50)
	  ,PhoneNumber VARCHAR(25)
	  ,PhoneNumberTypeID VARCHAR(25)
	  ,PhoneNumberType VARCHAR(25)
	  ,EmailAddress VARCHAR(50)
)

insert into #PersonData(
BusinessEntityID,
Title,
FirstName,
MiddleName,
LastName
)

Select BusinessEntityID,
Title,
FirstName,
MiddleName,
LastName from Person.Person

Update #PersonData
Set
PhoneNumber = PP.PhoneNumber,
PhoneNumberTypeID = PP.PhoneNumberTypeID
from #PersonData P inner join
Person.PersonPhone PP on
P.BusinessEntityID = PP.BusinessEntityID

Update #PersonData
Set 
PhoneNumberType = PT.PhoneNumberTypeID
from #PersonData P inner join 
Person.PhoneNumberType PT on
P.PhoneNumberTypeID = PT.PhoneNumberTypeID

Update #PersonData
Set
EmailAddress = E.EmailAddress
from #PersonData P inner join
Person.EmailAddress E
on P.BusinessEntityID = E.BusinessEntityID

select * from #PersonData
