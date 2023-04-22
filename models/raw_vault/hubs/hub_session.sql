{%- set source_model = ['v_stage_listen_events', 'v_stage_auth_events'] -%}
{%- set src_pk = 'session_pk' -%}
{%- set src_nk = ['user_id', 'session_id'] -%}
{%- set src_ldts = 'load_date' -%}
{%- set src_source = 'record_source' -%}


{{

    dbtvault.hub(
        src_pk=src_pk,
        src_nk=src_nk,
        src_ldts=src_ldts,
        src_source=src_source,
        source_model=source_model
    )

}}