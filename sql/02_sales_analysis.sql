-- Olist E-Commerce Analysis
-- Sales Analysis

-- Total product sales
SELECT
    ROUND(SUM(price), 2) AS total_product_sales
FROM workspace.olist.order_items;


-- Sales by year
SELECT
    YEAR(o.order_purchase_timestamp) AS order_year,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM workspace.olist.orders o
JOIN workspace.olist.order_items oi
    ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_purchase_timestamp)
ORDER BY order_year;


-- Monthly sales trend
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS order_month,
    ROUND(SUM(oi.price), 2) AS product_sales
FROM workspace.olist.orders o
JOIN workspace.olist.order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
ORDER BY order_month;