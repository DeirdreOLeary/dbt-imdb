with ratings as (

    select * from {{ ref('int_ratings_joined') }}

)

select * from ratings