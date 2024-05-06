explain select 
    dt.d_year,
    item.i_category_id,
    item.i_category,
    SUM(ss.ss_ext_sales_price) AS total_sales
FROM 
    date_dim dt,
    store_sales ss,
    item
WHERE 
    dt.d_date_sk = ss.ss_sold_date_sk
    AND ss.ss_item_sk = item.i_item_sk
    AND dt.d_moy = 11 
    AND dt.d_year = 1998
    AND item.i_manager_id = 1
GROUP BY 
    dt.d_year,
    item.i_category_id,
    item.i_category
ORDER BY 
    total_sales DESC,
    dt.d_year,
    item.i_category_id,
    item.i_category
LIMIT 100;SELECT 
    dt.d_year,
    item.i_category_id,
    item.i_category,
    SUM(ss.ss_ext_sales_price) AS total_sales
FROM 
    date_dim dt,
    store_sales ss,
    item
WHERE 
    dt.d_date_sk = ss.ss_sold_date_sk
    AND ss.ss_item_sk = item.i_item_sk
    AND dt.d_moy = 11 
    AND dt.d_year = 1998
    AND item.i_manager_id = 1
GROUP BY 
    dt.d_year,
    item.i_category_id,
    item.i_category
ORDER BY 
    total_sales DESC,
    dt.d_year,
    item.i_category_id,
    item.i_category
LIMIT 100;