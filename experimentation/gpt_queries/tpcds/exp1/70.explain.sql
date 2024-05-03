WITH FilteredStates AS (
    SELECT s_state
    FROM store_sales
    JOIN store ON s_store_sk = ss_store_sk
    JOIN date_dim ON d_date_sk = ss_sold_date_sk
    WHERE d_month_seq BETWEEN 1220 AND 1231
    GROUP BY s_state
    ORDER BY SUM(ss_net_profit) DESC
    LIMIT 5
),
AggregatedData AS (
    SELECT
        SUM(ss_net_profit) AS total_sum,
        s_state,
        s_county,
        grouping(s_state) + grouping(s_county) AS lochierarchy,
        RANK() OVER (
            PARTITION BY grouping(s_state) + grouping(s_county), s_state
            ORDER BY SUM(ss_net_profit) DESC
        ) AS rank_within_parent
    FROM store_sales
    JOIN store ON s_store_sk = ss_store_sk
    JOIN date_dim ON d_date_sk = ss_sold_date_sk
    WHERE d_month_seq BETWEEN 1220 AND 1231 AND s_state IN (SELECT s_state FROM FilteredStates)
    GROUP BY ROLLUP(s_state, s_county)
)
explain select *
FROM AggregatedData
ORDER BY lochierarchy DESC, s_state, rank_within_parent
LIMIT 100;WITH FilteredStates AS (
    SELECT s_state
    FROM store_sales
    JOIN store ON s_store_sk = ss_store_sk
    JOIN date_dim ON d_date_sk = ss_sold_date_sk
    WHERE d_month_seq BETWEEN 1220 AND 1231
    GROUP BY s_state
    ORDER BY SUM(ss_net_profit) DESC
    LIMIT 5
),
AggregatedData AS (
    SELECT
        SUM(ss_net_profit) AS total_sum,
        s_state,
        s_county,
        grouping(s_state) + grouping(s_county) AS lochierarchy,
        RANK() OVER (
            PARTITION BY grouping(s_state) + grouping(s_county), s_state
            ORDER BY SUM(ss_net_profit) DESC
        ) AS rank_within_parent
    FROM store_sales
    JOIN store ON s_store_sk = ss_store_sk
    JOIN date_dim ON d_date_sk = ss_sold_date_sk
    WHERE d_month_seq BETWEEN 1220 AND 1231 AND s_state IN (SELECT s_state FROM FilteredStates)
    GROUP BY ROLLUP(s_state, s_county)
)
SELECT *
FROM AggregatedData
ORDER BY lochierarchy DESC, s_state, rank_within_parent
LIMIT 100;