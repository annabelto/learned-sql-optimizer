explain select c_count, COUNT(*) AS custdist
FROM (
    SELECT c_custkey, COUNT(o_orderkey)
    FROM customer
    LEFT OUTER JOIN orders ON c_custkey = o_custkey AND o_comment NOT LIKE '%unusual%accounts%'
    GROUP BY c_custkey
) AS c_orders (c_custkey, c_count)
GROUP BY c_count
ORDER BY custdist DESC, c_count DESC;SELECT c_count, COUNT(*) AS custdist
FROM (
    SELECT c_custkey, COUNT(o_orderkey)
    FROM customer
    LEFT OUTER JOIN orders ON c_custkey = o_custkey AND o_comment NOT LIKE '%unusual%accounts%'
    GROUP BY c_custkey
) AS c_orders (c_custkey, c_count)
GROUP BY c_count
ORDER BY custdist DESC, c_count DESC;