-- ============================================================
-- Part 1 – RDBMS Schema Design
-- Normalized to Third Normal Form (3NF)
-- Source: orders_flat.csv
-- ============================================================

-- Drop tables in reverse dependency order (safe re-run)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS sales_reps;

-- ============================================================
-- Table 1: sales_reps
-- Eliminates update anomaly: office_address stored once per rep
-- ============================================================
CREATE TABLE sales_reps (
    sales_rep_id   VARCHAR(10)  NOT NULL,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(150) NOT NULL,
    office_address  VARCHAR(255) NOT NULL,
    CONSTRAINT pk_sales_reps PRIMARY KEY (sales_rep_id)
);

INSERT INTO sales_reps (sales_rep_id, sales_rep_name, sales_rep_email, office_address) VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02', 'Anita Desai',  'anita@corp.com',  'Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03', 'Ravi Kumar',   'ravi@corp.com',   'South Zone, MG Road, Bangalore - 560001');

-- ============================================================
-- Table 2: customers
-- Each customer stored once; city kept with customer
-- ============================================================
CREATE TABLE customers (
    customer_id    VARCHAR(10)  NOT NULL,
    customer_name  VARCHAR(100) NOT NULL,
    customer_email VARCHAR(150) NOT NULL,
    customer_city  VARCHAR(100) NOT NULL,
    CONSTRAINT pk_customers PRIMARY KEY (customer_id)
);

INSERT INTO customers (customer_id, customer_name, customer_email, customer_city) VALUES
('C001', 'Rohan Mehta',  'rohan@gmail.com',  'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com',  'Delhi'),
('C003', 'Amit Verma',   'amit@gmail.com',   'Bangalore'),
('C004', 'Sneha Iyer',   'sneha@gmail.com',  'Chennai'),
('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai'),
('C006', 'Neha Gupta',   'neha@gmail.com',   'Delhi'),
('C007', 'Arjun Nair',   'arjun@gmail.com',  'Bangalore'),
('C008', 'Kavya Rao',    'kavya@gmail.com',  'Hyderabad');

-- ============================================================
-- Table 3: products
-- Eliminates insert anomaly: products can exist without orders
-- unit_price stored once per product (not per order row)
-- ============================================================
CREATE TABLE products (
    product_id   VARCHAR(10)  NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    category     VARCHAR(50)  NOT NULL,
    unit_price   DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_products PRIMARY KEY (product_id)
);

INSERT INTO products (product_id, product_name, category, unit_price) VALUES
('P001', 'Laptop',        'Electronics', 55000.00),
('P002', 'Mouse',         'Electronics',   800.00),
('P003', 'Desk Chair',    'Furniture',    8500.00),
('P004', 'Notebook',      'Stationery',    120.00),
('P005', 'Headphones',    'Electronics',  3200.00),
('P006', 'Standing Desk', 'Furniture',   22000.00),
('P007', 'Pen Set',       'Stationery',    250.00),
('P008', 'Webcam',        'Electronics',  2100.00);

-- ============================================================
-- Table 4: orders
-- One row per order; links customer and sales rep
-- ============================================================
CREATE TABLE orders (
    order_id     VARCHAR(15)  NOT NULL,
    customer_id  VARCHAR(10)  NOT NULL,
    sales_rep_id VARCHAR(10)  NOT NULL,
    order_date   DATE         NOT NULL,
    CONSTRAINT pk_orders      PRIMARY KEY (order_id),
    CONSTRAINT fk_orders_cust FOREIGN KEY (customer_id)  REFERENCES customers(customer_id),
    CONSTRAINT fk_orders_sr   FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);

INSERT INTO orders (order_id, customer_id, sales_rep_id, order_date) VALUES
('ORD1000', 'C002', 'SR03', '2023-05-21'),
('ORD1001', 'C004', 'SR03', '2023-02-22'),
('ORD1002', 'C002', 'SR02', '2023-01-17'),
('ORD1003', 'C002', 'SR01', '2023-09-16'),
('ORD1004', 'C001', 'SR01', '2023-11-29'),
('ORD1005', 'C007', 'SR02', '2023-10-29'),
('ORD1006', 'C001', 'SR01', '2023-12-24'),
('ORD1007', 'C006', 'SR01', '2023-04-21'),
('ORD1008', 'C002', 'SR02', '2023-02-19'),
('ORD1009', 'C006', 'SR02', '2023-01-23');

-- ============================================================
-- Table 5: order_items
-- Each line item of an order; quantity at time of sale
-- Resolves many-to-many between orders and products
-- ============================================================
CREATE TABLE order_items (
    item_id    SERIAL,
    order_id   VARCHAR(15) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity   INT         NOT NULL CHECK (quantity > 0),
    CONSTRAINT pk_order_items  PRIMARY KEY (item_id),
    CONSTRAINT fk_oi_order     FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    CONSTRAINT fk_oi_product   FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
('ORD1000', 'P001', 2),
('ORD1001', 'P002', 5),
('ORD1002', 'P005', 1),
('ORD1003', 'P002', 5),
('ORD1004', 'P005', 5),
('ORD1005', 'P002', 3),
('ORD1006', 'P007', 4),
('ORD1007', 'P003', 3),
('ORD1008', 'P001', 3),
('ORD1009', 'P005', 4);
