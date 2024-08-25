/* ADD ON RESEARCH 3
Impact of Discounts on Sales:
Analyze the impact of different discount rates on sales volumes.
The final output should contain these fields:
	customer,
    market,
    fiscal_year,
    discount_rate
	gross_sales_mln
	total_sold_quantity            
Identify top 10 customer in 2021 by gross_sales    
*/

SELECT
	dc.customer,
	dc.market,
	fsm.fiscal_year,
	fp.pre_invoice_discount_pct AS discount_rate,
	ROUND(SUM(fsm.sold_quantity * fgp.gross_price) /1000000, 2) AS gross_sales_mln,
	SUM(fsm.sold_quantity) AS total_sold_quantity
FROM fact_sales_monthly fsm
JOIN fact_pre_invoice_deductions fp ON fsm.customer_code = fp.customer_code AND fsm.fiscal_year = fp.fiscal_year
JOIN fact_gross_price fgp ON fsm.product_code = fgp.product_code AND fsm.fiscal_year = fgp.fiscal_year
JOIN dim_customer dc ON fsm.customer_code = dc.customer_code
WHERE fsm.fiscal_year = 2021
GROUP BY 
	dc.customer, dc.market, fsm.fiscal_year
ORDER BY gross_sales_mln DESC
LIMIT 10;