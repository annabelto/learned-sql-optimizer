SELECT 
    c.c_last_name,
    c.c_first_name,
    ca.ca_city,
    bought_city,
    ss.ss_ticket_number,
    extended_price,
    extended_tax,
    list_price
FROM 
    (SELECT 
        ss.ss_ticket_number,
        ss.ss_customer_sk,
        ca.ca_city AS bought_city,
        SUM(ss.ss_ext_sales_price) AS extended_price,
        SUM(ss.ss_ext_list_price) AS list_price,
        SUM(ss.ss_ext_tax) AS extended_tax
    FROM 
        store_sales ss
    JOIN 
        date_dim dd ON ss.ss_sold_date_sk = dd.d_date_sk
    JOIN 
        store s ON ss.ss_store_sk = s.s_store_sk
    JOIN 
        household_demographics hd ON ss.ss_hdemo_sk = hd.hd_demo_sk
    JOIN 
        customer_address ca ON ss.ss_addr_sk = ca.ca_address_sk
    WHERE 
        dd.d_dom BETWEEN 1 AND 2
        AND (hd.hd_dep_count = 3 OR hd.hd_vehicle_count = 4)
        AND dd.d_year IN (1998, 1999, 2000)
        AND s.s_city IN ('Fairview', 'Midway')
    GROUP BY 
        ss.ss_ticket_number, ss.ss_customer_sk, ca.ca_city
    ) ss
JOIN 
    customer c ON ss.ss_customer_sk = c.c_customer_sk
JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
WHERE 
    ca.ca_city <> ss.bought_city
ORDER BY 
    c.c_last_name, ss.ss_ticket_number
LIMIT 100;