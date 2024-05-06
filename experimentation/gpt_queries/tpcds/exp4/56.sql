WITH item_filter AS (
    SELECT i_item_id
    FROM item
    WHERE i_color IN ('powder', 'orchid', 'pink')
),
ss AS (
    SELECT i_item_id, SUM(ss_ext_sales_price) AS total_sales
    FROM store_sales
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    JOIN customer_address ON ss_addr_sk = ca_address_sk
    JOIN item ON item.i_item_sk = store_sales.ss_item_sk
    WHERE d_year = 2000 AND d_moy = 3 AND ca_gmt_offset = -6
      AND item.i_item_id IN (SELECT i_item_id FROM item_filter)
    GROUP BY i_item_id
),
cs AS (
    SELECT i_item_id, SUM(cs_ext_sales_price) AS total_sales
    FROM catalog_sales
    JOIN date_dim ON cs_sold_date_sk = d_date_sk
    JOIN customer_address ON cs_bill_addr_sk = ca_address_sk
    JOIN item ON item.i_item_sk = catalog_sales.cs_item_sk
    WHERE d_year = 2000 AND d_moy = 3 AND ca_gmt_offset = -6
      AND item.i_item_id IN (SELECT i_item_id FROM item_filter)
    GROUP BY i_item_id
),
ws AS (
    SELECT i_item_id, SUM(ws_ext_sales_price) AS total_sales
    FROM web_sales
    JOIN date_dim ON ws_sold_date_sk = d_date_sk
    JOIN customer_address ON ws_bill_addr_sk = ca_address_sk
    JOIN item ON item.i_item_sk = web_sales.ws_item_sk
    WHERE d_year = 2000 AND d_moy = 3 AND ca_gmt_offset = -6
      AND item.i_item_id IN (SELECT i_item_id FROM item_filter)
    GROUP BY i_item_id
)
SELECT i_item_id, SUM(total_sales) AS total_sales
FROM (
    SELECT * FROM ss
    UNION ALL
    SELECT * FROM cs
    UNION ALL
    SELECT * FROM ws
) AS combined_sales
GROUP BY i_item_id
ORDER BY total_sales DESC, i_item_id
LIMIT 100;