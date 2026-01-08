/*
Assume you're given a table containing job postings from various companies on the LinkedIn platform. 
Write a query to retrieve the count of companies that have posted duplicate job listings.

Definition: Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.
*/

-- find duplicate job listing -> using group by on company_id, title, description
-- filter where count is more than 1 (duplicate listings)
-- find count of rows of above query to get duplicate_companies
select count(*) as duplicate_companies 
from (
  select 
    company_id, title, description
  from job_listings
  group by company_id, title, description
  having count(*) > 1
) t;
