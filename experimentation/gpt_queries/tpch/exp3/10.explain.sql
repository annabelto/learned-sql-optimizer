explain select 
    c.c_custkey, 
    c.c_name, 
    sub.revenue, 
    c.c_acctbal, 
    n.n_name, 
    c.c_address, 
    c.c_phone, 
    c.c_comment 
FROM 
    customer c 
JOIN 
    nation n ON c.c_nationkey = n.n_nationkey 
JOIN 
    (
        SELECT 
            o.o_custkey, 
            SUM(l.l_extendedprice * (1 - l.l_discount)) as revenue 
        FROM 
            orders o 
        JOIN 
            lineitem l ON l.l_orderkey = o.o_orderkey 
        WHERE 
            o.o_orderdate >= DATE '1995-01-01' 
            AND o.o_orderdate < DATE '1995-01-01' + INTERVAL '3' MONTH 
            AND l.l_returnflag = 'R' 
        GROUP BY 
            o.o_custkey
    ) sub ON c.c_custkey = sub.o_custkey 
ORDER BY 
    revenue DESC 
LIMIT 20;SELECT 
    c.c_custkey, 
    c.c_name, 
    sub.revenue, 
    c.c_acctbal, 
    n.n_name, 
    c.c_address, 
    c.c_phone, 
    c.c_comment 
FROM 
    customer c 
JOIN 
    nation n ON c.c_nationkey = n.n_nationkey 
JOIN 
    (
        SELECT 
            o.o_custkey, 
            SUM(l.l_extendedprice * (1 - l.l_discount)) as revenue 
        FROM 
            orders o 
        JOIN 
            lineitem l ON l.l_orderkey = o.o_orderkey 
        WHERE 
            o.o_orderdate >= DATE '1995-01-01' 
            AND o.o_orderdate < DATE '1995-01-01' + INTERVAL '3' MONTH 
            AND l.l_returnflag = 'R' 
        GROUP BY 
            o.o_custkey
    ) sub ON c.c_custkey = sub.o_custkey 
ORDER BY 
    revenue DESC 
LIMIT 20;