WITH cross_items AS (
    SELECT i_item_sk ss_item_sk 
    FROM item
    JOIN (
        SELECT iss.i_brand_id brand_id, iss.i_class_id class_id, iss.i_category_id category_id 
        FROM store_sales
        JOIN item iss ON ss_item_sk = iss.i_item_sk
        JOIN date_dim d1 ON ss_sold_date_sk = d1.d_date_sk AND d1.d_year BETWEEN 1999 AND 2001
        INTERSECT
        SELECT ics.i_brand_id, ics.i_class_id, ics.i_category_id 
        FROM catalog_sales
        JOIN item ics ON cs_item_sk = ics.i_item_sk
        JOIN date_dim d2 ON cs_sold_date_sk = d2.d_date_sk AND d2.d_year BETWEEN 1999 AND 2001
        INTERSECT
        SELECT iws.i_brand_id, iws.i_class_id, iws.i_category_id 
        FROM web_sales
        JOIN item iws ON ws_item_sk = iws.i_item_sk
        JOIN date_dim d3 ON ws_sold_date_sk = d3.d_date_sk AND d3.d_year BETWEEN 1999 AND 2001
    ) x ON i_brand_id = brand_id AND i_class_id = class_id AND i_category_id = category_id
), 
avg_sales AS (
    SELECT AVG(quantity * list_price) average_sales 
    FROM (
        SELECT ss_quantity quantity, ss_list_price list_price 
        FROM store_sales
        JOIN date_dim ON ss_sold_date_sk = d_date_sk AND d_year BETWEEN 1999 AND 2001
        UNION ALL
        SELECT cs_quantity quantity, cs_list_price list_price 
        FROM catalog_sales
        JOIN date_dim ON cs_sold_date_sk = d_date_sk AND d_year BETWEEN 1999 AND 2001
        UNION ALL
        SELECT ws_quantity quantity, ws_list_price list_price 
        FROM web_sales
        JOIN date_dim ON ws_sold_date_sk = d_date_sk AND d_year BETWEEN 1999 AND 2001
    ) x
)
explain select this_year.channel ty_channel, this_year.i_brand_id ty_brand, this_year.i_class_id ty_class, this_year.i_category_id ty_category, this_year.sales ty_sales, this_year.number_sales ty_number_sales, last_year.channel ly_channel, last_year.i_brand_id ly_brand, last_year.i_class_id ly_class, last_year.i_category_id ly_category, last_year.sales ly_sales, last_year.number_sales ly_number_sales 
FROM (
    SELECT 'store' channel, i_brand_id, i_class_id, i_category_id, SUM(ss_quantity * ss_list_price) sales, COUNT(*) number_sales 
    FROM store_sales
    JOIN item ON ss_item_sk = i_item_sk
    JOIN date_dim ON ss_sold_date_sk = d_date_sk AND d_week_seq = (SELECT d_week_seq FROM date_dim WHERE d_year = 2000 AND d_moy = 12 AND d_dom = 3)
    WHERE ss_item_sk IN (SELECT ss_item_sk FROM cross_items)
    GROUP BY i_brand_id, i_class_id, i_category_id
    HAVING SUM(ss_quantity * ss_list_price) > (SELECT average_sales FROM avg_sales)
) this_year
JOIN (
    SELECT 'store' channel, i_brand_id, i_class_id, i_category_id, SUM(ss_quantity * ss_list_price) sales, COUNT(*) number_sales 
    FROM store_sales
    JOIN item ON ss_item_sk = i_item_sk
    JOIN date_dim ON ss_sold_date_sk = d_date_sk AND d_week_seq = (SELECT d_week_seq FROM date_dim WHERE d_year = 1999 AND d_moy = 12 AND d_dom = 3)
    WHERE ss_item_sk IN (SELECT ss_item_sk FROM cross_items)
    GROUP BY i_brand_id, i_class_id, i_category_id
    HAVING SUM(ss_quantity * ss_list_price) > (SELECT average_sales FROM avg_sales)
) last_year ON this_year.i_brand_id = last_year.i_brand_id AND this_year.i_class_id = last_year.i_class_id AND this_year.i_category_id = last_year.i_category_id
ORDER BY this_year.channel, this_year.i_brand_id, this_year.i_class_id, this_year.i_category_id
LIMIT 100;WITH cross_items AS (
    SELECT i_item_sk ss_item_sk 
    FROM item
    JOIN (
        SELECT iss.i_brand_id brand_id, iss.i_class_id class_id, iss.i_category_id category_id 
        FROM store_sales
        JOIN item iss ON ss_item_sk = iss.i_item_sk
        JOIN date_dim d1 ON ss_sold_date_sk = d1.d_date_sk AND d1.d_year BETWEEN 1999 AND 2001
        INTERSECT
        SELECT ics.i_brand_id, ics.i_class_id, ics.i_category_id 
        FROM catalog_sales
        JOIN item ics ON cs_item_sk = ics.i_item_sk
        JOIN date_dim d2 ON cs_sold_date_sk = d2.d_date_sk AND d2.d_year BETWEEN 1999 AND 2001
        INTERSECT
        SELECT iws.i_brand_id, iws.i_class_id, iws.i_category_id 
        FROM web_sales
        JOIN item iws ON ws_item_sk = iws.i_item_sk
        JOIN date_dim d3 ON ws_sold_date_sk = d3.d_date_sk AND d3.d_year BETWEEN 1999 AND 2001
    ) x ON i_brand_id = brand_id AND i_class_id = class_id AND i_category_id = category_id
), 
avg_sales AS (
    SELECT AVG(quantity * list_price) average_sales 
    FROM (
        SELECT ss_quantity quantity, ss_list_price list_price 
        FROM store_sales
        JOIN date_dim ON ss_sold_date_sk = d_date_sk AND d_year BETWEEN 1999 AND 2001
        UNION ALL
        SELECT cs_quantity quantity, cs_list_price list_price 
        FROM catalog_sales
        JOIN date_dim ON cs_sold_date_sk = d_date_sk AND d_year BETWEEN 1999 AND 2001
        UNION ALL
        SELECT ws_quantity quantity, ws_list_price list_price 
        FROM web_sales
        JOIN date_dim ON ws_sold_date_sk = d_date_sk AND d_year BETWEEN 1999 AND 2001
    ) x
)
SELECT this_year.channel ty_channel, this_year.i_brand_id ty_brand, this_year.i_class_id ty_class, this_year.i_category_id ty_category, this_year.sales ty_sales, this_year.number_sales ty_number_sales, last_year.channel ly_channel, last_year.i_brand_id ly_brand, last_year.i_class_id ly_class, last_year.i_category_id ly_category, last_year.sales ly_sales, last_year.number_sales ly_number_sales 
FROM (
    SELECT 'store' channel, i_brand_id, i_class_id, i_category_id, SUM(ss_quantity * ss_list_price) sales, COUNT(*) number_sales 
    FROM store_sales
    JOIN item ON ss_item_sk = i_item_sk
    JOIN date_dim ON ss_sold_date_sk = d_date_sk AND d_week_seq = (SELECT d_week_seq FROM date_dim WHERE d_year = 2000 AND d_moy = 12 AND d_dom = 3)
    WHERE ss_item_sk IN (SELECT ss_item_sk FROM cross_items)
    GROUP BY i_brand_id, i_class_id, i_category_id
    HAVING SUM(ss_quantity * ss_list_price) > (SELECT average_sales FROM avg_sales)
) this_year
JOIN (
    SELECT 'store' channel, i_brand_id, i_class_id, i_category_id, SUM(ss_quantity * ss_list_price) sales, COUNT(*) number_sales 
    FROM store_sales
    JOIN item ON ss_item_sk = i_item_sk
    JOIN date_dim ON ss_sold_date_sk = d_date_sk AND d_week_seq = (SELECT d_week_seq FROM date_dim WHERE d_year = 1999 AND d_moy = 12 AND d_dom = 3)
    WHERE ss_item_sk IN (SELECT ss_item_sk FROM cross_items)
    GROUP BY i_brand_id, i_class_id, i_category_id
    HAVING SUM(ss_quantity * ss_list_price) > (SELECT average_sales FROM avg_sales)
) last_year ON this_year.i_brand_id = last_year.i_brand_id AND this_year.i_class_id = last_year.i_class_id AND this_year.i_category_id = last_year.i_category_id
ORDER BY this_year.channel, this_year.i_brand_id, this_year.i_class_id, this_year.i_category_id
LIMIT 100;