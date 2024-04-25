explain select i.i_brand_id AS brand_id, i.i_brand AS brand, i.i_manufact_id, i.i_manufact, SUM(ss.ss_ext_sales_price) AS ext_price
FROM item i
JOIN store_sales ss ON ss.ss_item_sk = i.i_item_sk
JOIN date_dim d ON d.d_date_sk = ss.ss_sold_date_sk AND d.d_moy = 11 AND d.d_year = 2002
JOIN customer c ON ss.ss_customer_sk = c.c_customer_sk
JOIN customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk AND substr(ca.ca_zip, 1, 5) <> substr(s.s_zip, 1, 5)
WHERE i.i_manager_id = 14
GROUP BY i.i_brand, i.i_brand_id, i.i_manufact_id, i.i_manufact
ORDER BY ext_price DESC, i.i_brand, i.i_brand_id, i.i_manufact_id, i.i_manufact
LIMIT 100;SELECT i.i_brand_id AS brand_id, i.i_brand AS brand, i.i_manufact_id, i.i_manufact, SUM(ss.ss_ext_sales_price) AS ext_price
FROM item i
JOIN store_sales ss ON ss.ss_item_sk = i.i_item_sk
JOIN date_dim d ON d.d_date_sk = ss.ss_sold_date_sk AND d.d_moy = 11 AND d.d_year = 2002
JOIN customer c ON ss.ss_customer_sk = c.c_customer_sk
JOIN customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk AND substr(ca.ca_zip, 1, 5) <> substr(s.s_zip, 1, 5)
WHERE i.i_manager_id = 14
GROUP BY i.i_brand, i.i_brand_id, i.i_manufact_id, i.i_manufact
ORDER BY ext_price DESC, i.i_brand, i.i_brand_id, i.i_manufact_id, i.i_manufact
LIMIT 100;