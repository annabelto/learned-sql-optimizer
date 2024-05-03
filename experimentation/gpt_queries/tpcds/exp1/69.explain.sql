explain select 
    cd_gender, 
    cd_marital_status, 
    cd_education_status, 
    COUNT(*) AS cnt1, 
    cd_purchase_estimate, 
    cd_credit_rating
FROM 
    customer c
JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN 
    customer_demographics cd ON cd.cd_demo_sk = c.c_current_cdemo_sk
WHERE 
    ca.ca_state IN ('IL', 'TX', 'ME')
    AND EXISTS (
        SELECT 1
        FROM 
            store_sales ss
        JOIN 
            date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
        WHERE 
            c.c_customer_sk = ss.ss_customer_sk
            AND d.d_year = 2002
            AND d.d_moy BETWEEN 1 AND 3
    )
    AND NOT EXISTS (
        SELECT 1
        FROM 
            web_sales ws
        JOIN 
            date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
        WHERE 
            c.c_customer_sk = ws.ws_bill_customer_sk
            AND d.d_year = 2002
            AND d.d_moy BETWEEN 1 AND 3
    )
    AND NOT EXISTS (
        SELECT 1
        FROM 
            catalog_sales cs
        JOIN 
            date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
        WHERE 
            c.c_customer_sk = cs.cs_ship_customer_sk
            AND d.d_year = 2002
            AND d.d_moy BETWEEN 1 AND 3
    )
GROUP BY 
    cd_gender, 
    cd_marital_status, 
    cd_education_status, 
    cd_purchase_estimate, 
    cd_credit_rating
ORDER BY 
    cd_gender, 
    cd_marital_status, 
    cd_education_status, 
    cd_purchase_estimate, 
    cd_credit_rating
LIMIT 100;SELECT 
    cd_gender, 
    cd_marital_status, 
    cd_education_status, 
    COUNT(*) AS cnt1, 
    cd_purchase_estimate, 
    cd_credit_rating
FROM 
    customer c
JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN 
    customer_demographics cd ON cd.cd_demo_sk = c.c_current_cdemo_sk
WHERE 
    ca.ca_state IN ('IL', 'TX', 'ME')
    AND EXISTS (
        SELECT 1
        FROM 
            store_sales ss
        JOIN 
            date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
        WHERE 
            c.c_customer_sk = ss.ss_customer_sk
            AND d.d_year = 2002
            AND d.d_moy BETWEEN 1 AND 3
    )
    AND NOT EXISTS (
        SELECT 1
        FROM 
            web_sales ws
        JOIN 
            date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
        WHERE 
            c.c_customer_sk = ws.ws_bill_customer_sk
            AND d.d_year = 2002
            AND d.d_moy BETWEEN 1 AND 3
    )
    AND NOT EXISTS (
        SELECT 1
        FROM 
            catalog_sales cs
        JOIN 
            date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
        WHERE 
            c.c_customer_sk = cs.cs_ship_customer_sk
            AND d.d_year = 2002
            AND d.d_moy BETWEEN 1 AND 3
    )
GROUP BY 
    cd_gender, 
    cd_marital_status, 
    cd_education_status, 
    cd_purchase_estimate, 
    cd_credit_rating
ORDER BY 
    cd_gender, 
    cd_marital_status, 
    cd_education_status, 
    cd_purchase_estimate, 
    cd_credit_rating
LIMIT 100;