explain select 
    i.i_brand_id AS brand_id, 
    i.i_brand AS brand,
    t.t_hour,
    t.t_minute, 
    SUM(tmp.ext_price) AS ext_price 
FROM 
    item i
JOIN 
    (SELECT 
         ws.ws_ext_sales_price AS ext_price, 
         ws.ws_item_sk AS sold_item_sk, 
         ws.ws_sold_time_sk AS time_sk 
     FROM 
         web_sales ws
     JOIN 
         date_dim d ON d.d_date_sk = ws.ws_sold_date_sk
     WHERE 
         d.d_moy = 12 AND d.d_year = 2002

     UNION ALL

     SELECT 
         cs.cs_ext_sales_price AS ext_price, 
         cs.cs_item_sk AS sold_item_sk, 
         cs.cs_sold_time_sk AS time_sk 
     FROM 
         catalog_sales cs
     JOIN 
         date_dim d ON d.d_date_sk = cs.cs_sold_date_sk
     WHERE 
         d.d_moy = 12 AND d.d_year = 2002

     UNION ALL

     SELECT 
         ss.ss_ext_sales_price AS ext_price, 
         ss.ss_item_sk AS sold_item_sk, 
         ss.ss_sold_time_sk AS time_sk 
     FROM 
         store_sales ss
     JOIN 
         date_dim d ON d.d_date_sk = ss.ss_sold_date_sk
     WHERE 
         d.d_moy = 12 AND d.d_year = 2002
    ) tmp ON i.i_item_sk = tmp.sold_item_sk
JOIN 
    time_dim t ON tmp.time_sk = t.t_time_sk
WHERE 
    i.i_manager_id = 1 AND 
    (t.t_meal_time = 'breakfast' OR t.t_meal_time = 'dinner')
GROUP BY 
    i.i_brand, i.i_brand_id, t.t_hour, t.t_minute
ORDER BY 
    SUM(tmp.ext_price) DESC, i.i_brand_id;SELECT 
    i.i_brand_id AS brand_id, 
    i.i_brand AS brand,
    t.t_hour,
    t.t_minute, 
    SUM(tmp.ext_price) AS ext_price 
FROM 
    item i
JOIN 
    (SELECT 
         ws.ws_ext_sales_price AS ext_price, 
         ws.ws_item_sk AS sold_item_sk, 
         ws.ws_sold_time_sk AS time_sk 
     FROM 
         web_sales ws
     JOIN 
         date_dim d ON d.d_date_sk = ws.ws_sold_date_sk
     WHERE 
         d.d_moy = 12 AND d.d_year = 2002

     UNION ALL

     SELECT 
         cs.cs_ext_sales_price AS ext_price, 
         cs.cs_item_sk AS sold_item_sk, 
         cs.cs_sold_time_sk AS time_sk 
     FROM 
         catalog_sales cs
     JOIN 
         date_dim d ON d.d_date_sk = cs.cs_sold_date_sk
     WHERE 
         d.d_moy = 12 AND d.d_year = 2002

     UNION ALL

     SELECT 
         ss.ss_ext_sales_price AS ext_price, 
         ss.ss_item_sk AS sold_item_sk, 
         ss.ss_sold_time_sk AS time_sk 
     FROM 
         store_sales ss
     JOIN 
         date_dim d ON d.d_date_sk = ss.ss_sold_date_sk
     WHERE 
         d.d_moy = 12 AND d.d_year = 2002
    ) tmp ON i.i_item_sk = tmp.sold_item_sk
JOIN 
    time_dim t ON tmp.time_sk = t.t_time_sk
WHERE 
    i.i_manager_id = 1 AND 
    (t.t_meal_time = 'breakfast' OR t.t_meal_time = 'dinner')
GROUP BY 
    i.i_brand, i.i_brand_id, t.t_hour, t.t_minute
ORDER BY 
    SUM(tmp.ext_price) DESC, i.i_brand_id;