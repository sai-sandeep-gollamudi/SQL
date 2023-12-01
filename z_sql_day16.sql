-- Temp Table - Update

Create table #SalesOrders(
SalesOrderID INT,
 OrderDate DATE,
 TaxAmt MONEY,
 Freight MONEY,
 TotalDue MONEY,
 TaxFreightPercent FLOAT,
 TaxFreightBucket VARCHAR(32),
 OrderAmtBucket VARCHAR(32),
 OrderCategory VARCHAR(32),
 OrderSubcategory VARCHAR(32)
 )

 Insert into #SalesOrders(
 SalesOrderID,
 OrderDate,
 TaxAmt,
 Freight,
 TotalDue,
 OrderCategory
 )

 Select SalesOrderID,
 OrderDate,
 TaxAmt,
 Freight,
 TotalDue,
 OrderCategory = 'Non-holiday Order'
 From Sales.SalesOrderHeader
 where year(OrderDate) = 2013

Update #SalesOrders
SET
TaxFreightPercent = (TaxAmt + Freight)/TotalDue,
OrderAmtBucket = 
CASE
    When TotalDue < 100 Then 'Small'
	When TotalDue < 1000 Then 'Medium'
	Else 'Large'
End

Update #SalesOrders
Set
TaxFreightBucket = 
Case
    when TaxFreightPercent < 0.1 Then 'Small'
	when TaxFreightPercent < 0.2 Then 'Medium'
	Else 'Large'
End

Update #SalesOrders
Set
OrderSubcategory = 'Holiday'
where DatePart(quarter,OrderDate) = 4

Update #SalesOrders
Set
OrderSubcategory = [OrderCategory] + ' - ' + [OrderAmtBucket]

Drop Table #SalesOrders

