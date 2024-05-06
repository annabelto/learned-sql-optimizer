SELECT
    (SELECT COUNT(*)
     FROM store_sales
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 8 AND time_dim.t_minute >= 30
       AND store.s_store_name = 'ese'
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2)
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1)
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))) AS h8_30_to_9,
    (SELECT COUNT(*)
     FROM store_sales
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 9 AND time_dim.t_minute < 30
       AND store.s_store_name = 'ese'
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2)
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1)
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))) AS h9_to_9_30,
    (SELECT COUNT(*)
     FROM store_sales
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 9 AND time_dim.t_minute >= 30
       AND store.s_store_name = 'ese'
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2)
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1)
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))) AS h9_30_to_10,
    (SELECT COUNT(*)
     FROM store_sales
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 10 AND time_dim.t_minute < 30
       AND store.s_store_name = 'ese'
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2)
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1)
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))) AS h10_to_10_30,
    (SELECT COUNT(*)
     FROM store_sales
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 10 AND time_dim.t_minute >= 30
       AND store.s_store_name = 'ese'
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2)
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1)
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))) AS h10_30_to_11,
    (SELECT COUNT(*)
     FROM store_sales
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 11 AND time_dim.t_minute < 30
       AND store.s_store_name = 'ese'
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2)
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1)
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))) AS h11_to_11_30,
    (SELECT COUNT(*)
     FROM store_sales
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 11 AND time_dim.t_minute >= 30
       AND store.s_store_name = 'ese'
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2)
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1)
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))) AS h11_30_to_12,
    (SELECT COUNT(*)
     FROM store_sales
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 12 AND time_dim.t_minute < 30
       AND store.s_store_name = 'ese'
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2)
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1)
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))) AS h12_to_12_30;