/*
CVS Health is analyzing its pharmacy sales data, and how well different products are selling in the market. Each drug is exclusively 
manufactured by a single manufacturer.

Write a query to identify the manufacturers associated with the drugs that resulted in losses for CVS Health and calculate the 
total amount of losses incurred.

Output the manufacturer's name, the number of drugs associated with losses, and the total losses in absolute value. 
Display the results sorted in descending order with the highest losses displayed at the top
*/


-- filter loss making drugs -> where total_sales < cogs
-- for each manufacture find num of drugs count and total loss 
select 
  manufacturer,
  count(*) as drug_count,
  sum(cogs - total_sales) as total_loss 
from pharmacy_sales
where total_sales < cogs
group by manufacturer
order by total_loss desc;
