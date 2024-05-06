select supp_nation, cust_nation, l_year, sum(volume) as revenue
from (
    select n1.n_name as supp_nation, n2.n_name as cust_nation, extract(year from l_shipdate) as l_year, l_extendedprice * (1 - l_discount) as volume
    from supplier
    join lineitem on s_suppkey = l_suppkey
    join orders on o_orderkey = l_orderkey
    join customer on c_custkey = o_custkey
    join nation n1 on s_nationkey = n1.n_nationkey
    join nation n2 on c_nationkey = n2.n_nationkey
    where (
          (n1.n_name = 'CANADA' and n2.n_name = 'MOZAMBIQUE')
          or (n1.n_name = 'MOZAMBIQUE' and n2.n_name = 'CANADA')
      )
      and l_shipdate between date '1995-01-01' and date '1996-12-31'
) as shipping
group by supp_nation, cust_nation, l_year
order by supp_nation, cust_nation, l_year
LIMIT ALL;