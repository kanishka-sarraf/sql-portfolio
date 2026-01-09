/*
Write a query to calculate the click-through rate (CTR) for the app in 2022 and round the results to 2 decimal places.

Definition and note:
- Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
- To avoid integer division, multiply the CTR by 100.0, not 100.

*/

-- solution1
-- filter 2022 events
-- find impression and click event count for each app -> case when with group by
-- calculate ctr using above query result
with app_click_impression as (
  select 
    app_id,
    count(case when event_type = 'impression' then 1 end) as impression,
    count(case when event_type = 'click' then 1 end) as click
  from events
  where timestamp >= '2022-01-01' 
            and timestamp < '2023-01-01'
  group by app_id
)
select 
  app_id, 
  round((click*100.0)/impression,2) as ctr
from app_click_impression;


-- solution2
-- More Optimal solution -> single layer solution (no cte, single scan)
SELECT
  app_id,
  ROUND(
    COUNT(*) FILTER (WHERE event_type = 'click') * 100.0
    / NULLIF(COUNT(*) FILTER (WHERE event_type = 'impression'), 0),
    2
  ) AS ctr
FROM events
WHERE timestamp >= '2022-01-01'
  AND timestamp <  '2023-01-01'
GROUP BY app_id;
