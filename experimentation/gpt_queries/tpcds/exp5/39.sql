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
        JOIN item ON inventory.inv_item_sk = item.i_item_sk
        JOIN warehouse ON inventory.inv_warehouse_sk = warehouse.w_warehouse_sk
        JOIN date_dim ON inventory.inv_date_sk = date_dim.d_date_sk
    WHERE 
        date_dim.d_year = 2000
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
    inv1.w_warehouse_sk,
    inv1.i_item_sk,
    inv1.d_moy,
    inv1.mean,
    inv1.cov,
    inv2.d_moy,
    inv2.mean,
    inv2.cov;