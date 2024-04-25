SELECT 
    100.00 * SUM(
        CASE 
            WHEN p.p_type LIKE 'PROMO%' THEN l.l_extendedprice * (1 - l.l_discount) 
            ELSE 0 
        END
    ) / SUM(l.l_extendedprice * (1 - l.l_discount)) AS promo_revenue
FROM 
    lineitem l
JOIN 
    part p ON l.l_partkey = p.p_partkey
WHERE 
    l.l_shipdate >= DATE '1995-10-01' 
    AND l.l_shipdate < DATE '1995-10-01' + INTERVAL '1 month'
LIMIT ALL;