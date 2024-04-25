explain select n_name, 
       SUM(l_extendedprice * (1 - l_discount)) AS revenue 
FROM customer 
JOIN orders ON c_custkey = o_custkey 
JOIN lineitem ON l_orderkey = o_orderkey 
JOIN supplier ON l_suppkey = s_suppkey AND c_nationkey = s_nationkey 
JOIN nation ON s_nationkey = n_nationkey 
JOIN region ON n_regionkey = r_regionkey 
WHERE r_name = 'MIDDLE EAST' 
AND o_orderdate >= DATE '1995-01-01' 
AND o_orderdate < DATE '1995-01-01' + INTERVAL '1' YEAR 
GROUP BY n_name 
ORDER BY revenue DESC;SELECT n_name, 
       SUM(l_extendedprice * (1 - l_discount)) AS revenue 
FROM customer 
JOIN orders ON c_custkey = o_custkey 
JOIN lineitem ON l_orderkey = o_orderkey 
JOIN supplier ON l_suppkey = s_suppkey AND c_nationkey = s_nationkey 
JOIN nation ON s_nationkey = n_nationkey 
JOIN region ON n_regionkey = r_regionkey 
WHERE r_name = 'MIDDLE EAST' 
AND o_orderdate >= DATE '1995-01-01' 
AND o_orderdate < DATE '1995-01-01' + INTERVAL '1' YEAR 
GROUP BY n_name 
ORDER BY revenue DESC;