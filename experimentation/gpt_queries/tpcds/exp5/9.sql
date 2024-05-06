SELECT 
    CASE 
        WHEN (SELECT count(*) FROM store_sales WHERE ss_quantity BETWEEN 1 AND 20) > 1071 
        THEN (SELECT avg(ss_ext_tax) FROM store_sales WHERE ss_quantity BETWEEN 1 AND 20) 
        ELSE (SELECT avg(ss_net_paid_inc_tax) FROM store_sales WHERE ss_quantity BETWEEN 1 AND 20) 
    END AS bucket1,
    CASE 
        WHEN (SELECT count(*) FROM store_sales WHERE ss_quantity BETWEEN 21 AND 40) > 39161 
        THEN (SELECT avg(ss_ext_tax) FROM store_sales WHERE ss_quantity BETWEEN 21 AND 40) 
        ELSE (SELECT avg(ss_net_paid_inc_tax) FROM store_sales WHERE ss_quantity BETWEEN 21 AND 40) 
    END AS bucket2,
    CASE 
        WHEN (SELECT count(*) FROM store_sales WHERE ss_quantity BETWEEN 41 AND 60) > 29434 
        THEN (SELECT avg(ss_ext_tax) FROM store_sales WHERE ss_quantity BETWEEN 41 AND 60) 
        ELSE (SELECT avg(ss_net_paid_inc_tax) FROM store_sales WHERE ss_quantity BETWEEN 41 AND 60) 
    END AS bucket3,
    CASE 
        WHEN (SELECT count(*) FROM store_sales WHERE ss_quantity BETWEEN 61 AND 80) > 6568 
        THEN (SELECT avg(ss_ext_tax) FROM store_sales WHERE ss_quantity BETWEEN 61 AND 80) 
        ELSE (SELECT avg(ss_net_paid_inc_tax) FROM store_sales WHERE ss_quantity BETWEEN 61 AND 80) 
    END AS bucket4,
    CASE 
        WHEN (SELECT count(*) FROM store_sales WHERE ss_quantity BETWEEN 81 AND 100) > 21216 
        THEN (SELECT avg(ss_ext_tax) FROM store_sales WHERE ss_quantity BETWEEN 81 AND 100) 
        ELSE (SELECT avg(ss_net_paid_inc_tax) FROM store_sales WHERE ss_quantity BETWEEN 81 AND 100) 
    END AS bucket5
FROM reason
WHERE r_reason_sk = 1;