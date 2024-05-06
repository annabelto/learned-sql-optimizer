SELECT 100.00 * SUM(
    CASE 
        WHEN p_type LIKE 'PROMO%' THEN l_extendedprice * (1 - l_discount) 
        ELSE 0 
    END
) / SUM(l_extendedprice * (1 - l_discount)) AS promo_revenue
FROM lineitem
INNER JOIN part ON lineitem.l_partkey = part.p_partkey
WHERE lineitem.l_shipdate >= DATE '1995-10-01'
AND lineitem.l_shipdate < DATE '1995-10-01' + INTERVAL '1 month';