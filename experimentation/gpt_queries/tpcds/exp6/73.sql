SELECT 
    c.c_last_name,
    c.c_first_name,
    c.c_salutation,
    c.c_preferred_cust_flag,
    ss.ss_ticket_number,
    COUNT(*) AS cnt
FROM 
    store_sales ss
JOIN 
    date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
JOIN 
    store s ON ss.ss_store_sk = s.s_store_sk
JOIN 
    household_demographics hd ON ss.ss_hdemo_sk = hd.hd_demo_sk
JOIN 
    customer c ON ss.ss_customer_sk = c.c_customer_sk
WHERE 
    d.d_dom BETWEEN 1 AND 2
    AND d.d_year IN (2000, 2001, 2002)
    AND s.s_county = 'Williamson County'
    AND (hd.hd_buy_potential = '1001-5000' OR hd.hd_buy_potential = '5001-10000')
    AND hd.hd_vehicle_count > 0
    AND (hd.hd_dep_count / NULLIF(hd.hd_vehicle_count, 0)) > 1
GROUP BY 
    ss.ss_ticket_number, 
    c.c_customer_sk, c.c_last_name, c.c_first_name, c.c_salutation, c.c_preferred_cust_flag
HAVING 
    COUNT(*) BETWEEN 1 AND 5
ORDER BY 
    cnt DESC, 
    c.c_last_name ASC;