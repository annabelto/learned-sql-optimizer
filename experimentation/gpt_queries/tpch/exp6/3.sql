SELECT
    l.l_orderkey,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue,
    o.o_orderdate,
    o.o_shippriority
FROM
    customer c
JOIN
    orders o ON c.c_custkey = o.o_custkey
JOIN
    lineitem l ON l.l_orderkey = o.o_orderkey
WHERE
    c.c_mktsegment = 'AUTOMOBILE'
    AND o.o_orderdate < DATE '1995-03-20'
    AND l.l_shipdate > DATE '1995-03-20'
GROUP BY
    l.l_orderkey, o.o_orderdate, o.o_shippriority
ORDER BY
    revenue DESC, o.o_orderdate
LIMIT ALL;