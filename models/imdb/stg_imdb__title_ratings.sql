with source as (

    select * from {{ source('imdb', 'title_ratings') }}

),

renamed as (

    select 
        -- Remove any trailing zeros from the title key
        left(tconst, 10) as TitleKey,
        -- Convert integers stored as strings to int
        cast(averageRating as int) as AverageRating,
        cast(numVotes as int) as NumberOfVotes
    from source

)

select * from renamed