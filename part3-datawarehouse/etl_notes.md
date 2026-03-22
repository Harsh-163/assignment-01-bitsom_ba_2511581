## Subjective 

## ETL Decisions

### Decision 1 — Fixing Date Format

Problem:
The dates in the raw file were in dd-mm-yyyy format, which MySQL doesn’t support directly. This caused issues while inserting into the date dimension and performing date-based analysis.

Resolution:
I converted all date values into YYYY-MM-DD format using STR_TO_DATE() during transformation. This ensured the dates were stored correctly and could be used reliably for joins and reporting.

### Decision 2 — Standardizing Category Values

Problem:
The category column had inconsistent values like electronics, Electronics, and also variations such as grocery and Groceries. This could lead to duplicate entries in the product dimension and incorrect aggregation in reports.

Resolution:
I standardized all category values into a consistent format by normalizing casing and naming. For example, all variations like grocery and Groceries were converted into a single value (Groceries). This ensured clean and consistent dimension data.

### Decision 3 — Handling Blank Store City Values
Problem:
Some records had blank values in the store_city field. This could create issues while loading the store dimension and also affect location-based analysis.
Resolution:
Since the store_name was available, I used it to identify and fill the missing store_city values based on known mappings. This ensured that no store record had missing location data and helped maintain consistency in the store dimension.
Since the store_name was available, I used it to identify and fill the missing store_city values based on known mappings. This ensured that no store record had missing location data and helped maintain consistency in the store dimension.
