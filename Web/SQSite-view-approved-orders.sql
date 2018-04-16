-- This is the query to build the view in SQSite for approved_orders
-- This view is used by the DTS job
-- Only shows orders that is in "AO" status

USE [SQSite]
GO

/****** Object:  View [dbo].[approved_order]    Script Date: 2/2/2018 3:56:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

/* all lines of orders that are approved and need to be submitted */
CREATE VIEW [dbo].[approved_order]
AS
  SELECT   TOP 10000 o.order_id                                                    AS oid,
                     ci.system_number                                              AS sysno,
                     CASE Len(cust.branch_number)
                       WHEN 1
                       THEN '0000' + Convert(CHAR,cust.branch_number)
                       ELSE '000' + Convert(CHAR,cust.branch_number)
                     END AS branch_number,
                     o.card_number,
                     ci.create_date                                                AS cart_item_create_date,
                     ci.cart_item_id,
                     ci.cart_item_status,
                     o.comments,
                     o.shipping_comments,
                      o.build_comments,
     --                case
                                  --       when ci.order_sort % 1000 <> 0 or (o.order_status <> 'sp' and ci.order_sort % 1000 = 0 and p.product_code in (select 'SV0252' as product_code union select 'SV0253' as product_code union select distinct product_code from shipping_option))
                                  --       then null
                                  --       else o.build_comments
                                  --end as build_comments,


                     u.customer_number,
                     o.csc,
                     o.expiration_date,
                     CASE ci.product_category
                       WHEN 'UNK'
                       THEN 1
                       ELSE scf.forwo
                     END AS forwo,
                     o.is_blind_shipment,
                     o.is_partial_shipment_allowed,
                     o.is_bid_sale,
                     Coalesce(o.customer_ship_to_number,pa.customer_ship_to_number,
                              ca.customer_ship_to_number) AS customer_ship_to_number,
                     scf.itemdesc,
                     isnull(ci.elite_style, ci.multi_option) as multi_option,
                     scf.notreqd,
                     o.create_date                                                 AS order_create_date,
                     o.order_freight,
                     o.order_freight_cost,
                     o.order_id,
                     o.order_number,
                     o.order_status,
                     o.order_tax,
                     o.order_total,
                     o.is_taxable,
                     scf.partmarkup,
                     o.payment_method,
                     o.po_number,
                     ci.product_category,
                     ci.product_number,
                     ci.quantity,
                     ci.original_quantity,
                     ci.quoted_price       AS quoted_price,
                     o.reference_id,
                     scf.scfid,
                     CASE
                       WHEN ci.selected = 1
                       THEN scf.segno
                       ELSE NULL
                     END AS segno,
                     o.shipping_service_id,
                  --   CASE
                   --    WHEN order_address.default_mot = 'GRR'
                   --    THEN Coalesce(ss.residential_service_code,ss.service_code)
                   --    ELSE ss.service_code
                  --   END AS shipping_service_code,
                     --bsc.carrier_id                                                AS shipping_carrier_id,
                     --bsc.carrier_name                                             AS shipping_carrier_name,
               ss.service_code                                          AS shipping_service_code,
               ss.carrier_id                                                AS shipping_carrier_id,
                     ss.carrier_name                                             AS shipping_carrier_name,
                     ci.system_number,
                     ci.system_revision,
                     scf.udc,
                     scf.udcval,
                     o.update_date,
                     ci.user_id,
                     '        ' + ci.build_warehouse                               AS build_warehouse,
                     '        ' + b.warehouse                                      AS warehouse,
                     product_category_code.category_code,
                     Coalesce(item_sequence.SEQUENCE,item_sequence_other.SEQUENCE) AS item_sequence,
                     dbo.Fn_gettextinstructions(ci.cart_item_id)                   AS configuration_instructions,
                     cust.is_credit_restricted,
                     o.approvernumber--@20100302 hz:add approverNumber
                     ,case  when ci.order_sort > 0 then ci.order_sort else -1 end as order_sort --@20110818 hz:add
                     ,o.estimated_shipping_date --@20110824 HZ add
                     , ci.work_order_type -- @March 19, 2013 HZ


                     ,o.release_date
                     ,o.jde_call
                     ,o.rma_claim
                     ,o.send_ack_flag
                     ,u.first_name + ' ' + u.last_name as rdwho
                     ,left(u.phone_number, 3) as phone_prefix
                     ,substring(u.phone_number, 4, 20) as phone
                     ,ci.RoutingOpSeq

  FROM     [order] o
           INNER JOIN cart_item ci
             ON o.order_id = ci.order_id
                AND o.order_status = ci.cart_item_status
           INNER JOIN [product] p
             ON p.product_number = ci.product_number
           LEFT JOIN distaw6sq.dbo.specdetail sd
             ON ci.system_number = sd.sysno
           LEFT JOIN distaw6sq.dbo.sysconfigfmt scf
             ON (sd.sysno = scf.sysno
                 AND ci.product_category = scf.prodcat)
           INNER JOIN [user] u
             ON ci.user_id = u.user_id
           INNER JOIN customer cust
             ON u.customer_number = cust.customer_number
           INNER JOIN branch b
             ON b.branch_number = cust.branch_number
           INNER JOIN order_address
             ON o.order_id = order_address.order_id

         --  INNER JOIN shipping_service ss
         --    ON ss.shipping_service_id = o.shipping_service_id
          -- INNER JOIN branch_service_carrier bsc
         --    ON bsc.build_warehouse = ci.build_warehouse
             --   AND bsc.SERVICE = ss.service_code
        INNER JOIN shipping_option ss
              ON ss.option_id = o.shipping_service_id

           LEFT JOIN site
             ON cust.customer_number = site.base_customer_number
           INNER JOIN (SELECT   customer_number,
                                Min(customer_ship_to_number) AS customer_ship_to_number
                       FROM     customer_address
                       WHERE    customer_ship_to_number IS NOT NULL
                       GROUP BY customer_number) ca
             ON ca.customer_number = u.customer_number
           LEFT JOIN customer_address pa
             ON u.customer_number = pa.customer_number
                AND u.customer_number = pa.customer_ship_to_number
           LEFT JOIN (SELECT product_number,
                             category_code
                      FROM   product_category
                             INNER JOIN category
                               ON category.category_id = product_category.category_id
                      WHERE  category_type_code = 'S3'
                             AND parent_category_id = 0) product_category_code
             ON ci.product_number = product_category_code.product_number
           LEFT JOIN item_sequence
             ON item_sequence.build_warehouse = ci.build_warehouse
                AND item_sequence.TYPE = 'WO'
                AND ((p.product_code NOT LIKE 'BS____'
                      AND item_sequence.VALUE = product_category_code.category_code)
                      OR (p.product_code LIKE 'BS____'
                          AND item_sequence.VALUE = 'BS item numbers'))
           LEFT JOIN item_sequence item_sequence_other
             ON item_sequence_other.build_warehouse = ci.build_warehouse
                AND item_sequence_other.TYPE = 'WO'
                AND item_sequence_other.VALUE = 'all other items'
  WHERE    o.order_status = 'AO'
           AND site.base_customer_number IS NULL
           AND order_address.address_is_ship_to = 1



--AND O.ORDER_ID IN (283472  )


  ORDER BY o.order_id,
           ci.system_number
