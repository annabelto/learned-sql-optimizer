WITH ss AS (
    SELECT 
        ca_county,
        d_qoy,
        d_year,
        SUM(ss_ext_sales_price) AS store_sales
    FROM 
        store_sales
        JOIN date_dim ON ss_sold_date_sk = d_date_sk
        JOIN customer_address ON ss_addr_sk = ca_address_sk
    WHERE 
        d_year = 1999 AND d_qoy IN (1, 2, 3)
    GROUP BY 
        ca_county, d_qoy, d_year
), 
ws AS (
    SELECT 
        ca_county,
        d_qoy,
        d_year,
        SUM(ws_ext_sales_price) AS web_sales
    FROM 
        web_sales
        JOIN date_dim ON ws_sold_date_sk = d_date_sk
        JOIN customer_address ON ws_bill_addr_sk = ca_address_sk
    WHERE 
        d_year = 1999 AND d_qoy IN (1, 2, 3)
    GROUP BY 
        ca_county, d_qoy, d_year
)
explain select 
    ss1.ca_county,
    ss1.d_year,
    ws2.web_sales / ws1.web_sales AS web_q1_q2_increase,
    ss2.store_sales / ss1.store_sales AS store_q1_q2_increase,
    ws3.web_sales / ws2.web_sales AS web_q2_q3_increase,
    ss3.store_sales / ss2.store_sales AS store_q2_q3_increase
FROM 
    ss ss1
    JOIN ss ss2 ON ss1.ca_county = ss2.ca_county AND ss1.d_year = ss2.d_year
    JOIN ss ss3 ON ss2.ca_county = ss3.ca_county AND ss2.d_year = ss3.d_year
    JOIN ws ws1 ON ss1.ca_county = ws1.ca_county AND ss1.d_year = ws1.d_year
    JOIN ws ws2 ON ws1.ca_county = ws2.ca_county AND ws1.d_year = ws2.d_year
    JOIN ws ws3 ON ws2.ca_county = ws3.ca_county AND ws2.d_year = ws3.d_year
WHERE 
    ss1.d_qoy = 1 AND ss2.d_qoy = 2 AND ss3.d_qoy = 3 AND
    ws1.d_qoy = 1 AND ws2.d_qoy = 2 AND ws3.d_qoy = 3 AND
    ws2.web_sales / ws1.web_sales > ss2.store_sales / ss1.store_sales AND
    ws3.web_sales / ws2.web_sales > ss3.store_sales / ss2.store_sales
ORDER BY 
    store_q2_q3_increase;WITH ss AS (
    SELECT 
        ca_county,
        d_qoy,
        d_year,
        SUM(ss_ext_sales_price) AS store_sales
    FROM 
        store_sales
        JOIN date_dim ON ss_sold_date_sk = d_date_sk
        JOIN customer_address ON ss_addr_sk = ca_address_sk
    WHERE 
        d_year = 1999 AND d_qoy IN (1, 2, 3)
    GROUP BY 
        ca_county, d_qoy, d_year
), 
ws AS (
    SELECT 
        ca_county,
        d_qoy,
        d_year,
        SUM(ws_ext_sales_price) AS web_sales
    FROM 
        web_sales
        JOIN date_dim ON ws_sold_date_sk = d_date_sk
        JOIN customer_address ON ws_bill_addr_sk = ca_address_sk
    WHERE 
        d_year = 1999 AND d_qoy IN (1, 2, 3)
    GROUP BY 
        ca_county, d_qoy, d_year
)
SELECT 
    ss1.ca_county,
    ss1.d_year,
    ws2.web_sales / ws1.web_sales AS web_q1_q2_increase,
    ss2.store_sales / ss1.store_sales AS store_q1_q2_increase,
    ws3.web_sales / ws2.web_sales AS web_q2_q3_increase,
    ss3.store_sales / ss2.store_sales AS store_q2_q3_increase
FROM 
    ss ss1
    JOIN ss ss2 ON ss1.ca_county = ss2.ca_county AND ss1.d_year = ss2.d_year
    JOIN ss ss3 ON ss2.ca_county = ss3.ca_county AND ss2.d_year = ss3.d_year
    JOIN ws ws1 ON ss1.ca_county = ws1.ca_county AND ss1.d_year = ws1.d_year
    JOIN ws ws2 ON ws1.ca_county = ws2.ca_county AND ws1.d_year = ws2.d_year
    JOIN ws ws3 ON ws2.ca_county = ws3.ca_county AND ws2.d_year = ws3.d_year
WHERE 
    ss1.d_qoy = 1 AND ss2.d_qoy = 2 AND ss3.d_qoy = 3 AND
    ws1.d_qoy = 1 AND ws2.d_qoy = 2 AND ws3.d_qoy = 3 AND
    ws2.web_sales / ws1.web_sales > ss2.store_sales / ss1.store_sales AND
    ws3.web_sales / ws2.web_sales > ss3.store_sales / ss2.store_sales
ORDER BY 
    store_q2_q3_increase;