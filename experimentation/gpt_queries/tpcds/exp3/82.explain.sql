explain select i_item_id, i_item_desc, i_current_price 
FROM item
JOIN inventory ON inv_item_sk = i_item_sk AND inv_quantity_on_hand BETWEEN 100 AND 500
JOIN date_dim ON d_date_sk = inv_date_sk AND d_date BETWEEN '2001-01-13'::date AND '2001-03-14'::date
JOIN store_sales ON ss_item_sk = i_item_sk
WHERE i_current_price BETWEEN 58 AND 88
  AND i_manufact_id IN (259, 559, 580, 485)
GROUP BY i_item_id, i_item_desc, i_current_price 
ORDER BY i_item_id 
LIMIT 100;SELECT i_item_id, i_item_desc, i_current_price 
FROM item
JOIN inventory ON inv_item_sk = i_item_sk AND inv_quantity_on_hand BETWEEN 100 AND 500
JOIN date_dim ON d_date_sk = inv_date_sk AND d_date BETWEEN '2001-01-13'::date AND '2001-03-14'::date
JOIN store_sales ON ss_item_sk = i_item_sk
WHERE i_current_price BETWEEN 58 AND 88
  AND i_manufact_id IN (259, 559, 580, 485)
GROUP BY i_item_id, i_item_desc, i_current_price 
ORDER BY i_item_id 
LIMIT 100;