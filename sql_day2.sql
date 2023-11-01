-- where statements

SELECT
      [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
  FROM [AdventureWorks2022].[Person].[Person]
  where FirstName = 'Pilar';

  SELECT
      [AccountNumber]
      ,[Name]
      ,[CreditRating]
      ,[PreferredVendorStatus]
      ,[ActiveFlag]
      ,[PurchasingWebServiceURL]
  FROM [AdventureWorks2022].[Purchasing].[Vendor]
  where [Name] = 'Northwind Traders';


  SELECT
      [AccountNumber]
      ,[Name]
      ,[CreditRating]
      ,[PreferredVendorStatus]
      ,[ActiveFlag]
      ,[PurchasingWebServiceURL]
  FROM [AdventureWorks2022].[Purchasing].[Vendor]
  where PreferredVendorStatus = 1;

  
  SELECT
      [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
  FROM [AdventureWorks2022].[Person].[Person]
  where PersonType!='IN';

  SELECT
      [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
  FROM [AdventureWorks2022].[Person].[Person]
  Where Title is NOT NULL;

  SELECT
      [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
  FROM [AdventureWorks2022].[Person].[Person]
  Where MiddleName is NULL;


  -- AND, OR, IN Statements
  SELECT
      [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
  FROM [AdventureWorks2022].[Person].[Person]
  Where Title != 'MR' or
  Title is NULL;

  Select  [PersonType]
      ,[Title]
      ,[FirstName]
      ,[LastName]
	  from [AdventureWorks2022].[Person].[Person]
	  Where FirstName = 'Laura' and
	  LastName = 'Norman';

  Select  [PersonType]
      ,[Title]
      ,[FirstName]
      ,[LastName]
	  from [AdventureWorks2022].[Person].[Person]
	  Where PersonType IN('SP','EM','VC');

select * from HumanResources.Employee where
gender = 'F' and JobTitle in ('Network Manager','Application Specialist');

Select PersonType as [Person Type],
Title,
FirstName as [First Name],
MiddleName as [Middle Name],
LastName as [Last Name],
Suffix
from Person.Person
where PersonType = 'EM' and
(Title is NULL or MiddleName is NULL);


--Range

Select OrderDate,
SubTotal,
TaxAmt,
Freight,
TotalDue
from Purchasing.PurchaseOrderHeader
where TotalDue>50000 and Freight<1000;

Select OrderDate,
SubTotal,
TaxAmt,
Freight,
TotalDue
from Purchasing.PurchaseOrderHeader
where SubTotal between 10000 and 30000;

Select OrderDate,
SubTotal,
TaxAmt,
Freight,
TotalDue
from Purchasing.PurchaseOrderHeader
where SubTotal > 10000 and
SubTotal < 30000;

--Text patterns

select * from Person.Person
where FirstName like '%.';

select * from Person.Person
where FirstName like 'T%'
and MiddleName like 'L%'
and LastName like 'C%';

select * from Person.Person
where FirstName not like '%[aeiou]%';

--order by

select OrganizationLevel as [Organization Level],
JobTitle as [Job Title],
VacationHours as [Vacation Hours],
SickLeaveHours as [Sick Leave Hours]
from HumanResources.Employee
order by [Organization Level], [Vacation Hours] desc;

select OrganizationLevel as [Organization Level],
JobTitle as [Job Title],
VacationHours as [Vacation Hours],
SickLeaveHours as [Sick Leave Hours]
from HumanResources.Employee
order by 1, 3 desc;

-- Distinct

select distinct
PersonType from Person.Person;

select distinct
FirstName,
MiddleName,
LastName
from Person.Person
where MiddleName is not NULL
order by 3,1 ;




