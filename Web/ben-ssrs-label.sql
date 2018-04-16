--To get Web Order Total:
select order_number, order_id, update_date, order_total, order_status
from [order]
where order_status = 'OO'
and update_date >= GETDATE()

-- Get order branch - Join to Customer number and branch
-- Get order type


-- To select a list of orders to search for labels
select
o.order_number, o.order_id, o.update_date, o.order_total, o.order_status,
c.cabinet_order_id, c.branch_number,c.cabinet_count, c.create_date,c.order_type
from [order] o left join [cabinetorder_extension] c on o.order_id = c.cabinet_order_ID
where order_status = 'OO'
and update_date >= GETDATE()-1
