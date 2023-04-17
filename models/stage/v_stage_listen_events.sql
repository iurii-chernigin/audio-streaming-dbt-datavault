
{%- set yaml_metadata -%}

source_model: 'raw_listen_events'
derived_columns: 
    record_source_id: '!playback-component'
    record_load_datetime: 'ts'
    user_id: 'userId'
    session_id: 'sessionId'
hashed_columns:
    session_pk: 'session_id'
    user_pk: 'user_id'
    song_pk:
        - 'artist'
        - 'song'
        - 'duration'
    location_pk:
        - 'lat'
        - 'lon'
        - 'zip'
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