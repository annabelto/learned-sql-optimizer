SELECT p_brand, p_type, p_size, COUNT(DISTINCT ps_suppkey) AS supplier_cnt
FROM partsupp
JOIN part ON p_partkey = ps_partkey
WHERE p_brand <> 'Brand#24'
  AND p_type NOT LIKE 'STANDARD BURNISHED%'
  AND p_size IN (44, 6, 46, 36, 42, 17, 26, 18)
  AND NOT EXISTS (
    SELECT 1
    FROM supplier
    WHERE s_suppkey = ps_suppkey
      AND s_comment LIKE '%Customer%Complaints%'
  )
GROUP BY p_brand, p_type, p_size
ORDER BY supplier_cnt DESC, p_brand, p_type, p_size;