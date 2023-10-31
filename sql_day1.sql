--Select statements
select Top(3000) Title,
LastName,FirstName from
AdventureWorks2022.Person.Person;


select Top(500) OrderDate,
DueDate,ShipDate,TotalDue from
AdventureWorks2022.Sales.SalesOrderHeader

select Top(100) SalesLastYear,
SalesYTD from AdventureWorks2022.Sales.SalesPerson


--Aliasing

select [Name] as [Product Name],
ListPrice as [List Price $$]
from AdventureWorks2022.Production.Product;

select PurchaseOrderID as OrderID, OrderQty as OrderQuantity,
LineTotal from AdventureWorks2022.Purchasing.PurchaseOrderDetail


--Custom values

Select [Name] = 'Sandeep', Age = 27;

SELECT TOP (5000) 
      [Query Run By] = 'Sandeep'
	  ,[SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[TerritoryID]
      ,[BillToAddressID]
      ,[ShipToAddressID]
      ,[ShipMethodID]
      ,[CreditCardID]
      ,[CreditCardApprovalCode]
      ,[CurrencyRateID]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
      ,[Comment]
  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]


  Select Top(100) * from AdventureWorks2022.Production.Product;