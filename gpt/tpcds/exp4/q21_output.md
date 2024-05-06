Apologies for the oversight in the previous response. The error occurred because the `HAVING` clause was used incorrectly to reference the aliases `inv_before` and `inv_after` which are not directly accessible outside the subquery where they are defined. To correct this, we need to wrap the main query in a subquery or a CTE (Common Table Expression) where these aliases are defined, and then apply the `HAVING` condition in an outer query where these aliases are visible.

### Optimized Query
```sql
WITH date_bounds AS (
    SELECT 
        cast('1999-06-22' as date) AS exact_date,
        cast('1999-06-22' as date) - 30 AS start_date,
        cast('1999-06-22' as date) + 30 AS end_date
),
filtered_items AS (
    SELECT 
        i_item_id, 
        i_item_sk
    FROM 
        item
    WHERE 
        i_current_price BETWEEN 0.99 AND 1.49
)
SELECT 
    w_warehouse_name,
    i_item_id,
    inv_before,
    inv_after
FROM (
    SELECT 
        w_warehouse_name,
        i_item_id,
        SUM(CASE WHEN d_date < date_bounds.exact_date THEN inv_quantity_on_hand ELSE 0 END) AS inv_before,
        SUM(CASE WHEN d_date >= date_bounds.exact_date THEN inv_quantity_on_hand ELSE 0 END) AS inv_after
    FROM 
        inventory
    JOIN 
        warehouse ON inv_warehouse_sk = w_warehouse_sk
    JOIN 
        filtered_items ON i_item_sk = inv_item_sk
    JOIN 
        date_dim ON inv_date_sk = d_date_sk
    JOIN 
        date_bounds ON d_date BETWEEN date_bounds.start_date AND date_bounds.end_date
    GROUP BY 
        w_warehouse_name, i_item_id
) AS subquery
WHERE 
    CASE WHEN inv_before > 0 THEN inv_after / inv_before ELSE NULL END BETWEEN 2.0/3.0 AND 3.0/2.0
ORDER BY 
    w_warehouse_name, i_item_id
LIMIT 100;
```

### Explanation
- **CTEs**: `date_bounds` and `filtered_items` are used to pre-compute and filter data, reducing redundancy and focusing processing on relevant rows.
- **Subquery**: The main aggregation is performed in a subquery where `inv_before` and `inv_after` are calculated. This allows these aliases to be used in the outer query's `WHERE` clause.
- **WHERE Clause in Outer Query**: The condition on the ratio of `inv_after` to `inv_before` is applied in the outer query where these aliases are accessible.

This approach ensures that the query is syntactically correct and should perform efficiently by reducing the amount of data processed and clearly defining the logical processing steps.