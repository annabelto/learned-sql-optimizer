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