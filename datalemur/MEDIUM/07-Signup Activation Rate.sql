/*
New TikTok users sign up with their emails. They confirmed their signup by replying to the text confirmation to 
activate their accounts. Users may receive multiple text messages for account confirmation until they have confirmed their new account.

A senior analyst is interested to know the activation rate of specified users in the emails table. Write a query to find the activation rate. 
Round the percentage to 2 decimal places.

Definitions:
emails table contain the information of user signup details.
texts table contains the users' activation information.

Assumptions:
The analyst is interested in the activation rate of specific users in the emails table, which may not include all users that could potentially 
be found in the texts table.
For example, user 123 in the emails table may not be in the texts table and vice versa.
*/

-- solution1 (OPTIMAL)
select 
  round((count(cs.email_id)*1.0) / count(e.email_id),2) as confirm_rate
from emails e
left join (
  select *
  from texts
  where signup_action = 'Confirmed'
) cs on e.email_id = cs.email_id;

-- solution2 (NOT OPTIMAL)
SELECT
  ROUND(
    (
      (SELECT COUNT(e.email_id)
       FROM emails e
       JOIN texts t
         ON e.email_id = t.email_id
       WHERE t.signup_action = 'Confirmed') * 1.0
      / (SELECT COUNT(*) FROM emails)
    ),
    2
  ) AS confirm_rate;
/*
Problems

Two separate scans

emails scanned once

emails + texts scanned again

Scalar subqueries

Prevent join reordering

Harder for optimizer

Poor scalability
*/

