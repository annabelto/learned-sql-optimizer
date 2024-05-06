explain select 
    c.c_custkey, 
    c.c_name, 
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue, 
    c.c_acctbal, 
    n.n_name, 
    c.c_address, 
    c.c_phone, 
    c.c_comment 
FROM 
    customer c
JOIN 
    orders o ON c.c_custkey = o.o_custkey
JOIN 
    lineitem l ON o.o_orderkey = l.l_orderkey
JOIN 
    nation n ON c.c_nationkey = n.n_nationkey
WHERE 
    o.o_orderdate >= DATE '1995-01-01' 
    AND o.o_orderdate < DATE '1995-01-01' + INTERVAL '3' MONTH
    AND l.l_returnflag = 'R'
GROUP BY 
    c.c_custkey, 
    c.c_name, 
    c.c_acctbal, 
    c.c_phone, 
    n.n_name, 
    c.c_address, 
    c.c_comment 
ORDER BY 
    revenue DESC 
LIMIT 20;SELECT 
    c.c_custkey, 
    c.c_name, 
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue, 
    c.c_acctbal, 
    n.n_name, 
    c.c_address, 
    c.c_phone, 
    c.c_comment 
FROM 
    customer c
JOIN 
    orders o ON c.c_custkey = o.o_custkey
JOIN 
    lineitem l ON o.o_orderkey = l.l_orderkey
JOIN 
    nation n ON c.c_nationkey = n.n_nationkey
WHERE 
    o.o_orderdate >= DATE '1995-01-01' 
    AND o.o_orderdate < DATE '1995-01-01' + INTERVAL '3' MONTH
    AND l.l_returnflag = 'R'
GROUP BY 
    c.c_custkey, 
    c.c_name, 
    c.c_acctbal, 
    c.c_phone, 
    n.n_name, 
    c.c_address, 
    c.c_comment 
ORDER BY 
    revenue DESC 
LIMIT 20;