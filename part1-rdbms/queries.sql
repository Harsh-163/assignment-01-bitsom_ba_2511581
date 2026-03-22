##1.3 — SQL Queries

-- Q1: List all customers from Mumbai along with their total order value     
use assignment_db;
select c.customer_name,sum(o.quantity * o.unit_price) AS total_order_value from customer c
inner join orders o
on c.customer_id = o.customer_id
inner join city ct
on ct.city_id = c.city_id
where ct.city_name = 'Mumbai'
group by c.customer_id,c.customer_name;

-- Q2: Find the top 3 products by total quantity sold
use assignment_db;
select p.product_name,sum(o.quantity) AS total_quantity_sold from product p
inner join orders o
on p.product_id = o.product_id
group by p.product_name
order by sum(o.quantity) desc
limit 3;

-- Q3: List all sales representatives and the number of unique customers they have handled
use assignment_db;
select e.sales_rep_name,
       count(distinct(o.customer_id)) AS unique_customers
from employee e
left join orders o
  on e.sales_rep_id = o.sales_rep_id
group by e.sales_rep_id, e.sales_rep_name;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
use assignment_db;
select order_id,
       sum(quantity * unit_price) AS total_value
from orders
group by order_id
having total_value > 10000
order by total_value desc;

-- Q5: Identify any products that have never been ordered
use assignment_db;
select p.product_name
from product p
left join orders o
  on p.product_id = o.product_id
where o.product_id is null;




