WITH min_supplycost AS (
    SELECT 
        MIN(ps_supplycost) AS min_cost 
    FROM 
        partsupp 
        JOIN supplier ON s_suppkey = ps_suppkey 
        JOIN nation ON s_nationkey = n_nationkey 
        JOIN region ON n_regionkey = r_regionkey 
    WHERE 
        r_name = 'EUROPE'
)
explain select 
    s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment 
FROM 
    part 
    JOIN partsupp ON p_partkey = ps_partkey 
    JOIN supplier ON s_suppkey = ps_suppkey 
    JOIN nation ON s_nationkey = n_nationkey 
    JOIN region ON n_regionkey = r_regionkey 
    JOIN min_supplycost ON ps_supplycost = min_cost
WHERE 
    p_size = 16 
    AND p_type LIKE '%NICKEL' 
    AND r_name = 'EUROPE' 
ORDER BY 
    s_acctbal DESC, n_name, s_name, p_partkey;WITH min_supplycost AS (
    SELECT 
        MIN(ps_supplycost) AS min_cost 
    FROM 
        partsupp 
        JOIN supplier ON s_suppkey = ps_suppkey 
        JOIN nation ON s_nationkey = n_nationkey 
        JOIN region ON n_regionkey = r_regionkey 
    WHERE 
        r_name = 'EUROPE'
)
SELECT 
    s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment 
FROM 
    part 
    JOIN partsupp ON p_partkey = ps_partkey 
    JOIN supplier ON s_suppkey = ps_suppkey 
    JOIN nation ON s_nationkey = n_nationkey 
    JOIN region ON n_regionkey = r_regionkey 
    JOIN min_supplycost ON ps_supplycost = min_cost
WHERE 
    p_size = 16 
    AND p_type LIKE '%NICKEL' 
    AND r_name = 'EUROPE' 
ORDER BY 
    s_acctbal DESC, n_name, s_name, p_partkey;