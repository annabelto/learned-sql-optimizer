SELECT 
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
    date_dim d
JOIN 
    catalog_sales cs ON cs.cs_sold_date_sk = d.d_date_sk
JOIN 
    item i ON cs.cs_item_sk = i.i_item_sk
JOIN 
    customer c ON cs.cs_bill_customer_sk = c.c_customer_sk
JOIN 
    customer_demographics cd1 ON cs.cs_bill_cdemo_sk = cd1.cd_demo_sk
JOIN 
    customer_demographics cd2 ON c.c_current_cdemo_sk = cd2.cd_demo_sk
JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
WHERE 
    d.d_year = 2001 AND
    cd1.cd_gender = 'F' AND
    cd1.cd_education_status = 'Primary' AND
    c.c_birth_month IN (1,3,7,11,10,4) AND
    ca.ca_state IN ('AL','MO','TN','GA','MT','IN','CA')
GROUP BY 
    ROLLUP (i_item_id, ca_country, ca_state, ca_county)
ORDER BY 
    ca_country, ca_state, ca_county, i_item_id 
LIMIT 100;