## ETL Decisions

### Decision 1 — Standardizing Date Formats

Problem:
The raw dataset contained inconsistent date formats such as 29/08/2023, 12-12-2023, and 2023-02-05.
This caused ETL failures when loading into the date dimension.

Resolution:
All dates were converted into a uniform ISO format: YYYY-MM-DD before inserting into dim_date and fact_sales. This ensures proper joins, year/month extraction, and analytics.

### Decision 2 — Fixing Inconsistent Category Names

Problem:
The dataset included multiple variations of category labels such as Groceries, Grocery, electronics, and Electronics.
This leads to duplicated categories and incorrect aggregations.

Resolution:
All categories were standardized with consistent casing (e.g., Electronics, Clothing, Grocery). These cleaned values were inserted into dim_product.

### Decision 3 — Handling Missing Store Cities

Problem:
Some rows in the raw data had empty store_city values, which would break foreign key constraints in the star schema.

Resolution:
Missing store cities were inferred based on store name (e.g., “Mumbai Central” → “Mumbai”). Rows with no reliable inference were flagged for cleaning. The warehouse now contains consistent store data.
