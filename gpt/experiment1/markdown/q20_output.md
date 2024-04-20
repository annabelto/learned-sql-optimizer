To optimize the given SQL query, we can apply several data-independent rewrite rules that improve the performance without altering the result. The rules we'll use include:

1. **Predicate Pushdown**: This rule moves predicates closer to where the data originates, reducing the amount of data that needs to be processed in the upper levels of the query.
2. **Subquery Flattening**: This rule transforms correlated subqueries into joins or applies other transformations to simplify the query structure.
3. **Join Reordering**: This rule changes the order of joins to reduce the size of intermediate results.

### Original Query
```sql
SELECT s_name, s_address 
FROM supplier, nation 
WHERE s_suppkey IN (
    SELECT ps_suppkey 
    FROM partsupp 
    WHERE ps_partkey IN (
        SELECT p_partkey 
        FROM part 
        WHERE p_name LIKE ':1%'
    ) 
    AND ps_availqty > (
        SELECT 0.5 * SUM(l_quantity) 
        FROM lineitem 
        WHERE l_partkey = ps_partkey 
        AND l_suppkey = ps_suppkey 
        AND l_shipdate >= DATE ':2' 
        AND l_shipdate < DATE ':2' + INTERVAL '1' year
    )
) 
AND s_nationkey = n_nationkey 
AND n_name = ':3' 
ORDER BY s_name;
```

### Step-by-Step Optimization

#### Step 1: Predicate Pushdown
Push predicates into the subqueries to reduce the amount of data processed and joined.

```sql
SELECT s_name, s_address 
FROM supplier
JOIN nation ON s_nationkey = n_nationkey
WHERE n_name = ':3'
AND s_suppkey IN (
    SELECT ps_suppkey 
    FROM partsupp 
    JOIN (
        SELECT p_partkey 
        FROM part 
        WHERE p_name LIKE ':1%'
    ) AS filtered_parts ON ps_partkey = filtered_parts.p_partkey
    WHERE ps_availqty > (
        SELECT 0.5 * SUM(l_quantity) 
        FROM lineitem 
        WHERE l_partkey = ps_partkey 
        AND l_suppkey = ps_suppkey 
        AND l_shipdate >= DATE ':2' 
        AND l_shipdate < DATE ':2' + INTERVAL '1' year
    )
)
ORDER BY s_name;
```

#### Step 2: Subquery Flattening
Flatten the subquery for `partsupp` by converting it into a join.

```sql
SELECT s_name, s_address 
FROM supplier
JOIN nation ON s_nationkey = n_nationkey
JOIN partsupp ON s_suppkey = ps_suppkey
JOIN part ON ps_partkey = p_partkey
WHERE n_name = ':3'
AND p_name LIKE ':1%'
AND ps_availqty > (
    SELECT 0.5 * SUM(l_quantity) 
    FROM lineitem 
    WHERE l_partkey = ps_partkey 
    AND l_suppkey = ps_suppkey 
    AND l_shipdate >= DATE ':2' 
    AND l_shipdate < DATE ':2' + INTERVAL '1' year
)
ORDER BY s_name;
```

#### Step 3: Join Reordering
Reorder joins to process the most restrictive conditions first (assuming `part` table filtering reduces the dataset significantly).

```sql
SELECT s_name, s_address 
FROM part
JOIN partsupp ON p_partkey = ps_partkey
JOIN supplier ON ps_suppkey = s_suppkey
JOIN nation ON s_nationkey = n_nationkey
WHERE p_name LIKE ':1%'
AND n_name = ':3'
AND ps_availqty > (
    SELECT 0.5 * SUM(l_quantity) 
    FROM lineitem 
    WHERE l_partkey = ps_partkey 
    AND l_suppkey = ps_suppkey 
    AND l_shipdate >= DATE ':2' 
    AND l_shipdate < DATE ':2' + INTERVAL '1' year
)
ORDER BY s_name;
```

### Final Optimized Query
The final query uses joins instead of subqueries where possible, applies predicate pushdown to reduce the data volume early, and reorders joins to minimize intermediate result sizes. This should perform better than the original query, especially on large datasets.