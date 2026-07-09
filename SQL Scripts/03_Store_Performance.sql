-- 3. How did different store locations perform in terms of sales volume and revenue?

SELECT   Stores.StoreCountry,
        -- For Sales Volume
        SUM([Transactions Fact].Quantity) AS [Total Sales Volume],
        ROUND(CAST(SUM([Transactions Fact].Quantity)*100.0 /
          (SELECT SUM([Transactions Fact].Quantity) AS [Total Quantity Sold]
          FROM [Transactions Fact] ) AS FLOAT),2) AS [Sales Volume in %],
        
        -- For Revenue
        ROUND(CAST (SUM([Transactions Fact].Quantity * Product.ProductPrice) AS FLOAT),2) AS [Gross Revenue],
        ROUND(CAST(SUM([Transactions Fact].Quantity * Product.ProductPrice)*100.0 /
          (SELECT SUM([Transactions Fact].Quantity * Product.ProductPrice) 
           FROM [Transactions Fact] 
           JOIN Product ON [Transactions Fact].ProductID = Product.ProductID
        ) AS FLOAT),2) AS [Gross Revenue in %]
FROM [Transactions Fact]
JOIN Orders ON [Transactions Fact].OrderNumber = Orders.OrderNumber
JOIN Product ON [Transactions Fact].ProductID = Product.ProductID
JOIN Stores ON Orders.StoreID = Stores.StoreID
GROUP BY Stores.StoreCountry
ORDER BY 2 DESC