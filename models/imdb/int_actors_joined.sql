with names as (

    select * from {{ ref('stg_imdb__name_basics') }}

),

principals as (

    select * from {{ ref('stg_imdb__title_principals') }}

),

filter_and_join_actor_names_to_principals as (

    select distinct n.NameKey,
        p.TitleKey,
        n.Name,
        p.Characters,
        n.BirthYear,
        n.DeathYear
    from names as n
    inner join principals as p
    on n.NameKey = p.NameKey
    where p.JobCategory in ('actor', 'actress')

)

select * from filter_and_join_actor_names_to_principals