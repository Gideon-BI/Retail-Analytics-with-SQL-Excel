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