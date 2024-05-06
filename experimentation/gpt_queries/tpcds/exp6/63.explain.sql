explain select *
FROM (
    SELECT 
        i_manager_id,
        SUM(ss_sales_price) AS sum_sales,
        AVG(SUM(ss_sales_price)) OVER (PARTITION BY i_manager_id) AS avg_monthly_sales
    FROM 
        item
        JOIN store_sales ON item.i_item_sk = store_sales.ss_item_sk
        JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
        JOIN store ON store_sales.ss_store_sk = store.s_store_sk
    WHERE 
        date_dim.d_month_seq BETWEEN 1222 AND 1233
        AND (
            (
                item.i_category IN ('Books', 'Children', 'Electronics')
                AND item.i_class IN ('personal', 'portable', 'reference', 'self-help')
                AND item.i_brand IN ('scholaramalgamalg #14', 'scholaramalgamalg #7', 'exportiunivamalg #9', 'scholaramalgamalg #9')
            ) OR (
                item.i_category IN ('Women', 'Music', 'Men')
                AND item.i_class IN ('accessories', 'classical', 'fragrances', 'pants')
                AND item.i_brand IN ('amalgimporto #1', 'edu packscholar #1', 'exportiimporto #1', 'importoamalg #1')
            )
        )
    GROUP BY 
        i_manager_id, date_dim.d_moy
) AS tmp1
WHERE 
    CASE 
        WHEN avg_monthly_sales > 0 THEN ABS(sum_sales - avg_monthly_sales) / avg_monthly_sales 
        ELSE NULL 
    END > 0.1
ORDER BY 
    i_manager_id, avg_monthly_sales, sum_sales
LIMIT 100;SELECT *
FROM (
    SELECT 
        i_manager_id,
        SUM(ss_sales_price) AS sum_sales,
        AVG(SUM(ss_sales_price)) OVER (PARTITION BY i_manager_id) AS avg_monthly_sales
    FROM 
        item
        JOIN store_sales ON item.i_item_sk = store_sales.ss_item_sk
        JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
        JOIN store ON store_sales.ss_store_sk = store.s_store_sk
    WHERE 
        date_dim.d_month_seq BETWEEN 1222 AND 1233
        AND (
            (
                item.i_category IN ('Books', 'Children', 'Electronics')
                AND item.i_class IN ('personal', 'portable', 'reference', 'self-help')
                AND item.i_brand IN ('scholaramalgamalg #14', 'scholaramalgamalg #7', 'exportiunivamalg #9', 'scholaramalgamalg #9')
            ) OR (
                item.i_category IN ('Women', 'Music', 'Men')
                AND item.i_class IN ('accessories', 'classical', 'fragrances', 'pants')
                AND item.i_brand IN ('amalgimporto #1', 'edu packscholar #1', 'exportiimporto #1', 'importoamalg #1')
            )
        )
    GROUP BY 
        i_manager_id, date_dim.d_moy
) AS tmp1
WHERE 
    CASE 
        WHEN avg_monthly_sales > 0 THEN ABS(sum_sales - avg_monthly_sales) / avg_monthly_sales 
        ELSE NULL 
    END > 0.1
ORDER BY 
    i_manager_id, avg_monthly_sales, sum_sales
LIMIT 100;