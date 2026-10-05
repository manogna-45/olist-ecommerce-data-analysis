\# Olist E-Commerce Data Analysis — Project Progress



\## Project Goal



Analyze Olist e-commerce data to understand sales performance,

customer behavior, product performance, delivery performance,

and customer satisfaction.



\## Tools



\- Databricks Free Edition

\- SQL

\- GitHub

\- Kaggle Olist Dataset



\## Phase 1 — Dataset Selection



Status: Completed



\- Industry: E-commerce

\- Dataset: Brazilian E-Commerce Public Dataset by Olist

\- Approximately 100K orders

\- 9 CSV files

\- Data period: 2016–2018



\## Phase 2 — GitHub Setup



Status: Completed



\- Repository: olist-ecommerce-data-analysis

\- Git initialized

\- Main branch created

\- Initial commit pushed

\- Raw dataset excluded from GitHub



\## Phase 3 — Databricks Setup



Status: Completed



\- Databricks Free Edition configured

\- SQL Warehouse connected

\- Catalog: workspace

\- Schema: olist

\- Volume: raw\_data

\- 9 Olist CSV files uploaded



\## Phase 4 — Data Analysis



Status: In Progress



\- orders table created

\- SQL analysis started



\## Key Findings



\- Total orders: 99,441

\- Delivered orders: 96,478

\- Delivered order rate: 97.02%

\- Non-delivered orders: 2,963 (2.98%)



\- Highest monthly order volume: November 2017 with 7,544 orders

\- Lowest monthly order volume: October 2016 with 1 order

\- The very low order count in the earliest period may reflect limited dataset coverage, so it should not be treated as a meaningful business decline.



\- Non-delivered order breakdown:

&#x20; - Shipped: 1,107

&#x20; - Canceled: 625

&#x20; - Unavailable: 609

&#x20; - Invoiced: 314

&#x20; - Processing: 301

&#x20; - Created: 5

&#x20; - Approved: 2

\- Canceled and unavailable orders together accounted for 1,234 orders (41.7% of non-delivered orders).

\- Shipped orders were the largest non-delivered status with 1,107 orders.



\- Total product sales value: R$13,591,643.70

\- Average order-item price: R$120.65

\- Minimum order-item price: R$0.85

\- Maximum order-item price: R$6,735.00

\- Product prices show a wide range, so average price should be interpreted alongside product/category-level analysis.



\- Top product category by sales value: beleza\_saude — R$1,258,681.34

\- Second-highest category: relogios\_presentes — R$1,205,005.68

\- Third-highest category: cama\_mesa\_banho — R$1,036,988.68

\- Product category analysis revealed R$179,535.28 in sales associated with missing product categories.



\## Problems \& Fixes



\- Initial CREATE TABLE SQL approach returned:

&#x20; "Missing cloud file system scheme"

\- Switched to Databricks Create Table workflow from the uploaded volume.

