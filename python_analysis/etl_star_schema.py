import pandas as pd
from sqlalchemy import create_engine, text

oltp_engine = create_engine('postgresql://postgres@localhost:5432/northwind')
olap_engine = create_engine('postgresql://postgres@localhost:5432/northwind_olap')

# --- STEP 1: EXTRACT ---
print('--- Step 1: Extracting raw data from OLTP... ---')
df_customers_raw = pd.read_sql("SELECT customer_id, company_name, country FROM customers", oltp_engine)
df_products_raw = pd.read_sql(
    """
    SELECT p.product_id, p.product_name, c.category_name
    FROM products p
    JOIN categories c ON p.category_id = c.category_id
    """, oltp_engine
)
df_orders_raw = pd.read_sql("SELECT order_id, customer_id, order_date FROM orders", oltp_engine)
df_details_raw = pd.read_sql("SELECT order_id, product_id, unit_price, quantity, discount FROM order_details", oltp_engine)

print(f"Extracted: {len(df_customers_raw)} customers, {len(df_products_raw)} products, {len(df_orders_raw)} orders.")

# --- STEP 2: TRANSFORM ---
# Calculate line total for facts
df_details_raw['line_total'] = (
    df_details_raw['unit_price'] *
    df_details_raw['quantity'] *
    (1 - df_details_raw['discount'])
)

df_sales_fact = df_orders_raw.merge(df_details_raw, on='order_id')

# Create a clean Time Dimension dataframe from unique order dates
df_time = pd.DataFrame({'full_date': pd.to_datetime(df_orders_raw['order_date']).dropna().unique()})
df_time['date_key'] = df_time['full_date'].dt.strftime('%Y%m%d').astype(int)
df_time['year'] = df_time['full_date'].dt.year
df_time['month'] = df_time['full_date'].dt.month

# Convert order_date to datetime and create the matching date_key in the sales dataframe
df_sales_fact['order_date'] = pd.to_datetime(df_sales_fact['order_date'])
df_sales_fact['date_key'] = df_sales_fact['order_date'].dt.strftime('%Y%m%d').astype(int)

# Drop the raw timestamp column since we now use date_key
df_sales_fact = df_sales_fact.drop(columns=['order_date'])

# --- STEP 3: LOAD SCHEMA & TABLES INTO OLAP ---
print(' Creating Star Schema tables in northwind_olap... ')
with olap_engine.begin() as conn:
    # Drop/Create table/dimensions:

    conn.execute(text("DROP TABLE IF EXISTS fact_sales CASCADE;"))

    conn.execute(text('DROP TABLE IF EXISTS dim_customers CASCADE;'))
    conn.execute(text(
        """
        CREATE TABLE dim_customers(
        customer_id VARCHAR(50) PRIMARY KEY,
        company_name VARCHAR(150),
        country VARCHAR(50)
        );
        """
    ))

    conn.execute(text('DROP TABLE IF EXISTS dim_products CASCADE;'))
    conn.execute(text(
        """
        CREATE TABLE dim_products (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(100),
        category_name VARCHAR(50)
        );
        """
    ))

    conn.execute(text('DROP TABLE IF EXISTS dim_time CASCADE;'))
    conn.execute(text(
        """
        CREATE TABLE dim_time (
        date_key INT PRIMARY KEY,
        full_date Date,
        year INT,
        month INT
        );
        """
    ))

    conn.execute(text(
        """
        CREATE TABLE fact_sales (
        sale_id SERIAL PRIMARY KEY,
        order_id INT,
        customer_id VARCHAR(50) REFERENCES dim_customers(customer_id),
        product_id INT REFERENCES dim_products(product_id),
        date_key INT REFERENCES dim_time(date_key),
        unit_price NUMERIC(10, 2),
        quantity INT,
        discount NUMERIC(4, 2),
        line_total NUMERIC(12, 2)
        );
        """
    ))

print(' Loading data into OLAP tables... ')
df_customers_raw.to_sql('dim_customers', olap_engine, if_exists='append', index=False)
df_products_raw.to_sql('dim_products', olap_engine, if_exists='append', index=False)
df_time.to_sql('dim_time', olap_engine, if_exists='append', index=False)
df_sales_fact.to_sql('fact_sales', olap_engine, if_exists='append', index=False)

print('ELT Pipline Completed Succesfully! Star Schema populated.')