explain select o_year,
       SUM(CASE WHEN nation = 'MOZAMBIQUE' THEN volume ELSE 0 END) / SUM(volume) AS mkt_share
FROM (
    SELECT EXTRACT(YEAR FROM o_orderdate) AS o_year,
           l_extendedprice * (1 - l_discount) AS volume,
           n2.n_name AS nation
    FROM part p
    JOIN lineitem l ON p.p_partkey = l.l_partkey
    JOIN orders o ON l.l_orderkey = o.o_orderkey
    JOIN customer c ON o.o_custkey = c.c_custkey
    JOIN supplier s ON s.s_suppkey = l.l_suppkey
    JOIN nation n1 ON c.c_nationkey = n1.n_nationkey
    JOIN region r ON n1.n_regionkey = r.r_regionkey AND r.r_name = 'AFRICA'
    JOIN nation n2 ON s.s_nationkey = n2.n_nationkey
    WHERE o.o_orderdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
      AND p.p_type = 'PROMO BRUSHED BRASS'
) AS all_nations
GROUP BY o_year
ORDER BY o_year
LIMIT ALL;SELECT o_year,
       SUM(CASE WHEN nation = 'MOZAMBIQUE' THEN volume ELSE 0 END) / SUM(volume) AS mkt_share
FROM (
    SELECT EXTRACT(YEAR FROM o_orderdate) AS o_year,
           l_extendedprice * (1 - l_discount) AS volume,
           n2.n_name AS nation
    FROM part p
    JOIN lineitem l ON p.p_partkey = l.l_partkey
    JOIN orders o ON l.l_orderkey = o.o_orderkey
    JOIN customer c ON o.o_custkey = c.c_custkey
    JOIN supplier s ON s.s_suppkey = l.l_suppkey
    JOIN nation n1 ON c.c_nationkey = n1.n_nationkey
    JOIN region r ON n1.n_regionkey = r.r_regionkey AND r.r_name = 'AFRICA'
    JOIN nation n2 ON s.s_nationkey = n2.n_nationkey
    WHERE o.o_orderdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
      AND p.p_type = 'PROMO BRUSHED BRASS'
) AS all_nations
GROUP BY o_year
ORDER BY o_year
LIMIT ALL;