
{%- set yaml_metadata -%}

source_model: 'raw_listen_events'
derived_columns: 
    record-source_id: '!playback-component'
    record_load_date: "date('{{ var('load_date') }}')"
    record_effective_from_date: 'play_start_ts'

hashed_columns:
    playback_pk:
        - 'user_id'
        - 'session_id'
        - 'play_start_ts'
    session_pk: 
        - 'session_id'
        - 'user_id'
    user_pk: 'user_id'
    song_pk:
        - 'song_artist'
        - 'song_name'
    location_city_pk: 'location_city'
    location_state_pk: 'location_state'
    location_geo_pk:
        - 'location_latitude'
        - 'location_longitute'
        - 'location_zip'
    
    playback_hashdiff:
        is_hashdiff: true
        columns:
            - 'song_played_sec'
            - 'play_start_ts'
            - 'user_id'
            - 'session_id'
    user_hashdiff:
        is_hashdiff: true
        columns:
            - 'user_id'
            - 'user_first_name'
            - 'user_last_name'
            - 'user_gender'
            - 'user_registration_ts'
    location_geo_hashdiff:
        is_hashdiff: true
        columns:
            - 'location_latitude'
            - 'location_longitute'
            - 'location_zip'

        

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}
{% set derived_columns = metadata_dict['derived_columns'] %}
{% set hashed_columns = metadata_dict['hashed_columns'] %}

with staging as (

    {{ 
        dbtvault.stage(
            include_source_columns=true,
            source_model=source_model,
            derived_columns=derived_columns,
            hashed_columns=hashed_columns,
            ranked_columns=none
        )
    }}

)

select *
from staging