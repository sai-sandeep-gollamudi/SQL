--SQl functions
select CardNumber,
right(CardNumber,4) as LastFourDigits from
Sales.CreditCard

select ReviewerName,
Comments,
replace(Comments,'-',' ') as [Cleaned Comments]
from Production.ProductReview

select FirstName, 
LastName from
Person.Person
where len(LastName) >=10
order by len(LastName) desc;

--Concat WS(Concat With Separator)

select FirstName,
MiddleName,
LastName,
FullName = FirstName +  IsNUll(' ' +MiddleName,'') + ' '+LastName,
[Easyway FullName] = Concat_WS(' ',FirstName,MiddleName,LastName)
from Person.Person

select * from Person.Address

select * from Person.StateProvince

select 
FullAddress = Concat_WS(' ',A.AddressLine1,A.AddressLine2,A.City,S.Name,A.PostalCode)
from Person.Address A inner join Person.StateProvince S
on A.StateProvinceID = S.StateProvinceID;

select Concat_WS(' :$',Name,ListPrice) as ProductPrice
from Production.Product
where ListPrice>1000;


--Nested Functions

Select FirstName,
LastName,
Concat_WS('-',left(FirstName,1),left(LastName,3)) as NickName
from Person.Person;

select ReviewerName,
Comments,
Replace(Replace(Comments,',',''),'.','') as [Cleaned Comments]
from Production.ProductReview;

Select FirstName,
Upper(FirstName) as FirstNameUpper,
Lower(FirstName)as FirstNameLower
from Person.Person;

-- Date and datetime
select GetDate() as Today,
MONTH(GetDate()) as [This month],
Year(GetDate()) as [This year]

select PurchaseOrderID,OrderDate,TotalDue from Purchasing.PurchaseOrderHeader
where Year(OrderDate) = 2011 and TotalDue>10000;

select GetDate() + 100 as [100 days from now];

select DateAdd(Month,6,GetDate()) as [6 months from now]

select * from sales.SalesOrderHeader
where DateDiff(DAY,OrderDate,DATEFROMPARTS(2013,12,25)) between 0 and 7 ;

select * from sales.SalesOrderHeader
where DateDiff(DAY,OrderDate,DATEFROMPARTS(year(OrderDate),12,25)) between 0 and 7;

select CAST(GetDate()-1 as Date) as [Yesterday's date];

select DateDiff(day,GetDate(),cast('2023-12-31' as Date)) as [Days until new year];

select Title,
FirstName,
MiddleName,
LastName,
Suffix,
PersonId = PersonType + '-' + cast(BusinessEntityID as  varchar)
from Person.Person
where MiddleName is Not Null and (Title is Not Null or Suffix is Not NUll)
