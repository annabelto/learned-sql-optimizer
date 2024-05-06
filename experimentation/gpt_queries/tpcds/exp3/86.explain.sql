explain select 
    sub.total_sum,
    sub.i_category,
    sub.i_class,
    sub.lochierarchy,
    sub.rank_within_parent
FROM (
    SELECT 
        SUM(ws.ws_net_paid) AS total_sum,
        i.i_category,
        i.i_class,
        GROUPING(i.i_category) + GROUPING(i.i_class) AS lochierarchy,
        RANK() OVER (
            PARTITION BY GROUPING(i.i_category) + GROUPING(i.i_class), 
            CASE WHEN GROUPING(i.i_class) = 0 THEN i.i_category END 
            ORDER BY SUM(ws.ws_net_paid) DESC
        ) AS rank_within_parent
    FROM 
        web_sales ws
        JOIN date_dim d1 ON d1.d_date_sk = ws.ws_sold_date_sk
        JOIN item i ON i.i_item_sk = ws.ws_item_sk
    WHERE 
        d1.d_month_seq BETWEEN 1186 AND 1197
    GROUP BY 
        ROLLUP(i.i_category, i.i_class)
) AS sub
ORDER BY 
    sub.lochierarchy DESC, 
    CASE WHEN sub.lochierarchy = 0 THEN sub.i_category END, 
    sub.rank_within_parent
LIMIT 100;SELECT 
    sub.total_sum,
    sub.i_category,
    sub.i_class,
    sub.lochierarchy,
    sub.rank_within_parent
FROM (
    SELECT 
        SUM(ws.ws_net_paid) AS total_sum,
        i.i_category,
        i.i_class,
        GROUPING(i.i_category) + GROUPING(i.i_class) AS lochierarchy,
        RANK() OVER (
            PARTITION BY GROUPING(i.i_category) + GROUPING(i.i_class), 
            CASE WHEN GROUPING(i.i_class) = 0 THEN i.i_category END 
            ORDER BY SUM(ws.ws_net_paid) DESC
        ) AS rank_within_parent
    FROM 
        web_sales ws
        JOIN date_dim d1 ON d1.d_date_sk = ws.ws_sold_date_sk
        JOIN item i ON i.i_item_sk = ws.ws_item_sk
    WHERE 
        d1.d_month_seq BETWEEN 1186 AND 1197
    GROUP BY 
        ROLLUP(i.i_category, i.i_class)
) AS sub
ORDER BY 
    sub.lochierarchy DESC, 
    CASE WHEN sub.lochierarchy = 0 THEN sub.i_category END, 
    sub.rank_within_parent
LIMIT 100;