# 🛒 Retail Sales Intelligence
## Stakeholder-Driven Sales & Customer Analytics with SQL Server & Excel

---
## 📖 Executive Summary

Modern retail organizations generate enormous volumes of transactional data across customers, products, stores, and sales channels. While this data holds significant strategic value, it often remains underutilized without structured analysis.

This project explores a global retail dataset using **SQL Server** and **Microsoft Excel** to uncover meaningful business insights that support strategic decision-making. The analysis focuses on understanding customer purchasing behaviour, sales trends, product performance, profitability, and geographic sales distribution.

The findings provide actionable recommendations that can help retail executives optimize inventory planning, improve customer retention, increase profitability, and identify opportunities for market expansion.

---

## 🎯 Business Objective

The objective of this project is to transform raw retail transaction data into meaningful business intelligence by answering key stakeholder questions using SQL and Excel.

Specifically, the analysis aims to:

- Identify historical sales trends and seasonal demand patterns.
- Evaluate product and category performance.
- Discover customer purchasing behaviours and loyalty patterns.
- Assess geographical sales performance.
- Provide actionable recommendations for improving business performance.

---


## 📂 Dataset Overview

**Source**

- Maven Analytics

The original dataset contained all business processes in a single denormalized table.

To improve analytical accuracy and database performance, the dataset was transformed into a **Snowflake Schema**, eliminating duplicate records and separating transactional data from descriptive attributes.

This restructuring significantly improved:

- Query performance
- Data integrity
- Scalability
- Analytical accuracy
- Report reliability

---

## 🏗️ Dimensioned Tables

### 👥 Customers

This table contains all information related to customers such as:

- CustomerID
- Name
- Gender
- Date of Birth
- City
- State
- Country

**Relationship:** Connects to the **Orders** table using the **CustomerID** column.

---

### 📦 Orders

This table contains information at the order level such as:

- OrderNumber
- Order Date
- Delivery Date
- CustomerID
- StoreID

**Relationship:** Filters the **Transactions Fact** table using the **OrderNumber** column.

---

### 🧾 Transactions Fact

This table contains atomic transaction records at the lowest level.

Attributes include:

- TransactionID
- OrderNumber
- LineItem
- Quantity
- ProductID

---

### 🏬 Stores

Contains information about all the stores and their locations where customers placed orders and had them shipped.

**Relationship:** Relates to the **Orders** table using the **StoreID**.

---

### 🛍️ Product

This table contains all information about products on sale.

Attributes include:

- ProductID
- ProductName
- ProductBrand
- ProductColor
- ProductCost
- ProductPrice
- ProductSubCategoryID

**Relationship:** Filters the **Transactions Fact** table using the **ProductID** column.

## 📌 Next Section

The following sections explore the business questions answered throughout this analysis, including:

- 📈 Sales Trend Analysis
- 🛍 Product Performance
- 🌍 Geographic Analysis
- 👥 Customer Insights
- 💡 Key Findings
- 🚀 Strategic Recommendations


## 1. Seasonality & Trend Analysis

What were the seasonal sales trends over the past three business years, and how did they vary across seasons?

![Order Trend by Month sql table](assets/Order_by_month_of%20_the_Year_csv.png)

![Order Trend by Month chart](assets/Orders_2018_2019_2020_Chart.png)

*Figure 1: Monthly order trends across the three business years*

### 💡 Key Insight

- **2019 recorded the highest order volumes** across most months, particularly during the second half of the year, making it the strongest-performing year in the analysis period. This suggests that favorable business strategies or market conditions positively influenced sales performance.

- **Sales in 2020 trailed both 2018 and 2019** across most months, with a noticeable decline in the latter part of the year. This trend may reflect the impact of global economic disruptions, including the COVID-19 pandemic, on consumer spending and supply chain operations.

- **Monthly demand followed a consistent seasonal pattern** across all three years. Sales began strongly in **January and February**, indicating robust customer demand at the start of each year.

- A **significant decline in order volumes** was observed between **March and May** across all years. This recurring trend may be attributed to seasonal fluctuations, reduced consumer demand, or other external business factors.

- **Sales activity rebounded considerably between October and December**, particularly in **2019**, suggesting a strong correlation with holiday shopping and year-end promotional campaigns.

### 1b. How did order volumes fluctuate across the four seasons of the year?

![Order Trend in Summer, Winter, Autumn & Spring](assets/Orders_by_Season_of_the_year_sql.png)

![Order Trend in Summer, Winter, Autumn & Spring](assets/Orders_by_Season_of_the_year_Chart.png)

*Figure 1b: Order by seasons of the year*

In 2018, Winter and Autumn emerged as the dominant seasons for orders, collectively driving the highest order volumes for the year. 

By 2019, which stands out as the most successful business year among the three, Winter and Autumn persist and maintained their position as the leading seasons, with Summer following closely in third place. In 2020, Winter once again outperformed all other seasons, solidifying its status as the peak period for sales. Across the three years, Winter consistently proved to be the most high-demand season, while Autumn also showed strong performance in 2018 and 2019, reinforcing its significance as a critical sales period.


### 1c. Which days of the week consistently account for the highest demand and sales?

![Orders trends per day of the week[2018-200]](assets/Orders_by_Day_of_the_week_sql.png)

![Orders trends per day of the week[2018-200]](assets/Orders_by_Day_of_the_week_Charts.png)

The chart reveals a consistent rise in order volumes throughout the week across 2018, 2019, and 2020. Sundays consistently record the lowest order volumes, while order numbers steadily increase, peaking on Saturdays. However, the highest demand days across the three years are Wednesdays, Thursdays, and Fridays, demonstrating consistent midweek and weekend activity.

# 🛠 Tech Stack

| Technology | Purpose |
|------------|---------|
| SQL Server | Data Extraction & Analysis |
| Microsoft Excel | Data Exploration & Visualization |
| T-SQL | Business Query Development |
| Snowflake Schema | Database Design |
| GitHub | Portfolio Documentation |