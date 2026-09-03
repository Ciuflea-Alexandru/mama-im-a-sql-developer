import pandas as pd
from sqlalchemy import create_engine, text

engine = create_engine('postgresql://postgres:12345@localhost:5432/northwind_olap')

print(' Extracting sales and customer data fro RFM Analysis')

query = """
SELECT
c.customer_id,
c.company_name,
f.order_id,
f.line_total,
t.full_date
FROM fact_sales f
JOIN dim_customers c ON f.customer_id = c.customer_id
JOIN dim_time t ON f.date_key = t.date_key;
"""

df_sales = pd.read_sql(text(query), engine)

# Convert order_date column to actual datetime objects
df_sales['full_date'] = pd.to_datetime(df_sales['full_date'])

# Set a snapshot date (1 day after the absolute latest order date in the database)
snapshot_date = df_sales['full_date'].max() + pd.Timedelta(days=1)

# Aggregate metrics using Pandas .agg()
# - Recency: How many days ago was their last purchase?
# - Frequency: How many unique orders did they place?
# - Monetary: What is their total lifetime spend?
rfm = df_sales.groupby(['customer_id', 'company_name']).agg(
    recency=('full_date', lambda x: (snapshot_date - x.max()).days),
    frequency_orders=('order_id', 'nunique'),
    monetary_spend=('line_total', 'sum')
).reset_index()

# Round monetary spend for clean readability
rfm['monetary_spend'] = rfm['monetary_spend'].round(2)

# Sort by Monetary spend from highest to lowest
rfm = rfm.sort_values(by='monetary_spend', ascending=False)

print(' Top 10 Customers by RFM Segmentation: ')
print(rfm.head(10).to_string(index=False))
print('-' * 50)
