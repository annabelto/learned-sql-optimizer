explain select 
    substr(w.w_warehouse_name, 1, 20) AS warehouse_name_short,
    sm.sm_type,
    cc.cc_name,
    SUM(CASE WHEN date_diff <= 30 THEN 1 ELSE 0 END) AS "30 days",
    SUM(CASE WHEN date_diff > 30 AND date_diff <= 60 THEN 1 ELSE 0 END) AS "31-60 days",
    SUM(CASE WHEN date_diff > 60 AND date_diff <= 90 THEN 1 ELSE 0 END) AS "61-90 days",
    SUM(CASE WHEN date_diff > 90 AND date_diff <= 120 THEN 1 ELSE 0 END) AS "91-120 days",
    SUM(CASE WHEN date_diff > 120 THEN 1 ELSE 0 END) AS ">120 days"
FROM 
    catalog_sales cs
JOIN 
    date_dim d ON cs.cs_ship_date_sk = d.d_date_sk
JOIN 
    warehouse w ON cs.cs_warehouse_sk = w.w_warehouse_sk
JOIN 
    ship_mode sm ON cs.cs_ship_mode_sk = sm.sm_ship_mode_sk
JOIN 
    call_center cc ON cs.cs_call_center_sk = cc.cc_call_center_sk
CROSS JOIN 
    LATERAL (SELECT cs.cs_ship_date_sk - cs.cs_sold_date_sk AS date_diff) AS diff
WHERE 
    d.d_month_seq BETWEEN 1194 AND 1205
GROUP BY 
    substr(w.w_warehouse_name, 1, 20),
    sm.sm_type,
    cc.cc_name
ORDER BY 
    substr(w.w_warehouse_name, 1, 20),
    sm.sm_type,
    cc.cc_name
LIMIT 100;SELECT 
    substr(w.w_warehouse_name, 1, 20) AS warehouse_name_short,
    sm.sm_type,
    cc.cc_name,
    SUM(CASE WHEN date_diff <= 30 THEN 1 ELSE 0 END) AS "30 days",
    SUM(CASE WHEN date_diff > 30 AND date_diff <= 60 THEN 1 ELSE 0 END) AS "31-60 days",
    SUM(CASE WHEN date_diff > 60 AND date_diff <= 90 THEN 1 ELSE 0 END) AS "61-90 days",
    SUM(CASE WHEN date_diff > 90 AND date_diff <= 120 THEN 1 ELSE 0 END) AS "91-120 days",
    SUM(CASE WHEN date_diff > 120 THEN 1 ELSE 0 END) AS ">120 days"
FROM 
    catalog_sales cs
JOIN 
    date_dim d ON cs.cs_ship_date_sk = d.d_date_sk
JOIN 
    warehouse w ON cs.cs_warehouse_sk = w.w_warehouse_sk
JOIN 
    ship_mode sm ON cs.cs_ship_mode_sk = sm.sm_ship_mode_sk
JOIN 
    call_center cc ON cs.cs_call_center_sk = cc.cc_call_center_sk
CROSS JOIN 
    LATERAL (SELECT cs.cs_ship_date_sk - cs.cs_sold_date_sk AS date_diff) AS diff
WHERE 
    d.d_month_seq BETWEEN 1194 AND 1205
GROUP BY 
    substr(w.w_warehouse_name, 1, 20),
    sm.sm_type,
    cc.cc_name
ORDER BY 
    substr(w.w_warehouse_name, 1, 20),
    sm.sm_type,
    cc.cc_name
LIMIT 100;