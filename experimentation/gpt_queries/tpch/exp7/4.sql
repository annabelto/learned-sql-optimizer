select o_orderpriority, count(distinct orders.o_orderkey) as order_count
from orders
join lineitem on lineitem.l_orderkey = orders.o_orderkey
  and lineitem.l_commitdate < lineitem.l_receiptdate
where orders.o_orderdate >= date '1996-01-01'
  and orders.o_orderdate < date '1996-01-01' + interval '3' month
group by o_orderpriority
order by o_orderpriority
LIMIT ALL;