To optimize the provided query, I will apply the following rules:

1. **Use explicit join syntax instead of comma-separated tables in the FROM clause.**
2. **Replace implicit joins with explicit joins.**
3. **Use JOIN instead of WHERE for linking tables.**
4. **Use JOIN instead of WHERE for combining tables.**
5. **Use explicit join conditions.**
6. **Move conditions from WHERE clause to ON clause in JOINs.**

### Original Query:
```sql
select i_item_id, i_item_desc, i_current_price 
from item, inventory, date_dim, store_sales 
where i_current_price between 58 and 58+30 
and inv_item_sk = i_item_sk 
and d_date_sk=inv_date_sk 
and d_date between cast('2001-01-13' as date) and (cast('2001-01-13' as date) + 60) 
and i_manufact_id in (259,559,580,485) 
and inv_quantity_on_hand between 100 and 500 
and ss_item_sk = i_item_sk 
group by i_item_id, i_item_desc, i_current_price 
order by i_item_id 
limit 100;
```

### Optimized Query:
```sql
SELECT i_item_id, i_item_desc, i_current_price 
FROM item
JOIN inventory ON inv_item_sk = i_item_sk AND inv_quantity_on_hand BETWEEN 100 AND 500
JOIN date_dim ON d_date_sk = inv_date_sk AND d_date BETWEEN CAST('2001-01-13' AS DATE) AND (CAST('2001-01-13' AS DATE) + 60)
JOIN store_sales ON ss_item_sk = i_item_sk
WHERE i_current_price BETWEEN 58 AND 88 -- 58+30 simplified to 88
AND i_manufact_id IN (259, 559, 580, 485)
GROUP BY i_item_id, i_item_desc, i_current_price 
ORDER BY i_item_id 
LIMIT 100;
```

### Explanation:
- **Rule 1, 2, 3, 4, 5:** I replaced the comma-separated list of tables in the FROM clause with explicit JOINs, specifying the join conditions using the ON keyword. This makes the query easier to read and understand.
- **Rule 6:** I moved relevant conditions from the WHERE clause to the ON clause of the corresponding JOINs. This can help the query optimizer by reducing the number of rows to process early in the execution plan, especially if the database can utilize indexes on the join columns.
- **Simplification:** Directly calculated `58+30` as `88` in the WHERE clause for clarity and potentially slight performance improvement.

This rewritten query should be more efficient and clearer in intent than the original version.