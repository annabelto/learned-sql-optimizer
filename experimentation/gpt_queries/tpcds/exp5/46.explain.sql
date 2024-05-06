explain select 
    c_last_name,
    c_first_name,
    ca_city,
    bought_city,
    ss_ticket_number,
    amt,
    profit
FROM 
    (
        SELECT 
            ss_ticket_number,
            ss_customer_sk,
            ca_city AS bought_city,
            SUM(ss_coupon_amt) AS amt,
            SUM(ss_net_profit) AS profit
        FROM 
            store_sales
            JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
            JOIN store ON store_sales.ss_store_sk = store.s_store_sk
            JOIN household_demographics ON store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk
            JOIN customer_address ON store_sales.ss_addr_sk = customer_address.ca_address_sk
        WHERE 
            (household_demographics.hd_dep_count = 8 OR household_demographics.hd_vehicle_count = 0)
            AND date_dim.d_dow IN (6, 0)
            AND date_dim.d_year IN (2000, 2001, 2002)
            AND store.s_city IN ('Midway', 'Fairview')
        GROUP BY 
            ss_ticket_number,
            ss_customer_sk,
            ss_addr_sk,
            ca_city
    ) AS dn
    JOIN customer ON dn.ss_customer_sk = customer.c_customer_sk
    JOIN customer_address AS current_addr ON customer.c_current_addr_sk = current_addr.ca_address_sk
WHERE 
    current_addr.ca_city <> bought_city
ORDER BY 
    c_last_name,
    c_first_name,
    ca_city,
    bought_city,
    ss_ticket_number
LIMIT 100;SELECT 
    c_last_name,
    c_first_name,
    ca_city,
    bought_city,
    ss_ticket_number,
    amt,
    profit
FROM 
    (
        SELECT 
            ss_ticket_number,
            ss_customer_sk,
            ca_city AS bought_city,
            SUM(ss_coupon_amt) AS amt,
            SUM(ss_net_profit) AS profit
        FROM 
            store_sales
            JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
            JOIN store ON store_sales.ss_store_sk = store.s_store_sk
            JOIN household_demographics ON store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk
            JOIN customer_address ON store_sales.ss_addr_sk = customer_address.ca_address_sk
        WHERE 
            (household_demographics.hd_dep_count = 8 OR household_demographics.hd_vehicle_count = 0)
            AND date_dim.d_dow IN (6, 0)
            AND date_dim.d_year IN (2000, 2001, 2002)
            AND store.s_city IN ('Midway', 'Fairview')
        GROUP BY 
            ss_ticket_number,
            ss_customer_sk,
            ss_addr_sk,
            ca_city
    ) AS dn
    JOIN customer ON dn.ss_customer_sk = customer.c_customer_sk
    JOIN customer_address AS current_addr ON customer.c_current_addr_sk = current_addr.ca_address_sk
WHERE 
    current_addr.ca_city <> bought_city
ORDER BY 
    c_last_name,
    c_first_name,
    ca_city,
    bought_city,
    ss_ticket_number
LIMIT 100;