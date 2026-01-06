-- Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.

-- solution1
-- find distinct page_id from page_likes table
-- find page_id from pages table which are not present in above query result
select page_id 
from pages
where page_id not in (select distinct page_id 
                      from page_likes)
order by page_id asc;


-- solution2
-- left join both the tables
-- filter records where page_likes.page_id = NULL
select p.page_id
from pages p 
left join page_likes pl
          on p.page_id = pl.page_id
where pl.page_id is NULL
order by p.page_id asc;
