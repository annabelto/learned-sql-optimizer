SELECT nation, o_year, SUM(amount) AS sum_profit
FROM (
    SELECT n.n_name AS nation, 
           EXTRACT(YEAR FROM o.o_orderdate) AS o_year, 
           l.l_extendedprice * (1 - l.l_discount) - ps.ps_supplycost * l.l_quantity AS amount
    FROM part p
    JOIN partsupp ps ON p.p_partkey = ps.ps_partkey
    JOIN lineitem l ON l.l_partkey = p.p_partkey AND l.l_suppkey = ps.ps_suppkey
    JOIN orders o ON o.o_orderkey = l.l_orderkey
    JOIN supplier s ON s.s_suppkey = l.l_suppkey
    JOIN nation n ON n.n_nationkey = s.s_nationkey
    WHERE p.p_name LIKE '%white%'
) AS profit
GROUP BY nation, o_year
ORDER BY nation, o_year DESC;