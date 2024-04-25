explain select 
    supp_nation, 
    cust_nation, 
    l_year, 
    SUM(volume) AS revenue 
FROM 
    (
        SELECT 
            n1.n_name AS supp_nation, 
            n2.n_name AS cust_nation, 
            EXTRACT(YEAR FROM l_shipdate) AS l_year, 
            l_extendedprice * (1 - l_discount) AS volume 
        FROM 
            lineitem 
        JOIN 
            supplier ON s_suppkey = l_suppkey 
        JOIN 
            nation n1 ON s_nationkey = n1.n_nationkey 
        JOIN 
            orders ON o_orderkey = l_orderkey 
        JOIN 
            customer ON c_custkey = o_custkey 
        JOIN 
            nation n2 ON c_nationkey = n2.n_nationkey 
        WHERE 
            l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
            AND 
            (
                (n1.n_name = 'CANADA' AND n2.n_name = 'MOZAMBIQUE') 
                OR 
                (n1.n_name = 'MOZAMBIQUE' AND n2.n_name = 'CANADA')
            )
    ) AS shipping 
GROUP BY 
    supp_nation, 
    cust_nation, 
    l_year 
ORDER BY 
    supp_nation, 
    cust_nation, 
    l_year 
LIMIT ALL;SELECT 
    supp_nation, 
    cust_nation, 
    l_year, 
    SUM(volume) AS revenue 
FROM 
    (
        SELECT 
            n1.n_name AS supp_nation, 
            n2.n_name AS cust_nation, 
            EXTRACT(YEAR FROM l_shipdate) AS l_year, 
            l_extendedprice * (1 - l_discount) AS volume 
        FROM 
            lineitem 
        JOIN 
            supplier ON s_suppkey = l_suppkey 
        JOIN 
            nation n1 ON s_nationkey = n1.n_nationkey 
        JOIN 
            orders ON o_orderkey = l_orderkey 
        JOIN 
            customer ON c_custkey = o_custkey 
        JOIN 
            nation n2 ON c_nationkey = n2.n_nationkey 
        WHERE 
            l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
            AND 
            (
                (n1.n_name = 'CANADA' AND n2.n_name = 'MOZAMBIQUE') 
                OR 
                (n1.n_name = 'MOZAMBIQUE' AND n2.n_name = 'CANADA')
            )
    ) AS shipping 
GROUP BY 
    supp_nation, 
    cust_nation, 
    l_year 
ORDER BY 
    supp_nation, 
    cust_nation, 
    l_year 
LIMIT ALL;