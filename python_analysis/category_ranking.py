import os
import pandas as pd
from sqlalchemy import create_engine, text

engine = create_engine('postgresql://postgres:12345@localhost:5432/northwind_olap')

print(' Retrieving Data... ')
query = """
SELECT
p.category_name,
SUM(f.line_total) AS category_revenue,
SUM(SUM(f.line_total)) OVER() AS total_revenue
FROM fact_sales f 
JOIN dim_products p ON f.product_id = p.product_id
GROUP BY p.category_name
ORDER BY category_revenue DESC
"""

df_category = pd.read_sql(query, engine)
print(df_category.head(5))

print('\n Calculating Category Contribution and Ranking... ')
df_category['percentage_share'] = df_category['category_revenue'] / df_category['total_revenue'] * 100

df_category['revenue_rank'] = df_category['category_revenue'].rank(ascending=False, method='dense').astype(int)

print(df_category.head(5))

print('\n Exporting as a csv file... ')
path = 'category_ranking.csv'
df_category.to_csv(path, index=False)

if os.path.exists(path):
    os.remove(path)