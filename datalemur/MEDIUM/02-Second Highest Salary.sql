/*
Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. 
Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.

It's possible that multiple employees may share the same second highest salary. In case of duplicate, display the salary only once.
*/

-- first approach (NOT OPTIMAL)
-- Rank each salary in desc order -> using dense_rank
-- find 2nd highest salary -> where salary_rnk = 2
-- use limit 1 as salary_rnk = 2 can have multiple records
select salary as second_highest_salary
from (
  select salary, 
  dense_rank() over(order by salary desc) as salary_rnk
  from employee
) t
where salary_rnk = 2
limit 1;

-- Window function ranks every row → full table scan and sorting -> unnecessary work
-- LIMIT 1 is redundant (rank already filters)


-- OPTIMAL solution
-- find max salary from full table 
-- filter records which are less than max salary -> exclude max_salary record
-- find max salary from filtered query
select max(salary) as second_highest_salary
from employee
where salary < (select max(salary) from employee);

-- No window function -> no full scan, no sorting
-- handle duplicates -> No use of LIMIT

-- RULE: If aggregates can solve it, avoid window functions
