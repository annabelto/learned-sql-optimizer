select c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, sum(l_quantity)
from customer
join orders on c_custkey = o_custkey
join lineitem on o_orderkey = l_orderkey
join (
    select l_orderkey
    from lineitem
    group by l_orderkey
    having sum(l_quantity) > 313
) as filtered_lineitems on o_orderkey = filtered_lineitems.l_orderkey
group by c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice
order by o_totalprice desc, o_orderdate;