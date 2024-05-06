To optimize the given TPC-DS query, we can apply several data-independent rewrite rules. These rules aim to simplify the query, reduce redundancy, and improve execution efficiency without altering the data context or the final result set. Here are the steps and rules applied:

1. **Common Sub-expression Elimination (CSE)**: The subquery calculating the average `ss_net_profit` for `ss_store_sk = 4` and `ss_hdemo_sk is null` is repeated in both the ascending and descending subqueries. We can calculate this once and reuse it.

2. **Predicate Pushdown**: This involves moving the filter conditions as close as possible to the data retrieval operation. This can reduce the amount of data processed in the later stages of the query.

3. **Eliminate Redundant Subquery Layers**: The query has unnecessary nested subqueries that can be flattened without changing the semantics of the query.

4. **Use of Aliases for Clarity**: Improve readability and manageability of the query by using clear aliases.

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
        RANK() OVER (ORDER BY AVG(ss_net_profit) ASC) AS asc_rank,
        RANK() OVER (ORDER BY AVG(ss_net_profit) DESC) AS desc_rank
    FROM store_sales
    WHERE ss_store_sk = 4
    GROUP BY ss_item_sk
    HAVING AVG(ss_net_profit) > 0.9 * (SELECT rank_col FROM avg_net_profit)
)
SELECT 
    a.asc_rank AS rnk, 
    i1.i_product_name AS best_performing, 
    i2.i_product_name AS worst_performing
FROM 
    ranked_items a
JOIN 
    ranked_items d ON a.asc_rank = d.desc_rank
JOIN 
    item i1 ON i1.i_item_sk = a.item_sk
JOIN 
    item i2 ON i2.i_item_sk = d.item_sk
WHERE 
    a.asc_rank < 11
ORDER BY 
    a.asc_rank
LIMIT 100;
```

### Explanation of Changes:
- **Common Sub-expression Elimination (CSE)**: The average net profit calculation is moved to a CTE (`avg_net_profit`), which is referenced in the main query to avoid redundant calculations.
- **Predicate Pushdown**: The `HAVING` clause is directly applied after the `GROUP BY` in the `ranked_items` CTE, ensuring that only necessary data is processed in the ranking functions.
- **Eliminate Redundant Subquery Layers**: Removed unnecessary nested subqueries and combined the ranking operations into a single CTE (`ranked_items`), which computes both ascending and descending ranks.
- **Use of Aliases for Clarity**: Introduced clearer aliases (`a` for ascending ranks and `d` for descending ranks) and used meaningful CTE names to make the query more understandable.

These optimizations should make the query more efficient and easier to maintain.