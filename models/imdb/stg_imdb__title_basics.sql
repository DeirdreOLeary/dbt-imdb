with source as (

    select * from {{ source('imdb', 'title_basics') }}

),

renamed as (

    select 
        -- Remove any trailing spaces from the title key
        left(tconst, 10) as TitleKey,
        titleType as TitleType,
        primaryTitle as Title,
        -- Set isAdult flag to a boolean (TRUE/FALSE)
        cast(isAdult as boolean) as IsAdultTitle,
        -- Set nulls for the release/start & end years, & remove any trailing spaces from non-null years. Note that an escape character is required for \N
        case startYear
            when '\\N' then null
            else left(startYear, 4)
        end as ReleaseOrStartYear,
        case endYear
            when '\\N' then null
            else left(endYear, 4)
        end as EndYear,
        -- Set nulls for the runtime & convert non-null runtimes to int
        case runtimeMinutes
            when '\\N' then null
            else cast(runtimeMinutes as int)
        end as RuntimeInMinutes,
        -- Set nulls for genres
        case genres
            when '\\N' then null
            else genres
        end as Genres
    from source

)

select * from renamed