select * from (
    select sum(ws_net_paid) as total_sum,
           i_category,
           i_class,
           grouping(i_category) + grouping(i_class) as lochierarchy,
           rank() over (
               partition by grouping(i_category) + grouping(i_class),
               case when grouping(i_class) = 0 then i_category end
               order by sum(ws_net_paid) desc
           ) as rank_within_parent
    from web_sales
    join date_dim d1 on d1.d_date_sk = ws_sold_date_sk
    join item on i_item_sk = ws_item_sk
    where d1.d_month_seq between 1186 and 1186 + 11
    group by rollup(i_category, i_class)
) as sub
order by lochierarchy desc, case when lochierarchy = 0 then i_category end, rank_within_parent
limit 100;select * from (
    select sum(ws_net_paid) as total_sum,
           i_category,
           i_class,
           grouping(i_category) + grouping(i_class) as lochierarchy,
           rank() over (
               partition by grouping(i_category) + grouping(i_class),
               case when grouping(i_class) = 0 then i_category end
               order by sum(ws_net_paid) desc
           ) as rank_within_parent
    from web_sales
    join date_dim d1 on d1.d_date_sk = ws_sold_date_sk
    join item on i_item_sk = ws_item_sk
    where d1.d_month_seq between 1186 and 1186 + 11
    group by rollup(i_category, i_class)
) as sub
order by lochierarchy desc, case when lochierarchy = 0 then i_category end, rank_within_parent
limit 100;