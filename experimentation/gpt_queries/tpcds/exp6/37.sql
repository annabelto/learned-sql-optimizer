SELECT i_item_id, i_item_desc, i_current_price 
FROM item
JOIN catalog_sales ON item.i_item_sk = catalog_sales.cs_item_sk
JOIN inventory ON item.i_item_sk = inventory.inv_item_sk
JOIN date_dim ON inventory.inv_date_sk = date_dim.d_date_sk
WHERE i_current_price BETWEEN 29 AND 59
AND i_manufact_id IN (705, 742, 777, 944)
AND inv_quantity_on_hand BETWEEN 100 AND 500
AND d_date BETWEEN CAST('2002-03-29' AS DATE) AND (CAST('2002-03-29' AS DATE) + 60)
GROUP BY i_item_id, i_item_desc, i_current_price 
ORDER BY i_item_id 
LIMIT 100;