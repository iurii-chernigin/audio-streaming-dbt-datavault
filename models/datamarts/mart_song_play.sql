
{{ config(materialized='view')}}


with song_play as (
    
    select 
        -- Hub's hashed primary key
        hub_song_play.song_play_pk,
        link_song_play_context.session_pk,
        
        -- Satellite meta
        sat_song_play.song_played_sec,
        sat_song_play.play_start_ts,
        sat_song_play.play_end_ts,

        hub_song.song_name,
        hub_song.song_artist
    
    from {{ ref('hub_song_play') }} as hub_song_play

    left join {{ ref('sat_song_play_details') }} as sat_song_play using(song_play_pk)
    left join {{ ref('link_song_play_context') }} as link_song_play_context using(song_play_pk)
    left join {{ ref('hub_song') }} as hub_song using (song_pk)

    where hub_song_play.load_date = date('{{ var('load_date')}}')

),


location_catalog as (

    select 
        
        hub_location_geo.location_geo_pk,

        hub_location_geo.location_latitude,
        hub_location_geo.location_longitude,

        hub_location_zip.location_zip,
        hub_location_city.location_city,
        hub_location_state.location_state

    from {{ ref('hub_location_geo') }} as hub_location_geo

    left join {{ ref('link_location_geo_zip') }} using(location_geo_pk)
    left join {{ ref('hub_location_zip') }} using(location_zip_pk)
    left join {{ ref('link_location_zip_city') }} using(location_zip_pk)
    left join {{ ref('hub_location_city') }} using(location_city_pk)
    left join {{ ref('link_location_city_state') }} using(location_city_pk)
    left join {{ ref('hub_location_state') }} using(location_state_pk)

),


session as (

    select

        t_link_authorization.session_pk,
        
        hub_user_agent.user_agent,

        location_catalog.location_latitude,
        location_catalog.location_longitude,

        location_catalog.location_city,
        location_catalog.location_state


    from {{ ref('t_link_authorization') }} as t_link_authorization

    left join location_catalog using(location_geo_pk)
    left join {{ ref('hub_user_agent') }} as hub_user_agent using(user_agent_pk)

    where t_link_authorization.load_date = date('{{ var('load_date') }}')

)



select 

    -- Play meta
    song_play.song_played_sec,
    song_play.play_start_ts,
    song_play.play_end_ts,

    -- Song meta
    song_play.song_name,
    song_play.song_artist,

    -- User agent
    session.user_agent,

    -- Location
    session.location_city,
    session.location_state,
    session.location_latitude,
    session.location_longitude

from song_play

left join session using(session_pk)


limit 10