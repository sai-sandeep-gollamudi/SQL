-- Pivot 
select * from 
(select VacationHours,
JobTitle
from HumanResources.Employee
) A
Pivot(
Avg(VacationHours)
for JobTitle in ([Sales Representative],[Buyer],[Janitor])
) B

select * from 
(select VacationHours,
JobTitle,
Gender from
HumanResources.Employee) A
Pivot(
Avg(VacationHours) for
JobTitle in ([Sales Representative],[Buyer],[Janitor])
)B

--CTE (Common Table Expressions)

With Sales_data as (
select OrderDate,
DateFromParts(year(OrderDate),Month(OrderDate),1) as OrderMonth,
TotalDue,
ROW_NUMBER() over(Partition by DateFromParts(year(OrderDate),Month(OrderDate),1) order by TotalDue desc) as RankNo
from Sales.SalesOrderHeader),

MinusTop10 as (
select OrderMonth,
Sum(TotalDue) as Total_sales from Sales_data where
RankNo>10 group by OrderMonth),

Purchase_data as(
select OrderDate,
DateFromParts(year(OrderDate),Month(OrderDate),1) as OrderMonth,
TotalDue,
ROW_NUMBER() over(Partition by DateFromParts(year(OrderDate),Month(OrderDate),1) order by TotalDue desc) as PRankNo
from Purchasing.PurchaseOrderHeader),

PMinusTop10 as (
select OrderMonth,
Sum(TotalDue) as Total_purchases from Purchase_data where
PRankNo > 10 group by OrderMonth)

select S.OrderMonth,
S.Total_sales,
P.Total_purchases
from MinusTop10 S inner join
PMinusTop10 P on
s.OrderMonth = P.OrderMonth
order by 1

-- Recursive CTE

with OddNumberList as (
select 1 as odd_number

union all

select odd_number+2 as odd_number 
from OddNumberList
where odd_number < 99
)

select * from OddNumberList

with StartofMonth as (
select Cast('01-01-2020' as Date) as FirstDayOfMonth

Union All

select DATEADD(Month,1,FirstDayOfMonth)
from StartofMonth
where FirstDayOfMonth < cast('12-01-2029' as Date)
)

select * from StartofMonth
Option(MaxRecursion 120)

