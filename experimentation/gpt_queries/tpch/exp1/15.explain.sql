WITH revenue0 AS (
    SELECT 
        l_suppkey AS supplier_no, 
        SUM(l_extendedprice * (1 - l_discount)) AS total_revenue
    FROM 
        lineitem
    WHERE 
        l_shipdate >= DATE '1996-07-01' 
        AND l_shipdate < DATE '1996-07-01' + INTERVAL '3 months'
    GROUP BY 
        l_suppkey
)
explain select 
    s_suppkey, 
    s_name, 
    s_address, 
    s_phone, 
    r.total_revenue
FROM 
    supplier s
JOIN 
    revenue0 r ON s.s_suppkey = r.supplier_no
WHERE 
    r.total_revenue = (SELECT MAX(total_revenue) FROM revenue0)
ORDER BY 
    s_suppkey;WITH revenue0 AS (
    SELECT 
        l_suppkey AS supplier_no, 
        SUM(l_extendedprice * (1 - l_discount)) AS total_revenue
    FROM 
        lineitem
    WHERE 
        l_shipdate >= DATE '1996-07-01' 
        AND l_shipdate < DATE '1996-07-01' + INTERVAL '3 months'
    GROUP BY 
        l_suppkey
)
SELECT 
    s_suppkey, 
    s_name, 
    s_address, 
    s_phone, 
    r.total_revenue
FROM 
    supplier s
JOIN 
    revenue0 r ON s.s_suppkey = r.supplier_no
WHERE 
    r.total_revenue = (SELECT MAX(total_revenue) FROM revenue0)
ORDER BY 
    s_suppkey;