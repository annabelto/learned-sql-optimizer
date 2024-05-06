explain select DISTINCT i1.i_product_name
FROM item i1
JOIN item i2 ON i1.i_manufact = i2.i_manufact
WHERE i1.i_manufact_id BETWEEN 704 AND 744
  AND (
    (i2.i_category = 'Women' AND (i2.i_color IN ('forest', 'lime')) AND (i2.i_units IN ('Pallet', 'Pound')) AND (i2.i_size IN ('economy', 'small')))
    OR (i2.i_category = 'Women' AND (i2.i_color IN ('navy', 'slate')) AND (i2.i_units IN ('Gross', 'Bunch')) AND (i2.i_size IN ('extra large', 'petite')))
    OR (i2.i_category = 'Men' AND (i2.i_color IN ('powder', 'sky')) AND (i2.i_units IN ('Dozen', 'Lb')) AND (i2.i_size IN ('N/A', 'large')))
    OR (i2.i_category = 'Men' AND (i2.i_color IN ('maroon', 'smoke')) AND (i2.i_units IN ('Ounce', 'Case')) AND (i2.i_size IN ('economy', 'small')))
    OR (i2.i_category = 'Women' AND (i2.i_color IN ('dark', 'aquamarine')) AND (i2.i_units IN ('Ton', 'Tbl')) AND (i2.i_size IN ('economy', 'small')))
    OR (i2.i_category = 'Women' AND (i2.i_color IN ('frosted', 'plum')) AND (i2.i_units IN ('Dram', 'Box')) AND (i2.i_size IN ('extra large', 'petite')))
    OR (i2.i_category = 'Men' AND (i2.i_color IN ('papaya', 'peach')) AND (i2.i_units IN ('Bundle', 'Carton')) AND (i2.i_size IN ('N/A', 'large')))
    OR (i2.i_category = 'Men' AND (i2.i_color IN ('firebrick', 'sienna')) AND (i2.i_units IN ('Cup', 'Each')) AND (i2.i_size IN ('economy', 'small')))
  )
ORDER BY i1.i_product_name
LIMIT 100;SELECT DISTINCT i1.i_product_name
FROM item i1
JOIN item i2 ON i1.i_manufact = i2.i_manufact
WHERE i1.i_manufact_id BETWEEN 704 AND 744
  AND (
    (i2.i_category = 'Women' AND (i2.i_color IN ('forest', 'lime')) AND (i2.i_units IN ('Pallet', 'Pound')) AND (i2.i_size IN ('economy', 'small')))
    OR (i2.i_category = 'Women' AND (i2.i_color IN ('navy', 'slate')) AND (i2.i_units IN ('Gross', 'Bunch')) AND (i2.i_size IN ('extra large', 'petite')))
    OR (i2.i_category = 'Men' AND (i2.i_color IN ('powder', 'sky')) AND (i2.i_units IN ('Dozen', 'Lb')) AND (i2.i_size IN ('N/A', 'large')))
    OR (i2.i_category = 'Men' AND (i2.i_color IN ('maroon', 'smoke')) AND (i2.i_units IN ('Ounce', 'Case')) AND (i2.i_size IN ('economy', 'small')))
    OR (i2.i_category = 'Women' AND (i2.i_color IN ('dark', 'aquamarine')) AND (i2.i_units IN ('Ton', 'Tbl')) AND (i2.i_size IN ('economy', 'small')))
    OR (i2.i_category = 'Women' AND (i2.i_color IN ('frosted', 'plum')) AND (i2.i_units IN ('Dram', 'Box')) AND (i2.i_size IN ('extra large', 'petite')))
    OR (i2.i_category = 'Men' AND (i2.i_color IN ('papaya', 'peach')) AND (i2.i_units IN ('Bundle', 'Carton')) AND (i2.i_size IN ('N/A', 'large')))
    OR (i2.i_category = 'Men' AND (i2.i_color IN ('firebrick', 'sienna')) AND (i2.i_units IN ('Cup', 'Each')) AND (i2.i_size IN ('economy', 'small')))
  )
ORDER BY i1.i_product_name
LIMIT 100;