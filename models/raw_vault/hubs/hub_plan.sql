{% set source_model = 'v_stage_listen_events' %}
{% set src_pk = 'plan_pk' %}
{% set src_nk = 'plan_type' %}
{% set src_ldts = 'record_load_date' %}
{% set src_source = 'record_source_id' %}


{{
    dbtvault.hub(
        src_pk=src_pk,
        src_nk=src_nk,
        src_ldts=src_ldts,
        src_source=src_source,
        source_model=source_model
    )
}}