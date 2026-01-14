/*
Assume you're given tables with information on Snapchat users, including their ages and time spent sending and opening snaps.

Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities 
grouped by age group. Round the percentage to 2 decimal places in the output.

Notes:
Calculate the following percentages:
time spent sending / (Time spent sending + Time spent opening)
Time spent opening / (Time spent sending + Time spent opening)
To avoid integer division in percentages, multiply by 100.0 and not 100.
*/


-- first approach (NOT OPTIMAL)
with opening_sending as (
  select 
    user_id,
    sum(case when activity_type = 'open' then time_spent else 0 end) as user_time_spent_opening,
    sum(case when activity_type = 'send' then time_spent else 0 end) as user_time_spent_sending
  from activities
  where activity_type != 'chat'
  group by user_id
) 
select 
  age_bucket,
  round(100.0*(sum(user_time_spent_sending) / (sum(user_time_spent_sending) + sum(user_time_spent_opening))),2) as send_perc,
  round(100.0*(sum(user_time_spent_opening) / (sum(user_time_spent_sending) + sum(user_time_spent_opening))),2) as open_perc
from opening_sending os
join age_breakdown ab on os.user_id = ab.user_id
group by age_bucket;

/*
Why its not optimal?
1. Extra aggregation level (main issue) -> double aggregation
Aggregating per user in the CTE
Aggregating again per age_bucket in the outer query

This double aggregation is unnecessary because:
Percentages are required per age bucket
There is no requirement to compute user-level totals first
This adds extra grouping and memory usage.

2. Redundant filter
WHERE activity_type != 'chat'
We are only aggregating open and send.

3. Repeated denominator calculation
sum(user_time_spent_sending) + sum(user_time_spent_opening)
Calculated twice.
*/

-- second approach 
with opening_sending as (
  select 
    age_bucket,
    sum(case when activity_type = 'open' then time_spent else 0 end) as time_spent_opening,
    sum(case when activity_type = 'send' then time_spent else 0 end) as time_spent_sending
  from activities a
  join age_breakdown ab on a.user_id = ab.user_id
  group by age_bucket
)
select 
  age_bucket, 
  round(100.0*(time_spent_sending / (time_spent_sending + time_spent_opening)),2) as send_perc,
  round(100.0*(time_spent_opening / (time_spent_sending + time_spent_opening)),2) as open_perc
from opening_sending;

/*
Optimal from previous solution but no much optimal
Repeated denominator calculation
sum(user_time_spent_sending) + sum(user_time_spent_opening)
Calculated twice.
*/


-- OPTIMAL Solution
-- join both tables activities and age_breakdown -> on user_id -> to get age_bucket and time_spent in one query
-- find total time spent on sending, opening, both(send + open) for each age_bucket -> using group by and case-when
with opening_sending as (
  select 
    age_bucket,
    sum(case when activity_type = 'open' then time_spent else 0 end) as time_spent_opening,
    sum(case when activity_type = 'send' then time_spent else 0 end) as time_spent_sending,
    sum(case when activity_type in ('open','send') then time_spent else 0 end) as time_spent
  from activities a
  join age_breakdown ab on a.user_id = ab.user_id
  group by age_bucket
)
select 
  age_bucket, 
  round(100.0 * (time_spent_sending / time_spent), 2) as send_perc,
  round(100.0 * (time_spent_opening / time_spent) ,2) as open_perc
from opening_sending;
-- calculating denominator only once as time_spent
