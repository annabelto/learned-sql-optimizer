explain select
    COUNT(DISTINCT ws1.ws_order_number) AS "order count",
    SUM(ws1.ws_ext_ship_cost) AS "total shipping cost",
    SUM(ws1.ws_net_profit) AS "total net profit"
FROM
    web_sales ws1
JOIN
    date_dim ON ws1.ws_ship_date_sk = date_dim.d_date_sk
    AND date_dim.d_date BETWEEN '2002-5-01' AND (CAST('2002-5-01' AS DATE) + INTERVAL '60 days')
JOIN
    customer_address ON ws1.ws_ship_addr_sk = customer_address.ca_address_sk
    AND customer_address.ca_state = 'OK'
JOIN
    web_site ON ws1.ws_web_site_sk = web_site.web_site_sk
    AND web_site.web_company_name = 'pri'
WHERE
    EXISTS (
        SELECT 1
        FROM web_sales ws2
        WHERE ws1.ws_order_number = ws2.ws_order_number
        AND ws1.ws_warehouse_sk <> ws2.ws_warehouse_sk
    )
    AND NOT EXISTS (
        SELECT 1
        FROM web_returns wr1
        WHERE ws1.ws_order_number = wr1.wr_order_number
    )
LIMIT 100;SELECT
    COUNT(DISTINCT ws1.ws_order_number) AS "order count",
    SUM(ws1.ws_ext_ship_cost) AS "total shipping cost",
    SUM(ws1.ws_net_profit) AS "total net profit"
FROM
    web_sales ws1
JOIN
    date_dim ON ws1.ws_ship_date_sk = date_dim.d_date_sk
    AND date_dim.d_date BETWEEN '2002-5-01' AND (CAST('2002-5-01' AS DATE) + INTERVAL '60 days')
JOIN
    customer_address ON ws1.ws_ship_addr_sk = customer_address.ca_address_sk
    AND customer_address.ca_state = 'OK'
JOIN
    web_site ON ws1.ws_web_site_sk = web_site.web_site_sk
    AND web_site.web_company_name = 'pri'
WHERE
    EXISTS (
        SELECT 1
        FROM web_sales ws2
        WHERE ws1.ws_order_number = ws2.ws_order_number
        AND ws1.ws_warehouse_sk <> ws2.ws_warehouse_sk
    )
    AND NOT EXISTS (
        SELECT 1
        FROM web_returns wr1
        WHERE ws1.ws_order_number = wr1.wr_order_number
    )
LIMIT 100;