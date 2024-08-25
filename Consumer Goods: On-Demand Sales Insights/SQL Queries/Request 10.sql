/* REQUEST 10
Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? 
The final output contains these fields, 
	division 
    product_code
    product 
    total_sold_quantity 
    rank_order
*/

WITH sold_qty_by_division AS (
	SELECT 
		p.division,
		p.product_code,
		CONCAT(p.product,' (',p.variant, ')') AS product,
		SUM(s.sold_quantity) AS total_sold_qty
	FROM fact_sales_monthly s
	JOIN dim_product p USING(product_code)
    WHERE s.fiscal_year = 2021
	GROUP BY p.division, p.product_code, p.product
)
,rank_product_by_sold_qty AS (
SELECT 
	*,
    DENSE_RANK() OVER(PARTITION BY division ORDER BY total_sold_qty DESC) AS rank_order
FROM sold_qty_by_division
)
SELECT * FROM rank_product_by_sold_qty WHERE rank_order <= 3;    