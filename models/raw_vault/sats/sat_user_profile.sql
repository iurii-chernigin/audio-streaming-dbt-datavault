{% set source_model = 'v_stage_listen_events' %}
{% set src_pk = 'user_pk' %}
{% set src_hashdiff = 'user_hashdiff' %}

{% set src_payload = ['user_first_name', 'user_last_name', 'user_gender', 'user_registration_ts'] %}
{% set src_eff = "record_effective_from_ts" %}
{% set src_ldts = "record_load_date" %}
{% set src_source = "record_source_id" %}

{{ 

    dbtvault.sat(
        src_pk=src_pk, 
        src_hashdiff=src_hashdiff,
        src_payload=src_payload,
        src_eff=src_eff,
        src_ldts=src_ldts, src_source=src_source,
        source_model=source_model
    )

}}