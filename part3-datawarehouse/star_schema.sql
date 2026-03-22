## Part 3 — Data Warehouses

## 3.1 — Star Schema Design

CREATE DATABASE retail_transactions;


## Product Dimension Table Creation
USE retail_transactions;
CREATE TABLE dim_product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    UNIQUE (product_name)
);

## Customer Dimension Table Creation
USE retail_transactions;
CREATE TABLE dim_customer (
    customer_id VARCHAR(10) PRIMARY KEY
);

## Store Dimension Table Creation
USE retail_transactions;
CREATE TABLE dim_store (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    store_city VARCHAR(100) NOT NULL,
    UNIQUE (store_name, store_city)
);

## Date Dimension Table Creation
USE retail_transactions;
CREATE TABLE dim_date (
    date_id INT AUTO_INCREMENT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,

    day INT,
    month INT,
    year INT,
    quarter INT,

    day_name VARCHAR(10),
    month_name VARCHAR(10),
    is_weekend BOOLEAN
);

## Transaction Fact Table Creation
USE retail_transactions;
CREATE TABLE fact_transaction (
    sale_key BIGINT AUTO_INCREMENT PRIMARY KEY,

    transaction_id VARCHAR(20) NOT NULL,

    product_id INT NOT NULL,
    customer_id VARCHAR(10) NOT NULL,
    store_id INT NOT NULL,
    date_id INT NOT NULL,

    units_sold INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

    total_amount DECIMAL(12,2)
    GENERATED ALWAYS AS (units_sold * unit_price) STORED,

    UNIQUE (transaction_id, product_id),

    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

## Insert 10 values of retail_transactions.csv into Product dimension table
use retail_transactions;
INSERT INTO dim_product (product_name, category)
VALUES
('Speaker', 'Electronics'),
('Tablet', 'Electronics'),
('Phone', 'Electronics'),
('Smartwatch', 'Electronics'),
('Laptop', 'Electronics'),
('Headphones', 'Electronics'),

('Jeans', 'Clothing'),
('Jacket', 'Clothing'),
('Saree', 'Clothing');

## Insert 10 values of retail_transactions.csv into Customer dimension table
use retail_transactions;
INSERT INTO dim_customer (customer_id)
VALUES
('CUST001'),
('CUST002'),
('CUST003'),
('CUST004'),
('CUST005'),
('CUST006'),
('CUST007'),
('CUST008'),
('CUST009'),
('CUST010');

## Insert 10 values of retail_transactions.csv into Date dimension table
use retail_transactions;
INSERT INTO dim_date (
    full_date, day, month, year, quarter, 
    day_name, month_name, is_weekend
)
VALUES
('2023-01-01', 1, 1, 2023, 1, 'Sunday', 'January', TRUE),
('2023-01-02', 2, 1, 2023, 1, 'Monday', 'January', FALSE),
('2023-01-03', 3, 1, 2023, 1, 'Tuesday', 'January', FALSE),
('2023-01-04', 4, 1, 2023, 1, 'Wednesday', 'January', FALSE),
('2023-01-05', 5, 1, 2023, 1, 'Thursday', 'January', FALSE),
('2023-01-06', 6, 1, 2023, 1, 'Friday', 'January', FALSE),
('2023-01-07', 7, 1, 2023, 1, 'Saturday', 'January', TRUE),
('2023-01-08', 8, 1, 2023, 1, 'Sunday', 'January', TRUE),
('2023-01-09', 9, 1, 2023, 1, 'Monday', 'January', FALSE),
('2023-01-10', 10, 1, 2023, 1, 'Tuesday', 'January', FALSE);


## Insert 10 values into Store dimension table
use retail_transactions;
INSERT INTO dim_store (store_name, store_city)
VALUES

('Chennai Anna', 'Chennai'),
('Delhi South', 'Delhi'),
('Bangalore MG', 'Bangalore'),
('Pune FC Road', 'Pune'),
('Mumbai Central', 'Mumbai'),
('Trivandrum Central', 'Trivandrum'),
('Hyderabad Banjara', 'Hyderabad'),
('Kolkata Park Street', 'Kolkata'),
('Ahmedabad CG Road', 'Ahmedabad'),
('Jaipur MI Road', 'Jaipur');

## Insert 10 values of retail_transactions.csv into fact transaction table
use retail_transactions;
INSERT INTO fact_transaction (
transaction_id, product_id, customer_id, store_id, date_id, units_sold, unit_price
) VALUES
('TXN5000',1,'CUST045',1,1,3,49262.78),
('TXN5001',2,'CUST021',1,2,11,23226.12),
('TXN5002',3,'CUST019',2,3,20,48703.39),
('TXN5003',2,'CUST007',3,4,14,23226.12),
('TXN5004',4,'CUST004',4,5,10,58851.01),
('TXN5005',11,'CUST027',5,6,12,52464.00),
('TXN5006',4,'CUST025',2,7,6,58851.01),
('TXN5007',7,'CUST041',3,8,16,2317.47),
('TXN5008',16,'CUST030',4,9,9,27469.99),
('TXN5009',4,'CUST020',3,10,3,58851.01);

