To optimize the given query, we can apply several data-independent rewrite rules that focus on improving the performance without altering the semantics of the query. Here are the steps and rules applied:

1. **Predicate Pushdown**: This rule moves predicates into subqueries to reduce the number of rows processed and joined in the main query. By applying filters as early as possible, we can minimize the amount of data that needs to be handled in later stages of the query.

2. **Use of Joins Instead of Cartesian Products**: The original query implicitly uses Cartesian products followed by filtering based on conditions. Rewriting these as explicit joins can help the database optimize the execution plan.

3. **Elimination of Redundant DISTINCT**: Since the INTERSECT operation inherently eliminates duplicates, the use of DISTINCT in subqueries before an INTERSECT is redundant and can be removed.

4. **Column Pruning**: Remove unnecessary columns from the SELECT clause that are not used elsewhere in the query. However, in this case, all selected columns are necessary for the final output.

### Optimized Query
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

### Explanation of Changes:
- **Predicate Pushdown**: Moved the `d_month_seq` filter into each subquery.
- **Use of Joins**: Replaced Cartesian products with explicit JOINs based on the foreign key relationships.
- **Elimination of Redundant DISTINCT**: Removed the `DISTINCT` keyword since `INTERSECT` already ensures uniqueness.
- **Column Pruning**: Maintained necessary columns for the final INTERSECT result.

These changes should help in reducing the execution time and resource usage of the query by minimizing the amount of data being processed and leveraging database optimizations for joins and intersections.