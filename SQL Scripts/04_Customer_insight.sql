-- 4a. Who are the top customers by total spending, and what is their demographic profile (age, gender, location)?

-- Calculate the current age of each customer
WITH CustomerDemographics AS (
    SELECT 
        CustomerID,
        Name,
        Gender,
        Country,
        State,
        City,
        DATEDIFF(YEAR, Date_of_Birth, GETDATE()) AS Age
    FROM 
        Customers
),

-- Calculate total spending for each customer
CustomerSpending AS (
    SELECT 
        o.CustomerID,
        SUM(tf.Quantity * p.ProductPrice) AS TotalSpending
    FROM 
        [Transactions Fact] tf
    JOIN 
        Product p ON tf.ProductID = p.ProductID
    JOIN 
        Orders o ON tf.OrderNumber = o.OrderNumber
    GROUP BY 
        o.CustomerID
)

-- Join the customer demographics with spending data to get the final result
SELECT 
    TOP 10 cd.Name AS CustomerName,
    cd.Age,
    cd.Gender,
    cd.Country,
    cd.State,
    cd.City,
    ROUND(cs.TotalSpending,2) AS Total_Spend
FROM 
    CustomerDemographics cd
JOIN 
    CustomerSpending cs ON cd.CustomerID = cs.CustomerID
ORDER BY 
    cs.TotalSpending DESC;



-- 4b. Who are the top customers by Most Orders or repeated patronage, and what is their demographic profile (age, gender, location)?

--- Customers with repeated patronage

SELECT TOP 20 
    O.CustomerID,
    C.Name,
    C.Gender,
    DATEDIFF(YEAR, C.Date_of_Birth, GETDATE()) AS Age,
    C.Country,
    C.State,
    C.City,
    COUNT(DISTINCT O.OrdeRNUMBER) AS PurchaseCount
FROM 
     Orders AS O
JOIN 
    Customers AS C ON O.CustomerID = C.CustomerID
GROUP BY  O.CustomerID,
        C.Name,
        C.Gender,
        C.Country,
        C.State,
        C.City,
        DATEDIFF(YEAR, C.Date_of_Birth, GETDATE())
HAVING 
      COUNT(DISTINCT OrderNUMBER) > 1
ORDER BY 8 DESC


-- 4c. What’s the average Order value by age Category or groups.

-- Average Order Value By Age Category or groups
SELECT 
      CASE
         WHEN DATEDIFF(YEAR, Date_of_Birth, GetDate()) < 25 THEN 'Under 25'
         WHEN DATEDIFF(YEAR, Date_of_Birth, GetDate()) BETWEEN 26 AND 30 THEN '26-30 Years'
         WHEN DATEDIFF(YEAR, Date_of_Birth, GetDate()) BETWEEN 31 AND 40 THEN '31-40 Years '
         WHEN DATEDIFF(YEAR, Date_of_Birth, GetDate()) BETWEEN 41 AND 50 THEN '41-50 Years'
         WHEN DATEDIFF(YEAR, Date_of_Birth, GetDate()) BETWEEN 51 AND 60 THEN '51-60 Years'
         WHEN DATEDIFF(YEAR, Date_of_Birth, GetDate()) BETWEEN 61 AND 70 THEN '61-70 Years'
         ELSE '71+ Years'
       END AS [Age Group],
 ROUND(AVG([Transactions Fact].Quantity * Product.ProductPrice),2) AS [Average Order Value]
 FROM Customers
 JOIN Orders ON Orders.CustomerID = Customers.CustomerID
 JOIN [Transactions Fact] ON [Transactions Fact].OrderNumber = Orders.OrderNUmber
 JOIN product ON Product.ProductID = [Transactions Fact].ProductID
 GROUP BY
      CASE
         WHEN DATEDIFF(YEAR, Date_of_Birth, GetDate()) < 25 THEN 'Under 25'
         WHEN DATEDIFF(YEAR, Date_of_Birth, GetDate()) BETWEEN 26 AND 30 THEN '26-30 Years'
         WHEN DATEDIFF(YEAR, Date_of_Birth, GetDate()) BETWEEN 31 AND 40 THEN '31-40 Years '
         WHEN DATEDIFF(YEAR, Date_of_Birth, GetDate()) BETWEEN 41 AND 50 THEN '41-50 Years'
         WHEN DATEDIFF(YEAR, Date_of_Birth, GetDate()) BETWEEN 51 AND 60 THEN '51-60 Years'
         WHEN DATEDIFF(YEAR, Date_of_Birth, GetDate()) BETWEEN 61 AND 70 THEN '61-70 Years'
         ELSE '71+ Years'
      END 
 ORDER BY 2 DESC