-- =====================================================
-- SALES & REVENUE INTELLIGENCE ANALYSIS (MySQL)
-- =====================================================
-- 1. DATA PREVIEW
SELECT * FROM supermarket LIMIT 10;

-- =====================================================
-- 2. BUSINESS OVERVIEW
-- =====================================================
-- Total Sales
SELECT SUM(Sales) AS Total_Sales
FROM supermarket;
-- Total Orders
SELECT COUNT(DISTINCT Order_ID) AS Total_Orders
FROM supermarket;
-- Average Shipping Days
SELECT AVG(DATEDIFF(Ship_Date, Order_Date)) AS Avg_Shipping_Days
FROM supermarket;

-- =====================================================
-- 3. REGIONAL ANALYSIS
-- =====================================================
-- Sales by Region
SELECT Region, 
       SUM(Sales) AS Region_Sales
FROM supermarket
GROUP BY Region
ORDER BY Region_Sales DESC;
-- Revenue Contribution %
SELECT 
    Region,
    SUM(Sales) AS Region_Sales,
    ROUND(
        SUM(Sales) * 100 /
        (SELECT SUM(Sales) FROM supermarket),
    2) AS Contribution_Percentage
FROM supermarket
GROUP BY Region
ORDER BY Region_Sales DESC;

-- =====================================================
-- 4. CUSTOMER ANALYSIS
-- =====================================================
-- Revenue by Customer
SELECT 
    Customer_Name,
    SUM(Sales) AS Customer_Revenue
FROM supermarket
GROUP BY Customer_Name
ORDER BY Customer_Revenue DESC;
-- Revenue by Customer
SELECT 
    Customer_Name,
    SUM(Sales) AS Customer_Revenue
FROM supermarket
GROUP BY Customer_Name
ORDER BY Customer_Revenue DESC;

-- =====================================================
-- 5. TIME ANALYSIS
-- =====================================================
-- Monthly Revenue
SELECT 
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    SUM(Sales) AS Monthly_Sales
FROM supermarket
GROUP BY Month
ORDER BY Month;
-- Month-over-Month Growth
WITH Monthly_Sales AS (
    SELECT 
        DATE_FORMAT(Order_Date, '%Y-%m-01') AS Month_Date,
        SUM(Sales) AS Total_Sales
    FROM supermarket
    GROUP BY Month_Date
)

SELECT 
    DATE_FORMAT(Month_Date, '%Y-%m') AS Month,
    Total_Sales,
    LAG(Total_Sales) OVER (ORDER BY Month_Date) AS Previous_Month,
    ROUND(
        (Total_Sales - LAG(Total_Sales) OVER (ORDER BY Month_Date)) 
        / LAG(Total_Sales) OVER (ORDER BY Month_Date) * 100,
    2) AS MoM_Growth_Percentage
FROM Monthly_Sales;
