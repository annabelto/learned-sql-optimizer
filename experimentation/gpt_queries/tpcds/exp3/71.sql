WITH sales_data AS (
    SELECT ws_ext_sales_price AS ext_price, ws_sold_date_sk AS sold_date_sk, ws_item_sk AS sold_item_sk, ws_sold_time_sk AS time_sk
    FROM web_sales
    JOIN date_dim ON d_date_sk = ws_sold_date_sk
    WHERE d_moy = 12 AND d_year = 2002

    UNION ALL

    SELECT cs_ext_sales_price AS ext_price, cs_sold_date_sk AS sold_date_sk, cs_item_sk AS sold_item_sk, cs_sold_time_sk AS time_sk
    FROM catalog_sales
    JOIN date_dim ON d_date_sk = cs_sold_date_sk
    WHERE d_moy = 12 AND d_year = 2002

    UNION ALL

    SELECT ss_ext_sales_price AS ext_price, ss_sold_date_sk AS sold_date_sk, ss_item_sk AS sold_item_sk, ss_sold_time_sk AS time_sk
    FROM store_sales
    JOIN date_dim ON d_date_sk = ss_sold_date_sk
    WHERE d_moy = 12 AND d_year = 2002
),
time_filtered AS (
    SELECT t_time_sk, t_hour, t_minute
    FROM time_dim
    WHERE t_meal_time = 'breakfast' OR t_meal_time = 'dinner'
)
SELECT i_brand_id AS brand_id, i_brand AS brand, t_hour, t_minute, SUM(ext_price) AS ext_price
FROM item
JOIN sales_data ON sold_item_sk = i_item_sk
JOIN time_filtered ON time_sk = t_time_sk
WHERE i_manager_id = 1
GROUP BY i_brand, i_brand_id, t_hour, t_minute
ORDER BY ext_price DESC, i_brand_id;