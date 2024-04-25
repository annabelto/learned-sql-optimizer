explain select 
    l.l_orderkey, 
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue, 
    o.o_orderdate, 
    o.o_shippriority 
FROM 
    (SELECT * FROM customer WHERE c_mktsegment = 'AUTOMOBILE') c
JOIN 
    orders o ON c.c_custkey = o.c_custkey AND o.o_orderdate < DATE '1995-03-20'
JOIN 
    (SELECT * FROM lineitem WHERE l_shipdate > DATE '1995-03-20') l ON l.l_orderkey = o.o_orderkey
GROUP BY 
    l.l_orderkey, 
    o.o_orderdate, 
    o.o_shippriority 
ORDER BY 
    revenue DESC, 
    o.o_orderdate;SELECT 
    l.l_orderkey, 
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue, 
    o.o_orderdate, 
    o.o_shippriority 
FROM 
    (SELECT * FROM customer WHERE c_mktsegment = 'AUTOMOBILE') c
JOIN 
    orders o ON c.c_custkey = o.c_custkey AND o.o_orderdate < DATE '1995-03-20'
JOIN 
    (SELECT * FROM lineitem WHERE l_shipdate > DATE '1995-03-20') l ON l.l_orderkey = o.o_orderkey
GROUP BY 
    l.l_orderkey, 
    o.o_orderdate, 
    o.o_shippriority 
ORDER BY 
    revenue DESC, 
    o.o_orderdate;