To optimize the given query, I will apply the following rules:

1. Use explicit join syntax instead of comma-separated tables in the FROM clause.
2. Replace implicit joins with explicit joins.
3. Use JOIN instead of WHERE for linking tables.
4. Use JOIN instead of WHERE for combining tables.
5. Use explicit join conditions.
6. Move conditions from WHERE clause to ON clause in JOINs.

### Optimized Query

```sql
SELECT supp_nation, cust_nation, l_year, SUM(volume) AS revenue
FROM (
    SELECT 
        n1.n_name AS supp_nation, 
        n2.n_name AS cust_nation, 
        EXTRACT(YEAR FROM l_shipdate) AS l_year, 
        l_extendedprice * (1 - l_discount) AS volume
    FROM 
        supplier
        JOIN lineitem ON s_suppkey = l_suppkey
        JOIN orders ON o_orderkey = l_orderkey
        JOIN customer ON c_custkey = o_custkey
        JOIN nation n1 ON s_nationkey = n1.n_nationkey
        JOIN nation n2 ON c_nationkey = n2.n_nationkey
    WHERE 
        ((n1.n_name = 'CANADA' AND n2.n_name = 'MOZAMBIQUE') OR 
         (n1.n_name = 'MOZAMBIQUE' AND n2.n_name = 'CANADA'))
        AND l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
) AS shipping
GROUP BY supp_nation, cust_nation, l_year
ORDER BY supp_nation, cust_nation, l_year
LIMIT ALL;
```

### Explanation of Changes:
- **Rule 1, 2, 3, 4, 5:** I replaced the comma-separated list of tables in the FROM clause with explicit JOIN syntax, specifying the join conditions using the ON keyword. This makes the query easier to read and understand, and it also helps the database optimizer to better understand the relationships between tables.
- **Rule 6:** I moved the conditions that link the tables directly into the ON clauses of the respective JOINs. This is more efficient as it allows the database engine to reduce the dataset earlier in the query process, potentially reducing the amount of data that needs to be processed in later stages of the query.