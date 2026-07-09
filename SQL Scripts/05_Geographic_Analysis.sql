-- 5a.Which Countries contributed most in sales?

SELECT  C.Country,
        SUM(TF.Quantity) AS [Total Sales],
        ROUND(CAST(SUM(TF.Quantity)*100.0/
                (SELECT SUM(TF.Quantity)
                 FROM [Transactions Fact] AS TF
                 ) AS FLOAT),2) AS [Total Sales in %]
 
FROM Customers AS C
JOIN Orders AS O ON O.CustomerID = C.CustomerID
JOIN [Transactions Fact] AS TF ON TF.OrderNumber = O.OrderNumber
JOIN Product AS P ON P.ProductID = TF.ProductID 
GROUP BY C.Country
ORDER BY 2 DESC

-- 5b. Which Countries generated the highest revenue?

SELECT  C.Country,
        ROUND(SUM(TF.Quantity * P.ProductPrice),2) AS [Total Revenue],
        ROUND(SUM(TF.Quantity * P.ProductPrice)*100.0/
                   (SELECT SUM(TF.Quantity * P.ProductPrice) AS Total_Rev
                    FROM [Transactions Fact] AS TF
                    JOIN Product AS P ON P.ProductID = TF.ProductID 
                   ), 2) AS [Total Revenue in %]
 
FROM Customers AS C
JOIN Orders AS O ON O.CustomerID = C.CustomerID
JOIN [Transactions Fact] AS TF ON TF.OrderNumber = O.OrderNumber
JOIN Product AS P ON P.ProductID = TF.ProductID 
GROUP BY C.Country
ORDER BY 2 DESC