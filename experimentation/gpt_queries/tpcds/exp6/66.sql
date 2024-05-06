SELECT 
    w_warehouse_name,
    w_warehouse_sq_ft,
    w_city,
    w_county,
    w_state,
    w_country,
    ship_carriers,
    year,
    SUM(jan_sales) AS jan_sales,
    SUM(feb_sales) AS feb_sales,
    SUM(mar_sales) AS mar_sales,
    SUM(apr_sales) AS apr_sales,
    SUM(may_sales) AS may_sales,
    SUM(jun_sales) AS jun_sales,
    SUM(jul_sales) AS jul_sales,
    SUM(aug_sales) AS aug_sales,
    SUM(sep_sales) AS sep_sales,
    SUM(oct_sales) AS oct_sales,
    SUM(nov_sales) AS nov_sales,
    SUM(dec_sales) AS dec_sales,
    SUM(jan_sales) / NULLIF(SUM(w_warehouse_sq_ft), 0) AS jan_sales_per_sq_foot,
    SUM(feb_sales) / NULLIF(SUM(w_warehouse_sq_ft), 0) AS feb_sales_per_sq_foot,
    SUM(mar_sales) / NULLIF(SUM(w_warehouse_sq_ft), 0) AS mar_sales_per_sq_foot,
    SUM(apr_sales) / NULLIF(SUM(w_warehouse_sq_ft), 0) AS apr_sales_per_sq_foot,
    SUM(may_sales) / NULLIF(SUM(w_warehouse_sq_ft), 0) AS may_sales_per_sq_foot,
    SUM(jun_sales) / NULLIF(SUM(w_warehouse_sq_ft), 0) AS jun_sales_per_sq_foot,
    SUM(jul_sales) / NULLIF(SUM(w_warehouse_sq_ft), 0) AS jul_sales_per_sq_foot,
    SUM(aug_sales) / NULLIF(SUM(w_warehouse_sq_ft), 0) AS aug_sales_per_sq_foot,
    SUM(sep_sales) / NULLIF(SUM(w_warehouse_sq_ft), 0) AS sep_sales_per_sq_foot,
    SUM(oct_sales) / NULLIF(SUM(w_warehouse_sq_ft), 0) AS oct_sales_per_sq_foot,
    SUM(nov_sales) / NULLIF(SUM(w_warehouse_sq_ft), 0) AS nov_sales_per_sq_foot,
    SUM(dec_sales) / NULLIF(SUM(w_warehouse_sq_ft), 0) AS dec_sales_per_sq_foot,
    SUM(jan_net) AS jan_net,
    SUM(feb_net) AS feb_net,
    SUM(mar_net) AS mar_net,
    SUM(apr_net) AS apr_net,
    SUM(may_net) AS may_net,
    SUM(jun_net) AS jun_net,
    SUM(jul_net) AS jul_net,
    SUM(aug_net) AS aug_net,
    SUM(sep_net) AS sep_net,
    SUM(oct_net) AS oct_net,
    SUM(nov_net) AS nov_net,
    SUM(dec_net) AS dec_net
FROM (
    SELECT 
        w_warehouse_name,
        w_warehouse_sq_ft,
        w_city,
        w_county,
        w_state,
        w_country,
        'ORIENTAL,BOXBUNDLES' AS ship_carriers,
        d_year AS year,
        CASE WHEN d_moy = 1 THEN ws_ext_sales_price * ws_quantity ELSE 0 END AS jan_sales,
        CASE WHEN d_moy = 2 THEN ws_ext_sales_price * ws_quantity ELSE 0 END AS feb_sales,
        CASE WHEN d_moy = 3 THEN ws_ext_sales_price * ws_quantity ELSE 0 END AS mar_sales,
        CASE WHEN d_moy = 4 THEN ws_ext_sales_price * ws_quantity ELSE 0 END AS apr_sales,
        CASE WHEN d_moy = 5 THEN ws_ext_sales_price * ws_quantity ELSE 0 END AS may_sales,
        CASE WHEN d_moy = 6 THEN ws_ext_sales_price * ws_quantity ELSE 0 END AS jun_sales,
        CASE WHEN d_moy = 7 THEN ws_ext_sales_price * ws_quantity ELSE 0 END AS jul_sales,
        CASE WHEN d_moy = 8 THEN ws_ext_sales_price * ws_quantity ELSE 0 END AS aug_sales,
        CASE WHEN d_moy = 9 THEN ws_ext_sales_price * ws_quantity ELSE 0 END AS sep_sales,
        CASE WHEN d_moy = 10 THEN ws_ext_sales_price * ws_quantity ELSE 0 END AS oct_sales,
        CASE WHEN d_moy = 11 THEN ws_ext_sales_price * ws_quantity ELSE 0 END AS nov_sales,
        CASE WHEN d_moy = 12 THEN ws_ext_sales_price * ws_quantity ELSE 0 END AS dec_sales,
        CASE WHEN d_moy = 1 THEN ws_net_paid_inc_ship * ws_quantity ELSE 0 END AS jan_net,
        CASE WHEN d_moy = 2 THEN ws_net_paid_inc_ship * ws_quantity ELSE 0 END AS feb_net,
        CASE WHEN d_moy = 3 THEN ws_net_paid_inc_ship * ws_quantity ELSE 0 END AS mar_net,
        CASE WHEN d_moy = 4 THEN ws_net_paid_inc_ship * ws_quantity ELSE 0 END AS apr_net,
        CASE WHEN d_moy = 5 THEN ws_net_paid_inc_ship * ws_quantity ELSE 0 END AS may_net,
        CASE WHEN d_moy = 6 THEN ws_net_paid_inc_ship * ws_quantity ELSE 0 END AS jun_net,
        CASE WHEN d_moy = 7 THEN ws_net_paid_inc_ship * ws_quantity ELSE 0 END AS jul_net,
        CASE WHEN d_moy = 8 THEN ws_net_paid_inc_ship * ws_quantity ELSE 0 END AS aug_net,
        CASE WHEN d_moy = 9 THEN ws_net_paid_inc_ship * ws_quantity ELSE 0 END AS sep_net,
        CASE WHEN d_moy = 10 THEN ws_net_paid_inc_ship * ws_quantity ELSE 0 END AS oct_net,
        CASE WHEN d_moy = 11 THEN ws_net_paid_inc_ship * ws_quantity ELSE 0 END AS nov_net,
        CASE WHEN d_moy = 12 THEN ws_net_paid_inc_ship * ws_quantity ELSE 0 END AS dec_net
    FROM 
        web_sales
        JOIN warehouse ON ws_warehouse_sk = w_warehouse_sk
        JOIN date_dim ON ws_sold_date_sk = d_date_sk
        JOIN time_dim ON ws_sold_time_sk = t_time_sk
        JOIN ship_mode ON ws_ship_mode_sk = sm_ship_mode_sk
    WHERE 
        d_year = 2001 
        AND t_time BETWEEN 42970 AND 42970 + 28800
        AND sm_carrier IN ('ORIENTAL', 'BOXBUNDLES')
    UNION ALL
    SELECT 
        w_warehouse_name,
        w_warehouse_sq_ft,
        w_city,
        w_county,
        w_state,
        w_country,
        'ORIENTAL,BOXBUNDLES' AS ship_carriers,
        d_year AS year,
        CASE WHEN d_moy = 1 THEN cs_ext_list_price * cs_quantity ELSE 0 END AS jan_sales,
        CASE WHEN d_moy = 2 THEN cs_ext_list_price * cs_quantity ELSE 0 END AS feb_sales,
        CASE WHEN d_moy = 3 THEN cs_ext_list_price * cs_quantity ELSE 0 END AS mar_sales,
        CASE WHEN d_moy = 4 THEN cs_ext_list_price * cs_quantity ELSE 0 END AS apr_sales,
        CASE WHEN d_moy = 5 THEN cs_ext_list_price * cs_quantity ELSE 0 END AS may_sales,
        CASE WHEN d_moy = 6 THEN cs_ext_list_price * cs_quantity ELSE 0 END AS jun_sales,
        CASE WHEN d_moy = 7 THEN cs_ext_list_price * cs_quantity ELSE 0 END AS jul_sales,
        CASE WHEN d_moy = 8 THEN cs_ext_list_price * cs_quantity ELSE 0 END AS aug_sales,
        CASE WHEN d_moy = 9 THEN cs_ext_list_price * cs_quantity ELSE 0 END AS sep_sales,
        CASE WHEN d_moy = 10 THEN cs_ext_list_price * cs_quantity ELSE 0 END AS oct_sales,
        CASE WHEN d_moy = 11 THEN cs_ext_list_price * cs_quantity ELSE 0 END AS nov_sales,
        CASE WHEN d_moy = 12 THEN cs_ext_list_price * cs_quantity ELSE 0 END AS dec_sales,
        CASE WHEN d_moy = 1 THEN cs_net_paid * cs_quantity ELSE 0 END AS jan_net,
        CASE WHEN d_moy = 2 THEN cs_net_paid * cs_quantity ELSE 0 END AS feb_net,
        CASE WHEN d_moy = 3 THEN cs_net_paid * cs_quantity ELSE 0 END AS mar_net,
        CASE WHEN d_moy = 4 THEN cs_net_paid * cs_quantity ELSE 0 END AS apr_net,
        CASE WHEN d_moy = 5 THEN cs_net_paid * cs_quantity ELSE 0 END AS may_net,
        CASE WHEN d_moy = 6 THEN cs_net_paid * cs_quantity ELSE 0 END AS jun_net,
        CASE WHEN d_moy = 7 THEN cs_net_paid * cs_quantity ELSE 0 END AS jul_net,
        CASE WHEN d_moy = 8 THEN cs_net_paid * cs_quantity ELSE 0 END AS aug_net,
        CASE WHEN d_moy = 9 THEN cs_net_paid * cs_quantity ELSE 0 END AS sep_net,
        CASE WHEN d_moy = 10 THEN cs_net_paid * cs_quantity ELSE 0 END AS oct_net,
        CASE WHEN d_moy = 11 THEN cs_net_paid * cs_quantity ELSE 0 END AS nov_net,
        CASE WHEN d_moy = 12 THEN cs_net_paid * cs_quantity ELSE 0 END AS dec_net
    FROM 
        catalog_sales
        JOIN warehouse ON cs_warehouse_sk = w_warehouse_sk
        JOIN date_dim ON cs_sold_date_sk = d_date_sk
        JOIN time_dim ON cs_sold_time_sk = t_time_sk
        JOIN ship_mode ON cs_ship_mode_sk = sm_ship_mode_sk
    WHERE 
        d_year = 2001 
        AND t_time BETWEEN 42970 AND 42970 + 28800
        AND sm_carrier IN ('ORIENTAL', 'BOXBUNDLES')
) x
GROUP BY 
    w_warehouse_name,
    w_warehouse_sq_ft,
    w_city,
    w_county,
    w_state,
    w_country,
    ship_carriers,
    year
ORDER BY 
    w_warehouse_name
LIMIT 100;