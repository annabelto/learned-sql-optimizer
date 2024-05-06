WITH cross_items AS (
    SELECT i_item_sk ss_item_sk 
    FROM item
    WHERE (i_brand_id, i_class_id, i_category_id) IN (
        SELECT iss.i_brand_id, iss.i_class_id, iss.i_category_id
        FROM store_sales ss
        JOIN item iss ON ss.ss_item_sk = iss.i_item_sk
        JOIN date_dim d1 ON ss.ss_sold_date_sk = d1.d_date_sk AND d1.d_year BETWEEN 1999 AND 2001
        INTERSECT
        SELECT ics.i_brand_id, ics.i_class_id, ics.i_category_id
        FROM catalog_sales cs
        JOIN item ics ON cs.cs_item_sk = ics.i_item_sk
        JOIN date_dim d2 ON cs.cs_sold_date_sk = d2.d_date_sk AND d2.d_year BETWEEN 1999 AND 2001
        INTERSECT
        SELECT iws.i_brand_id, iws.i_class_id, iws.i_category_id
        FROM web_sales ws
        JOIN item iws ON ws.ws_item_sk = iws.i_item_sk
        JOIN date_dim d3 ON ws.ws_sold_date_sk = d3.d_date_sk AND d3.d_year BETWEEN 1999 AND 2001
    )
), 
avg_sales AS (
    SELECT AVG(quantity * list_price) average_sales 
    FROM (
        SELECT ss_quantity AS quantity, ss_list_price AS list_price 
        FROM store_sales
        JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk AND date_dim.d_year BETWEEN 1999 AND 2001
        UNION ALL
        SELECT cs_quantity AS quantity, cs_list_price AS list_price 
        FROM catalog_sales
        JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk AND date_dim.d_year BETWEEN 1999 AND 2001
        UNION ALL
        SELECT ws_quantity AS quantity, ws_list_price AS list_price 
        FROM web_sales
        JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk AND date_dim.d_year BETWEEN 1999 AND 2001
    ) x
)
explain select channel, i_brand_id, i_class_id, i_category_id, SUM(sales), SUM(number_sales)
FROM (
    SELECT 'store' AS channel, i.i_brand_id, i.i_class_id, i.i_category_id, SUM(ss.ss_quantity * ss.ss_list_price) AS sales, COUNT(*) AS number_sales
    FROM store_sales ss
    JOIN item i ON ss.ss_item_sk = i.i_item_sk
    JOIN date_dim dd ON ss.ss_sold_date_sk = dd.d_date_sk AND dd.d_year = 2001 AND dd.d_moy = 11
    WHERE ss.ss_item_sk IN (SELECT ss_item_sk FROM cross_items)
    GROUP BY i.i_brand_id, i.i_class_id, i.i_category_id
    HAVING SUM(ss.ss_quantity * ss.ss_list_price) > (SELECT average_sales FROM avg_sales)
    UNION ALL
    SELECT 'catalog' AS channel, i.i_brand_id, i.i_class_id, i.i_category_id, SUM(cs.cs_quantity * cs.cs_list_price) AS sales, COUNT(*) AS number_sales
    FROM catalog_sales cs
    JOIN item i ON cs.cs_item_sk = i.i_item_sk
    JOIN date_dim dd ON cs.cs_sold_date_sk = dd.d_date_sk AND dd.d_year = 2001 AND dd.d_moy = 11
    WHERE cs.cs_item_sk IN (SELECT ss_item_sk FROM cross_items)
    GROUP BY i.i_brand_id, i.i_class_id, i.i_category_id
    HAVING SUM(cs.cs_quantity * cs.cs_list_price) > (SELECT average_sales FROM avg_sales)
    UNION ALL
    SELECT 'web' AS channel, i.i_brand_id, i.i_class_id, i.i_category_id, SUM(ws.ws_quantity * ws.ws_list_price) AS sales, COUNT(*) AS number_sales
    FROM web_sales ws
    JOIN item i ON ws.ws_item_sk = i.i_item_sk
    JOIN date_dim dd ON ws.ws_sold_date_sk = dd.d_date_sk AND dd.d_year = 2001 AND dd.d_moy = 11
    WHERE ws.ws_item_sk IN (SELECT ss_item_sk FROM cross_items)
    GROUP BY i.i_brand_id, i.i_class_id, i.i_category_id
    HAVING SUM(ws.ws_quantity * ws.ws_list_price) > (SELECT average_sales FROM avg_sales)
) y
GROUP BY ROLLUP (channel, i_brand_id, i_class_id, i_category_id)
ORDER BY channel, i_brand_id, i_class_id, i_category_id
LIMIT 100;WITH cross_items AS (
    SELECT i_item_sk ss_item_sk 
    FROM item
    WHERE (i_brand_id, i_class_id, i_category_id) IN (
        SELECT iss.i_brand_id, iss.i_class_id, iss.i_category_id
        FROM store_sales ss
        JOIN item iss ON ss.ss_item_sk = iss.i_item_sk
        JOIN date_dim d1 ON ss.ss_sold_date_sk = d1.d_date_sk AND d1.d_year BETWEEN 1999 AND 2001
        INTERSECT
        SELECT ics.i_brand_id, ics.i_class_id, ics.i_category_id
        FROM catalog_sales cs
        JOIN item ics ON cs.cs_item_sk = ics.i_item_sk
        JOIN date_dim d2 ON cs.cs_sold_date_sk = d2.d_date_sk AND d2.d_year BETWEEN 1999 AND 2001
        INTERSECT
        SELECT iws.i_brand_id, iws.i_class_id, iws.i_category_id
        FROM web_sales ws
        JOIN item iws ON ws.ws_item_sk = iws.i_item_sk
        JOIN date_dim d3 ON ws.ws_sold_date_sk = d3.d_date_sk AND d3.d_year BETWEEN 1999 AND 2001
    )
), 
avg_sales AS (
    SELECT AVG(quantity * list_price) average_sales 
    FROM (
        SELECT ss_quantity AS quantity, ss_list_price AS list_price 
        FROM store_sales
        JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk AND date_dim.d_year BETWEEN 1999 AND 2001
        UNION ALL
        SELECT cs_quantity AS quantity, cs_list_price AS list_price 
        FROM catalog_sales
        JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk AND date_dim.d_year BETWEEN 1999 AND 2001
        UNION ALL
        SELECT ws_quantity AS quantity, ws_list_price AS list_price 
        FROM web_sales
        JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk AND date_dim.d_year BETWEEN 1999 AND 2001
    ) x
)
SELECT channel, i_brand_id, i_class_id, i_category_id, SUM(sales), SUM(number_sales)
FROM (
    SELECT 'store' AS channel, i.i_brand_id, i.i_class_id, i.i_category_id, SUM(ss.ss_quantity * ss.ss_list_price) AS sales, COUNT(*) AS number_sales
    FROM store_sales ss
    JOIN item i ON ss.ss_item_sk = i.i_item_sk
    JOIN date_dim dd ON ss.ss_sold_date_sk = dd.d_date_sk AND dd.d_year = 2001 AND dd.d_moy = 11
    WHERE ss.ss_item_sk IN (SELECT ss_item_sk FROM cross_items)
    GROUP BY i.i_brand_id, i.i_class_id, i.i_category_id
    HAVING SUM(ss.ss_quantity * ss.ss_list_price) > (SELECT average_sales FROM avg_sales)
    UNION ALL
    SELECT 'catalog' AS channel, i.i_brand_id, i.i_class_id, i.i_category_id, SUM(cs.cs_quantity * cs.cs_list_price) AS sales, COUNT(*) AS number_sales
    FROM catalog_sales cs
    JOIN item i ON cs.cs_item_sk = i.i_item_sk
    JOIN date_dim dd ON cs.cs_sold_date_sk = dd.d_date_sk AND dd.d_year = 2001 AND dd.d_moy = 11
    WHERE cs.cs_item_sk IN (SELECT ss_item_sk FROM cross_items)
    GROUP BY i.i_brand_id, i.i_class_id, i.i_category_id
    HAVING SUM(cs.cs_quantity * cs.cs_list_price) > (SELECT average_sales FROM avg_sales)
    UNION ALL
    SELECT 'web' AS channel, i.i_brand_id, i.i_class_id, i.i_category_id, SUM(ws.ws_quantity * ws.ws_list_price) AS sales, COUNT(*) AS number_sales
    FROM web_sales ws
    JOIN item i ON ws.ws_item_sk = i.i_item_sk
    JOIN date_dim dd ON ws.ws_sold_date_sk = dd.d_date_sk AND dd.d_year = 2001 AND dd.d_moy = 11
    WHERE ws.ws_item_sk IN (SELECT ss_item_sk FROM cross_items)
    GROUP BY i.i_brand_id, i.i_class_id, i.i_category_id
    HAVING SUM(ws.ws_quantity * ws.ws_list_price) > (SELECT average_sales FROM avg_sales)
) y
GROUP BY ROLLUP (channel, i_brand_id, i_class_id, i_category_id)
ORDER BY channel, i_brand_id, i_class_id, i_category_id
LIMIT 100;