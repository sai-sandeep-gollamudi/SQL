--Union
select 
PurchaseOrderID as OrderID,
PurchaseOrderDetailID as OrderDetailID,
OrderQty,
LineTotal,
RunDate = GETDATE(),
OrderType = 'Purchase'
from Purchasing.PurchaseOrderDetail
where LineTotal > 10000
Union
select SalesOrderID,
SalesOrderDetailID,
OrderQty,
LineTotal,
RunDate = GETDATE(),
OrderType = 'Sale'
from Sales.SalesOrderDetail
where LineTotal > 10000

--- Join
Select
P.FirstName,
P.LastName,
E.EmailAddress
from Person.Person P Join
Person.EmailAddress E on
P.BusinessEntityID = E.BusinessEntityID

Select
P.Name,
P.ListPrice,
R.ReviewerName,
R.Comments
from Production.Product P join
Production.ProductReview R
on P.ProductID = R.ProductID