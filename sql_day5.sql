select BusinessEntityID,
FORMAT(SalesQuota, 'c') as SalesQuota,
FORMAT(Bonus, 'c') as bonus,
FORMAT(CommissionPct, 'p') as Comissionpct
FROM Sales.SalesPerson

SELECT FORMAT(OrderDate, 'yyyy - MM') as OrderYearMonth,
FORMAT(TaxAmt, 'c') as TaxAmt,
FORMAT(Freight, 'c') as Freight,
FORMAT(TotalDue, 'c') as TotalDue
FROM Purchasing.PurchaseOrderHeader
WHERE YEAR(OrderDate) = 2013