{# Root model for the authorization events  #}

with auth_events as (
    
    select

        sessionId           as session_id,
        userId              as user_id,

        -- Event timestamp
        ts as event_ts, 

        success as is_auth_successful,

        -- User meta
        trim(userAgent, '\"')   as user_agent,
        registration            as user_registration_ts,
        lower(level)            as plan_type,

        -- Geo
        lower(city)         as location_city,
        lower(state)        as location_state,
        zip                 as location_zip,
        lon                 as location_longitude,
        lat                 as location_latitude,

        -- Personal
        lastName            as user_last_name,
        firstName           as user_first_name,
        lower(gender)       as user_gender

    from {{ source('raw', 'auth_events') }}

    where date(ts) = date('{{ var('load_date') }}') 

    {% if var('is_test_run', default=true) %}
        limit 25
    {% endif %}

),

auth_from_listen_events as (

    select

        -- Group By
        sessionId as session_id,
        userId as user_id,
        

        -- Event timestamp
        min(ts) as event_ts, 
        if(lower(min(auth)) = 'logged in', true, null) as is_auth_successful,
        
        -- System application context

        trim(min(userAgent), '\"')           as user_agent,
        min(registration)        as user_registration_ts,
        lower(min(level))        as plan_type,

        -- Geo
        lower(min(city))         as location_city,
        lower(min(state))        as location_state,
        min(zip)                 as location_zip,
        min(lon)                 as location_longitude,
        min(lat)                 as location_latitude,

        -- Personal
        min(lastName)            as user_last_name,
        min(firstName)           as user_first_name,
        lower(min(gender))       as user_gender

    from {{ source('raw', 'listen_events') }}

    where date(ts) = date('{{ var('load_date') }}') 

    group by sessionId, userId

    {% if var('is_test_run', default=true) %}
        limit 25
    {% endif %}

),

union_events as (

    select 'auth' as raw_source, *
    from auth_events

    union distinct

    select 'listen' as raw_source, *
    from auth_from_listen_events

)

select *
from union_events