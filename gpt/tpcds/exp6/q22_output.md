To optimize the provided query, I will apply the following rules:

1. **Use explicit join syntax instead of comma-separated tables in the FROM clause.**
2. **Replace implicit joins with explicit joins.**
3. **Use JOIN instead of WHERE for linking tables.**
4. **Use JOIN instead of WHERE for combining tables.**
5. **Use explicit join conditions.**
6. **Move conditions from WHERE clause to ON clause in JOINs.**

### Original Query:
```sql
select i_product_name, i_brand, i_class, i_category, avg(inv_quantity_on_hand) qoh
from inventory, date_dim, item
where inv_date_sk = d_date_sk and inv_item_sk = i_item_sk
and d_month_seq between 1200 and 1200 + 11
group by rollup(i_product_name, i_brand, i_class, i_category)
order by qoh, i_product_name, i_brand, i_class, i_category
limit 100;
```

### Optimized Query:
```sql
SELECT i_product_name, i_brand, i_class, i_category, AVG(inv_quantity_on_hand) AS qoh
FROM inventory
JOIN date_dim ON inventory.inv_date_sk = date_dim.d_date_sk
JOIN item ON inventory.inv_item_sk = item.i_item_sk
WHERE date_dim.d_month_seq BETWEEN 1200 AND 1211
GROUP BY ROLLUP(i_product_name, i_brand, i_class, i_category)
ORDER BY qoh, i_product_name, i_brand, i_class, i_category
LIMIT 100;
```

### Explanation of Changes:
1. **Explicit Join Syntax:** I replaced the comma-separated list in the FROM clause with explicit JOIN clauses.
2. **Explicit Join Conditions:** I moved the join conditions from the WHERE clause to the respective ON clauses of the JOIN statements.
3. **Filter Condition:** The filter condition on `d_month_seq` remains in the WHERE clause as it does not relate directly to the join conditions but is a filter on the date_dim table after the joins have been made.

These changes make the query more readable and maintainable, and they can also help the database optimizer to create a more efficient execution plan.