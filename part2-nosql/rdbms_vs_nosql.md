## Subjective

## Database Recommendation

Database Recommendation

For a healthcare startup building a patient management system, I would recommend MySQL as the main database. Hospital systems manage sensitive and critical data such as patient records, prescriptions, billing, and appointment details. In such cases, data consistency and reliability are extremely important. MySQL follows the ACID properties (Atomicity, Consistency, Isolation, Durability) which ensure that transactions are handled safely and accurately. For example, when updating a patient’s treatment information or processing a payment, the system must guarantee that the transaction completes correctly without partial updates.

From the perspective of the CAP theorem, MySQL prioritizes Consistency and Partition tolerance (CP). In healthcare systems, maintaining correct and consistent data is more important than high availability because incorrect patient information could lead to serious issues.

MongoDB, on the other hand, follows the BASE model (Basically Available, Soft state, Eventually consistent) and focuses more on availability and scalability. This makes it suitable for handling large volumes of semi-structured or rapidly changing data.

If the system later includes a fraud detection module, MongoDB could be useful because fraud detection often involves analyzing large datasets such as transaction logs and behavior patterns.
Therefore, MySQL is better suited for the core hospital system, while MongoDB can support analytical components like fraud detection.
