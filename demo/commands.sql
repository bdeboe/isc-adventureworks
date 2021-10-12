



-- simple grouped aggregates, but how to compare rows?
SELECT EmployeeKey,
    SUM(salesamount) TotalSales,
    SUM(discountamount) TotalDiscount,
    AVG(discountamount / salesamount) AvgDiscount
FROM AdventureWorks.factresellersales f
GROUP BY f.EmployeeKey
ORDER BY 2 DESC
;










-- using "RANK() OVER (...)" syntax to return rank for
-- different sort fields
SELECT EmployeeKey,
    TotalSales,
    RANK() OVER (
        ORDER BY TotalSales DESC
    ) TotalSalesRank,
    TotalDiscount,
    RANK() OVER (
        ORDER BY TotalDiscount DESC
    ) TotalDiscountRank,
    AvgDiscount,
    RANK() OVER (
        ORDER BY AvgDiscount DESC
    ) AvgDiscountRank
FROM (
        SELECT EmployeeKey,
            SUM(salesamount) TotalSales,
            SUM(discountamount) TotalDiscount,
            AVG(discountamount / salesamount) AvgDiscount
        FROM AdventureWorks.factresellersales f
        GROUP BY f.EmployeeKey
    )
ORDER BY TotalSales DESC,
    TotalDiscountRank ASC
;





-- using RANK() OVER (PARTITION BY ...) to look at smaller
-- window instead of whole set
SELECT EmployeeKey,
    FiscalYear,
    TotalSales,
    RANK() OVER (
        PARTITION BY FiscalYear
        ORDER BY TotalSales DESC
    ) TotalSalesRank,
    TotalDiscount,
    RANK() OVER (
        PARTITION BY FiscalYear
        ORDER BY TotalDiscount DESC
    ) TotalDiscountRank,
    AvgDiscount,
    RANK() OVER (
        PARTITION BY FiscalYear
        ORDER BY AvgDiscount DESC
    ) AvgDiscountRank
FROM (
        SELECT EmployeeKey,
            FiscalYear,
            SUM(salesamount) TotalSales,
            SUM(discountamount) TotalDiscount,
            AVG(discountamount / salesamount) AvgDiscount
        FROM AdventureWorks.factresellersales f
            JOIN AdventureWorks.dimdate d ON f.OrderDateKey = d.DateKey
        GROUP BY f.EmployeeKey,
            FiscalYear
    )
ORDER BY EmployeeKey,
    FiscalYear;


-- create table for loading CSV data
CREATE TABLE AdventureWorks.Volatility
(
    Currency VARCHAR(10),
    Volatility DOUBLE,
    CONSTRAINT pk UNIQUE Currency
);



-- load data from CSV file
LOAD DATA 
    FROM FILE 'C:\tmp\demo\CurrencyVolatility.csv'
    INTO AdventureWorks.Volatility
;



SELECT * FROM AdventureWorks.Volatility;









-- create a UDAF based on a simple ITERATE function
-- INITIALIZE, MERGE and FINALIZE are optional
CREATE FUNCTION AdventureWorks.MagicIter(Temp DOUBLE, Amount DOUBLE, Volatility DOUBLE)
    RETURNS DOUBLE
    LANGUAGE ObjectScript
    {
        quit $g(Temp) + $s($g(Amount)>1000:Amount, 1:$g(Amount)*$g(Volatility))
    }
;
CREATE OR REPLACE AGGREGATE AdventureWorks.Magic(Amount DOUBLE, Volatility DOUBLE)
    RETURNS DOUBLE
    ITERATE WITH AdventureWorks.MagicIter
;

-- Now use it to show how volatility affects sales amount
SELECT  Currency,
        AdventureWorks.Magic(salesamount, Volatility) AS AdjustedSales,
        SUM(salesamount) AS TotalSales, 
        AVG(Volatility) AS AvgVolatility
FROM AdventureWorks.FactResellerSales f
    JOIN AdventureWorks.DimCurrency c ON f.CurrencyKey = c.CurrencyKey
    JOIN AdventureWorks.Volatility v ON c.CurrencyAlternateKey = v.Currency
GROUP BY Currency
;


-- the full sandwich
CREATE TABLE AdventureWorks.TheFullSandwich AS
    SELECT EmployeeKey,
        FiscalYear,
        TotalAdjustedSales,
        RANK() OVER ( PARTITION BY FiscalYear ORDER BY TotalAdjustedSales DESC ) TotalAdjSalesRank,
        TotalAdjustedDiscount,
        RANK() OVER ( PARTITION BY FiscalYear ORDER BY TotalAdjustedDiscount DESC ) TotalAdjDiscountRank,
        AvgDiscount,
        RANK() OVER ( PARTITION BY FiscalYear ORDER BY AvgDiscount DESC ) AvgDiscountRank,
        AvgVolatility
    FROM (
            SELECT EmployeeKey,
                FiscalYear,
                AdventureWorks.Magic(SalesAmount, Volatility) TotalAdjustedSales,
                AdventureWorks.Magic(discountamount, Volatility) TotalAdjustedDiscount,
                AVG(discountamount / salesamount) AvgDiscount,
                AVG(Volatility) AvgVolatility
            FROM AdventureWorks.factresellersales f
                JOIN AdventureWorks.dimdate d ON f.OrderDateKey = d.DateKey
                JOIN AdventureWorks.DimCurrency c ON f.CurrencyKey = c.CurrencyKey
                JOIN AdventureWorks.Volatility v ON c.CurrencyAlternateKey = v.Currency
            GROUP BY f.EmployeeKey,
                FiscalYear
        )
;


-- and now materialize results into a table
CREATE TABLE AdventureWorks.SalesLeaderboard AS
...