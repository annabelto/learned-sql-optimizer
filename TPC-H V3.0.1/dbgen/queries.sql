-- using 1713409886 as a seed to the RNG
	lineitem
where
	l_shipdate <= date '1998-12-01' - interval '95' day
group by
	l_returnflag,
	l_linestatus
order by
	l_returnflag,
	l_linestatus
LIMIT -1
			and s_nationkey = n_nationkey
			and n_regionkey = r_regionkey
			and r_name = 'ASIA'
	)
order by
	s_acctbal desc,
	n_name,
	s_name,
	p_partkey
LIMIT 100
	and o_orderdate < date '1995-03-17'
	and l_shipdate > date '1995-03-17'
group by
	l_orderkey,
	o_orderdate,
	o_shippriority
order by
	revenue desc,
	o_orderdate
LIMIT 10
			lineitem
		where
			l_orderkey = o_orderkey
			and l_commitdate < l_receiptdate
	)
group by
	o_orderpriority
order by
	o_orderpriority
LIMIT -1
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'ASIA'
	and o_orderdate >= date '1995-01-01'
	and o_orderdate < date '1995-01-01' + interval '1' year
group by
	n_name
order by
	revenue desc
LIMIT -1
select
	sum(l_extendedprice * l_discount) as revenue
from
	lineitem
where
	l_shipdate >= date '1995-01-01'
	and l_shipdate < date '1995-01-01' + interval '1' year
	and l_discount between 0.03 - 0.01 and 0.03 + 0.01
	and l_quantity < 24
LIMIT -1
	) as shipping
group by
	supp_nation,
	cust_nation,
	l_year
order by
	supp_nation,
	cust_nation,
	l_year
LIMIT -1
			and r_name = 'EUROPE'
			and s_nationkey = n2.n_nationkey
			and o_orderdate between date '1995-01-01' and date '1996-12-31'
			and p_type = 'SMALL POLISHED NICKEL'
	) as all_nations
group by
	o_year
order by
	o_year
LIMIT -1
			and s_nationkey = n_nationkey
			and p_name like '%drab%'
	) as profit
group by
	nation,
	o_year
order by
	nation,
	o_year desc
LIMIT -1
	c_custkey,
	c_name,
	c_acctbal,
	c_phone,
	n_name,
	c_address,
	c_comment
order by
	revenue desc
LIMIT 20
				supplier,
				nation
			where
				ps_suppkey = s_suppkey
				and s_nationkey = n_nationkey
				and n_name = 'VIETNAM'
		)
order by
	value desc
LIMIT -1
	and l_shipmode in ('SHIP', 'REG AIR')
	and l_commitdate < l_receiptdate
	and l_shipdate < l_commitdate
	and l_receiptdate >= date '1997-01-01'
	and l_receiptdate < date '1997-01-01' + interval '1' year
group by
	l_shipmode
order by
	l_shipmode
LIMIT -1
				and o_comment not like '%express%packages%'
		group by
			c_custkey
	) as c_orders (c_custkey, c_count)
group by
	c_count
order by
	custdist desc,
	c_count desc
LIMIT -1
		else 0
	end) / sum(l_extendedprice * (1 - l_discount)) as promo_revenue
from
	lineitem,
	part
where
	l_partkey = p_partkey
	and l_shipdate >= date '1993-01-01'
	and l_shipdate < date '1993-01-01' + interval '1' month
LIMIT -1
		select
			max(total_revenue)
		from
			revenue0
	)
order by
	s_suppkey;

drop view revenue0
LIMIT -1
group by
	p_brand,
	p_type,
	p_size
order by
	supplier_cnt desc,
	p_brand,
	p_type,
	p_size
LIMIT -1
	and p_container = 'MED CAN'
	and l_quantity < (
		select
			0.2 * avg(l_quantity)
		from
			lineitem
		where
			l_partkey = p_partkey
	)
LIMIT -1
group by
	c_name,
	c_custkey,
	o_orderkey,
	o_orderdate,
	o_totalprice
order by
	o_totalprice desc,
	o_orderdate
LIMIT 100
	(
		p_partkey = l_partkey
		and p_brand = 'Brand#23'
		and p_container in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
		and l_quantity >= 27 and l_quantity <= 27 + 10
		and p_size between 1 and 15
		and l_shipmode in ('AIR', 'AIR REG')
		and l_shipinstruct = 'DELIVER IN PERSON'
	)
LIMIT -1
					and l_suppkey = ps_suppkey
					and l_shipdate >= date '1996-01-01'
					and l_shipdate < date '1996-01-01' + interval '1' year
			)
	)
	and s_nationkey = n_nationkey
	and n_name = 'JAPAN'
order by
	s_name
LIMIT -1
			and l3.l_receiptdate > l3.l_commitdate
	)
	and s_nationkey = n_nationkey
	and n_name = 'ROMANIA'
group by
	s_name
order by
	numwait desc,
	s_name
LIMIT 100
					orders
				where
					o_custkey = c_custkey
			)
	) as custsale
group by
	cntrycode
order by
	cntrycode
LIMIT -1
