explain select 
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price,
    SUM(cs_ext_sales_price) AS itemrevenue,
    SUM(cs_ext_sales_price) * 100 / SUM(SUM(cs_ext_sales_price)) OVER (PARTITION BY i_class) AS revenueratio
FROM 
    item
JOIN 
    catalog_sales ON item.i_item_sk = catalog_sales.cs_item_sk
JOIN 
    date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
WHERE 
    item.i_category IN ('Books', 'Music', 'Sports')
    AND date_dim.d_date BETWEEN '2002-06-18'::date AND '2002-07-18'::date
GROUP BY 
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price
ORDER BY 
    i_category, i_class, i_item_id, i_item_desc, revenueratio
LIMIT 100;SELECT 
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price,
    SUM(cs_ext_sales_price) AS itemrevenue,
    SUM(cs_ext_sales_price) * 100 / SUM(SUM(cs_ext_sales_price)) OVER (PARTITION BY i_class) AS revenueratio
FROM 
    item
JOIN 
    catalog_sales ON item.i_item_sk = catalog_sales.cs_item_sk
JOIN 
    date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
WHERE 
    item.i_category IN ('Books', 'Music', 'Sports')
    AND date_dim.d_date BETWEEN '2002-06-18'::date AND '2002-07-18'::date
GROUP BY 
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price
ORDER BY 
    i_category, i_class, i_item_id, i_item_desc, revenueratio
LIMIT 100;