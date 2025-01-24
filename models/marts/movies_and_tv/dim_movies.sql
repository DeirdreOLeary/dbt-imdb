with movies as (

    select * from {{ ref('int_movies_filtered') }}

),

ratings as (

    select * from {{ ref('int_ratings_joined') }}

),

aggregate_and_join_ratings_to_movies as (

    select m.TitleKey,
        m.Title,
        m.ReleaseYear,
        m.RuntimeInMinutes,
        m.Genres,
        r.AverageRating,
        r.NumberOfVotes
    from ratings as r
    inner join movies as m
    on r.TitleKey = m.TitleKey

)

select * from aggregate_and_join_ratings_to_movies