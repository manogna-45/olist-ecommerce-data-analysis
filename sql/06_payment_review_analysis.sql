-- Olist E-Commerce Analysis
-- Payment and Review Analysis


-- Payment methods by value
SELECT
    payment_type,
    COUNT(*) AS payment_count,
    ROUND(SUM(payment_value), 2) AS total_payment_value,
    ROUND(AVG(payment_value), 2) AS average_payment_value
FROM workspace.olist.order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


-- Review score distribution
SELECT
    CAST(review_score AS INT) AS review_score,
    COUNT(*) AS review_count
FROM workspace.olist.order_reviews
WHERE review_score RLIKE '^[1-5]$'
GROUP BY CAST(review_score AS INT)
ORDER BY review_score;


-- Average review score: on-time vs late delivery
SELECT
    CASE
        WHEN o.order_delivered_customer_date IS NULL
            THEN 'Unknown'
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
            THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
    COUNT(*) AS reviews,
    ROUND(AVG(CAST(r.review_score AS INT)), 2) AS average_review_score
FROM workspace.olist.order_reviews r
JOIN workspace.olist.orders o
    ON r.order_id = o.order_id
WHERE r.review_score RLIKE '^[1-5]$'
GROUP BY
    CASE
        WHEN o.order_delivered_customer_date IS NULL
            THEN 'Unknown'
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
            THEN 'Late'
        ELSE 'On Time'
    END
ORDER BY average_review_score DESC;