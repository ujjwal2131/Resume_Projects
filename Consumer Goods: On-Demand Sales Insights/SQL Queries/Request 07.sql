/* REQUEST 7
Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month . 
This analysis helps to get an idea of low and high-performing months and take strategic decisions. 
The final report contains these columns: 
	Month 
    Year 
    Gross sales Amount
*/

WITH gross_sales AS (
	SELECT
		MONTHNAME(s.date) AS month_name,
        YEAR(s.date) AS calendar_year,
		s.fiscal_year,
		(s.sold_quantity * g.gross_price) AS gross_amt
	FROM fact_gross_price g
	JOIN fact_sales_monthly s USING(product_code, fiscal_year)
	JOIN dim_customer c USING(customer_code)
	WHERE c.customer = 'Atliq Exclusive'
)
SELECT 
	month_name,
    calendar_year,
    fiscal_year,
    ROUND(SUM(gross_amt)/1000000,2) AS gross_sales_amt_mln
FROM gross_sales
GROUP BY month_name, fiscal_year
ORDER BY fiscal_year;
