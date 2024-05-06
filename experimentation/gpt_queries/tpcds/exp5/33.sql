WITH ss AS (
    SELECT i.i_manufact_id, SUM(ss.ss_ext_sales_price) AS total_sales
    FROM store_sales ss
    JOIN item i ON ss.ss_item_sk = i.i_item_sk
    JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
    JOIN customer_address ca ON ss.ss_addr_sk = ca.ca_address_sk
    WHERE i.i_category = 'Books' AND d.d_year = 2001 AND d.d_moy = 3 AND ca.ca_gmt_offset = -5
    GROUP BY i.i_manufact_id
), cs AS (
    SELECT i.i_manufact_id, SUM(cs.cs_ext_sales_price) AS total_sales
    FROM catalog_sales cs
    JOIN item i ON cs.cs_item_sk = i.i_item_sk
    JOIN date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
    JOIN customer_address ca ON cs.cs_bill_addr_sk = ca.ca_address_sk
    WHERE i.i_category = 'Books' AND d.d_year = 2001 AND d.d_moy = 3 AND ca.ca_gmt_offset = -5
    GROUP BY i.i_manufact_id
), ws AS (
    SELECT i.i_manufact_id, SUM(ws.ws_ext_sales_price) AS total_sales
    FROM web_sales ws
    JOIN item i ON ws.ws_item_sk = i.i_item_sk
    JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
    JOIN customer_address ca ON ws.ws_bill_addr_sk = ca.ca_address_sk
    WHERE i.i_category = 'Books' AND d.d_year = 2001 AND d.d_moy = 3 AND ca.ca_gmt_offset = -5
    GROUP BY i.i_manufact_id
)
SELECT i_manufact_id, SUM(total_sales) AS total_sales
FROM (
    SELECT * FROM ss
    UNION ALL
    SELECT * FROM cs
    UNION ALL
    SELECT * FROM ws
) tmp1
GROUP BY i_manufact_id
ORDER BY total_sales DESC
LIMIT 100;