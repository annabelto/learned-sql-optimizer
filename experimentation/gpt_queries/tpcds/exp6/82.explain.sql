explain select i_item_id, i_item_desc, i_current_price 
FROM item
JOIN inventory ON inventory.inv_item_sk = item.i_item_sk
JOIN date_dim ON date_dim.d_date_sk = inventory.inv_date_sk
JOIN store_sales ON store_sales.ss_item_sk = item.i_item_sk
WHERE item.i_current_price BETWEEN 58 AND 88
AND item.i_manufact_id IN (259, 559, 580, 485)
AND inventory.inv_quantity_on_hand BETWEEN 100 AND 500
AND date_dim.d_date BETWEEN CAST('2001-01-13' AS DATE) AND (CAST('2001-01-13' AS DATE) + 60)
GROUP BY i_item_id, i_item_desc, i_current_price 
ORDER BY i_item_id 
LIMIT 100;SELECT i_item_id, i_item_desc, i_current_price 
FROM item
JOIN inventory ON inventory.inv_item_sk = item.i_item_sk
JOIN date_dim ON date_dim.d_date_sk = inventory.inv_date_sk
JOIN store_sales ON store_sales.ss_item_sk = item.i_item_sk
WHERE item.i_current_price BETWEEN 58 AND 88
AND item.i_manufact_id IN (259, 559, 580, 485)
AND inventory.inv_quantity_on_hand BETWEEN 100 AND 500
AND date_dim.d_date BETWEEN CAST('2001-01-13' AS DATE) AND (CAST('2001-01-13' AS DATE) + 60)
GROUP BY i_item_id, i_item_desc, i_current_price 
ORDER BY i_item_id 
LIMIT 100;