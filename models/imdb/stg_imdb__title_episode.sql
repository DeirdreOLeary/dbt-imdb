with source as (

    select * from {{ source('imdb', 'title_episode') }}

),

renamed as (

    select 
        -- Remove any trailing zeros from the tv series' title key
        left(parentTconst, 10) as TitleKey,
        -- Set nulls for the season & episode numbers, & convert non-null numbers to int
        case seasonNumber
            when '\N' then null
            else cast(seasonNumber as int)
        end as SeasonNumber,
        case episodeNumber
            when '\N' then null
            else cast(episodeNumber as int)
        end as EpisodeNumber
    from source

)

select * from renamed