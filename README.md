# SQL_Walmart_Data_Analysis

My goal is to explore the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition. https://www.kaggle.com/datasets/najir0123/walmart-10k-sales-datasets?resource=download

## Approach Used
## 1.Data Wrangling: 
This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace, missing or NULL values.\
Build a database.\
Create table and insert the data.\
Select columns with null values in them and eliminate or populate the values as per requirement.
## 2.Feature Engineering;
This will help use generate some new columns from existing ones.\
Add a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.\
Add a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.\
Add a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.
## 3. Exploratory Data Analysis (EDA): 
Exploratory data analysis is done to answer the listed questions and aims of this project.

### Generic Question
How many unique cities does the data have?\
In which city is each branch?
### Product
How many unique category does the data have?\
What is the most common payment method?\
What is the most selling category?\
What is the total revenue by month?\
What month had the largest revenue?\
What is the city with the largest revenue?\
Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales\
Which branch sold more products than average product sold?\
What is the average rating of each product line?
### Sales
Number of sales made in each time of the day per weekday\
Which of the customer types brings the most revenue?\
How many unique payment methods does the data have?\
What is the gender of most of the customers?\
Which month has the highest revenue?\
Which day fo the week has the best avg ratings?\
what is the annual total revenue for each year and also calculate running total?\
Determine each year's revenue by category. 
