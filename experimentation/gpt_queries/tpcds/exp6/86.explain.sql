explain select * FROM (
    SELECT 
        SUM(ws_net_paid) AS total_sum,
        i_category,
        i_class,
        grouping(i_category) + grouping(i_class) AS lochierarchy,
        rank() OVER (
            PARTITION BY grouping(i_category) + grouping(i_class),
            CASE WHEN grouping(i_class) = 0 THEN i_category END
            ORDER BY SUM(ws_net_paid) DESC
        ) AS rank_within_parent
    FROM 
        web_sales
    JOIN 
        date_dim d1 ON d1.d_date_sk = ws_sold_date_sk
    JOIN 
        item ON i_item_sk = ws_item_sk
    WHERE 
        d1.d_month_seq BETWEEN 1186 AND 1197
    GROUP BY 
        ROLLUP(i_category, i_class)
) AS sub
ORDER BY 
    lochierarchy DESC, 
    CASE WHEN lochierarchy = 0 THEN i_category END, 
    rank_within_parent
LIMIT 100;SELECT * FROM (
    SELECT 
        SUM(ws_net_paid) AS total_sum,
        i_category,
        i_class,
        grouping(i_category) + grouping(i_class) AS lochierarchy,
        rank() OVER (
            PARTITION BY grouping(i_category) + grouping(i_class),
            CASE WHEN grouping(i_class) = 0 THEN i_category END
            ORDER BY SUM(ws_net_paid) DESC
        ) AS rank_within_parent
    FROM 
        web_sales
    JOIN 
        date_dim d1 ON d1.d_date_sk = ws_sold_date_sk
    JOIN 
        item ON i_item_sk = ws_item_sk
    WHERE 
        d1.d_month_seq BETWEEN 1186 AND 1197
    GROUP BY 
        ROLLUP(i_category, i_class)
) AS sub
ORDER BY 
    lochierarchy DESC, 
    CASE WHEN lochierarchy = 0 THEN i_category END, 
    rank_within_parent
LIMIT 100;