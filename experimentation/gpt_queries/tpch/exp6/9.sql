select nation, o_year, sum(amount) as sum_profit
from (
    select n.n_name as nation, extract(year from o.o_orderdate) as o_year, 
           l.l_extendedprice * (1 - l.l_discount) - ps.ps_supplycost * l.l_quantity as amount
    from nation n
    join supplier s on s.s_nationkey = n.n_nationkey
    join partsupp ps on s.s_suppkey = ps.ps_suppkey
    join lineitem l on l.l_suppkey = ps.ps_suppkey and l.l_partkey = ps.ps_partkey
    join orders o on o.o_orderkey = l.l_orderkey
    join part p on p.p_partkey = l.l_partkey
    where p.p_name like '%white%'
) as profit
group by nation, o_year
order by nation, o_year desc
LIMIT ALL;