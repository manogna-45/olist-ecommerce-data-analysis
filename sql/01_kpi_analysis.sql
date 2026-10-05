-- Olist E-Commerce Analysis
-- KPI Analysis

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_product_sales,
    COUNT(DISTINCT c.customer_unique_id) AS total_customers,
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS average_order_value,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM workspace.olist.orders o
JOIN workspace.olist.order_items oi
    ON o.order_id = oi.order_id
JOIN workspace.olist.customers c
    ON o.customer_id = c.customer_id
LEFT JOIN (
    SELECT
        order_id,
        AVG(CAST(review_score AS INT)) AS review_score
    FROM workspace.olist.order_reviews
    WHERE review_score RLIKE '^[1-5]$'
    GROUP BY order_id
) r
    ON o.order_id = r.order_id;