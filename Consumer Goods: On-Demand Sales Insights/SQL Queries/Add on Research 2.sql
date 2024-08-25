/* ADD ON RESEARCH 2
Sales Channel Efficiency:
Compare the yearly average order size and frequency of orders across different sales channels (Retailer, Direct, Distributor).
The final output contains these fields,
	channel,
    fiscal_year,
    avg_order_size,
    order_frequency
*/

SELECT 
	dc.channel,
	fsm.fiscal_year,
	ROUND(AVG(fsm.sold_quantity),2) AS avg_order_size,
	COUNT(fsm.customer_code) AS order_frequency
FROM fact_sales_monthly fsm
JOIN dim_customer dc USING(customer_code)
GROUP BY dc.channel, fsm.fiscal_year
ORDER BY avg_order_size DESC;

/*
Note: Here we are finding averge on sold quantity to know the order size and counting on fsm.customer code to know the order frequency
*/