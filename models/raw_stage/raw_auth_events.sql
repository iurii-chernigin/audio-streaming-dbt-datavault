{# Root model for the authorization events  #}

select

    -- Event timestamp
    ts as event_ts, 

    success as is_auth_successful,
    -- System application context
    sessionId           as session_id,

    -- User meta
    userId              as user_id,
    userAgent           as user_agent,
    registration        as user_registration_ts,
    lower(level)        as plan_type,

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

from {{ source('raw', 'auth_events')}}

where date(ts) = date('{{ var('load_date') }}') 

{% if var('is_test_run', default=true) %}
    limit 25
{% endif %}