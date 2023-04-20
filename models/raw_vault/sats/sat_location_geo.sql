{%- set source_model = 'v_stage_listen_events' -%}
{%- set src_pk = 'location_geo_pk' -%}
{%- set src_hashdiff = 'location_geo_hashdiff' -%}

{%- set src_payload = ["location_latitude", "location_longitute"] -%}
{%- set src_eff = "record_effective_from_ts" -%}
{%- set src_ldts = "record_load_date" -%}
{%- set src_source = "record_source_id" -%}

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