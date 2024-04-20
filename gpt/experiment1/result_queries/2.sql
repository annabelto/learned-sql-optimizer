WITH MinCost AS (
    SELECT ps_partkey, MIN(ps_supplycost) AS min_supplycost
    FROM partsupp, supplier, nation, region
    WHERE s_suppkey = ps_suppkey
      AND s_nationkey = n_nationkey
      AND n_regionkey = r_regionkey
      AND r_name = ':3'
    GROUP BY ps_partkey
)
SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment
FROM part
JOIN partsupp ON part.p_partkey = partsupp.ps_partkey
JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey
JOIN nation ON supplier.s_nationkey = nation.n_nationkey
JOIN region ON nation.n_regionkey = region.r_regionkey
JOIN MinCost ON part.p_partkey = MinCost.ps_partkey AND partsupp.ps_supplycost = MinCost.min_supplycost
WHERE part.p_size = :1
  AND part.p_type LIKE '%:2'
  AND region.r_name = ':3'
ORDER BY s_acctbal DESC, n_name, s_name, p_partkey;