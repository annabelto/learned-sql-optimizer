WITH date_bounds AS (
    SELECT 
        cast('1999-06-22' as date) AS exact_date,
        cast('1999-06-22' as date) - 30 AS start_date,
        cast('1999-06-22' as date) + 30 AS end_date
),
filtered_items AS (
    SELECT 
        i_item_id, 
        i_item_sk
    FROM 
        item
    WHERE 
        i_current_price BETWEEN 0.99 AND 1.49
)
explain select 
    w_warehouse_name,
    i_item_id,
    inv_before,
    inv_after
FROM (
    SELECT 
        w_warehouse_name,
        i_item_id,
        SUM(CASE WHEN d_date < date_bounds.exact_date THEN inv_quantity_on_hand ELSE 0 END) AS inv_before,
        SUM(CASE WHEN d_date >= date_bounds.exact_date THEN inv_quantity_on_hand ELSE 0 END) AS inv_after
    FROM 
        inventory
    JOIN 
        warehouse ON inv_warehouse_sk = w_warehouse_sk
    JOIN 
        filtered_items ON i_item_sk = inv_item_sk
    JOIN 
        date_dim ON inv_date_sk = d_date_sk
    JOIN 
        date_bounds ON d_date BETWEEN date_bounds.start_date AND date_bounds.end_date
    GROUP BY 
        w_warehouse_name, i_item_id
) AS subquery
WHERE 
    CASE WHEN inv_before > 0 THEN inv_after / inv_before ELSE NULL END BETWEEN 2.0/3.0 AND 3.0/2.0
ORDER BY 
    w_warehouse_name, i_item_id
LIMIT 100;WITH date_bounds AS (
    SELECT 
        cast('1999-06-22' as date) AS exact_date,
        cast('1999-06-22' as date) - 30 AS start_date,
        cast('1999-06-22' as date) + 30 AS end_date
),
filtered_items AS (
    SELECT 
        i_item_id, 
        i_item_sk
    FROM 
        item
    WHERE 
        i_current_price BETWEEN 0.99 AND 1.49
)
SELECT 
    w_warehouse_name,
    i_item_id,
    inv_before,
    inv_after
FROM (
    SELECT 
        w_warehouse_name,
        i_item_id,
        SUM(CASE WHEN d_date < date_bounds.exact_date THEN inv_quantity_on_hand ELSE 0 END) AS inv_before,
        SUM(CASE WHEN d_date >= date_bounds.exact_date THEN inv_quantity_on_hand ELSE 0 END) AS inv_after
    FROM 
        inventory
    JOIN 
        warehouse ON inv_warehouse_sk = w_warehouse_sk
    JOIN 
        filtered_items ON i_item_sk = inv_item_sk
    JOIN 
        date_dim ON inv_date_sk = d_date_sk
    JOIN 
        date_bounds ON d_date BETWEEN date_bounds.start_date AND date_bounds.end_date
    GROUP BY 
        w_warehouse_name, i_item_id
) AS subquery
WHERE 
    CASE WHEN inv_before > 0 THEN inv_after / inv_before ELSE NULL END BETWEEN 2.0/3.0 AND 3.0/2.0
ORDER BY 
    w_warehouse_name, i_item_id
LIMIT 100;