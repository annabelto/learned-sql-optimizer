WITH ssales AS (
    SELECT 
        c_last_name,
        c_first_name,
        s_store_name,
        ca_state,
        s_state,
        i_color,
        i_current_price,
        i_manager_id,
        i_units,
        i_size,
        SUM(ss_net_paid) AS netpaid
    FROM 
        store_sales
        JOIN store_returns ON store_sales.ss_ticket_number = store_returns.sr_ticket_number AND store_sales.ss_item_sk = store_returns.sr_item_sk
        JOIN store ON store_sales.ss_store_sk = store.s_store_sk
        JOIN item ON store_sales.ss_item_sk = item.i_item_sk
        JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
        JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
    WHERE 
        customer.c_birth_country <> UPPER(customer_address.ca_country)
        AND store.s_zip = customer_address.ca_zip
        AND store.s_market_id = 5
    GROUP BY 
        c_last_name,
        c_first_name,
        s_store_name,
        ca_state,
        s_state,
        i_color,
        i_current_price,
        i_manager_id,
        i_units,
        i_size
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
    c_last_name, c_first_name, s_store_name;

WITH ssales AS (
    SELECT 
        c_last_name,
        c_first_name,
        s_store_name,
        ca_state,
        s_state,
        i_color,
        i_current_price,
        i_manager_id,
        i_units,
        i_size,
        SUM(ss_net_paid) AS netpaid
    FROM 
        store_sales
        JOIN store_returns ON store_sales.ss_ticket_number = store_returns.sr_ticket_number AND store_sales.ss_item_sk = store_returns.sr_item_sk
        JOIN store ON store_sales.ss_store_sk = store.s_store_sk
        JOIN item ON store_sales.ss_item_sk = item.i_item_sk
        JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
        JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
    WHERE 
        customer.c_birth_country <> UPPER(customer_address.ca_country)
        AND store.s_zip = customer_address.ca_zip
        AND store.s_market_id = 5
    GROUP BY 
        c_last_name,
        c_first_name,
        s_store_name,
        ca_state,
        s_state,
        i_color,
        i_current_price,
        i_manager_id,
        i_units,
        i_size
)
explain select 
    c_last_name,
    c_first_name,
    s_store_name,
    SUM(netpaid) AS paid
FROM 
    ssales
WHERE 
    i_color = 'seashell'
GROUP BY 
    c_last_name, c_first_name, s_store_name
HAVING 
    SUM(netpaid) > (SELECT 0.05 * AVG(netpaid) FROM ssales)
ORDER BY 
    c_last_name, c_first_name, s_store_name;WITH ssales AS (
    SELECT 
        c_last_name,
        c_first_name,
        s_store_name,
        ca_state,
        s_state,
        i_color,
        i_current_price,
        i_manager_id,
        i_units,
        i_size,
        SUM(ss_net_paid) AS netpaid
    FROM 
        store_sales
        JOIN store_returns ON store_sales.ss_ticket_number = store_returns.sr_ticket_number AND store_sales.ss_item_sk = store_returns.sr_item_sk
        JOIN store ON store_sales.ss_store_sk = store.s_store_sk
        JOIN item ON store_sales.ss_item_sk = item.i_item_sk
        JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
        JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
    WHERE 
        customer.c_birth_country <> UPPER(customer_address.ca_country)
        AND store.s_zip = customer_address.ca_zip
        AND store.s_market_id = 5
    GROUP BY 
        c_last_name,
        c_first_name,
        s_store_name,
        ca_state,
        s_state,
        i_color,
        i_current_price,
        i_manager_id,
        i_units,
        i_size
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

WITH ssales AS (
    SELECT 
        c_last_name,
        c_first_name,
        s_store_name,
        ca_state,
        s_state,
        i_color,
        i_current_price,
        i_manager_id,
        i_units,
        i_size,
        SUM(ss_net_paid) AS netpaid
    FROM 
        store_sales
        JOIN store_returns ON store_sales.ss_ticket_number = store_returns.sr_ticket_number AND store_sales.ss_item_sk = store_returns.sr_item_sk
        JOIN store ON store_sales.ss_store_sk = store.s_store_sk
        JOIN item ON store_sales.ss_item_sk = item.i_item_sk
        JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
        JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
    WHERE 
        customer.c_birth_country <> UPPER(customer_address.ca_country)
        AND store.s_zip = customer_address.ca_zip
        AND store.s_market_id = 5
    GROUP BY 
        c_last_name,
        c_first_name,
        s_store_name,
        ca_state,
        s_state,
        i_color,
        i_current_price,
        i_manager_id,
        i_units,
        i_size
)
SELECT 
    c_last_name,
    c_first_name,
    s_store_name,
    SUM(netpaid) AS paid
FROM 
    ssales
WHERE 
    i_color = 'seashell'
GROUP BY 
    c_last_name, c_first_name, s_store_name
HAVING 
    SUM(netpaid) > (SELECT 0.05 * AVG(netpaid) FROM ssales)
ORDER BY 
    c_last_name, c_first_name, s_store_name;