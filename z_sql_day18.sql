-- with exists
Select PH.PurchaseOrderID,
PH.OrderDate,
PH.TotalDue
from Purchasing.PurchaseOrderHeader PH
where exists (
                select * from  Purchasing.PurchaseOrderDetail PD
				where PH.PurchaseOrderID = PD.PurchaseOrderID
				and PD.RejectedQty > 5
			  )

-- with Update

create table #purchasedata2(
OrderID int,
OrderDate date,
TotalDue money,
RejectedQty int
)

insert into #purchasedata2(
OrderID,
OrderDate,
TotalDue
)

select PurchaseOrderID,
OrderDate,
TotalDue
from Purchasing.PurchaseOrderHeader

Update #purchasedata2
Set 
RejectedQty = PD.RejectedQty
from #purchasedata2 P2
inner join Purchasing.PurchaseOrderDetail PD
on P2.OrderID = PD.PurchaseOrderID

select * from #purchasedata2

drop table #purchasedata2

-- Indexes

CREATE TABLE #PersonInfo
(
	   BusinessEntityID INT,
      Title VARCHAR(8),
      FirstName VARCHAR(50),
      MiddleName VARCHAR(50),
      LastName VARCHAR(50),
	  PhoneNumber VARCHAR(25),
	  PhoneNumberTypeID VARCHAR(25),
	  PhoneNumberType VARCHAR(25),
	  EmailAddress VARCHAR(50)
)

INSERT INTO #PersonInfo
(
	   BusinessEntityID,
      Title,
      FirstName,
      MiddleName,
      LastName
)

SELECT
	   BusinessEntityID,
      Title,
      FirstName,
      MiddleName,
      LastName
FROM Person.Person

Create CLUSTERED Index perinfo_1 on #PersonInfo(BusinessEntityID)

Update #PersonInfo
Set
PhoneNumber = P.PhoneNumber,
PhoneNumberTypeID = P.PhoneNumberTypeID
from #PersonInfo PE
inner join Person.PersonPhone P on
PE.BusinessENtityID = P.BusinessEntityID

create NONCLUSTERED INDEX per_info2 on #PersonInfo(PhoneNUmberTypeID)

Update #PersonInfo
SET
PhoneNumberType = PT.Name
from #PersonInfo PE inner join
Person.PhoneNumberType PT on 
PE.PhoneNumberTypeID = PT.PhoneNumberTypeID

Update #PersonInfo
SET
EmailAddress = E.EmailAddress
from #PersonInfo PE
inner join Person.EmailAddress E
on PE.BusinessEntityID = E.BusinessEntityID

select * from #PersonInfo

Drop table #PersonInfo