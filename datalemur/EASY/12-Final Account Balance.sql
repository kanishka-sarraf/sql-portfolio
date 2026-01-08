/*
Given a table containing information about bank deposits and withdrawals made using Paypal, write a query to retrieve the final account balance 
for each account, taking into account all the transactions recorded in the table with the assumption that there are no missing transactions.
*/

-- solution1 (my approach)
-- using case-when make amount as per transaction_type
-- find final_balance for each account using above query result
select account_id, 
  sum(amount) as final_balance
from ( 
  select account_id,
  case when transaction_type = 'Withdrawal' then amount*(-1)
       else amount 
  end as amount
  from transactions
) t
group by account_id;

-- Not optimal -> as due to subquery there is additional operation/layer

-- Optimal solution (No subquery)
select account_id,
  sum(
      case when transaction_type = 'Withdrawal' then amount*(-1)
           else amount 
      end
  ) as final_balance
from transactions
group by account_id;
