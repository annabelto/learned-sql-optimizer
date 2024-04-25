SELECT 
    n1.n_name AS supp_nation, 
    n2.n_name AS cust_nation, 
    EXTRACT(year FROM l.l_shipdate) AS l_year, 
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
FROM 
    supplier s
JOIN 
    nation n1 ON s.s_nationkey = n1.n_nationkey
JOIN 
    lineitem l ON s.s_suppkey = l.l_suppkey
JOIN 
    orders o ON l.l_orderkey = o.o_orderkey
JOIN 
    customer c ON o.c_custkey = c.c_custkey
JOIN 
    nation n2 ON c.c_nationkey = n2.n_nationkey
WHERE 
    ((n1.n_name = 'CANADA' AND n2.n_name = 'MOZAMBIQUE') OR (n1.n_name = 'MOZAMBIQUE' AND n2.n_name = 'CANADA'))
    AND l.l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
GROUP BY 
    n1.n_name, n2.n_name, EXTRACT(year FROM l.l_shipdate)
ORDER BY 
    n1.n_name, n2.n_name, EXTRACT(year FROM l.l_shipdate)
LIMIT ALL;