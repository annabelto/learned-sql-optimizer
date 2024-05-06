WITH ssales AS (
    SELECT 
        c_last_name,
        c_first_name,
        s_store_name,
        i_color,
        SUM(ss_net_paid) AS netpaid
    FROM 
        store_sales
        JOIN store_returns ON ss_ticket_number = sr_ticket_number AND ss_item_sk = sr_item_sk
        JOIN store ON ss_store_sk = s_store_sk
        JOIN item ON ss_item_sk = i_item_sk
        JOIN customer ON ss_customer_sk = c_customer_sk
        JOIN customer_address ON c_current_addr_sk = ca_address_sk
    WHERE 
        c_birth_country <> UPPER(ca_country)
        AND s_zip = ca_zip
        AND s_market_id = 5
    GROUP BY 
        c_last_name,
        c_first_name,
        s_store_name,
        i_color
), avg_netpaid AS (
    SELECT 
        0.05 * AVG(netpaid) AS avg_netpaid_threshold
    FROM 
        ssales
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
    c_last_name,
    c_first_name,
    s_store_name
HAVING 
    SUM(netpaid) > (SELECT avg_netpaid_threshold FROM avg_netpaid)
ORDER BY 
    c_last_name, c_first_name, s_store_name;

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
    c_last_name,
    c_first_name, s_store_name
HAVING 
    SUM(netpaid) > (SELECT avg_netpaid_threshold FROM avg_netpaid)
ORDER BY 
    c_last_name, c_first_name, s_store_name;