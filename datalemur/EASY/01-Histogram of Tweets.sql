-- group the users by the number of tweets they posted in 2022 and count the number of users in each group.

-- filter tweets -> 2022
-- count tweets by each user -> tweet_bucket
-- count users in each tweet_bucket

with user_tweets as (
  select 
    user_id, 
    count(tweet_id) as user_tweet_count
  from tweets
  where year(tweet_date) = 2022
  group by user_id
)
select 
  user_tweet_count as tweet_bucket, 
  count(user_id) as users_num
from user_tweets
group by user_tweet_count;
