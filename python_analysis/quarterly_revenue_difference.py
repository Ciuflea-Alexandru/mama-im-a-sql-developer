import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://postgres:12345@localhost:5432/northwind_oltp')

# Write the advanced SQL query containing CTEs, DATE_TRUNC, and Window Functions (LAG/LEAD)
advanced_sql_query = """
WITH quaterly_revenue AS (
    SELECT 
        DATE_TRUNC('quarter', o.order_date) AS order_quarter,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY order_quarter
)
SELECT 
    order_quarter,
    ROUND(total_revenue::numeric, 2) AS current_revenue,
    ROUND(LAG(total_revenue, 1) OVER (ORDER BY order_quarter)::numeric, 2) AS prev_quarter_revenue,
    ROUND((total_revenue - LAG(total_revenue, 1) OVER (ORDER BY order_quarter))::numeric, 2) AS last_quarter_diff,
    ROUND(LEAD(total_revenue, 1) OVER (ORDER BY order_quarter)::numeric, 2) AS next_quarter_revenue,
    ROUND((total_revenue - LEAD(total_revenue, 1) OVER (ORDER BY order_quarter))::numeric, 2) AS next_quarter_diff
FROM quaterly_revenue
ORDER BY order_quarter;
"""

print("Executing advanced SQL query and pulling into Pandas...")

# Use pd.read_sql() to execute the query and dump the result right into a DataFrame
df_quarterly_trends = pd.read_sql(advanced_sql_query, engine)

print("\n--- Quarterly Revenue & Growth Trends ---")
print(df_quarterly_trends.to_string(index=False))