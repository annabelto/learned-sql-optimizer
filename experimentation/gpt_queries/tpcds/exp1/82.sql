SELECT i_item_id, i_item_desc, i_current_price
FROM item
JOIN inventory ON inv_item_sk = i_item_sk
JOIN date_dim ON d_date_sk = inv_date_sk
JOIN store_sales ON ss_item_sk = i_item_sk
WHERE i_current_price BETWEEN 58 AND 88
  AND d_date BETWEEN CAST('2001-01-13' AS DATE) AND (CAST('2001-01-13' AS DATE) + 60)
  AND i_manufact_id IN (259, 559, 580, 485)
  AND inv_quantity_on_hand BETWEEN 100 AND 500
GROUP BY i_item_id, i_item_desc, i_current_price
ORDER BY i_item_id
LIMIT 100;