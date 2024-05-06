select * from (
    select 
        sum(ss_net_profit)/sum(ss_ext_sales_price) as gross_margin,
        i_category,
        i_class,
        grouping(i_category)+grouping(i_class) as lochierarchy,
        rank() over (
            partition by grouping(i_category)+grouping(i_class), 
            case when grouping(i_class) = 0 then i_category end 
            order by sum(ss_net_profit)/sum(ss_ext_sales_price) asc
        ) as rank_within_parent 
    from 
        store_sales
        JOIN date_dim d1 ON d1.d_date_sk = ss_sold_date_sk
        JOIN item ON i_item_sk = ss_item_sk
        JOIN store ON s_store_sk = ss_store_sk
    where 
        d1.d_year = 2000 and 
        s_state in ('TN') 
    group by rollup(i_category, i_class)
) as sub 
order by 
    lochierarchy desc, 
    case when lochierarchy = 0 then i_category end, 
    rank_within_parent 
limit 100;