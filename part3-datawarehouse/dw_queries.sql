-- 3.1 — Star Schema Design
-- Q1: Total sales revenue by product category for each month
use retail_transactions;
SELECT 
    dd.year,
    dd.month_name,
    dp.category,
    SUM(ft.units_sold * ft.unit_price) AS total_revenue
FROM fact_transaction ft
JOIN dim_date dd 
    ON ft.date_id = dd.date_id
JOIN dim_product dp 
    ON ft.product_id = dp.product_id
GROUP BY dd.year, dd.month, dd.month_name, dp.category
ORDER BY dd.year, dd.month, dp.category;

-- Q2: Top 2 performing stores by total revenue
SELECT 
    ds.store_name,
    SUM(ft.units_sold * ft.unit_price) AS total_revenue
FROM fact_transaction ft
JOIN dim_store ds 
    ON ft.store_id = ds.store_id
GROUP BY ds.store_name
ORDER BY total_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
use retail_transactions;
SELECT 
    dd.year,
    dd.month,
    dd.month_name,
    SUM(ft.units_sold * ft.unit_price) AS monthly_sales
FROM fact_transaction ft
JOIN dim_date dd 
    ON ft.date_id = dd.date_id
GROUP BY dd.year, dd.month, dd.month_name
ORDER BY dd.year, dd.month;


