select P.BusinessEntityID,
P.PersonType,
P.FirstName + 
Case
    when P.MiddleName is Null then ' '
	else ' '+P.MiddleName+' '
end
+P.LastName as [FullName],
A.AddressLine1 as 'Address',
A.City,
A.PostalCode,
S.Name as 'State',
C.Name as 'Country',
isNull(H.JobTitle,'None') as 'JobTitle',
Case
     when H.JobTitle like '%Manager%' or H.JobTitle like '%President%' or H.JobTitle like '%Executive%' then 'Management'
	 when H.JobTitle like '%Engineer%' then 'Engineering'
	 when H.JobTitle like '%Production' then 'Production'
	 when H.JobTitle like '%Marketing%' then 'Marketing'
	 when H.JobTitle is NUll then 'NA'
	 when H.JobTitle in ('Recruiter','Benefits Specialist','Human Resources Administrative Assistant') then 'Human Resources'
	 else 'Other'
end as 'Job Category'
from Person.Person P inner join 
Person.BusinessEntityAddress B on
P.BusinessEntityID = B.BusinessEntityID inner join
Person.Address A on B.AddressID = A.AddressID inner join
Person.StateProvince S on 
S.StateProvinceID = A.StateProvinceID inner join
Person.CountryRegion C on S.CountryRegionCode = C.CountryRegionCode inner join
HumanResources.Employee H on H.BusinessEntityID = P.BusinessEntityID
where P.PersonType = 'SP' or 
(A.PostalCode like '9%' and len(A.PostalCode)=5 and C.Name = 'United States');


Select
DateDiff(Day,GetDate(),
DateAdd(Day,-1,
DateAdd(Month,1,
DATEFROMPARTS(Year(GetDate()),Month(GetDate()),1)))) as 'Days until End of Month';

-- Window functions - over()

Select P.FirstName,
P.LastName,
H.JobTitle,
PA.Rate,
Avg(PA.Rate) over() as 'Average Rate',
Max(PA.Rate) over() as 'Maximum Rate',
[DiffFromAvgRate] = (PA.Rate - Avg(PA.Rate)over()),
[PercentofMaxRate] = ((PA.Rate/Max(PA.Rate)over())*100)
from Person.Person P inner join 
HumanResources.Employee H on
P.BusinessEntityID = H.BusinessEntityID
inner join HumanResources.EmployeePayHistory PA on
H.BusinessEntityID = PA.BusinessEntityID
order by 4 desc;

--Partion By
Select P.Name as 'ProductName',
P.ListPrice,
S.Name as 'ProductSubcategory',
C.Name as 'ProductCategory',
Avg(P.ListPrice) over(Partition by C.Name) as 'AvgPriceByCategory',
Avg(P.ListPrice) over(Partition by C.Name,S.Name) as 'AvgPriceByCategoryAndSubcategory',
(P.ListPrice - Avg(P.ListPrice) over(Partition by C.Name)) as 'ProductVsCategoryDelta'
from Production.Product P inner join
Production.ProductSubcategory S on
P.ProductSubcategoryID = S.ProductSubcategoryID inner join
Production.ProductCategory C on
C.ProductCategoryID = S.ProductCategoryID

