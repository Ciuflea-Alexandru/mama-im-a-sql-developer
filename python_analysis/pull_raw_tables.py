import pandas as pd
from sqlalchemy import create_engine

# 1. Define your SQLAlchemy connection string for PostgreSQL
# Format: postgresql://username:password@host:port/database_name

DB_USER = "postgres"
DB_PASSWORD= "12345"
DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "northwind_oltp"

connection_string = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

# 2. Create the SQLAlchemy engine (our enterprise connection manager)
engine = create_engine(connection_string)

try:
    print("Connecting to the database...")
    
    # 3. Pull multiple raw OLTP tables into Pandas DataFrames
    df_customers = pd.read_sql("SELECT * FROM customers", engine)
    df_orders = pd.read_sql("SELECT * FROM orders", engine)
    df_order_details = pd.read_sql("SELECT * FROM order_details", engine)

    print("\n--- Customer Preview ---")
    print(df_customers.head(3))

    print("\n--- Orders Preview ---")
    print(df_orders.head(3))

    # 4. The Pandas Challenge: Merge them together just like a complex SQL join!
    print("\n Merging raw OLTP tables in Pandas memory...")

    df_merged = df_orders.merge(df_customers, on="customer_id", how="inner")

    print(df_merged[['order_id', 'customer_id', 'company_name', 'order_date', 'ship_city']].head(5))

except Exception as e:
    print(f"An error occurred: {e}")