WITH cross_items AS (
    SELECT i_item_sk ss_item_sk
    FROM item
    WHERE EXISTS (
        SELECT 1
        FROM store_sales
        JOIN item iss ON store_sales.ss_item_sk = iss.i_item_sk
        JOIN date_dim d1 ON store_sales.ss_sold_date_sk = d1.d_date_sk
        WHERE d1.d_year BETWEEN 1999 AND 2001
        INTERSECT
        SELECT 1
        FROM catalog_sales
        JOIN item ics ON catalog_sales.cs_item_sk = ics.i_item_sk
        JOIN date_dim d2 ON catalog_sales.cs_sold_date_sk = d2.d_date_sk
        WHERE d2.d_year BETWEEN 1999 AND 2001
        INTERSECT
        SELECT 1
        FROM web_sales
        JOIN item iws ON web_sales.ws_item_sk = iws.i_item_sk
        JOIN date_dim d3 ON web_sales.ws_sold_date_sk = d3.d_date_sk
        WHERE d3.d_year BETWEEN 1999 AND 2001
    )
),
avg_sales AS (
    SELECT AVG(quantity * list_price) AS average_sales
    FROM (
        SELECT ss_quantity AS quantity, ss_list_price AS list_price
        FROM store_sales
        JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
        WHERE date_dim.d_year BETWEEN 1999 AND 2001
        UNION ALL
        SELECT cs_quantity AS quantity, cs_list_price AS list_price
        FROM catalog_sales
        JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
        WHERE date_dim.d_year BETWEEN 1999 AND 2001
        UNION ALL
        SELECT ws_quantity AS quantity, ws_list_price AS list_price
        FROM web_sales
        JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
        WHERE date_dim.d_year BETWEEN 1999 AND 2001
    ) sales_data
)
SELECT channel, i_brand_id, i_class_id, i_category_id, SUM(sales) AS total_sales, SUM(number_sales) AS total_number_sales
FROM (
    SELECT 'store' AS channel, i_brand_id, i_class_id, i_category_id, 
           SUM(ss_quantity * ss_list_price) AS sales, 
           COUNT(*) AS number_sales
    FROM store_sales
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    WHERE store_sales.ss_item_sk IN (SELECT ss_item_sk FROM cross_items)
      AND date_dim.d_year = 2001 AND date_dim.d_moy = 11
    GROUP BY i_brand_id, i_class_id, i_category_id
    HAVING SUM(ss_quantity * ss_list_price) > (SELECT average_sales FROM avg_sales)
    UNION ALL
    SELECT 'catalog' AS channel, i_brand_id, i_class_id, i_category_id, 
           SUM(cs_quantity * cs_list_price) AS sales, 
           COUNT(*) AS number_sales
    FROM catalog_sales
    JOIN item ON catalog_sales.cs_item_sk = item.i_item_sk
    JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
    WHERE catalog_sales.cs_item_sk IN (SELECT ss_item_sk FROM cross_items)
      AND date_dim.d_year = 2001 AND date_dim.d_moy = 11
    GROUP BY i_brand_id, i_class_id, i_category_id
    HAVING SUM(cs_quantity * cs_list_price) > (SELECT average_sales FROM avg_sales)
    UNION ALL
    SELECT 'web' AS channel, i_brand_id, i_class_id, i_category_id, 
           SUM(ws_quantity * ws_list_price) AS sales, 
           COUNT(*) AS number_sales
    FROM web_sales
    JOIN item ON web_sales.ws_item_sk = item.i_item_sk
    JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
    WHERE web_sales.ws_item_sk IN (SELECT ss_item_sk FROM cross_items)
      AND date_dim.d_year = 2001 AND date_dim.d_moy = 11
    GROUP BY i_brand_id, i_class_id, i_category_id
    HAVING SUM(ws_quantity * ws_list_price) > (SELECT average_sales FROM avg_sales)
) aggregated_sales
GROUP BY ROLLUP (channel, i_brand_id, i_class_id, i_category_id)
ORDER BY channel, i_brand_id, i_class_id, i_category_id
LIMIT 100;