SELECT count(*)
FROM store_sales
JOIN store ON store_sales.ss_store_sk = store.s_store_sk AND store.s_store_name = 'ese'
JOIN household_demographics ON store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk AND household_demographics.hd_dep_count = 0
JOIN time_dim ON store_sales.ss_sold_time_sk = time_dim.t_time_sk AND time_dim.t_hour = 8 AND time_dim.t_minute >= 30
LIMIT 100;