/* REQUEST 9
Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? 
The final output contains these fields, 
	channel 
    gross_sales_mln 
    percentage
*/

WITH gross_sales_by_channel AS (
	SELECT
		c.channel,
		ROUND(SUM(s.sold_quantity * g.gross_price)/1000000,2) AS gross_sales_mln
	FROM fact_gross_price g
	JOIN fact_sales_monthly s USING(product_code, fiscal_year)
	JOIN dim_customer c USING(customer_code)
	WHERE s.fiscal_year = 2021
	GROUP BY c.channel
)
SELECT 
	*,
    ROUND((gross_sales_mln/(SELECT SUM(gross_sales_mln) FROM gross_sales_by_channel)*100),2) AS percentage
FROM gross_sales_by_channel
ORDER BY gross_sales_mln DESC;
