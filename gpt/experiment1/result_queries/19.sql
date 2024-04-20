SELECT SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM lineitem
JOIN (
    SELECT p_partkey
    FROM part
    WHERE (p_brand = ':1' AND p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') AND p_size BETWEEN 1 AND 5)
       OR (p_brand = ':2' AND p_container IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') AND p_size BETWEEN 1 AND 10)
       OR (p_brand = ':3' AND p_container IN ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') AND p_size BETWEEN 1 AND 15)
) AS p ON p.p_partkey = lineitem.l_partkey
WHERE (l_quantity >= :4 AND l_quantity <= :4 + 10 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON')
   OR (l_quantity >= :5 AND l_quantity <= :5 + 10 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON')
   OR (l_quantity >= :6 AND l_quantity <= :6 + 10 AND l_shipmode IN ('AIR', 'AIR REG') AND l_shipinstruct = 'DELIVER IN PERSON');