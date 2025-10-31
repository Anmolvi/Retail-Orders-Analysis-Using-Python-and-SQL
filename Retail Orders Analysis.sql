create database project;
use project;

select * from orders_data;
describe orders_data;

-- Write a sql query to list all distinct cities where orders have been shipped.
select distinct(city) from orders_data;

-- Calculate the total selling price and profits for all the orders.
select order_id, sum(unit_selling_price * quantity) as Total_Selling_Price,
round(sum(unit_profit*quantity),2) as Total_Profit 
from orders_data
group by order_id
order by total_profit desc;

-- Write a query to find all orders from the "Technology" category that were shipped using "Second Class" ship mode, ordered by order date.
select * from orders_data;

select * from orders_data
where category = "Technology" and ship_mode = "Second Class"
order by Order_Date;

-- write a query to Find the Average Order Value
select round(avg(unit_selling_price*quantity),2) from orders_data;

-- Write a query to Find the city with the highest total quantity of products ordered
select city, sum(quantity) as max_quantity
from orders_data
group by city
order by max_quantity desc
limit 1;

-- Write a query using window function to Rank orders in each region by quantity in descending order
select * from orders_Data;

select order_id, region, quantity, 
dense_rank() over(partition by region order by quantity desc) as rnk 
from orders_data
order by region, rnk;

-- Write a sql query to List all the orders placed in the first quarter of any year (January to March), including the total cost for these orders

select order_id, sum(quantity*unit_selling_price) as Total_Value
from orders_data
where month(order_date) in (1,2,3)
group by order_id
order by Total_Value desc;

-- Find top 10 highest profit generating products

select * from orders_data;

select round(sum(total_profit),2), product_id 
from orders_data
group by product_id
order by sum(total_profit) desc
limit 10;

-- alternate
with cte as (select round(sum(total_profit),2) as profit, product_id,
dense_rank() over(order by sum(total_profit) desc) as rn
from orders_data
group by product_id)
select product_id, profit
from cte where rn<=10;

-- Find the top 3 highest selling products in each region

select region, product_id, round(sum(quantity*unit_selling_price),2) as Total_sales 
from orders_data
group by region, product_id
order by Total_sales desc
limit 3;

with cte as (select region, product_id, 
round(sum(quantity*unit_selling_price),2) as Total_sales,
row_number() over(partition by region order by round(sum(quantity*unit_selling_price),2) desc) as rn
from orders_data
group by region, product_id)
select * from cte
where rn<=3;

-- Find month over month growth comparison for 2022 and 2023 sales eg: jan 2022 vs jan 2023

select year(order_date) from orders_data;

with cte as (
select year(order_date) as year_order, month(order_date) as month_order, 
sum(quantity*unit_selling_price) as Total_sales
from orders_data
group by year(order_date),month(order_date)
)
select month_order,
round(sum(case when year_order = 2022 then Total_sales else 0 end),2) as sales_2022,
round(sum(case when year_order = 2023 then Total_sales else 0 end),2) as sales_2023
from cte
group by month_order
order by month_order;

-- with month name

with cte as (
select year(order_date) as year_order, monthname(order_date) as month_order, 
sum(quantity*unit_selling_price) as Total_sales
from orders_data
group by year(order_date),monthname(order_date)
)
select month_order,
round(sum(case when year_order = 2022 then Total_sales else 0 end),2) as sales_2022,
round(sum(case when year_order = 2023 then Total_sales else 0 end),2) as sales_2023
from cte
group by month_order
order by month_order;


-- for each category which month had highest sales

select category, month(order_date), round(sum(quantity*unit_selling_price),2) as sales from orders_data
group by month(order_date), category
order by sales desc
limit 3;

select category, round(sum(quantity*unit_selling_price),2) as sales
from orders_data
where category = "Technology" and
month(order_date) = 10 and
year(order_date) = 2023;

-- which sub category had the highest growth by sales in 2023 compare to 2022
with cte as (
select sub_category, year(order_date) as order_year, round(sum(quantity*unit_selling_price),2) as sales
from orders_data
group by sub_category, year(order_date)
), cte2 as (
select sub_category,
round(sum(case when order_year = 2022 then sales else 0 end),2) as Sales_2022,
round(sum(case when order_year = 2023 then sales else 0 end),2) as Sales_2023
from cte
group by sub_category)
select sub_category, sales_2022, sales_2023, round((sales_2023-sales_2022),2) as Diff
from cte2
order by diff desc
limit 1;
