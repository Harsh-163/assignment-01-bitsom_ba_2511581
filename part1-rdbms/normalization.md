## Anomaly Analysis

### Insert Anomaly:
**Definition:** An insert anomaly occurs when we cannot add a new piece of information without also inserting unrelated data.

**Example from orders_flat.csv:**  
For example, to add a new product “P010 – Office Chair”, you must also create a dummy order row, because product attributes are stored inside each order row.
This happens because columns like product_id, product_name, and category appear only when an order exists.
Thus, a new product cannot be inserted independently.

---

### Update Anomaly:
**Definition:** An update anomaly occurs when updating a single logical fact requires changing it in multiple rows, creating a risk of inconsistency.

**Example from orders_flat.csv:**  
Customer details are duplicated across many rows.
For example, customer C002 – Priya Sharma appears in multiple rows with the same email (priya@gmail.com).
If Priya changes her email, updating just one row (e.g., the row with order_id ORD1027) would create inconsistent customer records.

---

### Delete Anomaly:
**Definition:** A delete anomaly occurs when deleting a record unintentionally destroys other useful information.

**Example from orders_flat.csv:**  
If the only order belonging to product P004 – Notebook is deleted, then all product details (name, category, price) would be lost from the system.
Since product master data lives inside each order row, deleting a single order erases the only record of that product.

---

## Normalization Justification

The argument that "keeping everything in one table is simpler" may seem attractive at first, but the structure of orders_flat.csv clearly shows how denormalization creates long‑term operational risks. The flat file duplicates customer details, product data, and sales representative information across many rows. This duplication leads directly to update anomalies, where changing a customer email or product price requires updating multiple rows. Missing even one row creates inconsistent and unreliable data, which affects reporting, analytics, and customer communication.
The file also causes insert anomalies. For example, when introducing a new product, the system cannot register it unless an order exists because product attributes are embedded in the order rows. This makes catalog management impossible without creating fake transactions. Conversely, delete anomalies appear when removing the only order of a product or customer, which unintentionally deletes all information about that product or customer.
Normalizing the data into 3NF solves all these issues. Customer data moves to a Customers table, product data to a Products table, orders to an Orders table, and line items to an OrderItems table. Each entity then updates independently, ensuring accuracy and consistency. Queries become more efficient, storage decreases due to reduced redundancy, and the risk of data corruption drops significantly. Normalization is not over‑engineering—it is essential for correctness, scalability, and maintainability.
