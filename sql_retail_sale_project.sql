/* CREATE DATABASE */
create database Sql_project;
use Sql_project;

/* Create table */
create  table Retail_sales_analysis
(transaction_id int,
	sale_date 	date,
    sale_time	time,
    customer_id	int,
    gender	varchar(15),
    age	int,
    category varchar(20),	
    quantiy	int,
    price_per_unit float,	
    cogs     float,
    total_sale float
);

select * 
from  retail_sales_analysis;

select
 count(*)
from 
retail_sales_analysis;

/*  DATA CLEANING PART*/

SELECT * FROM retail_sales_analysis
where transactions_id is null;

SELECT * FROM retail_sales_analysis
where sale_date is null;

select * from retail_sales_analysis
 where 
    transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or 
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or 
    total_Sale is null;
    
    /* DELETE NULL VALUES*/
    delete from retail_sales_analysis
    where 
    transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or 
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_Sale is null;
    
    /* DATA EXPLORATION*/
    
    /*How Many Sales We Have*/
    select count(*) 
    as total_sales
    from 
    retail_sales_analysis;
    
    /* how many unique customer we have */
    select  count(distinct customer_id) 
    from 
    retail_sales_analysis;
    
    /*DATA ANALYSIS AND BUSINESS PROBLEM*/
    
    /*1. WRITE a Sql Query to retrive all column for sales made on '2022-11-05 */
    select * from 
    retail_sales_analysis
    where 
    sale_date='2022-11-05';

   /* 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022*/
     select * from retail_sales_analysis
        where 
        category='clothing' 
        and
        quantiy>=2 
        and 
        month('2022-11-05');
        
     /* 3.Write a SQL query to calculate the total sales (total_sale) for each category.*/
     select category,sum(total_sale)
     from 
     retail_sales_analysis
     group by category;
     
	/* 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category*/
     select category, ROUND(avg(age),2)
     from 
     retail_sales_analysis
     where 
     category='beauty'; 
     
	/* Write a SQL query to find all transactions where the total_sale is greater than 1000 */
     select  distinct transactions_id,total_sale 
     from
     retail_sales_analysis
     where 
     total_sale >1000 ;
     
	/* Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:*/
     select
     category,gender,count(*) 
     as
     total_transaction
     from 
     retail_sales_analysis
     group by 
     category,gender;
     
	/* Write a SQL query to calculate the average sale for each month. Find out best selling month in each year: */
      SELECT 
       year(sale_date) as year,
       month(sale_date)as month ,
       round(avg(total_sale),2) as total_sale, 
       rank() over(partition by year(sale_date)order by avg(total_sale)desc)
       from retail_sales_analysis
       group by 1,2
       order by 1,3 desc;
       
	  /* **Write a SQL query to find the top 5 customers based on the highest total sales **:*/
        select customer_id,
        sum(total_sale)
        from 
        retail_sales_analysis
        group by 1 order by 2 desc limit 5;
       
	   /* Write a SQL query to find the number of unique customers who purchased items from each category.:*/
        select 
        category,count(distinct customer_id)
        from 
        retail_sales_analysis 
        group by 1;
	  /* Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):*/
      WITH hourly_sale
          AS(SELECT *,
    CASE
        WHEN hour(sale_time) < 12 THEN 'Morning'
        WHEN hour(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
      FROM retail_sales_analysis
        )
      SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;
