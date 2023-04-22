{% set source_model = 'v_stage_auth_events' %}

{# Logic data #}
{% set src_pk = 'authorization_pk' %}
{% set src_fk = ['session_pk', 'user_agent_pk', 'user_pk', 'location_geo_pk'] %}
{% set src_payload = ['authorization_ts', 'is_auth_successful']%}

{# System meta #}
{% set src_eff = 'effective_from_ts' %}
{% set src_ldts = 'load_date' %}
{% set src_source = 'record_source' %}


{{ 
    dbtvault.t_link(
        src_pk=src_pk,
        src_fk=src_fk,
        src_payload=src_payload,
        src_eff=src_eff,
        src_ldts=src_ldts,
        src_source=src_source,
        source_model=source_model
    )
}}