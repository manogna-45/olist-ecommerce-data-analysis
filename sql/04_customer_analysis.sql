-- Olist E-Commerce Analysis
-- Customer Analysis


-- Total and repeat customers
SELECT
    COUNT(DISTINCT customer_unique_id) AS total_customers,
    COUNT(DISTINCT CASE
        WHEN customer_order_count > 1
        THEN customer_unique_id
    END) AS repeat_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS customer_order_count
    FROM workspace.olist.customers c
    JOIN workspace.olist.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
);


-- Customer type
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM workspace.olist.customers c
    JOIN workspace.olist.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customers
FROM customer_orders
GROUP BY
    CASE
        WHEN order_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END
ORDER BY customers DESC;


-- Sales per customer type
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM workspace.olist.customers c
    JOIN workspace.olist.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
),
customer_sales AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS total_sales
    FROM workspace.olist.customers c
    JOIN workspace.olist.orders o
        ON c.customer_id = o.customer_id
    JOIN workspace.olist.order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
)
SELECT
    CASE
        WHEN co.order_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customers,
    ROUND(SUM(cs.total_sales), 2) AS total_sales,
    ROUND(AVG(cs.total_sales), 2) AS average_sales_per_customer
FROM customer_orders co
JOIN customer_sales cs
    ON co.customer_unique_id = cs.customer_unique_id
GROUP BY
    CASE
        WHEN co.order_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END;