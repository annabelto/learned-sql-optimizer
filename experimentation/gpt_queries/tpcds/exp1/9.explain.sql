explain select
  CASE
    WHEN bucket1_count > 1071 THEN bucket1_avg_ext_tax
    ELSE bucket1_avg_net_paid_inc_tax
  END AS bucket1,
  CASE
    WHEN bucket2_count > 39161 THEN bucket2_avg_ext_tax
    ELSE bucket2_avg_net_paid_inc_tax
  END AS bucket2,
  CASE
    WHEN bucket3_count > 29434 THEN bucket3_avg_ext_tax
    ELSE bucket3_avg_net_paid_inc_tax
  END AS bucket3,
  CASE
    WHEN bucket4_count > 6568 THEN bucket4_avg_ext_tax
    ELSE bucket4_avg_net_paid_inc_tax
  END AS bucket4,
  CASE
    WHEN bucket5_count > 21216 THEN bucket5_avg_ext_tax
    ELSE bucket5_avg_net_paid_inc_tax
  END AS bucket5
FROM (
  SELECT
    COUNT(*) FILTER (WHERE ss_quantity BETWEEN 1 AND 20) AS bucket1_count,
    AVG(ss_ext_tax) FILTER (WHERE ss_quantity BETWEEN 1 AND 20) AS bucket1_avg_ext_tax,
    AVG(ss_net_paid_inc_tax) FILTER (WHERE ss_quantity BETWEEN 1 AND 20) AS bucket1_avg_net_paid_inc_tax,
    COUNT(*) FILTER (WHERE ss_quantity BETWEEN 21 AND 40) AS bucket2_count,
    AVG(ss_ext_tax) FILTER (WHERE ss_quantity BETWEEN 21 AND 40) AS bucket2_avg_ext_tax,
    AVG(ss_net_paid_inc_tax) FILTER (WHERE ss_quantity BETWEEN 21 AND 40) AS bucket2_avg_net_paid_inc_tax,
    COUNT(*) FILTER (WHERE ss_quantity BETWEEN 41 AND 60) AS bucket3_count,
    AVG(ss_ext_tax) FILTER (WHERE ss_quantity BETWEEN 41 AND 60) AS bucket3_avg_ext_tax,
    AVG(ss_net_paid_inc_tax) FILTER (WHERE ss_quantity BETWEEN 41 AND 60) AS bucket3_avg_net_paid_inc_tax,
    COUNT(*) FILTER (WHERE ss_quantity BETWEEN 61 AND 80) AS bucket4_count,
    AVG(ss_ext_tax) FILTER (WHERE ss_quantity BETWEEN 61 AND 80) AS bucket4_avg_ext_tax,
    AVG(ss_net_paid_inc_tax) FILTER (WHERE ss_quantity BETWEEN 61 AND 80) AS bucket4_avg_net_paid_inc_tax,
    COUNT(*) FILTER (WHERE ss_quantity BETWEEN 81 AND 100) AS bucket5_count,
    AVG(ss_ext_tax) FILTER (WHERE ss_quantity BETWEEN 81 AND 100) AS bucket5_avg_ext_tax,
    AVG(ss_net_paid_inc_tax) FILTER (WHERE ss_quantity BETWEEN 81 AND 100) AS bucket5_avg_net_paid_inc_tax
  FROM store_sales
) AS subquery;SELECT
  CASE
    WHEN bucket1_count > 1071 THEN bucket1_avg_ext_tax
    ELSE bucket1_avg_net_paid_inc_tax
  END AS bucket1,
  CASE
    WHEN bucket2_count > 39161 THEN bucket2_avg_ext_tax
    ELSE bucket2_avg_net_paid_inc_tax
  END AS bucket2,
  CASE
    WHEN bucket3_count > 29434 THEN bucket3_avg_ext_tax
    ELSE bucket3_avg_net_paid_inc_tax
  END AS bucket3,
  CASE
    WHEN bucket4_count > 6568 THEN bucket4_avg_ext_tax
    ELSE bucket4_avg_net_paid_inc_tax
  END AS bucket4,
  CASE
    WHEN bucket5_count > 21216 THEN bucket5_avg_ext_tax
    ELSE bucket5_avg_net_paid_inc_tax
  END AS bucket5
FROM (
  SELECT
    COUNT(*) FILTER (WHERE ss_quantity BETWEEN 1 AND 20) AS bucket1_count,
    AVG(ss_ext_tax) FILTER (WHERE ss_quantity BETWEEN 1 AND 20) AS bucket1_avg_ext_tax,
    AVG(ss_net_paid_inc_tax) FILTER (WHERE ss_quantity BETWEEN 1 AND 20) AS bucket1_avg_net_paid_inc_tax,
    COUNT(*) FILTER (WHERE ss_quantity BETWEEN 21 AND 40) AS bucket2_count,
    AVG(ss_ext_tax) FILTER (WHERE ss_quantity BETWEEN 21 AND 40) AS bucket2_avg_ext_tax,
    AVG(ss_net_paid_inc_tax) FILTER (WHERE ss_quantity BETWEEN 21 AND 40) AS bucket2_avg_net_paid_inc_tax,
    COUNT(*) FILTER (WHERE ss_quantity BETWEEN 41 AND 60) AS bucket3_count,
    AVG(ss_ext_tax) FILTER (WHERE ss_quantity BETWEEN 41 AND 60) AS bucket3_avg_ext_tax,
    AVG(ss_net_paid_inc_tax) FILTER (WHERE ss_quantity BETWEEN 41 AND 60) AS bucket3_avg_net_paid_inc_tax,
    COUNT(*) FILTER (WHERE ss_quantity BETWEEN 61 AND 80) AS bucket4_count,
    AVG(ss_ext_tax) FILTER (WHERE ss_quantity BETWEEN 61 AND 80) AS bucket4_avg_ext_tax,
    AVG(ss_net_paid_inc_tax) FILTER (WHERE ss_quantity BETWEEN 61 AND 80) AS bucket4_avg_net_paid_inc_tax,
    COUNT(*) FILTER (WHERE ss_quantity BETWEEN 81 AND 100) AS bucket5_count,
    AVG(ss_ext_tax) FILTER (WHERE ss_quantity BETWEEN 81 AND 100) AS bucket5_avg_ext_tax,
    AVG(ss_net_paid_inc_tax) FILTER (WHERE ss_quantity BETWEEN 81 AND 100) AS bucket5_avg_net_paid_inc_tax
  FROM store_sales
) AS subquery;