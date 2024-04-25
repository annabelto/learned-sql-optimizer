explain select supp_nation, cust_nation, l_year, sum(volume) as revenue
FROM (
    SELECT n1.n_name as supp_nation, n2.n_name as cust_nation, 
           extract(year from l_shipdate) as l_year, 
           l_extendedprice * (1 - l_discount) as volume
    FROM supplier
    JOIN lineitem ON s_suppkey = l_suppkey
    JOIN orders ON o_orderkey = l_orderkey
    JOIN customer ON c_custkey = o_custkey
    JOIN nation n1 ON s_nationkey = n1.n_nationkey
    JOIN nation n2 ON c_nationkey = n2.n_nationkey
    WHERE (
          (n1.n_name = 'CANADA' AND n2.n_name = 'MOZAMBIQUE') 
          OR (n1.n_name = 'MOZAMBIQUE' AND n2.n_name = 'CANADA')
      )
      AND l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
) AS shipping
GROUP BY supp_nation, cust_nation, l_year
ORDER BY supp_nation, cust_nation, l_year;SELECT supp_nation, cust_nation, l_year, sum(volume) as revenue
FROM (
    SELECT n1.n_name as supp_nation, n2.n_name as cust_nation, 
           extract(year from l_shipdate) as l_year, 
           l_extendedprice * (1 - l_discount) as volume
    FROM supplier
    JOIN lineitem ON s_suppkey = l_suppkey
    JOIN orders ON o_orderkey = l_orderkey
    JOIN customer ON c_custkey = o_custkey
    JOIN nation n1 ON s_nationkey = n1.n_nationkey
    JOIN nation n2 ON c_nationkey = n2.n_nationkey
    WHERE (
          (n1.n_name = 'CANADA' AND n2.n_name = 'MOZAMBIQUE') 
          OR (n1.n_name = 'MOZAMBIQUE' AND n2.n_name = 'CANADA')
      )
      AND l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
) AS shipping
GROUP BY supp_nation, cust_nation, l_year
ORDER BY supp_nation, cust_nation, l_year;