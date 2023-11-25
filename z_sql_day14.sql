--Temp Table
select OrderDate,
DateFromParts(Year(OrderDate),Month(OrderDate),1) as OrderMonth,
TotalDue,
ROW_NUMBER() over( Partition by DateFromParts(Year(OrderDate),Month(OrderDate),1) Order by TotalDue desc) as RankNo
into #sales
from sales.SalesOrderHeader

select OrderMonth,
Sum(TotalDue) as TotalSales
into #WOTop10sales
from #sales
where RankNo>10
group by OrderMonth

select OrderDate,
DateFromParts(Year(OrderDate),Month(OrderDate),1) as OrderMonth,
TotalDue,
ROW_NUMBER() over(Partition by DateFromParts(Year(OrderDate),Month(OrderDate),1) Order by TotalDue desc) as PRankNo
into #purchases
from Purchasing.PurchaseOrderHeader

select OrderMonth,
Sum(TotalDue) as TotalPurchases
into #WOTop10purchases
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
