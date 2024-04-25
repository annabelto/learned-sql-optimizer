explain select o_year, 
       SUM(CASE WHEN nation = 'MOZAMBIQUE' THEN volume ELSE 0 END) / SUM(volume) AS mkt_share 
FROM (
    SELECT EXTRACT(YEAR FROM o_orderdate) AS o_year, 
           l_extendedprice * (1 - l_discount) AS volume, 
           n2.n_name AS nation 
    FROM part
    JOIN lineitem ON p_partkey = l_partkey
    JOIN orders ON l_orderkey = o_orderkey
    JOIN supplier ON s_suppkey = l_suppkey
    JOIN customer ON o_custkey = c_custkey
    JOIN nation n1 ON c_nationkey = n1.n_nationkey
    JOIN region ON n1.n_regionkey = r_regionkey
    JOIN nation n2 ON s_nationkey = n2.n_nationkey
    WHERE r_name = 'AFRICA'
      AND o_orderdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
      AND p_type = 'PROMO BRUSHED BRASS'
) AS all_nations 
GROUP BY o_year 
ORDER BY o_year 
LIMIT ALL;SELECT o_year, 
       SUM(CASE WHEN nation = 'MOZAMBIQUE' THEN volume ELSE 0 END) / SUM(volume) AS mkt_share 
FROM (
    SELECT EXTRACT(YEAR FROM o_orderdate) AS o_year, 
           l_extendedprice * (1 - l_discount) AS volume, 
           n2.n_name AS nation 
    FROM part
    JOIN lineitem ON p_partkey = l_partkey
    JOIN orders ON l_orderkey = o_orderkey
    JOIN supplier ON s_suppkey = l_suppkey
    JOIN customer ON o_custkey = c_custkey
    JOIN nation n1 ON c_nationkey = n1.n_nationkey
    JOIN region ON n1.n_regionkey = r_regionkey
    JOIN nation n2 ON s_nationkey = n2.n_nationkey
    WHERE r_name = 'AFRICA'
      AND o_orderdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
      AND p_type = 'PROMO BRUSHED BRASS'
) AS all_nations 
GROUP BY o_year 
ORDER BY o_year 
LIMIT ALL;