select 
    c_last_name,
    c_first_name,
    c_salutation,
    c_preferred_cust_flag,
    ss_ticket_number,
    cnt 
from (
    select 
        ss_ticket_number,
        ss_customer_sk,
        count(*) as cnt 
    from 
        store_sales
    join 
        date_dim on store_sales.ss_sold_date_sk = date_dim.d_date_sk
    join 
        store on store_sales.ss_store_sk = store.s_store_sk
    join 
        household_demographics on store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk
    where 
        (date_dim.d_dom between 1 and 3 or date_dim.d_dom between 25 and 28) 
        and (household_demographics.hd_buy_potential = '1001-5000' or household_demographics.hd_buy_potential = '0-500') 
        and household_demographics.hd_vehicle_count > 0 
        and household_demographics.hd_dep_count / household_demographics.hd_vehicle_count > 1.2 
        and date_dim.d_year in (2000, 2001, 2002) 
        and store.s_county = 'Williamson County' 
    group by 
        ss_ticket_number,
        ss_customer_sk
) dn
join 
    customer on dn.ss_customer_sk = c_customer_sk
where 
    cnt between 15 and 20 
order by 
    c_last_name,
    c_first_name,
    c_salutation,
    c_preferred_cust_flag desc, 
    ss_ticket_number;