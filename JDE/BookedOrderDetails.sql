SELECT     OrderDate, Branch, OrderNumber, Line, IsOpen, OrderStatusCode, LastStatusCode, Sales, Commcost, Cost, OriginalCost, Item, ItemDesc, ItemDesc2,
                      Quantity, CreditHold, ShippingMethod, ShipDate, PromiseDate, RequestDate, InvoiceDate, Customer, CustomerName, ShipTo, SalesRep,
                      SalesRepName, WareHouse, CountsForRevenue, OrderMethod, JDEOrderType, LineType, Term, Hold, TransactionOriginator, PromisedDlvyDate,
                      SchdPickDate, CustomerPO, KitItemNumber, KitComponentNumber, BID, UnitVolume, OriginalSQOrderNumber, UnitVolumeOfMeasure,
                      DeliveryDate
FROM         SalesDetails
WHERE     CancelDate IS NULL OR
                      CanCelDate <> OrderDate
UNION
SELECT     CancelDate AS OrderDate, Branch, OrderNumber, Line, IsOpen, OrderStatusCode, LastStatusCode, (Sales * - 1) AS Sales, (Commcost * - 1)
                      AS CommCost, (Cost * - 1) AS Cost, (OriginalCost * - 1) AS OriginalCost, Item, ItemDesc, ItemDesc2, Quantity * - 1 AS Quantity, CreditHold,
                      ShippingMethod, ShipDate, PromiseDate, RequestDate, InvoiceDate, Customer, CustomerName, ShipTo, SalesRep, SalesRepName, WareHouse,
                      CountsForRevenue, OrderMethod, JDEOrderType, LineType, Term, Hold, TransactionOriginator, PromisedDlvyDate, SchdPickDate, CustomerPO, 
                      KitItemNumber, KitComponentNumber, BID, UnitVolume, OriginalSQOrderNumber, UnitVolumeOfMeasure, DeliveryDate
FROM         SalesDetails
WHERE     (CancelDate IS NOT NULL AND CancelDate <> OrderDate))
