SELECT 
    c_customer_id AS customer_id, 
    COALESCE(c_last_name, '') || ', ' || COALESCE(c_first_name, '') AS customername 
FROM 
    customer
JOIN 
    customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
JOIN 
    customer_demographics ON customer.c_current_cdemo_sk = customer_demographics.cd_demo_sk
JOIN 
    household_demographics ON customer.c_current_hdemo_sk = household_demographics.hd_demo_sk
JOIN 
    income_band ON household_demographics.hd_income_band_sk = income_band.ib_income_band_sk
JOIN 
    store_returns ON customer_demographics.cd_demo_sk = store_returns.sr_cdemo_sk
WHERE 
    customer_address.ca_city = 'Woodland' 
    AND income_band.ib_lower_bound >= 60306 
    AND income_band.ib_upper_bound <= 60306 + 50000
ORDER BY 
    customer.c_customer_id 
LIMIT 100;