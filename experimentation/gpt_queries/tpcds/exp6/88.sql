SELECT s1.h8_30_to_9, s2.h9_to_9_30, s3.h9_30_to_10, s4.h10_to_10_30, s5.h10_30_to_11, s6.h11_to_11_30, s7.h11_30_to_12, s8.h12_to_12_30
FROM 
    (SELECT COUNT(*) AS h8_30_to_9 
     FROM store_sales
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 8 
       AND time_dim.t_minute >= 30 
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2) 
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1) 
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))
       AND store.s_store_name = 'ese') s1
CROSS JOIN 
    (SELECT COUNT(*) AS h9_to_9_30 
     FROM store_sales
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 9 
       AND time_dim.t_minute < 30 
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2) 
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1) 
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))
       AND store.s_store_name = 'ese') s2
CROSS JOIN 
    (SELECT COUNT(*) AS h9_30_to_10 
     FROM store_sales
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 9 
       AND time_dim.t_minute >= 30 
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2) 
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1) 
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))
       AND store.s_store_name = 'ese') s3
CROSS JOIN 
    (SELECT COUNT(*) AS h10_to_10_30 
     FROM store_sales
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 10 
       AND time_dim.t_minute < 30 
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2) 
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1) 
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))
       AND store.s_store_name = 'ese') s4
CROSS JOIN 
    (SELECT COUNT(*) AS h10_30_to_11 
     FROM store_sales
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 10 
       AND time_dim.t_minute >= 30 
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2) 
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1) 
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))
       AND store.s_store_name = 'ese') s5
CROSS JOIN 
    (SELECT COUNT(*) AS h11_to_11_30 
     FROM store_sales
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 11 
       AND time_dim.t_minute < 30 
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2) 
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1) 
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))
       AND store.s_store_name = 'ese') s6
CROSS JOIN 
    (SELECT COUNT(*) AS h11_30_to_12 
     FROM store_sales
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 11 
       AND time_dim.t_minute >= 30 
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2) 
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1) 
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))
       AND store.s_store_name = 'ese') s7
CROSS JOIN 
    (SELECT COUNT(*) AS h12_to_12_30 
     FROM store_sales
     JOIN time_dim ON ss_sold_time_sk = time_dim.t_time_sk
     JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
     JOIN store ON ss_store_sk = store.s_store_sk
     WHERE time_dim.t_hour = 12 
       AND time_dim.t_minute < 30 
       AND ((household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2) 
            OR (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1) 
            OR (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5))
       AND store.s_store_name = 'ese') s8;