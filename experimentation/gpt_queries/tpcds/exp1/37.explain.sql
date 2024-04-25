explain select 
    i_item_id,
    i_item_desc,
    i_current_price
FROM 
    item
JOIN 
    inventory ON inv_item_sk = i_item_sk AND inv_quantity_on_hand BETWEEN 100 AND 500
JOIN 
    date_dim ON d_date_sk = inv_date_sk AND d_date BETWEEN CAST('2002-03-29' AS DATE) AND (CAST('2002-03-29' AS DATE) + INTERVAL '60 days')
JOIN 
    catalog_sales ON cs_item_sk = i_item_sk
WHERE 
    i_current_price BETWEEN 29 AND 59
    AND i_manufact_id IN (705, 742, 777, 944)
GROUP BY 
    i_item_id, i_item_desc, i_current_price
ORDER BY 
    i_item_id
LIMIT 100;SELECT 
    i_item_id,
    i_item_desc,
    i_current_price
FROM 
    item
JOIN 
    inventory ON inv_item_sk = i_item_sk AND inv_quantity_on_hand BETWEEN 100 AND 500
JOIN 
    date_dim ON d_date_sk = inv_date_sk AND d_date BETWEEN CAST('2002-03-29' AS DATE) AND (CAST('2002-03-29' AS DATE) + INTERVAL '60 days')
JOIN 
    catalog_sales ON cs_item_sk = i_item_sk
WHERE 
    i_current_price BETWEEN 29 AND 59
    AND i_manufact_id IN (705, 742, 777, 944)
GROUP BY 
    i_item_id, i_item_desc, i_current_price
ORDER BY 
    i_item_id
LIMIT 100;