SELECT 
    c.c_name, 
    c.c_custkey, 
    o.o_orderkey, 
    o.o_orderdate, 
    o.o_totalprice, 
    SUM(l.l_quantity)
FROM 
    customer c
JOIN 
    orders o ON c.c_custkey = o.o_custkey
JOIN 
    lineitem l ON o.o_orderkey = l.l_orderkey
JOIN 
    (
        SELECT 
            l_orderkey, 
            SUM(l_quantity) AS total_quantity
        FROM 
            lineitem
        GROUP BY 
            l_orderkey
        HAVING 
            SUM(l_quantity) > 313
    ) AS subq ON o.o_orderkey = subq.l_orderkey
GROUP BY 
    c.c_name, 
    c.c_custkey, 
    o.o_orderkey, 
    o.o_orderdate, 
    o.o_totalprice
ORDER BY 
    o.o_totalprice DESC, 
    o.o_orderdate;