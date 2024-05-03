WITH revenue0 AS (
    SELECT l_suppkey AS supplier_no, 
           SUM(l_extendedprice * (1 - l_discount)) AS total_revenue 
    FROM lineitem 
    WHERE l_shipdate >= DATE '1996-07-01' 
          AND l_shipdate < DATE '1996-07-01' + INTERVAL '3' MONTH 
    GROUP BY l_suppkey
), max_revenue AS (
    SELECT MAX(total_revenue) AS max_revenue 
    FROM revenue0
)
explain select s.s_suppkey, 
       s.s_name, 
       s.s_address, 
       s.s_phone, 
       r.total_revenue 
FROM supplier s 
JOIN revenue0 r ON s.s_suppkey = r.supplier_no 
JOIN max_revenue m ON r.total_revenue = m.max_revenue 
ORDER BY s.s_suppkey;WITH revenue0 AS (
    SELECT l_suppkey AS supplier_no, 
           SUM(l_extendedprice * (1 - l_discount)) AS total_revenue 
    FROM lineitem 
    WHERE l_shipdate >= DATE '1996-07-01' 
          AND l_shipdate < DATE '1996-07-01' + INTERVAL '3' MONTH 
    GROUP BY l_suppkey
), max_revenue AS (
    SELECT MAX(total_revenue) AS max_revenue 
    FROM revenue0
)
SELECT s.s_suppkey, 
       s.s_name, 
       s.s_address, 
       s.s_phone, 
       r.total_revenue 
FROM supplier s 
JOIN revenue0 r ON s.s_suppkey = r.supplier_no 
JOIN max_revenue m ON r.total_revenue = m.max_revenue 
ORDER BY s.s_suppkey;