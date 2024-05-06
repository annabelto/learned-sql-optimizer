explain select i.i_brand_id AS brand_id, 
       i.i_brand AS brand, 
       SUM(ss.ss_ext_sales_price) AS ext_price
FROM item i
JOIN store_sales ss ON i.i_item_sk = ss.ss_item_sk
JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
WHERE i.i_manager_id = 52
  AND d.d_moy = 11
  AND d.d_year = 2000
GROUP BY i.i_brand, i.i_brand_id
ORDER BY ext_price DESC, i.i_brand_id
LIMIT 100;SELECT i.i_brand_id AS brand_id, 
       i.i_brand AS brand, 
       SUM(ss.ss_ext_sales_price) AS ext_price
FROM item i
JOIN store_sales ss ON i.i_item_sk = ss.ss_item_sk
JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
WHERE i.i_manager_id = 52
  AND d.d_moy = 11
  AND d.d_year = 2000
GROUP BY i.i_brand, i.i_brand_id
ORDER BY ext_price DESC, i.i_brand_id
LIMIT 100;