WITH v1 AS (
    SELECT 
        i_category, 
        i_brand, 
        s_store_name, 
        s_company_name, 
        d_year, 
        d_moy, 
        SUM(ss_sales_price) AS sum_sales,
        AVG(SUM(ss_sales_price)) OVER (PARTITION BY i_category, i_brand, s_store_name, s_company_name, d_year) AS avg_monthly_sales,
        RANK() OVER (PARTITION BY i_category, i_brand, s_store_name, s_company_name ORDER BY d_year, d_moy) AS rn
    FROM 
        item
        JOIN store_sales ON ss_item_sk = i_item_sk
        JOIN date_dim ON ss_sold_date_sk = d_date_sk
        JOIN store ON ss_store_sk = s_store_sk
    WHERE 
        d_year = 2000 OR 
        (d_year = 1999 AND d_moy = 12) OR 
        (d_year = 2001 AND d_moy = 1)
    GROUP BY 
        i_category, 
        i_brand, 
        s_store_name, 
        s_company_name, 
        d_year, 
        d_moy
), 
v2 AS (
    SELECT 
        v1.s_store_name, 
        v1.s_company_name,
        v1.d_year,
        v1.avg_monthly_sales,
        v1.sum_sales,
        v1_lag.sum_sales AS psum,
        v1_lead.sum_sales AS nsum
    FROM 
        v1
        JOIN v1 AS v1_lag ON v1.i_category = v1_lag.i_category 
            AND v1.i_brand = v1_lag.i_brand 
            AND v1.s_store_name = v1_lag.s_store_name 
            AND v1.s_company_name = v1_lag.s_company_name 
            AND v1.rn = v1_lag.rn + 1
        JOIN v1 AS v1_lead ON v1.i_category = v1_lead.i_category 
            AND v1.i_brand = v1_lead.i_brand 
            AND v1.s_store_name = v1_lead.s_store_name 
            AND v1.s_company_name = v1_lead.s_company_name 
            AND v1.rn = v1_lead.rn - 1
)
SELECT 
    *
FROM 
    v2
WHERE 
    d_year = 2000 AND 
    avg_monthly_sales > 0 AND 
    CASE 
        WHEN avg_monthly_sales > 0 THEN ABS(sum_sales - avg_monthly_sales) / avg_monthly_sales 
        ELSE NULL 
    END > 0.1
ORDER BY 
    sum_sales - avg_monthly_sales, 
    nsum
LIMIT 100;