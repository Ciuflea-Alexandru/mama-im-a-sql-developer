import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://postgres@localhost:5432/northwind')
print("Pulling tables from OLTP database...")
df_orders = pd.read_sql("SELECT order_id, customer_id, order_date FROM orders", engine)
df_details = pd.read_sql("SELECT order_id, product_id, unit_price, quantity, discount FROM order_details", engine)
df_products = pd.read_sql("SELECT product_id, product_name, category_id FROM products", engine)
df_categories = pd.read_sql("SELECT category_id, category_name FROM categories", engine)
print("Merging dataframes in Pandas memory...")
df_full = (
    df_details
    .merge(df_orders, on="order_id")
    .merge(df_products, on="product_id")
    .merge(df_categories, on="category_id")
)

df_full['line_total'] = df_full['unit_price'] * df_full['quantity'] * (1- df_full['discount'])

category_revenue = (
    df_full
    .groupby('category_name')['line_total']
    .sum()
    .reset_index()
    .sort_values(by='line_total', ascending=False)
)

print("\n--- Total Revenue by Product Category ---")
print(category_revenue.to_string(index=False))