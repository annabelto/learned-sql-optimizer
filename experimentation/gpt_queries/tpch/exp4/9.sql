SELECT 
    n.n_name AS nation, 
    EXTRACT(year FROM o.o_orderdate) AS o_year, 
    SUM(l.l_extendedprice * (1 - l.l_discount) - ps.ps_supplycost * l.l_quantity) AS sum_profit
FROM 
    nation n
JOIN 
    supplier s ON s.s_nationkey = n.n_nationkey
JOIN 
    partsupp ps ON s.s_suppkey = ps.ps_suppkey
JOIN 
    lineitem l ON l.l_suppkey = ps.ps_suppkey AND l.l_partkey = ps.ps_partkey
JOIN 
    orders o ON o.o_orderkey = l.l_orderkey
JOIN 
    part p ON p.p_partkey = l.l_partkey
WHERE 
    p.p_name LIKE '%white%'
GROUP BY 
    n.n_name, EXTRACT(year FROM o.o_orderdate)
ORDER BY 
    n.n_name, EXTRACT(year FROM o.o_orderdate) DESC
LIMIT ALL;