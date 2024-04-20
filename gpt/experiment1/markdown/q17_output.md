To optimize the given SQL query, we can apply several data-independent rewrite rules that improve the performance without changing the result. The rules include predicate pushdown, subquery flattening, and using joins instead of subqueries where applicable. Here's the step-by-step optimization process:

### Original Query
```sql
SELECT SUM(l_extendedprice) / 7.0 AS avg_yearly
FROM lineitem, part
WHERE p_partkey = l_partkey
  AND p_brand = ':1'
  AND p_container = ':2'
  AND l_quantity < (
    SELECT 0.2 * AVG(l_quantity)
    FROM lineitem
    WHERE l_partkey = p_partkey
  );
```

### Step 1: Predicate Pushdown
This rule pushes conditions into the subquery to reduce the number of rows processed early in the execution plan.

**Apply Predicate Pushdown:**
Move the condition `p_partkey = l_partkey` into the subquery to reduce the number of rows processed by the subquery.

### Step 2: Subquery Flattening
This rule replaces a subquery with a join when possible, which can be more efficient as it allows the database to better optimize the execution plan.

**Apply Subquery Flattening:**
Convert the subquery into a join. This involves calculating the average quantity per part key in a derived table and then joining this result back to the `lineitem` and `part` tables.

### Optimized Query
```sql
SELECT SUM(l_extendedprice) / 7.0 AS avg_yearly
FROM lineitem
JOIN part ON p_partkey = l_partkey
JOIN (
  SELECT l_partkey AS sub_l_partkey, 0.2 * AVG(l_quantity) AS avg_qty
  FROM lineitem
  GROUP BY l_partkey
) AS subquery ON subquery.sub_l_partkey = l_partkey
WHERE p_brand = ':1'
  AND p_container = ':2'
  AND l_quantity < subquery.avg_qty;
```

### Explanation of Applied Rules:
1. **Predicate Pushdown**: Initially, the subquery was calculating the average quantity for potentially many rows that would later be filtered out. By moving the join condition into the subquery, we ensure that the average is only computed for relevant `partkey`s.

2. **Subquery Flattening**: By converting the subquery into a join, the database can optimize the join order and execution plan more effectively than when dealing with a correlated subquery. This also allows all filtering and joining to be handled in a single pass, which is generally more efficient.

This optimized query should perform better because it minimizes the amount of data processed by leveraging joins and reducing the complexity of the subquery. The use of a derived table (subquery in the FROM clause) ensures that the average quantity calculation is done once per `partkey` and then reused in the main query, rather than being recalculated for each row in the outer query.