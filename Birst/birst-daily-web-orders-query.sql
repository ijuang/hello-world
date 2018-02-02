SELECT Sum(total_price) + Sum(adjust_amount) - Sum(discount_amount) + Sum( 
              shipping_surcharge) + Sum(delivery_charge) + Sum(tax) AS
       'web order daily total',
       CONVERT(DATE, create_date)                                   AS 'date'
FROM   cliq_sold_order_header
GROUP  BY CONVERT(DATE, create_date)
ORDER  BY CONVERT(DATE, create_date) DESC
