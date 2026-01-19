/*
Assume you're given a table containing data on Amazon customers and their spending on products in different category, 
write a query to identify the top two highest-grossing products within each category in the year 2022. 
The output should include the category, product, and total spend.
*/

-- filter 2022 records
-- find total spend for each product in each category -> using group by
-- assign rank for total spend in each category -> using dense_rank with category partition
-- filter 2 top spending products -> using rnk<=2 on above query
select 
  category, product, total_spend 
from (
    SELECT 
      category,
      product,
      sum(spend) as total_spend,
      dense_rank() over(partition by category order by sum(spend) desc) as rnk
    FROM product_spend
    where transaction_date >= '2022-01-01' and transaction_date < '2023-01-01'
    group by category, product
) t1
where rnk <= 2;
