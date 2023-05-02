
{{ 
    config(
        materialized = 'incremental',
        incremental_strategy= 'insert_overwrite',
        partition_by = {
            'field': 'play_date',
            'data_type': 'date',
            'granularity': 'day'
        }
    ) 
}}

with top_10_songs as (

    select

        play_start_date as play_date,
        song_name,
        song_artist,

        count(distinct user_id) as uniq_users

    from {{ ref('mart_song_play') }}
    
    where play_start_date = date('{{ var('load_date') }}')

    group by play_date, song_name, song_artist
    order by uniq_users desc

    limit 10

)

select *
from top_10_songs

