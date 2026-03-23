-- Q1: List all customers from Mumbai along with their total order value
SELECT c.customer_name, SUM(p.unit_price * oi.quantity) AS total_value
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE c.customer_city = 'Mumbai'
GROUP BY c.customer_name;

-- Q2: Top 3 products by total quantity sold
SELECT p.product_name, SUM(oi.quantity) AS total_qty
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_qty DESC
LIMIT 3;

-- Q3: List all sales representatives and number of unique customers they handled
SELECT s.sales_rep_name, COUNT(DISTINCT o.customer_id) AS unique_customers
FROM SalesReps s
LEFT JOIN Orders o ON s.sales_rep_id = o.sales_rep_id
GROUP BY s.sales_rep_name;

-- Q4: Find all orders where total value > 10,000 sorted desc
SELECT o.order_id,
       SUM(p.unit_price * oi.quantity) AS total_value
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY o.order_id
HAVING SUM(p.unit_price * oi.quantity) > 10000
ORDER BY total_value DESC;

-- Q5: Products that have never been ordered
SELECT p.product_id, p.product_name
FROM Products p
LEFT JOIN OrderItems oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;
