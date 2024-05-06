SELECT 
    i_item_id,
    i_item_desc,
    i_current_price
FROM 
    item
JOIN 
    inventory ON inv_item_sk = i_item_sk
JOIN 
    date_dim ON d_date_sk = inv_date_sk
JOIN 
    catalog_sales ON cs_item_sk = i_item_sk
WHERE 
    i_current_price BETWEEN 29 AND 59
    AND d_date BETWEEN '2002-03-29'::date AND ('2002-03-29'::date + INTERVAL '60 days')
    AND i_manufact_id IN (705, 742, 777, 944)
    AND inv_quantity_on_hand BETWEEN 100 AND 500
GROUP BY 
    i_item_id, i_item_desc, i_current_price
ORDER BY 
    i_item_id
LIMIT 100;