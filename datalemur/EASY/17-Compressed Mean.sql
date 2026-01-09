/*
You're trying to find the mean number of items per order on Alibaba, rounded to 1 decimal place using tables which includes information on 
the count of items in each order (item_count table) and the corresponding number of orders for each item count (order_occurrences table).
*/

-- find total items = sum(item_count*order_occurrences)
-- find total orders = sum(order_occurrences)
-- find mean = total items / total orders
select 
  round(
    sum(item_count*order_occurrences)::numeric 
    / sum(order_occurrences)
  , 1) as mean
from items_per_order;


-- first solution (gives below error)
select 
  sum(item_count*order_occurrences) / sum(order_occurrences) as mean
from items_per_order;
-- ERROR: function round(double precision, integer) does not exist (LINE: 1)
/*
Why error occured?
ROUND(double precision, integer) does not exist

In PostgreSQL:
SUM(item_count * order_occurrences) / SUM(order_occurrences) → returns double precision
Postgres does not auto-cast here.

ROUND(x, n) only works with numeric, not double precision. 
*/
