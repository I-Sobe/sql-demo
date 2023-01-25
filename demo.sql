# a querry to return the  lowest 20 orders in terms of 
# smallest total_amt_usd. Include the id, account_id, and total_amt_usd
select id, account_id, total_amt_usd
from orders
order by total_amt_usd
limit 20;

select id, account_id, total_amt_usd
from orders
order by account_id, total_amt_usd desc;

select id, account_id, total_amt_usd
from orders
order by total_amt_usd desc, account_id

# pulls the first 5 rows and all columns from the order table that have  
# dollar amount of gloss_amt_usd greater than or equal to 1000.
select *
from orders
where gloss_amt_usd >= 1000
limit 5;

# Pulls the first 10 rows and all columns from the orders 
# table that have a total_amt_usd less than 500
select *
from orders
where total_amt_usd < 500
limit 10;

# Filter the accounts table to include the company name, website, and the primary
# point of contact (primary_poc) just for the Exxon Mobil company in the accounts table.
select name, website, primary_poc
from accounts
where name = 'Exxon Mobil';

# Create a column that divides the standard_amt_usd by the standard_qty to find the 
# unit price for standard paper for each order.
# Limit the results to the first 10 orders, and include the id and account_id fields.
select id, account_id, (standard_amt_usd/standard_qty) 'std_paper_unit_price'
from orders
limit 10;

# Write a query that finds the percentage of revenue that comes from poster paper for each order. 
# You will need to use only the columns that end with _usd. 
#(Try to do this without using the total column.) Display the id and account_id fields also
select id, account_id, poster_amt_usd/(standard_amt_usd+gloss_amt_usd+poster_amt_usd+total_amt_usd)*100 as poster_paper_revenue 
from orders
limit 10;

# using the account table
# All the companies whose names start with 'C'
select *
from accounts
where name like 'C%'; 

# All companies whose names contain the string 'one' somewhere in the name.
select *
from accounts
where name like '%one%';

# All companies whose names end with 's
select *
from accounts
where name like '%s';

# Use the accounts table to find the account name, primary_poc,
# and sales_rep_id for Walmart, Target, and Nordstrom.
select name, primary_poc, sales_rep_id
from accounts
where name in ('Walmart', 'Target', 'Nordstrom');

#Use the web_events table to find all information 
# regarding individuals who were contacted via the channel of organic or adwords.
select *
from web_events 
where channel in ('organic','adwords');

# Use the accounts table to find the account name, 
# primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.
select name,primary_poc,sales_rep_id
from accounts
where name not in ('Walmart', 'Target', 'Nordstrom');

# Use the web_events table to find all information regarding 
# individuals who were contacted via any method except using organic or adwords methods.
select *
from web_events
where channel not in ('organic','adwords');

# Using the account table 
#All the companies whose names do not start with 'C'.
select *
from accounts
where name not like 'C%';

# All companies whose names do not contain the string 'one' somewhere in the name.
select *
from accounts
where name not like '%one%';

# All companies whose names do not end with 's'.
select *
from accounts
where name not like '%s';

# Write a query that returns all the 
# orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.
select *
from orders
where standard_qty > 1000 and poster_qty =0 and gloss_qty=0;

# Using the accounts table, 
# find all the companies whose names do not start with 'C' and end with 's'
select *
from accounts
where name not like 'C%' and '%s';

# When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not? 
# Figure out the answer to this important question by writing a query that displays 
# the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29.Then
# look at your output to see if the BETWEEN operator included the begin and end values or not.
select occurred_at, gloss_qty
from orders
where gloss_qty between 24 and 29;

# Use the web_events table to find all information regarding individuals 
# who were contacted via the organic or adwords channels, 
# and started their account at any point in 2016, sorted from newest to oldest.
select *
from web_events
where channel in ('organic' and 'adwords') and occurred_at like '2016%'
order by occurred_at desc;

# Find list of orders ids where either gloss_qty or poster_qty is greater 
# than 4000. Only include the id field in the resulting table.
select account_id
from orders
where gloss_qty or poster_qty > 4000;

# Write a query that returns a list of orders where the 
# standard_qty is zero and either the gloss_qty or poster_qty is over 1000.
select *
from orders
where standard_qty=0 and (gloss_qty or poster_qty=1000);

# Find all the company names that start with a 'C' or 'W', 
# and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.
select *
from accounts
where (name like 'C%' or 'W%') 
and (primary_poc like '%ana%' or '%Ana%') 
and (primary_poc not like '%eana%'); 

# using the join and ON statement
select accounts.name, orders.occurred_at
from orders
join accounts
on orders.account_id = accounts.id;

select*
from orders
join accounts
on orders.account_id = accounts.id;

# Try pulling all the data from the accounts table, and all the data from the orders table.
select accounts.*, orders.*
from accounts
join orders
on orders.account_id = accounts.id;

# Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
select accounts.website, accounts.primary_poc, orders.standard_qty,orders.gloss_qty,orders.poster_qty
from accounts
join orders
on orders.account_id = accounts.id;

SELECT orders.standard_qty, orders.gloss_qty, 
       orders.poster_qty,  accounts.website, 
       accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

# joining 3 tables web_events,orders,accounts
SELECT *
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN orders o
ON a.id = o.account_id;

# joining tables and pulling specific columns from the join 
SELECT web_events.channel, accounts.name, orders.total
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id;

# Provide a table for all web_events associated with account name of Walmart
# There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event.
# Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
select a.primary_poc, w.occurred_at, w.channel, a.name
from web_events w
join accounts a
on w.account_id = a.id
where a.name='Walmart';

# Provide a table that provides the region for each sales_rep along with their associated accounts.
# Your final table should include three columns: the region name, the sales rep name, and the account name.
# Sort the accounts alphabetically (A-Z) according to account name.
select a.name as account_name, s.name as sales_rep_name, r.name As region_name
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r
on s.region_id = r.id
order by a.name;

# Provide the name for each region for every order, 
# as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
# Your final table should have 3 columns: region name, account name, and unit price. 
# A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
select a.name as account_name, r.name as region_name, (o.total_amt_usd/(total + 0.01)) as unit_price
from accounts a
join orders o
on o.account_id = a.id
join sales_reps s
on a.sales_rep_id=s.id
join region r
on s.region_id = r.id;

# Provide a table that provides the region for each sales_rep along with their associated accounts. 
# This time only for the Midwest region. 
# Your final table should include three columns: the region name, the sales rep name, and the account name. 
# Sort the accounts alphabetically (A-Z) according to account name.
select a.name as account_name, s.name as sales_rep_name, r.name as region_name
from sales_reps s
join accounts a
on s.id = a.sales_rep_id
join region r
on s.region_id = r.id
where r.name = 'Midwest'
order by a.name;

# Provide a table that provides the region for each sales_rep along with their associated accounts.
# This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. 
# Your final table should include three columns: the region name, the sales rep name, and the account name.
# Sort the accounts alphabetically (A-Z) according to account name.

select a.name as account_name, s.name as sales_rep_name, r.name as region_name
from sales_reps s
join accounts a
on s.id = a.sales_rep_id
join region r
on s.region_id = r.id
where r.name = 'Midwest' and s.name like 'S%'
order by a.name;

# Provide a table that provides the region for each sales_rep along with their associated accounts. 
# This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. 
# Your final table should include three columns: the region name, the sales rep name, and the account name. 
# Sort the accounts alphabetically (A-Z) according to account name.
select a.name as account_name, s.name as sales_rep_name, r.name as region_name
from sales_reps s
join accounts a
on s.id = a.sales_rep_id
join region r
on s.region_id = r.id
where r.name = 'Midwest' and s.name like '% K%'
order by a.name;

# Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
# However, you should only provide the results if the standard order quantity exceeds 100. 
# Your final table should have 3 columns: region name, account name, and unit price. 
# In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).
SELECT r.name AS region_name, a.name AS account_name, (o.total_amt_usd/(total+0.01)) AS unit_price
from orders o
join accounts a
on o.account_id = a.id
join sales_reps s
on s.id = a.sales_rep_id
join region r
on r.id = s.region_id
where o.standard_qty>100;

# Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
# However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
# Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first.
select r.name as region, a.name as account, (o.total_amt_usd/(total+0.01)) AS unit_price
from orders o
join accounts a
on o.account_id = a.id
join sales_reps s
on s.id = a.sales_rep_id
join region r
on r.id = s.region_id
where o.standard_qty>100 and poster_qty > 50
order by unit_price;

# Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
# However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
# Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first.
select r.name as region, a.name as account, (o.total_amt_usd/(total+0.01)) AS unit_price
from orders o
join accounts a
on o.account_id = a.id
join sales_reps s
on s.id = a.sales_rep_id
join region r
on r.id = s.region_id
where o.standard_qty>100 and poster_qty > 50
order by unit_price desc;

# What are the different channels used by account id 1001? 
# Your final table should have only 2 columns: account name and the different channels. 
# You can try SELECT DISTINCT to narrow down the results to only the unique values.
select a.name, w.channel
from accounts a
join web_events w
on w.account_id = a.id
where a.id = '1001';

# Find all the orders that occurred in 2015. 
# Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.
select o.occurred_at, a.name as name, o.total as total, o.total_amt_usd
from accounts a
join orders o
on a.id = o.account_id
where o.occurred_at between '01-01-2015' and '01-01-2016'
order by o.occurred_at desc ;

#number of rowsin the table
SELECT COUNT(*) AS sum_rows
FROM accounts;

SELECT COUNT(accounts.id)
FROM accounts;

# Find the total amount of poster_qty paper ordered in the orders table.
select sum(poster_qty) AS poster_qty_sum
from orders;

# Find the total amount of standard_qty paper ordered in the orders table.
select sum(standard_qty) AS standard_qty_sum
from orders;

# Find the total dollar amount of sales using the total_amt_usd in the orders table.
select sum(total_amt_usd) As total_dollar_amt
from orders;

# Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table.
# This should give a dollar amount for each order in the table.
SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

# Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.
select sum(standard_amt_usd)/sum(standard_qty) AS standard_price_per_unit
from orders;

# When was the earliest order ever placed? You only need to return the date.
select min(occurred_at)
from orders;

# Try performing the same query as in question 1 without using an aggregation function.
select occurred_at
from orders
order by occurred_at
limit 1;

# When did the most recent (latest) web_event occur?
select max(occurred_at)
from web_events;

# Try to perform the result of the previous query without using an aggregation function.
select occurred_at
from orders
order by occurred_at DESC
limit 1;

# Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. 
# Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.
select AVG(standard_qty) AS mean_stnd, AVG(gloss_qty) AS mean_gloss, AVG(poster_qty) AS mean_poster, 
		AVG(standard_amt_usd) AS mean_stnd_amt, avg(gloss_amt_usd) AS mean_gloss_amt, avg(poster_amt_usd) AS mean_poster_amt
from orders;

# what is the MEDIAN total_usd spent on all orders?
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

# Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
select a.name as account_name, o.occurred_at as order_date
from accounts a
join orders o
on a.id = o.account_id
order by o.occurred_at
limit 1;

# Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.
select a.name as company_name, sum(o.total_amt_usd) as total_sales
from accounts a
join orders o
on a.id = o.account_id
group by a.name;

# Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? 
# Your query should return only three values - the date, channel, and account name.
select w.occurred_at as date, a.name as account_name,  w.channel as channel
from accounts a
join web_events w
on a.id = w.account_id
order by w.occurred_at desc
limit 1;

# Find the total number of times each type of channel from the web_events was used. 
# Your final table should have two columns - the channel and the number of times the channel was used.
select w.channel as channel, count(w.channel)
from web_events w
group by w.channel; 

# Who was the primary contact associated with the earliest web_event?
select a.primary_poc as primary_contact, w.occurred_at
from accounts a
join web_events w
on a.id = w.account_id
order by w.occurred_at 
limit 1;

# What was the smallest order placed by each account in terms of total usd. 
# Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.
select a.name as account_name, min(o.total_amt_usd) as smallest_order
from accounts a
join orders o
on a.id = o.account_id
group by a.name
order by smallest_order;

# Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. 
# Order from fewest reps to most reps.
select r.name as region, count(s.name) as sales_rep
from region r
join sales_reps s
on r.id = s.region_id
group by r.name
order by sales_rep;

# OR
SELECT r.name, COUNT(*) num_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_reps;

# For each account, determine the average amount of each type of paper they purchased across their orders. 
# Your result should have four columns - 
# one for the account name and one for the average quantity purchased for each of the paper types for each account.
select a.name as name, avg(o.standard_qty) as mean_standard, avg(o.gloss_qty) as mean_gloss, avg(o.poster_qty) as mean_poster
from accounts a
join orders o
on a.id = o.account_id
group by a.name;

# For each account, determine the average amount spent per order on each paper type. 
# Your result should have four columns - one for the account name and one for the average amount spent on each paper type.
select a.name as name, avg(o.standard_amt_usd) as mean_standard_amt, 
		avg(o.gloss_amt_usd) as mean_gloss_amt, avg(o.poster_amt_usd) as mean_poster_amt
from accounts a
join orders o
on a.id = o.account_id
group by a.name;

# Determine the number of times a particular channel was used in the web_events table for each sales rep.
# Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. 
# Order your table with the highest number of occurrences first.
select s.name as sales_rep, w.channel as channel, count(*) num_events
from sales_reps s
join accounts a
on s.id = a.sales_rep_id
join web_events w
on a.id = w.account_id
group by s.name, w.channel
order by num_events desc;

# Determine the number of times a particular channel was used in the web_events table for each region. 
# Your final table should have three columns - the region name, the channel, and the number of occurrences. 
# Order your table with the highest number of occurrences first.
select r.name, w.channel, count(*) num_occurrence
from region r
join sales_reps s
on r.id = s.region_id
join accounts a
on s.id = a.sales_rep_id
join web_events w
on a.id = w.account_id
group by r.name, w.channel
order by num_occurrence desc;

# Use DISTINCT to test if there are any accounts associated with more than one region.
select distinct id, name
from accounts;

#
SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;

# Have any sales reps worked on more than one account?
select distinct id, name
from sales_reps;

# 
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

# How many of the sales reps have more than 5 accounts that they manage?
select s.name, s.id, count(*) num_accounts 
from accounts a
join sales_reps s
on s.id = a.sales_rep_id
group by s.id, s.name
having num_accounts >= 5
order by num_accounts;

# How many accounts have more than 20 orders?
select a.name, count(*) num_orders
from accounts a
join orders o
on o.account_id=a.id
group by a.name
having num_orders >20
order by num_orders;

# Which account has the most orders?
select a.name, count(*) num_orders
from accounts a
join orders o
on o.account_id=a.id
group by a.name
having num_orders >20
order by num_orders desc
limit 1;

# Which accounts spent more than 30,000 usd total across all orders?
select a.name, sum(o.total_amt_usd) as "Total orders"
from accounts a
join orders o
on o.account_id = a.id
group by a.name
having sum(o.total_amt_usd) > 30000
order by a.name; 

# Which accounts spent less than 1,000 usd total across all orders?
select a.name, sum(o.total_amt_usd) as "Total orders"
from accounts a
join orders o
on o.account_id = a.id
group by a.name
having sum(o.total_amt_usd) < 1000
order by a.name;

# Which account has spent the most with us?
select a.name, sum(o.total_amt_usd) as "Total orders"
from accounts a
join orders o
on o.account_id = a.id
group by a.name
order by sum(o.total_amt_usd) desc
limit 1;

# Which account has spent the least with us?
select a.name, sum(o.total_amt_usd) total_orders
from accounts a
join orders o
on o.account_id = a.id
group by a.name
order by total_orders
limit 1;

# Which accounts used facebook as a channel to contact customers more than 6 times?
select a.name, w.channel, count(*) times_used
from accounts a
join web_events w
on a.id = w.account_id
group by a.name, w.channel
having count(*) >6 and w.channel = 'facebook'
order by times_used;

# Which account used facebook most as a channel?
select a.name, w.channel, count(*) times_used
from accounts a
join web_events w
on a.id = w.account_id
group by a.name, w.channel
having count(*) >6 and w.channel = 'facebook'
order by times_used desc
limit 1;

# Which channel was most frequently used by most accounts?
select a.name, w.channel, count(*) times_used
from accounts a
join web_events w
on a.id = w.account_id
group by a.name, w.channel
order by times_used desc
limit 1;

# Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. 
# Do you notice any trends in the yearly sales totals?
select year(occurred_at) ord_year, sum(total_amt_usd) total_spent
from orders
group by 1
order by 2 desc;

# Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
select month(occurred_at) ord_year, sum(total_amt_usd) total_spent
from orders
group by 1
order by 2 desc;

# Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?
select year(occurred_at) ord_year, count(*) total_orders
from orders
group by 1
order by 2 desc;

# Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?
select month(occurred_at) ord_year, count(*) total_orders
from orders
group by 1
order by 2 desc;

# In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
select month(o.occurred_at) ord_month, sum(o.gloss_amt_usd) gloss_usd
from orders o
join accounts a
on a.id = o.account_id
where a.name = 'Walmart'
group by 1
order by 2 desc;

# Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. 
# Limit the results to the first 10 orders, and include the id and account_id fields.
SELECT account_id, CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
                        ELSE standard_amt_usd/standard_qty END AS unit_price
FROM orders
LIMIT 10;

# Write a query to display for each order, the account ID, total amount of the order, 
# and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.
select account_id, total_amt_usd, 
case when total_amt_usd >= 3000 then 'Large' else 'Small' end as order_level
from orders;

# Write a query to display the number of orders in each of three categories, based on the total number of items in each order. 
# The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
select case when total >=2000 then 'At least 2000' when total >=1000 and total <2000 then 'Between 1000 and 2000'
else 'Less than 1000' end as order_categories,
count(*) as order_count
from orders
group by 1;

# We would like to understand 3 different levels of customers based on the amount associated with their purchases. 
# The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. 
# The second level is between 200,000 and 100,000 usd. 
# The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. 
# You should provide the account name, the total sales of all orders for the customer, and the level.
# Order with the top spending customers listed first.
select a.name, sum(o.total_amt_usd) total_spending, case when sum(o.total_amt_usd) >200000 then 'top level' when sum(o.total_amt_usd)
 >=100000 and sum(o.total_amt_usd) <200000 then 'second level' else 'lowest level' end as level
from accounts a
join orders o
on a.id = o.account_id
group by a.name
order by 2 desc;

# We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. 
# Keep the same levels as in the previous question. Order with the top spending customers listed first.
select a.name, sum(o.total_amt_usd) total_spending, 
case when sum(o.total_amt_usd) >200000 then 'top level' when sum(o.total_amt_usd)
 >=100000 and sum(o.total_amt_usd) <200000 then 'second level' else 'lowest level' end as level
from accounts a
join orders o
on a.id = o.account_id
where occurred_at > '2015-12-31'
group by a.name
order by 2 desc;

# We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders.
# Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders.
# Place the top sales people first in your final table.
SELECT s.name, COUNT(*) num_ords,
     CASE WHEN COUNT(*) > 200 THEN 'top'
     ELSE 'not' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 2 DESC;

# The previous didn't account for the middle, nor the dollar amount associated with the sales. 
# Management decides they want to see these characteristics represented as well. 
# We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. 
# The middle group has any rep with more than 150 orders or 500000 in sales. 
# Create a table with the sales rep name, the total number of orders, total sales across all orders, 
# and a column with top, middle, or low depending on this criteria. 
# Place the top sales people based on dollar amount of sales first in your final table.
SELECT s.name, COUNT(*), SUM(o.total_amt_usd) total_spent, 
     CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
     WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
     ELSE 'low' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 3 DESC;