explain select i_item_id, s_state, grouping(s_state) AS g_state, 
       avg(ss_quantity) AS agg1, avg(ss_list_price) AS agg2, 
       avg(ss_coupon_amt) AS agg3, avg(ss_sales_price) AS agg4 
FROM 
  (SELECT * FROM date_dim WHERE d_year = 1999) date_dim
JOIN 
  (SELECT * FROM customer_demographics WHERE cd_gender = 'M' AND cd_marital_status = 'W' AND cd_education_status = 'Secondary') customer_demographics 
  ON ss_cdemo_sk = cd_demo_sk
JOIN 
  store_sales ON ss_sold_date_sk = d_date_sk
JOIN 
  item ON ss_item_sk = i_item_sk
JOIN 
  (SELECT * FROM store WHERE s_state = 'TN') store ON ss_store_sk = s_store_sk
GROUP BY ROLLUP (i_item_id, s_state) 
ORDER BY i_item_id, s_state 
LIMIT 100;SELECT i_item_id, s_state, grouping(s_state) AS g_state, 
       avg(ss_quantity) AS agg1, avg(ss_list_price) AS agg2, 
       avg(ss_coupon_amt) AS agg3, avg(ss_sales_price) AS agg4 
FROM 
  (SELECT * FROM date_dim WHERE d_year = 1999) date_dim
JOIN 
  (SELECT * FROM customer_demographics WHERE cd_gender = 'M' AND cd_marital_status = 'W' AND cd_education_status = 'Secondary') customer_demographics 
  ON ss_cdemo_sk = cd_demo_sk
JOIN 
  store_sales ON ss_sold_date_sk = d_date_sk
JOIN 
  item ON ss_item_sk = i_item_sk
JOIN 
  (SELECT * FROM store WHERE s_state = 'TN') store ON ss_store_sk = s_store_sk
GROUP BY ROLLUP (i_item_id, s_state) 
ORDER BY i_item_id, s_state 
LIMIT 100;