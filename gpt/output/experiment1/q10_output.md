To optimize the given SQL query, we can apply several data-independent rewrite rules that help in reducing the amount of data processed and the complexity of the operations. Here are the steps and rules applied:

1. **Push Selections Down**: This rule moves filter conditions as close as possible to the data sources. This reduces the number of tuples in the intermediate results and minimizes the amount of data that needs to be joined.

2. **Push Projections Down**: This rule reduces the number of columns handled in the intermediate results by projecting (selecting) only the necessary columns early in the query processing.

Here's the optimized query with explanations for each step:

### Original Query
```sql
SELECT c_custkey, c_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue, c_acctbal, n_name, c_address, c_phone, c_comment
FROM customer, orders, lineitem, nation
WHERE c_custkey = o_custkey
  AND l_orderkey = o_orderkey
  AND o_orderdate >= date ':1'
  AND o_orderdate < date ':1' + interval '3' month
  AND l_returnflag = 'R'
  AND c_nationkey = n_nationkey
GROUP BY c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment
ORDER BY revenue DESC;
```

### Optimized Query
```sql
SELECT c_custkey, c_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue, c_acctbal, n_name, c_address, c_phone, c_comment
FROM (
    SELECT c_custkey, c_name, c_acctbal, c_nationkey, c_address, c_phone, c_comment
    FROM customer
) c
JOIN (
    SELECT o_custkey, o_orderkey
    FROM orders
    WHERE o_orderdate >= date ':1'
      AND o_orderdate < date ':1' + interval '3' month
) o ON c.c_custkey = o.o_custkey
JOIN (
    SELECT l_orderkey, l_extendedprice, l_discount
    FROM lineitem
    WHERE l_returnflag = 'R'
) l ON o.o_orderkey = l_orderkey
JOIN (
    SELECT n_nationkey, n_name
    FROM nation
) n ON c.c_nationkey = n.nationkey
GROUP BY c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment
ORDER BY revenue DESC;
```

### Explanation of Optimization Steps:
- **Push Selections Down**: Filters on `orders.o_orderdate` and `lineitem.l_returnflag` are pushed down to their respective table scans. This reduces the number of rows from `orders` and `lineitem` that participate in the join, thus reducing the computational load.
- **Push Projections Down**: Only the necessary columns are selected from each table early in the query. This reduces the amount of data that needs to be carried through the joins and grouped later.

These optimizations should make the query more efficient by reducing the amount of data transferred between operations and focusing processing on relevant subsets of data.