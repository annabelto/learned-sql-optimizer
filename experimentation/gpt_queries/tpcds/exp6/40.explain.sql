explain select 
    w_state,
    i_item_id,
    SUM(CASE 
            WHEN (CAST(d_date AS DATE) < CAST('2001-05-02' AS DATE)) 
            THEN cs_sales_price - COALESCE(cr_refunded_cash, 0) 
            ELSE 0 
        END) AS sales_before,
    SUM(CASE 
            WHEN (CAST(d_date AS DATE) >= CAST('2001-05-02' AS DATE)) 
            THEN cs_sales_price - COALESCE(cr_refunded_cash, 0) 
            ELSE 0 
        END) AS sales_after
FROM 
    item
JOIN 
    catalog_sales ON i_item_sk = cs_item_sk
LEFT OUTER JOIN 
    catalog_returns ON cs_order_number = cr_order_number AND cs_item_sk = cr_item_sk
JOIN 
    warehouse ON cs_warehouse_sk = w_warehouse_sk
JOIN 
    date_dim ON cs_sold_date_sk = d_date_sk
WHERE 
    i_current_price BETWEEN 0.99 AND 1.49
    AND d_date BETWEEN (CAST('2001-05-02' AS DATE) - 30) AND (CAST('2001-05-02' AS DATE) + 30)
GROUP BY 
    w_state, i_item_id
ORDER BY 
    w_state, i_item_id
LIMIT 100;SELECT 
    w_state,
    i_item_id,
    SUM(CASE 
            WHEN (CAST(d_date AS DATE) < CAST('2001-05-02' AS DATE)) 
            THEN cs_sales_price - COALESCE(cr_refunded_cash, 0) 
            ELSE 0 
        END) AS sales_before,
    SUM(CASE 
            WHEN (CAST(d_date AS DATE) >= CAST('2001-05-02' AS DATE)) 
            THEN cs_sales_price - COALESCE(cr_refunded_cash, 0) 
            ELSE 0 
        END) AS sales_after
FROM 
    item
JOIN 
    catalog_sales ON i_item_sk = cs_item_sk
LEFT OUTER JOIN 
    catalog_returns ON cs_order_number = cr_order_number AND cs_item_sk = cr_item_sk
JOIN 
    warehouse ON cs_warehouse_sk = w_warehouse_sk
JOIN 
    date_dim ON cs_sold_date_sk = d_date_sk
WHERE 
    i_current_price BETWEEN 0.99 AND 1.49
    AND d_date BETWEEN (CAST('2001-05-02' AS DATE) - 30) AND (CAST('2001-05-02' AS DATE) + 30)
GROUP BY 
    w_state, i_item_id
ORDER BY 
    w_state, i_item_id
LIMIT 100;