import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://postgres@localhost:5432/northwind')

print('Pulling tables from OLTP...')

df_customers = pd.read_sql('SELECT * FROM customers', engine)
df_orders = pd.read_sql(' SELECT * FROM orders', engine)
df_order_details = pd.read_sql(' SELECT * FROM order_details', engine)

print('Merging data frames in Pandas memory...')

df_full = (
    df_orders
    .merge(df_order_details, on='order_id')
    .merge(df_customers, on='customer_id')
)

df_full['line_total'] = df_full['unit_price'] * df_full['quantity'] * (1 - df_full['discount'])

top_customers = (
    df_full
    .groupby('company_name')['line_total']
    .sum()
    .reset_index()
    .sort_values(by='line_total', ascending=False)
)

print('\n--- Top 5 highest-spending customer ---')
print(top_customers.head(5).to_string(index=False))