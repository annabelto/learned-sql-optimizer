explain select SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM part
JOIN lineitem ON part.p_partkey = lineitem.l_partkey
WHERE (
    (part.p_brand = 'Brand#53' AND part.p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') AND
     lineitem.l_quantity BETWEEN 10 AND 20 AND part.p_size BETWEEN 1 AND 5 AND
     lineitem.l_shipmode IN ('AIR', 'AIR REG') AND lineitem.l_shipinstruct = 'DELIVER IN PERSON')
  OR
    (part.p_brand = 'Brand#32' AND part.p_container IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') AND
     lineitem.l_quantity BETWEEN 13 AND 23 AND part.p_size BETWEEN 1 AND 10 AND
     lineitem.l_shipmode IN ('AIR', 'AIR REG') AND lineitem.l_shipinstruct = 'DELIVER IN PERSON')
  OR
    (part.p_brand = 'Brand#41' AND part.p_container IN ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') AND
     lineitem.l_quantity BETWEEN 23 AND 33 AND part.p_size BETWEEN 1 AND 15 AND
     lineitem.l_shipmode IN ('AIR', 'AIR REG') AND lineitem.l_shipinstruct = 'DELIVER IN PERSON')
)
LIMIT ALL;SELECT SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM part
JOIN lineitem ON part.p_partkey = lineitem.l_partkey
WHERE (
    (part.p_brand = 'Brand#53' AND part.p_container IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') AND
     lineitem.l_quantity BETWEEN 10 AND 20 AND part.p_size BETWEEN 1 AND 5 AND
     lineitem.l_shipmode IN ('AIR', 'AIR REG') AND lineitem.l_shipinstruct = 'DELIVER IN PERSON')
  OR
    (part.p_brand = 'Brand#32' AND part.p_container IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') AND
     lineitem.l_quantity BETWEEN 13 AND 23 AND part.p_size BETWEEN 1 AND 10 AND
     lineitem.l_shipmode IN ('AIR', 'AIR REG') AND lineitem.l_shipinstruct = 'DELIVER IN PERSON')
  OR
    (part.p_brand = 'Brand#41' AND part.p_container IN ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') AND
     lineitem.l_quantity BETWEEN 23 AND 33 AND part.p_size BETWEEN 1 AND 15 AND
     lineitem.l_shipmode IN ('AIR', 'AIR REG') AND lineitem.l_shipinstruct = 'DELIVER IN PERSON')
)
LIMIT ALL;