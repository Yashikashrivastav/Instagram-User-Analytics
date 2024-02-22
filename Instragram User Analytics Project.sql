-- A) Marketing Analysis:
-- Identify the five oldest users on Instagram from the provided database.
Select * from users
order by created_at 
limit 5;

-- Identify users who have never posted a single photo on Instagram.
select username from users
left join photos
on users.id = photos.user_id
where photos.id is null;

-- Determine the winner of the contest and provide their details to the team.
select username, photos.id, photos.image_url, count(likes.user_id) as total
from photos
inner join likes
on likes.photo_id= photos.id
inner join users
on photos.user_id = users.id
group by photos.id
order by total desc
limit 1;

--  Identify and suggest the top five most commonly used hashtags on the platform.
select tags.tag_name,
count(*) as total
from photo_tags
join tags
on photo_tags.tag_id= tags.id
group by tags.id
order by total desc
limit 5;

-- Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.
select dayname(created_at) as day, count(*) as total
from users
group by day
order by total desc
limit 2;

-- B) Investor Metrics:
-- Compute the average posts per user by dividing total posts by total users, and find the average photos per user by dividing total photos by total users.
select
(select count(*) from photos) / (select count(*) from users) as Avg;

select user_id, count(*) as num_likes
from likes
group by user_id
having num_likes = (select count(*) from photos);

-- Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.
select u.username, count(*) as num_likes
from users u 
join likes on u.id = user_id
group by u.id
having num_likes = (select count(*) from photos); 




