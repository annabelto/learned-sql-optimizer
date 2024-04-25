SELECT 
    n_name, 
    SUM(l_extendedprice * (1 - l_discount)) AS revenue 
FROM 
    region 
JOIN 
    nation ON n_regionkey = r_regionkey 
JOIN 
    supplier ON s_nationkey = n_nationkey 
JOIN 
    customer ON c_nationkey = s_nationkey 
JOIN 
    orders ON c_custkey = o_custkey 
JOIN 
    lineitem ON l_orderkey = o_orderkey AND l_suppkey = s_suppkey 
WHERE 
    r_name = 'MIDDLE EAST' 
    AND o_orderdate >= DATE '1995-01-01' 
    AND o_orderdate < DATE '1995-01-01' + INTERVAL '1' year 
GROUP BY 
    n_name 
ORDER BY 
    revenue DESC 
LIMIT ALL;