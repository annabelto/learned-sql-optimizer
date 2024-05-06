explain select 
    c.c_customer_id AS customer_id,
    COALESCE(c.c_last_name, '') || ', ' || COALESCE(c.c_first_name, '') AS customername
FROM 
    customer c
INNER JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
INNER JOIN 
    customer_demographics cd ON c.c_current_cdemo_sk = cd.cd_demo_sk
INNER JOIN 
    household_demographics hd ON c.c_current_hdemo_sk = hd.hd_demo_sk
INNER JOIN 
    income_band ib ON hd.hd_income_band_sk = ib.ib_income_band_sk
INNER JOIN 
    store_returns sr ON cd.cd_demo_sk = sr.sr_cdemo_sk
WHERE 
    ca.ca_city = 'Woodland'
    AND ib.ib_lower_bound >= 60306
    AND ib.ib_upper_bound <= 60306 + 50000
ORDER BY 
    c.c_customer_id
LIMIT 100;SELECT 
    c.c_customer_id AS customer_id,
    COALESCE(c.c_last_name, '') || ', ' || COALESCE(c.c_first_name, '') AS customername
FROM 
    customer c
INNER JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
INNER JOIN 
    customer_demographics cd ON c.c_current_cdemo_sk = cd.cd_demo_sk
INNER JOIN 
    household_demographics hd ON c.c_current_hdemo_sk = hd.hd_demo_sk
INNER JOIN 
    income_band ib ON hd.hd_income_band_sk = ib.ib_income_band_sk
INNER JOIN 
    store_returns sr ON cd.cd_demo_sk = sr.sr_cdemo_sk
WHERE 
    ca.ca_city = 'Woodland'
    AND ib.ib_lower_bound >= 60306
    AND ib.ib_upper_bound <= 60306 + 50000
ORDER BY 
    c.c_customer_id
LIMIT 100;