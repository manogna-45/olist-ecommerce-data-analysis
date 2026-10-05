-- Olist E-Commerce Analysis
-- Product Analysis


-- Sales by product category
SELECT
    p.product_category_name,
    COUNT(*) AS total_items,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM workspace.olist.order_items oi
JOIN workspace.olist.products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC;


-- Top 10 product categories by sales
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM workspace.olist.order_items oi
JOIN workspace.olist.products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC
LIMIT 10;


-- Average item price by category
SELECT
    p.product_category_name,
    COUNT(*) AS total_items,
    ROUND(AVG(oi.price), 2) AS average_item_price
FROM workspace.olist.order_items oi
JOIN workspace.olist.products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
HAVING COUNT(*) >= 500
ORDER BY average_item_price DESC;


-- Missing product categories
SELECT
    COUNT(*) AS missing_category_items,
    COUNT(DISTINCT oi.product_id) AS missing_category_products,
    ROUND(SUM(oi.price), 2) AS missing_category_sales
FROM workspace.olist.order_items oi
JOIN workspace.olist.products p
    ON oi.product_id = p.product_id
WHERE p.product_category_name IS NULL;