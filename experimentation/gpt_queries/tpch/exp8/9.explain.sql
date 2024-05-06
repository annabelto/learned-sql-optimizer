explain select 
    n.n_name AS nation, 
    EXTRACT(YEAR FROM o.o_orderdate) AS o_year, 
    SUM(l.l_extendedprice * (1 - l.l_discount) - ps.ps_supplycost * l.l_quantity) AS sum_profit 
FROM 
    part p
    JOIN lineitem l ON p.p_partkey = l.l_partkey
    JOIN partsupp ps ON ps.ps_partkey = l.l_partkey AND ps.ps_suppkey = l.l_suppkey
    JOIN orders o ON o.o_orderkey = l.l_orderkey
    JOIN supplier s ON s.s_suppkey = l.l_suppkey
    JOIN nation n ON n.n_nationkey = s.s_nationkey
WHERE 
    p.p_name LIKE '%white%'
GROUP BY 
    n.n_name, 
    EXTRACT(YEAR FROM o.o_orderdate)
ORDER BY 
    n.n_name, 
    EXTRACT(YEAR FROM o.o_orderdate) DESC 
LIMIT ALL;SELECT 
    n.n_name AS nation, 
    EXTRACT(YEAR FROM o.o_orderdate) AS o_year, 
    SUM(l.l_extendedprice * (1 - l.l_discount) - ps.ps_supplycost * l.l_quantity) AS sum_profit 
FROM 
    part p
    JOIN lineitem l ON p.p_partkey = l.l_partkey
    JOIN partsupp ps ON ps.ps_partkey = l.l_partkey AND ps.ps_suppkey = l.l_suppkey
    JOIN orders o ON o.o_orderkey = l.l_orderkey
    JOIN supplier s ON s.s_suppkey = l.l_suppkey
    JOIN nation n ON n.n_nationkey = s.s_nationkey
WHERE 
    p.p_name LIKE '%white%'
GROUP BY 
    n.n_name, 
    EXTRACT(YEAR FROM o.o_orderdate)
ORDER BY 
    n.n_name, 
    EXTRACT(YEAR FROM o.o_orderdate) DESC 
LIMIT ALL;