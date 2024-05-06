SELECT 
    x.w_warehouse_name, 
    x.i_item_id, 
    x.inv_before, 
    x.inv_after
FROM (
    SELECT 
        w.w_warehouse_name, 
        i.i_item_id, 
        SUM(CASE WHEN CAST(d.d_date AS DATE) < CAST('1999-06-22' AS DATE) THEN inv.inv_quantity_on_hand ELSE 0 END) AS inv_before, 
        SUM(CASE WHEN CAST(d.d_date AS DATE) >= CAST('1999-06-22' AS DATE) THEN inv.inv_quantity_on_hand ELSE 0 END) AS inv_after
    FROM 
        inventory inv
        JOIN warehouse w ON inv.inv_warehouse_sk = w.w_warehouse_sk
        JOIN item i ON i.i_item_sk = inv.inv_item_sk
        JOIN date_dim d ON inv.inv_date_sk = d.d_date_sk
    WHERE 
        i.i_current_price BETWEEN 0.99 AND 1.49
        AND d.d_date BETWEEN CAST('1999-06-22' AS DATE) - INTERVAL '30 days' AND CAST('1999-06-22' AS DATE) + INTERVAL '30 days'
    GROUP BY 
        w.w_warehouse_name, 
        i.i_item_id
) x
WHERE 
    (CASE WHEN x.inv_before > 0 THEN x.inv_after / x.inv_before ELSE NULL END) BETWEEN 2.0/3.0 AND 3.0/2.0
ORDER BY 
    x.w_warehouse_name, 
    x.i_item_id
LIMIT 100;