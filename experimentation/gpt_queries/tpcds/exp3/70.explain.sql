explain select 
    total_sum,
    s_state,
    s_county,
    lochierarchy,
    rank_within_parent
FROM (
    SELECT 
        SUM(ss_net_profit) AS total_sum,
        s_state,
        s_county,
        grouping(s_state) + grouping(s_county) AS lochierarchy,
        rank() OVER (
            PARTITION BY grouping(s_state) + grouping(s_county), 
            CASE WHEN grouping(s_county) = 0 THEN s_state END 
            ORDER BY SUM(ss_net_profit) DESC
        ) AS rank_within_parent
    FROM 
        store_sales
    JOIN 
        store ON s_store_sk = ss_store_sk
    JOIN 
        date_dim d1 ON d1.d_date_sk = ss_sold_date_sk
    WHERE 
        d1.d_month_seq BETWEEN 1220 AND 1231
        AND s_state IN (
            SELECT 
                s_state
            FROM (
                SELECT 
                    s_state,
                    SUM(ss_net_profit) AS state_profit
                FROM 
                    store_sales
                JOIN 
                    store ON s_store_sk = ss_store_sk
                JOIN 
                    date_dim ON d_date_sk = ss_sold_date_sk
                WHERE 
                    d_month_seq BETWEEN 1220 AND 1231
                GROUP BY 
                    s_state
                ORDER BY 
                    state_profit DESC
                LIMIT 5
            ) AS top_states
        )
    GROUP BY 
        ROLLUP(s_state, s_county)
) AS sub
ORDER BY 
    lochierarchy DESC,
    CASE WHEN lochierarchy = 0 THEN s_state END,
    rank_within_parent
LIMIT 100;SELECT 
    total_sum,
    s_state,
    s_county,
    lochierarchy,
    rank_within_parent
FROM (
    SELECT 
        SUM(ss_net_profit) AS total_sum,
        s_state,
        s_county,
        grouping(s_state) + grouping(s_county) AS lochierarchy,
        rank() OVER (
            PARTITION BY grouping(s_state) + grouping(s_county), 
            CASE WHEN grouping(s_county) = 0 THEN s_state END 
            ORDER BY SUM(ss_net_profit) DESC
        ) AS rank_within_parent
    FROM 
        store_sales
    JOIN 
        store ON s_store_sk = ss_store_sk
    JOIN 
        date_dim d1 ON d1.d_date_sk = ss_sold_date_sk
    WHERE 
        d1.d_month_seq BETWEEN 1220 AND 1231
        AND s_state IN (
            SELECT 
                s_state
            FROM (
                SELECT 
                    s_state,
                    SUM(ss_net_profit) AS state_profit
                FROM 
                    store_sales
                JOIN 
                    store ON s_store_sk = ss_store_sk
                JOIN 
                    date_dim ON d_date_sk = ss_sold_date_sk
                WHERE 
                    d_month_seq BETWEEN 1220 AND 1231
                GROUP BY 
                    s_state
                ORDER BY 
                    state_profit DESC
                LIMIT 5
            ) AS top_states
        )
    GROUP BY 
        ROLLUP(s_state, s_county)
) AS sub
ORDER BY 
    lochierarchy DESC,
    CASE WHEN lochierarchy = 0 THEN s_state END,
    rank_within_parent
LIMIT 100;