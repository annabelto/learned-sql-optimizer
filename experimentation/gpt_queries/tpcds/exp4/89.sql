SELECT 
    i_category, i_class, i_brand, s_store_name, s_company_name, d_moy, 
    sum_sales, avg_monthly_sales
FROM (
    SELECT 
        i_category, i_class, i_brand, s_store_name, s_company_name, d_moy, 
        SUM(ss_sales_price) AS sum_sales, 
        AVG(SUM(ss_sales_price)) OVER (PARTITION BY i_category, i_brand, s_store_name, s_company_name) AS avg_monthly_sales 
    FROM 
        item
        JOIN store_sales ON ss_item_sk = i_item_sk
        JOIN date_dim ON ss_sold_date_sk = d_date_sk
        JOIN store ON ss_store_sk = s_store_sk
    WHERE 
        d_year = 2001 AND 
        (
            (i_category IN ('Books', 'Children', 'Electronics') AND i_class IN ('history', 'school-uniforms', 'audio')) OR 
            (i_category IN ('Men', 'Sports', 'Shoes') AND i_class IN ('pants', 'tennis', 'womens'))
        )
    GROUP BY 
        i_category, i_class, i_brand, s_store_name, s_company_name, d_moy
) AS subquery
WHERE 
    avg_monthly_sales <> 0 AND (ABS(sum_sales - avg_monthly_sales) / avg_monthly_sales) > 0.1
ORDER BY 
    sum_sales - avg_monthly_sales, s_store_name 
LIMIT 100;