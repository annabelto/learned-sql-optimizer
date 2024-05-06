WITH ssales AS (
    SELECT 
        c.c_last_name,
        c.c_first_name,
        s.s_store_name,
        ca.ca_state,
        s.s_state,
        i.i_color,
        i.i_current_price,
        i.i_manager_id,
        i.i_units,
        i.i_size,
        SUM(ss.ss_net_paid) AS netpaid
    FROM 
        store_sales ss
        JOIN store_returns sr ON ss.ss_ticket_number = sr.sr_ticket_number AND ss.ss_item_sk = sr.sr_item_sk
        JOIN store s ON ss.ss_store_sk = s.s_store_sk
        JOIN item i ON ss.ss_item_sk = i.i_item_sk
        JOIN customer c ON ss.ss_customer_sk = c.c_customer_sk
        JOIN customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
    WHERE 
        c.c_birth_country <> UPPER(ca.ca_country)
        AND s.s_zip = ca.ca_zip
        AND s.s_market_id = 5
    GROUP BY 
        c.c_last_name,
        c.c_first_name,
        s.s_store_name,
        ca.ca_state,
        s.s_state,
        i.i_color,
        i.i_current_price,
        i.i_manager_id,
        i.i_units,
        i.i_size
)
explain select 
    c_last_name,
    c_first_name,
    s_store_name,
    SUM(netpaid) AS paid
FROM 
    ssales
WHERE 
    i_color = 'aquamarine'
GROUP BY 
    c_last_name, c_first_name, s_store_name
HAVING 
    SUM(netpaid) > (SELECT 0.05 * AVG(netpaid) FROM ssales)
ORDER BY 
    c_last_name, c_first_name, s_store_name;WITH ssales AS (
    SELECT 
        c.c_last_name,
        c.c_first_name,
        s.s_store_name,
        ca.ca_state,
        s.s_state,
        i.i_color,
        i.i_current_price,
        i.i_manager_id,
        i.i_units,
        i.i_size,
        SUM(ss.ss_net_paid) AS netpaid
    FROM 
        store_sales ss
        JOIN store_returns sr ON ss.ss_ticket_number = sr.sr_ticket_number AND ss.ss_item_sk = sr.sr_item_sk
        JOIN store s ON ss.ss_store_sk = s.s_store_sk
        JOIN item i ON ss.ss_item_sk = i.i_item_sk
        JOIN customer c ON ss.ss_customer_sk = c.c_customer_sk
        JOIN customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
    WHERE 
        c.c_birth_country <> UPPER(ca.ca_country)
        AND s.s_zip = ca.ca_zip
        AND s.s_market_id = 5
    GROUP BY 
        c.c_last_name,
        c.c_first_name,
        s.s_store_name,
        ca.ca_state,
        s.s_state,
        i.i_color,
        i.i_current_price,
        i.i_manager_id,
        i.i_units,
        i.i_size
)
SELECT 
    c_last_name,
    c_first_name,
    s_store_name,
    SUM(netpaid) AS paid
FROM 
    ssales
WHERE 
    i_color = 'aquamarine'
GROUP BY 
    c_last_name, c_first_name, s_store_name
HAVING 
    SUM(netpaid) > (SELECT 0.05 * AVG(netpaid) FROM ssales)
ORDER BY 
    c_last_name, c_first_name, s_store_name;