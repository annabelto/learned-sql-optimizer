explain select 
    ca_state, 
    cd_gender, 
    cd_marital_status, 
    cd_dep_count, 
    COUNT(*) AS cnt1, 
    AVG(cd_dep_count), 
    STDDEV_SAMP(cd_dep_count), 
    SUM(cd_dep_count), 
    cd_dep_employed_count, 
    COUNT(*) AS cnt2, 
    AVG(cd_dep_employed_count), 
    STDDEV_SAMP(cd_dep_employed_count), 
    SUM(cd_dep_employed_count), 
    cd_dep_college_count, 
    COUNT(*) AS cnt3, 
    AVG(cd_dep_college_count), 
    STDDEV_SAMP(cd_dep_college_count), 
    SUM(cd_dep_college_count) 
FROM 
    customer c
JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN 
    customer_demographics cd ON cd.cd_demo_sk = c.c_current_cdemo_sk
WHERE 
    EXISTS (
        SELECT * 
        FROM 
            store_sales ss
        JOIN 
            date_dim d ON ss.ss_sold_date_sk = d_date_sk
        WHERE 
            c.c_customer_sk = ss.ss_customer_sk 
            AND d_year = 1999 
            AND d_qoy < 4
    )
    AND (
        EXISTS (
            SELECT * 
            FROM 
                web_sales ws
            JOIN 
                date_dim d ON ws.ws_sold_date_sk = d_date_sk
            WHERE 
                c.c_customer_sk = ws.ws_bill_customer_sk 
                AND d_year = 1999 
                AND d_qoy < 4
        )
        OR EXISTS (
            SELECT * 
            FROM 
                catalog_sales cs
            JOIN 
                date_dim d ON cs.cs_sold_date_sk = d_date_sk
            WHERE 
                c.c_customer_sk = cs.cs_ship_customer_sk 
                AND d_year = 1999 
                AND d_qoy < 4
        )
    )
GROUP BY 
    ca_state, 
    cd_gender, 
    cd_marital_status, 
    cd_dep_count, 
    cd_dep_employed_count, 
    cd_dep_college_count 
ORDER BY 
    ca_state, 
    cd_gender, 
    cd_marital_status, 
    cd_dep_count, 
    cd_dep_employed_count, 
    cd_dep_college_count 
LIMIT 100;SELECT 
    ca_state, 
    cd_gender, 
    cd_marital_status, 
    cd_dep_count, 
    COUNT(*) AS cnt1, 
    AVG(cd_dep_count), 
    STDDEV_SAMP(cd_dep_count), 
    SUM(cd_dep_count), 
    cd_dep_employed_count, 
    COUNT(*) AS cnt2, 
    AVG(cd_dep_employed_count), 
    STDDEV_SAMP(cd_dep_employed_count), 
    SUM(cd_dep_employed_count), 
    cd_dep_college_count, 
    COUNT(*) AS cnt3, 
    AVG(cd_dep_college_count), 
    STDDEV_SAMP(cd_dep_college_count), 
    SUM(cd_dep_college_count) 
FROM 
    customer c
JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN 
    customer_demographics cd ON cd.cd_demo_sk = c.c_current_cdemo_sk
WHERE 
    EXISTS (
        SELECT * 
        FROM 
            store_sales ss
        JOIN 
            date_dim d ON ss.ss_sold_date_sk = d_date_sk
        WHERE 
            c.c_customer_sk = ss.ss_customer_sk 
            AND d_year = 1999 
            AND d_qoy < 4
    )
    AND (
        EXISTS (
            SELECT * 
            FROM 
                web_sales ws
            JOIN 
                date_dim d ON ws.ws_sold_date_sk = d_date_sk
            WHERE 
                c.c_customer_sk = ws.ws_bill_customer_sk 
                AND d_year = 1999 
                AND d_qoy < 4
        )
        OR EXISTS (
            SELECT * 
            FROM 
                catalog_sales cs
            JOIN 
                date_dim d ON cs.cs_sold_date_sk = d_date_sk
            WHERE 
                c.c_customer_sk = cs.cs_ship_customer_sk 
                AND d_year = 1999 
                AND d_qoy < 4
        )
    )
GROUP BY 
    ca_state, 
    cd_gender, 
    cd_marital_status, 
    cd_dep_count, 
    cd_dep_employed_count, 
    cd_dep_college_count 
ORDER BY 
    ca_state, 
    cd_gender, 
    cd_marital_status, 
    cd_dep_count, 
    cd_dep_employed_count, 
    cd_dep_college_count 
LIMIT 100;