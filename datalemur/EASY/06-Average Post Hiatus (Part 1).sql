/*
Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between 
each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each 
user's first and last post.
*/

-- solution1 (OPTIMIZED Solution)
-- filter 2021 posts
-- find first post and last year for each user_id: using min, max
-- find days between last and first post: using datediff
-- filter out user_id who have made single post in the year: using condition days_between != 0 
select 
  user_id, 
  datediff(max(post_date),min(post_date)) as days_between
from posts
where post_date >= '2021-01-01'
        and post_date <=  '2021-12-31'
group by user_id
having days_between != 0;


-- solution2 (NOT OPTIMIZED Solution)
-- using window functions
-- create window for each user_id -> finding difference of days between first, last post
-- cte will give duplicate records and user who made single post -> using distinct and filter condition
with user_post_details as (
  SELECT *,
    DATEDIFF(LAST_VALUE(post_date) OVER w, FIRST_VALUE(post_date)  OVER w) AS days_between
  FROM posts
  WHERE YEAR(post_date) = 2021
  WINDOW w AS (
    PARTITION BY user_id
    ORDER BY post_date ASC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  )
)
select distinct user_id, days_between
from user_post_details
where days_between != 0;

-- Why NOT OPTIMIZED solution
-- window function process each row -> Not required
-- window frame (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) -> forces full scan -> Avoid optimization or early termination
-- distinct (Expensive operation)
-- year(post_date) instead filter as " where post_date >= '2021-01-01' and post_date <=  '2021-12-31' " -> efficient indexing
