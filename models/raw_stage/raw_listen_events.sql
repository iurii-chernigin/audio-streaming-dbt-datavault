{# Root model for the listen events  #}

select

    -- Event timestamp
    ts, 

    -- Listening context
    artist,
    song,
    duration,
    itemInSession,

    -- System application context
    sessionId,
    auth,

    -- Subscription info
    level,

    -- User meta
    userId,
    userAgent,
    registration,

    -- Geo
    city,
    zip,
    state,
    lon,
    lat,

    -- Personal
    lastName,
    firstName,
    gender

from {{ source('raw', 'listen_events')}}

{% if var('is_test_run', default=true) %}
    limit 5
{% endif %}