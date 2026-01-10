/*
Write a query to calculate the total drug sales for each manufacturer. Round the answer to the nearest million and report your 
results in descending order of total sales. In case of any duplicates, sort them alphabetically by the manufacturer name.

Since this data will be displayed on a dashboard viewed by business stakeholders, please format your results as follows: "$36 million".
*/


select 
  manufacturer,
  concat('$',round(sum(total_sales)/1000000.0),' million') as sale 
from pharmacy_sales
group by manufacturer
order by sum(total_sales) desc, manufacturer asc;
