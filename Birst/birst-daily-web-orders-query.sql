SELECT Sum(total_price) + Sum(adjust_amount) - Sum(discount_amount) + Sum(
              shipping_surcharge) + Sum(delivery_charge) + Sum(tax)
              - Sum(total_coupon_discounted) + sum(special_promotion_value) AS
       'web order daily total',
       CONVERT(DATE, create_date)                                   AS 'date'
FROM   cliq_sold_order_header
WHERE create_date >= GETDATE()-1
GROUP  BY CONVERT(DATE, create_date)
ORDER  BY CONVERT(DATE, create_date) DESC



//****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [sold_order_id]
      ,[order_type]
      ,[order_number]
      ,[order_name]
      ,[customer_number]
      ,[user_id]
      ,[discount]

      ,[total_price]
      ,[adjust_amount]
      ,[discount_amount]
      ,[shipping_surcharge]
      ,[delivery_charge]
      ,[tax]
      ,[total_coupon_discounted]
      ,[special_promotion_value]

      ,[total_price_discounted]
      ,[adjust_amount_discounted]

      ,[CSR]
      ,[ACD]
      ,[payment_option]
      ,[tracking_number]
      ,[create_date]
      ,[update_date]
      ,[style_id]
      ,[chk_profile_overwrite]
      ,[delivery_condition]
      ,[delivery_comment]
      ,[quote_id]
  FROM [SQSite].[dbo].[cliq_sold_order_header]
