WITH ws_wh AS (
    SELECT ws1.ws_order_number
    FROM web_sales ws1
    JOIN web_sales ws2 ON ws1.ws_order_number = ws2.ws_order_number
    WHERE ws1.ws_warehouse_sk <> ws2.ws_warehouse_sk
)
explain select 
    COUNT(DISTINCT ws1.ws_order_number) AS "order count",
    SUM(ws1.ws_ext_ship_cost) AS "total shipping cost",
    SUM(ws1.ws_net_profit) AS "total net profit"
FROM 
    web_sales ws1
JOIN 
    date_dim ON ws1.ws_ship_date_sk = date_dim.d_date_sk
JOIN 
    customer_address ON ws1.ws_ship_addr_sk = customer_address.ca_address_sk
JOIN 
    web_site ON ws1.ws_web_site_sk = web_site.web_site_sk
WHERE 
    date_dim.d_date BETWEEN '2001-4-01' AND (CAST('2001-4-01' AS DATE) + INTERVAL '60 days')
    AND customer_address.ca_state = 'VA'
    AND web_site.web_company_name = 'pri'
    AND EXISTS (
        SELECT 1
        FROM ws_wh
        WHERE ws1.ws_order_number = ws_wh.ws_order_number
    )
    AND EXISTS (
        SELECT 1
        FROM web_returns
        WHERE web_returns.wr_order_number = ws1.ws_order_number
    )
ORDER BY 
    COUNT(DISTINCT ws1.ws_order_number)
LIMIT 100;WITH ws_wh AS (
    SELECT ws1.ws_order_number
    FROM web_sales ws1
    JOIN web_sales ws2 ON ws1.ws_order_number = ws2.ws_order_number
    WHERE ws1.ws_warehouse_sk <> ws2.ws_warehouse_sk
)
SELECT 
    COUNT(DISTINCT ws1.ws_order_number) AS "order count",
    SUM(ws1.ws_ext_ship_cost) AS "total shipping cost",
    SUM(ws1.ws_net_profit) AS "total net profit"
FROM 
    web_sales ws1
JOIN 
    date_dim ON ws1.ws_ship_date_sk = date_dim.d_date_sk
JOIN 
    customer_address ON ws1.ws_ship_addr_sk = customer_address.ca_address_sk
JOIN 
    web_site ON ws1.ws_web_site_sk = web_site.web_site_sk
WHERE 
    date_dim.d_date BETWEEN '2001-4-01' AND (CAST('2001-4-01' AS DATE) + INTERVAL '60 days')
    AND customer_address.ca_state = 'VA'
    AND web_site.web_company_name = 'pri'
    AND EXISTS (
        SELECT 1
        FROM ws_wh
        WHERE ws1.ws_order_number = ws_wh.ws_order_number
    )
    AND EXISTS (
        SELECT 1
        FROM web_returns
        WHERE web_returns.wr_order_number = ws1.ws_order_number
    )
ORDER BY 
    COUNT(DISTINCT ws1.ws_order_number)
LIMIT 100;