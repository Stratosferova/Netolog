
select ('ФИО: Екатерина Староверова');
select
userid,
movieid,
rating,
(case when (rating - max(rating) over (partition by userid))=0 then 0 else (rating - min(rating) over (partition by userid))/(rating - max(rating) over (partition by userid))end) as normed_rating,
(avg(rating) over (partition by userid)) as avg_rating
from
(select distinct userid, movieid, rating from ratings) as sample
order by userid, rating desc limit 30;

--скрин https://s.mail.ru/9J5G/xBqevoaXv 
