/*
Assume you're given the tables containing completed trade orders and user details in a Robinhood trading system.

Write a query to retrieve the top three cities that have the highest number of completed trade orders listed in descending order. 
Output the city name and the corresponding number of completed trade orders.
*/

-- join both tables traders and users on basis of user_id
-- filter Completed orders
-- find completed orders by each city (then list top three cities)
select 
  u.city,
  count(*) as total_orders
from trades t
inner join users u on t.user_id = u.user_id
where t.status = 'Completed'
group by u.city
order by total_orders desc
limit 3;
