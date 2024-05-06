-- Create a view to calculate total revenue per supplier
CREATE VIEW revenue0 (supplier_no, total_revenue) AS 
explain select l_suppkey, SUM(l_extendedprice * (1 - l_discount))
FROM lineitem
WHERE l_shipdate >= DATE '1996-07-01' AND l_shipdate < DATE '1996-07-01' + INTERVAL '3' MONTH
GROUP BY l_suppkey;

-- Select supplier details with the maximum total revenue
explain select s.s_suppkey, s.s_name, s.s_address, s.s_phone, r.total_revenue
FROM supplier s
JOIN revenue0 r ON s.s_suppkey = r.supplier_no
WHERE r.total_revenue = (
    SELECT MAX(total_revenue) FROM revenue0
)
ORDER BY s.s_suppkey
LIMIT ALL;

-- Drop the view
DROP VIEW revenue0;-- Create a view to calculate total revenue per supplier
CREATE VIEW revenue0 (supplier_no, total_revenue) AS 
SELECT l_suppkey, SUM(l_extendedprice * (1 - l_discount))
FROM lineitem
WHERE l_shipdate >= DATE '1996-07-01' AND l_shipdate < DATE '1996-07-01' + INTERVAL '3' MONTH
GROUP BY l_suppkey;

-- Select supplier details with the maximum total revenue
SELECT s.s_suppkey, s.s_name, s.s_address, s.s_phone, r.total_revenue
FROM supplier s
JOIN revenue0 r ON s.s_suppkey = r.supplier_no
WHERE r.total_revenue = (
    SELECT MAX(total_revenue) FROM revenue0
)
ORDER BY s.s_suppkey
LIMIT ALL;

-- Drop the view
DROP VIEW revenue0;