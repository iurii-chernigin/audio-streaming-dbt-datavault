
{%- set yaml_metadata -%}

source_model: 'raw_listen_events'
derived_columns: 
    record_source_id: '!playback-component'

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}
{% set derived_columns = metadata_dict['derived_columns'] %}

with staging as (

    {{ 
        dbtvault.stage(
            include_source_columns=true,
            source_model=source_model,
            derived_columns=derived_columns,
            hashed_columns=none,
            ranked_columns=none
        )
    }}

)

select *
from staging