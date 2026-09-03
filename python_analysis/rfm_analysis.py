import os
import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine

load_dotenv()
bucket = os.getenv('AWS_BUCKET_NAME')

engine = create_engine('postgresql://postgres:12345@localhost:5432/northwind_olap')

print(' Retrieving Data ')

df_sales = pd.read_sql('SELECT * FROM fact_sales', engine)
df_customers = pd.read_sql('SELECT * FROM dim_customers', engine)

validation_failed = False

invalid_prices = df_sales[df_sales['unit_price'] <= 0]
if not invalid_prices.empty:
    print(f" FAIL: Found {len(invalid_prices)} rows with zero negative unit prices! ")
    validation_failed = True
else:
    print(' Pass: All unit prices are greater than zero ')

invalid_quantities = df_sales[df_sales['quantity'] <=0]
if not invalid_quantities.empty:
    print(f" Fail: Found {len(invalid_quantities)} rows with zero negative quantity! ")
    validation_failed = True
else:
    print(' Pass: All unit quantity are greater than zero ')

invalid_discounts = df_sales[df_sales['discount'] <= 0]
if not invalid_discounts.empty:
    print(f" Fail: Found {len(invalid_discounts)} rows with zero negative discount! ")
    validation_failed = True
else:
    print(' Pass: All discounts are greater than zero ')

print("-" * 50)
if validation_failed:
    print(' Pipeline Data Quality Audit FAILED. ')
else:
    print(' All Data Quality Checks Passed successfully. ')