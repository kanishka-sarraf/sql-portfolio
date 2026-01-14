-- Assume you are given the table below on Uber transactions made by users. Write a query to obtain the third transaction of every user. 
-- Output the user id, spend and transaction date.


-- find trn_num as additional column for each user -> using window function 
-- filter above query to find 3rd transaction -> where trn_num = 3 
select user_id, spend, transaction_date 
from (
  select * ,
  row_number() over(partition by user_id order by transaction_date asc) as trn_num
  from transactions
) t
where trn_num = 3;
