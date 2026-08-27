import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://postgres@localhost:5432/northwind')

print(' Pulling up the data... ')

df_orders = pd.read_sql(' SELECT * FROM orders', engine)
df_order_details = pd.read_sql(' SELECT * FROM order_details', engine)

print(' Mergin the tables... ')

df_full = (
    df_orders
    .merge(df_order_details, on='order_id')
)

df_full['line_total'] = df_full['unit_price'] * df_full['quantity'] * (1 - df_full['discount'])

top_shiping = (
    df_full
    .groupby('ship_country')['line_total']
    .sum()
    .reset_index()
    .sort_values(by='line_total', ascending=False)
)

print('\n--- Top 5 shipping countries by total revenue ---')
print(top_shiping.head(5).to_string(index=False))

# Filter for USA
df_usa = df_full[df_full['ship_country'] == 'USA']

print('\n--- Only display the shipping to USA ---')
print(df_usa[['order_id', 'customer_id', 'ship_country']].head(3).to_string(index=False))

#Multiple conditions: Germany AND line_total > 100
df_germany_and = df_full[
    (df_full['ship_country'] == 'Germany') &
    (df_full['line_total'] > 100)
]

print('\n--- Only display the germany ships or  ---')
print(df_germany_and[['order_id', 'ship_country', 'line_total']].head(5).to_string(index=False))

# Multiple conditions: Germany OR line_total < 100
df_germany_or = df_full[
    (df_full['ship_country'] == 'Germany') |
    (df_full['line_total'] < 100)
]

print('\n--- Only display the germany shipings or the shippings with line_total less than 100 ---')
print(df_germany_or[['order_id', 'ship_country', 'line_total']].head(5).to_string(index=False))

# Using .query() reads almost identical to SQL
df_query = df_full.query("ship_country == 'USA' and line_total > 200")

print('\n--- Display via sql query syntax ---')
print(df_query[['order_id', 'ship_country', 'line_total']].head(3).to_string(index=False))