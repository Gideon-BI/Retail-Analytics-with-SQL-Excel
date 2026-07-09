-- 2a. Which product subcategories contribute the most to overall revenue?

-- Revenue By Subcategores Only 
SELECT TOP 10 
      SubCategory.ProductSubcategory As Subcategories,
      ROUND(CAST(SUM([Transactions Fact].quantity * Product.ProductPrice) AS FLOAT),2) AS [Gross Revenue],
      ROUND(CAST(SUM([Transactions Fact].quantity * Product.ProductPrice) * 100.0 /
        ( SELECT SUM([Transactions Fact].quantity * Product.ProductPrice) AS [Gross Revenue] 
          FROM [Transactions Fact]
          JOIN Product ON [Transactions Fact].ProductID = Product.ProductID
        )AS FLOAT),2) AS [Gross Revenue in %]
FROM Product 
JOIN [Transactions Fact] ON [Transactions Fact].ProductID = Product.ProductID
JOIN Subcategory ON Product.ProductSubCategoryID = Subcategory.ProductSubcategoryID
GROUP BY SubCategory.ProductSubCategory
ORDER BY 2 DESC


-- 2b. Which product categories are most effective at driving repeat purchases?

WITH RepeatCustomers AS ( -- Identify Customers with repeated Sales
   SELECT 
        O.CustomerID,
        COUNT(DISTINCT O.OrderNumber) AS PurchaseCount
   FROM Orders AS O
   GROUP BY O.CustomerID 
   HAVING COUNT(DISTINCT O.OrderNumber)> 1
),

-- Get Orders Placed by repeat customers
RepeatOrders AS (
  SELECT Rc.CustomerID, 
          O.OrderNumber
  FROM Orders O
  JOIN RepeatCustomers rc ON rc.CustomerID = O.CustomerID
 ),

ProductRepeatCategories AS (
-- Map  Repeated Orders to Product Categories
SELECT
    ro.OrderNumber, 
    C.ProductCategory AS "Product Category"
FROM  RepeatOrders AS ro
JOIN [Transactions Fact] AS TF ON TF.OrderNumber = ro.OrderNumber
JOIN Product AS P ON TF.ProductID = P.ProductID
JOIN Subcategory AS SC  ON SC.ProductSubCategoryID = P.ProductSubCategoryID
JOIN Category AS C ON C.ProductCategoryID  =  SC.ProductCategoryID
)

-- Count the frequency of each product category in repeat purchases
SELECT pr.[Product Category],
      COUNT(*) AS [Total Orders],
      ROUND(CAST(COUNT(*) *100.0/(SELECT COUNT(*) 
          FROM ProductRepeatCategories
          ) AS FLOAT),2) AS [Total Orders in %]
FROM ProductRepeatCategories AS pr
GROUP BY pr.[Product Category]
ORDER BY 2 DESC


-- 2c. Which products are the most profitable based on the difference between product cost and product price?

SELECT TOP 10 Product,
       SUM(Revenue - [Total Production Cost]) AS Profit,
       ROUND((SUM(Revenue - [Total Production Cost]) * 100.0) /
       (SELECT SUM(Revenue - [Total Production Cost])
        FROM (
            SELECT  ROUND(SUM([Transactions Fact].Quantity * Product.ProductCost), 2) AS [Total Production Cost],
            ROUND(SUM([Transactions Fact].Quantity * Product.ProductPrice), 2) AS Revenue
            FROM [Transactions Fact]
            JOIN Product ON [Transactions Fact].ProductID = Product.ProductID
               GROUP BY Product.ProductName
            ) AS Subquery),2) AS [Profit in %]

FROM (
    SELECT Product.ProductName AS Product,
           ROUND(SUM([Transactions Fact].Quantity * Product.ProductCost), 2) AS [Total Production Cost],
           ROUND(SUM([Transactions Fact].Quantity * Product.ProductPrice), 2) AS Revenue
    FROM [Transactions Fact]
    JOIN Product ON [Transactions Fact].ProductID = Product.ProductID
    GROUP BY Product.ProductName
) AS Product_Cost_Plus_Revenue
GROUP BY Product
ORDER BY Profit DESC;

