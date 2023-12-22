--
select * from(
    select top 1 u.name as results from Users u inner join
    MovieRating r on u.user_id = r.user_id
    group by r.user_id, u.name
    order by count(*) desc, u.name

    union all

    select top 1 m.title from Movies m inner join
    MovieRating r on m.movie_id = r.movie_id
    where year(created_at) = 2020 and month(created_at)=02
    group by m.movie_id,m.title
    order by Avg(r.rating+0.00) desc, m.title

) t