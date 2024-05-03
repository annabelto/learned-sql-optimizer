explain select 
    s_acctbal, 
    s_name, 
    n_name, 
    p_partkey, 
    p_mfgr, 
    s_address, 
    s_phone, 
    s_comment 
FROM 
    part
JOIN 
    partsupp ON part.p_partkey = partsupp.ps_partkey
JOIN 
    supplier ON partsupp.ps_suppkey = supplier.s_suppkey
JOIN 
    nation ON supplier.s_nationkey = nation.n_nationkey
JOIN 
    region ON nation.n_regionkey = region.r_regionkey
WHERE 
    part.p_size = 16 
    AND part.p_type LIKE '%NICKEL'
    AND region.r_name = 'EUROPE'
    AND partsupp.ps_supplycost = (
        SELECT 
            MIN(psupp.ps_supplycost)
        FROM 
            partsupp psupp
        JOIN 
            supplier s ON psupp.ps_suppkey = s.s_suppkey
        JOIN 
            nation n ON s.s_nationkey = n.n_nationkey
        JOIN 
            region r ON n.n_regionkey = r.r_regionkey
        WHERE 
            r.r_name = 'EUROPE'
            AND psupp.ps_partkey = part.p_partkey
    )
ORDER BY 
    s_acctbal DESC, 
    n_name, 
    s_name, 
    p_partkey 
LIMIT ALL;SELECT 
    s_acctbal, 
    s_name, 
    n_name, 
    p_partkey, 
    p_mfgr, 
    s_address, 
    s_phone, 
    s_comment 
FROM 
    part
JOIN 
    partsupp ON part.p_partkey = partsupp.ps_partkey
JOIN 
    supplier ON partsupp.ps_suppkey = supplier.s_suppkey
JOIN 
    nation ON supplier.s_nationkey = nation.n_nationkey
JOIN 
    region ON nation.n_regionkey = region.r_regionkey
WHERE 
    part.p_size = 16 
    AND part.p_type LIKE '%NICKEL'
    AND region.r_name = 'EUROPE'
    AND partsupp.ps_supplycost = (
        SELECT 
            MIN(psupp.ps_supplycost)
        FROM 
            partsupp psupp
        JOIN 
            supplier s ON psupp.ps_suppkey = s.s_suppkey
        JOIN 
            nation n ON s.s_nationkey = n.n_nationkey
        JOIN 
            region r ON n.n_regionkey = r.r_regionkey
        WHERE 
            r.r_name = 'EUROPE'
            AND psupp.ps_partkey = part.p_partkey
    )
ORDER BY 
    s_acctbal DESC, 
    n_name, 
    s_name, 
    p_partkey 
LIMIT ALL;