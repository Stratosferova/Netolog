select 'ФИО: Староверова Екатерина Андреевна'
--first request
select * from ratings limit 10;
select imdbid, movieid from links where imdbid like '%42' and (movieid > 100 and movieid < 1000) limit 10;

--second request
select imdbid from links inner join ratings on ratings.movieid=links.movieid where ratings.rating = 5;

--third request 3.1
select count(links.movieid) from links left join ratings on ratings.movieid=links.movieid where ratings.movieid is null;
--third request 3.2 (two options)
select userid, sum(rating)/count(rating) as rate from ratings where rating > 3.5  group by userid, rating order by rating desc limit 10;
select userid, rating from ratings group by userid, rating having sum(rating)/ count(rating) > 3.5 order by rating desc limit 10;

--fourth request 4.1
select imdbid, avg_rating from (select imdbid, avg(rating) as avg_rating from links inner join ratings on ratings.movieid=links.movieid group by imdbid) as s where avg_rating > 3.5 limit 10;
--fourth request 4.2
with table_avg as (select userid, avg(rating) as average, count(rating) as count_quantity from ratings group by userid), table_more10_rate as(select userid, count(rating)> 10  as true_quantity from ratings group by userid) select avg(average) from table_avg TA join table_more10_rate TM on TA.userid = TM.userid where TM.true_quantity = true;
