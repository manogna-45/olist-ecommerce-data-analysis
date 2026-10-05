-- Olist E-Commerce Analysis
-- Delivery Analysis


-- Overall delivery performance
SELECT
    COUNT(DISTINCT CASE
        WHEN order_delivered_customer_date IS NOT NULL
        THEN order_id
    END) AS delivered_orders,
    COUNT(DISTINCT CASE
        WHEN order_delivered_customer_date > order_estimated_delivery_date
        THEN order_id
    END) AS late_orders,
    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN order_delivered_customer_date > order_estimated_delivery_date
            THEN order_id
        END)
        /
        COUNT(DISTINCT CASE
            WHEN order_delivered_customer_date IS NOT NULL
            THEN order_id
        END),
        2
    ) AS late_delivery_percentage
FROM workspace.olist.orders;


-- Average delivery time
SELECT
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ),
        2
    ) AS average_delivery_days,
    MIN(
        DATEDIFF(
            order_delivered_customer_date,
            order_purchase_timestamp
        )
    ) AS minimum_delivery_days,
    MAX(
        DATEDIFF(
            order_delivered_customer_date,
            order_purchase_timestamp
        )
    ) AS maximum_delivery_days
FROM workspace.olist.orders
WHERE order_delivered_customer_date IS NOT NULL;


-- Late delivery by state
SELECT
    c.customer_state,
    COUNT(*) AS delivered_orders,
    SUM(
        CASE
            WHEN o.order_delivered_customer_date >
                 o.order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS late_orders,
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN o.order_delivered_customer_date >
                     o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_delivery_percentage
FROM workspace.olist.orders o
JOIN workspace.olist.customers c
    ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
HAVING COUNT(*) >= 100
ORDER BY late_delivery_percentage DESC;