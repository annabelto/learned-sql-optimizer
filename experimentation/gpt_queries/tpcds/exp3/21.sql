SELECT *
FROM (
    SELECT
        w_warehouse_name,
        i_item_id,
        SUM(CASE WHEN d_date < DATE '1999-06-22' THEN inv_quantity_on_hand ELSE 0 END) AS inv_before,
        SUM(CASE WHEN d_date >= DATE '1999-06-22' THEN inv_quantity_on_hand ELSE 0 END) AS inv_after
    FROM
        inventory
    JOIN
        item ON i_item_sk = inv_item_sk
    JOIN
        warehouse ON inv_warehouse_sk = w_warehouse_sk
    JOIN
        date_dim ON inv_date_sk = d_date_sk
    WHERE
        i_current_price BETWEEN 0.99 AND 1.49
        AND d_date BETWEEN DATE '1999-06-22' - 30 AND DATE '1999-06-22' + 30
    GROUP BY
        w_warehouse_name,
        i_item_id
) x
WHERE
    (CASE WHEN inv_before > 0 THEN inv_after / inv_before ELSE NULL END) BETWEEN 2.0/3.0 AND 3.0/2.0
ORDER BY
    w_warehouse_name,
    i_item_id
LIMIT 100;