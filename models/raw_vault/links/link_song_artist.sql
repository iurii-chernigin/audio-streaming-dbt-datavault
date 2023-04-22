{% set source_model = 'v_stage_listen_events' %}
{% set src_pk = 'link_song_artist_pk' %}
{% set src_fk = ['song_pk', 'song_artist_pk'] %}
{% set src_ldts = 'load_date' %}
{% set src_source = 'record_source' %}

{{
    dbtvault.link(
        src_pk=src_pk,
        src_fk=src_fk,
        src_ldts=src_ldts,
        src_source=src_source,
        source_model=source_model
    )
}}