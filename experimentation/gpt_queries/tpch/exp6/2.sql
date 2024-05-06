SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment
FROM part
JOIN partsupp ON part.p_partkey = partsupp.ps_partkey
JOIN (
    SELECT ps_partkey, min(ps_supplycost) as min_supplycost
    FROM partsupp
    JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey
    JOIN nation ON supplier.s_nationkey = nation.n_nationkey
    JOIN region ON nation.n_regionkey = region.r_regionkey
    WHERE region.r_name = 'EUROPE'
    GROUP BY ps_partkey
) AS min_cost ON partsupp.ps_partkey = min_cost.ps_partkey AND partsupp.ps_supplycost = min_cost.min_supplycost
JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey
JOIN nation ON supplier.s_nationkey = nation.n_nationkey
JOIN region ON nation.n_regionkey = region.r_regionkey
WHERE part.p_size = 16
AND part.p_type LIKE '%NICKEL'
AND region.r_name = 'EUROPE'
ORDER BY s_acctbal DESC, n_name, s_name, p_partkey
LIMIT ALL;