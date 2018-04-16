--- FRIDAY NIGHT PANKAJ's SQL
select * from
(select a.create_date as web_order_cr_date,b.sold_order_id, a.order_id as web_order_id, a.order_number as jde_order_id
,b.branch_number,b.order_type, a.order_total as web_order_total, b.sample_order_id,a.order_status
from [order] a left outer join [SQSite].[dbo].[cabinetorder_extension] b on a.order_id=b.cabinet_order_id
where a.create_date>='2018-01-21'
and b.order_type<>'XX'
and b.branch_number=5200) a
left outer join
(
select  create_date as sold_order_cr_date, sold_order_id
, sum(total_price) + sum(adjust_amount) - sum(discount_amount) + sum(shipping_surcharge) + sum(delivery_charge) + sum(tax) AS 'sold_order_total'
from cliq_sold_order_header
group by create_date, sold_order_id
) b
on a.sold_order_id=b.sold_order_id



--- FROM FRIDAY NIGHT -----------------

--queries for Sold order
select * from cliq_sold_order_header a left join cliq_card_header b on a.sold_order_id = b.order_id where create_date >= '2017-11-01'

select * from cliq_sold_order_header a left join cliq_card_header b on a.sold_order_id = b.order_id where a.user_id=129229 and a.create_date >='2017-12-01'

-- all SOld Orders that are NOT pay by phone
select * from cliq_sold_order_header where payment_option<>'By Phone' and create_date >= '2017-12-31' and create_date <='2018-01-31'

-- querying cabinetorder_extension based on JDE customer number
select * from [order] a left join [user] b on a.user_id = b.user_id
left join cabinetorder_extension c on a.order_id=c.cabinet_order_id where a.create_date >= '2017-12-01' and b.customer_number=4131519

-- querying cabinetorder_extension based on Web user ID
select * from [order] a left join [user] b on a.user_id = b.user_id
left join cabinetorder_extension c on a.order_id=c.cabinet_order_id where a.create_date >= '2017-12-27' and a.user_id=555402
