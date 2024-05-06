WITH store_sales_summary AS (
    SELECT 
        CASE 
            WHEN ss_quantity BETWEEN 1 AND 20 THEN '1-20'
            WHEN ss_quantity BETWEEN 21 AND 40 THEN '21-40'
            WHEN ss_quantity BETWEEN 41 AND 60 THEN '41-60'
            WHEN ss_quantity BETWEEN 61 AND 80 THEN '61-80'
            WHEN ss_quantity BETWEEN 81 AND 100 THEN '81-100'
        END AS quantity_range,
        COUNT(*) AS total_count,
        AVG(ss_ext_tax) AS avg_ext_tax,
        AVG(ss_net_paid_inc_tax) AS avg_net_paid_inc_tax
    FROM 
        store_sales
    WHERE 
        ss_quantity BETWEEN 1 AND 100
    GROUP BY 
        CASE 
            WHEN ss_quantity BETWEEN 1 AND 20 THEN '1-20'
            WHEN ss_quantity BETWEEN 21 AND 40 THEN '21-40'
            WHEN ss_quantity BETWEEN 41 AND 60 THEN '41-60'
            WHEN ss_quantity BETWEEN 61 AND 80 THEN '61-80'
            WHEN ss_quantity BETWEEN 81 AND 100 THEN '81-100'
        END
)
SELECT 
    CASE 
        WHEN (SELECT total_count FROM store_sales_summary WHERE quantity_range = '1-20') > 1071 
        THEN (SELECT avg_ext_tax FROM store_sales_summary WHERE quantity_range = '1-20')
        ELSE (SELECT avg_net_paid_inc_tax FROM store_sales_summary WHERE quantity_range = '1-20')
    END AS bucket1,
    CASE 
        WHEN (SELECT total_count FROM store_sales_summary WHERE quantity_range = '21-40') > 39161 
        THEN (SELECT avg_ext_tax FROM store_sales_summary WHERE quantity_range = '21-40')
        ELSE (SELECT avg_net_paid_inc_tax FROM store_sales_summary WHERE quantity_range = '21-40')
    END AS bucket2,
    CASE 
        WHEN (SELECT total_count FROM store_sales_summary WHERE quantity_range = '41-60') > 29434 
        THEN (SELECT avg_ext_tax FROM store_sales_summary WHERE quantity_range = '41-60')
        ELSE (SELECT avg_net_paid_inc_tax FROM store_sales_summary WHERE quantity_range = '41-60')
    END AS bucket3,
    CASE 
        WHEN (SELECT total_count FROM store_sales_summary WHERE quantity_range = '61-80') > 6568 
        THEN (SELECT avg_ext_tax FROM store_sales_summary WHERE quantity_range = '61-80')
        ELSE (SELECT avg_net_paid_inc_tax FROM store_sales_summary WHERE quantity_range = '61-80')
    END AS bucket4,
    CASE 
        WHEN (SELECT total_count FROM store_sales_summary WHERE quantity_range = '81-100') > 21216 
        THEN (SELECT avg_ext_tax FROM store_sales_summary WHERE quantity_range = '81-100')
        ELSE (SELECT avg_net_paid_inc_tax FROM store_sales_summary WHERE quantity_range = '81-100')
    END AS bucket5
FROM 
    reason
WHERE 
    r_reason_sk = 1;