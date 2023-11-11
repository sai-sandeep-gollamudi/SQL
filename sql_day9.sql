--Aggregate Functions
select count(*) as 'Num of records' from Purchasing.PurchaseOrderHeader where TotalDue > 20000;

select sum(TotalDue) as 'Sum' from Purchasing.PurchaseOrderHeader;

select Max(TotalDue) as 'Max Value' from Purchasing.PurchaseOrderHeader;

select Avg(SubTotal + Freight) as 'Avg' from Purchasing.PurchaseOrderHeader;

--Group By

select isNULL(Color,'No Color') as Color, isNULL(Style,'NA') as Style, count(*) as 'Count' from Production.Product
Group by Color, Style;

select FirstName, count(*) as 'Count' from Person.Person
Group by FirstName
Having count(*) > 50
order by 2 desc;

Select P.Name,
Sum(PP.LineTotal) as [Total Sales],
count(*) as [Count of Sales]
from Production.Product P
inner join Purchasing.PurchaseOrderDetail PP
on P.ProductID = PP.ProductID
where P.Name not like '%[0-9]%'
Group by P.Name
Having Sum(PP.LineTotal) < 10000
order by 2;

--String Agg

Select Distinct S.SalesOrderID,
Sum(S.LineTotal) as OrderTotal,
STRING_AGG(P.Name,', ') as ProductList
from Sales.SalesOrderDetail S inner join 
Production.Product P on
S.ProductID = P.ProductID
group by S.SalesOrderID
Having Sum(S.LineTotal) > 5000;