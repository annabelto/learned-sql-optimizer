WITH inv AS (
    SELECT 
        w_warehouse_name,
        w_warehouse_sk,
        i_item_sk,
        d_moy,
        stddev_samp(inv_quantity_on_hand) AS stdev,
        avg(inv_quantity_on_hand) AS mean,
        CASE 
            WHEN avg(inv_quantity_on_hand) = 0 THEN NULL 
            ELSE stddev_samp(inv_quantity_on_hand) / avg(inv_quantity_on_hand) 
        END AS cov
    FROM 
        inventory
        JOIN item ON inv_item_sk = i_item_sk
        JOIN warehouse ON inv_warehouse_sk = w_warehouse_sk
        JOIN date_dim ON inv_date_sk = d_date_sk
    WHERE 
        d_year = 2000
    GROUP BY 
        w_warehouse_name, w_warehouse_sk, i_item_sk, d_moy
    HAVING 
        CASE 
            WHEN avg(inv_quantity_on_hand) = 0 THEN 0 
            ELSE stddev_samp(inv_quantity_on_hand) / avg(inv_quantity_on_hand) 
        END > 1
)
explain select 
    inv1.w_warehouse_sk,
    inv1.i_item_sk,
    inv1.d_moy,
    inv1.mean,
    inv1.cov,
    inv2.w_warehouse_sk,
    inv2.i_item_sk,
    inv2.d_moy,
    inv2.mean,
    inv2.cov
FROM 
    inv inv1
    JOIN inv inv2 ON inv1.i_item_sk = inv2.i_item_sk 
        AND inv1.w_warehouse_sk = inv2.w_warehouse_sk 
        AND inv1.d_moy = 1 
        AND inv2.d_moy = 2
WHERE 
    inv1.cov > 1.5
ORDER BY 
    inv1.w_warehouse_sk, inv1.i_item_sk, inv1.d_moy, inv1.mean, inv1.cov, 
    inv2.d_moy, inv2.mean, inv2.cov;WITH inv AS (
    SELECT 
        w_warehouse_name,
        w_warehouse_sk,
        i_item_sk,
        d_moy,
        stddev_samp(inv_quantity_on_hand) AS stdev,
        avg(inv_quantity_on_hand) AS mean,
        CASE 
            WHEN avg(inv_quantity_on_hand) = 0 THEN NULL 
            ELSE stddev_samp(inv_quantity_on_hand) / avg(inv_quantity_on_hand) 
        END AS cov
    FROM 
        inventory
        JOIN item ON inv_item_sk = i_item_sk
        JOIN warehouse ON inv_warehouse_sk = w_warehouse_sk
        JOIN date_dim ON inv_date_sk = d_date_sk
    WHERE 
        d_year = 2000
    GROUP BY 
        w_warehouse_name, w_warehouse_sk, i_item_sk, d_moy
    HAVING 
        CASE 
            WHEN avg(inv_quantity_on_hand) = 0 THEN 0 
            ELSE stddev_samp(inv_quantity_on_hand) / avg(inv_quantity_on_hand) 
        END > 1
)
SELECT 
    inv1.w_warehouse_sk,
    inv1.i_item_sk,
    inv1.d_moy,
    inv1.mean,
    inv1.cov,
    inv2.w_warehouse_sk,
    inv2.i_item_sk,
    inv2.d_moy,
    inv2.mean,
    inv2.cov
FROM 
    inv inv1
    JOIN inv inv2 ON inv1.i_item_sk = inv2.i_item_sk 
        AND inv1.w_warehouse_sk = inv2.w_warehouse_sk 
        AND inv1.d_moy = 1 
        AND inv2.d_moy = 2
WHERE 
    inv1.cov > 1.5
ORDER BY 
    inv1.w_warehouse_sk, inv1.i_item_sk, inv1.d_moy, inv1.mean, inv1.cov, 
    inv2.d_moy, inv2.mean, inv2.cov;