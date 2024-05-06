To optimize the given query, I will apply the following rules:

1. Use explicit join syntax instead of comma-separated tables in the FROM clause.
2. Replace implicit joins with explicit joins.
3. Use JOIN instead of WHERE for linking tables.
4. Use JOIN instead of WHERE for combining tables.
5. Use explicit join conditions.
6. Move conditions from WHERE clause to ON clause in JOINs.

### Original Query:
```sql
select n_name, sum(l_extendedprice * (1 - l_discount)) as revenue
from customer, orders, lineitem, supplier, nation, region
where c_custkey = o_custkey
  and l_orderkey = o_orderkey
  and l_suppkey = s_suppkey
  and c_nationkey = s_nationkey
  and s_nationkey = n_nationkey
  and n_regionkey = r_regionkey
  and r_name = 'MIDDLE EAST'
  and o_orderdate >= date '1995-01-01'
  and o_orderdate < date '1995-01-01' + interval '1' year
group by n_name
order by revenue desc
LIMIT ALL;
```

### Optimized Query:
```sql
SELECT n_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM customer
JOIN orders ON c_custkey = o_custkey
JOIN lineitem ON l_orderkey = o_orderkey
JOIN supplier ON l_suppkey = s_suppkey AND c_nationkey = s_nationkey
JOIN nation ON s_nationkey = n_nationkey
JOIN region ON n_regionkey = r_regionkey
WHERE r_name = 'MIDDLE EAST'
  AND o_orderdate >= DATE '1995-01-01'
  AND o_orderdate < DATE '1995-01-01' + INTERVAL '1' year
GROUP BY n_name
ORDER BY revenue DESC
LIMIT ALL;
```

### Explanation:
- **Rule 1, 2, 3, 4, 5:** I replaced the comma-separated list of tables in the FROM clause with explicit JOIN syntax and specified the join conditions using the ON keyword. This makes the query more readable and clear about how tables are related.
- **Rule 6:** I moved the conditions that are related to the join (like `c_custkey = o_custkey`, `l_orderkey = o_orderkey`, etc.) to the ON clause of the respective JOINs. Conditions that filter the results (like `r_name = 'MIDDLE EAST'` and date conditions) remain in the WHERE clause.

This optimized query structure helps in understanding the relationships between tables and ensures that the joins are processed efficiently by the database engine.