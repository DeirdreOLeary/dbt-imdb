with titles as (

    select * from {{ ref('stg_imdb__title_basics') }}

),

filter_movies as (

    select TitleKey,
        Title,
        ReleaseOrStartYear as ReleaseYear,
        RuntimeInMinutes,
        Genres
    from titles
    where TitleType = 'movie'
        and IsAdultTitle is FALSE
        and Title is not null

)

select * from filter_movies