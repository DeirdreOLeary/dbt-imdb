with source as (

    select * from {{ source('imdb', 'title_episode') }}

),

renamed as (

    select 
        -- Remove any trailing zeros from the tv series' title & parent title keys
        left(tconst, 10) as TitleKey,
        left(parentTconst, 10) as ParentTitleKey,
        -- Set nulls for the season & episode numbers, & convert non-null numbers to int. Note that an escape character is required for \N
        case seasonNumber
            when '\\N' then null
            else cast(seasonNumber as smallint)
        end as SeasonNumber,
        case episodeNumber
            when '\\N' then null
            else cast(episodeNumber as smallint)
        end as EpisodeNumber
    from source

)

select * from renamed