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
    FROM store_sales
    WHERE ss_quantity <= 100
    GROUP BY 1
)
explain select
    MAX(CASE WHEN quantity_range = '1-20' THEN
        CASE WHEN total_count > 1071 THEN avg_ext_tax ELSE avg_net_paid_inc_tax END
    END) AS bucket1,
    MAX(CASE WHEN quantity_range = '21-40' THEN
        CASE WHEN total_count > 39161 THEN avg_ext_tax ELSE avg_net_paid_inc_tax END
    END) AS bucket2,
    MAX(CASE WHEN quantity_range = '41-60' THEN
        CASE WHEN total_count > 29434 THEN avg_ext_tax ELSE avg_net_paid_inc_tax END
    END) AS bucket3,
    MAX(CASE WHEN quantity_range = '61-80' THEN
        CASE WHEN total_count > 6568 THEN avg_ext_tax ELSE avg_net_paid_inc_tax END
    END) AS bucket4,
    MAX(CASE WHEN quantity_range = '81-100' THEN
        CASE WHEN total_count > 21216 THEN avg_ext_tax ELSE avg_net_paid_inc_tax END
    END) AS bucket5
FROM store_sales_summary
JOIN reason ON r_reason_sk = 1
WHERE quantity_range IS NOT NULL;WITH store_sales_summary AS (
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
    FROM store_sales
    WHERE ss_quantity <= 100
    GROUP BY 1
)
SELECT
    MAX(CASE WHEN quantity_range = '1-20' THEN
        CASE WHEN total_count > 1071 THEN avg_ext_tax ELSE avg_net_paid_inc_tax END
    END) AS bucket1,
    MAX(CASE WHEN quantity_range = '21-40' THEN
        CASE WHEN total_count > 39161 THEN avg_ext_tax ELSE avg_net_paid_inc_tax END
    END) AS bucket2,
    MAX(CASE WHEN quantity_range = '41-60' THEN
        CASE WHEN total_count > 29434 THEN avg_ext_tax ELSE avg_net_paid_inc_tax END
    END) AS bucket3,
    MAX(CASE WHEN quantity_range = '61-80' THEN
        CASE WHEN total_count > 6568 THEN avg_ext_tax ELSE avg_net_paid_inc_tax END
    END) AS bucket4,
    MAX(CASE WHEN quantity_range = '81-100' THEN
        CASE WHEN total_count > 21216 THEN avg_ext_tax ELSE avg_net_paid_inc_tax END
    END) AS bucket5
FROM store_sales_summary
JOIN reason ON r_reason_sk = 1
WHERE quantity_range IS NOT NULL;