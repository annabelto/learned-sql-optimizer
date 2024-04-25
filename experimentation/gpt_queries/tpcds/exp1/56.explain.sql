WITH filtered_items AS (
    SELECT i_item_id, i_item_sk
    FROM item
    WHERE i_color IN ('powder', 'orchid', 'pink')
),
date_filter AS (
    SELECT d_date_sk
    FROM date_dim
    WHERE d_year = 2000 AND d_moy = 3
),
ss AS (
    SELECT i.i_item_id, SUM(ss_ext_sales_price) AS total_sales
    FROM store_sales
    JOIN filtered_items i ON ss_item_sk = i.i_item_sk
    JOIN date_filter d ON ss_sold_date_sk = d.d_date_sk
    JOIN customer_address ca ON ss_addr_sk = ca_address_sk AND ca_gmt_offset = -6
    GROUP BY i.i_item_id
),
cs AS (
    SELECT i.i_item_id, SUM(cs_ext_sales_price) AS total_sales
    FROM catalog_sales
    JOIN filtered_items i ON cs_item_sk = i.i_item_sk
    JOIN date_filter d ON cs_sold_date_sk = d.d_date_sk
    JOIN customer_address ca ON cs_bill_addr_sk = ca_address_sk AND ca_gmt_offset = -6
    GROUP BY i.i_item_id
),
ws AS (
    SELECT i.i_item_id, SUM(ws_ext_sales_price) AS total_sales
    FROM web_sales
    JOIN filtered_items i ON ws_item_sk = i.i_item_sk
    JOIN date_filter d ON ws_sold_date_sk = d.d_date_sk
    JOIN customer_address ca ON ws_bill_addr_sk = ca_address_sk AND ca_gmt_offset = -6
    GROUP BY i.i_item_id
)
explain select i_item_id, SUM(total_sales) AS total_sales
FROM (
    SELECT * FROM ss
    UNION ALL
    SELECT * FROM cs
    UNION ALL
    SELECT * FROM ws
) tmp1
GROUP BY i_item_id
ORDER BY total_sales DESC, i_item_id
LIMIT 100;WITH filtered_items AS (
    SELECT i_item_id, i_item_sk
    FROM item
    WHERE i_color IN ('powder', 'orchid', 'pink')
),
date_filter AS (
    SELECT d_date_sk
    FROM date_dim
    WHERE d_year = 2000 AND d_moy = 3
),
ss AS (
    SELECT i.i_item_id, SUM(ss_ext_sales_price) AS total_sales
    FROM store_sales
    JOIN filtered_items i ON ss_item_sk = i.i_item_sk
    JOIN date_filter d ON ss_sold_date_sk = d.d_date_sk
    JOIN customer_address ca ON ss_addr_sk = ca_address_sk AND ca_gmt_offset = -6
    GROUP BY i.i_item_id
),
cs AS (
    SELECT i.i_item_id, SUM(cs_ext_sales_price) AS total_sales
    FROM catalog_sales
    JOIN filtered_items i ON cs_item_sk = i.i_item_sk
    JOIN date_filter d ON cs_sold_date_sk = d.d_date_sk
    JOIN customer_address ca ON cs_bill_addr_sk = ca_address_sk AND ca_gmt_offset = -6
    GROUP BY i.i_item_id
),
ws AS (
    SELECT i.i_item_id, SUM(ws_ext_sales_price) AS total_sales
    FROM web_sales
    JOIN filtered_items i ON ws_item_sk = i.i_item_sk
    JOIN date_filter d ON ws_sold_date_sk = d.d_date_sk
    JOIN customer_address ca ON ws_bill_addr_sk = ca_address_sk AND ca_gmt_offset = -6
    GROUP BY i.i_item_id
)
SELECT i_item_id, SUM(total_sales) AS total_sales
FROM (
    SELECT * FROM ss
    UNION ALL
    SELECT * FROM cs
    UNION ALL
    SELECT * FROM ws
) tmp1
GROUP BY i_item_id
ORDER BY total_sales DESC, i_item_id
LIMIT 100;