
{%- set yaml_metadata -%}

source_model: 'raw_auth_events'
derived_columns: 
    record_source_id: '!auth_events'
    record_load_date: "date('{{ var('load_date') }}')"
    record_effective_from_ts: 'event_ts'
hashed_columns:
    authorization_pk: 
        - 'user_id'
        - 'session_id'
        - 'event_ts'
    session_pk: 
        - 'user_id'
        - 'session_id'
    user_pk: 'user_id'
    plan_pk: 'plan_type'
    location_geo_pk:
        - 'location_latitude'
        - 'location_longitute'
    location_city_pk: 'location_city'
    location_state_pk: 'location_state'
    location_zip_pk: 'location_zip'
    user_agent_pk:
        - 'user_agent'
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
    software_client_hashdiff:
        is_hashdiff: true
        columns:
            - 'user_id'
            - 'user_agent'
    link_user_agent_user_pk:
        - 'user_id'
        - 'user_agent'
    link_location_geo_zip_pk:
        - 'location_zip'
        - 'location_latitude'
        - 'location_longitute'
    link_location_zip_city_pk:
        - 'location_zip'
        - 'location_city'
    link_location_city_state_pk:
        - 'location_city'
        - 'location_state'

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