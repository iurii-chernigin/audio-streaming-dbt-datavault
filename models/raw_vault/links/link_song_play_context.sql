{% set source_model = 'v_stage_listen_events' %}
{% set src_pk = 'link_song_play_context_pk' %}
{% set src_fk = ['song_play_pk', 'session_pk', 'song_pk'] %}
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