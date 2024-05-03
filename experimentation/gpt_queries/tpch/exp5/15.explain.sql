-- Using a Common Table Expression (CTE) for the revenue calculation
WITH revenue0 AS (
    SELECT 
        l_suppkey AS supplier_no, 
        SUM(l_extendedprice * (1 - l_discount)) AS total_revenue
    FROM 
        lineitem
    WHERE 
        l_shipdate >= DATE '1996-07-01' AND 
        l_shipdate < DATE '1996-07-01' + INTERVAL '3' month
    GROUP BY 
        l_suppkey
)

-- Selecting suppliers with the maximum total revenue
explain select 
    s.s_suppkey, 
    s.s_name, 
    s.s_address, 
    s.s_phone, 
    r.total_revenue
FROM 
    supplier s
JOIN 
    revenue0 r ON s.s_suppkey = r.supplier_no
WHERE 
    r.total_revenue = (SELECT MAX(total_revenue) FROM revenue0)
ORDER BY 
    s.s_suppkey;-- Using a Common Table Expression (CTE) for the revenue calculation
WITH revenue0 AS (
    SELECT 
        l_suppkey AS supplier_no, 
        SUM(l_extendedprice * (1 - l_discount)) AS total_revenue
    FROM 
        lineitem
    WHERE 
        l_shipdate >= DATE '1996-07-01' AND 
        l_shipdate < DATE '1996-07-01' + INTERVAL '3' month
    GROUP BY 
        l_suppkey
)

-- Selecting suppliers with the maximum total revenue
SELECT 
    s.s_suppkey, 
    s.s_name, 
    s.s_address, 
    s.s_phone, 
    r.total_revenue
FROM 
    supplier s
JOIN 
    revenue0 r ON s.s_suppkey = r.supplier_no
WHERE 
    r.total_revenue = (SELECT MAX(total_revenue) FROM revenue0)
ORDER BY 
    s.s_suppkey;