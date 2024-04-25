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
            EXTRACT(year FROM l.l_shipdate) AS l_year, 
            l.l_extendedprice * (1 - l.l_discount) AS volume
        FROM 
            supplier AS s
        JOIN 
            nation AS n1 ON s.s_nationkey = n1.n_nationkey
        JOIN 
            lineitem AS l ON s.s_suppkey = l.l_suppkey
        JOIN 
            orders AS o ON l.l_orderkey = o.o_orderkey
        JOIN 
            customer AS c ON o.o_custkey = c.c_custkey
        JOIN 
            nation AS n2 ON c.c_nationkey = n2.n_nationkey
        WHERE 
            l.l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
            AND ((n1.n_name = 'CANADA' AND n2.n_name = 'MOZAMBIQUE') OR (n1.n_name = 'MOZAMBIQUE' AND n2.n_name = 'CANADA'))
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
            EXTRACT(year FROM l.l_shipdate) AS l_year, 
            l.l_extendedprice * (1 - l.l_discount) AS volume
        FROM 
            supplier AS s
        JOIN 
            nation AS n1 ON s.s_nationkey = n1.n_nationkey
        JOIN 
            lineitem AS l ON s.s_suppkey = l.l_suppkey
        JOIN 
            orders AS o ON l.l_orderkey = o.o_orderkey
        JOIN 
            customer AS c ON o.o_custkey = c.c_custkey
        JOIN 
            nation AS n2 ON c.c_nationkey = n2.n_nationkey
        WHERE 
            l.l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
            AND ((n1.n_name = 'CANADA' AND n2.n_name = 'MOZAMBIQUE') OR (n1.n_name = 'MOZAMBIQUE' AND n2.n_name = 'CANADA'))
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