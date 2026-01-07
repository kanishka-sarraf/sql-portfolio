/*
Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. 
Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending order based on the count of the messages.

Assumption: No two users have sent the same number of messages in August 2022.
*/

-- filter Aug 2022 messages
-- find message_count from each user
-- given in question, no 2 users have same message_count in Aug 2022 -> use order by and limit to find top 2 users
select 
  sender_id,
  count(message_id) as message_count
from messages
where sent_date >= '2022-08-01' 
        and sent_date < '2022-09-01'
group by sender_id
order by message_count desc
limit 2;
