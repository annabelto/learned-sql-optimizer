SELECT 
    dt.d_year,
    item.i_brand_id AS brand_id,
    item.i_brand AS brand,
    SUM(ss_ext_sales_price) AS ext_price
FROM 
    date_dim dt
INNER JOIN 
    store_sales ON dt.d_date_sk = store_sales.ss_sold_date_sk
INNER JOIN 
    item ON store_sales.ss_item_sk = item.i_item_sk
WHERE 
    dt.d_year = 2000 AND dt.d_moy = 12 AND item.i_manager_id = 1
GROUP BY 
    dt.d_year, item.i_brand_id, item.i_brand
ORDER BY 
    dt.d_year, ext_price DESC, brand_id
LIMIT 100;