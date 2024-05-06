SELECT 
    dt.d_year,
    item.i_brand_id AS brand_id,
    item.i_brand AS brand,
    SUM(ss.ss_sales_price) AS sum_agg
FROM 
    item
JOIN 
    store_sales ss ON item.i_item_sk = ss.ss_item_sk
JOIN 
    date_dim dt ON ss.ss_sold_date_sk = dt.d_date_sk
WHERE 
    item.i_manufact_id = 816
    AND dt.d_moy = 11
GROUP BY 
    dt.d_year,
    item.i_brand,
    item.i_brand_id
ORDER BY 
    dt.d_year,
    sum_agg DESC,
    brand_id
LIMIT 100;