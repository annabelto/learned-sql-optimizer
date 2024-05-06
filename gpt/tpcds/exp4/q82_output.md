To optimize the given query, we can apply several data-independent rewrite rules that can potentially improve the performance of the query execution. The rules include:

1. **Predicate Pushdown**: Move predicates as close as possible to where the data originates, reducing the amount of data that needs to be processed in the later stages of the query.
2. **Join Reordering**: Reorder joins to reduce the size of intermediate results, which can decrease the overall query execution time.
3. **Use of Explicit JOIN Syntax**: Convert implicit joins (comma-separated in the FROM clause) to explicit JOIN syntax for better readability and control.
4. **Elimination of Redundant GROUP BY**: Since the query uses an aggregate function on columns that are already in the GROUP BY clause, ensure that the grouping is necessary and correctly applied.
5. **Limit Pushdown**: If possible, push the limit down to reduce the amount of data processed.

### Original Query:
```sql
SELECT i_item_id, i_item_desc, i_current_price
FROM item, inventory, date_dim, store_sales
WHERE i_current_price BETWEEN 58 AND 58 + 30
  AND inv_item_sk = i_item_sk
  AND d_date_sk = inv_date_sk
  AND d_date BETWEEN CAST('2001-01-13' AS DATE) AND (CAST('2001-01-13' AS DATE) + 60)
  AND i_manufact_id IN (259, 559, 580, 485)
  AND inv_quantity_on_hand BETWEEN 100 AND 500
  AND ss_item_sk = i_item_sk
GROUP BY i_item_id, i_item_desc, i_current_price
ORDER BY i_item_id
LIMIT 100;
```

### Applying Optimization Rules:

1. **Use of Explicit JOIN Syntax**:
   Convert the implicit joins to explicit joins for clarity and potentially better optimization by the query planner.

2. **Predicate Pushdown**:
   Push predicates into the JOIN conditions where applicable, especially those that involve keys used in the joins.

3. **Join Reordering**:
   Not explicitly shown here, but typically handled by the query optimizer. Ensure that smaller result sets are joined earlier if possible.

### Optimized Query:
```sql
SELECT i_item_id, i_item_desc, i_current_price
FROM item
JOIN inventory ON inv_item_sk = i_item_sk AND inv_quantity_on_hand BETWEEN 100 AND 500
JOIN date_dim ON d_date_sk = inv_date_sk AND d_date BETWEEN CAST('2001-01-13' AS DATE) AND (CAST('2001-01-13' AS DATE) + 60)
JOIN store_sales ON ss_item_sk = i_item_sk
WHERE i_current_price BETWEEN 58 AND 88  -- Simplified arithmetic expression
  AND i_manufact_id IN (259, 559, 580, 485)
GROUP BY i_item_id, i_item_desc, i_current_price
ORDER BY i_item_id
LIMIT 100;
```

In this optimized query:
- The explicit JOIN syntax clarifies the relationships and conditions directly associated with each join.
- Conditions related to specific tables are moved closer to those table references, which can help in executing more efficient scans and joins.
- The arithmetic expression in the `BETWEEN` clause is simplified for clarity.