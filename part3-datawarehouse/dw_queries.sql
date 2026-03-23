-- ============================================================
-- PART 3 — STAR SCHEMA DESIGN
-- ============================================================

DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;

-- ============================================================
-- DIMENSION: dim_date
-- ============================================================

CREATE TABLE dim_date (
    date_id        DATE PRIMARY KEY,
    year           INT,
    month          INT,
    month_name     VARCHAR(20),
    day            INT
);

-- ============================================================
-- DIMENSION: dim_store
-- ============================================================

CREATE TABLE dim_store (
    store_id     INT AUTO_INCREMENT PRIMARY KEY,
    store_name   VARCHAR(100) NOT NULL,
    store_city   VARCHAR(100) NOT NULL
);

-- ============================================================
-- DIMENSION: dim_product
-- ============================================================

CREATE TABLE dim_product (
    product_id    INT AUTO_INCREMENT PRIMARY KEY,
    product_name  VARCHAR(100) NOT NULL,
    category      VARCHAR(50)
);

-- ============================================================
-- FACT TABLE: fact_sales
-- ============================================================

CREATE TABLE fact_sales (
    sales_id       INT AUTO_INCREMENT PRIMARY KEY,
    date_id        DATE NOT NULL,
    store_id       INT NOT NULL,
    product_id     INT NOT NULL,
    units_sold     INT NOT NULL,
    unit_price     DECIMAL(10,2) NOT NULL,
    revenue        DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- ============================================================
-- INSERT CLEANED DIMENSION DATA
-- ============================================================

-- Stores
INSERT INTO dim_store (store_name, store_city) VALUES
('Chennai Anna', 'Chennai'),
('Delhi South', 'Delhi'),
('Bangalore MG', 'Bangalore'),
('Pune FC Road', 'Pune'),
('Mumbai Central', 'Mumbai');

-- Products
INSERT INTO dim_product (product_name, category) VALUES
('Speaker', 'Electronics'),
('Tablet', 'Electronics'),
('Phone', 'Electronics'),
('Smartwatch', 'Electronics'),
('Atta 10kg', 'Grocery'),
('Jeans', 'Clothing'),
('Biscuits', 'Groceries'),
('Laptop', 'Electronics'),
('Milk 1L', 'Groceries'),
('Rice 5kg', 'Grocery');

-- Dates (10 sample cleaned rows)
INSERT INTO dim_date VALUES
('2023-08-29', 2023, 8, 'August', 29),
('2023-10-26', 2023, 10, 'October', 26),
('2023-12-08', 2023, 12, 'December', 8),
('2023-06-04', 2023, 6, 'June', 4),
('2023-07-22', 2023, 7, 'July', 22),
('2023-09-17', 2023, 9, 'September', 17),
('2023-02-08', 2023, 2, 'February', 8),
('2023-11-18', 2023, 11, 'November', 18),
('2023-05-26', 2023, 5, 'May', 26),
('2023-03-31', 2023, 3, 'March', 31);

-- ============================================================
-- INSERT CLEANED FACT DATA (10 rows)
-- ============================================================

INSERT INTO fact_sales (date_id, store_id, product_id, units_sold, unit_price, revenue) VALUES
('2023-08-29', 3, 1, 10, 49262.78, 492627.80),
('2023-10-26', 4, 6, 16, 2317.47, 37079.52),
('2023-12-08', 3, 7, 9, 27469.99, 247229.91),
('2023-06-04', 4, 4, 15, 30187.24, 452808.60),
('2023-07-22', 1, 5, 3, 52464.00, 157392.00),
('2023-09-17', 3, 6, 15, 2317.47, 34762.05),
('2023-02-08', 3, 1, 15, 39854.96, 597824.40),
('2023-11-18', 2, 4, 5, 30187.24, 150936.20),
('2023-05-26', 4, 10, 9, 31604.47, 284440.23),
('2023-03-31', 3, 4, 6, 39854.96, 239129.76);
