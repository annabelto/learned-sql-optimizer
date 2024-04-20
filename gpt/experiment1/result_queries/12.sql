SELECT 
    l_shipmode, 
    SUM(CASE WHEN o_orderpriority IN ('1-URGENT', '2-HIGH') THEN 1 ELSE 0 END) AS high_line_count,
    SUM(CASE WHEN o_orderpriority NOT IN ('1-URGENT', '2-HIGH') THEN 1 ELSE 0 END) AS low_line_count
FROM 
    orders
JOIN 
    lineitem ON o_orderkey = l_orderkey
WHERE 
    l_shipmode IN (':1', ':2') AND
    l_commitdate < l_receiptdate AND
    l_shipdate < l_commitdate AND
    l_receiptdate BETWEEN date ':3' AND date ':3' + interval '1 year' - interval '1 day'
GROUP BY 
    l_shipmode
ORDER BY 
    l_shipmode;