## 6.2 — Design Justification

## Storage Systems
(Which databases/storage systems did you choose for each of the 4 goals and why)
Different storage systems are used in this design based on the type of hospital data and how it is used.
All data from sources like patient records, lab reports, and medical devices is first stored in a Data Lake. This is useful because it can store any type of data in its original form without needing a fixed structure.
For daily hospital operations such as patient registration, appointments, and billing, MySQL is used. It helps keep the data accurate and consistent, which is important for transactions.
For data like doctor notes and medical reports, which do not follow a fixed format, MongoDB is used. It is flexible and can easily store different types of data.
For analysis and reporting, DuckDB is used. It reads processed data and helps generate insights and reports, and also supports AI models.
Overall, using different storage systems makes the design simple, flexible, and efficient.

## OLTP vs OLAP Boundary
(Where does the transactional system end and the analytical system begin in your design)
In this architecture, the OLTP (transactional system) includes all systems where real-time hospital operations take place. This covers activities such as patient registration, appointment booking, billing, and updating medical records. These operations are handled in MySQL, where data is continuously created and updated. The main goal here is fast and accurate transaction processing.
The boundary between OLTP and OLAP occurs at the data ingestion layer. Once data is extracted from MySQL and other hospital sources (like lab systems or medical devices), it is no longer part of the transactional system.
From the ingestion stage onwards, the system becomes OLAP (analytical). The data is moved into the Data Lake, where it is stored, cleaned, and transformed. After processing, tools like DuckDB are used for analysis, reporting, and AI model usage.
In this design, OLAP starts early (from ingestion), which follows a modern data architecture approach and allows better scalability and flexibility for analytics.

## Trade-offs
(Identify one significant trade-off in your design and how you would mitigate it)
One important trade-off in this design is the use of multiple systems like MySQL, Data Lake, MongoDB, and DuckDB. This improves performance and flexibility because each system is used for a specific purpose. However, it also increases the complexity of the overall architecture. Managing data across different systems can be challenging, and there is a risk of data delay or mismatch if the flow is not handled properly.
To manage this, a well-defined ETL process is used to move data in a structured and controlled way. Data validation and cleaning steps ensure consistency before it is used for reporting or AI models.
In addition, proper data flow design and monitoring help track how data moves between systems and quickly detect any issues.
So, even though the system is more complex, these measures help maintain accuracy, reliability, and scalability.




