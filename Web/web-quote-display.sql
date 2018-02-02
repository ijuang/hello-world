SELECT @transaction_id                    AS transaction_id, 
       freight_cost                       AS freight, 
       csr, 
       acd, 
       customer_number, 
       adjust_amount, 
       order_id                           AS quote_id, 
       [user_id]                          AS login_user_id, 
       quote_name, 
       total_price                        AS item_total, 
       style_id, 
       multiplier                         AS promotion_discount, 
       CASE 
         WHEN [type] = 'SQ' THEN 'quote' 
         WHEN [type] = '2020SQ' THEN '2020quote' 
       END                                AS cart_type, 
       create_date, 
       update_date, 
       Isnull(special_promotion_value, 0) AS special_promotion 
FROM   quote_cliq_header 
WHERE  [user_id] = @user_id 
ORDER  BY order_id, 
          [type]; 