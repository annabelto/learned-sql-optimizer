WITH item_filter AS (
    SELECT i_manufact_id, i_item_sk
    FROM item
    WHERE i_category = 'Books'
),
ss AS (
    SELECT i.i_manufact_id, SUM(ss_ext_sales_price) AS total_sales
    FROM store_sales
    JOIN date_dim d ON ss_sold_date_sk = d_date_sk
    JOIN customer_address ca ON ss_addr_sk = ca_address_sk
    JOIN item_filter i ON ss_item_sk = i.i_item_sk
    WHERE d_year = 2001 AND d_moy = 3 AND ca_gmt_offset = -5
    GROUP BY i.i_manufact_id
),
cs AS (
    SELECT i.i_manufact_id, SUM(cs_ext_sales_price) AS total_sales
    FROM catalog_sales
    JOIN date_dim d ON cs_sold_date_sk = d_date_sk
    JOIN customer_address ca ON cs_bill_addr_sk = ca_address_sk
    JOIN item_filter i ON cs_item_sk = i.i_item_sk
    WHERE d_year = 2001 AND d_moy = 3 AND ca_gmt_offset = -5
    GROUP BY i.i_manufact_id
),
ws AS (
    SELECT i.i_manufact_id, SUM(ws_ext_sales_price) AS total_sales
    FROM web_sales
    JOIN date_dim d ON ws_sold_date_sk = d_date_sk
    JOIN customer_address ca ON ws_bill_addr_sk = ca_address_sk
    JOIN item_filter i ON ws_item_sk = i.i_item_sk
    WHERE d_year = 2001 AND d_moy = 3 AND ca_gmt_offset = -5
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