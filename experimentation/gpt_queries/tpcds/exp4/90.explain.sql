explain select
    CAST(sum(CASE WHEN t_hour BETWEEN 12 AND 13 THEN 1 ELSE 0 END) AS DECIMAL(15,4)) /
    CAST(sum(CASE WHEN t_hour BETWEEN 14 AND 15 THEN 1 ELSE 0 END) AS DECIMAL(15,4)) AS am_pm_ratio
FROM
    web_sales
JOIN
    household_demographics ON ws_ship_hdemo_sk = household_demographics.hd_demo_sk
JOIN
    time_dim ON ws_sold_time_sk = time_dim.t_time_sk
JOIN
    web_page ON ws_web_page_sk = web_page.wp_web_page_sk
WHERE
    household_demographics.hd_dep_count = 6
    AND web_page.wp_char_count BETWEEN 5000 AND 5200
    AND time_dim.t_hour BETWEEN 12 AND 15
GROUP BY
    household_demographics.hd_dep_count, web_page.wp_char_count
ORDER BY
    am_pm_ratio DESC
LIMIT 100;SELECT
    CAST(sum(CASE WHEN t_hour BETWEEN 12 AND 13 THEN 1 ELSE 0 END) AS DECIMAL(15,4)) /
    CAST(sum(CASE WHEN t_hour BETWEEN 14 AND 15 THEN 1 ELSE 0 END) AS DECIMAL(15,4)) AS am_pm_ratio
FROM
    web_sales
JOIN
    household_demographics ON ws_ship_hdemo_sk = household_demographics.hd_demo_sk
JOIN
    time_dim ON ws_sold_time_sk = time_dim.t_time_sk
JOIN
    web_page ON ws_web_page_sk = web_page.wp_web_page_sk
WHERE
    household_demographics.hd_dep_count = 6
    AND web_page.wp_char_count BETWEEN 5000 AND 5200
    AND time_dim.t_hour BETWEEN 12 AND 15
GROUP BY
    household_demographics.hd_dep_count, web_page.wp_char_count
ORDER BY
    am_pm_ratio DESC
LIMIT 100;