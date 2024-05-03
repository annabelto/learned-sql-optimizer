explain select c_customer_id AS customer_id,
       COALESCE(c_last_name, '') || ', ' || COALESCE(c_first_name, '') AS customername
FROM (
    SELECT c_customer_id, c_last_name, c_first_name, c_current_cdemo_sk, c_current_hdemo_sk, c_current_addr_sk
    FROM customer
) c
JOIN (
    SELECT ca_address_sk
    FROM customer_address
    WHERE ca_city = 'Woodland'
) ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN (
    SELECT cd_demo_sk, c_current_cdemo_sk
    FROM customer_demographics
) cd ON c.c_current_cdemo_sk = cd.cd_demo_sk
JOIN (
    SELECT hd_demo_sk, hd_income_band_sk
    FROM household_demographics
) hd ON c.c_current_hdemo_sk = hd.hd_demo_sk
JOIN (
    SELECT ib_income_band_sk
    FROM income_band
    WHERE ib_lower_bound >= 60306 AND ib_upper_bound <= 60306 + 50000
) ib ON hd.hd_income_band_sk = ib.ib_income_band_sk
JOIN (
    SELECT sr_cdemo_sk
    FROM store_returns
) sr ON cd.cd_demo_sk = sr.sr_cdemo_sk
ORDER BY c_customer_id
LIMIT 100;SELECT c_customer_id AS customer_id,
       COALESCE(c_last_name, '') || ', ' || COALESCE(c_first_name, '') AS customername
FROM (
    SELECT c_customer_id, c_last_name, c_first_name, c_current_cdemo_sk, c_current_hdemo_sk, c_current_addr_sk
    FROM customer
) c
JOIN (
    SELECT ca_address_sk
    FROM customer_address
    WHERE ca_city = 'Woodland'
) ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN (
    SELECT cd_demo_sk, c_current_cdemo_sk
    FROM customer_demographics
) cd ON c.c_current_cdemo_sk = cd.cd_demo_sk
JOIN (
    SELECT hd_demo_sk, hd_income_band_sk
    FROM household_demographics
) hd ON c.c_current_hdemo_sk = hd.hd_demo_sk
JOIN (
    SELECT ib_income_band_sk
    FROM income_band
    WHERE ib_lower_bound >= 60306 AND ib_upper_bound <= 60306 + 50000
) ib ON hd.hd_income_band_sk = ib.ib_income_band_sk
JOIN (
    SELECT sr_cdemo_sk
    FROM store_returns
) sr ON cd.cd_demo_sk = sr.sr_cdemo_sk
ORDER BY c_customer_id
LIMIT 100;