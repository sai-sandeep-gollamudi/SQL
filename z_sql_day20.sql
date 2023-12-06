-- User Defined Functions
create Function dbo.ufnPercentCalculator(@Number1 Int,@Number2 Int)

returns Varchar(10)

As

Begin

       Declare @Ans Float
	   Set @Ans = (@Number1*1.0)/(@Number2)
	   Return Format(@Ans,'P')

End


Declare @MaxVacationHours INT = (Select Max(VacationHours) from HumanResources.Employee)

Select 
BusinessEntityID,
JobTitle,
VacationHours,
PercentOfMaxVacation = dbo.ufnPercentCalculator(VacationHours, @MaxVacationHours)
from HumanResources.Employee

-- Table Valued Functions

select * from Production.Product

Create Function Production.ufn_ProductsByPriceRange(@MinValue Money, @MaxValue Money)
Returns Table
As
Return ( Select ProductID,
         Name,
		 ListPrice
		 from Production.Product
		 where ListPrice between @MinValue and @MaxValue
	   )

Select * from Production.ufn_ProductsByPriceRange(40,120)
