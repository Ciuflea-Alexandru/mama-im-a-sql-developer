import pandas as pd
from sqlalchemy import create_engine, MetaData, Table, select, func

engine = create_engine('postgresql://postgres:12345@localhost:5432/northwind_olap')

# Reflect existing tables from the database metadata
metadata = MetaData()
metadata.reflect(bind=engine)

fact_sales = metadata.tables['fact_sales']
dim_customers = metadata.tables['dim_customers']

print('Building query using SQLAlchemy expression language...\n')

# Construct the query pythonically
stmt = (
    select(
        dim_customers.c.customer_id,
        dim_customers.c.company_name,
        dim_customers.c.country,
        func.sum(fact_sales.c.line_total).label('total_lifetime_spend'),
        func.count(fact_sales.c.order_id.distinct()).label('total_orders_placed')
    )
    .select_from(
        fact_sales.join(dim_customers, fact_sales.c.customer_id == dim_customers.c.customer_id)
    )
    .group_by(
        dim_customers.c.customer_id,
        dim_customers.c.company_name,
        dim_customers.c.country
    )
    .having(func.sum(fact_sales.c.line_total) >= 1000.00)
    .order_by(func.sum(fact_sales.c.line_total).desc())
)

df_top_customers = pd.read_sql(stmt, engine)

print(f"Found {len(df_top_customers)} high-value customers using SQLAlchemy syntax:")
print(df_top_customers.head(10).to_string(index=False))
