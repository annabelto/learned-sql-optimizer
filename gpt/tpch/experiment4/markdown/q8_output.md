To optimize the given TPC-H query, we can apply several data-independent rewrite rules that can potentially improve the performance of the query execution. The rules I will use include:

1. **Predicate Pushdown**: This involves moving predicates (conditions) as close as possible to the base tables in the query. This reduces the number of rows processed in the upper levels of the query, which can significantly reduce the amount of data that needs to be joined or aggregated in later stages.

2. **Join Elimination**: If a join does not contribute to the final result, it can be eliminated. This is often possible when foreign key relationships are present, and the only purpose of joining a table is to filter data based on a condition that can be checked with existing tables.

3. **Column Pruning**: This involves removing unnecessary columns from the SELECT and JOIN clauses that are not needed for the final output of the query.

### Applying the Rules:

1. **Predicate Pushdown**: We push conditions on `o_orderdate`, `p_type`, and `r_name` closer to their respective tables. This reduces the size of intermediate results early in the query processing.

2. **Join Elimination**: We need to check if any joins can be eliminated without affecting the result. However, in this query, all joins seem necessary to filter and compute the desired results.

3. **Column Pruning**: We can remove unnecessary columns from the SELECT list inside the subquery. For instance, columns from the `part`, `supplier`, `customer`, and `region` tables are not directly used except for filtering and joining purposes.

### Optimized Query:
```sql
SELECT o_year, 
       SUM(CASE WHEN nation = 'MOZAMBIQUE' THEN volume ELSE 0 END) / SUM(volume) AS mkt_share 
FROM (
    SELECT EXTRACT(YEAR FROM o_orderdate) AS o_year, 
           l_extendedprice * (1 - l_discount) AS volume, 
           n2.n_name AS nation 
    FROM part
    JOIN lineitem ON p_partkey = l_partkey
    JOIN orders ON l_orderkey = o_orderkey
    JOIN customer ON o_custkey = c_custkey
    JOIN nation n1 ON c_nationkey = n1.n_nationkey
    JOIN region ON n1.n_regionkey = r_regionkey
    JOIN supplier ON s_suppkey = l_suppkey
    JOIN nation n2 ON s_nationkey = n2.n_nationkey
    WHERE r_name = 'AFRICA'
      AND o_orderdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
      AND p_type = 'PROMO BRUSHED BRASS'
) AS all_nations 
GROUP BY o_year 
ORDER BY o_year 
LIMIT ALL;
```

### Explanation:
- **Predicate Pushdown**: Conditions related to `o_orderdate`, `p_type`, and `r_name` are pushed down.
- **Column Pruning**: Only necessary columns for the final output are selected in the subquery.
- **Join Elimination**: Not applied as all joins contribute to the result.

This optimized query should perform better than the original by reducing the amount of data processed and focusing only on the necessary computations and data retrieval.