-- 1.How many distinct customer types are there in the sales customer table?
select distinct(customer_type)
from sales_customers;

-- 2. How many distinct markets name are there in the sales markets table?

select distinct(markets_name)
from sales_markets;

-- 3. How many distinct product type are there in the sales products table?
select distinct(product_type)
from sales_products;

-- 4. How many customer types are there in the sales customer table and how many customers are assigned to each type?
select count(customer_name) as Total_Customers
from sales_customers;

select customer_type,count(customer_name) as Total_Customers
from sales_customers
group by customer_type;


-- 5. How many customers are there in the sales transactions?
select count(customer_code) 
as Total_Customers
from sales_transactions;


-- 6. what is the sum of sales amount?
select sum(sales_amount) as Total_amount
from sales_transactions;


-- 7. What is the total sales amount for each year in the sales transaction table?
select sum(sales_amount) as Total_amount, year(order_date) as Date
from sales_transactions
group by year(order_date);

-- 8. What is the total sales quantity and sales amount for each customer in the sales transaction table?
select sum(t.sales_qty) as Total_qty,sum(t.sales_amount) as Total_amount,c.customer_name
from sales_transactions as t
join sales_customers as c
on t.customer_code = c.customer_code
group by c.customer_name;


-- 9. Which customer has made the highest sales amount in a single transaction?
SELECT c.custmer_name, t.sales_amount
FROM sales_customers AS c
JOIN sales_transactions AS t ON c.customer_code = t.customer_code
where t.sales_amount=(select max(sales_amount) 
from sales_transactions)
limit 1;


-- 10. What is the total sales quantity and sales amount for each market in a specific year?
SELECT m.markets_name,year(t.order_date), SUM(t.sales_qty) AS quantity, SUM(t.sales_amount) AS total_amount
FROM sales_transactions AS t
JOIN sales_markets AS m ON t.market_code = m.markets_code
WHERE YEAR(t.order_date) = 2017
GROUP BY t.market_code,m.markets_name,year(t.order_date)
order by YEAR(t.order_date);


SELECT m.markets_name,year(t.order_date), SUM(t.sales_qty) AS quantity, SUM(t.sales_amount) AS total_amount
FROM sales_transactions AS t
JOIN sales_markets AS m ON t.market_code = m.markets_code
WHERE YEAR(t.order_date) = t.order_date
GROUP BY t.market_code,m.markets_name,year(t.order_date)
order by YEAR(t.order_date);


-- 11. Which product has the highest sales quantity across all transactions?
select p.product_type,t.sales_qty as Max_qty 
from sales_transactions as t
join sales_products as p
on t.product_code = p.product_code
group by t.product_code,p.product_type,t.sales_qty
order by t.sales_qty desc
limit 1;

-- 12. What is the total sales amount for each customer type in a specific month?
select month(t.order_date) as mon ,sum(t.sales_amount) as total,c.customer_type
from sales_transactions as t
join sales_customers as c
on t.customer_code = c.customer_code
where month(t.order_date)= 3
group by c.customer_type,month(t.order_date);

select month(t.order_date) as mon ,sum(t.sales_amount) as total,c.customer_type
from sales_transactions as t
join sales_customers as c
on t.customer_code = c.customer_code
where month(t.order_date)= month(t.order_date)
group by c.customer_type,month(t.order_date)
order by c.customer_type,month(t.order_date);

-- 13. Which market has the highest sales amount in a specific year and month?
select m.markets_name,Max(t.sales_amount),month(t.order_date) as Max_Month,year(t.order_date) as Max_Yrs
from sales_transactions as t
join sales_markets as m
on t.market_code = m.markets_code
group by m.markets_name,Max_Month,Max_Yrs
order by Max(t.sales_amount) desc;

-- 14. How many sales transactions were made in each zone?
select count(*) as Total_Tans, m.zone 
FROM sales_transactions as t
join sales_markets as m
on t.market_code = m.markets_code
group by m.zone;

-- 15. What is the average sales amount per transaction for each customer type?
select round(avg(t.sales_amount)) as avg_sales,c.customer_type
from sales_transactions as t
join sales_customers as c
on t.customer_code = c.customer_code
group by c.customer_type;


-- 16. Which customer made the earliest order date in the sales transaction table?
select c.customer_name, date(t.order_date) as early_date
from sales_transactions as t
join sales_customers as c
on t.customer_code = c.customer_code
order by early_date asc
limit 1;

-- 17. What is the total sales amount for each product type in a specific year and market?
select p.product_type,sum(t.sales_amount) as total, year(t.order_date) as tran_date
from sales_transactions as t
join sales_products as p
on t.product_code = p.product_code
where p.product_type= p.product_type
group by p.product_type,year(t.order_date);