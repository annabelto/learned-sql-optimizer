select count(distinct ws1.ws_order_number) as "order count",
       sum(ws1.ws_ext_ship_cost) as "total shipping cost",
       sum(ws1.ws_net_profit) as "total net profit"
from web_sales ws1
join date_dim d on ws1.ws_ship_date_sk = d.d_date_sk
                and d.d_date between '2002-5-01' and (cast('2002-5-01' as date) + 60)
join customer_address ca on ws1.ws_ship_addr_sk = ca.ca_address_sk
                         and ca.ca_state = 'OK'
join web_site ws on ws1.ws_web_site_sk = ws.web_site_sk
                and ws.web_company_name = 'pri'
where exists (
      select * from web_sales ws2
      where ws1.ws_order_number = ws2.ws_order_number
        and ws1.ws_warehouse_sk <> ws2.ws_warehouse_sk
  )
  and not exists (
      select * from web_returns wr1
      where ws1.ws_order_number = wr1.wr_order_number
  )
order by count(distinct ws1.ws_order_number)
limit 100;select count(distinct ws1.ws_order_number) as "order count",
       sum(ws1.ws_ext_ship_cost) as "total shipping cost",
       sum(ws1.ws_net_profit) as "total net profit"
from web_sales ws1
join date_dim d on ws1.ws_ship_date_sk = d.d_date_sk
                and d.d_date between '2002-5-01' and (cast('2002-5-01' as date) + 60)
join customer_address ca on ws1.ws_ship_addr_sk = ca.ca_address_sk
                         and ca.ca_state = 'OK'
join web_site ws on ws1.ws_web_site_sk = ws.web_site_sk
                and ws.web_company_name = 'pri'
where exists (
      select * from web_sales ws2
      where ws1.ws_order_number = ws2.ws_order_number
        and ws1.ws_warehouse_sk <> ws2.ws_warehouse_sk
  )
  and not exists (
      select * from web_returns wr1
      where ws1.ws_order_number = wr1.wr_order_number
  )
order by count(distinct ws1.ws_order_number)
limit 100;