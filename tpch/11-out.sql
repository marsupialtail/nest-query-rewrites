with (select
	sum(ps_supplycost * ps_availqty) * :2
from
	partsupp,
	supplier,
	nation
where
	ps_suppkey = s_suppkey
	and s_nationkey = n_nationkey
	and n_name = ':1') as condition

-- the nested subquery is independnet of the main query, so just evaluate it separately!

select
        ps_partkey,
        sum(ps_supplycost * ps_availqty) as value
from
        partsupp,
        supplier,
        nation
where
        ps_suppkey = s_suppkey
        and s_nationkey = n_nationkey
        and n_name = ':1'
group by
        ps_partkey having
                sum(ps_supplycost * ps_availqty) > condition
order by
        value desc;


