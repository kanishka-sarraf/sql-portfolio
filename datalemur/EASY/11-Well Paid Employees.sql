/*
Companies often perform salary analyses to ensure fair compensation practices. One useful analysis is to check if there are any employees 
earning more than their direct managers.

As a HR Analyst, you're asked to identify all employees who earn more than their direct managers. The result should include the employee's ID and name.
*/


-- self join (treat one table as employee and other as manager table) on manager_id and employee_id
select 
  e.employee_id, 
  e.name as employee_name
from employee e
join employee m on e.manager_id = m.employee_id
where e.salary > m.salary;
