select o_year, 
       sum(case when nation = 'MOZAMBIQUE' then volume else 0 end) / sum(volume) as mkt_share 
from (
    select extract(year from o.o_orderdate) as o_year, 
           l.l_extendedprice * (1 - l.l_discount) as volume, 
           n2.n_name as nation 
    from part p
    join lineitem l on p.p_partkey = l.l_partkey
    join orders o on l.l_orderkey = o.o_orderkey
    join customer c on o.o_custkey = c.c_custkey
    join nation n1 on c.c_nationkey = n1.n_nationkey
    join region r on n1.n_regionkey = r.r_regionkey
    join supplier s on l.l_suppkey = s.s_suppkey
    join nation n2 on s.s_nationkey = n2.n_nationkey
    where r.r_name = 'AFRICA'
      and o.o_orderdate between date '1995-01-01' and date '1996-12-31'
      and p.p_type = 'PROMO BRUSHED BRASS'
) as all_nations 
group by o_year 
order by o_year 
LIMIT ALL;