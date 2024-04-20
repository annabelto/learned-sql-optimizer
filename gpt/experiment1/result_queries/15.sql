SELECT s.s_suppkey, s.s_name, s.s_address, s.s_phone, r.total_revenue
FROM supplier s
JOIN (
    SELECT l_suppkey AS supplier_no, SUM(l_extendedprice * (1 - l_discount)) AS total_revenue
    FROM lineitem
    WHERE l_shipdate >= date ':1' AND l_shipdate < date ':1' + interval '3 month'
    GROUP BY l_suppkey
) r ON s.s_suppkey = r.supplier_no
WHERE r.total_revenue = (
    SELECT MAX(total_revenue)
    FROM (
        SELECT SUM(l_extendedprice * (1 - l_discount)) AS total_revenue
        FROM lineitem
        WHERE l_shipdate >= date ':1' AND l_shipdate < date ':1' + interval '3 month'
        GROUP BY l_suppkey
    ) max_revenue
)
ORDER BY s.s_suppkey;