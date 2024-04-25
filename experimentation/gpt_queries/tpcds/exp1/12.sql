WITH date_range AS (
    SELECT 
        cast('2001-06-15' as date) AS start_date,
        (cast('2001-06-15' as date) + interval '30 days') AS end_date
)
SELECT 
    i.i_item_id,
    i.i_item_desc,
    i.i_category,
    i.i_class,
    i.i_current_price,
    SUM(ws.ws_ext_sales_price) AS itemrevenue,
    SUM(ws.ws_ext_sales_price) * 100 / SUM(SUM(ws.ws_ext_sales_price)) OVER (PARTITION BY i.i_class) AS revenueratio
FROM 
    web_sales ws
JOIN 
    item i ON ws.ws_item_sk = i.i_item_sk
JOIN 
    date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
JOIN 
    date_range dr ON d.d_date BETWEEN dr.start_date AND dr.end_date
WHERE 
    i.i_category IN ('Men', 'Books', 'Electronics')
GROUP BY 
    i.i_item_id, i.i_item_desc, i.i_category, i.i_class, i.i_current_price
ORDER BY 
    i.i_category, i.i_class, i.i_item_id, i.i_item_desc, revenueratio
LIMIT 100;