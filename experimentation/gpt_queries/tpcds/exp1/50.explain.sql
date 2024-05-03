explain select 
    s.s_store_name,
    s.s_company_id,
    s.s_street_number,
    s.s_street_name,
    s.s_street_type,
    s.s_suite_number,
    s.s_city,
    s.s_county,
    s.s_state,
    s.s_zip,
    SUM(CASE WHEN (sr.sr_returned_date_sk - ss.ss_sold_date_sk <= 30) THEN 1 ELSE 0 END) AS "30 days",
    SUM(CASE WHEN (sr.sr_returned_date_sk - ss.ss_sold_date_sk > 30) AND (sr.sr_returned_date_sk - ss.ss_sold_date_sk <= 60) THEN 1 ELSE 0 END) AS "31-60 days",
    SUM(CASE WHEN (sr.sr_returned_date_sk - ss.ss_sold_date_sk > 60) AND (sr.sr_returned_date_sk - ss.ss_sold_date_sk <= 90) THEN 1 ELSE 0 END) AS "61-90 days",
    SUM(CASE WHEN (sr.sr_returned_date_sk - ss.ss_sold_date_sk > 90) AND (sr.sr_returned_date_sk - ss.ss_sold_date_sk <= 120) THEN 1 ELSE 0 END) AS "91-120 days",
    SUM(CASE WHEN (sr.sr_returned_date_sk - ss.ss_sold_date_sk > 120) THEN 1 ELSE 0 END) AS ">120 days"
FROM 
    store_sales ss
JOIN 
    store_returns sr ON ss.ss_ticket_number = sr.sr_ticket_number AND ss.ss_item_sk = sr.sr_item_sk AND ss.ss_customer_sk = sr.sr_customer_sk
JOIN 
    store s ON ss.ss_store_sk = s.s_store_sk
JOIN 
    date_dim d1 ON ss.ss_sold_date_sk = d1.d_date_sk
JOIN 
    date_dim d2 ON sr.sr_returned_date_sk = d2.d_date_sk AND d2.d_year = 2001 AND d2.d_moy = 8
GROUP BY 
    s.s_store_name, s.s_company_id, s.s_street_number, s.s_street_name, s.s_street_type, s.s_suite_number, s.s_city, s.s_county, s.s_state, s.s_zip
ORDER BY 
    s.s_store_name, s.s_company_id, s.s_street_number, s.s_street_name, s.s_street_type, s.s_suite_number, s.s_city, s.s_county, s.s_state, s.s_zip
LIMIT 100;SELECT 
    s.s_store_name,
    s.s_company_id,
    s.s_street_number,
    s.s_street_name,
    s.s_street_type,
    s.s_suite_number,
    s.s_city,
    s.s_county,
    s.s_state,
    s.s_zip,
    SUM(CASE WHEN (sr.sr_returned_date_sk - ss.ss_sold_date_sk <= 30) THEN 1 ELSE 0 END) AS "30 days",
    SUM(CASE WHEN (sr.sr_returned_date_sk - ss.ss_sold_date_sk > 30) AND (sr.sr_returned_date_sk - ss.ss_sold_date_sk <= 60) THEN 1 ELSE 0 END) AS "31-60 days",
    SUM(CASE WHEN (sr.sr_returned_date_sk - ss.ss_sold_date_sk > 60) AND (sr.sr_returned_date_sk - ss.ss_sold_date_sk <= 90) THEN 1 ELSE 0 END) AS "61-90 days",
    SUM(CASE WHEN (sr.sr_returned_date_sk - ss.ss_sold_date_sk > 90) AND (sr.sr_returned_date_sk - ss.ss_sold_date_sk <= 120) THEN 1 ELSE 0 END) AS "91-120 days",
    SUM(CASE WHEN (sr.sr_returned_date_sk - ss.ss_sold_date_sk > 120) THEN 1 ELSE 0 END) AS ">120 days"
FROM 
    store_sales ss
JOIN 
    store_returns sr ON ss.ss_ticket_number = sr.sr_ticket_number AND ss.ss_item_sk = sr.sr_item_sk AND ss.ss_customer_sk = sr.sr_customer_sk
JOIN 
    store s ON ss.ss_store_sk = s.s_store_sk
JOIN 
    date_dim d1 ON ss.ss_sold_date_sk = d1.d_date_sk
JOIN 
    date_dim d2 ON sr.sr_returned_date_sk = d2.d_date_sk AND d2.d_year = 2001 AND d2.d_moy = 8
GROUP BY 
    s.s_store_name, s.s_company_id, s.s_street_number, s.s_street_name, s.s_street_type, s.s_suite_number, s.s_city, s.s_county, s.s_state, s.s_zip
ORDER BY 
    s.s_store_name, s.s_company_id, s.s_street_number, s.s_street_name, s.s_street_type, s.s_suite_number, s.s_city, s.s_county, s.s_state, s.s_zip
LIMIT 100;