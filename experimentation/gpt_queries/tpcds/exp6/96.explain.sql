explain select COUNT(*)
FROM store_sales
JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk AND time_dim.t_hour = 8 AND time_dim.t_minute >= 30
JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk AND household_demographics.hd_dep_count = 0
JOIN store ON ss_store_sk = store.s_store_sk AND store.s_store_name = 'ese'
ORDER BY COUNT(*)
LIMIT 100;SELECT COUNT(*)
FROM store_sales
JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk AND time_dim.t_hour = 8 AND time_dim.t_minute >= 30
JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk AND household_demographics.hd_dep_count = 0
JOIN store ON ss_store_sk = store.s_store_sk AND store.s_store_name = 'ese'
ORDER BY COUNT(*)
LIMIT 100;