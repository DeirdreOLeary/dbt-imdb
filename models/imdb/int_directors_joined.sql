with names as (

    select * from {{ ref('stg_imdb__name_basics') }}

),

principals as (

    select * from {{ ref('stg_imdb__title_principals') }}

),

filter_and_join_director_names_to_principals as (

    select distinct n.NameKey,
        p.TitleKey,
        n.Name,
        n.BirthYear,
        n.DeathYear
    from names as n
    inner join principals as p
    on n.NameKey = p.NameKey
    where p.JobCategory = 'director'

)

select * from filter_and_join_director_names_to_principals