WITH ss AS (
    SELECT i_item_id, SUM(ss_ext_sales_price) AS total_sales
    FROM store_sales
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN customer_address ON store_sales.ss_addr_sk = customer_address.ca_address_sk
    WHERE item.i_item_id IN (SELECT i_item_id FROM item WHERE i_color IN ('powder', 'orchid', 'pink'))
      AND date_dim.d_year = 2000
      AND date_dim.d_moy = 3
      AND customer_address.ca_gmt_offset = -6
    GROUP BY i_item_id
), cs AS (
    SELECT i_item_id, SUM(cs_ext_sales_price) AS total_sales
    FROM catalog_sales
    JOIN item ON catalog_sales.cs_item_sk = item.i_item_sk
    JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
    JOIN customer_address ON catalog_sales.cs_bill_addr_sk = customer_address.ca_address_sk
    WHERE item.i_item_id IN (SELECT i_item_id FROM item WHERE i_color IN ('powder', 'orchid', 'pink'))
      AND date_dim.d_year = 2000
      AND date_dim.d_moy = 3
      AND customer_address.ca_gmt_offset = -6
    GROUP BY i_item_id
), ws AS (
    SELECT i_item_id, SUM(ws_ext_sales_price) AS total_sales
    FROM web_sales
    JOIN item ON web_sales.ws_item_sk = item.i_item_sk
    JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
    JOIN customer_address ON web_sales.ws_bill_addr_sk = customer_address.ca_address_sk
    WHERE item.i_item_id IN (SELECT i_item_id FROM item WHERE i_color IN ('powder', 'orchid', 'pink'))
      AND date_dim.d_year = 2000
      AND date_dim.d_moy = 3
      AND customer_address.ca_gmt_offset = -6
    GROUP BY i_item_id
)
explain select i_item_id, SUM(total_sales) AS total_sales
FROM (
    SELECT i_item_id, total_sales FROM ss
    UNION ALL
    SELECT i_item_id, total_sales FROM cs
    UNION ALL
    SELECT i_item_id, total_sales FROM ws
) AS tmp1
GROUP BY i_item_id
ORDER BY total_sales DESC, i_item_id
LIMIT 100;WITH ss AS (
    SELECT i_item_id, SUM(ss_ext_sales_price) AS total_sales
    FROM store_sales
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN customer_address ON store_sales.ss_addr_sk = customer_address.ca_address_sk
    WHERE item.i_item_id IN (SELECT i_item_id FROM item WHERE i_color IN ('powder', 'orchid', 'pink'))
      AND date_dim.d_year = 2000
      AND date_dim.d_moy = 3
      AND customer_address.ca_gmt_offset = -6
    GROUP BY i_item_id
), cs AS (
    SELECT i_item_id, SUM(cs_ext_sales_price) AS total_sales
    FROM catalog_sales
    JOIN item ON catalog_sales.cs_item_sk = item.i_item_sk
    JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
    JOIN customer_address ON catalog_sales.cs_bill_addr_sk = customer_address.ca_address_sk
    WHERE item.i_item_id IN (SELECT i_item_id FROM item WHERE i_color IN ('powder', 'orchid', 'pink'))
      AND date_dim.d_year = 2000
      AND date_dim.d_moy = 3
      AND customer_address.ca_gmt_offset = -6
    GROUP BY i_item_id
), ws AS (
    SELECT i_item_id, SUM(ws_ext_sales_price) AS total_sales
    FROM web_sales
    JOIN item ON web_sales.ws_item_sk = item.i_item_sk
    JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
    JOIN customer_address ON web_sales.ws_bill_addr_sk = customer_address.ca_address_sk
    WHERE item.i_item_id IN (SELECT i_item_id FROM item WHERE i_color IN ('powder', 'orchid', 'pink'))
      AND date_dim.d_year = 2000
      AND date_dim.d_moy = 3
      AND customer_address.ca_gmt_offset = -6
    GROUP BY i_item_id
)
SELECT i_item_id, SUM(total_sales) AS total_sales
FROM (
    SELECT i_item_id, total_sales FROM ss
    UNION ALL
    SELECT i_item_id, total_sales FROM cs
    UNION ALL
    SELECT i_item_id, total_sales FROM ws
) AS tmp1
GROUP BY i_item_id
ORDER BY total_sales DESC, i_item_id
LIMIT 100;