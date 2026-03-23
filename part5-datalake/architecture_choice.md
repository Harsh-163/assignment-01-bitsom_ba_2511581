## Architecture Recommendation

For a fast-growing food delivery startup collecting GPS location logs, customer text reviews, payment transactions, and restaurant menu images, I would recommend a **Data Lakehouse** architecture.

### Reason 1 — Variety of Data Types Demands Lake-Level Flexibility

The four data types described span every storage category: structured (payment transactions), semi-structured (GPS logs, JSON events), unstructured text (customer reviews), and binary (menu images). A traditional Data Warehouse only ingests structured, pre-modelled data — it cannot store raw GPS telemetry or JPEG images at all. A pure Data Lake can hold all of these, but it offers no transactional guarantees and makes structured reporting slow and unreliable. A Data Lakehouse (built on formats like Apache Iceberg or Delta Lake, or platforms like Databricks or AWS Lake Formation) stores all data types in a unified object store while adding a metadata and transaction layer that enables ACID-compliant SQL queries over structured subsets. The startup gets the schema flexibility of a lake and the query performance of a warehouse in one system.

### Reason 2 — Real-Time and Batch Workloads Coexist

Payment transaction monitoring needs near-real-time consistency (fraud checks, receipts). GPS logs arrive as a continuous high-velocity stream. Customer reviews are written asynchronously and analyzed in batch. A Data Lakehouse supports both streaming ingest (via Kafka or Kinesis connectors) and batch analytics in the same platform, avoiding the cost and complexity of maintaining a separate streaming pipeline alongside a warehouse.

### Reason 3 — Cost-Effective Scalability for a Fast-Growing Startup

A full Data Warehouse (e.g., Snowflake, BigQuery) charges per byte scanned and per compute hour — costs that scale sharply as GPS log volumes grow. A Data Lakehouse stores raw data cheaply in object storage (S3, GCS) and applies compute only when queries are run, with table-format optimizations (file pruning, Z-ordering) to minimize unnecessary scans. This gives the startup an architecture that is affordable at current scale and elastic as it grows, without needing a costly re-architecture later.
