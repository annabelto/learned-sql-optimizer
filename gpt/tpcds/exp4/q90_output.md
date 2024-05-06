To optimize the given PostgreSQL query, we can apply several data-independent rewrite rules. These rules aim to simplify the query, improve its readability, and potentially enhance execution performance by the database engine. Here are the steps and rules I will apply:

1. **Common Sub-expression Elimination**: The subqueries for `amc` and `pmc` share similar structures and conditions, differing only in the filter on `time_dim.t_hour`. We can refactor the query to compute these counts in a single scan by grouping on the hour condition.

2. **Predicate Pushdown**: Move conditions as close as possible to where the data originates, which can reduce the amount of data processed in the joins.

3. **Simplify Expressions**: The expression `12 + 1` and `14 + 1` can be simplified directly to `13` and `15`, respectively.

4. **Eliminate Redundant Casting**: Since the division of two counts (integers) is being cast to decimal, ensure that casting is necessary only at the final step of computing the ratio.

### Optimized Query

```sql
SELECT
    CAST(sum(CASE WHEN t_hour BETWEEN 12 AND 13 THEN 1 ELSE 0 END) AS DECIMAL(15,4)) /
    CAST(sum(CASE WHEN t_hour BETWEEN 14 AND 15 THEN 1 ELSE 0 END) AS DECIMAL(15,4)) AS am_pm_ratio
FROM
    web_sales
JOIN
    household_demographics ON ws_ship_hdemo_sk = household_demographics.hd_demo_sk
JOIN
    time_dim ON ws_sold_time_sk = time_dim.t_time_sk
JOIN
    web_page ON ws_web_page_sk = web_page.wp_web_page_sk
WHERE
    household_demographics.hd_dep_count = 6
    AND web_page.wp_char_count BETWEEN 5000 AND 5200
    AND time_dim.t_hour BETWEEN 12 AND 15
GROUP BY
    household_demographics.hd_dep_count, web_page.wp_char_count
ORDER BY
    am_pm_ratio DESC
LIMIT 100;
```

**Explanation of Changes:**

- **Common Sub-expression Elimination**: The query now computes the counts for `amc` and `pmc` in a single pass over the data, using conditional aggregation based on the hour.
- **Predicate Pushdown**: All filters are applied directly in the `WHERE` clause before the join and aggregation, reducing the amount of data that needs to be processed.
- **Simplify Expressions**: Directly using `13` and `15` instead of `12 + 1` and `14 + 1`.
- **Eliminate Redundant Casting**: The casting is now applied only once at the time of division, which is necessary to ensure decimal precision in the result.

This refactored query should be more efficient, as it minimizes the number of table scans and simplifies the computation by reducing the number of subqueries and leveraging conditional aggregation.