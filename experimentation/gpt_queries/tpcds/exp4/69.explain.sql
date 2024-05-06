explain select 
    cd.cd_gender, 
    cd.cd_marital_status, 
    cd.cd_education_status, 
    COUNT(*) AS cnt1, 
    cd.cd_purchase_estimate, 
    COUNT(*) AS cnt2, 
    cd.cd_credit_rating, 
    COUNT(*) AS cnt3 
FROM 
    customer c
INNER JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
INNER JOIN 
    customer_demographics cd ON cd.cd_demo_sk = c.c_current_cdemo_sk
WHERE 
    ca.ca_state IN ('IL', 'TX', 'ME')
    AND EXISTS (
        SELECT 1
        FROM 
            store_sales ss
        INNER JOIN 
            date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
        WHERE 
            ss.ss_customer_sk = c.c_customer_sk
            AND d.d_year = 2002
            AND d.d_moy BETWEEN 1 AND 3
    )
    AND NOT EXISTS (
        SELECT 1
        FROM 
            web_sales ws
        INNER JOIN 
            date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
        WHERE 
            ws.ws_bill_customer_sk = c.c_customer_sk
            AND d.d_year = 2002
            AND d.d_moy BETWEEN 1 AND 3
    )
    AND NOT EXISTS (
        SELECT 1
        FROM 
            catalog_sales cs
        INNER JOIN 
            date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
        WHERE 
            cs.cs_ship_customer_sk = c.c_customer_sk
            AND d.d_year = 2002
            AND d.d_moy BETWEEN 1 AND 3
    )
GROUP BY 
    cd.cd_gender, 
    cd.cd_marital_status, 
    cd.cd_education_status, 
    cd.cd_purchase_estimate, 
    cd.cd_credit_rating
ORDER BY 
    cd.cd_gender, 
    cd.cd_marital_status, 
    cd.cd_education_status, 
    cd.cd_purchase_estimate, 
    cd.cd_credit_rating
LIMIT 100;SELECT 
    cd.cd_gender, 
    cd.cd_marital_status, 
    cd.cd_education_status, 
    COUNT(*) AS cnt1, 
    cd.cd_purchase_estimate, 
    COUNT(*) AS cnt2, 
    cd.cd_credit_rating, 
    COUNT(*) AS cnt3 
FROM 
    customer c
INNER JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
INNER JOIN 
    customer_demographics cd ON cd.cd_demo_sk = c.c_current_cdemo_sk
WHERE 
    ca.ca_state IN ('IL', 'TX', 'ME')
    AND EXISTS (
        SELECT 1
        FROM 
            store_sales ss
        INNER JOIN 
            date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
        WHERE 
            ss.ss_customer_sk = c.c_customer_sk
            AND d.d_year = 2002
            AND d.d_moy BETWEEN 1 AND 3
    )
    AND NOT EXISTS (
        SELECT 1
        FROM 
            web_sales ws
        INNER JOIN 
            date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
        WHERE 
            ws.ws_bill_customer_sk = c.c_customer_sk
            AND d.d_year = 2002
            AND d.d_moy BETWEEN 1 AND 3
    )
    AND NOT EXISTS (
        SELECT 1
        FROM 
            catalog_sales cs
        INNER JOIN 
            date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
        WHERE 
            cs.cs_ship_customer_sk = c.c_customer_sk
            AND d.d_year = 2002
            AND d.d_moy BETWEEN 1 AND 3
    )
GROUP BY 
    cd.cd_gender, 
    cd.cd_marital_status, 
    cd.cd_education_status, 
    cd.cd_purchase_estimate, 
    cd.cd_credit_rating
ORDER BY 
    cd.cd_gender, 
    cd.cd_marital_status, 
    cd.cd_education_status, 
    cd.cd_purchase_estimate, 
    cd.cd_credit_rating
LIMIT 100;