SELECT p.p_brand, p.p_type, p.p_size, COUNT(DISTINCT ps.ps_suppkey) AS supplier_cnt
FROM part p
JOIN partsupp ps ON p.p_partkey = ps.ps_partkey
WHERE p.p_brand <> 'Brand#24'
  AND p.p_type NOT LIKE 'STANDARD BURNISHED%'
  AND p.p_size IN (44, 6, 46, 36, 42, 17, 26, 18)
  AND ps.ps_suppkey NOT IN (
    SELECT s.s_suppkey 
    FROM supplier s 
    WHERE s.s_comment LIKE '%Customer%Complaints%'
  )
GROUP BY p.p_brand, p.p_type, p.p_size
ORDER BY supplier_cnt DESC, p.p_brand, p.p_type, p.p_size
LIMIT ALL;