-- Write a query to find how many UHG policy holders made three, or more calls, assuming each call is identified by the case_id column.


-- find how many calls each holder made
-- filter holders which made 3 or greater than 3 calls
-- find num of holders which made 3 or greater than 3 calls using above query result
select count(*) as policy_holder_count 
from (
  select 
    policy_holder_id
  from callers
  group by policy_holder_id
  having count(case_id) >= 3
) t;
