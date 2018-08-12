select ('ФИО: Екатерина Староверова');
-- КОМАНДА СОЗДАНИЯ ТАБЛИЦЫ
create table keywords (id bigint, tags text);

-- КОМАНДА ЗАЛИВКИ ДАННЫХ В ТАБЛИЦУ
\copy keywords from '/data/keywords.csv' delimiter ',' header csv;

-- ЗАПРОС-3
with top_rated as(select movieid, avg(rating) as avg_rating from ratings group by movieid having count(rating)> 50),
top_tags as(select id, tags from keywords) select distinct movieid, avg_rating, tags into top_rated_tags
from top_rated TR join top_tags TT on TR.movieid=TT.id
order by avg_rating desc, movieid asc limit 150;

-- КОМАНДА ВЫГРУЗКИ ТАБЛИЦЫ В ФАЙЛ (только я сохраню под другим названием, не как в домашке)
\copy top_rated_tags to '/data/keywords_up.csv' with delimiter as E'\t';
