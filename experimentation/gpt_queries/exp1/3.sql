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