-- Join Statements
Select P.FirstName,
P.LastName,
E.EmailAddress,
PP.PhoneNumber
from Person.Person P join
Person.EmailAddress E on
P.BusinessEntityId = E.BusinessEntityID join
Person.PersonPhone PP on 
PP.BusinessEntityID = E.BusinessEntityID;

Select P.FirstName,
P.LastName,
E.EmailAddress,
PP.PhoneNumber,
PA.City
from Person.Person P join
Person.EmailAddress E on
P.BusinessEntityId = E.BusinessEntityID join
Person.PersonPhone PP on 
PP.BusinessEntityID = E.BusinessEntityID join
Person.BusinessEntityAddress BE on 
BE.BusinessEntityID = P.BusinessEntityID
join Person.Address PA on
PA.AddressID = BE.AddressID
where PP.PhoneNumber Like '%201%';

Select SP.BusinessEntityID,
SP.SalesQuota,
SP.SalesYTD,
ST.Name as 'TerritoryName'
from Sales.SalesPerson SP
left join Sales.SalesTerritory ST
on SP.TerritoryID = ST.TerritoryID
Where SP.SalesYTD < 2000000;

Select SQH.SalesOrderID,
SQH.OrderDate,
SQH.TotalDue,
[Percent of Sales YTD] = (SQH.TotalDue/SP.SalesYTD)*100
from Sales.SalesOrderHeader SQH left join
Sales.SalesPerson SP on
SQH.SalesPersonID = SP.BusinessEntityID
where SQH.TotalDue > 2000
and SP.SalesYTD < 2000000;

Select P.PurchaseOrderID,
P.PurchaseOrderDetailID,
P.OrderQty,
P.UnitPrice,
P.LineTotal,
POH.OrderDate, 
Case
	When P.OrderQTY > 500 Then 'Large'
	When P.OrderQty > 50 and P.OrderQty<=500 Then 'Medium'
	Else 'Small'
End as OrderSizeCategory,
PP.Name as 'ProductName',
isNull(PS.Name,'None') as 'Subcategory',
isNull(PC.Name,'None') as 'Category'
from Purchasing.PurchaseOrderDetail P join
Purchasing.PurchaseOrderHeader POH on
p.PurchaseOrderID = POH.PurchaseOrderID join
Production.Product PP on
PP.ProductID = P.ProductID left join
Production.ProductSubcategory PS on
PS.ProductSubcategoryID = PP.ProductSubcategoryID
left join Production.ProductCategory PC on
PC.ProductCategoryID = PS.ProductCategoryID
where Month(POH.OrderDate) = 12;





