{% set source_model = 'v_stage_listen_events' %}
{% set src_pk = 'link_location_geo_zip_pk' %}
{% set src_fk = ['location_geo_pk', 'location_zip_pk'] %}
{% set src_ldts = 'record_load_date' %}
{% set src_source = 'record_source_id' %}

{{
    dbtvault.link(
        src_pk=src_pk,
        src_fk=src_fk,
        src_ldts=src_ldts,
        src_source=src_source,
        source_model=source_model
    )
}}