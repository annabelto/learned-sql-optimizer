SELECT 
    cd_gender, 
    cd_marital_status, 
    cd_education_status, 
    COUNT(*) AS cnt1, 
    cd_purchase_estimate, 
    COUNT(*) AS cnt2, 
    cd_credit_rating, 
    COUNT(*) AS cnt3, 
    cd_dep_count, 
    COUNT(*) AS cnt4, 
    cd_dep_employed_count, 
    COUNT(*) AS cnt5, 
    cd_dep_college_count, 
    COUNT(*) AS cnt6
FROM 
    customer c
JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN 
    customer_demographics cd ON cd.cd_demo_sk = c.c_current_cdemo_sk
WHERE 
    ca.ca_county IN ('Fairfield County', 'Campbell County', 'Washtenaw County', 'Escambia County', 'Cleburne County')
    AND EXISTS (
        SELECT 1
        FROM store_sales
        JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
        WHERE store_sales.ss_customer_sk = c.c_customer_sk
            AND date_dim.d_year = 2001
            AND date_dim.d_moy BETWEEN 3 AND 6
    )
    AND (
        EXISTS (
            SELECT 1
            FROM web_sales
            JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
            WHERE web_sales.ws_bill_customer_sk = c.c_customer_sk
                AND date_dim.d_year = 2001
                AND date_dim.d_moy BETWEEN 3 AND 6
        )
        OR EXISTS (
            SELECT 1
            FROM catalog_sales
            JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
            WHERE catalog_sales.cs_ship_customer_sk = c.c_customer_sk
                AND date_dim.d_year = 2001
                AND date_dim.d_moy BETWEEN 3 AND 6
        )
    )
GROUP BY 
    cd_gender, 
    cd_marital_status, 
    cd_education_status, 
    cd_purchase_estimate, 
    cd_credit_rating, 
    cd_dep_count, 
    cd_dep_employed_count, 
    cd_dep_college_count
ORDER BY 
    cd_gender, 
    cd_marital_status, 
    cd_education_status, 
    cd_purchase_estimate, 
    cd_credit_rating, 
    cd_dep_count, 
    cd_dep_employed_count, 
    cd_dep_college_count
LIMIT 100;