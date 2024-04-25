SELECT 
    w_warehouse_name,
    w_warehouse_sq_ft,
    w_city,
    w_county,
    w_state,
    w_country,
    'ORIENTAL,BOXBUNDLES' AS ship_carriers,
    year,
    SUM(jan_sales) AS jan_sales,
    SUM(feb_sales) AS feb_sales,
    -- Include other months and net calculations similarly
    SUM(dec_sales) AS dec_sales,
    SUM(jan_sales/w_warehouse_sq_ft) AS jan_sales_per_sq_foot,
    -- Include other months per sq foot calculations similarly
    SUM(dec_sales/w_warehouse_sq_ft) AS dec_sales_per_sq_foot,
    SUM(jan_net) AS jan_net,
    -- Include other net calculations similarly
    SUM(dec_net) AS dec_net
FROM (
    SELECT 
        w_warehouse_name,
        w_warehouse_sq_ft,
        w_city,
        w_county,
        w_state,
        w_country,
        d_year AS year,
        -- Include sales and net calculations for each month similarly
        SUM(case when d_moy = 12 THEN ws_ext_sales_price * ws_quantity ELSE 0 END) AS dec_sales,
        SUM(case when d_moy = 12 THEN ws_net_paid_inc_ship * ws_quantity ELSE 0 END) AS dec_net
    FROM 
        web_sales
        JOIN warehouse ON ws_warehouse_sk = w_warehouse_sk
        JOIN date_dim ON ws_sold_date_sk = d_date_sk AND d_year = 2001
        JOIN time_dim ON ws_sold_time_sk = t_time_sk AND t_time BETWEEN 42970 AND 42970+28800
        JOIN ship_mode ON ws_ship_mode_sk = sm_ship_mode_sk AND sm_carrier IN ('ORIENTAL', 'BOXBUNDLES')
    GROUP BY 
        w_warehouse_name, w_warehouse_sq_ft, w_city, w_county, w_state, w_country, d_year
    UNION ALL
    -- Similar subquery for catalog_sales
) x
GROUP BY 
    w_warehouse_name, w_warehouse_sq_ft, w_city, w_county, w_state, w_country, ship_carriers, year
ORDER BY 
    w_warehouse_name
LIMIT 100;