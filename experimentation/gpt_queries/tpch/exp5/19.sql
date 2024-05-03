SELECT SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM part
JOIN lineitem ON p_partkey = l_partkey
WHERE (
    (
        p_brand = 'Brand#53' AND
        p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') AND
        l_quantity BETWEEN 10 AND 20 AND
        p_size BETWEEN 1 AND 5
    ) OR (
        p_brand = 'Brand#32' AND
        p_container IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') AND
        l_quantity BETWEEN 13 AND 23 AND
        p_size BETWEEN 1 AND 10
    ) OR (
        p_brand = 'Brand#41' AND
        p_container IN ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') AND
        l_quantity BETWEEN 23 AND 33 AND
        p_size BETWEEN 1 AND 15
    )
) AND
l_shipmode IN ('AIR', 'AIR REG') AND
l_shipinstruct = 'DELIVER IN PERSON'
LIMIT ALL;