SELECT DISTINCT i1.i_product_name
FROM item i1
JOIN item i2 ON i1.i_manufact = i2.i_manufact
WHERE i1.i_manufact_id BETWEEN 704 AND 744
AND (
    (i2.i_category = 'Women' AND i2.i_color IN ('forest', 'lime', 'navy', 'slate', 'dark', 'aquamarine', 'frosted', 'plum') AND i2.i_units IN ('Pallet', 'Pound', 'Gross', 'Bunch', 'Ton', 'Tbl', 'Dram', 'Box') AND i2.i_size IN ('economy', 'small', 'extra large', 'petite'))
    OR
    (i2.i_category = 'Men' AND i2.i_color IN ('powder', 'sky', 'maroon', 'smoke', 'papaya', 'peach', 'firebrick', 'sienna') AND i2.i_units IN ('Dozen', 'Lb', 'Ounce', 'Case', 'Bundle', 'Carton', 'Cup', 'Each') AND i2.i_size IN ('N/A', 'large', 'economy', 'small'))
)
GROUP BY i1.i_product_name
HAVING COUNT(*) > 0
ORDER BY i1.i_product_name
LIMIT 100;