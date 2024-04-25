explain select 
    o_year, 
    sum(case when nation = 'MOZAMBIQUE' then volume else 0 end) as mozambique_volume,
    sum(volume) as total_volume
FROM 
    (
        SELECT 
            extract(year from o_orderdate) as o_year, 
            l_extendedprice * (1 - l_discount) as volume, 
            n2.n_name as nation 
        FROM 
            part
        JOIN 
            lineitem ON p_partkey = l_partkey
        JOIN 
            orders ON l_orderkey = o_orderkey
        JOIN 
            (
                SELECT 
                    c_custkey, 
                    n1.n_nationkey 
                FROM 
                    customer
                JOIN 
                    nation n1 ON c_nationkey = n1.n_nationkey
                JOIN 
                    region ON n1.n_regionkey = r_regionkey
                WHERE 
                    r_name = 'AFRICA'
            ) sub1 ON o_custkey = sub1.c_custkey
        JOIN 
            (
                SELECT 
                    s_suppkey, 
                    n2.n_name 
                FROM 
                    supplier
                JOIN 
                    nation n2 ON s_nationkey = n2.n_nationkey
            ) sub2 ON l_suppkey = sub2.s_suppkey
        WHERE 
            o_orderdate between date '1995-01-01' and date '1996-12-31' 
            AND p_type = 'PROMO BRUSHED BRASS'
    ) as all_nations 
GROUP BY 
    o_year 
ORDER BY 
    o_year 
LIMIT ALL;SELECT 
    o_year, 
    sum(case when nation = 'MOZAMBIQUE' then volume else 0 end) as mozambique_volume,
    sum(volume) as total_volume
FROM 
    (
        SELECT 
            extract(year from o_orderdate) as o_year, 
            l_extendedprice * (1 - l_discount) as volume, 
            n2.n_name as nation 
        FROM 
            part
        JOIN 
            lineitem ON p_partkey = l_partkey
        JOIN 
            orders ON l_orderkey = o_orderkey
        JOIN 
            (
                SELECT 
                    c_custkey, 
                    n1.n_nationkey 
                FROM 
                    customer
                JOIN 
                    nation n1 ON c_nationkey = n1.n_nationkey
                JOIN 
                    region ON n1.n_regionkey = r_regionkey
                WHERE 
                    r_name = 'AFRICA'
            ) sub1 ON o_custkey = sub1.c_custkey
        JOIN 
            (
                SELECT 
                    s_suppkey, 
                    n2.n_name 
                FROM 
                    supplier
                JOIN 
                    nation n2 ON s_nationkey = n2.n_nationkey
            ) sub2 ON l_suppkey = sub2.s_suppkey
        WHERE 
            o_orderdate between date '1995-01-01' and date '1996-12-31' 
            AND p_type = 'PROMO BRUSHED BRASS'
    ) as all_nations 
GROUP BY 
    o_year 
ORDER BY 
    o_year 
LIMIT ALL;