select
        s_acctbal,
        s_name,
        n_name,
        p_partkey,
        p_mfgr,
        s_address,
        s_phone,
        s_comment
from
        part,
        supplier,
        partsupp,
        nation,
        region, 
        (
                select
                        min(ps_supplycost) as min_cost, ps_partkey as europe_key
                from
                        partsupp,
                        supplier,
                        nation,
                        region
                where
                        s_suppkey = ps_suppkey
                        and s_nationkey = n_nationkey
                        and n_regionkey = r_regionkey
                        and r_name = 'EUROPE'
               group by 
                        ps_partkey
          ) as europe
where
        p_partkey = europe_key
        and p_partkey = ps_partkey
        and s_suppkey = ps_suppkey
        and p_size = 15
        and p_type like '%BRASS'
        and s_nationkey = n_nationkey
        and n_regionkey = r_regionkey
        and r_name = 'EUROPE'
        and ps_supplycost = min_cost
order by
        s_acctbal desc,
        n_name,
        s_name,
        p_partkey
limit 100
