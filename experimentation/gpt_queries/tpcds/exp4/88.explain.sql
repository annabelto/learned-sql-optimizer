WITH filtered_sales AS (
    SELECT ss_sold_time_sk, ss_store_sk
    FROM store_sales
    JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
    JOIN store ON ss_store_sk = store.s_store_sk
    WHERE store.s_store_name = 'ese'
      AND (
          (household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2) OR
          (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1) OR
          (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5)
      )
),
time_filtered AS (
    SELECT
        COUNT(*) FILTER (WHERE t_hour = 8 AND t_minute >= 30) AS h8_30_to_9,
        COUNT(*) FILTER (WHERE t_hour = 9 AND t_minute < 30) AS h9_to_9_30,
        COUNT(*) FILTER (WHERE t_hour = 9 AND t_minute >= 30) AS h9_30_to_10,
        COUNT(*) FILTER (WHERE t_hour = 10 AND t_minute < 30) AS h10_to_10_30,
        COUNT(*) FILTER (WHERE t_hour = 10 AND t_minute >= 30) AS h10_30_to_11,
        COUNT(*) FILTER (WHERE t_hour = 11 AND t_minute < 30) AS h11_to_11_30,
        COUNT(*) FILTER (WHERE t_hour = 11 AND t_minute >= 30) AS h11_30_to_12,
        COUNT(*) FILTER (WHERE t_hour = 12 AND t_minute < 30) AS h12_to_12_30
    FROM time_dim
    JOIN filtered_sales ON time_dim.t_time_sk = filtered_sales.ss_sold_time_sk
)
explain select * FROM time_filtered;WITH filtered_sales AS (
    SELECT ss_sold_time_sk, ss_store_sk
    FROM store_sales
    JOIN household_demographics ON ss_hdemo_sk = household_demographics.hd_demo_sk
    JOIN store ON ss_store_sk = store.s_store_sk
    WHERE store.s_store_name = 'ese'
      AND (
          (household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count <= 2) OR
          (household_demographics.hd_dep_count = -1 AND household_demographics.hd_vehicle_count <= 1) OR
          (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count <= 5)
      )
),
time_filtered AS (
    SELECT
        COUNT(*) FILTER (WHERE t_hour = 8 AND t_minute >= 30) AS h8_30_to_9,
        COUNT(*) FILTER (WHERE t_hour = 9 AND t_minute < 30) AS h9_to_9_30,
        COUNT(*) FILTER (WHERE t_hour = 9 AND t_minute >= 30) AS h9_30_to_10,
        COUNT(*) FILTER (WHERE t_hour = 10 AND t_minute < 30) AS h10_to_10_30,
        COUNT(*) FILTER (WHERE t_hour = 10 AND t_minute >= 30) AS h10_30_to_11,
        COUNT(*) FILTER (WHERE t_hour = 11 AND t_minute < 30) AS h11_to_11_30,
        COUNT(*) FILTER (WHERE t_hour = 11 AND t_minute >= 30) AS h11_30_to_12,
        COUNT(*) FILTER (WHERE t_hour = 12 AND t_minute < 30) AS h12_to_12_30
    FROM time_dim
    JOIN filtered_sales ON time_dim.t_time_sk = filtered_sales.ss_sold_time_sk
)
SELECT * FROM time_filtered;