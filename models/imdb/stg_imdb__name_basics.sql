with source as (

    select * from {{ source('imdb', 'name_basics') }}

),

renamed as (

    select
        -- Remove any trailing spaces from the name key
        left(nconst, 10) as NameKey,
        primaryName as Name,
        -- Set nulls for the birth & death years, & remove any trailing spaces from non-null years
        case birthYear
            when '\\N' then null
            else left(birthYear, 4)
        end as BirthYear,
        case deathYear
            when '\\N' then null
            else left(deathYear, 4)
        end as DeathYear
    from source

)

select * from renamed