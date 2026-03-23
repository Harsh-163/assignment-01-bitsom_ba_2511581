## Storage Systems

The hospital network's four goals each map to a different storage paradigm, and the architecture uses all of them in a coordinated pipeline.

**Goal 1 — Predict patient readmission risk** requires a historical analytical store. All treatment records, discharge summaries, lab results, and prior admission data are loaded into a **Data Warehouse** (e.g., Amazon Redshift or Snowflake). The warehouse serves as the feature store for the ML model: batch ETL jobs extract, clean, and compute features (e.g., number of prior admissions in 90 days, comorbidity flags), which the readmission risk model consumes on a nightly training cycle.

**Goal 2 — Doctors querying patient history in plain English** requires a **Vector Database** (e.g., Pinecone or pgvector). Clinical notes, discharge summaries, and diagnostic reports are chunked and embedded using a medical language model (e.g., BioBERT). At query time, a doctor's natural-language question is embedded and a semantic nearest-neighbor search retrieves the most relevant passages, which are then summarized by a language model before display.

**Goal 3 — Monthly management reports** are served directly from the **Data Warehouse** described above. A BI layer (Tableau or Power BI) connects to pre-aggregated views for bed occupancy, department-wise costs, and admission trends — refreshed nightly via scheduled ETL.

**Goal 4 — Real-time ICU vitals streaming** requires a **Time-Series Database** (e.g., InfluxDB or Amazon Timestream) fed by an **Apache Kafka** streaming pipeline. ICU device readings arrive every second; Kafka buffers and routes them; the time-series store indexes them for low-latency real-time dashboards and threshold-based alerting.

---

## OLTP vs OLAP Boundary

The **OLTP boundary** covers all live patient interactions: admissions, prescriptions, billing, and ICU device writes. These are handled by a relational transactional database (PostgreSQL or MySQL) with strict ACID guarantees — any write affecting a patient record must be immediately consistent. The ICU vitals streaming pipeline is also on the OLTP side: data is produced transactionally at the device, buffered in Kafka, and written to the time-series store in near real-time.

The **OLAP boundary** begins the moment data crosses into the Data Warehouse. A nightly ETL process extracts from the OLTP database, applies dimensional modelling (a star schema with `dim_patient`, `dim_department`, `dim_date`, and `fact_admission`), and loads into the warehouse. From this point forward, all analytical workloads — readmission prediction feature engineering, management reporting, and vector-DB ingestion of historical notes — operate on the warehouse copy. The two boundaries are kept strictly separate: no BI query ever touches the live OLTP database, preventing analytical workloads from degrading clinical system performance.

---

## Trade-offs

**Trade-off: Data Duplication and Synchronization Lag**

The architecture stores patient data in four separate systems: the OLTP relational database, the Data Warehouse, the Vector Database, and the Time-Series store. This duplication creates a synchronization lag: a patient's updated diagnosis in the OLTP system will not appear in the warehouse, vector DB, or ML features until the next ETL cycle (up to 24 hours). In a clinical setting, a doctor querying patient history via the semantic search could theoretically see data that is one day stale.

**Mitigation:** For Goal 2 (plain-English queries), implement a hybrid retrieval strategy: the vector DB handles semantic search for historical records, but the system also queries the live OLTP database for any events from the last 24 hours and merges the results before displaying to the doctor. This adds a thin real-time overlay on top of the semantic layer without compromising the architectural separation of OLTP and OLAP workloads. For the ML model, a daily refresh is clinically acceptable for readmission risk scoring; if lower latency is required, the ETL cadence can be increased to hourly using a CDC (Change Data Capture) tool like Debezium.
