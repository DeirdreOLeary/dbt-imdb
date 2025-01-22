with ratings as (

    select * from {{ ref('stg_imdb__title_ratings') }}

),

movies_and_tvseries as (

    select TitleKey
    from {{ ref('int_movies_filtered') }}
    union
    select TitleKey
    from {{ ref('int_tvseries_joined') }}

),

filter_and_join_ratings_to_movies_and_tvseries as (

    select mt.TitleKey,
        r.AverageRating,
        r.NumberOfVotes
    from ratings as r
    inner join movies_and_tvseries as mt
    on r.TitleKey = mt.TitleKey

)

select * from filter_and_join_ratings_to_movies_and_tvseries