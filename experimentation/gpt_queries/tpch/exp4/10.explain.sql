explain select 
    c_custkey, 
    c_name, 
    SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
    c_acctbal, 
    n_name, 
    c_address, 
    c_phone, 
    c_comment 
FROM 
    customer
JOIN 
    nation ON c_nationkey = n_nationkey
JOIN 
    orders ON c_custkey = o_custkey
JOIN 
    lineitem ON l_orderkey = o_orderkey
WHERE 
    o_orderdate >= DATE '1995-01-01' 
    AND o_orderdate < DATE '1995-01-01' + INTERVAL '3' MONTH 
    AND l_returnflag = 'R'
GROUP BY 
    c_custkey, 
    c_name, 
    c_acctbal, 
    c_phone, 
    n_name, 
    c_address, 
    c_comment 
ORDER BY 
    revenue DESC 
LIMIT 20;SELECT 
    c_custkey, 
    c_name, 
    SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
    c_acctbal, 
    n_name, 
    c_address, 
    c_phone, 
    c_comment 
FROM 
    customer
JOIN 
    nation ON c_nationkey = n_nationkey
JOIN 
    orders ON c_custkey = o_custkey
JOIN 
    lineitem ON l_orderkey = o_orderkey
WHERE 
    o_orderdate >= DATE '1995-01-01' 
    AND o_orderdate < DATE '1995-01-01' + INTERVAL '3' MONTH 
    AND l_returnflag = 'R'
GROUP BY 
    c_custkey, 
    c_name, 
    c_acctbal, 
    c_phone, 
    n_name, 
    c_address, 
    c_comment 
ORDER BY 
    revenue DESC 
LIMIT 20;