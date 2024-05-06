WITH ranked_states AS (
    SELECT 
        s_state,
        SUM(ss_net_profit) AS state_profit
    FROM 
        store_sales
    JOIN 
        store ON store.s_store_sk = store_sales.ss_store_sk
    JOIN 
        date_dim ON date_dim.d_date_sk = store_sales.ss_sold_date_sk
    WHERE 
        date_dim.d_month_seq BETWEEN 1220 AND 1231
    GROUP BY 
        s_state
    ORDER BY 
        state_profit DESC
    LIMIT 5
)
, sales_summary AS (
    SELECT 
        SUM(ss_net_profit) AS total_sum,
        s_state,
        s_county,
        grouping(s_state) + grouping(s_county) AS lochierarchy
    FROM 
        store_sales
    JOIN 
        store ON store.s_store_sk = store_sales.ss_store_sk
    JOIN 
        date_dim ON date_dim.d_date_sk = store_sales.ss_sold_date_sk
    WHERE 
        date_dim.d_month_seq BETWEEN 1220 AND 1231
        AND s_state IN (SELECT s_state FROM ranked_states)
    GROUP BY 
        ROLLUP(s_state, s_county)
)
SELECT 
    total_sum,
    s_state,
    s_county,
    lochierarchy,
    RANK() OVER (
        PARTITION BY lochierarchy, 
        CASE WHEN lochierarchy = 0 THEN s_state END 
        ORDER BY total_sum DESC
    ) AS rank_within_parent
FROM 
    sales_summary
ORDER BY 
    lochierarchy DESC,
    CASE WHEN lochierarchy = 0 THEN s_state END,
    rank_within_parent
LIMIT 100;