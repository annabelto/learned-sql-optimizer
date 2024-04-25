explain select
    substr(r_reason_desc, 1, 20),
    AVG(ws_quantity),
    AVG(wr_refunded_cash),
    AVG(wr_fee)
FROM
    web_sales
JOIN
    web_returns ON ws_item_sk = wr_item_sk AND ws_order_number = wr_order_number
JOIN
    web_page ON ws_web_page_sk = wp_web_page_sk
JOIN
    customer_demographics cd1 ON cd1.cd_demo_sk = wr_refunded_cdemo_sk
JOIN
    customer_demographics cd2 ON cd2.cd_demo_sk = wr_returning_cdemo_sk AND cd1.cd_marital_status = cd2.cd_marital_status AND cd1.cd_education_status = cd2.cd_education_status
JOIN
    customer_address ON ca_address_sk = wr_refunded_addr_sk
JOIN
    date_dim ON ws_sold_date_sk = d_date_sk AND d_year = 1998
JOIN
    reason ON r_reason_sk = wr_reason_sk
WHERE
    (
        (cd1.cd_marital_status = 'D' AND cd1.cd_education_status = 'Primary' AND ws_sales_price BETWEEN 100.00 AND 150.00) OR
        (cd1.cd_marital_status = 'S' AND cd1.cd_education_status = 'College' AND ws_sales_price BETWEEN 50.00 AND 100.00) OR
        (cd1.cd_marital_status = 'U' AND cd1.cd_education_status = 'Advanced Degree' AND ws_sales_price BETWEEN 150.00 AND 200.00)
    ) AND
    (
        (ca_country = 'United States' AND ca_state IN ('NC', 'TX', 'IA') AND ws_net_profit BETWEEN 100 AND 200) OR
        (ca_country = 'United States' AND ca_state IN ('WI', 'WV', 'GA') AND ws_net_profit BETWEEN 150 AND 300) OR
        (ca_country = 'United States' AND ca_state IN ('OK', 'VA', 'KY') AND ws_net_profit BETWEEN 50 AND 250)
    )
GROUP BY
    r_reason_desc
ORDER BY
    substr(r_reason_desc, 1, 20),
    AVG(ws_quantity),
    AVG(wr_refunded_cash),
    AVG(wr_fee)
LIMIT 100;SELECT
    substr(r_reason_desc, 1, 20),
    AVG(ws_quantity),
    AVG(wr_refunded_cash),
    AVG(wr_fee)
FROM
    web_sales
JOIN
    web_returns ON ws_item_sk = wr_item_sk AND ws_order_number = wr_order_number
JOIN
    web_page ON ws_web_page_sk = wp_web_page_sk
JOIN
    customer_demographics cd1 ON cd1.cd_demo_sk = wr_refunded_cdemo_sk
JOIN
    customer_demographics cd2 ON cd2.cd_demo_sk = wr_returning_cdemo_sk AND cd1.cd_marital_status = cd2.cd_marital_status AND cd1.cd_education_status = cd2.cd_education_status
JOIN
    customer_address ON ca_address_sk = wr_refunded_addr_sk
JOIN
    date_dim ON ws_sold_date_sk = d_date_sk AND d_year = 1998
JOIN
    reason ON r_reason_sk = wr_reason_sk
WHERE
    (
        (cd1.cd_marital_status = 'D' AND cd1.cd_education_status = 'Primary' AND ws_sales_price BETWEEN 100.00 AND 150.00) OR
        (cd1.cd_marital_status = 'S' AND cd1.cd_education_status = 'College' AND ws_sales_price BETWEEN 50.00 AND 100.00) OR
        (cd1.cd_marital_status = 'U' AND cd1.cd_education_status = 'Advanced Degree' AND ws_sales_price BETWEEN 150.00 AND 200.00)
    ) AND
    (
        (ca_country = 'United States' AND ca_state IN ('NC', 'TX', 'IA') AND ws_net_profit BETWEEN 100 AND 200) OR
        (ca_country = 'United States' AND ca_state IN ('WI', 'WV', 'GA') AND ws_net_profit BETWEEN 150 AND 300) OR
        (ca_country = 'United States' AND ca_state IN ('OK', 'VA', 'KY') AND ws_net_profit BETWEEN 50 AND 250)
    )
GROUP BY
    r_reason_desc
ORDER BY
    substr(r_reason_desc, 1, 20),
    AVG(ws_quantity),
    AVG(wr_refunded_cash),
    AVG(wr_fee)
LIMIT 100;