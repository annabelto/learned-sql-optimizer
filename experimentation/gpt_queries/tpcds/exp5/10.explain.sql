explain select 
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
    customer_demographics cd ON cd.cd_demo_sk = c.c_current_cdemo_sk
WHERE 
    ca.ca_county IN ('Fairfield County', 'Campbell County', 'Washtenaw County', 'Escambia County', 'Cleburne County')
    AND EXISTS (
        SELECT * 
        FROM 
            store_sales ss
        JOIN 
            date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
        WHERE 
            c.c_customer_sk = ss.ss_customer_sk 
            AND d.d_year = 2001 
            AND d.d_moy BETWEEN 3 AND 6
    )
    AND (
        EXISTS (
            SELECT * 
            FROM 
                web_sales ws
            JOIN 
                date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
            WHERE 
                c.c_customer_sk = ws.ws_bill_customer_sk 
                AND d.d_year = 2001 
                AND d.d_moy BETWEEN 3 AND 6
        ) 
        OR EXISTS (
            SELECT * 
            FROM 
                catalog_sales cs
            JOIN 
                date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
            WHERE 
                c.c_customer_sk = cs.cs_ship_customer_sk 
                AND d.d_year = 2001 
                AND d.d_moy BETWEEN 3 AND 6
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
LIMIT 100;SELECT 
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
    customer_demographics cd ON cd.cd_demo_sk = c.c_current_cdemo_sk
WHERE 
    ca.ca_county IN ('Fairfield County', 'Campbell County', 'Washtenaw County', 'Escambia County', 'Cleburne County')
    AND EXISTS (
        SELECT * 
        FROM 
            store_sales ss
        JOIN 
            date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
        WHERE 
            c.c_customer_sk = ss.ss_customer_sk 
            AND d.d_year = 2001 
            AND d.d_moy BETWEEN 3 AND 6
    )
    AND (
        EXISTS (
            SELECT * 
            FROM 
                web_sales ws
            JOIN 
                date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
            WHERE 
                c.c_customer_sk = ws.ws_bill_customer_sk 
                AND d.d_year = 2001 
                AND d.d_moy BETWEEN 3 AND 6
        ) 
        OR EXISTS (
            SELECT * 
            FROM 
                catalog_sales cs
            JOIN 
                date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
            WHERE 
                c.c_customer_sk = cs.cs_ship_customer_sk 
                AND d.d_year = 2001 
                AND d.d_moy BETWEEN 3 AND 6
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