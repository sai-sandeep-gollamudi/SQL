--Scalar subqueries
Select BusinessEntityID,
JobTitle,
VacationHours,
(select Max(VacationHours) from HumanResources.Employee) as 'MaxVacationHours',
PercentComparedtoMax = (VacationHours*1.0)/(select Max(VacationHours) from HumanResources.Employee)
from HumanResources.Employee
where (VacationHours*1.0)/(select Max(VacationHours) from HumanResources.Employee) >= 0.8

--Correlated subqueries
Select PurchaseOrderID,
VendorID,
OrderDate,
TotalDue,
NonRejectedItems = (Select count(*) from Purchasing.PurchaseOrderDetail b where b.PurchaseOrderID = a.PurchaseOrderID and b.RejectedQty=0),
MostExpensiveItem = (Select Max(c.UnitPrice) from Purchasing.PurchaseOrderDetail c where c.PurchaseOrderID = a.PurchaseOrderID)
from Purchasing.PurchaseOrderHeader a

--Exists
Select PurchaseOrderID,
OrderDate,
SubTotal,
TaxAmt
from Purchasing.PurchaseOrderHeader a
where Exists (select 1 from Purchasing.PurchaseOrderDetail b 
                where a.PurchaseOrderID = b.PurchaseOrderID
				and b.OrderQty > 500
)
order by 1;

select * from Purchasing.PurchaseOrderHeader a
where Exists (select 1 from Purchasing.PurchaseOrderDetail b 
                where a.PurchaseOrderID = b.PurchaseOrderID
				and b.OrderQty > 500 and b.UnitPrice > 50
)

select * from Purchasing.PurchaseOrderHeader a
where Not Exists (select * from Purchasing.PurchaseOrderDetail b
              where a.PurchaseOrderID = b.PurchaseOrderID
			  and b.RejectedQty>0)
