{# Root model for the listen events  #}

select

    -- Event timestamp
    ts                  as play_start_ts, 

    -- Listening context
    artist              as song_artist,
    song                as song_name,
    duration            as song_played_sec,
    itemInSession + 1   as song_number_in_session,
    lower(level)        as song_access_level,

    -- System application context
    sessionId           as session_id,
    lower(auth)         as authorization_level,

    -- User meta
    userId              as user_id,
    userAgent           as user_agent,
    registration        as user_registration_ts,

    -- Geo
    lower(city)         as location_city,
    lower(state)        as location_state,
    zip                 as location_zip,
    lon                 as location_longitute,
    lat                 as location_latitude,

    -- Personal
    lastName            as user_last_name,
    firstName           as user_first_name,
    lower(gender)       as user_gender

from {{ source('raw', 'listen_events')}}

where date(ts) = date('{{ var('load_date') }}') 

{% if var('is_test_run', default=true) %}
    limit 25
{% endif %}