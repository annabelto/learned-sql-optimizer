To optimize the given query, we can apply several data-independent rewrite rules that improve the performance without altering the result. The rules include:

1. **Predicate Pushdown**: This involves moving the predicates as close as possible to the data source. It reduces the amount of data processed by filtering rows early in the execution plan.

2. **Common Sub-expression Elimination**: If the same expression or subquery is used multiple times, it can be computed once and reused.

3. **Join Elimination**: If a join does not contribute to the final result, it can be eliminated.

4. **Redundant DISTINCT Removal**: If the query uses `DISTINCT` in subqueries that are combined using `INTERSECT`, the final `DISTINCT` is redundant because `INTERSECT` returns only distinct results.

### Applying the Rules:

1. **Predicate Pushdown**: We push the predicates related to `d_month_seq` directly into the subqueries to reduce the amount of data joined and processed in each subquery.

2. **Common Sub-expression Elimination**: The predicate `d_month_seq between 1189 and 1189 + 11` is common across all subqueries and can be factored out, but since it involves a join condition, it's more efficient to keep it within each subquery for better locality.

3. **Redundant DISTINCT Removal**: Since `INTERSECT` inherently ensures that only distinct results are considered, the `DISTINCT` in the subqueries is redundant and can be removed.

### Optimized Query:
```sql
SELECT COUNT(*)
FROM (
    SELECT c_last_name, c_first_name, d_date
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
    WHERE d_month_seq BETWEEN 1189 AND 1200
    INTERSECT
    SELECT c_last_name, c_first_name, d_date
    FROM catalog_sales
    JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
    JOIN customer ON catalog_sales.cs_bill_customer_sk = customer.c_customer_sk
    WHERE d_month_seq BETWEEN 1189 AND 1200
    INTERSECT
    SELECT c_last_name, c_first_name, d_date
    FROM web_sales
    JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
    JOIN customer ON web_sales.ws_bill_customer_sk = customer.c_customer_sk
    WHERE d_month_seq BETWEEN 1189 AND 1200
) hot_cust
LIMIT 100;
```

### Explanation:
- **Predicate Pushdown**: The `WHERE` clause is applied directly after the joins in each subquery, reducing the amount of data that needs to be processed.
- **Redundant DISTINCT Removal**: Removed the `DISTINCT` keyword from the subqueries since `INTERSECT` ensures uniqueness.
- **Join and Subquery Structure**: Maintained as necessary for correct results.

This optimized query should perform better due to reduced data processing and elimination of unnecessary `DISTINCT` operations.