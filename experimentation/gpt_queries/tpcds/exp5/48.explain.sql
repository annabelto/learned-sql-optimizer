explain select SUM(ss_quantity)
FROM store_sales
JOIN store ON store.s_store_sk = store_sales.ss_store_sk
JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk AND date_dim.d_year = 2001
JOIN customer_demographics ON store_sales.ss_cdemo_sk = customer_demographics.cd_demo_sk
JOIN customer_address ON store_sales.ss_addr_sk = customer_address.ca_address_sk AND customer_address.ca_country = 'United States'
WHERE 
    (
        (customer_demographics.cd_marital_status = 'S' AND customer_demographics.cd_education_status = 'Secondary' AND store_sales.ss_sales_price BETWEEN 100.00 AND 150.00)
        OR (customer_demographics.cd_marital_status = 'M' AND customer_demographics.cd_education_status = '2 yr Degree' AND store_sales.ss_sales_price BETWEEN 50.00 AND 100.00)
        OR (customer_demographics.cd_marital_status = 'D' AND customer_demographics.cd_education_status = 'Advanced Degree' AND store_sales.ss_sales_price BETWEEN 150.00 AND 200.00)
    )
    AND (
        (customer_address.ca_state IN ('ND', 'NY', 'SD') AND store_sales.ss_net_profit BETWEEN 0 AND 2000)
        OR (customer_address.ca_state IN ('MD', 'GA', 'KS') AND store_sales.ss_net_profit BETWEEN 150 AND 3000)
        OR (customer_address.ca_state IN ('CO', 'MN', 'NC') AND store_sales.ss_net_profit BETWEEN 50 AND 25000)
    );SELECT SUM(ss_quantity)
FROM store_sales
JOIN store ON store.s_store_sk = store_sales.ss_store_sk
JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk AND date_dim.d_year = 2001
JOIN customer_demographics ON store_sales.ss_cdemo_sk = customer_demographics.cd_demo_sk
JOIN customer_address ON store_sales.ss_addr_sk = customer_address.ca_address_sk AND customer_address.ca_country = 'United States'
WHERE 
    (
        (customer_demographics.cd_marital_status = 'S' AND customer_demographics.cd_education_status = 'Secondary' AND store_sales.ss_sales_price BETWEEN 100.00 AND 150.00)
        OR (customer_demographics.cd_marital_status = 'M' AND customer_demographics.cd_education_status = '2 yr Degree' AND store_sales.ss_sales_price BETWEEN 50.00 AND 100.00)
        OR (customer_demographics.cd_marital_status = 'D' AND customer_demographics.cd_education_status = 'Advanced Degree' AND store_sales.ss_sales_price BETWEEN 150.00 AND 200.00)
    )
    AND (
        (customer_address.ca_state IN ('ND', 'NY', 'SD') AND store_sales.ss_net_profit BETWEEN 0 AND 2000)
        OR (customer_address.ca_state IN ('MD', 'GA', 'KS') AND store_sales.ss_net_profit BETWEEN 150 AND 3000)
        OR (customer_address.ca_state IN ('CO', 'MN', 'NC') AND store_sales.ss_net_profit BETWEEN 50 AND 25000)
    );