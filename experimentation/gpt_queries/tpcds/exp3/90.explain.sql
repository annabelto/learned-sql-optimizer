WITH amc AS (
    SELECT COUNT(*) AS amc
    FROM web_sales
    JOIN household_demographics ON ws_ship_hdemo_sk = household_demographics.hd_demo_sk
    JOIN time_dim ON ws_sold_time_sk = time_dim.t_time_sk
    JOIN web_page ON ws_web_page_sk = web_page.wp_web_page_sk
    WHERE time_dim.t_hour BETWEEN 12 AND 13
      AND household_demographics.hd_dep_count = 6
      AND web_page.wp_char_count BETWEEN 5000 AND 5200
),
pmc AS (
    SELECT COUNT(*) AS pmc
    FROM web_sales
    JOIN household_demographics ON ws_ship_hdemo_sk = household_demographics.hd_demo_sk
    JOIN time_dim ON ws_sold_time_sk = time_dim.t_time_sk
    JOIN web_page ON ws_web_page_sk = web_page.wp_web_page_sk
    WHERE time_dim.t_hour BETWEEN 14 AND 15
      AND household_demographics.hd_dep_count = 6
      AND web_page.wp_char_count BETWEEN 5000 AND 5200
)
explain select
    CAST(amc.amc AS DECIMAL(15,4)) / CAST(pmc.pmc AS DECIMAL(15,4)) AS am_pm_ratio
FROM
    amc, pmc
ORDER BY
    am_pm_ratio DESC
LIMIT 100;WITH amc AS (
    SELECT COUNT(*) AS amc
    FROM web_sales
    JOIN household_demographics ON ws_ship_hdemo_sk = household_demographics.hd_demo_sk
    JOIN time_dim ON ws_sold_time_sk = time_dim.t_time_sk
    JOIN web_page ON ws_web_page_sk = web_page.wp_web_page_sk
    WHERE time_dim.t_hour BETWEEN 12 AND 13
      AND household_demographics.hd_dep_count = 6
      AND web_page.wp_char_count BETWEEN 5000 AND 5200
),
pmc AS (
    SELECT COUNT(*) AS pmc
    FROM web_sales
    JOIN household_demographics ON ws_ship_hdemo_sk = household_demographics.hd_demo_sk
    JOIN time_dim ON ws_sold_time_sk = time_dim.t_time_sk
    JOIN web_page ON ws_web_page_sk = web_page.wp_web_page_sk
    WHERE time_dim.t_hour BETWEEN 14 AND 15
      AND household_demographics.hd_dep_count = 6
      AND web_page.wp_char_count BETWEEN 5000 AND 5200
)
SELECT
    CAST(amc.amc AS DECIMAL(15,4)) / CAST(pmc.pmc AS DECIMAL(15,4)) AS am_pm_ratio
FROM
    amc, pmc
ORDER BY
    am_pm_ratio DESC
LIMIT 100;