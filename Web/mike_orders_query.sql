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


SELECT a.[sold_order_id]
      ,a.[order_type]
      ,a.[order_number]
      ,a.[order_name]
      ,a.[customer_number]
      ,a.[user_id]
	  ,a.[create_date]
	  ,(a.total_price)+(a.adjust_amount)-(a.discount_amount)+(a.shipping_surcharge)+(a.delivery_charge)+(a.tax)-
	  (a.total_coupon_discounted)+(a.special_promotion_value) AS 'sold_order_total'
	  ,b.customer_type
FROM  cliq_sold_order_header a left join customer b on a.customer_number=b.customer_number
WHERE create_date >= GETDATE()-1 and customer_type = 'PRO'
