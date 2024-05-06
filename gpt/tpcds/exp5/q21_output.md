To optimize the given query, I will apply the following rules:

1. **Use explicit join syntax instead of comma-separated tables in the FROM clause.**
2. **Replace implicit joins with explicit joins.**
3. **Use JOIN instead of WHERE for linking tables.**
4. **Use JOIN instead of WHERE for combining tables.**
5. **Use explicit join conditions.**
6. **Move conditions from WHERE clause to ON clause in JOINs.**

### Optimized Query

```sql
SELECT 
    x.w_warehouse_name, 
    x.i_item_id, 
    x.inv_before, 
    x.inv_after
FROM (
    SELECT 
        w.w_warehouse_name, 
        i.i_item_id, 
        SUM(CASE WHEN d.d_date < DATE '1999-06-22' THEN inv.inv_quantity_on_hand ELSE 0 END) AS inv_before, 
        SUM(CASE WHEN d.d_date >= DATE '1999-06-22' THEN inv.inv_quantity_on_hand ELSE 0 END) AS inv_after
    FROM 
        inventory inv
        JOIN item i ON i.i_item_sk = inv.inv_item_sk
        JOIN warehouse w ON inv.inv_warehouse_sk = w.w_warehouse_sk
        JOIN date_dim d ON inv.inv_date_sk = d.d_date_sk
    WHERE 
        i.i_current_price BETWEEN 0.99 AND 1.49
        AND d.d_date BETWEEN (DATE '1999-06-22' - INTERVAL '30 days') AND (DATE '1999-06-22' + INTERVAL '30 days')
    GROUP BY 
        w.w_warehouse_name, 
        i.i_item_id
) x
WHERE 
    (CASE WHEN x.inv_before > 0 THEN x.inv_after / x.inv_before ELSE NULL END) BETWEEN 2.0/3.0 AND 3.0/2.0
ORDER BY 
    x.w_warehouse_name, 
    x.i_item_id
LIMIT 100;
```

### Explanation of Changes:

1. **Explicit Join Syntax:** I replaced the comma-separated table list in the FROM clause with explicit JOIN clauses.
2. **Explicit Join Conditions:** I moved the join conditions from the WHERE clause to the respective ON clauses of the JOINs.
3. **Filter Conditions:** I retained the filter conditions (`i.i_current_price BETWEEN 0.99 AND 1.49` and date range for `d.d_date`) in the WHERE clause of the subquery.
4. **Aggregation and Case Statements:** These remain inside the subquery to correctly compute the sums before and after the specified date.
5. **Outer Query Conditions:** The condition on the computed ratio (`inv_after / inv_before`) remains in the WHERE clause of the outer query to filter the final results.
6. **Order and Limit:** The ORDER BY and LIMIT clauses are applied at the end of the outer query to finalize the sorted output and limit the number of rows returned.

This optimized query should perform better due to the use of explicit JOINs, which are generally more readable and can be more efficiently optimized by the query planner compared to implicit joins in the WHERE clause.