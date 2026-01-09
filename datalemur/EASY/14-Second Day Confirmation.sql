/*
Write a query to display the user IDs of those who did not confirm their sign-up on the first day, but confirmed on the second day.

Definition:
- action_date refers to the date when users activated their accounts and confirmed their sign-up through text messages.
*/


-- join both tables emails and texts on email 
-- filter confirmed records and sign-up on 2nd day
select e.user_id
from emails e
join texts t on e.email_id = t.email_id
where t.signup_action = 'Confirmed' 
          and (datediff(t.action_date, e.signup_date) = 1);

-- datediff in where applies additional function and forces row-by-row evaluation 
-- no index scan


-- OPTIMAL solution
select e.user_id
from emails e
join texts t on e.email_id = t.email_id
where t.signup_action = 'Confirmed' 
  AND t.action_date >= date_add(e.signup_date, interval 1 day)
  AND t.action_date <  date_add(e.signup_date, interval 2 day);
-- no additional function
-- index efficient scan

/*
Why not only `t.action_date = (e.signup_date + INTERVAL 1 day)` ?

If action_date or signup_date is DATETIME:
- This matches only one exact timestamp
- Misses all other times on that day

eg:
signup_date  = 2022-01-01 10:15:00
action_date  = 2022-01-02 09:00:00  → NOT matched
*/
