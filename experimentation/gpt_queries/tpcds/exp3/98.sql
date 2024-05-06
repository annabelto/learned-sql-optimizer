SELECT 
    i.i_item_id,
    i.i_item_desc,
    i.i_category,
    i.i_class,
    i.i_current_price,
    SUM(ss.ss_ext_sales_price) AS itemrevenue,
    SUM(ss.ss_ext_sales_price) * 100 / SUM(SUM(ss.ss_ext_sales_price)) OVER (PARTITION BY i.i_class) AS revenueratio
FROM 
    store_sales ss
JOIN 
    item i ON ss.ss_item_sk = i.i_item_sk
JOIN 
    date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
WHERE 
    i.i_category IN ('Men', 'Sports', 'Jewelry')
    AND d.d_date BETWEEN '1999-02-05'::date AND ('1999-02-05'::date + INTERVAL '30 days')
GROUP BY 
    i.i_item_id, i.i_item_desc, i.i_category, i.i_class, i.i_current_price
ORDER BY 
    i.i_category, i.i_class, i.i_item_id, i.i_item_desc, revenueratio;