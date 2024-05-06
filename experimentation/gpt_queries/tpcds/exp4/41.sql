SELECT DISTINCT i1.i_product_name
FROM item i1
WHERE i1.i_manufact_id BETWEEN 704 AND 744
  AND EXISTS (
    SELECT 1
    FROM item i2
    WHERE i2.i_manufact = i1.i_manufact
      AND (
        (i2.i_category = 'Women' AND ((i2.i_color = 'forest' OR i2.i_color = 'lime') AND (i2.i_units = 'Pallet' OR i2.i_units = 'Pound') AND (i2.i_size = 'economy' OR i2.i_size = 'small')))
        OR (i2.i_category = 'Women' AND ((i2.i_color = 'navy' OR i2.i_color = 'slate') AND (i2.i_units = 'Gross' OR i2.i_units = 'Bunch') AND (i2.i_size = 'extra large' OR i2.i_size = 'petite')))
        OR (i2.i_category = 'Men' AND ((i2.i_color = 'powder' OR i2.i_color = 'sky') AND (i2.i_units = 'Dozen' OR i2.i_units = 'Lb') AND (i2.i_size = 'N/A' OR i2.i_size = 'large')))
        OR (i2.i_category = 'Men' AND ((i2.i_color = 'maroon' OR i2.i_color = 'smoke') AND (i2.i_units = 'Ounce' OR i2.i_units = 'Case') AND (i2.i_size = 'economy' OR i2.i_size = 'small')))
        OR (i2.i_category = 'Women' AND ((i2.i_color = 'dark' OR i2.i_color = 'aquamarine') AND (i2.i_units = 'Ton' OR i2.i_units = 'Tbl') AND (i2.i_size = 'economy' OR i2.i_size = 'small')))
        OR (i2.i_category = 'Women' AND ((i2.i_color = 'frosted' OR i2.i_color = 'plum') AND (i2.i_units = 'Dram' OR i2.i_units = 'Box') AND (i2.i_size = 'extra large' OR i2.i_size = 'petite')))
        OR (i2.i_category = 'Men' AND ((i2.i_color = 'papaya' OR i2.i_color = 'peach') AND (i2.i_units = 'Bundle' OR i2.i_units = 'Carton') AND (i2.i_size = 'N/A' OR i2.i_size = 'large')))
        OR (i2.i_category = 'Men' AND ((i2.i_color = 'firebrick' OR i2.i_color = 'sienna') AND (i2.i_units = 'Cup' OR i2.i_units = 'Each') AND (i2.i_size = 'economy' OR i2.i_size = 'small')))
      )
  )
ORDER BY i1.i_product_name
LIMIT 100;