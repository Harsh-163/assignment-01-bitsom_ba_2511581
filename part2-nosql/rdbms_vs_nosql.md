## Database Recommendation

For a healthcare patient management system, I would recommend **MySQL** (or any ACID-compliant relational database) as the primary data store — with important caveats about a hybrid architecture for the fraud detection module.

### Why MySQL for the Core PMS

Healthcare data is fundamentally relational and transactional. A patient has one identity, linked to multiple admissions, each linked to prescriptions, lab results, and billing records. These relationships are well-defined and stable — exactly what a relational schema is designed to represent. More critically, **ACID compliance is non-negotiable here**. Consider a scenario where a doctor updates a patient's medication dosage and simultaneously a billing record is generated: both operations must either fully succeed or fully roll back together. A BASE (Basically Available, Soft-state, Eventually consistent) system, which MongoDB follows, allows temporary inconsistency — acceptable for a shopping cart, dangerous for a patient's drug dosage record.

Under the **CAP theorem**, MySQL (configured with synchronous replication) prioritizes **Consistency** and **Partition Tolerance** — giving up some availability during network partitions. For healthcare, a brief unavailability is far preferable to a clinician reading stale medication data. MongoDB in its default configuration prioritizes **Availability** over strict consistency, which is the wrong trade-off in a clinical setting.

### Would the Answer Change for Fraud Detection?

Yes, partially. A fraud detection module has very different requirements: it needs to analyze high-velocity, semi-structured behavioral event streams (login patterns, claim submission timings, IP geolocation data) in near real-time. This data is not neatly relational and evolves rapidly as new fraud signals are discovered. Here, **MongoDB (or a time-series/stream database like Apache Kafka + Cassandra)** is appropriate as a **secondary, purpose-specific store** for the fraud engine — not replacing MySQL, but complementing it. The PMS core retains its ACID guarantees, while the fraud module processes event logs in a flexible, schema-less store optimized for analytical queries.

In summary: **MySQL for the transactional PMS core; MongoDB or a streaming store as a sidecar for fraud detection.**
