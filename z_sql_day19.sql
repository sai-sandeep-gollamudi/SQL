-- View

CREATE VIEW Sales.vw_Top10MonthOverMonth AS

WITH Sales AS
(
SELECT 
       OrderDate,
	   OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
       TotalDue,
	   OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM Sales.SalesOrderHeader
)

,Top10Sales AS
(
SELECT
OrderMonth,
Top10Total = SUM(TotalDue)
FROM Sales
WHERE OrderRank <= 10
GROUP BY OrderMonth
)


SELECT
A.OrderMonth,
A.Top10Total,
PrevTop10Total = B.Top10Total

FROM Top10Sales A
	LEFT JOIN Top10Sales B
		ON A.OrderMonth = DATEADD(MONTH,1,B.OrderMonth)

-- Variables

Declare @declaration_example Int
set @declaration_example = 1
select @declaration_example

Declare @declaration_example_2 Int = 2
select @declaration_example_2

Declare @MaxVac Int
Select @MaxVac = (SELECT MAX(VacationHours) FROM HumanResources.Employee)

SELECT
	   BusinessEntityID,
       JobTitle,
       VacationHours,
	   MaxVacationHours = @MaxVac,
	   PercentOfMaxVacationHours = (VacationHours * 1.0) / @MaxVac
FROM HumanResources.Employee
WHERE (VacationHours * 1.0) / @MaxVac >= 0.8

Declare @StartofPay Date

Select @StartofPay = Case
                         When Day(GetDate()) >=15 then DATEFROMPARTS(Year(GetDate()),Month(GetDate())-1,15)
						 Else DATEFROMPARTS(Year(GetDate()),Month(GetDate())-2,15)
                     End

Declare @EndofPay Date
Select @EndofPay = Case
                         When Day(GetDate()) >=15 then DATEFROMPARTS(Year(GetDate()),Month(GetDate()),14)
						 Else DATEFROMPARTS(Year(GetDate()),Month(GetDate())-1,14)
                     End

Select @StartofPay
Select @EndofPay