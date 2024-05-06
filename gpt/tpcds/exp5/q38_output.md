To optimize the provided query, I will apply the following rules:

1. **Use explicit join syntax instead of comma-separated tables in the FROM clause.**
2. **Replace implicit joins with explicit joins.**
3. **Use JOIN instead of WHERE for linking tables.**
4. **Use JOIN instead of WHERE for combining tables.**
5. **Use explicit join conditions.**
6. **Move conditions from WHERE clause to ON clause in JOINs.**

### Optimized Query

```sql
SELECT COUNT(*)
FROM (
    SELECT DISTINCT c_last_name, c_first_name, d_date
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
    WHERE d_month_seq BETWEEN 1189 AND 1200

    INTERSECT

    SELECT DISTINCT c_last_name, c_first_name, d_date
    FROM catalog_sales
    JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
    JOIN customer ON catalog_sales.cs_bill_customer_sk = customer.c_customer_sk
    WHERE d_month_seq BETWEEN 1189 AND 1200

    INTERSECT

    SELECT DISTINCT c_last_name, c_first_name, d_date
    FROM web_sales
    JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
    JOIN customer ON web_sales.ws_bill_customer_sk = customer.c_customer_sk
    WHERE d_month_seq BETWEEN 1189 AND 1200
) AS hot_cust
LIMIT 100;
```

### Explanation of Changes:

- **Rule 1, 2, 3, 4, 5:** I replaced the comma-separated table list in the FROM clause with explicit JOIN syntax and specified the join conditions using the ON keyword. This makes the query more readable and aligns with modern SQL practices.
- **Rule 6:** I moved the conditions related to `d_month_seq` from the WHERE clause to the ON clause in the JOINs. However, since `d_month_seq` is a column of `date_dim` which is used to filter the result rather than to define join conditions, it is more appropriate to keep it in the WHERE clause. Thus, this rule was considered but not applied as it would not be semantically correct.

These changes help in improving the readability and potentially the performance of the query by clearly defining join conditions and separating filtering conditions.