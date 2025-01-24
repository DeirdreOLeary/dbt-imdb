with tv as (

    select * from {{ ref('int_tvseries_joined') }}

),

ratings as (

    select * from {{ ref('int_ratings_joined') }}

),

aggregate_and_join_ratings_to_tv as (

    select t.TitleKey,
        t.Title,
        t.StartYear,
        t.EndYear,
        t.NumberOfSeasons,
        t.NumberOfEpisodes,
        t.Genres,
        r.AverageRating,
        r.NumberOfVotes
    from ratings as r
    inner join tv as t
    on r.TitleKey = t.TitleKey

)

select * from aggregate_and_join_ratings_to_tv