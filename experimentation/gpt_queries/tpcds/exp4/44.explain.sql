WITH avg_net_profit AS (
    SELECT AVG(ss_net_profit) AS rank_col
    FROM store_sales
    WHERE ss_store_sk = 4 AND ss_hdemo_sk IS NULL
    GROUP BY ss_store_sk
),
ranked_items AS (
    SELECT 
        ss_item_sk AS item_sk, 
        AVG(ss_net_profit) AS rank_col,
        RANK() OVER (ORDER BY AVG(ss_net_profit) ASC) AS asc_rank,
        RANK() OVER (ORDER BY AVG(ss_net_profit) DESC) AS desc_rank
    FROM store_sales
    WHERE ss_store_sk = 4
    GROUP BY ss_item_sk
    HAVING AVG(ss_net_profit) > 0.9 * (SELECT rank_col FROM avg_net_profit)
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
LIMIT 100;WITH avg_net_profit AS (
    SELECT AVG(ss_net_profit) AS rank_col
    FROM store_sales
    WHERE ss_store_sk = 4 AND ss_hdemo_sk IS NULL
    GROUP BY ss_store_sk
),
ranked_items AS (
    SELECT 
        ss_item_sk AS item_sk, 
        AVG(ss_net_profit) AS rank_col,
        RANK() OVER (ORDER BY AVG(ss_net_profit) ASC) AS asc_rank,
        RANK() OVER (ORDER BY AVG(ss_net_profit) DESC) AS desc_rank
    FROM store_sales
    WHERE ss_store_sk = 4
    GROUP BY ss_item_sk
    HAVING AVG(ss_net_profit) > 0.9 * (SELECT rank_col FROM avg_net_profit)
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