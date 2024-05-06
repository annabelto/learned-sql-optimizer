SELECT 
    l_orderkey, 
    SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
    o_orderdate, 
    o_shippriority 
FROM 
    customer 
JOIN 
    orders ON c_custkey = o_custkey AND o_orderdate < DATE '1995-03-20'
JOIN 
    lineitem ON l_orderkey = o_orderkey AND l_shipdate > DATE '1995-03-20'
WHERE 
    c_mktsegment = 'AUTOMOBILE'
GROUP BY 
    l_orderkey, o_orderdate, o_shippriority 
ORDER BY 
    revenue DESC, o_orderdate 
LIMIT ALL;