-- You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.
-- Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.

-- solution1
-- list of all skills for each candidate -> group_concat
-- find mentioned skills in skills list (using function find_in_set) 

select candidate_id 
from (
  select 
  candidate_id,
  group_concat(skill) as skills
  from candidates
  group by candidate_id
) as t
where find_in_set('Python',skills) 
      and find_in_set('Tableau',skills) 
      and find_in_set('PostgreSQL',skills)
order by candidate_id asc;

-- expensive operations group_concat and find_in_set 
-- Not optimized solution

-- solution2
SELECT candidate_id
FROM   (SELECT candidate_id,
               Group_concat(skill) AS skill_set
        FROM   candidates
        GROUP  BY candidate_id
        HAVING skill_set LIKE '%Python%'
               AND skill_set LIKE '%Tableau%'
               AND skill_set LIKE '%PostgreSQL%') t
ORDER  BY candidate_id ASC; 


-- solution3
-- filter only mentioned skills data
-- count num of skills per candidate -> candidate_skill_count
-- filter if candidate_skill_count = 3

select 
  candidate_id
from candidates
where skill in ('Python','Tableau','PostgreSQL')
group by candidate_id
having count(distinct skill) = 3
order by candidate_id asc;
