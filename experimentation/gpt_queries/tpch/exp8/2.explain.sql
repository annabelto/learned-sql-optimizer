explain select 
    s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment 
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
            MIN(part_supp.ps_supplycost)
        FROM 
            partsupp AS part_supp
        JOIN 
            supplier AS supp ON part_supp.ps_suppkey = supp.s_suppkey
        JOIN 
            nation AS nat ON supp.s_nationkey = nat.n_nationkey
        JOIN 
            region AS reg ON nat.n_regionkey = reg.r_regionkey
        WHERE 
            reg.r_name = 'EUROPE'
            AND part_supp.ps_partkey = part.p_partkey
    )
ORDER BY 
    s_acctbal DESC, n_name, s_name, p_partkey 
LIMIT ALL;SELECT 
    s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment 
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
            MIN(part_supp.ps_supplycost)
        FROM 
            partsupp AS part_supp
        JOIN 
            supplier AS supp ON part_supp.ps_suppkey = supp.s_suppkey
        JOIN 
            nation AS nat ON supp.s_nationkey = nat.n_nationkey
        JOIN 
            region AS reg ON nat.n_regionkey = reg.r_regionkey
        WHERE 
            reg.r_name = 'EUROPE'
            AND part_supp.ps_partkey = part.p_partkey
    )
ORDER BY 
    s_acctbal DESC, n_name, s_name, p_partkey 
LIMIT ALL;