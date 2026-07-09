-- 1. Seasonality and Trend Analysis
-- What were the seasonal sales trends over the past three business years, and how did they vary across seasons?

--Using Subquery, Get orders for Year 2018,2019 and 2020
SELECT  [2018].Number,
        LEFT([2018].Month,3) AS Month,
        [2018].Orders AS Orders_2018,
        [2019].Orders AS Orders_2019,
        [2020].Orders AS Orders_2020
FROM (
 ( -- Get Orderss for 2018
   SELECT  MONTH(ORDERDATE) AS Number,
           DATENAME(MONTH, ORDERDATE) AS MONTH, 
           COUNT(*)  AS Orders
   FROM Orders 
   WHERE DATENAME(YEAR, ORDERDATE) = '2018'
   GROUP BY MONTH(ORDERDATE),
            DATENAME(MONTH, ORDERDATE)
)  AS [2018]

JOIN ( --Get Orders for 2019. Join Orders results of 2018 with 2019
     SELECT  MONTH(ORDERDATE) AS Number,
             DATENAME(MONTH, ORDERDATE) AS MONTH, 
             COUNT(*)  AS Orders
     FROM Orders 
     WHERE DATENAME(YEAR, ORDERDATE) = '2019'
     GROUP BY MONTH(ORDERDATE),
              DATENAME(MONTH, ORDERDATE)
) AS [2019]
ON [2018].Number = [2019].Number

JOIN (--Get Orders for 2020. Join Orders results of 2019 with 2020
     SELECT  MONTH(ORDERDATE) AS Number,
             DATENAME(MONTH, ORDERDATE) AS MONTH, 
             COUNT(*)  AS Orders
     FROM Orders 
     WHERE DATENAME(YEAR, ORDERDATE) = '2020'
     GROUP BY MONTH(ORDERDATE),
              DATENAME(MONTH, ORDERDATE)
) AS [2020]
ON [2019].Number = [2020].Number
)

ORDER BY 1 ASC