explain select 
    substr(w.w_warehouse_name, 1, 20) AS warehouse_name,
    sm.sm_type,
    web.web_name,
    COUNT(*) FILTER (WHERE ws.ws_ship_date_sk - ws.ws_sold_date_sk <= 30) AS "30 days",
    COUNT(*) FILTER (WHERE ws.ws_ship_date_sk - ws.ws_sold_date_sk > 30 AND ws.ws_ship_date_sk - ws.ws_sold_date_sk <= 60) AS "31-60 days",
    COUNT(*) FILTER (WHERE ws.ws_ship_date_sk - ws.ws_sold_date_sk > 60 AND ws.ws_ship_date_sk - ws.ws_sold_date_sk <= 90) AS "61-90 days",
    COUNT(*) FILTER (WHERE ws.ws_ship_date_sk - ws.ws_sold_date_sk > 90 AND ws.ws_ship_date_sk - ws.ws_sold_date_sk <= 120) AS "91-120 days",
    COUNT(*) FILTER (WHERE ws.ws_ship_date_sk - ws.ws_sold_date_sk > 120) AS ">120 days"
FROM 
    web_sales ws
JOIN 
    warehouse w ON ws.ws_warehouse_sk = w.w_warehouse_sk
JOIN 
    ship_mode sm ON ws.ws_ship_mode_sk = sm.sm_ship_mode_sk
JOIN 
    web_site web ON ws.ws_web_site_sk = web.web_site_sk
JOIN 
    date_dim d ON ws.ws_ship_date_sk = d.d_date_sk
WHERE 
    d.d_month_seq BETWEEN 1223 AND 1234
GROUP BY 
    substr(w.w_warehouse_name, 1, 20),
    sm.sm_type,
    web.web_name
ORDER BY 
    substr(w.w_warehouse_name, 1, 20),
    sm.sm_type,
    web.web_name
LIMIT 100;SELECT 
    substr(w.w_warehouse_name, 1, 20) AS warehouse_name,
    sm.sm_type,
    web.web_name,
    COUNT(*) FILTER (WHERE ws.ws_ship_date_sk - ws.ws_sold_date_sk <= 30) AS "30 days",
    COUNT(*) FILTER (WHERE ws.ws_ship_date_sk - ws.ws_sold_date_sk > 30 AND ws.ws_ship_date_sk - ws.ws_sold_date_sk <= 60) AS "31-60 days",
    COUNT(*) FILTER (WHERE ws.ws_ship_date_sk - ws.ws_sold_date_sk > 60 AND ws.ws_ship_date_sk - ws.ws_sold_date_sk <= 90) AS "61-90 days",
    COUNT(*) FILTER (WHERE ws.ws_ship_date_sk - ws.ws_sold_date_sk > 90 AND ws.ws_ship_date_sk - ws.ws_sold_date_sk <= 120) AS "91-120 days",
    COUNT(*) FILTER (WHERE ws.ws_ship_date_sk - ws.ws_sold_date_sk > 120) AS ">120 days"
FROM 
    web_sales ws
JOIN 
    warehouse w ON ws.ws_warehouse_sk = w.w_warehouse_sk
JOIN 
    ship_mode sm ON ws.ws_ship_mode_sk = sm.sm_ship_mode_sk
JOIN 
    web_site web ON ws.ws_web_site_sk = web.web_site_sk
JOIN 
    date_dim d ON ws.ws_ship_date_sk = d.d_date_sk
WHERE 
    d.d_month_seq BETWEEN 1223 AND 1234
GROUP BY 
    substr(w.w_warehouse_name, 1, 20),
    sm.sm_type,
    web.web_name
ORDER BY 
    substr(w.w_warehouse_name, 1, 20),
    sm.sm_type,
    web.web_name
LIMIT 100;