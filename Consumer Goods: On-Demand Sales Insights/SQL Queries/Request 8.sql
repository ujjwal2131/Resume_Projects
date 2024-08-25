/* REQUEST 8
In which quarter of 2020, got the maximum total_sold_quantity? 
The final output contains these fields sorted by the total_sold_quantity, 
	Quarter 
    total_sold_quantity
*/

WITH quarter_sales AS (
	SELECT 
		*,
		CONCAT('Q', CEILING(MONTH(DATE_ADD(date, INTERVAL 4 MONTH))/3)) AS quarter_nm
	FROM fact_sales_monthly s
    WHERE fiscal_year = 2020
)
SELECT
	quarter_nm,
    ROUND(SUM(sold_quantity)/1000000,2) AS total_sold_qty_mln
FROM quarter_sales
GROUP BY quarter_nm
ORDER BY total_sold_qty_mln DESC;