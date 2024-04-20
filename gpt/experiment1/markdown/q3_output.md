To optimize the given SQL query, we can apply several data-independent rewrite rules that improve the performance without altering the result. The rules include predicate pushdown, join reordering, and projection pruning. Here's how these rules can be applied:

1. **Predicate Pushdown**: This rule moves the filtering predicates closer to the data source. It reduces the amount of data that needs to be processed in the later stages of the query.

2. **Join Reordering**: This rule changes the order of joins to minimize the size of intermediate results. It's generally beneficial to perform joins that reduce the result size early.

3. **Projection Pruning**: This rule removes unnecessary columns from the SELECT and intermediate operations, reducing the amount of data that needs to be processed.

### Original Query
```sql
SELECT l_orderkey, 
       SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
       o_orderdate, 
       o_shippriority 
FROM customer, orders, lineitem 
WHERE c_mktsegment = ':1' 
  AND c_custkey = o_custkey 
  AND l_orderkey = o_orderkey 
  AND o_orderdate < DATE ':2' 
  AND l_shipdate > DATE ':2' 
GROUP BY l_orderkey, o_orderdate, o_shippriority 
ORDER BY revenue DESC, o_orderdate;
```

### Applying Optimization Rules

#### Step 1: Predicate Pushdown
- Move `c_mktsegment = ':1'` to the earliest possible point where `customer` is accessed.
- Move `o_orderdate < DATE ':2'` to the earliest point where `orders` is accessed.
- Move `l_shipdate > DATE ':2'` to the earliest point where `lineitem` is accessed.

#### Step 2: Join Reordering
- Since `customer` and `orders` are joined on `c_custkey = o_custkey` and filtered by `c_mktsegment` and `o_orderdate`, it might be beneficial to perform this join first if these tables are smaller or the filters highly selective.
- `lineitem` can be joined afterward since it's large and filtered by `l_shipdate`.

#### Step 3: Projection Pruning
- Only select columns that are necessary for final output or conditions (`c_custkey`, `o_custkey`, `l_orderkey`, `o_orderkey`, `l_extendedprice`, `l_discount`, `o_orderdate`, `o_shippriority`).

### Optimized Query
```sql
SELECT l_orderkey, 
       SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
       o_orderdate, 
       o_shippriority 
FROM (
    SELECT o_custkey, o_orderkey, o_orderdate, o_shippriority
    FROM orders
    WHERE o_orderdate < DATE ':2'
) AS orders
JOIN (
    SELECT c_custkey
    FROM customer
    WHERE c_mktsegment = ':1'
) AS customer ON customer.c_custkey = orders.o_custkey
JOIN (
    SELECT l_orderkey, l_extendedprice, l_discount
    FROM lineitem
    WHERE l_shipdate > DATE ':2'
) AS lineitem ON lineitem.l_orderkey = orders.o_orderkey
GROUP BY l_orderkey, o_orderdate, o_shippriority 
ORDER BY revenue DESC, o_orderdate;
```

### Explanation
- **Predicate Pushdown**: Filters are applied directly in the subqueries for `customer`, `orders`, and `lineitem`.
- **Join Reordering**: The query first joins filtered `orders` and `customer`, then joins the result with filtered `lineitem`.
- **Projection Pruning**: Each subquery only selects the columns needed for the join conditions and final output, reducing the amount of data processed.

This optimized query should perform better due to reduced I/O and smaller intermediate result sets.