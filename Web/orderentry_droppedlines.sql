--To get Web Order Total:
select order_number, order_id, update_date, order_total, order_status
from [order]
where order_status not in ('D','O', 'Q', 'AN', 'AH', 'A1', 'A2')
and update_date >= '2017-11-20 00:00:00'


--To get JDE Order Total at submission time:
--order_details > details that submitted to JDE
select m.order_number, m.order_id, m.date_entered, sum(d.extended_price/100)
from [order] m
inner join [order_details] d on d.document_number = m.order_number
where m.date_entered >= '2017-11-15'
group by m.order_number, m.order_id, m.date_entered
go


--To get JDE Order Total at current time:
--Order_item > edit order page (detail)
select m.order_number, m.order_id, m.date_entered, sum(d.extended_price)
from [order] m
inner join [order_item] d on d.order_number = m.order_number
where m.date_entered >= '2017-11-15'
group by m.order_number, m.order_id, m.date_entered
go
