To optimize the given SQL query, we can apply several data-independent rewrite rules that help in reducing the amount of data processed and the complexity of the operations. Here are the steps and rules applied:

1. **Push Selections Down**: This rule moves filter conditions as close as possible to the base tables. This reduces the number of tuples in the intermediate results and minimizes the amount of data that needs to be joined.

2. **Push Projections Down**: This rule reduces the number of columns handled in the intermediate results by projecting only the necessary columns early in the query processing.

3. **Join Order Optimization**: This rule rearranges the joins to minimize the size of intermediate results.

Here's how these rules can be applied to the given query:

### Original Query:
```sql
SELECT l_orderkey, 
       SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
       o_orderdate, 
       o_shippriority 
FROM customer, orders, lineitem 
WHERE c_mktsegment = 'AUTOMOBILE' 
  AND c_custkey = o_custkey 
  AND l_orderkey = o_orderkey 
  AND o_orderdate < DATE '1995-03-20' 
  AND l_shipdate > DATE '1995-03-20' 
GROUP BY l_orderkey, o_orderdate, o_shippriority 
ORDER BY revenue DESC, o_orderdate 
LIMIT ALL;
```

### Optimized Query:
```sql
SELECT l_orderkey, 
       SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
       o_orderdate, 
       o_shippriority 
FROM (
    SELECT l_orderkey, l_extendedprice, l_discount
    FROM lineitem
    WHERE l_shipdate > DATE '1995-03-20'
) AS l
JOIN (
    SELECT o_orderkey, o_orderdate, o_shippriority, o_custkey
    FROM orders
    WHERE o_orderdate < DATE '1995-03-20'
) AS o ON l_orderkey = o_orderkey
JOIN (
    SELECT c_custkey
    FROM customer
    WHERE c_mktsegment = 'AUTOMOBILE'
) AS c ON c_custkey = o_custkey
GROUP BY l_orderkey, o_orderdate, o_shippriority 
ORDER BY revenue DESC, o_orderdate 
LIMIT ALL;
```

### Explanation of Optimization Steps:
1. **Push Selections Down**: 
   - Filters `c_mktsegment = 'AUTOMOBILE'` for `customer`, `o_orderdate < DATE '1995-03-20'` for `orders`, and `l_shipdate > DATE '1995-03-20'` for `lineitem` are pushed down to reduce the size of data being joined.
   
2. **Push Projections Down**: 
   - Only the necessary columns (`c_custkey` from `customer`, `o_orderkey`, `o_orderdate`, `o_shippriority`, `o_custkey` from `orders`, and `l_orderkey`, `l_extendedprice`, `l_discount` from `lineitem`) are selected in the subqueries, reducing the amount of data processed in the joins and group by operations.

3. **Join Order Optimization**: 
   - Although not explicitly rearranged in this example, considering the size and selectivity of the filters, the optimizer might choose to perform joins in a way that minimizes the intermediate result sizes. Typically, smaller or more filtered datasets (`customer` and `orders`) might be joined first.

These optimizations should lead to a more efficient execution of the query by reducing the amount of data transferred and processed at each step of the query execution plan.