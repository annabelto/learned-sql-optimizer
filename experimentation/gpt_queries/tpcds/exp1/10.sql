SELECT 
    cd_gender, 
    cd_marital_status, 
    cd_education_status, 
    count(*) AS cnt1, 
    cd_purchase_estimate, 
    count(*) AS cnt2, 
    cd_credit_rating, 
    count(*) AS cnt3, 
    cd_dep_count, 
    count(*) AS cnt4, 
    cd_dep_employed_count, 
    count(*) AS cnt5, 
    cd_dep_college_count, 
    count(*) AS cnt6 
FROM 
    customer c
JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN 
    customer_demographics ON cd_demo_sk = c.c_current_cdemo_sk
WHERE 
    ca_county IN ('Fairfield County', 'Campbell County', 'Washtenaw County', 'Escambia County', 'Cleburne County')
    AND EXISTS (
        SELECT 1
        FROM store_sales, date_dim
        WHERE c.c_customer_sk = ss_customer_sk
        AND ss_sold_date_sk = d_date_sk
        AND d_year = 2001
        AND d_moy BETWEEN 3 AND 6
    )
    AND (
        EXISTS (
            SELECT 1
            FROM web_sales, date_dim
            WHERE c.c_customer_sk = ws_bill_customer_sk
            AND ws_sold_date_sk = d_date_sk
            AND d_year = 2001
            AND d_moy BETWEEN 3 AND 6
        )
        OR EXISTS (
            SELECT 1
            FROM catalog_sales, date_dim
            WHERE c.c_customer_sk = cs_ship_customer_sk
            AND cs_sold_date_sk = d_date_sk
            AND d_year = 2001
            AND d_moy BETWEEN 3 AND 6
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