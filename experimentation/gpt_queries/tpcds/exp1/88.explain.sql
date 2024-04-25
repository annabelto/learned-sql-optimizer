explain select
    COUNT(*) FILTER (WHERE t_hour = 8 AND t_minute >= 30) AS h8_30_to_9,
    COUNT(*) FILTER (WHERE t_hour = 9 AND t_minute < 30) AS h9_to_9_30,
    COUNT(*) FILTER (WHERE t_hour = 9 AND t_minute >= 30) AS h9_30_to_10,
    COUNT(*) FILTER (WHERE t_hour = 10 AND t_minute < 30) AS h10_to_10_30,
    COUNT(*) FILTER (WHERE t_hour = 10 AND t_minute >= 30) AS h10_30_to_11,
    COUNT(*) FILTER (WHERE t_hour = 11 AND t_minute < 30) AS h11_to_11_30,
    COUNT(*) FILTER (WHERE t_hour = 11 AND t_minute >= 30) AS h11_30_to_12,
    COUNT(*) FILTER (WHERE t_hour = 12 AND t_minute < 30) AS h12_to_12_30
FROM
    store_sales
JOIN
    household_demographics ON ss_hdemo_sk = hd_demo_sk
JOIN
    time_dim ON ss_sold_time_sk = t_time_sk
JOIN
    store ON ss_store_sk = s_store_sk
WHERE
    s_store_name = 'ese'
    AND (
        (hd_dep_count = 0 AND hd_vehicle_count <= 2) OR
        (hd_dep_count = -1 AND hd_vehicle_count <= 1) OR
        (hd_dep_count = 3 AND hd_vehicle_count <= 5)
    )SELECT
    COUNT(*) FILTER (WHERE t_hour = 8 AND t_minute >= 30) AS h8_30_to_9,
    COUNT(*) FILTER (WHERE t_hour = 9 AND t_minute < 30) AS h9_to_9_30,
    COUNT(*) FILTER (WHERE t_hour = 9 AND t_minute >= 30) AS h9_30_to_10,
    COUNT(*) FILTER (WHERE t_hour = 10 AND t_minute < 30) AS h10_to_10_30,
    COUNT(*) FILTER (WHERE t_hour = 10 AND t_minute >= 30) AS h10_30_to_11,
    COUNT(*) FILTER (WHERE t_hour = 11 AND t_minute < 30) AS h11_to_11_30,
    COUNT(*) FILTER (WHERE t_hour = 11 AND t_minute >= 30) AS h11_30_to_12,
    COUNT(*) FILTER (WHERE t_hour = 12 AND t_minute < 30) AS h12_to_12_30
FROM
    store_sales
JOIN
    household_demographics ON ss_hdemo_sk = hd_demo_sk
JOIN
    time_dim ON ss_sold_time_sk = t_time_sk
JOIN
    store ON ss_store_sk = s_store_sk
WHERE
    s_store_name = 'ese'
    AND (
        (hd_dep_count = 0 AND hd_vehicle_count <= 2) OR
        (hd_dep_count = -1 AND hd_vehicle_count <= 1) OR
        (hd_dep_count = 3 AND hd_vehicle_count <= 5)
    )