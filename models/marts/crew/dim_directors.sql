with directors as (

    select * from {{ ref('int_directors_joined') }}

),

ratings as (

    select * from {{ ref('int_ratings_joined') }}

),

aggregate_and_join_ratings_to_directors as (

    select d.NameKey,
        d.TitleKey,
        d.Name,
        d.BirthYear,
        d.DeathYear,
        max(r.AverageRating) as HighestRating,
        count(r.NumberOfVotes) as TotalVotes
    from ratings as r
    inner join directors as d
    on r.TitleKey = d.TitleKey
    group by d.NameKey,
        d.TitleKey,
        d.Name,
        d.BirthYear,
        d.DeathYear

)

select * from aggregate_and_join_ratings_to_directors