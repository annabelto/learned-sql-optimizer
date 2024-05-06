To optimize the given TPC-H query, we will apply the provided data-independent rewrite rules. The original query uses a comma-separated list of tables in the FROM clause and mixes join conditions with filtering conditions in the WHERE clause. We will address these issues by using explicit JOIN syntax and moving appropriate conditions to the ON clause of the JOINs.

### Rules Applied:
1. **Use explicit join syntax instead of comma-separated tables in the FROM clause.**
2. **Replace implicit joins with explicit joins.**
3. **Use JOIN instead of WHERE for linking tables.**
4. **Use JOIN instead of WHERE for combining tables.**
5. **Use explicit join conditions.**
6. **Move conditions from WHERE clause to ON clause in JOINs.**

### Optimized Query:
```sql
SELECT o_year,
       SUM(CASE WHEN nation = 'MOZAMBIQUE' THEN volume ELSE 0 END) / SUM(volume) AS mkt_share
FROM (
    SELECT EXTRACT(YEAR FROM o_orderdate) AS o_year,
           l_extendedprice * (1 - l_discount) AS volume,
           n2.n_name AS nation
    FROM part p
    JOIN lineitem l ON p.p_partkey = l.l_partkey
    JOIN orders o ON l.l_orderkey = o.o_orderkey
    JOIN customer c ON o.o_custkey = c.c_custkey
    JOIN supplier s ON s.s_suppkey = l.l_suppkey
    JOIN nation n1 ON c.c_nationkey = n1.n_nationkey
    JOIN region r ON n1.n_regionkey = r.r_regionkey AND r.r_name = 'AFRICA'
    JOIN nation n2 ON s.s_nationkey = n2.n_nationkey
    WHERE o.o_orderdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
      AND p.p_type = 'PROMO BRUSHED BRASS'
) AS all_nations
GROUP BY o_year
ORDER BY o_year
LIMIT ALL;
```

### Explanation:
- **Explicit JOIN Syntax**: The query now uses explicit `JOIN` clauses instead of listing tables separated by commas. This makes the relationships between tables clearer and easier to understand.
- **Moving Conditions to ON Clauses**: Conditions that are directly related to how tables are linked (e.g., `p.p_partkey = l.l_partkey`) are moved to the `ON` clause of the corresponding `JOIN`. This helps in potentially reducing the working dataset early during query execution.
- **Filtering Conditions in WHERE Clause**: Conditions that filter the data, but are not directly related to table joins (e.g., filtering by dates and product type), remain in the `WHERE` clause.
- **Order and Grouping**: The `GROUP BY` and `ORDER BY` clauses are maintained as in the original query to ensure the same output structure and sorting.

This optimized query should perform better in terms of execution plan clarity and potentially execution time, as it allows the database engine to better understand the relationships and filter data more efficiently during joins.