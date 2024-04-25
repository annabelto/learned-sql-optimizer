WITH v1 AS (
    SELECT 
        i_category, 
        i_brand, 
        cc_name, 
        d_year, 
        d_moy, 
        SUM(cs_sales_price) AS sum_sales,
        AVG(SUM(cs_sales_price)) OVER (PARTITION BY i_category, i_brand, cc_name, d_year) AS avg_monthly_sales,
        rank() OVER (PARTITION BY i_category, i_brand, cc_name ORDER BY d_year, d_moy) AS rn
    FROM 
        item, 
        catalog_sales, 
        date_dim, 
        call_center
    WHERE 
        cs_item_sk = i_item_sk AND 
        cs_sold_date_sk = d_date_sk AND 
        cc_call_center_sk = cs_call_center_sk AND 
        (d_year = 2001 OR d_year = 2000 AND d_moy = 12 OR d_year = 2002 AND d_moy = 1)
    GROUP BY 
        i_category, 
        i_brand, 
        cc_name, 
        d_year, 
        d_moy
), 
v2 AS (
    SELECT 
        v1.i_category, 
        v1.i_brand, 
        v1.cc_name, 
        v1.d_year, 
        v1.avg_monthly_sales, 
        v1.sum_sales, 
        v1_lag.sum_sales AS psum, 
        v1_lead.sum_sales AS nsum
    FROM 
        v1
    JOIN v1 v1_lag ON v1.i_category = v1_lag.i_category AND v1.i_brand = v1_lag.i_brand AND v1.cc_name = v1_lag.cc_name AND v1.rn = v1_lag.rn + 1
    JOIN v1 v1_lead ON v1.i_category = v1_lead.i_category AND v1.i_brand = v1_lead.i_brand AND v1.cc_name = v1_lead.cc_name AND v1.rn = v1_lead.rn - 1
)
SELECT 
    *
FROM 
    v2
WHERE 
    d_year = 2001 AND 
    avg_monthly_sales > 0 AND 
    ABS(sum_sales - avg_monthly_sales) / avg_monthly_sales > 0.1
ORDER BY 
    sum_sales - avg_monthly_sales, 
    avg_monthly_sales
LIMIT 100;