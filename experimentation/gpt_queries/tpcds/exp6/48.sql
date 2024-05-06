SELECT SUM(ss_quantity)
FROM store_sales
JOIN store ON s_store_sk = ss_store_sk
JOIN date_dim ON ss_sold_date_sk = d_date_sk AND d_year = 2001
JOIN customer_demographics ON cd_demo_sk = ss_cdemo_sk
JOIN customer_address ON ss_addr_sk = ca_address_sk AND ca_country = 'United States'
WHERE 
    (
        (cd_marital_status = 'S' AND cd_education_status = 'Secondary' AND ss_sales_price BETWEEN 100.00 AND 150.00)
        OR (cd_marital_status = 'M' AND cd_education_status = '2 yr Degree' AND ss_sales_price BETWEEN 50.00 AND 100.00)
        OR (cd_marital_status = 'D' AND cd_education_status = 'Advanced Degree' AND ss_sales_price BETWEEN 150.00 AND 200.00)
    )
    AND
    (
        (ca_state IN ('ND', 'NY', 'SD') AND ss_net_profit BETWEEN 0 AND 2000)
        OR (ca_state IN ('MD', 'GA', 'KS') AND ss_net_profit BETWEEN 150 AND 3000)
        OR (ca_state IN ('CO', 'MN', 'NC') AND ss_net_profit BETWEEN 50 AND 25000)
    );