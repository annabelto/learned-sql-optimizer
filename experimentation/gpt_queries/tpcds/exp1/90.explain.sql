WITH filtered_web_sales AS (
    SELECT ws_sold_time_sk, ws_ship_hdemo_sk, ws_web_page_sk
    FROM web_sales
    WHERE ws_sold_time_sk IS NOT NULL AND ws_ship_hdemo_sk IS NOT NULL AND ws_web_page_sk IS NOT NULL
),
common_join AS (
    SELECT ws_sold_time_sk
    FROM filtered_web_sales
    JOIN household_demographics ON ws_ship_hdemo_sk = household_demographics.hd_demo_sk
    JOIN web_page ON ws_web_page_sk = web_page.wp_web_page_sk
    WHERE household_demographics.hd_dep_count = 6
      AND web_page.wp_char_count BETWEEN 5000 AND 5200
),
am_counts AS (
    SELECT COUNT(*) AS amc
    FROM common_join
    JOIN time_dim ON common_join.ws_sold_time_sk = time_dim.t_time_sk
    WHERE time_dim.t_hour = 12
),
pm_counts AS (
    SELECT COUNT(*) AS pmc
    FROM common_join
    JOIN time_dim ON common_join.ws_sold_time_sk = time_dim.t_time_sk
    WHERE time_dim.t_hour = 14
)
explain select CAST(amc AS DECIMAL(15,4)) / CAST(pmc AS DECIMAL(15,4)) AS am_pm_ratio
FROM am_counts, pm_counts
LIMIT 100;WITH filtered_web_sales AS (
    SELECT ws_sold_time_sk, ws_ship_hdemo_sk, ws_web_page_sk
    FROM web_sales
    WHERE ws_sold_time_sk IS NOT NULL AND ws_ship_hdemo_sk IS NOT NULL AND ws_web_page_sk IS NOT NULL
),
common_join AS (
    SELECT ws_sold_time_sk
    FROM filtered_web_sales
    JOIN household_demographics ON ws_ship_hdemo_sk = household_demographics.hd_demo_sk
    JOIN web_page ON ws_web_page_sk = web_page.wp_web_page_sk
    WHERE household_demographics.hd_dep_count = 6
      AND web_page.wp_char_count BETWEEN 5000 AND 5200
),
am_counts AS (
    SELECT COUNT(*) AS amc
    FROM common_join
    JOIN time_dim ON common_join.ws_sold_time_sk = time_dim.t_time_sk
    WHERE time_dim.t_hour = 12
),
pm_counts AS (
    SELECT COUNT(*) AS pmc
    FROM common_join
    JOIN time_dim ON common_join.ws_sold_time_sk = time_dim.t_time_sk
    WHERE time_dim.t_hour = 14
)
SELECT CAST(amc AS DECIMAL(15,4)) / CAST(pmc AS DECIMAL(15,4)) AS am_pm_ratio
FROM am_counts, pm_counts
LIMIT 100;