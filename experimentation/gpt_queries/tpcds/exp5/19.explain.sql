explain select 
    i_brand_id AS brand_id, 
    i_brand AS brand, 
    i_manufact_id, 
    i_manufact, 
    SUM(ss_ext_sales_price) AS ext_price 
FROM 
    date_dim
JOIN 
    store_sales ON d_date_sk = ss_sold_date_sk
JOIN 
    item ON ss_item_sk = i_item_sk
JOIN 
    customer ON ss_customer_sk = c_customer_sk
JOIN 
    customer_address ON c_current_addr_sk = ca_address_sk
JOIN 
    store ON ss_store_sk = s_store_sk AND substr(ca_zip, 1, 5) <> substr(s_zip, 1, 5)
WHERE 
    i_manager_id = 14 
    AND d_moy = 11 
    AND d_year = 2002
GROUP BY 
    i_brand, 
    i_brand_id, 
    i_manufact_id, 
    i_manufact
ORDER BY 
    ext_price DESC, 
    i_brand, 
    i_brand_id, 
    i_manufact_id, 
    i_manufact
LIMIT 100;SELECT 
    i_brand_id AS brand_id, 
    i_brand AS brand, 
    i_manufact_id, 
    i_manufact, 
    SUM(ss_ext_sales_price) AS ext_price 
FROM 
    date_dim
JOIN 
    store_sales ON d_date_sk = ss_sold_date_sk
JOIN 
    item ON ss_item_sk = i_item_sk
JOIN 
    customer ON ss_customer_sk = c_customer_sk
JOIN 
    customer_address ON c_current_addr_sk = ca_address_sk
JOIN 
    store ON ss_store_sk = s_store_sk AND substr(ca_zip, 1, 5) <> substr(s_zip, 1, 5)
WHERE 
    i_manager_id = 14 
    AND d_moy = 11 
    AND d_year = 2002
GROUP BY 
    i_brand, 
    i_brand_id, 
    i_manufact_id, 
    i_manufact
ORDER BY 
    ext_price DESC, 
    i_brand, 
    i_brand_id, 
    i_manufact_id, 
    i_manufact
LIMIT 100;