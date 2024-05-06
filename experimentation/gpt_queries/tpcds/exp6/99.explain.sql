explain select 
    substr(w_warehouse_name, 1, 20) AS warehouse_name,
    sm_type,
    cc_name,
    SUM(CASE WHEN (cs_ship_date_sk - cs_sold_date_sk <= 30) THEN 1 ELSE 0 END) AS "30 days",
    SUM(CASE WHEN (cs_ship_date_sk - cs_sold_date_sk > 30) AND (cs_ship_date_sk - cs_sold_date_sk <= 60) THEN 1 ELSE 0 END) AS "31-60 days",
    SUM(CASE WHEN (cs_ship_date_sk - cs_sold_date_sk > 60) AND (cs_ship_date_sk - cs_sold_date_sk <= 90) THEN 1 ELSE 0 END) AS "61-90 days",
    SUM(CASE WHEN (cs_ship_date_sk - cs_sold_date_sk > 90) AND (cs_ship_date_sk - cs_sold_date_sk <= 120) THEN 1 ELSE 0 END) AS "91-120 days",
    SUM(CASE WHEN (cs_ship_date_sk - cs_sold_date_sk > 120) THEN 1 ELSE 0 END) AS ">120 days"
FROM 
    catalog_sales
JOIN 
    warehouse ON cs_warehouse_sk = w_warehouse_sk
JOIN 
    ship_mode ON cs_ship_mode_sk = sm_ship_mode_sk
JOIN 
    call_center ON cs_call_center_sk = cc_call_center_sk
JOIN 
    date_dim ON cs_ship_date_sk = d_date_sk
WHERE 
    d_month_seq BETWEEN 1194 AND 1194 + 11
GROUP BY 
    substr(w_warehouse_name, 1, 20),
    sm_type,
    cc_name
ORDER BY 
    substr(w_warehouse_name, 1, 20),
    sm_type,
    cc_name
LIMIT 100;SELECT 
    substr(w_warehouse_name, 1, 20) AS warehouse_name,
    sm_type,
    cc_name,
    SUM(CASE WHEN (cs_ship_date_sk - cs_sold_date_sk <= 30) THEN 1 ELSE 0 END) AS "30 days",
    SUM(CASE WHEN (cs_ship_date_sk - cs_sold_date_sk > 30) AND (cs_ship_date_sk - cs_sold_date_sk <= 60) THEN 1 ELSE 0 END) AS "31-60 days",
    SUM(CASE WHEN (cs_ship_date_sk - cs_sold_date_sk > 60) AND (cs_ship_date_sk - cs_sold_date_sk <= 90) THEN 1 ELSE 0 END) AS "61-90 days",
    SUM(CASE WHEN (cs_ship_date_sk - cs_sold_date_sk > 90) AND (cs_ship_date_sk - cs_sold_date_sk <= 120) THEN 1 ELSE 0 END) AS "91-120 days",
    SUM(CASE WHEN (cs_ship_date_sk - cs_sold_date_sk > 120) THEN 1 ELSE 0 END) AS ">120 days"
FROM 
    catalog_sales
JOIN 
    warehouse ON cs_warehouse_sk = w_warehouse_sk
JOIN 
    ship_mode ON cs_ship_mode_sk = sm_ship_mode_sk
JOIN 
    call_center ON cs_call_center_sk = cc_call_center_sk
JOIN 
    date_dim ON cs_ship_date_sk = d_date_sk
WHERE 
    d_month_seq BETWEEN 1194 AND 1194 + 11
GROUP BY 
    substr(w_warehouse_name, 1, 20),
    sm_type,
    cc_name
ORDER BY 
    substr(w_warehouse_name, 1, 20),
    sm_type,
    cc_name
LIMIT 100;