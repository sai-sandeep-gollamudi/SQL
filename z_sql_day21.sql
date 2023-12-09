--Stored Procedure
Create Procedure dbo.OrdersAboveThreshold(@Thres Money, @StartYear Int, @EndYear Int)
As
Begin
      Select S.SalesOrderID,
	  S.OrderDate,
	  S.TotalDue
	  from Sales.SalesOrderHeader S
	  join dbo.Calender C on
	  S.OrderDate = C.DateValue
	  where S.TotalDue > @Thres and C.YearNumber between @StartYear and @EndYear
End

--To execute stored procedure
EXEC OrdersAboveThreshold 15000, 2005, 2015


-- Control Flow

Create Procedure dbo.OrdersAboveThresholdWithIF(@Thres Money, @StartYear Int, @EndYear Int, @OrderType Int)
As
Begin
      IF @OrderType = 1
		  Begin
			  Select S.SalesOrderID,
			  S.OrderDate,
			  S.TotalDue
			  from Sales.SalesOrderHeader S
			  join dbo.Calender C on
			  S.OrderDate = C.DateValue
			  where S.TotalDue > @Thres and C.YearNumber between @StartYear and @EndYear
		 End
	 Else
		 Begin
			 Select P.PurchaseOrderID,
			  P.OrderDate,
			  P.TotalDue
			  from Purchasing.PurchaseOrderHeader P
			  join dbo.Calender C on
			  P.OrderDate = C.DateValue
			  where P.TotalDue > @Thres and C.YearNumber between @StartYear and @EndYear
		 End
End


EXEC OrdersAboveThreshold 15000, 2007, 2014, 1

-- Multiple IF statements

Create Procedure dbo.OrdersAboveThresholdWithIF(@Thres Money, @StartYear Int, @EndYear Int, @OrderType Int)
As
Begin
      IF @OrderType = 1
		  Begin
			  Select S.SalesOrderID,
			  S.OrderDate,
			  S.TotalDue
			  from Sales.SalesOrderHeader S
			  join dbo.Calender C on
			  S.OrderDate = C.DateValue
			  where S.TotalDue > @Thres and C.YearNumber between @StartYear and @EndYear
		 End
	  IF @OrderType = 2
		 Begin
			 Select P.PurchaseOrderID,
			  P.OrderDate,
			  P.TotalDue
			  from Purchasing.PurchaseOrderHeader P
			  join dbo.Calender C on
			  P.OrderDate = C.DateValue
			  where P.TotalDue > @Thres and C.YearNumber between @StartYear and @EndYear
		 End
	  IF @OrderType = 3
	     Begin
		      Select OrderID = S.SalesOrderID,
			  OrderType = 'Sales'
			  S.OrderDate,
			  S.TotalDue
			  from Sales.SalesOrderHeader S
			  join dbo.Calender C on
			  S.OrderDate = C.DateValue
			  where S.TotalDue > @Thres and C.YearNumber between @StartYear and @EndYear

			  Union All

			  Select OrderID = P.PurchaseOrderID,
			  OrderType = 'Purchase'
			  P.OrderDate,
			  P.TotalDue
			  from Purchasing.PurchaseOrderHeader P
			  join dbo.Calender C on
			  P.OrderDate = C.DateValue
			  where P.TotalDue > @Thres and C.YearNumber between @StartYear and @EndYear	
		End
End

