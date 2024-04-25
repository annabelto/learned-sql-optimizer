explain select l_orderkey, 
       SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
       o_orderdate, 
       o_shippriority 
FROM (
    SELECT c_custkey
    FROM customer
    WHERE c_mktsegment = 'AUTOMOBILE'
) c
JOIN (
    SELECT o_custkey, o_orderkey, o_orderdate, o_shippriority
    FROM orders
    WHERE o_orderdate < DATE '1995-03-20'
) o ON c.c_custkey = o.o_custkey
JOIN (
    SELECT l_orderkey, l_extendedprice, l_discount
    FROM lineitem
    WHERE l_shipdate > DATE '1995-03-20'
) l ON o.o_orderkey = l.l_orderkey
GROUP BY l_orderkey, o_orderdate, o_shippriority 
ORDER BY revenue DESC, o_orderdate 
LIMIT ALL;SELECT l_orderkey, 
       SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
       o_orderdate, 
       o_shippriority 
FROM (
    SELECT c_custkey
    FROM customer
    WHERE c_mktsegment = 'AUTOMOBILE'
) c
JOIN (
    SELECT o_custkey, o_orderkey, o_orderdate, o_shippriority
    FROM orders
    WHERE o_orderdate < DATE '1995-03-20'
) o ON c.c_custkey = o.o_custkey
JOIN (
    SELECT l_orderkey, l_extendedprice, l_discount
    FROM lineitem
    WHERE l_shipdate > DATE '1995-03-20'
) l ON o.o_orderkey = l.l_orderkey
GROUP BY l_orderkey, o_orderdate, o_shippriority 
ORDER BY revenue DESC, o_orderdate 
LIMIT ALL;