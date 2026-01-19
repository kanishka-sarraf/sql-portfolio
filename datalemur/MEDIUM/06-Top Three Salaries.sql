/*
As part of an ongoing analysis of salary distribution within the company, your manager has requested a report identifying 
high earners in each department. A 'high earner' within a department is defined as an employee with a salary ranking among the 
top three salaries within that department.

You're tasked with identifying these high earners across all departments. Write a query to display the employee's name along 
with their department name and salary. In case of duplicates, sort the results of department name in ascending order, 
then by salary in descending order. If multiple employees have the same salary, then order them alphabetically.

Note: Ensure to utilize the appropriate ranking window function to handle duplicate salaries effectively.
*/


-- join both tables: employee and department on department_id
-- assign rank on basis of salary -> using dense_rank 
-- filter top 3 earners -> rnk<=3 on above query
select department_name, name, salary 
from (
  SELECT 
    d.department_name,
    e.name,
    e.salary,
    dense_rank() over(partition by d.department_id order by e.salary desc) as rnk
  FROM employee e
  join department d on e.department_id = d.department_id
) t
where rnk<=3
order by department_name asc, salary desc, name asc;
