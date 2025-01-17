with source as (

    select * from {{ source('imdb', 'title_principals') }}

),

renamed as (

    select 
        -- Remove any trailing spaces from the title & name keys
        left(tconst, 10) as TitleKey,
        left(nconst, 10) as NameKey,
        -- Set nulls for genres. Note that an escape character is required for \N
        case characters
            when '\\N' then null
            else characters
        end as Characters,
        category as JobCategory
    from source

)

select * from renamed