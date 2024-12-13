Create schema walmart;
Select * from walmart;
select count(*) from walmart;
describe walmart;

select * from walmart limit 5;

SET sql_safe_updates=0;
-- date is in text format and needs to be convered to date

update walmart
Set date=str_to_date(date, "%d/%m/%Y");

-- Altering the table and updating date column 
alter table walmart
modify column date date;

-- time is in text format and needs to be converted to time
update walmart
Set time=str_to_date(time, "%H:%i:%s");

alter table walmart
modify column time time;

select time from walmart;

-- Add the time of day column
 SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM walmart;

ALTER TABLE walmart ADD COLUMN time_of_day VARCHAR(20);

UPDATE walmart
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

-- Add day name column to the table 
Select date,dayname(date) as Day_Name from walmart;

ALTER TABLE walmart ADD COLUMN Day VARCHAR(20);
UPDATE walmart
SET Day = dayname(date);

-- -- Add month_name column
SELECT
	date,
	MONTHNAME(date)
FROM walmart;

ALTER TABLE walmart ADD COLUMN month_name VARCHAR(10);

UPDATE walmart
SET month_name = MONTHNAME(date);

-- How many unique cities does the data have?
select distinct(city) from walmart order by city ;
select count(*) from (select distinct(city) from walmart) as citycount;

-- City and its branch
SELECT 
	DISTINCT city,
    branch
FROM walmart;

-- Calculating revenue for each entry

ALTER TABLE walmart ADD COLUMN Revenue double;

UPDATE walmart
SET Unit_price = REPLACE(Unit_price, '$', '');

alter table walmart
modify column unit_price double;

UPDATE walmart
SET Revenue = unit_price*quantity; 

UPDATE walmart
SET Revenue = Round(Revenue,2);

-- Most selling category

select sum(quantity) as Qty , category
from walmart
group by category
order by 1 desc;

Select max(qty) from (select sum(quantity) as Qty , category
from walmart
group by category
order by 1 desc) as sub;

-- What is the total revenue by month

select Round(sum(revenue),2), month_name 
from  walmart 
group by month_name;

-- What category had the largest revenue?
select round(sum(Revenue),2) as Qty , category
from walmart
group by category
order by 1 desc;

-- What is the city with the largest revenue?
select city,sum(revenue)
from walmart
group by city
order by 2;

-- Sum of revenue for each category by using windows function.
with sum_rev as
(select category,row_number() over (partition by category) as rownum,
sum(revenue) over (partition by category) as revenue from walmart)

select * from sum_rev 
where rownum=1;
-- Avg revenue 
Select avg(revenue)
 from walmart;

/*Fetch each product line and add a column to those product line showing "Good", "Bad". 
Good if its greater than average sales*/

select category , avg(revenue),
case when Avg(revenue) > (Select avg(revenue)
 from walmart) then "good"
 else "bad"
 end as remark 
 from walmart
 group by category;
 
-- Which city sold more products than average product sold? 
select city, sum(quantity) as qty 
from walmart
group by city;

Select avg(quantity) from walmart;

select city, sum(quantity) as qty 
from walmart
group by city
having sum(quantity)> (select avg(quantity) from walmart);

-- What is the average rating of each category
SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    category
FROM walmart
GROUP BY category
ORDER BY 1 DESC;

-- During which time the sale is more
Select time_of_day, sum(revenue) 
from walmart
group by 1;

-- revenue by day
Select day, sum(revenue) as Revenue
from walmart
group by 1
order by 2 desc;

-- Number of sales made in each time of the day per Weekend 
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM walmart
WHERE day in ("Sunday" , "Saturday")
GROUP BY time_of_day 
ORDER BY total_sales DESC;

-- Which month has the highest revenue
select sum(revenue),month_name from walmart 
group by month_name
order by 1 desc
limit 1;

-- Revenue by payment_method
Select payment_method,Sum(revenue) from walmart
group by payment_method;

-- Which day fo the week has the best avg ratings?
SELECT
	day,
	AVG(rating) AS avg_rating
FROM walmart
GROUP BY day
ORDER BY avg_rating DESC;

-- -- Yearly revenue and running yearly total calculations
WITH yearly_revenue AS (
    SELECT 
        EXTRACT(YEAR FROM date) AS year, 
        SUM(revenue) AS total_revenue
    FROM walmart
    GROUP BY 1
)
SELECT 
    year, 
    total_revenue,
    SUM(total_revenue) OVER (ORDER BY year) AS running_revenue
FROM yearly_revenue
ORDER BY year;

-- alternate way by using rows between unbounded preceding and current row
WITH yearly_revenue AS (
    SELECT 
        EXTRACT(YEAR FROM date) AS year, 
        SUM(revenue) AS total_revenue
    FROM walmart
    GROUP BY 1
)
SELECT 
    year, 
    total_revenue,
    SUM(total_revenue) OVER (ORDER BY year rows between unbounded preceding and current row) AS running_revenue
FROM yearly_revenue
ORDER BY year;

-- Calculating revenue by year and category

    SELECT 
        EXTRACT(YEAR FROM date) AS year, category,
        SUM(revenue) AS total_revenue
    FROM walmart
    GROUP BY 1,2

