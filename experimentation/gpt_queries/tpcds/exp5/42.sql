SELECT 
    dt.d_year,
    item.i_category_id,
    item.i_category,
    SUM(ss_ext_sales_price)
FROM 
    date_dim dt
JOIN 
    store_sales ON dt.d_date_sk = store_sales.ss_sold_date_sk
JOIN 
    item ON store_sales.ss_item_sk = item.i_item_sk
WHERE 
    item.i_manager_id = 1 
    AND dt.d_moy = 11 
    AND dt.d_year = 1998
GROUP BY 
    dt.d_year,
    item.i_category_id,
    item.i_category
ORDER BY 
    SUM(ss_ext_sales_price) DESC,
    dt.d_year,
    item.i_category_id,
    item.i_category
LIMIT 100;