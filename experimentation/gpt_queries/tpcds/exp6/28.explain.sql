explain select
    *
FROM
    (
        SELECT
            AVG(ss_list_price) AS B1_LP,
            COUNT(ss_list_price) AS B1_CNT,
            COUNT(DISTINCT ss_list_price) AS B1_CNTD
        FROM
            store_sales
        WHERE
            ss_quantity BETWEEN 0 AND 5
            AND (
                ss_list_price BETWEEN 107 AND 117
                OR ss_coupon_amt BETWEEN 1319 AND 2319
                OR ss_wholesale_cost BETWEEN 60 AND 80
            )
    ) AS B1,
    (
        SELECT
            AVG(ss_list_price) AS B2_LP,
            COUNT(ss_list_price) AS B2_CNT,
            COUNT(DISTINCT ss_list_price) AS B2_CNTD
        FROM
            store_sales
        WHERE
            ss_quantity BETWEEN 6 AND 10
            AND (
                ss_list_price BETWEEN 23 AND 33
                OR ss_coupon_amt BETWEEN 825 AND 1825
                OR ss_wholesale_cost BETWEEN 43 AND 63
            )
    ) AS B2,
    (
        SELECT
            AVG(ss_list_price) AS B3_LP,
            COUNT(ss_list_price) AS B3_CNT,
            COUNT(DISTINCT ss_list_price) AS B3_CNTD
        FROM
            store_sales
        WHERE
            ss_quantity BETWEEN 11 AND 15
            AND (
                ss_list_price BETWEEN 74 AND 84
                OR ss_coupon_amt BETWEEN 4381 AND 5381
                OR ss_wholesale_cost BETWEEN 57 AND 77
            )
    ) AS B3,
    (
        SELECT
            AVG(ss_list_price) AS B4_LP,
            COUNT(ss_list_price) AS B4_CNT,
            COUNT(DISTINCT ss_list_price) AS B4_CNTD
        FROM
            store_sales
        WHERE
            ss_quantity BETWEEN 16 AND 20
            AND (
                ss_list_price BETWEEN 89 AND 99
                OR ss_coupon_amt BETWEEN 3117 AND 4117
                OR ss_wholesale_cost BETWEEN 68 AND 88
            )
    ) AS B4,
    (
        SELECT
            AVG(ss_list_price) AS B5_LP,
            COUNT(ss_list_price) AS B5_CNT,
            COUNT(DISTINCT ss_list_price) AS B5_CNTD
        FROM
            store_sales
        WHERE
            ss_quantity BETWEEN 21 AND 25
            AND (
                ss_list_price BETWEEN 58 AND 68
                OR ss_coupon_amt BETWEEN 9402 AND 10402
                OR ss_wholesale_cost BETWEEN 38 AND 58
            )
    ) AS B5,
    (
        SELECT
            AVG(ss_list_price) AS B6_LP,
            COUNT(ss_list_price) AS B6_CNT,
            COUNT(DISTINCT ss_list_price) AS B6_CNTD
        FROM
            store_sales
        WHERE
            ss_quantity BETWEEN 26 AND 30
            AND (
                ss_list_price BETWEEN 64 AND 74
                OR ss_coupon_amt BETWEEN 5792 AND 6792
                OR ss_wholesale_cost BETWEEN 73 AND 93
            )
    ) AS B6
LIMIT 100;SELECT
    *
FROM
    (
        SELECT
            AVG(ss_list_price) AS B1_LP,
            COUNT(ss_list_price) AS B1_CNT,
            COUNT(DISTINCT ss_list_price) AS B1_CNTD
        FROM
            store_sales
        WHERE
            ss_quantity BETWEEN 0 AND 5
            AND (
                ss_list_price BETWEEN 107 AND 117
                OR ss_coupon_amt BETWEEN 1319 AND 2319
                OR ss_wholesale_cost BETWEEN 60 AND 80
            )
    ) AS B1,
    (
        SELECT
            AVG(ss_list_price) AS B2_LP,
            COUNT(ss_list_price) AS B2_CNT,
            COUNT(DISTINCT ss_list_price) AS B2_CNTD
        FROM
            store_sales
        WHERE
            ss_quantity BETWEEN 6 AND 10
            AND (
                ss_list_price BETWEEN 23 AND 33
                OR ss_coupon_amt BETWEEN 825 AND 1825
                OR ss_wholesale_cost BETWEEN 43 AND 63
            )
    ) AS B2,
    (
        SELECT
            AVG(ss_list_price) AS B3_LP,
            COUNT(ss_list_price) AS B3_CNT,
            COUNT(DISTINCT ss_list_price) AS B3_CNTD
        FROM
            store_sales
        WHERE
            ss_quantity BETWEEN 11 AND 15
            AND (
                ss_list_price BETWEEN 74 AND 84
                OR ss_coupon_amt BETWEEN 4381 AND 5381
                OR ss_wholesale_cost BETWEEN 57 AND 77
            )
    ) AS B3,
    (
        SELECT
            AVG(ss_list_price) AS B4_LP,
            COUNT(ss_list_price) AS B4_CNT,
            COUNT(DISTINCT ss_list_price) AS B4_CNTD
        FROM
            store_sales
        WHERE
            ss_quantity BETWEEN 16 AND 20
            AND (
                ss_list_price BETWEEN 89 AND 99
                OR ss_coupon_amt BETWEEN 3117 AND 4117
                OR ss_wholesale_cost BETWEEN 68 AND 88
            )
    ) AS B4,
    (
        SELECT
            AVG(ss_list_price) AS B5_LP,
            COUNT(ss_list_price) AS B5_CNT,
            COUNT(DISTINCT ss_list_price) AS B5_CNTD
        FROM
            store_sales
        WHERE
            ss_quantity BETWEEN 21 AND 25
            AND (
                ss_list_price BETWEEN 58 AND 68
                OR ss_coupon_amt BETWEEN 9402 AND 10402
                OR ss_wholesale_cost BETWEEN 38 AND 58
            )
    ) AS B5,
    (
        SELECT
            AVG(ss_list_price) AS B6_LP,
            COUNT(ss_list_price) AS B6_CNT,
            COUNT(DISTINCT ss_list_price) AS B6_CNTD
        FROM
            store_sales
        WHERE
            ss_quantity BETWEEN 26 AND 30
            AND (
                ss_list_price BETWEEN 64 AND 74
                OR ss_coupon_amt BETWEEN 5792 AND 6792
                OR ss_wholesale_cost BETWEEN 73 AND 93
            )
    ) AS B6
LIMIT 100;