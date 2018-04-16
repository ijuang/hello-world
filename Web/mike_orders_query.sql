select
sold_order_id,
order type,
order name,
h.customer_number,
total_price,
adjust_amount,
shipping_surcharge,
delivery_charge,
discount_amount as discount_amount,
--total_price+adjust_amount+discount_amount as order_amount,
h.create_date,
u.user_name,
c.*
 from cliq_sold_order_header h inner join [user] u on u.user_id = h.user_id
 inner join customer c on c.customer_number = u.customer_number
where h.create_date >= '12/31/2017'
order by sold_order_id desc




select
*
 from cliq_sold_order_header
where create_date >= '12/31/2017'
order by sold_order_id desc


select
*
 from cliq_sold_order_header
where create_date >= '2018-01-31'
order by sold_order_id desc
