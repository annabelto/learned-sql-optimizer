explain select DISTINCT i_product_name
FROM item i1
WHERE i_manufact_id BETWEEN 704 AND 744
  AND EXISTS (
    SELECT 1
    FROM item
    WHERE i_manufact = i1.i_manufact
      AND (
        (i_category = 'Women' AND ((i_color = 'forest' OR i_color = 'lime') AND (i_units = 'Pallet' OR i_units = 'Pound') AND (i_size = 'economy' OR i_size = 'small')))
        OR (i_category = 'Women' AND ((i_color = 'navy' OR i_color = 'slate') AND (i_units = 'Gross' OR i_units = 'Bunch') AND (i_size = 'extra large' OR i_size = 'petite')))
        OR (i_category = 'Men' AND ((i_color = 'powder' OR i_color = 'sky') AND (i_units = 'Dozen' OR i_units = 'Lb') AND (i_size = 'N/A' OR i_size = 'large')))
        OR (i_category = 'Men' AND ((i_color = 'maroon' OR i_color = 'smoke') AND (i_units = 'Ounce' OR i_units = 'Case') AND (i_size = 'economy' OR i_size = 'small')))
        OR (i_category = 'Women' AND ((i_color = 'dark' OR i_color = 'aquamarine') AND (i_units = 'Ton' OR i_units = 'Tbl') AND (i_size = 'economy' OR i_size = 'small')))
        OR (i_category = 'Women' AND ((i_color = 'frosted' OR i_color = 'plum') AND (i_units = 'Dram' OR i_units = 'Box') AND (i_size = 'extra large' OR i_size = 'petite')))
        OR (i_category = 'Men' AND ((i_color = 'papaya' OR i_color = 'peach') AND (i_units = 'Bundle' OR i_units = 'Carton') AND (i_size = 'N/A' OR i_size = 'large')))
        OR (i_category = 'Men' AND ((i_color = 'firebrick' OR i_color = 'sienna') AND (i_units = 'Cup' OR i_units = 'Each') AND (i_size = 'economy' OR i_size = 'small')))
      )
  )
ORDER BY i_product_name
LIMIT 100;SELECT DISTINCT i_product_name
FROM item i1
WHERE i_manufact_id BETWEEN 704 AND 744
  AND EXISTS (
    SELECT 1
    FROM item
    WHERE i_manufact = i1.i_manufact
      AND (
        (i_category = 'Women' AND ((i_color = 'forest' OR i_color = 'lime') AND (i_units = 'Pallet' OR i_units = 'Pound') AND (i_size = 'economy' OR i_size = 'small')))
        OR (i_category = 'Women' AND ((i_color = 'navy' OR i_color = 'slate') AND (i_units = 'Gross' OR i_units = 'Bunch') AND (i_size = 'extra large' OR i_size = 'petite')))
        OR (i_category = 'Men' AND ((i_color = 'powder' OR i_color = 'sky') AND (i_units = 'Dozen' OR i_units = 'Lb') AND (i_size = 'N/A' OR i_size = 'large')))
        OR (i_category = 'Men' AND ((i_color = 'maroon' OR i_color = 'smoke') AND (i_units = 'Ounce' OR i_units = 'Case') AND (i_size = 'economy' OR i_size = 'small')))
        OR (i_category = 'Women' AND ((i_color = 'dark' OR i_color = 'aquamarine') AND (i_units = 'Ton' OR i_units = 'Tbl') AND (i_size = 'economy' OR i_size = 'small')))
        OR (i_category = 'Women' AND ((i_color = 'frosted' OR i_color = 'plum') AND (i_units = 'Dram' OR i_units = 'Box') AND (i_size = 'extra large' OR i_size = 'petite')))
        OR (i_category = 'Men' AND ((i_color = 'papaya' OR i_color = 'peach') AND (i_units = 'Bundle' OR i_units = 'Carton') AND (i_size = 'N/A' OR i_size = 'large')))
        OR (i_category = 'Men' AND ((i_color = 'firebrick' OR i_color = 'sienna') AND (i_units = 'Cup' OR i_units = 'Each') AND (i_size = 'economy' OR i_size = 'small')))
      )
  )
ORDER BY i_product_name
LIMIT 100;