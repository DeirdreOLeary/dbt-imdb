with episodes as (

    select * from {{ ref('stg_imdb__title_episode') }}

),

titles as (

    select * from {{ ref('stg_imdb__title_basics') }}

),

group_seasons_and_episodes as (

    select ParentTitleKey,
        coalesce(max(SeasonNumber), 0) as NumberOfSeasons,
        count(EpisodeNumber) as NumberOfEpisodes
    from episodes
    group by ParentTitleKey

),

filter_and_join_titles_to_seasons_and_episodes as (

    select t.TitleKey,
        t.Title,
        t.ReleaseOrStartYear as StartYear,
        t.EndYear,
        se.NumberOfSeasons,
        se.NumberOfEpisodes,
        t.Genres
    from titles as t
    inner join group_seasons_and_episodes as se
    on t.TitleKey = se.ParentTitleKey
    where t.TitleType = 'tvSeries'
        and t.IsAdultTitle is FALSE
        and t.Title is not null

)

select * from filter_and_join_titles_to_seasons_and_episodes