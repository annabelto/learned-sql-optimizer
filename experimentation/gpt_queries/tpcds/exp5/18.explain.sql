explain select 
    i_item_id, 
    ca_country, 
    ca_state, 
    ca_county, 
    AVG(CAST(cs_quantity AS DECIMAL(12,2))) AS agg1, 
    AVG(CAST(cs_list_price AS DECIMAL(12,2))) AS agg2, 
    AVG(CAST(cs_coupon_amt AS DECIMAL(12,2))) AS agg3, 
    AVG(CAST(cs_sales_price AS DECIMAL(12,2))) AS agg4, 
    AVG(CAST(cs_net_profit AS DECIMAL(12,2))) AS agg5, 
    AVG(CAST(c_birth_year AS DECIMAL(12,2))) AS agg6, 
    AVG(CAST(cd1.cd_dep_count AS DECIMAL(12,2))) AS agg7
FROM 
    catalog_sales
JOIN 
    item ON cs_item_sk = i_item_sk
JOIN 
    date_dim ON cs_sold_date_sk = d_date_sk AND d_year = 2001
JOIN 
    customer_demographics cd1 ON cs_bill_cdemo_sk = cd1.cd_demo_sk AND cd1.cd_gender = 'F' AND cd1.cd_education_status = 'Primary'
JOIN 
    customer ON cs_bill_customer_sk = c_customer_sk AND c_birth_month IN (1,3,7,11,10,4)
JOIN 
    customer_demographics cd2 ON c_current_cdemo_sk = cd2.cd_demo_sk
JOIN 
    customer_address ON c_current_addr_sk = ca_address_sk AND ca_state IN ('AL','MO','TN','GA','MT','IN','CA')
GROUP BY 
    ROLLUP (i_item_id, ca_country, ca_state, ca_county)
ORDER BY 
    ca_country, ca_state, ca_county, i_item_id
LIMIT 100;SELECT 
    i_item_id, 
    ca_country, 
    ca_state, 
    ca_county, 
    AVG(CAST(cs_quantity AS DECIMAL(12,2))) AS agg1, 
    AVG(CAST(cs_list_price AS DECIMAL(12,2))) AS agg2, 
    AVG(CAST(cs_coupon_amt AS DECIMAL(12,2))) AS agg3, 
    AVG(CAST(cs_sales_price AS DECIMAL(12,2))) AS agg4, 
    AVG(CAST(cs_net_profit AS DECIMAL(12,2))) AS agg5, 
    AVG(CAST(c_birth_year AS DECIMAL(12,2))) AS agg6, 
    AVG(CAST(cd1.cd_dep_count AS DECIMAL(12,2))) AS agg7
FROM 
    catalog_sales
JOIN 
    item ON cs_item_sk = i_item_sk
JOIN 
    date_dim ON cs_sold_date_sk = d_date_sk AND d_year = 2001
JOIN 
    customer_demographics cd1 ON cs_bill_cdemo_sk = cd1.cd_demo_sk AND cd1.cd_gender = 'F' AND cd1.cd_education_status = 'Primary'
JOIN 
    customer ON cs_bill_customer_sk = c_customer_sk AND c_birth_month IN (1,3,7,11,10,4)
JOIN 
    customer_demographics cd2 ON c_current_cdemo_sk = cd2.cd_demo_sk
JOIN 
    customer_address ON c_current_addr_sk = ca_address_sk AND ca_state IN ('AL','MO','TN','GA','MT','IN','CA')
GROUP BY 
    ROLLUP (i_item_id, ca_country, ca_state, ca_county)
ORDER BY 
    ca_country, ca_state, ca_county, i_item_id
LIMIT 100;