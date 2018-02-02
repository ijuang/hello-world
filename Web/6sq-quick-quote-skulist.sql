select 
DISTINCT
Replace(Ltrim(Rtrim(Substring(p.product_code,Charindex('-',p.product_code) + 1, Len(p.product_code) - Charindex('-',p.product_code)))), '"','&#34;') AS cabinet_code,
c.category_id,
c.category_code,
pcat.category_id as parent_category_id,
pcat.category_code as parent_category_code,
0 as priority
FROM
product p
INNER JOIN product_category pc
ON p.product_number = pc.product_number
INNER JOIN category c
ON pc.category_id = c.category_id
LEFT JOIN category pcat
ON c.parent_category_id = pcat.category_id
WHERE p.product_type = 'K'
AND (c.category_type_code = 'QP' OR c.category_type_code = 'QC')
AND (pcat.category_type_code = 'QP' OR pcat.category_type_code = 'QC')
AND p.product_code NOT LIKE '%AR'
AND p.product_code NOT LIKE '%AL'


/**
So it will get products:
1.	Product type=K
2.	Category_type_code=QP or QC
3.	Product_code not ending with AR or AL

Hope this information is helpful to troubleshoot our data import.
Karen
**/
