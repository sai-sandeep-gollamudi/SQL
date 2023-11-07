
--IS NULL
select Name, ISNULL(Color,'None') from production.product 
where ISNULL(Weight,0)<10;

--Case
Select Name,
ListPrice,
[Price Category] = 
Case
When ListPrice > 1000 Then 'Premium'
When ListPrice < 1000 and ListPrice > 100 Then 'Mid Range'
Else 'Value'
End
from Production.Product

Select BusinessEntityID,
HireDate,
SalariedFlag,
[Employee Tenure] = 
Case
When SalariedFlag = 1 and DateDiff(year,HireDate, cast('2023-11-08' as Date)) < 10 Then 'Non-Exempt - 10+ Years'
When SalariedFlag = 1 and DateDiff(year,HireDate, cast('2023-11-08' as Date)) > 10 Then 'Non-Exempt -< 10 Years'
When SalariedFlag = 0 and DateDiff(year,HireDate, cast('2023-11-08' as Date)) < 10 Then 'Exempt - 10+ Years'
Else 'Exempt -< 10 Years'
End
from HumanResources.Employee