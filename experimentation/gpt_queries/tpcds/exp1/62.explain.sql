explain select 
    substr(w.w_warehouse_name, 1, 20) AS warehouse_name,
    sm.sm_type,
    ws.web_name,
    SUM(CASE WHEN date_diff <= 30 THEN 1 ELSE 0 END) AS "30 days",
    SUM(CASE WHEN date_diff > 30 AND date_diff <= 60 THEN 1 ELSE 0 END) AS "31-60 days",
    SUM(CASE WHEN date_diff > 60 AND date_diff <= 90 THEN 1 ELSE 0 END) AS "61-90 days",
    SUM(CASE WHEN date_diff > 90 AND date_diff <= 120 THEN 1 ELSE 0 END) AS "91-120 days",
    SUM(CASE WHEN date_diff > 120 THEN 1 ELSE 0 END) AS ">120 days"
FROM 
    web_sales ws
JOIN 
    warehouse w ON ws.ws_warehouse_sk = w.w_warehouse_sk
JOIN 
    ship_mode sm ON ws.ws_ship_mode_sk = sm.sm_ship_mode_sk
JOIN 
    web_site ws ON ws.ws_web_site_sk = ws.web_site_sk
JOIN 
    date_dim d ON ws.ws_ship_date_sk = d.d_date_sk
WHERE 
    d.d_month_seq BETWEEN 1223 AND 1234
    AND ws.ws_sold_date_sk IS NOT NULL
GROUP BY 
    substr(w.w_warehouse_name, 1, 20),
    sm.sm_type,
    ws.web_name
ORDER BY 
    substr(w.w_warehouse_name, 1, 20),
    sm.sm_type,
    ws.web_name
LIMIT 100;SELECT 
    substr(w.w_warehouse_name, 1, 20) AS warehouse_name,
    sm.sm_type,
    ws.web_name,
    SUM(CASE WHEN date_diff <= 30 THEN 1 ELSE 0 END) AS "30 days",
    SUM(CASE WHEN date_diff > 30 AND date_diff <= 60 THEN 1 ELSE 0 END) AS "31-60 days",
    SUM(CASE WHEN date_diff > 60 AND date_diff <= 90 THEN 1 ELSE 0 END) AS "61-90 days",
    SUM(CASE WHEN date_diff > 90 AND date_diff <= 120 THEN 1 ELSE 0 END) AS "91-120 days",
    SUM(CASE WHEN date_diff > 120 THEN 1 ELSE 0 END) AS ">120 days"
FROM 
    web_sales ws
JOIN 
    warehouse w ON ws.ws_warehouse_sk = w.w_warehouse_sk
JOIN 
    ship_mode sm ON ws.ws_ship_mode_sk = sm.sm_ship_mode_sk
JOIN 
    web_site ws ON ws.ws_web_site_sk = ws.web_site_sk
JOIN 
    date_dim d ON ws.ws_ship_date_sk = d.d_date_sk
WHERE 
    d.d_month_seq BETWEEN 1223 AND 1234
    AND ws.ws_sold_date_sk IS NOT NULL
GROUP BY 
    substr(w.w_warehouse_name, 1, 20),
    sm.sm_type,
    ws.web_name
ORDER BY 
    substr(w.w_warehouse_name, 1, 20),
    sm.sm_type,
    ws.web_name
LIMIT 100;