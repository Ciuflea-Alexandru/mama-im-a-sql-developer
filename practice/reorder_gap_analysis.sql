WITH CustomerOrderDates AS (
    SELECT 
        o1.customer_id,
        o1.order_id AS current_order_id,
        o1.order_date AS current_order_date,
        -- Find previous orders for the same customer using a non-equality join condition
        o2.order_id AS previous_order_id,
        o2.order_date AS previous_order_date
    FROM orders o1
    JOIN orders o2 ON o1.customer_id = o2.customer_id
    -- This condition ensures o2 is strictly chronologically *before* o1
    WHERE o2.order_date < o1.order_date
),
RankedGaps AS (
    SELECT 
        customer_id,
        current_order_id,
        current_order_date,
        previous_order_date,
        -- Calculate the exact number of days between the current and previous order
        (current_order_date - previous_order_date) AS days_since_last_order,
        -- Use ROW_NUMBER to pick *only* the immediately preceding order, skipping older ones
        ROW_NUMBER() OVER (
            PARTITION BY customer_id, current_order_id 
            ORDER BY previous_order_date DESC
        ) AS rn
    FROM CustomerOrderDates
)
SELECT 
    customer_id,
    current_order_id,
    current_order_date,
    previous_order_date,
    days_since_last_order
FROM RankedGaps
WHERE rn = 1
ORDER BY customer_id, current_order_date;