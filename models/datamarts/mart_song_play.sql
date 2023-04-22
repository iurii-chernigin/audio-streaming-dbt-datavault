
{{ config(materialized='view')}}


with hub_song_play as (
    
    select 
        -- Hub's hashed primary key
        song_play_pk
    
    from {{ ref('hub_song_play') }}
    where load_date = date('{{ var('load_date')}}')

),

sat_song_play as (

    select 

        -- Satellite hashed foreign key
        song_play_pk,

        -- Song play context
        song_played_sec,
        play_start_ts,
        play_end_ts

    from {{ ref('sat_song_play_details') }}

),


hub_song as (

    select 

        song_pk,
        song_name,
        song_artist

    from {{ ref('hub_song') }}

),


link_song_play_context as (

    select 
        song_play_pk,
        
        hub_song.song_name,
        hub_song.song_artist

    from {{ ref('link_song_play_context') }}

    inner join hub_song using (song_pk)

)


select 

    hub_song_play.song_play_pk,

    sat_song_play.song_played_sec,
    sat_song_play.play_start_ts,
    sat_song_play.play_end_ts,

    link_song_play_context.song_name,
    link_song_play_context.song_artist

from hub_song_play

inner join sat_song_play using(song_play_pk)
inner join link_song_play_context using (song_play_pk)


limit 10