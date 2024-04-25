explain select n_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM region
JOIN nation ON region.r_regionkey = nation.n_regionkey
JOIN supplier ON nation.n_nationkey = supplier.s_nationkey
JOIN customer ON supplier.s_nationkey = customer.c_nationkey
JOIN orders ON customer.c_custkey = orders.o_custkey
    AND orders.o_orderdate >= DATE '1995-01-01'
    AND orders.o_orderdate < DATE '1995-01-01' + INTERVAL '1' year
JOIN lineitem ON orders.o_orderkey = lineitem.l_orderkey
    AND lineitem.l_suppkey = supplier.s_suppkey
WHERE region.r_name = 'MIDDLE EAST'
GROUP BY n_name
ORDER BY revenue DESC
LIMIT ALL;SELECT n_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM region
JOIN nation ON region.r_regionkey = nation.n_regionkey
JOIN supplier ON nation.n_nationkey = supplier.s_nationkey
JOIN customer ON supplier.s_nationkey = customer.c_nationkey
JOIN orders ON customer.c_custkey = orders.o_custkey
    AND orders.o_orderdate >= DATE '1995-01-01'
    AND orders.o_orderdate < DATE '1995-01-01' + INTERVAL '1' year
JOIN lineitem ON orders.o_orderkey = lineitem.l_orderkey
    AND lineitem.l_suppkey = supplier.s_suppkey
WHERE region.r_name = 'MIDDLE EAST'
GROUP BY n_name
ORDER BY revenue DESC
LIMIT ALL;