### Original Query
```sql
SELECT s_name, s_address 
FROM supplier, nation 
WHERE s_suppkey IN (
    SELECT ps_suppkey 
    FROM partsupp, (
        SELECT l_partkey AS agg_partkey, l_suppkey AS agg_suppkey, 0.5 * SUM(l_quantity) AS agg_quantity 
        FROM lineitem 
        WHERE l_shipdate >= DATE '1995-01-01' 
        AND l_shipdate < DATE '1995-01-01' + INTERVAL '1' YEAR 
        GROUP BY l_partkey, l_suppkey
    ) agg_lineitem 
    WHERE agg_partkey = ps_partkey 
    AND agg_suppkey = ps_suppkey 
    AND ps_partkey IN (
        SELECT p_partkey 
        FROM part 
        WHERE p_name LIKE 'linen%'
    ) 
    AND ps_availqty > agg_quantity
) 
AND s_nationkey = n_nationkey 
AND n_name = 'FRANCE' 
ORDER BY s_name 
LIMIT ALL;
```

### Optimization Steps

1. **Predicate Pushdown**: Move conditions as close as possible to where the data originates. This reduces the amount of data processed in the subqueries and joins.
2. **Join Elimination**: Replace implicit joins (comma-separated in FROM clause) with explicit JOIN syntax for clarity and potential performance benefits.
3. **Use of EXISTS instead of IN**: When checking for existence, EXISTS can be more efficient than IN because it stops processing as soon as it finds the first occurrence.
4. **Remove Redundant LIMIT ALL**: `LIMIT ALL` is redundant as it does not limit the number of rows returned.

### Applying the Rules

1. **Predicate Pushdown**: Move the condition `p_name LIKE 'linen%'` closer to the `part` table and `ps_availqty > agg_quantity` closer to the `partsupp` table.
2. **Join Elimination**: Convert the implicit joins to explicit JOINs.
3. **Use of EXISTS instead of IN**: Convert the IN subquery to an EXISTS subquery.
4. **Remove Redundant LIMIT ALL**: Remove the `LIMIT ALL` clause.

### Optimized Query
```sql
SELECT s_name, s_address 
FROM supplier
JOIN nation ON s_nationkey = n_nationkey 
WHERE n_name = 'FRANCE'
AND EXISTS (
    SELECT 1
    FROM partsupp
    JOIN (
        SELECT l_partkey AS agg_partkey, l_suppkey AS agg_suppkey, 0.5 * SUM(l_quantity) AS agg_quantity 
        FROM lineitem 
        WHERE l_shipdate >= DATE '1995-01-01' 
        AND l_shipdate < DATE '1995-01-01' + INTERVAL '1' YEAR 
        GROUP BY l_partkey, l_suppkey
    ) agg_lineitem ON agg_partkey = ps_partkey AND agg_suppkey = ps_suppkey
    WHERE ps_suppkey = supplier.s_suppkey
    AND ps_availqty > agg_quantity
    AND EXISTS (
        SELECT 1
        FROM part
        WHERE p_partkey = ps_partkey
        AND p_name LIKE 'linen%'
    )
)
ORDER BY s_name;
```

This rewritten query should perform better due to more efficient subquery processing and clearer join conditions.