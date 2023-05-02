{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'insert_overwrite',
        partition_by = {
            'field': 'play_date',
            'data_type': 'date',
            'granularity': 'day'
        }
    )
}}


select 

    play_start_date as play_date,
    extract(hour from play_start_ts) as play_hour,

    count(distinct user_id)                             as uniq_users,
    count(distinct concat(song_name, song_artist))      as uniq_songs,
    count(distinct user_agent)                          as uniq_user_agents

from {{ ref('mart_song_play') }}
where play_start_date = date('{{ var('load_date') }}')

group by play_date, play_hour