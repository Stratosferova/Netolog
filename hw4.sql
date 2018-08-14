
SELECT ('ФИО: Екатерина Староверова');

-- используя функцию определения размера таблицы, вывести top-5 самых больших таблиц базы
select * from information_schema.tables;
select relname as table_name, relpages as table_size from pg_class order by relpages desc limit 5;

-- array_agg: собрать в массив все фильмы, просмотренные пользователем (без повторов)
select userid, array_agg(movieid) as user_views from ratings group by userid;

-- таблица user_movies_agg, в которую сохраните результат предыдущего запроса
select userid, array_agg(movieid) as user_views into user_movies_agg from ratings group by userid;

-- Используя следующий синтаксис, создайте функцию cross_arr которая принимает на вход два массива arr1 и arr2.
-- Функциия возвращает массив, который представляет собой пересечение контента из обоих списков.
-- Примечание - по именам к аргументам обращаться не получится, придётся делать через $1 и $2.
create or replace function cross_arr(bigint[], bigint[]) returns bigint[] as
$$ select array_agg(elem)
from (select unnest($1) as elem intersect select unnest($2) as elem) as set; $$ language sql;

-- Проверим как работает
select cross_arr(u1.user_views, u2.user_views) from user_movies_agg u1, user_movies_agg u2
where u1.userid = 1 and u2.userid = 20;

-- Сформируйте запрос следующего вида: достать из таблицы всевозможные наборы u1, r1, u2, r2.
-- u1 и u2 - это id пользователей, r1 и r2 - соответствующие массивы рейтингов
select u1.userid, u2.userid, u1.user_views as r1, u2.user_views as r2
from user_movies_agg u1, user_movies_agg u2
where u1.userid != u2.userid;
--- option-2
select u1.userid, u2.userid, u1.user_views as r1, u2.user_views as r2
from user_movies_agg u1
inner join user_movies_agg u2 on (u1.userid != u2.userid)

-- Оберните запрос в CTE и примените к парам <ar1, ar2> функцию CROSS_ARR, которую вы создали
-- вы получите триплеты u1, u2, crossed_arr
-- созхраните результат в таблицу common_user_views
with user_pairs as(select u1.userid as u1, u2.userid as u2, u1.user_views as r1, u2.user_views as r2
from user_movies_agg u1 inner join user_movies_agg u2 on (u1.userid != u2.userid))
select u1, u2, cross_arr(r1, r2) into common_user_views from user_pairs;


-- Оставить как есть - это просто SELECT из таблички common_user_views для контроля результата
select * from common_user_views limit 3;

-- Создайте по аналогии с cross_arr функцию diff_arr, которая вычитает один массив из другого.
create or replace function diff_arr(bigint[], bigint[]) returns bigint[] as $$select array_agg(elem)
from (select unnest($1) as elem except
select unnest($2) as elem) as set; $$ language sql;

-- Сформируйте рекомендации - для каждой пары посоветуйте для u1 контент, который видел u2, но не видел u1 (в виде массива).
select diff_arr(user_views, cross_arr) from common_user_views inner join user_movies_agg on common_user_views.u1  = user_movies_agg.userid;
