with actors as (

    select * from {{ ref('int_actors_joined') }}

),

ratings as (

    select * from {{ ref('int_ratings_joined') }}

),

aggregate_and_join_ratings_to_actors as (

    select a.NameKey,
        a.TitleKey,
        a.Name,
        a.Characters,
        a.BirthYear,
        a.DeathYear,
        max(r.AverageRating) as HighestRating,
        count(r.NumberOfVotes) as TotalVotes
    from ratings as r
    inner join actors as a
    on r.TitleKey = a.TitleKey
    group by a.NameKey,
        a.TitleKey,
        a.Name,
        a.Characters,
        a.BirthYear,
        a.DeathYear

)

select * from aggregate_and_join_ratings_to_actors