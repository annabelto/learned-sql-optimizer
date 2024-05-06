explain select asceding.rnk, i1.i_product_name AS best_performing, i2.i_product_name AS worst_performing
FROM
    (SELECT item_sk, rnk
     FROM (SELECT item_sk, rank() OVER (ORDER BY rank_col ASC) AS rnk
           FROM (SELECT ss_item_sk AS item_sk, AVG(ss_net_profit) AS rank_col
                 FROM store_sales
                 WHERE ss_store_sk = 4
                 GROUP BY ss_item_sk
                 HAVING AVG(ss_net_profit) > 0.9 * (SELECT AVG(ss_net_profit)
                                                   FROM store_sales
                                                   WHERE ss_store_sk = 4 AND ss_hdemo_sk IS NULL
                                                   GROUP BY ss_store_sk)
                ) AS subquery1
          ) AS ranked
     WHERE rnk < 11
    ) AS asceding
JOIN
    (SELECT item_sk, rnk
     FROM (SELECT item_sk, rank() OVER (ORDER BY rank_col DESC) AS rnk
           FROM (SELECT ss_item_sk AS item_sk, AVG(ss_net_profit) AS rank_col
                 FROM store_sales
                 WHERE ss_store_sk = 4
                 GROUP BY ss_item_sk
                 HAVING AVG(ss_net_profit) > 0.9 * (SELECT AVG(ss_net_profit)
                                                   FROM store_sales
                                                   WHERE ss_store_sk = 4 AND ss_hdemo_sk IS NULL
                                                   GROUP BY ss_store_sk)
                ) AS subquery2
          ) AS ranked
     WHERE rnk < 11
    ) AS descending
ON asceding.rnk = descending.rnk
JOIN item i1 ON i1.i_item_sk = asceding.item_sk
JOIN item i2 ON i2.i_item_sk = descending.item_sk
ORDER BY asceding.rnk
LIMIT 100;SELECT asceding.rnk, i1.i_product_name AS best_performing, i2.i_product_name AS worst_performing
FROM
    (SELECT item_sk, rnk
     FROM (SELECT item_sk, rank() OVER (ORDER BY rank_col ASC) AS rnk
           FROM (SELECT ss_item_sk AS item_sk, AVG(ss_net_profit) AS rank_col
                 FROM store_sales
                 WHERE ss_store_sk = 4
                 GROUP BY ss_item_sk
                 HAVING AVG(ss_net_profit) > 0.9 * (SELECT AVG(ss_net_profit)
                                                   FROM store_sales
                                                   WHERE ss_store_sk = 4 AND ss_hdemo_sk IS NULL
                                                   GROUP BY ss_store_sk)
                ) AS subquery1
          ) AS ranked
     WHERE rnk < 11
    ) AS asceding
JOIN
    (SELECT item_sk, rnk
     FROM (SELECT item_sk, rank() OVER (ORDER BY rank_col DESC) AS rnk
           FROM (SELECT ss_item_sk AS item_sk, AVG(ss_net_profit) AS rank_col
                 FROM store_sales
                 WHERE ss_store_sk = 4
                 GROUP BY ss_item_sk
                 HAVING AVG(ss_net_profit) > 0.9 * (SELECT AVG(ss_net_profit)
                                                   FROM store_sales
                                                   WHERE ss_store_sk = 4 AND ss_hdemo_sk IS NULL
                                                   GROUP BY ss_store_sk)
                ) AS subquery2
          ) AS ranked
     WHERE rnk < 11
    ) AS descending
ON asceding.rnk = descending.rnk
JOIN item i1 ON i1.i_item_sk = asceding.item_sk
JOIN item i2 ON i2.i_item_sk = descending.item_sk
ORDER BY asceding.rnk
LIMIT 100;