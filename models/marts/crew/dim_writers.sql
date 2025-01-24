with writers as (

    select * from {{ ref('int_writers_joined') }}

),

ratings as (

    select * from {{ ref('int_ratings_joined') }}

),

aggregate_and_join_ratings_to_writers as (

    select w.NameKey,
        w.TitleKey,
        w.Name,
        w.BirthYear,
        w.DeathYear,
        max(r.AverageRating) as HighestRating,
        count(r.NumberOfVotes) as TotalVotes
    from ratings as r
    inner join writers as w
    on r.TitleKey = w.TitleKey
    group by w.NameKey,
        w.TitleKey,
        w.Name,
        w.BirthYear,
        w.DeathYear

)

select * from aggregate_and_join_ratings_to_writers