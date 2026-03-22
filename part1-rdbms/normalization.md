## Part 1 — Relational Databases 
## 1.1 — Anomaly Analysis
An Insert Anomaly : In flat file orders_flat.csv the order table, customer table and the product table are merged. So it is not possible to insert a new product
which has not been ordered yet. For example : "Keyboard" is not ordered till date. This product cannot be inserted because the table require fields like order_id, customer_id, and order_date. This creates an Insert Anomaly due to poor table design.


An Update Anomaly : In the flat file orders_flat.csv, customer details such as customer_id, customer_name, and customer_city are stored together with order details. If a customer changes their city, the customer_city value must be updated in multiple rows where that customer appears. For example if Customer having customer_id = C001 , customer_name = Rohan Mehta and customer_city = Mumbai changes the city to Bangalore, then all rows with customer_id = C001 (rows 3,11,15,22,42,46,54,70,79,95,103,121,124,132,133,138,168,174,182 and 187) has to be updated.If some rows are not updated and some are updated data inconsistency will occur and create Update Anomaly.


A Delete Anomaly : In the flat file orders_flat.csv, order, customer and product information are stored together in the same table. When a record is deleted, other important information stored in that row may also be lost unintentionally.

For example, if the record with order_id = ORD1185, (row 13) is deleted, the product information such as product_name = Webcam will also be removed completely from the table since that product appears only in that row. This loss of important information due to deletion of a record is called a Delete Anomaly.

## Subjective
## Normalization Justification

Keeping all the data in a single table may appear simple, but it leads to several data anomalies such as insert, update, and delete anomalies. Normalization helps to eliminate these issues by organizing data into related tables.

Insert Anomaly:
In the flat dataset orders_flat.csv, it is difficult to add information about a new product if no order exists for it. For example, if we want to add a new product like Keyboard, we cannot store it unless an order is created. In the normalized schema, the product can be inserted directly into the product table without requiring an order record.

Update Anomaly:
Suppose a customer with customer_id = C001 moves from Mumbai to Bangalore. In the flat table (orders_flat.csv), the city information is repeated in many rows (for example rows 3, 11, 15, 22, etc.). Updating the city would require modifying all these rows. If even one row is missed, the dataset becomes inconsistent.
In the normalized schema, customer and city information are stored separately from orders. Therefore, we only update the city in the customer table once. This prevents inconsistency and helps to preserve historical order data. The orders that were placed when the customer lived in Mumbai remain unchanged, while the new address is updated correctly in the customer table.

Delete Anomaly:
In the flat file, deleting an order such as order_id = ORD1185 may also remove important information like product_name = Webcam if that product appears only in that row. In the normalized design, deleting an order only removes the order record, while product, customer, and category data remain safely stored in their respective tables.

Therefore, normalization reduces redundancy, maintains data integrity, and prevents anomalies.
