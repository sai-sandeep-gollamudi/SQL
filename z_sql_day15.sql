-- Temp Table - Create and Insert
Create Table #sales(
OrderDate Date,
OrderMonth Date,
TotalDue Money,
RankNo Int
)

Insert into #sales

select OrderDate,
DateFromParts(Year(OrderDate),Month(OrderDate),1) as OrderMonth,
TotalDue,
ROW_NUMBER() over( Partition by DateFromParts(Year(OrderDate),Month(OrderDate),1) Order by TotalDue desc) as RankNo
from sales.SalesOrderHeader

Create Table #WOTop10sales(
OrderMonth Date,
TotalSales Int
)

Insert into #WOTop10sales

select OrderMonth,
Sum(TotalDue) as TotalSales
from #sales
where RankNo>10
group by OrderMonth

Create Table #purchases(
OrderDate Date,
OrderMonth Date,
TotalDue Int,
PRankNo Int
)

Insert into #purchases
select OrderDate,
DateFromParts(Year(OrderDate),Month(OrderDate),1) as OrderMonth,
TotalDue,
ROW_NUMBER() over(Partition by DateFromParts(Year(OrderDate),Month(OrderDate),1) Order by TotalDue desc) as PRankNo
from Purchasing.PurchaseOrderHeader


Create Table #WOTop10purchases(
OrderMonth Date,
TotalPurchases Int
)

Insert into #WOTop10purchases
select OrderMonth,
Sum(TotalDue) as TotalPurchases
from #purchases
where PRankNo>10
group by OrderMonth

select S.OrderMonth,
S.TotalSales,
P.TotalPurchases
from #WOTop10sales S inner join
#WOTop10purchases P on
S.OrderMonth = P.OrderMonth
Order by 1

Drop Table #Sales
Drop Table #WOTop10sales
Drop Table #Purchases
Drop Table #WOTop10Purchases
