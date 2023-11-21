-- Row number
Select 
P.Name as 'ProductName',
P.ListPrice,
PS.Name as 'ProductSubcategory',
PC.Name as 'ProductCategory',
row_number() over(order by P.ListPrice desc) as 'Price Rank',
row_number() over(Partition by PC.Name Order by P.ListPrice desc) as [Category Price Rank],
Case
     when row_number() over(Partition by PC.Name Order by P.ListPrice desc) <=5 then 'Yes'
	 else 'No'
end as 'Top 5 Price In Category'
from
Production.Product P inner join
Production.ProductSubcategory PS on
P.ProductSubcategoryID = PS.ProductSubcategoryID
inner join Production.ProductCategory PC on
PC.ProductCategoryID = PS.ProductCategoryID;

--Rank and Dense Rank
Select 
P.Name as 'ProductName',
P.ListPrice,
PS.Name as 'ProductSubcategory',
PC.Name as 'ProductCategory',
row_number() over(order by P.ListPrice desc) as 'Price Rank',
row_number() over(Partition by PC.Name Order by P.ListPrice desc) as [Category Price Rank],
rank() over(Partition by PC.Name order by P.ListPrice desc) as 'Category Price Rank with Rank',
dense_rank() over(Partition by PC.Name order by P.ListPrice desc) as 'Category Price Rank with Dense Rank',
Case
     when dense_rank() over(Partition by PC.Name order by P.ListPrice desc) <=5 then 'Yes'
	 else 'No'
end as 'Top 5 Price In Category'
from
Production.Product P inner join
Production.ProductSubcategory PS on
P.ProductSubcategoryID = PS.ProductSubcategoryID
inner join Production.ProductCategory PC on
PC.ProductCategoryID = PS.ProductCategoryID;

-- Lead and Lag
select PH.PurchaseOrderID,
PH.OrderDate,
PH.TotalDue,
Lag(PH.TotalDue,1) over(partition by PH.vendorID order by PH.OrderDate) as 'PrevOrderFromVendorAmt',
Lead(V.Name,1) over(partition by PH.EmployeeID order by PH.OrderDate) as 'NextOrderByEmployeeVendor',
Lead(V.Name,2) over(partition by PH.EmployeeID order by PH.OrderDate) as 'Next2OrderByEmployeeVendor',
V.Name as 'Vendor Name' from
Purchasing.PurchaseOrderHeader PH inner join
Purchasing.Vendor V on
PH.VendorID = V.BusinessEntityID
where year(PH.OrderDate) >=2013 and PH.TotalDue>500
order by PH.EmployeeID;

-- First value
Select BusinessEntityID as 'Employee ID',
JobTitle,
HireDate,
VacationHours,
FIRST_VALUE(VacationHours) over(Partition by JobTitle order by HireDate) as 'FirstHireVacationHours'
from
HumanResources.Employee
order by JobTitle, HireDate

Select P.ProductID,
P.Name,
PH.ListPrice,
PH.ModifiedDate,
first_value(PH.ListPrice) over(Partition by P.ProductID order by PH.ListPrice desc) as 'HighestPrice',
first_value(PH.ListPrice) over(Partition by P.ProductID order by PH.ListPrice) as 'LowestPrice',
(first_value(PH.ListPrice) over(Partition by P.ProductID order by PH.ListPrice desc) - 
first_value(PH.ListPrice) over(Partition by P.ProductID order by PH.ListPrice)) as 'PriceRange'
from
Production.Product P inner join
Production.ProductListPriceHistory PH on
P.ProductID = PH.ProductID
order by P.ProductID,PH.ModifiedDate

--Subquery
select PurchaseOrderId,
VendorId,
OrderDate,
TaxAmt,
Freight,
TotalDue from (
		select PurchaseOrderId,
		VendorId,
		OrderDate,
		TaxAmt,
		Freight,
		TotalDue,
		dense_rank() over(Partition by VendorId order by TotalDue desc) as [wrank]
		from Purchasing.PurchaseOrderHeader) A
where A.wrank<=3

-- Rows between
select OrderMonth,
OrderYear,
SubTotal,
sum(SubTotal) over(order by OrderYear, OrderMonth rows between 2 preceding and current row) as 'Rolling 3 Months Total',
avg(SubTotal) over(order by OrderYear, OrderMonth rows between 6 preceding and 1 Preceding) as 'MovingAvg6Months',
avg(SubTotal) over(order by OrderYear, OrderMonth rows between current row and 2 following) as 'MovingAvgNext2Months'
from(
	select Month(OrderDate) as [OrderMonth],
	Year(OrderDate) as [OrderYear],
	sum(SubTotal) as 'SubTotal'
	from
	Purchasing.PurchaseOrderHeader
	group by MONTH(OrderDate),Year(OrderDate)
) A