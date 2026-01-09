/*
IBM is analyzing how their employees are utilizing the Db2 database by tracking the SQL queries executed by their employees. 
The objective is to generate data to populate a histogram that shows the number of unique queries run by employees during the third quarter of 2023 (July to September). 
Additionally, it should count the number of employees who did not run any queries during this period.

Display the number of unique queries as histogram categories, along with the count of employees who executed that number of unique queries.
*/


-- left join both tables employees and queries -> to get all employees 
-- joining condition: on employee_id + query_time -> to get all employees even if they have not run any query in given period (2023 July to September)
-- if we use: join on employee_id + where condition on query_time -> it will not include employees who didn't run any query in given period
-- after join -> find unique queries run by each employee
-- find num of employees in each unique_queries bucket using result of above query
select 
  unique_queries,
  count(*) as employee_count
from (
  select 
    e.employee_id,
    count(distinct q.query_id) as unique_queries
  from employees e
  left join queries q 
  on e.employee_id = q.employee_id
        and q.query_starttime >= '2023-07-01' 
        and q.query_starttime < '2023-10-01'
  group by e.employee_id
) t
group by unique_queries
order by unique_queries asc;

-- Not need to use `COALESCE(COUNT(DISTINCT q.query_id), 0)` -> as COUNT() never returns NULL
