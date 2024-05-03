-- Ensure the following indexes are in place for optimal performance:
-- CREATE INDEX idx_orders_date ON orders(o_orderdate);
-- CREATE INDEX idx_lineitem_orderkey ON lineitem(l_orderkey);
-- CREATE INDEX idx_lineitem_commit_receipt ON lineitem(l_commitdate, l_receiptdate);

explain select o_orderpriority, count(*) AS order_count
FROM orders
WHERE o_orderdate >= date '1996-01-01'
  AND o_orderdate < date '1996-04-01'  -- Pre-computed date
  AND EXISTS (
    SELECT 1
    FROM lineitem
    WHERE l_orderkey = orders.o_orderkey
      AND l_commitdate < l_receiptdate
  )
GROUP BY o_orderpriority
ORDER BY o_orderpriority
LIMIT ALL;-- Ensure the following indexes are in place for optimal performance:
-- CREATE INDEX idx_orders_date ON orders(o_orderdate);
-- CREATE INDEX idx_lineitem_orderkey ON lineitem(l_orderkey);
-- CREATE INDEX idx_lineitem_commit_receipt ON lineitem(l_commitdate, l_receiptdate);

SELECT o_orderpriority, count(*) AS order_count
FROM orders
WHERE o_orderdate >= date '1996-01-01'
  AND o_orderdate < date '1996-04-01'  -- Pre-computed date
  AND EXISTS (
    SELECT 1
    FROM lineitem
    WHERE l_orderkey = orders.o_orderkey
      AND l_commitdate < l_receiptdate
  )
GROUP BY o_orderpriority
ORDER BY o_orderpriority
LIMIT ALL;