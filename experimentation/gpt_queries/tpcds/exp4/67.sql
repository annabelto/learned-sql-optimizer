SELECT 
    i_category, 
    i_class, 
    i_brand, 
    i_product_name, 
    d_year, 
    d_qoy, 
    d_moy, 
    s_store_id, 
    sumsales, 
    rk
FROM (
    SELECT 
        i_category, 
        i_class, 
        i_brand, 
        i_product_name, 
        d_year, 
        d_qoy, 
        d_moy, 
        s_store_id, 
        sumsales, 
        rank() OVER (PARTITION BY i_category ORDER BY sumsales DESC) AS rk
    FROM (
        SELECT 
            i_category, 
            i_class, 
            i_brand, 
            i_product_name, 
            d_year, 
            d_qoy, 
            d_moy, 
            s_store_id, 
            SUM(ss_sales_price * ss_quantity) AS sumsales
        FROM 
            store_sales
            JOIN date_dim ON ss_sold_date_sk = d_date_sk
            JOIN store ON ss_store_sk = s_store_sk
            JOIN item ON ss_item_sk = i_item_sk
        WHERE 
            d_month_seq BETWEEN 1217 AND 1228
        GROUP BY 
            ROLLUP(i_category, i_class, i_brand, i_product_name, d_year, d_qoy, d_moy, s_store_id)
    ) AS dw1
) AS dw2
WHERE 
    rk <= 100
ORDER BY 
    i_category, 
    i_class, 
    i_brand, 
    i_product_name, 
    d_year, 
    d_qoy, 
    d_moy, 
    s_store_id, 
    sumsales, 
    rk
LIMIT 100;