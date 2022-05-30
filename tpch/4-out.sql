select
        o_orderpriority,
        count(*) as order_count
from
        orders,
        ( select l_orderkey
          from lineitem
          where l_commitdate < l_receiptdate
          group by
         	l_orderkey
          ) as f_lineitem
where
        o_orderdate >= date '1993-07-01'
        and o_orderdate < date '1993-10-01'
        and l_orderkey = o_orderkey
group by
        o_orderpriority
order by
        o_orderpriority
