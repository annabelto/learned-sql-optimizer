explain select 
    l.l_shipmode, 
    (SELECT COUNT(*) FROM orders o WHERE o.o_orderkey = l.l_orderkey AND (o.o_orderpriority = '1-URGENT' OR o.o_orderpriority = '2-HIGH')) AS high_line_count,
    (SELECT COUNT(*) FROM orders o WHERE o.o_orderkey = l.l_orderkey AND o.o_orderpriority <> '1-URGENT' AND o.o_orderpriority <> '2-HIGH') AS low_line_count
FROM 
    lineitem l
JOIN 
    orders o ON o.o_orderkey = l.l_orderkey
WHERE 
    l.l_shipmode IN ('RAIL', 'TRUCK') 
    AND l.l_shipdate < l.l_commitdate 
    AND l.l_receiptdate BETWEEN date '1995-01-01' AND date '1995-01-01' + interval '1' year
GROUP BY 
    l.l_shipmode 
ORDER BY 
    l.l_shipmode;SELECT 
    l.l_shipmode, 
    (SELECT COUNT(*) FROM orders o WHERE o.o_orderkey = l.l_orderkey AND (o.o_orderpriority = '1-URGENT' OR o.o_orderpriority = '2-HIGH')) AS high_line_count,
    (SELECT COUNT(*) FROM orders o WHERE o.o_orderkey = l.l_orderkey AND o.o_orderpriority <> '1-URGENT' AND o.o_orderpriority <> '2-HIGH') AS low_line_count
FROM 
    lineitem l
JOIN 
    orders o ON o.o_orderkey = l.l_orderkey
WHERE 
    l.l_shipmode IN ('RAIL', 'TRUCK') 
    AND l.l_shipdate < l.l_commitdate 
    AND l.l_receiptdate BETWEEN date '1995-01-01' AND date '1995-01-01' + interval '1' year
GROUP BY 
    l.l_shipmode 
ORDER BY 
    l.l_shipmode;