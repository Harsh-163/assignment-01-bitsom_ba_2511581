## Part 5 — Data Lakes & DuckDB
## 5.1 — Cross-Format Queries
    
-- These queries were executed using DuckDB in Python (VS Code environment).

-- Q1: List all customers along with the total number of orders they have placed
import duckdb
duckdb.query("""
SELECT 
    c.customer_id,
    c.name AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM read_csv_auto('datasets/customers.csv') c
LEFT JOIN read_json_auto('datasets/orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC
""").show()

-- Q2: Find the top 3 customers by total order value
import duckdb
duckdb.query("""
SELECT 
    c.customer_id,
    c.name AS customer_name,
    SUM(CAST(o.total_amount AS DOUBLE)) AS total_value
FROM read_csv_auto('datasets/customers.csv') c
JOIN read_json_auto('datasets/orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_value DESC
LIMIT 3
""").show()

-- Q3: List all products purchased by customers from Bangalore
import duckdb
duckdb.query("""
SELECT DISTINCT
    c.customer_id,
    c.name AS customer_name,
    p.product_name
FROM read_csv_auto('datasets/customers.csv') c
JOIN read_json_auto('datasets/orders.json') o
    ON c.customer_id = o.customer_id
JOIN read_parquet('datasets/products.parquet') p
    ON o.order_id = p.order_id
WHERE c.city = 'Bangalore'
ORDER BY c.name
""").show()


-- Q4: Join all three files to show: customer name, order date, product name, and quantity
import duckdb
duckdb.query("""
SELECT 
   c.name AS customer_name,
    o.order_date,
    p.product_name,
    p.quantity
FROM read_csv_auto('datasets/customers.csv') c
JOIN read_json_auto('datasets/orders.json') o
    ON c.customer_id = o.customer_id
JOIN read_parquet('datasets/products.parquet') p
    ON o.order_id = p.order_id
ORDER BY o.order_date DESC
""").show()


