SELECT @transaction_id                     AS transaction_id, 
       shipping_surcharge                  AS freight, 
       csr, 
       acd, 
       customer_number, 
       adjust_amount, 
       sold_order_id                       AS quote_id, 
       [user_id]                           AS login_user_id, 
       order_name                          AS quote_name, 
       total_price                         AS item_total, 
       style_id, 
       discount                            AS promotion_discount, 
       CASE 
         WHEN [order_type] = 'website' THEN 'order' 
         WHEN [order_type] = '2020' THEN '2020order' 
       END                                 AS cart_type, 
       create_date, 
       update_date, 
       delivery_charge, 
       tax, 
       Isnull(total_price_discounted, 0)   AS item_total_discounted, 
       Isnull(adjust_amount_discounted, 0) AS adjust_amount_discounted, 
       Isnull(special_promotion_value, 0)  AS special_promotion, 
       Isnull(total_coupon_discounted, 0)  AS coupon_discounted 
FROM   cliq_sold_order_header 
WHERE  [user_id] = @user_id 
ORDER  BY sold_order_id 