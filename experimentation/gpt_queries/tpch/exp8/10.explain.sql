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
    orders ON customer.c_custkey = orders.o_custkey
    AND orders.o_orderdate >= DATE '1995-01-01' 
    AND orders.o_orderdate < DATE '1995-01-01' + INTERVAL '3' month
JOIN 
    lineitem ON orders.o_orderkey = lineitem.l_orderkey
    AND lineitem.l_returnflag = 'R'
JOIN 
    nation ON customer.c_nationkey = nation.n_nationkey
GROUP BY 
    c_custkey, 
    c_name, 
    c_acctbal, 
    n_name, 
    c_address, 
    c_phone, 
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
    orders ON customer.c_custkey = orders.o_custkey
    AND orders.o_orderdate >= DATE '1995-01-01' 
    AND orders.o_orderdate < DATE '1995-01-01' + INTERVAL '3' month
JOIN 
    lineitem ON orders.o_orderkey = lineitem.l_orderkey
    AND lineitem.l_returnflag = 'R'
JOIN 
    nation ON customer.c_nationkey = nation.n_nationkey
GROUP BY 
    c_custkey, 
    c_name, 
    c_acctbal, 
    n_name, 
    c_address, 
    c_phone, 
    c_comment 
ORDER BY 
    revenue DESC 
LIMIT 20;