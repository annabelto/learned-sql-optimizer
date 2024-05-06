SELECT
    B1.B1_LP,
    B1.B1_CNT,
    B1.B1_CNTD,
    B2.B2_LP,
    B2.B2_CNT,
    B2.B2_CNTD,
    B3.B3_LP,
    B3.B3_CNT,
    B3.B3_CNTD,
    B4.B4_LP,
    B4.B4_CNT,
    B4.B4_CNTD,
    B5.B5_LP,
    B5.B5_CNT,
    B5.B5_CNTD,
    B6.B6_LP,
    B6.B6_CNT,
    B6.B6_CNTD
FROM
    (SELECT
        AVG(ss_list_price) AS B1_LP,
        COUNT(ss_list_price) AS B1_CNT,
        COUNT(DISTINCT ss_list_price) AS B1_CNTD
    FROM store_sales
    WHERE ss_quantity BETWEEN 0 AND 5
        AND (ss_list_price BETWEEN 107 AND 117
            OR ss_coupon_amt BETWEEN 1319 AND 2319
            OR ss_wholesale_cost BETWEEN 60 AND 80)) B1,
    (SELECT
        AVG(ss_list_price) AS B2_LP,
        COUNT(ss_list_price) AS B2_CNT,
        COUNT(DISTINCT ss_list_price) AS B2_CNTD
    FROM store_sales
    WHERE ss_quantity BETWEEN 6 AND 10
        AND (ss_list_price BETWEEN 23 AND 33
            OR ss_coupon_amt BETWEEN 825 AND 1825
            OR ss_wholesale_cost BETWEEN 43 AND 63)) B2,
    (SELECT
        AVG(ss_list_price) AS B3_LP,
        COUNT(ss_list_price) AS B3_CNT,
        COUNT(DISTINCT ss_list_price) AS B3_CNTD
    FROM store_sales
    WHERE ss_quantity BETWEEN 11 AND 15
        AND (ss_list_price BETWEEN 74 AND 84
            OR ss_coupon_amt BETWEEN 4381 AND 5381
            OR ss_wholesale_cost BETWEEN 57 AND 77)) B3,
    (SELECT
        AVG(ss_list_price) AS B4_LP,
        COUNT(ss_list_price) AS B4_CNT,
        COUNT(DISTINCT ss_list_price) AS B4_CNTD
    FROM store_sales
    WHERE ss_quantity BETWEEN 16 AND 20
        AND (ss_list_price BETWEEN 89 AND 99
            OR ss_coupon_amt BETWEEN 3117 AND 4117
            OR ss_wholesale_cost BETWEEN 68 AND 88)) B4,
    (SELECT
        AVG(ss_list_price) AS B5_LP,
        COUNT(ss_list_price) AS B5_CNT,
        COUNT(DISTINCT ss_list_price) AS B5_CNTD
    FROM store_sales
    WHERE ss_quantity BETWEEN 21 AND 25
        AND (ss_list_price BETWEEN 58 AND 68
            OR ss_coupon_amt BETWEEN 9402 AND 10402
            OR ss_wholesale_cost BETWEEN 38 AND 58)) B5,
    (SELECT
        AVG(ss_list_price) AS B6_LP,
        COUNT(ss_list_price) AS B6_CNT,
        COUNT(DISTINCT ss_list_price) AS B6_CNTD
    FROM store_sales
    WHERE ss_quantity BETWEEN 26 AND 30
        AND (ss_list_price BETWEEN 64 AND 74
            OR ss_coupon_amt BETWEEN 5792 AND 6792
            OR ss_wholesale_cost BETWEEN 73 AND 93)) B6;