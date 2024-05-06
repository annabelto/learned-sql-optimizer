WITH net_profit_threshold AS (
    SELECT 0.9 * AVG(ss_net_profit) AS threshold
    FROM store_sales
    WHERE ss_store_sk = 4 AND ss_hdemo_sk IS NULL
),
ranked_items AS (
    SELECT 
        ss_item_sk AS item_sk,
        AVG(ss_net_profit) AS avg_net_profit,
        RANK() OVER (ORDER BY AVG(ss_net_profit)) AS asc_rank,
        RANK() OVER (ORDER BY AVG(ss_net_profit) DESC) AS desc_rank
    FROM store_sales
    WHERE ss_store_sk = 4
    GROUP BY ss_item_sk
    HAVING AVG(ss_net_profit) > (SELECT threshold FROM net_profit_threshold)
)
explain select 
    a.asc_rank AS rnk,
    i1.i_product_name AS best_performing,
    i2.i_product_name AS worst_performing
FROM 
    ranked_items a
JOIN 
    ranked_items d ON a.asc_rank = d.desc_rank
JOIN 
    item i1 ON i1.i_item_sk = a.item_sk
JOIN 
    item i2 ON i2.i_item_sk = d.item_sk
WHERE 
    a.asc_rank < 11
ORDER BY 
    a.asc_rank
LIMIT 100;WITH net_profit_threshold AS (
    SELECT 0.9 * AVG(ss_net_profit) AS threshold
    FROM store_sales
    WHERE ss_store_sk = 4 AND ss_hdemo_sk IS NULL
),
ranked_items AS (
    SELECT 
        ss_item_sk AS item_sk,
        AVG(ss_net_profit) AS avg_net_profit,
        RANK() OVER (ORDER BY AVG(ss_net_profit)) AS asc_rank,
        RANK() OVER (ORDER BY AVG(ss_net_profit) DESC) AS desc_rank
    FROM store_sales
    WHERE ss_store_sk = 4
    GROUP BY ss_item_sk
    HAVING AVG(ss_net_profit) > (SELECT threshold FROM net_profit_threshold)
)
SELECT 
    a.asc_rank AS rnk,
    i1.i_product_name AS best_performing,
    i2.i_product_name AS worst_performing
FROM 
    ranked_items a
JOIN 
    ranked_items d ON a.asc_rank = d.desc_rank
JOIN 
    item i1 ON i1.i_item_sk = a.item_sk
JOIN 
    item i2 ON i2.i_item_sk = d.item_sk
WHERE 
    a.asc_rank < 11
ORDER BY 
    a.asc_rank
LIMIT 100;