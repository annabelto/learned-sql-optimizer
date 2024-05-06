explain select 
    i_item_id, 
    ca_country, 
    ca_state, 
    ca_county, 
    AVG(cs_quantity) AS agg1, 
    AVG(cs_list_price) AS agg2, 
    AVG(cs_coupon_amt) AS agg3, 
    AVG(cs_sales_price) AS agg4, 
    AVG(cs_net_profit) AS agg5, 
    AVG(c_birth_year) AS agg6, 
    AVG(cd1.cd_dep_count) AS agg7 
FROM 
    catalog_sales
JOIN 
    item ON cs_item_sk = i_item_sk
JOIN 
    date_dim ON cs_sold_date_sk = d_date_sk
JOIN 
    customer_demographics cd1 ON cs_bill_cdemo_sk = cd1.cd_demo_sk
JOIN 
    customer ON cs_bill_customer_sk = c_customer_sk
JOIN 
    customer_address ON c_current_addr_sk = ca_address_sk
WHERE 
    cd1.cd_gender = 'F' 
    AND cd1.cd_education_status = 'Primary'
    AND c_birth_month IN (1,3,7,11,10,4)
    AND d_year = 2001
    AND ca_state IN ('AL','MO','TN','GA','MT','IN','CA')
GROUP BY ROLLUP (i_item_id, ca_country, ca_state, ca_county) 
ORDER BY ca_country, ca_state, ca_county, i_item_id 
LIMIT 100;SELECT 
    i_item_id, 
    ca_country, 
    ca_state, 
    ca_county, 
    AVG(cs_quantity) AS agg1, 
    AVG(cs_list_price) AS agg2, 
    AVG(cs_coupon_amt) AS agg3, 
    AVG(cs_sales_price) AS agg4, 
    AVG(cs_net_profit) AS agg5, 
    AVG(c_birth_year) AS agg6, 
    AVG(cd1.cd_dep_count) AS agg7 
FROM 
    catalog_sales
JOIN 
    item ON cs_item_sk = i_item_sk
JOIN 
    date_dim ON cs_sold_date_sk = d_date_sk
JOIN 
    customer_demographics cd1 ON cs_bill_cdemo_sk = cd1.cd_demo_sk
JOIN 
    customer ON cs_bill_customer_sk = c_customer_sk
JOIN 
    customer_address ON c_current_addr_sk = ca_address_sk
WHERE 
    cd1.cd_gender = 'F' 
    AND cd1.cd_education_status = 'Primary'
    AND c_birth_month IN (1,3,7,11,10,4)
    AND d_year = 2001
    AND ca_state IN ('AL','MO','TN','GA','MT','IN','CA')
GROUP BY ROLLUP (i_item_id, ca_country, ca_state, ca_county) 
ORDER BY ca_country, ca_state, ca_county, i_item_id 
LIMIT 100;