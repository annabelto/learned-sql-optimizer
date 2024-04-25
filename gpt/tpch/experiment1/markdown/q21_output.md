To optimize the given SQL query, we can apply several data-independent rewrite rules that improve the performance without altering the result. Here are the steps and rules applied:

1. **Predicate Pushdown**: This rule moves predicates (conditions) closer to the data source. It reduces the number of rows processed by filtering data as early as possible in the query plan.

2. **Join Reordering**: This rule changes the order of joins to reduce the size of intermediate results, which can decrease the overall query execution time.

3. **Elimination of Redundant Subqueries**: This rule removes subqueries that are unnecessary or can be combined with other parts of the query.

Here's the optimized query with explanations for each step:

```sql
SELECT s_name, COUNT(*) AS numwait
FROM supplier
JOIN nation ON s_nationkey = n_nationkey
JOIN lineitem l1 ON s_suppkey = l1.l_suppkey
JOIN orders ON o_orderkey = l1.l_orderkey
WHERE n_name = 'KENYA'
  AND o_orderstatus = 'F'
  AND l1.l_receiptdate > l1.l_commitdate
  AND EXISTS (
    SELECT 1
    FROM lineitem l2
    WHERE l2.l_orderkey = l1.l_orderkey
      AND l2.l_suppkey <> l1.l_suppkey
  )
  AND NOT EXISTS (
    SELECT 1
    FROM lineitem l3
    WHERE l3.l_orderkey = l1.l_orderkey
      AND l3.l_suppkey <> l1.l_suppkey
      AND l3.l_receiptdate > l3.l_commitdate
  )
GROUP BY s_name
ORDER BY numwait DESC, s_name
LIMIT ALL;
```

### Explanation of Changes:

1. **Predicate Pushdown**:
   - Moved the conditions `n_name = 'KENYA'`, `o_orderstatus = 'F'`, and `l1.l_receiptdate > l1.l_commitdate` directly into the `WHERE` clause to filter rows as early as possible.
   - This reduces the number of rows that need to be joined and processed in later stages.

2. **Join Reordering**:
   - Reordered joins to start with `supplier` and `nation` based on the `n_name = 'KENYA'` condition, which likely reduces the result set size early.
   - Then joined `lineitem` and `orders`, which are filtered by `o_orderstatus` and `l1.l_receiptdate > l1.l_commitdate`.

3. **Elimination of Redundant Subqueries**:
   - The subqueries in `EXISTS` and `NOT EXISTS` are necessary for the logic and cannot be eliminated or combined further without changing the semantics of the query.

4. **Simplification of Subquery Select Clauses**:
   - Changed the `SELECT *` in the subqueries to `SELECT 1` because we are only checking for the existence of rows, not retrieving specific column values.

These optimizations should help improve the performance of the query by reducing the amount of data processed and the complexity of the operations performed.