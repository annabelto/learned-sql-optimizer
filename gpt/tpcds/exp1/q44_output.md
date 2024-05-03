To optimize the given query, we can apply several data-independent rewrite rules that focus on improving the query's performance by reducing the complexity and redundancy of operations. Here are the steps and rules applied:

1. **Common Sub-expression Elimination**: The subquery calculating the average net profit for `store_sales` where `ss_store_sk = 4` and `ss_hdemo_sk is null` is repeated in both the ascending and descending subqueries. We can calculate this once and reuse it.

2. **Predicate Pushdown**: This involves moving the predicates as close as possible to the data source. In this case, we can apply the filter `ss_store_sk = 4` directly in the subquery to reduce the amount of data processed in later stages.

3. **Eliminate Redundant Ordering**: Since both subqueries use `rank()` which inherently orders the data, the final `order by asceding.rnk` is redundant if the limit does not exceed the rank filter (`rnk < 11`).

4. **Limit Pushdown**: Applying the limit as early as possible can significantly reduce the amount of data that needs to be processed in later stages of the query.

### Optimized Query

```sql
WITH avg_net_profit AS (
    SELECT AVG(ss_net_profit) AS rank_col
    FROM store_sales
    WHERE ss_store_sk = 4 AND ss_hdemo_sk IS NULL
    GROUP BY ss_store_sk
),
ranked_items AS (
    SELECT 
        ss_item_sk AS item_sk, 
        AVG(ss_net_profit) AS rank_col,
        RANK() OVER (ORDER BY AVG(ss_net_profit) ASC) AS rnk_asc,
        RANK() OVER (ORDER BY AVG(ss_net_profit) DESC) AS rnk_desc
    FROM store_sales
    WHERE ss_store_sk = 4
    GROUP BY ss_item_sk
    HAVING AVG(ss_net_profit) > 0.9 * (SELECT rank_col FROM avg_net_profit)
)
SELECT 
    a.rnk_asc AS rnk, 
    i1.i_product_name AS best_performing, 
    i2.i_product_name AS worst_performing
FROM 
    ranked_items a
JOIN 
    ranked_items d ON a.rnk_asc = d.rnk_desc
JOIN 
    item i1 ON i1.i_item_sk = a.item_sk
JOIN 
    item i2 ON i2.i_item_sk = d.item_sk
WHERE 
    a.rnk_asc < 11
ORDER BY 
    a.rnk_asc
LIMIT 100;
```

### Explanation of Changes:
- **Common Sub-expression Elimination**: The average net profit calculation is moved to a CTE (`avg_net_profit`), which is referenced in the main query.
- **Predicate Pushdown**: The condition `ss_store_sk = 4` is used directly in the subquery where the data is first accessed.
- **Eliminate Redundant Ordering**: The final `ORDER BY` is maintained because it explicitly orders the final result, ensuring the correct order is presented, especially if the database chooses to optimize the internal ordering differently.
- **Limit Pushdown**: The limit is applied at the end of the query, which is appropriate after all joins and conditions are applied.

This optimized query should perform better due to reduced redundancy and more efficient data handling.