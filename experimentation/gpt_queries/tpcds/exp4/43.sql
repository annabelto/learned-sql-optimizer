SELECT 
    s_store_name, 
    s_store_id, 
    SUM(ss_sales_price) FILTER (WHERE d_day_name = 'Sunday') AS sun_sales, 
    SUM(ss_sales_price) FILTER (WHERE d_day_name = 'Monday') AS mon_sales, 
    SUM(ss_sales_price) FILTER (WHERE d_day_name = 'Tuesday') AS tue_sales, 
    SUM(ss_sales_price) FILTER (WHERE d_day_name = 'Wednesday') AS wed_sales, 
    SUM(ss_sales_price) FILTER (WHERE d_day_name = 'Thursday') AS thu_sales, 
    SUM(ss_sales_price) FILTER (WHERE d_day_name = 'Friday') AS fri_sales, 
    SUM(ss_sales_price) FILTER (WHERE d_day_name = 'Saturday') AS sat_sales 
FROM 
    store 
JOIN 
    store_sales ON s_store_sk = ss_store_sk 
JOIN 
    date_dim ON d_date_sk = ss_sold_date_sk 
WHERE 
    s_gmt_offset = -5 
    AND d_year = 2000 
GROUP BY 
    s_store_name, 
    s_store_id 
ORDER BY 
    s_store_name, s_store_id, sun_sales, mon_sales, tue_sales, wed_sales, thu_sales, fri_sales, sat_sales 
LIMIT 100;