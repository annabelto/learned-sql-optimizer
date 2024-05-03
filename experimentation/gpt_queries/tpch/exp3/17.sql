SELECT 
    (SUM(l.l_extendedprice) / 7.0) AS avg_yearly 
FROM 
    lineitem l
JOIN 
    part p ON p.p_partkey = l.l_partkey
WHERE 
    p.p_brand = 'Brand#41' 
    AND p.p_container = 'WRAP BAG' 
    AND l.l_quantity < (SELECT 0.2 * AVG(l_quantity) FROM lineitem WHERE l_partkey = p.p_partkey)