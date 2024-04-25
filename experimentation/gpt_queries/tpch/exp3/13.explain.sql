select c_count, count(*) as custdist 
from (
    select c_custkey, count(o_orderkey) 
    from customer 
    inner join orders on c_custkey = o_custkey 
    where o_comment not like '%unusual%accounts%' 
    group by c_custkey
) as c_orders (c_custkey, c_count) 
group by c_count 
order by custdist desc, c_count desc;select c_count, count(*) as custdist 
from (
    select c_custkey, count(o_orderkey) 
    from customer 
    inner join orders on c_custkey = o_custkey 
    where o_comment not like '%unusual%accounts%' 
    group by c_custkey
) as c_orders (c_custkey, c_count) 
group by c_count 
order by custdist desc, c_count desc;