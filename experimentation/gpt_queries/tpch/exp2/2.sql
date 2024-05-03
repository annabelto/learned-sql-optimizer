SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment 
FROM part
JOIN partsupp ON p_partkey = ps_partkey
JOIN supplier ON s_suppkey = ps_suppkey
JOIN nation ON s_nationkey = n_nationkey
JOIN region ON n_regionkey = r_regionkey
WHERE p_size = 16 
  AND p_type LIKE '%NICKEL' 
  AND r_name = 'EUROPE' 
  AND ps_supplycost = (
    SELECT MIN(ps_supplycost) 
    FROM partsupp
    JOIN supplier ON s_suppkey = ps_suppkey
    JOIN nation ON s_nationkey = n_nationkey
    JOIN region ON n_regionkey = r_regionkey
    WHERE p_partkey = ps_partkey 
      AND r_name = 'EUROPE'
  ) 
ORDER BY s_acctbal DESC, n_name, s_name, p_partkey;