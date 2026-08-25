/*
Add Primary Key and Foreign Key constraints to your dimension and fact table.
*/

ALTER TABLE dim_customers ADD PRIMARY KEY (customer_id);
ALTER TABLE dim_products ADD PRIMARY KEY (product_id);
ALTER TABLE dim_employees ADD PRIMARY KEY (employee_id);
ALTER TABLE dim_suppliers ADD PRIMARY KEY (supplier_id);
ALTER TABLE dim_shippers ADD PRIMARY KEY (shipper_id);
ALTER TABLE dim_date ADD PRIMARY KEY (date_key);

ALTER TABLE fact_sales 
ADD CONSTRAINT fk_fact_customer FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id),
ADD CONSTRAINT fk_fact_product FOREIGN KEY (product_id) REFERENCES dim_products(product_id),
ADD CONSTRAINT fk_fact_employee FOREIGN KEY (employee_id) REFERENCES dim_employees(employee_id),
ADD CONSTRAINT fk_fact_supplier FOREIGN KEY (supplier_id) REFERENCES dim_suppliers(supplier_id),
ADD CONSTRAINT fk_fact_shipper FOREIGN KEY (shipper_id) REFERENCES dim_shippers(shipper_id),
ADD CONSTRAINT fk_fact_order_date FOREIGN KEY (order_date_key) REFERENCES dim_date(date_key),
ADD CONSTRAINT fk_fact_required_date FOREIGN KEY (required_date_key) REFERENCES dim_date(date_key),
ADD CONSTRAINT fk_fact_shipped_date FOREIGN KEY (shipped_date_key) REFERENCES dim_date(date_key);