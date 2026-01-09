/*
Write a query that outputs the name of each credit card and the difference in the number of issued cards between the month with the highest 
issuance cards and the lowest issuance. Arrange the results based on the largest disparity.
*/

-- find for each card min issued_amount and max issued_amount
select 
  card_name, 
  max(issued_amount) - min(issued_amount) as difference
from monthly_cards_issued
group by card_name
order by difference desc;
